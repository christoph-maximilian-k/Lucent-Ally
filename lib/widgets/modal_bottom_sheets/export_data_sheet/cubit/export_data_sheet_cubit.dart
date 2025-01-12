import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// User with Settings and labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/entries/entry.dart';
import '/data/models/entries/entries.dart';
import '/data/models/fields/field.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/members/member.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/field_types/payment_data/share_reference.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/members/members.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/files/file_item.dart';

part 'export_data_sheet_state.dart';

class ExportDataSheetCubit extends Cubit<ExportDataSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;

  ExportDataSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        super(ExportDataSheetState.initial());

  // ############################################
  // # Initialization.
  // ############################################

  /// Initialize local state data.
  Future<void> initializeLocal() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access all local top level groups.
      final Groups localTopLevelGroups = await _localStorageCubit.getAllLocalTopLevelGroups();

      // Convert to picker items.
      final PickerItems localGroupsPickerItems = localTopLevelGroups.toPickerItems();

      // Delete empty directories.
      // * This is only done for data integrity.
      await _localStorageCubit.deleteAllEmptyLocalDirectories();

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        topLevelGroups: localTopLevelGroups,
        topLevelGroupsAsPickerItems: localGroupsPickerItems,
        status: ExportDataSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> initializeLocal() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: failure,
        status: ExportDataSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> initializeLocal() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: Failure.genericError(),
        status: ExportDataSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared state data.
  Future<void> initializeShared() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access number of available exports.
      final int numberOfAvailableExports = await _localStorageCubit.getAvailableExports();

      // Access all shared top level groups.
      final Groups sharedTopLevelGroups = await _localStorageCubit.getSelfAllSharedTopLevelGroups();

      // Convert to picker items.
      final PickerItems groupsAsPickerItems = sharedTopLevelGroups.toPickerItems();

      // Delete empty directories.
      // * This is only done for data integrity.
      await _localStorageCubit.deleteAllEmptyLocalDirectories();

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        sharedExportsLeft: numberOfAvailableExports,
        topLevelGroups: sharedTopLevelGroups,
        topLevelGroupsAsPickerItems: groupsAsPickerItems,
        status: ExportDataSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> initializeShared() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: failure,
        status: ExportDataSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> initializeShared() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: Failure.genericError(),
        status: ExportDataSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State.
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open and not loading.
    if (isClosed || state.status == ExportDataSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ExportDataSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == ExportDataSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ExportDataSheetStatus.close,
    ));
  }

  /// This method can be used to choose a top level group.
  Future<void> chooseTopLevelGroup({required BuildContext context}) async {
    try {
      // Let user pick group to import to.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          title: labels.basicLabelsLocalGroups(),
          pickerItems: state.topLevelGroupsAsPickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = state.topLevelGroupsAsPickerItems.items[pickedIndex];

      // Access picked group.
      final Group? pickedGroup = await state.topLevelGroups.getById(
        groupId: pickedItem.id,
      );

      // * Group not found.
      if (pickedGroup == null) throw Failure.genericError();

      // Do nothing if user picked the same group again.
      if (state.topLevelGroup.groupId == pickedGroup.groupId) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: ExportDataSheetStatus.loading,
      ));

      // * This line is needed to let state update first.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Access subgroups.
      final Groups subgroups = state.isShared == false
          ? await _localStorageCubit.getAllLocalSubgroups(
              groupId: pickedGroup.groupId,
            )
          : await _localStorageCubit.getSharedSubgroupsOfGroup(
              rootGroupReference: pickedGroup.rootGroupReference,
              groupId: pickedGroup.groupId,
            );

      // Create Pickeritems.
      final PickerItems subgroupPickerItems = subgroups.toPickerItems();

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        topLevelGroup: pickedGroup,
        subgroup: Group.initial(), // Reset any previously selected subgroups.
        selectedGroup: pickedGroup, // Set as currently picked group.
        subgroups: subgroups,
        subgroupsAsPickerItems: subgroupPickerItems,
        status: ExportDataSheetStatus.waiting,
        // * Trigger load file event.
        loadFileFailure: Failure.initial(),
        loadFilesStatus: LoadFilesStatus.loading,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> chooseTopLevelGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ExportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> chooseTopLevelGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExportDataSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to choose a subgroup.
  Future<void> chooseSubgroup({required BuildContext context}) async {
    try {
      // Let user pick group to import to.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          title: labels.basicLabelsLocalGroups(),
          pickerItems: state.subgroupsAsPickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = state.subgroupsAsPickerItems.items[pickedIndex];

      // Access picked group.
      final Group? pickedGroup = await state.subgroups.getById(
        groupId: pickedItem.id,
      );

      // * Group not found.
      if (pickedGroup == null) throw Failure.genericError();

      // Do nothing if user picked the same group again.
      if (state.subgroup.groupId == pickedGroup.groupId) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        subgroup: pickedGroup,
        selectedGroup: pickedGroup,
        // * Trigger load file event.
        loadFileFailure: Failure.initial(),
        loadFilesStatus: LoadFilesStatus.loading,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> chooseSubgroupGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ExportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> chooseSubgroupGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExportDataSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to remove a selected subgroup.
  void removeSubgroup() {
    // Only emit state if cubit is open and a subgroup is selected.
    if (isClosed || state.subgroup.groupName.isEmpty) return;

    // Update state.
    emit(state.copyWith(
      subgroup: Group.initial(),
      selectedGroup: state.topLevelGroup, // * If subgroup is removed, selected group has to be updated.
      // * Trigger load file event.
      loadFileFailure: Failure.initial(),
      loadFilesStatus: LoadFilesStatus.loading,
    ));
  }

  // ############################################
  // # Files
  // ############################################

  // This method can be used to retry loading files.
  void retryLoadFiles() {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      loadFileFailure: Failure.initial(),
      loadFilesStatus: LoadFilesStatus.loading,
    ));
  }

  /// This method can be used to load local files into state.
  Future<void> loadFiles() async {
    try {
      // Make sure spinner is always shown for a bit for smoother UX.
      await Future.delayed(const Duration(milliseconds: 350));

      // Create folder path.
      final String folderPath = await _localStorageCubit.createLocalFilePath(
        groupId: state.selectedGroup.groupId,
        relativePath: 'exports/',
      );

      // Load files.
      final List<String> filePaths = await _localStorageCubit.loadLocalFilesOfFolder(folderPath: folderPath, onlyPaths: true);

      // If this is a subgroup add paths to state list, otherwise replace it.
      final List<String> paths = state.selectedGroup.getIsLocalSubgroupType ? [...state.filePaths, ...filePaths] : filePaths;

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        filePaths: paths,
        loadFilesStatus: LoadFilesStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> loadFiles() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        loadFileFailure: failure,
        loadFilesStatus: LoadFilesStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> loadFiles() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        loadFileFailure: Failure.failedToLoadFiles(),
        loadFilesStatus: LoadFilesStatus.failure,
      ));
    }
  }

  /// This method can be used to share files.
  Future<void> shareFile({required String filePath}) async {
    try {
      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: ExportDataSheetStatus.loading,
      ));

      // Init the file.
      final XFile xfile = XFile(filePath);

      // Let user share the file.
      // * This also enables saveing it to local file system.
      final ShareResult shareResult = await Share.shareXFiles(
        [xfile],
      );

      // Show a success mesage.
      if (shareResult.status == ShareResultStatus.success) {
        _appMessagesCubit.showNotification(message: labels.basicLabelsSuccess());
      }

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        sharedFilePath: '',
        status: ExportDataSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> shareFile() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        sharedFilePath: '',
        failure: failure,
        status: ExportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> shareFile() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        sharedFilePath: '',
        failure: Failure.genericError(),
        status: ExportDataSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to delete files.
  /// * If a delete failes, it does not matter.
  Future<void> deleteFile({required String filePath, required BuildContext context}) async {
    try {
      // Show confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.basicLabelsConfirmDeleteFile(),
            ),
          ) ??
          false;

      // User cancled.
      if (confirm == false) return;

      // Create updated filePaths.
      final List<String> updated = state.filePaths.where((path) => path != filePath).toList();

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        filePaths: updated,
        status: ExportDataSheetStatus.waiting,
      ));

      // Delete the file.
      // * Is not awaited because if this fails user can simply retry next time files get loaded.
      _localStorageCubit.deleteLocalFile(filePath: filePath);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> deleteFile() --> failure: ${failure.toString()}');

      // * There is no state update here because if this fails user can just try again.
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> deleteFile() --> exception: ${exception.toString()}');

      // * There is no state update here because if this fails user can just try again.
    }
  }

  // ############################################
  // # Export
  // ############################################

  /// This method will be triggered if user wants to export data of a local group.
  Future<void> conductLocalExport() async {
    try {
      // Make sure user selected a group.
      if (state.selectedGroup.groupName.isEmpty) throw Failure.noGroupSelected();

      // Make sure that group has data available.
      final bool groupIsEmpty = await _localStorageCubit.getLocalGroupIsEmpty(groupId: state.selectedGroup.groupId);

      // Empty groups cannot be exported.
      if (groupIsEmpty) throw Failure.groupIsEmpty();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: ExportDataSheetStatus.pageIsLoading,
      ));

      // Make sure spinner is shown for a bit for smoother UX.
      await Future.delayed(const Duration(milliseconds: 350));

      // Access secrets.
      final Secrets? secrets = state.selectedGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Init offset.
      int offset = 0;
      int limit = 100;

      // Helper variables.
      List<String> entriesIdsBacklog = []; // Helps to keep track of which entries have already been converted to avoid duplicates.

      // Init row template.
      Map<String, dynamic> template = {
        'Entry name': '',
        'Entry created at in UTC': '',
        'Entry created at timezone': '',
        'Entry edited at in UTC': '',
        'Entry edited at timezone': '',
      };

      // Holds the converted entry data.
      List<Map<String, dynamic>> entryData = [];

      // This will hold the finished rows ready for conversion to csv.
      List<List<String>> rows = [];

      while (true) {
        // Cycle through all data of group.
        final Entries entries = await _localStorageCubit.getLocalEntriesInLocalGroup(
          groupId: state.selectedGroup.groupId,
          offset: offset,
          limit: limit,
          secrets: secrets,
        );

        // Heighten offset.
        offset = offset + limit;

        // Stop while loop if there are no entries left.
        if (entries.items.isEmpty) break;

        // Go through data.
        for (final Entry entry in entries.items) {
          // Check if entry was already converted.
          if (entriesIdsBacklog.contains(entry.entryId)) continue;

          // Add entry id to backlog.
          entriesIdsBacklog.add(entry.entryId);

          // Access ModelEntry.
          final ModelEntry? modelEntry = await _localStorageCubit.getLocalModelEntryById(
            modelEntryId: entry.modelEntryReference,
            shouldAccessPrefs: false,
          );

          // Init data.
          Map<String, dynamic> rowData = {
            'Entry name': entry.entryName,
            'Entry created at in UTC': entry.createdAtInUtc.toIso8601String(),
            'Entry created at timezone': entry.createdAtTimeZone,
            'Entry edited at in UTC': entry.editedAtInUtc.toIso8601String(),
            'Entry edited at timezone': entry.editedAtTimeZone,
          };

          // Create csv header row.
          for (final Field field in entry.fields.items) {
            // Access FieldIdentification.
            final FieldIdentification? fieldIdentification = modelEntry!.fieldIdentifications.getById(
              fieldId: field.fieldId,
            );

            // Helpers.
            final String fieldLabel = fieldIdentification!.label;
            final String fieldId = fieldIdentification.fieldId;

            // * Depending on field type add headers and row data.

            // Handle TextFields.
            if (field.getIsTextField) {
              // Create header item.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.textData!.value;
            }

            // Handle PasswordFields.
            if (field.getIsPasswordField) {
              // Create header item.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.passwordData!.value;
            }

            // Handle PasswordFields.
            if (field.getIsPhoneField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.phoneData!.getValue;
            }

            // Handle DateFields.
            if (field.getIsDateField) {
              // Create header items.
              final String headerItem = '$fieldLabel in UTC (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';
              template[headerItemTimezone] = '';

              // Set data to row data.
              rowData[headerItem] = field.dateData!.valueInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.dateData!.timezone;
            }

            // Handle DateAndTimeFields.
            if (field.getIsDateAndTimeField) {
              // Create header items.
              final String headerItem = '$fieldLabel in UTC (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';
              template[headerItemTimezone] = '';

              // Set data to row data.
              rowData[headerItem] = field.dateAndTimeData!.valueInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.dateAndTimeData!.timezone;
            }

            // Handle TimeFields.
            if (field.getIsTimeField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.timeData!.getFormattedTime;
            }

            // Handle NumberField.
            if (field.getIsNumberField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.numberData!.getFormattedNumber;
            }

            // Handle EmailField.
            if (field.getIsEmailField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.emailData!.value;
            }

            // Handle WebsiteField.
            if (field.getIsWebsiteField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.websiteData!.value;
            }

            // Handle UsernameField.
            if (field.getIsUsernameField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.usernameData!.value;
            }

            // Handle LocationField.
            if (field.getIsLocationField) {
              // Create header items.
              final String headerItemLat = '$fieldLabel latitude (field_id: $fieldId)';
              final String headerItemLng = '$fieldLabel longitude (field_id: $fieldId)';
              final String headerItemTags = '$fieldLabel tags (field_id: $fieldId)';
              final String headerItemDate = '$fieldLabel created at in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel created at timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemLat] = '';
              template[headerItemLng] = '';
              template[headerItemDate] = '';
              template[headerItemTimezone] = '';
              template[headerItemTags] = '';

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.locationData!.tagsData,
                isShared: false,
              );

              // Set data to row data.
              rowData[headerItemLat] = field.locationData!.latitude;
              rowData[headerItemLng] = field.locationData!.longitude;
              rowData[headerItemDate] = field.locationData!.createdAtInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.locationData!.createdAtTimezone;
              rowData[headerItemTags] = csvSaveTagLabels;
            }

            // Handle MoneyField.
            if (field.getIsMoneyField) {
              // Create header items.
              final String headerItemValue = '$fieldLabel value (field_id: $fieldId)';
              final String headerItemCurrency = '$fieldLabel currency (field_id: $fieldId)';
              final String headerItemDefaultCurrency = '$fieldLabel default currency (field_id: $fieldId)';
              final String headerItemExchangeRate = '$fieldLabel exchange rate (field_id: $fieldId)';
              final String headerItemDate = '$fieldLabel created at in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel created at timezone (field_id: $fieldId)';
              final String headerItemTags = '$fieldLabel tags (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemValue] = '';
              template[headerItemCurrency] = '';
              template[headerItemDefaultCurrency] = '';
              template[headerItemExchangeRate] = '';
              template[headerItemDate] = '';
              template[headerItemTimezone] = '';
              template[headerItemTags] = '';

              // Access exchange rate if needed.
              final Map<String, dynamic> exchangeRateMap = await _localStorageCubit.getExchangeRate(
                customExchangeRates: field.moneyData!.customExchangeRates,
                exchangeRateDateInUtc: field.moneyData!.createdAtInUtc!,
                fromCurrencyCode: field.moneyData!.currencyCode,
                toCurrencyCode: state.selectedGroup.defaultCurrencyCode,
              );

              // Convenience variables.
              final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.moneyData!.tagsData,
                isShared: false,
              );

              // Set data to row data.
              rowData[headerItemValue] = field.moneyData!.value;
              rowData[headerItemCurrency] = field.moneyData!.currencyCode;
              rowData[headerItemDefaultCurrency] = state.selectedGroup.defaultCurrencyCode;
              rowData[headerItemExchangeRate] = exchangeRateToDefault == null ? "" : exchangeRateToDefault.toString();
              rowData[headerItemDate] = field.moneyData!.createdAtInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.moneyData!.timezone;
              rowData[headerItemTags] = csvSaveTagLabels;
            }

            // Handle PaymentField.
            if (field.getIsPaymentField) {
              // Create header items.
              final String headerItemTotal = '$fieldLabel total (field_id: $fieldId)';
              final String headerItemTotalCurrency = '$fieldLabel total currency (field_id: $fieldId)';

              final String headerItemPaidBy = '$fieldLabel paid by (field_id: $fieldId)';
              final String headerItemPaymentDate = '$fieldLabel date in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel timezone (field_id: $fieldId)';

              final String headerItemIsCompensated = '$fieldLabel is compensated (field_id: $fieldId)';

              final String headerItemDefaultCurrency = '$fieldLabel default currency (field_id: $fieldId)';
              final String headerItemExchangeRate = '$fieldLabel exchange rate (field_id: $fieldId)';
              final String headerItemTags = '$fieldLabel tags (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemTotal] = '';
              template[headerItemTotalCurrency] = '';
              template[headerItemPaidBy] = '';
              template[headerItemPaymentDate] = '';
              template[headerItemTimezone] = '';
              template[headerItemIsCompensated] = '';
              template[headerItemDefaultCurrency] = '';
              template[headerItemExchangeRate] = '';
              template[headerItemTags] = '';

              // Access Paid by member.
              final Member paidByMember = await _localStorageCubit.getLocalMemberById(memberId: field.paymentData!.paidById) ??
                  Member.unknownMember(
                    memberId: field.paymentData!.paidById,
                  );

              // Access exchange rate if needed.
              final Map<String, dynamic> exchangeRateMap = await _localStorageCubit.getExchangeRate(
                customExchangeRates: field.paymentData!.customExchangeRates,
                exchangeRateDateInUtc: field.paymentData!.paymentDateInUtc!,
                fromCurrencyCode: field.paymentData!.currencyCode,
                toCurrencyCode: state.selectedGroup.defaultCurrencyCode,
              );

              // Convenience variables.
              final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.paymentData!.tagsData,
                isShared: false,
              );

              // Go through share references and access relevant members.
              for (final ShareReference reference in field.paymentData!.shareReferences.items) {
                // Access the member associated with this ref.
                final Member member = await _localStorageCubit.getLocalMemberById(memberId: reference.id) ??
                    Member.unknownMember(
                      memberId: reference.id,
                    );

                // Create header items.
                // ! Do not add stuff that potentially randomizes this (like the toCurrency) because that will potentially result
                // ! in having multiple columns for a single payment member field.
                final String headerItemValue = '$fieldLabel ${member.memberName} value (member_id: ${member.memberId}) (field_id: $fieldId)';

                // Update template to have keys available in one map.
                template[headerItemValue] = '';

                // Calculate converted value.
                final double convertedValue = reference.valueAsDouble;

                // Set data to row data.
                rowData[headerItemValue] = convertedValue.truncateToDouble().toString();
              }

              // Set data to row data.
              rowData[headerItemTotal] = field.paymentData!.total.toString();
              rowData[headerItemTotalCurrency] = field.paymentData!.currencyCode;
              rowData[headerItemPaidBy] = '${paidByMember.memberName} (${paidByMember.memberId})';
              rowData[headerItemPaymentDate] = field.paymentData!.paymentDateInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.paymentData!.paymentDateTimezone;
              rowData[headerItemIsCompensated] = field.paymentData!.isCompensated.toString();
              rowData[headerItemDefaultCurrency] = state.selectedGroup.defaultCurrencyCode;
              rowData[headerItemExchangeRate] = exchangeRateToDefault == null ? "" : exchangeRateToDefault.toString();
              rowData[headerItemTags] = csvSaveTagLabels;
            }

            // Handle DateOfBirthField.
            if (field.getIsDateOfBirthField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.dateOfBirthData!.getFormattedDate;
            }

            // Handle TagsField.
            if (field.getIsTagsField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.tagsData,
                isShared: false,
              );

              // Set data to row data.
              rowData[headerItem] = csvSaveTagLabels;
            }

            // Handle MeasurementField.
            if (field.getIsMeasurementField) {
              // Create header items.
              final String headerItemCategory = '$fieldLabel category (field_id: $fieldId)';
              final String headerItemValue = '$fieldLabel value (field_id: $fieldId)';
              final String headerItemUnit = '$fieldLabel unit (field_id: $fieldId)';
              final String headerItemDate = '$fieldLabel created at in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel created at timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemCategory] = '';
              template[headerItemValue] = '';
              template[headerItemUnit] = '';
              template[headerItemDate] = '';
              template[headerItemTimezone] = '';

              // Set data to row data.
              rowData[headerItemCategory] = field.measurementData!.category;
              rowData[headerItemValue] = field.measurementData!.value;
              rowData[headerItemUnit] = field.measurementData!.unit;
              rowData[headerItemDate] = field.measurementData!.createdAtInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.measurementData!.createdAtTimezone;
            }

            // Handle BooleanField.
            if (field.getIsBooleanField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.booleanData!.value.toString();
            }

            // Handle EmotionData.
            if (field.getIsEmotionField) {
              // Access csv save data.
              final String csvSaveEmotions = EmotionData.emotionsToString(emotionData: field.emotionData);
              final String csvSaveIntensities = EmotionData.intensitiesToString(emotionData: field.emotionData);
              final String csvSaveOccurrences = EmotionData.occurrencesToString(emotionData: field.emotionData);
              final String csvSaveTimezones = EmotionData.timezonesToString(emotionData: field.emotionData);

              // Create header items.
              final String headerItemEmotions = '$fieldLabel emotion types (field_id: $fieldId)';
              final String headerItemIntensities = '$fieldLabel emotion intensities (field_id: $fieldId)';
              final String headerItemOccurrences = '$fieldLabel emotion occurrences (field_id: $fieldId)';
              final String headerItemTimezones = '$fieldLabel emotion occurrences timezones (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemEmotions] = '';
              template[headerItemIntensities] = '';
              template[headerItemOccurrences] = '';
              template[headerItemTimezones] = '';

              // Set data to row data.
              rowData[headerItemEmotions] = csvSaveEmotions;
              rowData[headerItemIntensities] = csvSaveIntensities;
              rowData[headerItemOccurrences] = csvSaveOccurrences;
              rowData[headerItemTimezones] = csvSaveTimezones;
            }
          }

          // Once all fields have been checked, add to data.
          entryData.add(rowData);
        }
      }

      // Create header row.
      final List<String> header = template.keys.toList();

      // Go through data and create rows.
      for (final Map<String, dynamic> element in entryData) {
        // Init row.
        List<String> row = [];

        // Iterating through template keys.
        for (String key in template.keys) {
          // Check if key exists.
          final bool containsKey = element.containsKey(key);

          // Init value.
          final String value = containsKey ? element[key] : '';

          // Add value to row.
          row.add(value);
        }

        // Add row to rows.
        rows.add(row);
      }

      // Update rows with header.
      rows = [header, ...rows];

      // Sanitize group name
      final String sanitizedGroupName = state.selectedGroup.groupName.replaceAll(' ', '_').replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');

      // Create a export id.
      final String exportId = const Uuid().v4();

      // Access current date.
      final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Convert to csv.
      final String csv = const ListToCsvConverter().convert(rows);

      // Get the full path.
      final String filePath = await _localStorageCubit.createLocalFilePath(
        groupId: state.selectedGroup.groupId,
        relativePath: 'exports/$exportId/${sanitizedGroupName}_$formattedDate.csv',
      );

      // Access the correct MimeType.
      final String mimeType = FileItem.getMimeType(extension: 'csv')!;

      // Save the file into local storage. This is done so user can access previous exports.
      await _localStorageCubit.putLocalFile(
        filePath: filePath,
        bytes: utf8.encode(csv),
        mimeType: mimeType,
        encrypt: false,
        secrets: null,
      );

      // Create updated file paths.
      final List<String> updatedPaths = [...state.filePaths, filePath];

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        filePaths: updatedPaths,
        // * Promt user with share sheet.
        sharedFilePath: filePath,
        status: ExportDataSheetStatus.shareFile,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> conductExport() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ExportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> conductExport() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExportDataSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to export data of a local group.
  Future<void> conductSharedExport() async {
    try {
      // If user is in shared mode and does not have any exports left, show error.
      if (state.sharedExportsLeft == 0) throw Failure.noSharedExportsLeft();

      // Make sure user selected a group.
      if (state.selectedGroup.groupName.isEmpty) throw Failure.noGroupSelected();

      // Ensure that current user is top level group owner.
      if (state.selectedGroup.groupCreator != user.userId) throw Failure.onlyGroupCreatorCanExport();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: ExportDataSheetStatus.pageIsLoading,
      ));

      // Make sure spinner is shown for a bit for smoother UX.
      await Future.delayed(const Duration(milliseconds: 350));

      // Init offset.
      int offset = 0;
      int limit = 100;

      // Helper variables.
      List<String> entriesIdsBacklog = []; // Helps to keep track of which entries have already been converted to avoid duplicates.

      // Init row template.
      Map<String, dynamic> template = {
        'Entry name': '',
        'Entry created at in UTC': '',
        'Entry created at timezone': '',
        'Entry edited at in UTC': '',
        'Entry edited at timezone': '',
      };

      // Holds the converted entry data.
      List<Map<String, dynamic>> entryData = [];

      // This will hold the finished rows ready for conversion to csv.
      List<List<String>> rows = [];

      // Members.
      Members relevantMembers = await _localStorageCubit.getSharedMembersOfParticipant(
        participantId: state.selectedGroup.participantReference,
        rootGroupReference: state.selectedGroup.rootGroupReference,
        referenceType: state.selectedGroup.getReferenceType,
        referenceId: state.selectedGroup.groupId,
      );

      while (true) {
        // Access Entries.
        final Entries entries = await _localStorageCubit.getSharedEntriesOfSharedGroup(
          rootGroupReference: state.selectedGroup.rootGroupReference,
          referenceType: state.selectedGroup.getReferenceType,
          referenceId: state.selectedGroup.groupId,
          offset: offset,
          limit: limit,
        );

        // Heighten offset.
        offset = offset + limit;

        // Stop while loop if there are no entries left.
        if (entries.items.isEmpty) break;

        // Go through data.
        for (final Entry entry in entries.items) {
          // Check if entry was already converted.
          if (entriesIdsBacklog.contains(entry.entryId)) continue;

          // Add entry id to backlog.
          entriesIdsBacklog.add(entry.entryId);

          // Access ModelEntry.
          final ModelEntry? modelEntry = await _localStorageCubit.getSharedModelEntryById(
            modelEntryId: entry.modelEntryReference,
            rootGroupReference: state.selectedGroup.rootGroupReference,
            referenceType: state.selectedGroup.getReferenceType,
            referenceId: state.selectedGroup.groupId,
          );

          // Failed to access model entry.
          if (modelEntry == null) throw Failure.modelEntryNotFound();

          // Init data.
          Map<String, dynamic> rowData = {
            'Entry name': entry.entryName,
            'Entry created at in UTC': entry.createdAtInUtc.toIso8601String(),
            'Entry created at timezone': entry.createdAtTimeZone,
            'Entry edited at in UTC': entry.editedAtInUtc.toIso8601String(),
            'Entry edited at timezone': entry.editedAtTimeZone,
          };

          // Create csv header row.
          for (final Field field in entry.fields.items) {
            // Access FieldIdentification.
            final FieldIdentification? fieldIdentification = modelEntry.fieldIdentifications.getById(
              fieldId: field.fieldId,
            );

            // Helpers.
            final String fieldLabel = fieldIdentification!.label;
            final String fieldId = fieldIdentification.fieldId;

            // * Depending on field type add headers and row data.

            // Handle TextFields.
            if (field.getIsTextField) {
              // Create header item.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.textData!.value;
            }

            // Handle PasswordFields.
            if (field.getIsPasswordField) {
              // Create header item.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.passwordData!.value;
            }

            // Handle PasswordFields.
            if (field.getIsPhoneField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.phoneData!.getValue;
            }

            // Handle DateFields.
            if (field.getIsDateField) {
              // Create header items.
              final String headerItem = '$fieldLabel in UTC (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';
              template[headerItemTimezone] = '';

              // Set data to row data.
              rowData[headerItem] = field.dateData!.valueInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.dateData!.timezone;
            }

            // Handle DateAndTimeFields.
            if (field.getIsDateAndTimeField) {
              // Create header items.
              final String headerItem = '$fieldLabel in UTC (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';
              template[headerItemTimezone] = '';

              // Set data to row data.
              rowData[headerItem] = field.dateAndTimeData!.valueInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.dateAndTimeData!.timezone;
            }

            // Handle TimeFields.
            if (field.getIsTimeField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.timeData!.getFormattedTime;
            }

            // Handle NumberField.
            if (field.getIsNumberField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.numberData!.getFormattedNumber;
            }

            // Handle EmailField.
            if (field.getIsEmailField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.emailData!.value;
            }

            // Handle WebsiteField.
            if (field.getIsWebsiteField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.websiteData!.value;
            }

            // Handle UsernameField.
            if (field.getIsUsernameField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.usernameData!.value;
            }

            // Handle LocationField.
            if (field.getIsLocationField) {
              // Create header items.
              final String headerItemLat = '$fieldLabel latitude (field_id: $fieldId)';
              final String headerItemLng = '$fieldLabel longitude (field_id: $fieldId)';
              final String headerItemTags = '$fieldLabel tags (field_id: $fieldId)';
              final String headerItemDate = '$fieldLabel created at in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel created at timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemLat] = '';
              template[headerItemLng] = '';
              template[headerItemDate] = '';
              template[headerItemTimezone] = '';
              template[headerItemTags] = '';

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.locationData!.tagsData,
                isShared: true,
              );

              // Set data to row data.
              rowData[headerItemLat] = field.locationData!.latitude;
              rowData[headerItemLng] = field.locationData!.longitude;
              rowData[headerItemDate] = field.locationData!.createdAtInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.locationData!.createdAtTimezone;
              rowData[headerItemTags] = csvSaveTagLabels;
            }

            // Handle MoneyField.
            if (field.getIsMoneyField) {
              // Create header items.
              final String headerItemValue = '$fieldLabel value (field_id: $fieldId)';
              final String headerItemCurrency = '$fieldLabel currency (field_id: $fieldId)';
              final String headerItemDefaultCurrency = '$fieldLabel default currency (field_id: $fieldId)';
              final String headerItemExchangeRate = '$fieldLabel exchange rate (field_id: $fieldId)';
              final String headerItemDate = '$fieldLabel created at in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel created at timezone (field_id: $fieldId)';
              final String headerItemTags = '$fieldLabel tags (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemValue] = '';
              template[headerItemCurrency] = '';
              template[headerItemDefaultCurrency] = '';
              template[headerItemExchangeRate] = '';
              template[headerItemDate] = '';
              template[headerItemTimezone] = '';
              template[headerItemTags] = '';

              // Access exchange rate if needed.
              final Map<String, dynamic> exchangeRateMap = await _localStorageCubit.getExchangeRate(
                customExchangeRates: field.moneyData!.customExchangeRates,
                exchangeRateDateInUtc: field.moneyData!.createdAtInUtc!,
                fromCurrencyCode: field.moneyData!.currencyCode,
                toCurrencyCode: state.selectedGroup.defaultCurrencyCode,
              );

              // Convenience variables.
              final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.moneyData!.tagsData,
                isShared: true,
              );

              // Set data to row data.
              rowData[headerItemValue] = field.moneyData!.value;
              rowData[headerItemCurrency] = field.moneyData!.currencyCode;
              rowData[headerItemDefaultCurrency] = state.selectedGroup.defaultCurrencyCode;
              rowData[headerItemExchangeRate] = exchangeRateToDefault == null ? "" : exchangeRateToDefault.toString();
              rowData[headerItemDate] = field.moneyData!.createdAtInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.moneyData!.timezone;
              rowData[headerItemTags] = csvSaveTagLabels;
            }

            // Handle PaymentField.
            if (field.getIsPaymentField) {
              // Create header items.
              final String headerItemTotal = '$fieldLabel total (field_id: $fieldId)';
              final String headerItemTotalCurrency = '$fieldLabel total currency (field_id: $fieldId)';

              final String headerItemPaidBy = '$fieldLabel paid by (field_id: $fieldId)';
              final String headerItemPaymentDate = '$fieldLabel date in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel timezone (field_id: $fieldId)';

              final String headerItemIsCompensated = '$fieldLabel is compensated (field_id: $fieldId)';

              final String headerItemDefaultCurrency = '$fieldLabel default currency (field_id: $fieldId)';
              final String headerItemExchangeRate = '$fieldLabel exchange rate (field_id: $fieldId)';
              final String headerItemTags = '$fieldLabel tags (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemTotal] = '';
              template[headerItemTotalCurrency] = '';
              template[headerItemPaidBy] = '';
              template[headerItemPaymentDate] = '';
              template[headerItemTimezone] = '';
              template[headerItemIsCompensated] = '';
              template[headerItemDefaultCurrency] = '';
              template[headerItemExchangeRate] = '';
              template[headerItemTags] = '';

              // Access Paid by member.
              Member? paidByMember = relevantMembers.getById(memberId: field.paymentData!.paidById);

              // Member is not in helper yet, access from cloud.
              if (paidByMember == null) {
                // Access member.
                final Members members = await _localStorageCubit.getSharedReferencedMembers(
                  references: [field.paymentData!.paidById],
                  rootGroupReference: state.selectedGroup.rootGroupReference,
                  referenceType: state.selectedGroup.getReferenceType,
                  referenceId: state.selectedGroup.groupId,
                );

                // Try and access member.
                paidByMember = members.items.isNotEmpty ? members.items.first : Member.unknownMember(memberId: field.paymentData!.paidById);

                // Update relevant members.
                relevantMembers = await relevantMembers.addUniqueMembers(
                  members: Members(items: [paidByMember]),
                );
              }

              // Access exchange rate if needed.
              final Map<String, dynamic> exchangeRateMap = await _localStorageCubit.getExchangeRate(
                customExchangeRates: field.paymentData!.customExchangeRates,
                exchangeRateDateInUtc: field.paymentData!.paymentDateInUtc!,
                fromCurrencyCode: field.paymentData!.currencyCode,
                toCurrencyCode: state.selectedGroup.defaultCurrencyCode,
              );

              // Convenience variables.
              final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.paymentData!.tagsData,
                isShared: true,
              );

              // Go through share references and access relevant members.
              for (final ShareReference reference in field.paymentData!.shareReferences.items) {
                // Access member.
                Member? member = relevantMembers.getById(memberId: reference.id);

                // Member is not in helper yet, access from cloud.
                if (member == null) {
                  // Access member.
                  final Members members = await _localStorageCubit.getSharedReferencedMembers(
                    references: [reference.id],
                    rootGroupReference: state.selectedGroup.rootGroupReference,
                    referenceType: state.selectedGroup.getReferenceType,
                    referenceId: state.selectedGroup.groupId,
                  );

                  // Try and access member.
                  member = members.items.isNotEmpty ? members.items.first : Member.unknownMember(memberId: reference.id);

                  // Update relevant members.
                  relevantMembers = await relevantMembers.addUniqueMembers(
                    members: Members(items: [member]),
                  );
                }

                // Create header items.
                // ! Do not add stuff that potentially randomizes this (like the toCurrency) because that will potentially result
                // ! in having multiple columns for a single payment member field.
                final String headerItemValue = '$fieldLabel ${member.memberName} value (member_id: ${member.memberId}) (field_id: $fieldId)';

                // Update template to have keys available in one map.
                template[headerItemValue] = '';

                // Calculate converted value.
                final double convertedValue = reference.valueAsDouble;

                // Set data to row data.
                rowData[headerItemValue] = convertedValue.truncateToDouble().toString();
              }

              // Set data to row data.
              rowData[headerItemTotal] = field.paymentData!.total.toString();
              rowData[headerItemTotalCurrency] = field.paymentData!.currencyCode;
              rowData[headerItemPaidBy] = '${paidByMember.memberName} (${paidByMember.memberId})';
              rowData[headerItemPaymentDate] = field.paymentData!.paymentDateInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.paymentData!.paymentDateTimezone;
              rowData[headerItemIsCompensated] = field.paymentData!.isCompensated.toString();
              rowData[headerItemDefaultCurrency] = state.selectedGroup.defaultCurrencyCode;
              rowData[headerItemExchangeRate] = exchangeRateToDefault == null ? "" : exchangeRateToDefault.toString();
              rowData[headerItemTags] = csvSaveTagLabels;
            }

            // Handle DateOfBirthField.
            if (field.getIsDateOfBirthField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.dateOfBirthData!.getFormattedDate;
            }

            // Handle TagsField.
            if (field.getIsTagsField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Get CSV save tag labels.
              final String csvSaveTagLabels = await _localStorageCubit.getCsvSaveTagLabels(
                tagsData: field.tagsData,
                isShared: true,
              );

              // Set data to row data.
              rowData[headerItem] = csvSaveTagLabels;
            }

            // Handle MeasurementField.
            if (field.getIsMeasurementField) {
              // Create header items.
              final String headerItemCategory = '$fieldLabel category (field_id: $fieldId)';
              final String headerItemValue = '$fieldLabel value (field_id: $fieldId)';
              final String headerItemUnit = '$fieldLabel unit (field_id: $fieldId)';
              final String headerItemDate = '$fieldLabel created at in utc (field_id: $fieldId)';
              final String headerItemTimezone = '$fieldLabel created at timezone (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemCategory] = '';
              template[headerItemValue] = '';
              template[headerItemUnit] = '';
              template[headerItemDate] = '';
              template[headerItemTimezone] = '';

              // Set data to row data.
              rowData[headerItemCategory] = field.measurementData!.category;
              rowData[headerItemValue] = field.measurementData!.value;
              rowData[headerItemUnit] = field.measurementData!.unit;
              rowData[headerItemDate] = field.measurementData!.createdAtInUtc!.toIso8601String();
              rowData[headerItemTimezone] = field.measurementData!.createdAtTimezone;
            }

            // Handle BooleanField.
            if (field.getIsBooleanField) {
              // Create header items.
              final String headerItem = '$fieldLabel (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItem] = '';

              // Set data to row data.
              rowData[headerItem] = field.booleanData!.value.toString();
            }

            // Handle EmotionData.
            if (field.getIsEmotionField) {
              // Access csv save data.
              final String csvSaveEmotions = EmotionData.emotionsToString(emotionData: field.emotionData);
              final String csvSaveIntensities = EmotionData.intensitiesToString(emotionData: field.emotionData);
              final String csvSaveOccurrences = EmotionData.occurrencesToString(emotionData: field.emotionData);
              final String csvSaveTimezones = EmotionData.timezonesToString(emotionData: field.emotionData);

              // Create header items.
              final String headerItemEmotions = '$fieldLabel emotion types (field_id: $fieldId)';
              final String headerItemIntensities = '$fieldLabel emotion intensities (field_id: $fieldId)';
              final String headerItemOccurrences = '$fieldLabel emotion occurrences (field_id: $fieldId)';
              final String headerItemTimezones = '$fieldLabel emotion occurrences timezones (field_id: $fieldId)';

              // Update template to have keys available in one map.
              template[headerItemEmotions] = '';
              template[headerItemIntensities] = '';
              template[headerItemOccurrences] = '';
              template[headerItemTimezones] = '';

              // Set data to row data.
              rowData[headerItemEmotions] = csvSaveEmotions;
              rowData[headerItemIntensities] = csvSaveIntensities;
              rowData[headerItemOccurrences] = csvSaveOccurrences;
              rowData[headerItemTimezones] = csvSaveTimezones;
            }
          }

          // Once all fields have been checked, add to data.
          entryData.add(rowData);
        }
      }

      // Empty groups cannot be exported.
      if (entryData.isEmpty) throw Failure.groupIsEmpty();

      // Create header row.
      final List<String> header = template.keys.toList();

      // Go through data and create rows.
      for (final Map<String, dynamic> element in entryData) {
        // Init row.
        List<String> row = [];

        // Iterating through template keys.
        for (String key in template.keys) {
          // Check if key exists.
          final bool containsKey = element.containsKey(key);

          // Init value.
          final String value = containsKey ? element[key] : '';

          // Add value to row.
          row.add(value);
        }

        // Add row to rows.
        rows.add(row);
      }

      // Update rows with header.
      rows = [header, ...rows];

      // Sanitize group name
      final String sanitizedGroupName = state.selectedGroup.groupName.replaceAll(' ', '_').replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');

      // Create a export id.
      final String exportId = const Uuid().v4();

      // Access current date.
      final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Convert to csv.
      final String csv = const ListToCsvConverter().convert(rows);

      // Get the full path.
      final String filePath = await _localStorageCubit.createLocalFilePath(
        groupId: state.selectedGroup.groupId,
        relativePath: 'exports/$exportId/${sanitizedGroupName}_$formattedDate.csv',
      );

      // Access the correct MimeType.
      final String mimeType = FileItem.getMimeType(extension: 'csv')!;

      // Save the file into local storage. This is done so user can access previous exports.
      await _localStorageCubit.putLocalFile(
        filePath: filePath,
        bytes: utf8.encode(csv),
        mimeType: mimeType,
        encrypt: false,
        secrets: null,
      );

      // Create updated file paths.
      final List<String> updatedPaths = [...state.filePaths, filePath];

      // Update available exports.
      final int availableExports = await _localStorageCubit.decrementAvailableSharedExports(amount: 1);

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        filePaths: updatedPaths,
        // * Promt user with share sheet.
        sharedFilePath: filePath,
        sharedExportsLeft: availableExports,
        status: ExportDataSheetStatus.shareFile,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> conductSharedExport() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ExportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExportDataSheetCubit --> conductSharedExport() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExportDataSheetStatus.failure,
      ));
    }
  }
}
