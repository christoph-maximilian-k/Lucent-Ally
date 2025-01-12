import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Logic.
import '/logic/helper_functions/helper_functions.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/menu_sheet/cubit/menu_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/create_model_sheet/cubit/create_model_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/cubit/entry_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/widgets/modal_bottom_sheets/show_data_sample_sheet/cubit/show_data_sample_sheet_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/create_model_sheet/create_model_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/entry_sheet.dart';
import '/widgets/modal_bottom_sheets/show_data_sample_sheet/show_data_sample_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/groups/group.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/entries/entry.dart';
import '/data/models/fields/fields.dart';
import '/data/models/import_specifications/import_specifications.dart';
import '/data/repositories/local_notifications/local_notifications_repository.dart';
import '/data/repositories/location/location_repository.dart';
import '/data/models/secrets/secrets.dart';

part 'import_data_sheet_state.dart';

class ImportDataSheetCubit extends Cubit<ImportDataSheetState> with HelperFunctions {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final MenuSheetCubit _menuSheetCubit;

  ImportDataSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    required MenuSheetCubit menuSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        _menuSheetCubit = menuSheetCubit,
        super(ImportDataSheetState.initial());

  // ############################################
  // # Initialization.
  // ############################################

  /// Initialize local state data.
  Future<void> initializeLocal({required Group group, required ModelEntries localModelEntries}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        group: group,
        importModelEntries: localModelEntries,
        status: ImportDataSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: failure,
        status: ImportDataSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: Failure.genericError(),
        status: ImportDataSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State.
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open and not loading.
    if (isClosed || state.status == ImportDataSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ImportDataSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == ImportDataSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ImportDataSheetStatus.close,
    ));
  }

  /// This method can be used to let user choose a file.
  Future<void> chooseFile({required BuildContext context}) async {
    try {
      // Access initial item.
      final int initialItem = state.delimiters.items.indexWhere(
        (element) => element.id == state.pickedDelimiter?.id,
      );

      // Let user pick group to import to.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          title: labels.basicLabelsDelimiters(),
          initialItem: initialItem == -1 ? 0 : initialItem,
          pickerItems: state.delimiters,
          staticInfoMessage: labels.delimiterInfoMessage(),
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        status: ImportDataSheetStatus.pageIsLoading,
      ));

      // Access picked object.
      final PickerItem pickedItem = state.delimiters.items[pickedIndex];

      // Let user pick a file.
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        allowMultiple: false,
      );

      // User did not pick a file.
      // * Revert state.
      if (result == null) {
        // * Only emit new states if cubit is still open.
        if (isClosed) return;

        // Emit loading state.
        emit(state.copyWith(
          status: ImportDataSheetStatus.waiting,
        ));

        return;
      }

      // Get the file.
      final File file = File(result.files.single.path!);

      // Read the file content.
      final String fileContent = await file.readAsString();

      // Parse the CSV file.
      List<List<dynamic>> csvTable = const CsvToListConverter().convert(
        fileContent,
        fieldDelimiter: pickedItem.label,
        eol: "\n",
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        file: file,
        pickedDelimiter: pickedItem,
        // * Reset selected model entry if file changes.
        selectedModelEntry: ModelEntry.initial(),
        csvTable: csvTable,
        status: ImportDataSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> chooseFile() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ImportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> chooseFile() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ImportDataSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to show data sample.
  Future<void> showDataSample({required BuildContext context}) async {
    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<ShowDataSampleSheetCubit>(
          create: (context) => ShowDataSampleSheetCubit()
            ..initialize(
              csvTable: state.csvTable,
            ),
          child: const ShowDataSampleSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> showDataSample() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: failure,
        status: ImportDataSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> showDataSample() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isShared: false,
        pageFailure: Failure.genericError(),
        status: ImportDataSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # Match with ModelEntry.
  // ############################################

  /// This method can be used to let user match selected header item with a field item.
  Future<void> matchWithModelEntry({required BuildContext context}) async {
    try {
      // Make sure a file was chosen.
      if (state.file == null || state.csvTable.isEmpty) throw Failure.noFileChosen();

      // Check if user has import model entries available to choose from.
      final bool hasAvailable = state.importModelEntries.items.isNotEmpty;

      // Check if user has the option of editing an import ModelEntry.
      final bool canEdit = state.selectedModelEntry.modelEntryName.isNotEmpty;

      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Create new Import ModelEntry.
          optionOne: labels.basicLabelsCreateNew(),
          optionOneIcon: AppIcons.edit,
          optionOneSuffix: true,
          // * Choose from existing import ModelEntries.
          optionTwo: hasAvailable ? labels.basicLabelsChooseExisting() : null,
          optionTwoIcon: hasAvailable ? AppIcons.entryModels : null,
          optionTwoSuffix: true,
          // * Edit import ModelEntry.
          optionThree: canEdit ? labels.basicLabelsEdit() : null,
          optionThreeIcon: canEdit ? AppIcons.edit : null,
          optionThreeSuffix: true,
        ),
      );

      // * User cancelled.
      if (option == null) return;

      // * User wants to create a new model entry tailored to supplied data.
      if (option == 1) {
        // Make sure used context is still mounted.
        if (!context.mounted) {
          // Output debug message.
          contextNotMountedHelper(parent: 'ImportDataSheetCubit', sourceMethod: 'matchWithModelEntry()');

          throw Failure.genericError();
        }

        // Show a create ModelEntry sheet.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<CreateModelCubit>(
            create: (context) => CreateModelCubit(
              localStorageCubit: _localStorageCubit,
              mainScreenCubit: _mainScreenCubit,
              menuSheetCubit: _menuSheetCubit,
              importDataSheetCubit: this,
            )..initializeLocalImportMatchCreate(
                csvTable: state.csvTable,
              ),
            child: const CreateModelSheet(),
          ),
        );
      }

      // * User wants to choose from existing model entries.
      if (option == 2) {
        // Make sure used context is still mounted.
        if (!context.mounted) {
          // Output debug message.
          contextNotMountedHelper(parent: 'ImportDataSheetCubit', sourceMethod: 'matchWithModelEntry()');

          throw Failure.genericError();
        }

        // Create PickerItems from model entries.
        final PickerItems pickerItems = state.importModelEntries.toPickerItems();

        // Let user pick group to import to.
        final int? pickedIndex = await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) => PickerSheet(
            title: labels.basicLabelsModelEntries(),
            pickerItems: pickerItems,
          ),
        );

        // * User did not pick an item.
        if (pickedIndex == null) return;

        // Access picked object.
        final PickerItem pickedItem = pickerItems.items[pickedIndex];

        // Access model entry by its id.
        final ModelEntry pickedModelEntry = state.importModelEntries.getById(id: pickedItem.id)!;

        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          selectedModelEntry: pickedModelEntry,
        ));
      }

      // * User wants to edit an import ModelEntry.
      if (option == 3) {
        // Make sure used context is still mounted.
        if (!context.mounted) {
          // Output debug message.
          contextNotMountedHelper(parent: 'ImportDataSheetCubit', sourceMethod: 'matchWithModelEntry()');

          throw Failure.genericError();
        }

        // Show a create ModelEntry sheet.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<CreateModelCubit>(
            create: (context) => CreateModelCubit(
              localStorageCubit: _localStorageCubit,
              mainScreenCubit: _mainScreenCubit,
              menuSheetCubit: _menuSheetCubit,
              importDataSheetCubit: this,
            )..initializeLocalImportMatchEdit(
                csvTable: state.csvTable,
                modelEntry: state.selectedModelEntry,
              ),
            child: const CreateModelSheet(),
          ),
        );
      }
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> matchWithModelEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ImportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> matchWithModelEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ImportDataSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Create sample entry.
  // ############################################

  /// This method can be used to show a preview of what the first imported entry will look like and to provide additional contexts.
  Future<void> matchImportDataToEntry({required BuildContext context}) async {
    try {
      // Make sure a file was chosen.
      if (state.file == null || state.csvTable.isEmpty) throw Failure.noFileChosen();

      // Make sure a ModelEntry was selected.
      if (state.selectedModelEntry.modelEntryName.isEmpty) throw Failure.noModelEntrySelected();

      // Init LocalNotificationsCubit.
      final LocalNotificationCubit localNotificationCubit = LocalNotificationCubit(
        localNotificationsRepository: context.read<LocalNotificationsRepository>(),
        appMessagesCubit: _appMessagesCubit,
      );

      // Show create entry sheet.
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<EntrySheetCubit>(
          create: (context) {
            // * Initialize an edit.
            if (state.isTemplateEdit) {
              return EntrySheetCubit(
                locationRepository: context.read<LocationRepository>(),
                localNotificationsCubit: localNotificationCubit,
                localStorageCubit: _localStorageCubit,
                appMessagesCubit: _appMessagesCubit,
                mainScreenCubit: _mainScreenCubit,
                menuSheetCubit: _menuSheetCubit,
                importDataSheetCubit: this,
              )..initializeSetImportMatch(
                  modelEntry: state.selectedModelEntry,
                  isEdit: true,
                  fromGroup: state.group,
                  csvTable: state.csvTable,
                );
            }

            // * Initialize a create.
            return EntrySheetCubit(
              locationRepository: context.read<LocationRepository>(),
              localNotificationsCubit: localNotificationCubit,
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              menuSheetCubit: _menuSheetCubit,
              importDataSheetCubit: this,
            )..initializeSetImportMatch(
                modelEntry: state.selectedModelEntry,
                isEdit: false,
                fromGroup: state.group,
                csvTable: state.csvTable,
              );
          },
          child: const EntrySheet(),
        ),
      );

      // * Close the cubit after useing it.
      localNotificationCubit.close();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> matchImportDataToEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ImportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> matchImportDataToEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ImportDataSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Import rules.
  // ############################################

  /// This method can be used to set a import rule.
  Future<void> setImportRule({required BuildContext context, required bool isInvalidRule}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Option import should fail.
          optionOne: labels.basicLabelsImportShouldFail(),
          optionOneIcon: AppIcons.first,
          // * Option import should skip value.
          optionTwo: labels.basicLabelsImportShouldSkip(),
          optionTwoIcon: AppIcons.second,
          // * Option import should skip value.
          optionThree: labels.basicLabelsImportShouldFailOrDefault(),
          optionThreeIcon: AppIcons.third,
          // * Option import should skip value.
          optionFour: labels.basicLabelsImportShouldSkipOrDefault(),
          optionFourIcon: AppIcons.fourth,
        ),
      );

      // * User cancelled.
      // * Only emit new states if cubit is still open.
      if (option == null || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        status: ImportDataSheetStatus.loading,
      ));

      // Init specs.
      ImportSpecifications specs = state.selectedModelEntry.importSpecifications ?? ImportSpecifications.initial();

      // * User selected first option.
      if (option == 1) {
        // Create updated ImportSpecifications.
        specs = specs.copyWith(
          invalidValueRule: isInvalidRule ? ImportSpecifications.importRuleFail : null,
          missingValueRule: isInvalidRule == false ? ImportSpecifications.importRuleFail : null,
        );
      }

      // * User selected second option.
      if (option == 2) {
        // Create updated ImportSpecifications.
        specs = specs.copyWith(
          invalidValueRule: isInvalidRule ? ImportSpecifications.importRuleSkip : null,
          missingValueRule: isInvalidRule == false ? ImportSpecifications.importRuleSkip : null,
        );
      }

      // * User selected third option.
      if (option == 3) {
        // Create updated ImportSpecifications.
        specs = specs.copyWith(
          invalidValueRule: isInvalidRule ? ImportSpecifications.importRuleDefaultOrFail : null,
          missingValueRule: isInvalidRule == false ? ImportSpecifications.importRuleDefaultOrFail : null,
        );
      }

      // * User selected fourth option.
      if (option == 4) {
        // Create updated ImportSpecifications.
        specs = specs.copyWith(
          invalidValueRule: isInvalidRule ? ImportSpecifications.importRuleDefaultOrSkip : null,
          missingValueRule: isInvalidRule == false ? ImportSpecifications.importRuleDefaultOrSkip : null,
        );
      }

      // Update ModelEntry.
      final ModelEntry updatedModel = state.selectedModelEntry.copyWith(
        importSpecifications: specs,
      );

      // Update local storage.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Add entry model to local storage.
        await _localStorageCubit.editLocalModelEntry(
          updatedModelEntry: updatedModel,
        );
      });

      // * Update dependent cubits.
      _menuSheetCubit.onEntryModelEdited(editedEntryModel: updatedModel);

      // * Update dependent cubits.
      _mainScreenCubit.onModelEntryEdited(modelEntry: updatedModel);

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        selectedModelEntry: updatedModel,
        status: ImportDataSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> setImportRule() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ImportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> setImportRule() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ImportDataSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Conduct import.
  // ############################################

  /// This method can be used to conduct the import.
  Future<void> conductImport() async {
    try {
      // Make sure import specs are available.
      if (state.selectedModelEntry.importSpecifications == null) throw Failure.sampleEntryRequired();

      // Make sure import rules were set.
      if (state.selectedModelEntry.importSpecifications!.invalidValueRule.isEmpty) throw Failure.invalidValueRuleRequired();
      if (state.selectedModelEntry.importSpecifications!.missingValueRule.isEmpty) throw Failure.missingValueRuleRequired();

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: ImportDataSheetStatus.pageIsLoading,
        loadingMessage: labels.basicLabelsConvertingData(),
      ));

      // Trigger micro service to ensure that state update is respected.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Access secrets.
      final Secrets? secrets = state.group.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Transform csv table.
      final List<Map<String, dynamic>> transformed = await HelperFunctions.wrapperConvertCsvToMap(
        csvTable: state.csvTable,
        convertRows: null,
      );

      // Access import specifications.
      final ImportSpecifications importSpecifications = state.selectedModelEntry.importSpecifications!;

      // Go through data and create entries.
      for (int i = 0; i < transformed.length; i++) {
        // Update state.
        emit(state.copyWith(
          loadingMessage: labels.loadingMessageEntriesImported(index: i),
        ));

        // Access data.
        final Map<String, dynamic> element = transformed[i];

        // Access entry name.
        final String entryName = importSpecifications.getImportEntryName(
          row: element,
          defaultEntryName: importSpecifications.entryNameDefault,
        );

        // Access created at.
        final DateTime createdAtInUtc = importSpecifications.getImportCreatedAtInUtc(
          row: element,
        );

        // Go through importSpecifications fields and create field from provided instructions.
        // * i + 1 is used because user do not know that in development the first item in a list is marked as 0.
        final Fields fields = await importSpecifications.fieldsFromImportInstructions(
          row: element,
          currentRow: i + 1,
          localStorageCubit: _localStorageCubit,
          groupParticipantReference: state.group.participantReference,
          defaultCurrencyCode: state.group.defaultCurrencyCode,
        );

        // Init the entry.
        final Entry entry = Entry.initial().copyWith(
          entryName: entryName,
          createdAtInUtc: createdAtInUtc,
          createdAtTimeZone: 'UTC',
          editedAtInUtc: createdAtInUtc,
          editedAtTimeZone: 'UTC',
          modelEntryReference: state.selectedModelEntry.modelEntryId,
          entryCreator: user.userId,
          fields: fields,
        );

        // Conduct import.
        await _localStorageCubit.state.database!.writeTxn(() async {
          // Add reference.
          await _localStorageCubit.createLocalGroupToEntryReference(
            group: state.group,
            entry: entry,
            addedBy: user.userId,
          );

          // Create entry.
          await _localStorageCubit.createLocalEntry(
            entry: entry,
            encrypt: state.group.isEncrypted,
            secrets: secrets,
          );

          // Only emit new states if cubit is still open.
          if (isClosed) throw Failure.genericError();
        });
      }

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.importSucceeded(),
      );

      // Update state.
      emit(state.copyWith(
        status: ImportDataSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> conductImport() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ImportDataSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ImportDataSheetCubit --> conductImport() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ImportDataSheetStatus.failure,
      ));
    }
  }

  // ##################################################################
  // * Below methods are called from other cubits.
  // ##################################################################

  /// This method will be triggered if user created a new model entry.
  Future<void> onModelEntryCreated({required ModelEntry modelEntry}) async {
    // Add model entry to list.
    final ModelEntries updated = state.importModelEntries.add(
      modelEntry: modelEntry,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      importModelEntries: updated,
      selectedModelEntry: modelEntry,
      status: ImportDataSheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user finished creating template fields.
  Future<void> onTemplateCreated({required ModelEntry modelEntry}) async {
    // Add model entry to list.
    final ModelEntries? updated = state.importModelEntries.update(
      modelEntry: modelEntry,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      importModelEntries: updated,
      selectedModelEntry: modelEntry,
      status: ImportDataSheetStatus.waiting,
    ));
  }
}
