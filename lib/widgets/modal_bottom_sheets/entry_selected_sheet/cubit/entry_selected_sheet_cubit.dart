import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Repositories.
import '/data/repositories/location/location_repository.dart';
import '/data/repositories/local_notifications/local_notifications_repository.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/entry_sheet/entry_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/local_notification_sheet.dart';
import '/widgets/modal_bottom_sheets/local_notification_details_sheet/local_notification_details_sheet.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/local_group_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/shared_group_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';

// Pages.
import '/pages/view_files_page/view_files_page.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/cubit/entry_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/widgets/modal_bottom_sheets/view_entries_sheet/cubit/view_entries_sheet_cubit.dart';

// Screens.
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/view_entries_sheet/view_entries_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/entries/entry.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/fields/fields.dart';
import '/data/models/fields/field.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/password_data/password_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';
import '/data/models/files/files.dart';
import '/data/models/files/file_item.dart';
import '/data/models/notification_payload/notification_payload.dart';
import '/data/models/members/members.dart';
import '/data/models/tags/tag.dart';
import '/data/models/references/recent_entries/recent_entry.dart';
import '/data/models/model_entry_prefs/model_entry_prefs.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/exchange_rates/exchange_rates.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/tags/tags.dart';

part 'entry_selected_sheet_state.dart';

class EntrySelectedSheetCubit extends Cubit<EntrySelectedSheetState> with HelperFunctions {
  final LocalNotificationsRepository _localNotificationsRepository;
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;
  final ViewEntriesSheetCubit? _viewEntriesSheetCubit;

  EntrySelectedSheetCubit({
    required LocalNotificationsRepository localNotificationsRepository,
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
    ViewEntriesSheetCubit? viewEntriesSheetCubit,
  })  : _localNotificationsRepository = localNotificationsRepository,
        _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        _mainScreenCubit = mainScreenCubit,
        _viewEntriesSheetCubit = viewEntriesSheetCubit,
        super(EntrySelectedSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize local entry selected state data.
  Future<void> initializeLocal({required Entry entry, required Group? fromGroup, required bool fromViewEntriesSheet}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init Local Notifications.
      final FlutterLocalNotificationsPlugin plugin = state.notificationsPlugin ?? await _localNotificationsRepository.initPlugin();

      // Access currently pending notifications and store them into state.
      final List<PendingNotificationRequest> pendingNotifications = await plugin.pendingNotificationRequests();

      // Indication that this entry was from recent entries.
      final bool fromRecentEntry = fromGroup == null;

      // Check if from group is null and init it if thats the case.
      if (fromGroup == null) {
        // Access Recent entry reference.
        final RecentEntry? recentEntry = await _localStorageCubit.getLocalRecentEntryById(
          entryId: entry.entryId,
        );

        // This should never happen.
        if (recentEntry == null) throw Failure.genericError();

        // Access referenced group.
        fromGroup = await _localStorageCubit.getLocalGroupById(
          groupId: recentEntry.groupReference,
        );
      }

      // If group was not found, throw Failure.
      if (fromGroup == null) throw Failure.genericError();

      // Access topLevelGroup.
      final Group? topLevelGroup = fromGroup.getIsLocalGroupType
          ? fromGroup
          : await _localStorageCubit.getLocalGroupById(
              groupId: fromGroup.rootGroupReference,
            );

      // Top level group not found.
      if (topLevelGroup == null) throw Failure.genericError();

      // Access relevant ModelEntry.
      final ModelEntry? modelEntry = await _localStorageCubit.getLocalModelEntryById(
        modelEntryId: entry.modelEntryReference,
        shouldAccessPrefs: true,
      );

      // Specified ModelEntry was not found.
      if (modelEntry == null) throw Failure.entryModelNotFound();

      // Access groups of entry.
      final Groups groups = await _localStorageCubit.getLocalGroupsOfEntry(
        entry: entry,
      );

      // Only do this if this entry was not selected from main screen.
      if (fromRecentEntry == false) {
        // Update recent items.
        await _localStorageCubit.state.database!.writeTxn(() async {
          await _localStorageCubit.putLocalRecentEntry(
            entryId: entry.entryId,
            rootGroupReference: fromGroup!.rootGroupReference,
            groupReference: fromGroup.groupId,
          );
        });

        // Let cubit know.
        _mainScreenCubit.onEntryInteracted(
          entry: entry,
          modelEntry: modelEntry,
          fromGroup: fromGroup,
        );
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        fromViewEntriesSheet: fromViewEntriesSheet,
        fromRecentEntry: fromRecentEntry,
        topLevelGroup: topLevelGroup,
        fromGroup: fromGroup,
        groups: groups,
        entry: entry,
        entryModel: modelEntry,
        notificationsPlugin: plugin,
        pendingNotifications: pendingNotifications,
        status: EntrySelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> initializeLocal() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySelectedSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> initializeLocal() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySelectedSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared entry selected state data.
  Future<void> initializeShared({required Entry entry, required Group? fromGroup, required bool fromViewEntriesSheet}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init Local Notifications.
      final FlutterLocalNotificationsPlugin plugin = state.notificationsPlugin ?? await _localNotificationsRepository.initPlugin();

      // Access currently pending notifications and store them into state.
      final List<PendingNotificationRequest> pendingNotifications = await plugin.pendingNotificationRequests();

      // Indication that this entry was from recent entries.
      final bool fromRecentEntry = fromGroup == null;

      // Check if from group is null and init it if thats the case.
      if (fromGroup == null) {
        // Access Recent entry reference.
        final RecentEntry recentEntry = await _localStorageCubit.getSelfSharedRecentEntryById(
          entryId: entry.entryId,
        );

        // Check if group reference is referencing a root group.
        final bool isRootGroup = recentEntry.rootGroupReference == recentEntry.groupReference;

        // Access referenced group.
        fromGroup = isRootGroup
            ? await _localStorageCubit.getSharedGroupById(
                groupId: recentEntry.groupReference,
              )
            : await _localStorageCubit.getSharedSubgroupById(
                rootGroupReference: recentEntry.rootGroupReference,
                subgroupId: recentEntry.groupReference,
              );
      }

      // Access topLevelGroup.
      final Group topLevelGroup = fromGroup.getIsSharedGroupType
          ? fromGroup
          : await _localStorageCubit.getSharedGroupById(
              groupId: fromGroup.rootGroupReference,
            );

      // Access the entry.
      final Entry accessedEntry = await _localStorageCubit.getSharedEntryById(
        rootGroupReference: fromGroup.rootGroupReference,
        entryId: entry.entryId,
        referenceType: fromGroup.getReferenceType,
        referenceId: fromGroup.groupId,
      );

      // Access relevant ModelEntry.
      final ModelEntry? entryModel = await _localStorageCubit.getSharedModelEntryById(
        rootGroupReference: fromGroup.rootGroupReference,
        modelEntryId: accessedEntry.modelEntryReference,
        referenceType: fromGroup.getReferenceType,
        referenceId: fromGroup.groupId,
      );

      // Specified ModelEntry was not found.
      if (entryModel == null) throw Failure.entryModelNotFound();

      // Check if entry creator is banned.
      final bool entryCreatorIsBanned = await _localStorageCubit.getUserIsBanned(
        rootGroupReference: fromGroup.rootGroupReference,
        groupId: fromGroup.groupId,
        referencedUserId: accessedEntry.entryCreator,
      );

      // Access groups of entry.
      // * In this case the only group is the one that was already accessed because
      // * shared entries can currently only be in one group.
      final Groups groups = Groups(items: [fromGroup]);

      // Update recent items. Do not await for smoother UI ex.
      _localStorageCubit.putSharedRecentEntry(
        entryId: accessedEntry.entryId,
        groupReference: fromGroup.groupId,
      );

      // Let cubit know.
      _mainScreenCubit.onEntryInteracted(
        entry: accessedEntry,
        modelEntry: entryModel,
        fromGroup: fromGroup,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        fromRecentEntry: fromRecentEntry,
        fromViewEntriesSheet: fromViewEntriesSheet,
        entryCreatorIsBanned: entryCreatorIsBanned,
        topLevelGroup: topLevelGroup,
        fromGroup: fromGroup,
        groups: groups,
        entry: accessedEntry,
        entryModel: entryModel,
        notificationsPlugin: plugin,
        pendingNotifications: pendingNotifications,
        status: EntrySelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> initializeShared() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySelectedSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> initializeShared() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySelectedSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # Files.
  // ############################################

  /// This method can be used to load images from file system.
  Future<FileItem?> loadFileItem({required FileItem? fileItem}) async {
    return await _localStorageCubit.loadLocalFileItem(fromGroup: state.fromGroup, fileItem: fileItem);
  }

  /// This method can be used to load a members of a PaymentField into state.
  Future<Members?> loadReferencedMembers({required PaymentData paymentData}) async {
    // * User is in shared mode, return shared members.
    if (state.isShared) {
      return await _localStorageCubit.loadReferencedSharedMembers(
        fromGroup: state.fromGroup,
        participantReference: paymentData.participantReference,
        additionalMemberIds: paymentData.involvedMemberIds,
      );
    }

    // * User is in local mode return local members.
    return await _localStorageCubit.loadReferencedLocalMembers(
      participantReference: paymentData.participantReference,
      additionalMemberIds: paymentData.involvedMemberIds,
    );
  }

  /// This method can be used to load tags into state.
  Future<Tags?> loadReferencedTags({required TagsData tagsData, required Field field}) async {
    // * User is in shared mode, return shared tags.
    if (state.isShared) {
      return await _localStorageCubit.loadReferencedSharedTags(
        field: field,
        tagsData: tagsData,
      );
    }

    // * User is in local mode return local tags.
    return await _localStorageCubit.loadReferencedLocalTags(
      field: field,
      tagsData: tagsData,
    );
  }

  // ############################################
  // # State
  // ############################################

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Do nothing if state is already set to close.
    if (state.status == EntrySelectedSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntrySelectedSheetStatus.close,
    ));
  }

  /// This method will be triggered if user tabs on a specific tag.
  Future<void> onTabTag({required BuildContext context, required Tag tag}) async {
    try {
      // Do not allow this in a nested way.
      if (state.fromViewEntriesSheet) return;

      // This feature is currently not available in shared mode.
      if (state.isShared) throw Failure.unimplemented();

      // Show view entries sheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<ViewEntriesSheetCubit>(
          create: (context) => ViewEntriesSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
            entrySelectedSheetCubit: this,
          )..initializeLocal(
              fromGroup: state.fromGroup,
              referenceId: tag.tagId,
              referenceType: 'tag',
              chart: null,
            ),
          child: const ViewEntriesSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> onTabTag() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> onTabTag() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntrySelectedSheetStatus.waiting,
    ));
  }

  /// This method gets triggered if user wants to change obsucre status.
  void obscuredChanged({required Field field}) {
    // Create updated PasswordData.
    final PasswordData updatedPasswordData = field.passwordData!.copyWith(
      obscure: !field.passwordData!.obscure,
    );

    // Create updated Field.
    final Field updatedField = field.copyWith(
      passwordData: updatedPasswordData,
    );

    // Create Fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Emit state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  
  /// This method can be used to copy a value to clipboard.
  Future<void> copyToClipboard({required BuildContext context, required String data, required String notification}) async {
    try {
      // Set data to clipboard.
      await Clipboard.setData(ClipboardData(text: data));

      // Only do this if this entry was not selected from main screen.
      if (state.fromRecentEntry == false) {
        // * User is in local mode.
        if (state.isShared == false) {
          await _localStorageCubit.state.database!.writeTxn(() async {
            // Update recent items.
            await _localStorageCubit.putLocalRecentEntry(
              entryId: state.entry.entryId,
              rootGroupReference: state.fromGroup.rootGroupReference,
              groupReference: state.fromGroup.groupId,
            );
          });
        }

        // * User is in shared mode.
        if (state.isShared) {
          // Update recent items. Do not await for smoother UI ex.
          _localStorageCubit.putSharedRecentEntry(
            entryId: state.entry.entryId,
            groupReference: state.fromGroup.groupId,
          );
        }

        // Let main screen know.
        _mainScreenCubit.onEntryInteracted(
          entry: state.entry,
          modelEntry: state.entryModel,
          fromGroup: state.fromGroup,
        );
      }

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: notification,
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> copyToClipboard() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> copyToClipboard() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to show an EntrySheet in local mode.
  Future<void> editLocalEntry({required BuildContext context}) async {
    // Init LocalNotificationsCubit.
    final LocalNotificationCubit localNotificationCubit = LocalNotificationCubit(
      localNotificationsRepository: context.read<LocalNotificationsRepository>(),
      appMessagesCubit: _appMessagesCubit,
    );

    // * Show EntrySheet.
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<EntrySheetCubit>(
        create: (context) => EntrySheetCubit(
          locationRepository: context.read<LocationRepository>(),
          localNotificationsCubit: localNotificationCubit,
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          entrySelectedSheetCubit: this,
          mainScreenCubit: _mainScreenCubit,
          localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
          viewEntriesSheetCubit: _viewEntriesSheetCubit,
        )..initializeLocalEdit(
            modelEntry: state.entryModel,
            fromGroup: state.fromGroup,
          ),
        child: const EntrySheet(),
      ),
    );

    // * Close cubit after useing it.
    localNotificationCubit.close();
  }

  /// This method can be used to show an EntrySheet in shared mode.
  Future<void> editSharedEntry({required BuildContext context}) async {
    // Make sure only user that has the correct rights can edit this entry.
    final bool userHasEditRights = state.fromGroup.userHasEntryEditPermissions(
      isShared: state.isShared,
      topLevelGroupOwner: state.topLevelGroup.groupCreator,
      entryCreator: state.entry.entryCreator,
    );

    // Emit failure state.
    if (userHasEditRights == false) {
      emit(state.copyWith(
        failure: Failure.noEditPermission(),
        status: EntrySelectedSheetStatus.failure,
      ));

      return;
    }

    // Init LocalNotificationsCubit.
    final LocalNotificationCubit localNotificationCubit = LocalNotificationCubit(
      localNotificationsRepository: context.read<LocalNotificationsRepository>(),
      appMessagesCubit: _appMessagesCubit,
    );

    // * Show EntrySheet.
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<EntrySheetCubit>(
        create: (context) => EntrySheetCubit(
          locationRepository: context.read<LocationRepository>(),
          localNotificationsCubit: localNotificationCubit,
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          entrySelectedSheetCubit: this,
          mainScreenCubit: _mainScreenCubit,
          sharedGroupSelectedSheetCubit: _sharedGroupSelectedSheetCubit,
        )..initializeSharedEdit(
            modelEntry: state.entryModel,
            fromGroup: state.fromGroup,
          ),
        child: const EntrySheet(),
      ),
    );

    // * Close cubit after useing it.
    localNotificationCubit.close();
  }

  /// This method will be triggered if user wants to change what data will be accessible in entry preview card.
  Future<void> onFieldOptionsPressed({required BuildContext context, required FieldIdentification fieldIdentification, required Field field, bool excludeCopyOption = false}) async {
    try {
      // * Display SelectOptionsSheet.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Entry preview copy.
          optionOne: excludeCopyOption ? null : labels.entrySelectedSetAsEntryPreviewCopy(),
          optionOneIcon: excludeCopyOption ? null : AppIcons.copy,
          // * Entry preview subtitle.
          optionTwo: labels.entrySelectedSetAsEntryPreviewSubtitle(),
          optionTwoIcon: AppIcons.subtitle,
          // * Entry preview thirdline.
          optionThree: labels.entrySelectedSetAsEntryPreviewThirdline(),
          optionThreeIcon: AppIcons.thirdline,
          // * Set Notification.
          optionFour: labels.entrySelectedSetNotificationOption(),
          optionFourIcon: AppIcons.notification,
          optionFourSuffix: true,
        ),
      );

      // User dismissed sheet.
      if (option == null) return;

      // * User wants to set a notification for this field.
      if (option == 4) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Emit notification state.
        emit(state.copyWith(
          status: EntrySelectedSheetStatus.setNotification,
          notificationField: field,
        ));

        return;
      }

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: EntrySelectedSheetStatus.loading,
      ));

      // Create edited modelEntryPrefs.
      final ModelEntryPrefs prefs = state.entryModel.modelEntryPrefs.copyWith(
        copyFieldId: option == 1 ? fieldIdentification.fieldId : state.entryModel.modelEntryPrefs.copyFieldId,
        subtitleFieldId: option == 2 ? fieldIdentification.fieldId : state.entryModel.modelEntryPrefs.subtitleFieldId,
        thirdLineFieldId: option == 3 ? fieldIdentification.fieldId : state.entryModel.modelEntryPrefs.thirdLineFieldId,
      );

      // Create edited ModelEntry.
      final ModelEntry editedEntryModel = state.entryModel.copyWith(
        modelEntryPrefs: prefs,
      );

      // Update local ModelEntryPrefs.
      if (state.isShared == false) {
        await _localStorageCubit.state.database!.writeTxn(() async {
          await _localStorageCubit.putLocalModelEntryPrefs(
            modelEntryId: state.entryModel.modelEntryId,
            modelEntryPrefs: prefs,
          );
        });
      }

      // Update shared ModelEntry.
      if (state.isShared) {
        await _localStorageCubit.putSelfSharedModelEntryPrefs(
          modelEntryId: state.entryModel.modelEntryId,
          modelEntryPrefs: prefs,
          isSelfDefault: null,
        );
      }

      // Initialize default.
      String notification = labels.entrySelectedDefaultOptionsNotification();

      // Set notification message.
      if (option == 1) notification = labels.entrySelectedCopyOptionNotification(fieldLabel: fieldIdentification.label);
      if (option == 2) notification = labels.entrySelectedSubtitleOptionNotification(fieldLabel: fieldIdentification.label);
      if (option == 3) notification = labels.entrySelectedThirdlineOptionNotification(fieldLabel: fieldIdentification.label);

      // Notify dependent cubits.
      if (_sharedGroupSelectedSheetCubit != null) {
        await _sharedGroupSelectedSheetCubit.onModelEntryEdited(modelEntry: editedEntryModel);
      }

      // Notify dependent cubits.
      if (_localGroupSelectedSheetCubit != null) {
        await _localGroupSelectedSheetCubit.onModelEntryEdited(modelEntry: editedEntryModel);
      }

      // Notify dependent cubits.
      if (_viewEntriesSheetCubit != null) {
        await _viewEntriesSheetCubit.onModelEntryEdited(modelEntry: editedEntryModel);
      }

      // Notify dependent cubits.
      await _mainScreenCubit.onModelEntryEdited(modelEntry: editedEntryModel);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Revert state.
      emit(state.copyWith(
        entryModel: editedEntryModel,
        status: EntrySelectedSheetStatus.waiting,
      ));

      // Display notification.
      _appMessagesCubit.showNotification(
        message: notification,
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> entryPreviewOptionSelected() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> entryPreviewOptionSelected() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method is triggerd if user wants to view entry options.
  Future<void> onEntryOptionsPressed({required BuildContext context}) async {
    // * Make sure user is root group owner.
    final bool isRootGroupOwner = state.topLevelGroup.groupCreator == user.userId;
    final bool rootGroupCreatorIsEntryCreator = state.topLevelGroup.groupCreator == state.entry.entryCreator;
    final bool canBan = state.isShared && isRootGroupOwner && rootGroupCreatorIsEntryCreator == false && state.entryCreatorIsBanned == false;
    final bool canUnban = state.isShared && isRootGroupOwner && rootGroupCreatorIsEntryCreator == false && state.entryCreatorIsBanned;

    // * Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        // * Delete entry.
        optionOne: labels.entrySelectedSheetCubitDeleteEntry(),
        optionOneIcon: AppIcons.delete,
        optionOneSuffix: true,
        // * Remove entry from group.
        optionTwo: state.isShared == false ? labels.entrySelectedSheetRemoveFromGroup() : null,
        optionTwoIcon: AppIcons.remove,
        optionTwoSuffix: true,
        // TODO: Move entry to another group (new_feature).
        // * Go to group.
        optionThree: state.fromRecentEntry ? labels.entrySelectedSheetGoToGroup() : null,
        optionThreeIcon: AppIcons.groups,
        optionThreeSuffix: true,
        // * Ban user from group.
        optionFour: canBan ? labels.entrySelectedSheetCubitBanUser() : null,
        optionFourIcon: AppIcons.ban,
        optionFourSuffix: true,
        // * Unban user from group.
        optionFive: canUnban ? labels.entrySelectedSheetCubitRevokeBan() : null,
        optionFiveIcon: AppIcons.revoke,
        optionFiveSuffix: true,
      ),
    );

    // Make sure used context is still mounted. Output debug message.
    if (!context.mounted) return contextNotMountedHelper(parent: 'EntrySelectedSheetCubit', sourceMethod: 'onEntryOptionsPressed()');

    // * User wants to delete entry.
    if (option == 1) {
      if (state.isShared == false) confirmDeleteLocalEntry(context: context);
      if (state.isShared) confirmDeleteSharedEntry(context: context);
    }

    // * User wants to remove entry from group.
    if (option == 2) {
      if (state.isShared == false) confirmRemoveEntryFromLocalGroup(context: context);
    }

    // * User wants to go to entry group.
    if (option == 3) {
      if (state.isShared == false) goToGroupOfLocalEntry(context: context);
      if (state.isShared) goToGroupOfSharedEntry(context: context);
    }

    // * User wants to ban user from group.
    if (option == 4) {
      if (state.isShared) confirmBanUserFromGroup(context: context);
    }

    // * User wants to revoke ban for a user.
    if (option == 5) {
      if (state.isShared) confirmRevokeBan(context: context);
    }
  }

  /// This method can be used to go to group of an entry.
  Future<void> goToGroupOfLocalEntry({required BuildContext context}) async {
    try {
      // Check if this group is only in one group.
      final bool onlyOneGroup = state.groups.items.length == 1;

      Group? selectedGroup = onlyOneGroup ? state.groups.items[0] : null;

      // Entry is in more then one group, let user select.
      if (onlyOneGroup == false) {
        // Access PickerItems.
        final PickerItems pickerItems = state.groups.toPickerItems();

        // Show picker sheet.
        final int? pickedIndex = await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) => PickerSheet(
            title: labels.entrySelectedSheetSelectGroup(),
            pickerItems: pickerItems,
          ),
        );

        // * User did not pick an item.
        if (pickedIndex == null) return;

        // Access picked object.
        final PickerItem pickedItem = pickerItems.items[pickedIndex];

        // Access group.
        final Group pickedGroup = await state.groups.getById(groupId: pickedItem.id) as Group;

        // Set variable.
        selectedGroup = pickedGroup;
      }

      // User cancled.
      if (selectedGroup == null) return;

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'EntrySelectedSheetCubit', sourceMethod: 'goToGroupOfLocalEntry()');

      // Close the entry selected sheet.
      Navigator.of(context).pop();

      // * Display GroupSelectedSheet in local mode.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<LocalGroupSelectedSheetCubit>(
          create: (context) => LocalGroupSelectedSheetCubit(
            localNotificationsRepository: _localNotificationsRepository,
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            // * TopLevel group gets selected here, which means that there is no ancestor groupSelectedSheetCubit to pass on.
            ancestorLocalGroupSelectedSheetCubit: null,
          )..initialize(
              context: context,
              group: selectedGroup!,
              topLevelGroupId: selectedGroup.rootGroupReference,
            ),
          child: const LocalGroupSelectedSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> goToGroupOfLocalEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> goToGroupOfEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to go to group of an entry.
  Future<void> goToGroupOfSharedEntry({required BuildContext context}) async {
    try {
      // Check if this is a subgroup.
      final bool isSubgroup = state.groups.items[0].getIsSharedSubgroupType;

      // Close the entry selected sheet.
      Navigator.of(context).pop();

      // Show in subgroup mode.
      if (isSubgroup) {
        // * Display SharedGroupSelectedSheet.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<SharedGroupSelectedSheetCubit>(
            create: (context) => SharedGroupSelectedSheetCubit(
              localNotificationsRepository: _localNotificationsRepository,
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              // * TopLevel group gets selected here, which means that there is no ancestor groupSelectedSheetCubit to pass on.
              sharedGroupSelectedSheetCubit: null,
            )..initializeSubgroup(
                initialGroup: state.groups.items[0],
                topLevelGroupOwner: state.topLevelGroup.groupCreator,
              ),
            child: const SharedGroupSelectedSheet(),
          ),
        );

        return;
      }

      // * Display SharedGroupSelectedSheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<SharedGroupSelectedSheetCubit>(
          create: (context) => SharedGroupSelectedSheetCubit(
            localNotificationsRepository: _localNotificationsRepository,
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            // * TopLevel group gets selected here, which means that there is no ancestor groupSelectedSheetCubit to pass on.
            sharedGroupSelectedSheetCubit: null,
          )..initializeGroup(initialGroup: state.groups.items[0]),
          child: const SharedGroupSelectedSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> goToGroupOfSharedEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> goToGroupOfSharedEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to perform a quick addition to a number.
  Future<void> quickNumberAction({required BuildContext context, required Field field, required int index, required String action}) async {
    try {
      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Make sure only authorized user can edit.
      final bool userCanEdit = state.fromGroup.userHasEntryEditPermissions(
        isShared: state.isShared,
        topLevelGroupOwner: state.topLevelGroup.groupCreator,
        entryCreator: state.entry.entryCreator,
      );

      // This user cannot edit this entry.
      if (userCanEdit == false) throw Failure.noEditPermission();

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        currentLoadingChipsIndex: index,
        status: EntrySelectedSheetStatus.chipsLoading,
      ));

      // * Make sure a failure is thrown if action is unknown.
      if (NumberData.availableQuickNumberActions.contains(action) == false) {
        throw Failure.unknownQuickNumberAction();
      }

      // Access quick Action value.
      final double quickActionValue = field.numberData!.quickActionValue;

      // Init value.
      late double value;

      // * User action: add
      if (action == NumberData.quickNumberActionAdd) {
        value = field.numberData!.valueAsDouble + quickActionValue;
      }

      // * User action: subtract
      if (action == NumberData.quickNumberActionSubtract) {
        value = field.numberData!.valueAsDouble - quickActionValue;
      }

      // * User action: invert
      if (action == NumberData.quickNumberActionInvert) {
        value = field.numberData!.valueAsDouble * (-1);
      }

      // Update Field.
      final Field updatedField = field.copyWith(
        numberData: field.numberData!.copyWith(
          value: value.toString(),
        ),
      );

      // Update Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Create edited entry.
      final Entry editedEntry = state.entry.copyWith(
        fields: fields,
      );

      final Entry result = await _localStorageCubit.state.database!.writeTxn(() async {
        // Add entry to local storage.
        final Entry updatedEntry = state.isShared
            ? await _localStorageCubit.editSharedEntry(
                entry: editedEntry,
                rootGroupReference: state.fromGroup.rootGroupReference,
                referenceType: state.fromGroup.getReferenceType,
                referenceId: state.fromGroup.groupId,
              )
            : await _localStorageCubit.editLocalEntry(
                editedEntry: editedEntry,
                isEdit: true,
                secrets: secrets,
              ) as Entry; // * This is used to indicate that this method will not return null (shouldRethrow == true).

        return updatedEntry;
      });

      // Update dependent cubits.
      if (_localGroupSelectedSheetCubit != null) {
        await _localGroupSelectedSheetCubit.onEntryEdited(editedEntry: result);
      }

      // Notify dependent cubits.
      if (_viewEntriesSheetCubit != null) {
        await _viewEntriesSheetCubit.onEntryEdited(editedEntry: result);
      }

      // Update dependent cubits.
      await _mainScreenCubit.onEntryEdited(editedEntry: result);

      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Revert state, update state entry.
      emit(state.copyWith(
        entry: result,
        status: EntrySelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> quickNumberAction() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> quickNumberAction() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to delete a shared entry.
  Future<void> confirmDeleteSharedEntry({required BuildContext context}) async {
    try {
      // Make sure user is allowed to delete this entry.
      final bool userHasDeletePermission = state.fromGroup.userHasEntryDeletePermissions(
        isShared: state.isShared,
        topLevelGroupOwner: state.topLevelGroup.groupCreator,
        entryCreator: state.entry.entryCreator,
      );

      // User does not have delete permission.
      if (userHasDeletePermission == false) throw Failure.entryDeleteNotAllowed();

      // * Show a confirm indication.
      final bool? confirm = await showModalBottomSheet(
        context: context,
        builder: (context) => ConfirmSheet(
          title: labels.entrySelectedSheetConfirmDeleteTitle(),
          subtitle: labels.entrySelectedSheetConfirmDeleteSubtitle(),
        ),
      );

      // * User canceled.
      if (confirm != true) return;

      await _localStorageCubit.state.database!.writeTxn(() async {
        // Emit loading state.
        emit(state.copyWith(
          failure: Failure.initial(),
          status: EntrySelectedSheetStatus.pageIsLoading,
        ));

        // Access all pending notifications of entry
        final List<PendingNotificationRequest> entryNotifications = state.getPendingNotificationsOfEntry(
          entryId: state.entry.entryId,
        );

        // Go through notifications and delete them.
        for (final PendingNotificationRequest request in entryNotifications) {
          await deleteNotification(notification: request);
        }

        // Delete recent entry reference.
        await _localStorageCubit.deleteLocalRecentEntry(
          entry: state.entry,
        );

        // Delete shared entry.
        await _localStorageCubit.deleteSharedEntry(
          entry: state.entry,
          rootGroupReference: state.fromGroup.rootGroupReference,
          referenceType: state.fromGroup.getReferenceType,
          referenceId: state.fromGroup.groupId,
        );

        // * Update dependent cubits.
        if (_sharedGroupSelectedSheetCubit != null) {
          await _sharedGroupSelectedSheetCubit.onEntryDeleted(entry: state.entry);
        }

        // * Let main screen know.
        _mainScreenCubit.onEntryDeleted(entryId: state.entry.entryId);

        // Only emit state if cubit is open.
        if (isClosed) return;

        // Emit closing state.
        emit(state.copyWith(
          status: EntrySelectedSheetStatus.close,
        ));

        // Display notification.
        _appMessagesCubit.showNotification(
          message: labels.entrySelectedSheetEntryDeletedNotification(),
        );
      });
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmDeleteSharedEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmDeleteSharedEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to delete a local entry.
  Future<void> confirmDeleteLocalEntry({required BuildContext context}) async {
    try {
      // * Show a confirm indication.
      final bool? confirm = await showModalBottomSheet(
        context: context,
        builder: (context) => ConfirmSheet(
          title: labels.entrySelectedSheetConfirmDeleteTitle(),
          subtitle: labels.entrySelectedSheetConfirmDeleteSubtitle(),
        ),
      );

      // * User canceled.
      if (confirm != true || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: EntrySelectedSheetStatus.pageIsLoading,
      ));

      // Access all pending notifications of entry
      final List<PendingNotificationRequest> entryNotifications = state.getPendingNotificationsOfEntry(
        entryId: state.entry.entryId,
      );

      // Go through notifications and delete them.
      for (final PendingNotificationRequest request in entryNotifications) {
        await deleteNotification(notification: request);
      }

      // Get groups that this entry is associated with.
      final Groups groups = await _localStorageCubit.getLocalGroupsOfEntry(
        entry: state.entry,
      );

      // Delete all files of this entry.
      await _localStorageCubit.deleteAllLocalFilesOfEntry(
        entry: state.entry,
        group: state.fromGroup,
      );

      // Perform delete.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Go through groups and remove entry from reference.
        for (final Group group in groups.items) {
          // Delete group to entry reference.
          await _localStorageCubit.deleteLocalGroupToEntryReference(
            group: group,
            entry: state.entry,
          );
        }

        // Delete recent entry reference.
        await _localStorageCubit.deleteLocalRecentEntry(
          entry: state.entry,
        );

        // Delete entry offline.
        await _localStorageCubit.deleteLocalEntry(
          entry: state.entry,
        );
      });

      // Update dependent cubits.
      if (_localGroupSelectedSheetCubit != null) {
        await _localGroupSelectedSheetCubit.onEntryDeleted(entryId: state.entry.entryId);
      }

      // Notify dependent cubits.
      if (_viewEntriesSheetCubit != null) {
        await _viewEntriesSheetCubit.onEntryDeleted(entry: state.entry);
      }

      // Update dependent cubits.
      await _mainScreenCubit.onEntryDeleted(entryId: state.entry.entryId);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit closing state.
      emit(state.copyWith(
        status: EntrySelectedSheetStatus.close,
      ));

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.entrySelectedSheetEntryDeletedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmDeleteEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmDeleteEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user wants to remove an entry from this local group.
  Future<void> confirmRemoveEntryFromLocalGroup({required BuildContext context}) async {
    try {
      // Do not trigger this function if state is already loading.
      if (state.status == EntrySelectedSheetStatus.loading) return;

      await _localStorageCubit.state.database!.writeTxn(() async {
        // * Prompt user with confirm sheet.
        final bool confirm = await showModalBottomSheet(
              context: context,
              builder: (context) => ConfirmSheet(
                title: labels.entrySelectedSheetCubitConfirmRemoveFromGroup(),
              ),
            ) ??
            false;

        // * User dismissed, or cubit was closed.
        if (confirm == false || isClosed) return;

        // Emit loading state.
        emit(state.copyWith(
          failure: Failure.initial(),
          status: EntrySelectedSheetStatus.loading,
        ));

        // Access groups to check if entry is tagged with at least one other group.
        final Groups entryGroups = await _localStorageCubit.getLocalGroupsOfEntry(
          entry: state.entry,
        );

        // Entry can only be deleted from group if entry is at least tagged with one other group.
        if (entryGroups.items.length == 1) throw Failure.currentGroupIsRequired();

        // Remove Group to Entry reference.
        await _localStorageCubit.deleteLocalGroupToEntryReference(
          group: state.fromGroup,
          entry: state.entry,
        );

        // Update dependent cubits.
        if (_localGroupSelectedSheetCubit != null) {
          await _localGroupSelectedSheetCubit.onEntryDeleted(entryId: state.entry.entryId);
        }

        // Notify dependent cubits.
        if (_viewEntriesSheetCubit != null) {
          await _viewEntriesSheetCubit.onEntryDeleted(entry: state.entry);
        }

        // Update dependent cubits.
        await _mainScreenCubit.onEntryDeleted(entryId: state.entry.entryId);

        // Only emit state if cubit is open.
        if (isClosed) return;

        // Emit closing state
        emit(state.copyWith(
          status: EntrySelectedSheetStatus.close,
        ));

        // Display anotification.
        _appMessagesCubit.showNotification(
          message: labels.entrySelectedSheetCubitRemovedFromGroup(),
        );
      });
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> removeFromLocalGroup() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> removeFromLocalGroup() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to confirm ban a user.
  /// * Currently always bans from root group and subsequently from all subgroups.
  Future<void> confirmBanUserFromGroup({required BuildContext context}) async {
    try {
      // * Show a confirm indication.
      final bool? confirm = await showModalBottomSheet(
        context: context,
        builder: (context) => ConfirmSheet(
          title: labels.entrySelectedSheetConfirmBanUser(),
          subtitle: labels.entrySelectedSheetConfirmBanUserInfo(),
        ),
      );

      // * User canceled.
      if (confirm != true || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: EntrySelectedSheetStatus.pageIsLoading,
      ));

      // Ban user from group.
      await _localStorageCubit.banUserFromSharedGroup(
        bannedUserId: state.entry.entryCreator,
        rootGroupReference: state.topLevelGroup.groupId,
        // ! Attention: currently always bans from root group.
        groupId: state.topLevelGroup.groupId,
      );

      // * Only emit states if cubit is open.
      if (isClosed) return;

      // Reset state.
      emit(state.copyWith(
        entryCreatorIsBanned: true,
        failure: Failure.initial(),
        status: EntrySelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmBanUserFromGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmBanUserFromGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to confirm revoke a ban.
  /// * Currently always revokes bans from root group and subsequently from all subgroups.
  Future<void> confirmRevokeBan({required BuildContext context}) async {
    try {
      // * Show a confirm indication.
      final bool? confirm = await showModalBottomSheet(
        context: context,
        builder: (context) => ConfirmSheet(
          title: labels.entrySelectedSheetConfirmRevokeBanUser(),
          subtitle: labels.entrySelectedSheetConfirmRevokeBanUserInfo(),
        ),
      );

      // * User canceled.
      if (confirm != true || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: EntrySelectedSheetStatus.pageIsLoading,
      ));

      // revoke ban from group.
      await _localStorageCubit.revokeBanFromSharedGroup(
        bannedUserId: state.entry.entryCreator,
        rootGroupReference: state.topLevelGroup.groupId,
        // ! Attention: currently always bans from root group.
        groupId: state.topLevelGroup.groupId,
      );

      // * Only emit states if cubit is open.
      if (isClosed) return;

      // Reset state.
      emit(state.copyWith(
        entryCreatorIsBanned: false,
        failure: Failure.initial(),
        status: EntrySelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmRevokeBan() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> confirmRevokeBan() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be called if user tabs on an image.
  void onTabFile({required BuildContext context, required Files files, required int index, required bool isFiles}) {
    try {
      // Show preview of offer.
      Navigator.of(context).pushNamed(
        ViewFilesPage.routeName,
        arguments: ViewFilesPageArguments(
          files: files,
          initialPage: index,
          isFiles: isFiles,
          fromEntry: state.entry,
          fromGroup: state.fromGroup,
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> onTabFile() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> onTabFile() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if a local notifications reload was requested.
  Future<void> reloadLocalNotifications() async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state to loading.
      emit(state.copyWith(
        loadNotificationsFailure: Failure.initial(),
        loadNotificationsStatus: LoadNotificationsStatus.loading,
      ));

      // Access currently pending notifications and store them into state.
      final List<PendingNotificationRequest> pendingNotifications = await state.notificationsPlugin!.pendingNotificationRequests();

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Revert state.
      emit(state.copyWith(
        pendingNotifications: pendingNotifications,
        loadNotificationsStatus: LoadNotificationsStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> reloadLocalNotifications() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        loadNotificationsFailure: failure,
        loadNotificationsStatus: LoadNotificationsStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> reloadLocalNotifications() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        loadNotificationsFailure: Failure.genericError(),
        loadNotificationsStatus: LoadNotificationsStatus.failure,
      ));
    }
  }

  /// This method can be used to set a notification.
  Future<void> setNotification({required BuildContext context}) async {
    try {
      // * Make sure a valid field was set, this should never happen.
      if (state.notificationField == null) throw Failure.genericError();

      // * Show LocalNotificationSheet.
      final bool? notificationSet = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => BlocProvider<LocalNotificationCubit>(
          create: (context) => LocalNotificationCubit(
            localNotificationsRepository: context.read<LocalNotificationsRepository>(),
            appMessagesCubit: _appMessagesCubit,
          )..initializeWithEntry(
              group: state.fromGroup,
              entry: state.entry,
              field: state.notificationField!,
            ),
          child: const LocalNotificationSheet(),
        ),
      );

      // If no notification was set, simply revert state.
      if (notificationSet == false) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Revert state.
        emit(state.copyWith(
          status: EntrySelectedSheetStatus.waiting,
        ));

        return;
      }

      // * User set a notification and pending notifications need to be relaoded.

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Revert state.
      emit(state.copyWith(
        status: EntrySelectedSheetStatus.waiting,
        loadNotificationsStatus: LoadNotificationsStatus.reloadPendingNotifications,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> setNotification() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> setNotification() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to view the details of a notification.
  void onNotificationSelected({required BuildContext context, required PendingNotificationRequest notification, required int index}) {
    // Do not do anything if status is loading or cubit is closed.
    if (state.status == EntrySelectedSheetStatus.loading || isClosed) return;

    // Emit failure if payload is not accessible.
    if (notification.payload == null || notification.payload!.isEmpty) {
      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.notificationPayloadIsInvalid(),
        status: EntrySelectedSheetStatus.failure,
      ));

      return;
    }

    // * Show EntrySelectedSheet.
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isDismissible: true,
      builder: (context) => LocalNotificationDetailsSheet(
        notification: notification,
      ),
    );
  }

  /// This method can be used to delete an individual notification.
  Future<void> deleteNotification({BuildContext? context, required PendingNotificationRequest notification, int? index}) async {
    try {
      // Do not do anything if status is loading or cubit is closed.
      if (state.status == EntrySelectedSheetStatus.loading || isClosed) return;

      // Show a confirm dialog if context is present.
      if (context != null) {
        // * Show a confirm indication.
        final bool? confirm = await showModalBottomSheet(
          context: context,
          builder: (context) => ConfirmSheet(
            title: labels.entrySelectedSheetConfirmDeleteNotification(),
          ),
        );

        // * User canceled.
        if (confirm != true) return;
      }

      // * Emit a loading status sheet wide.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: EntrySelectedSheetStatus.loading,
      ));

      // Make sure plugin was initialized.
      if (state.notificationsPlugin == null) {
        throw Failure.failedToInitNotificationPlugin();
      }

      // Delete the notification.
      await _localNotificationsRepository.deleteNotification(
        notificationsPlugin: state.notificationsPlugin!,
        id: notification.id,
      );

      // Remove notification from state.
      final List<PendingNotificationRequest> removedRequests = state.removeNotification(
        id: notification.id,
      );

      // * Reset state.
      emit(state.copyWith(
        pendingNotifications: removedRequests,
        status: EntrySelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> deleteNotification() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> deleteNotification() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to access the exchange rate of a expense.
  /// * Returns ```null``` on error.
  Future<Map<String, dynamic>> getExchangeRate({required DateTime exchangeRateDateInUtc, required String fromCurrencyCode, required String toCurrencyCode, required ExchangeRates customExchangeRates}) async {
    // * This await is here for better UX because otherwise if user presses try again no loading indication might be shown.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    // Access exchange rate.
    final Map<String, dynamic> exchangeRateMap = await _localStorageCubit.getExchangeRate(
      customExchangeRates: customExchangeRates,
      exchangeRateDateInUtc: exchangeRateDateInUtc,
      fromCurrencyCode: fromCurrencyCode,
      toCurrencyCode: toCurrencyCode,
    );

    return exchangeRateMap;
  }

  /// This method will be triggerd if user wants to set a custom exchange rate.
  Future<void> onSetCustomExchangeRate({required String fromCurrencyCode, required String toCurrencyCode, required ExchangeRates customExchangeRates, required Field field, required BuildContext context}) async {
    try {
      // Find relevant exchange rate.
      final ExchangeRate? initial = customExchangeRates.findMatchingExchangeRate(
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
      );

      // Show text sheet.
      // * Let user authenticate.
      final String? customExchangeRateValue = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => TextFieldSheet(
          textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
          title: labels.basicLabelsExchangeRate(),
          initialValue: initial?.exchangeRate.toString() ?? '',
          autocorrect: false,
        ),
      );

      // * User cancled.
      if (customExchangeRateValue == null || customExchangeRateValue.isEmpty) return;

      // Try and parse to default number data.
      final String converted = NumberData.convertToDefaultNumberFormat(value: customExchangeRateValue);

      // Check value.
      final bool isValidNumber = NumberData.numberValidator(input: converted);

      // * Invalid number discovered.
      if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: '');

      // Ensure that value is not to big.
      final bool tooManyChars = NumberData.tooManyNumberCharacters(input: converted);

      // Raise error.
      if (tooManyChars) throw Failure.numberHasTooManyCharacters();

      // Convert to double.
      final double asDouble = double.parse(converted);

      // * Must be greater zero.
      if (asDouble <= 0) throw Failure.customExchangeRateMustBeGreaterZero();

      // Create updated CustomExchangeRate.
      final ExchangeRate customExchangeRateObject = ExchangeRate.initial().copyWith(
        exchangeRateDateInUtc: DateTime.now().toUtc(),
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
        exchangeRate: asDouble,
      );

      // Set ExchangeRates object.
      final ExchangeRates? setExchangeRatesMoneyData = field.moneyData?.customExchangeRates.set(
        exchangeRate: customExchangeRateObject,
      );

      // Create updated money data.
      final MoneyData? updatedMoneyData = field.moneyData?.copyWith(
        customExchangeRates: setExchangeRatesMoneyData,
      );

      // Set ExchangeRates object.
      final ExchangeRates? setExchangeRatesPaymentData = field.paymentData?.customExchangeRates.set(
        exchangeRate: customExchangeRateObject,
      );

      // Create updated payment data.
      final PaymentData? updatedPaymentData = field.paymentData?.copyWith(
        customExchangeRates: setExchangeRatesPaymentData,
      );

      // Access the field.
      final Field updatedField = field.copyWith(
        moneyData: field.getIsMoneyField ? updatedMoneyData : null,
        paymentData: field.getIsPaymentField ? updatedPaymentData : null,
      );

      // Update Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Update Entry.
      final Entry editedEntry = state.entry.copyWith(
        fields: fields,
      );

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      final Entry result = await _localStorageCubit.state.database!.writeTxn(() async {
        // Add entry to local storage.
        final Entry updatedEntry = state.isShared
            ? await _localStorageCubit.editSharedEntry(
                entry: editedEntry,
                rootGroupReference: state.fromGroup.rootGroupReference,
                referenceType: state.fromGroup.getReferenceType,
                referenceId: state.fromGroup.groupId,
              )
            : await _localStorageCubit.editLocalEntry(
                editedEntry: editedEntry,
                isEdit: true,
                secrets: secrets,
              ) as Entry; // * This is used to indicate that this method will not return null (shouldRethrow == true).

        return updatedEntry;
      });

      // Update dependent cubits.
      if (_localGroupSelectedSheetCubit != null) {
        await _localGroupSelectedSheetCubit.onEntryEdited(editedEntry: result);
      }

      // Notify dependent cubits.
      if (_viewEntriesSheetCubit != null) {
        await _viewEntriesSheetCubit.onEntryEdited(editedEntry: result);
      }

      // Update dependent cubits.
      await _mainScreenCubit.onEntryEdited(editedEntry: result);

      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Revert state, update state entry.
      emit(state.copyWith(
        entry: result,
        status: EntrySelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> onSetCustomExchangeRate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> onSetCustomExchangeRate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to share files.
  Future<void> shareFile({required FileItem fileItem, required bool isFile}) async {
    try {
      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySelectedSheetStatus.loading,
        loadingMessage: state.fromGroup.isEncrypted ? labels.decryptingFile() : '',
      ));

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access file path of file.
      final String filePath = await _localStorageCubit.createLocalFilePath(
        groupId: state.fromGroup.groupId,
        relativePath: fileItem.relativePath,
      );

      // Sanitize name.
      String sanitizedName = fileItem.title.replaceAll(' ', '_').replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');

      // Ensure that name is not empty.
      if (sanitizedName.isEmpty) {
        if (isFile) sanitizedName = labels.basicLabelsFile();
        if (isFile == false) sanitizedName = labels.basicLabelsImage();
      }

      // Read the bytes from local storage.
      final Uint8List? bytes = await _localStorageCubit.getLocalFileBytes(
        filePath: filePath,
        secrets: secrets,
        isEncrypted: state.fromGroup.isEncrypted,
      );

      // Ensure that bytes were accessed.
      if (bytes == null) throw Failure.genericError();

      // Create a temporary directory and file path.
      final String tempDir = Directory.systemTemp.path;
      final String tempFilePath = path.join(tempDir, '$sanitizedName.${fileItem.type}');

      // Write the bytes to a temporary file.
      final File tempFile = File(tempFilePath);

      // Populate temp file.
      await tempFile.writeAsBytes(bytes);

      // Share the file from the temporary path.
      final XFile xfile = XFile(tempFile.path);

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
        status: EntrySelectedSheetStatus.waiting,
        loadingMessage: '',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> shareFile() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        loadingMessage: '',
        failure: failure,
        status: EntrySelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedSheetCubit --> shareFile() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        loadingMessage: '',
        failure: Failure.genericError(),
        status: EntrySelectedSheetStatus.failure,
      ));
    }
  }

  // ##########################################################
  // Used from other cubits.
  // ##########################################################

  /// This method will be triggered if user successfully edited an entry.
  Future<void> onEntryEdited({required Entry editedEntry}) async {
    // Only emit state if cubit is open.
    if (isClosed) return;

    // Revert state, update entry.
    emit(state.copyWith(
      entry: editedEntry,
    ));
  }

  /// This method will be triggerd if user edited a model entry.
  Future<void> onModelEntryEdited({required ModelEntry modelEntry}) async {
    // Make sure cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entryModel: modelEntry,
    ));
  }

  /// This method will be triggerd if user deleted a entry.
  Future<void> onEntryDeleted({required Entry entry}) async {
    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove entry from state.
    emit(state.copyWith(
      status: EntrySelectedSheetStatus.close,
    ));
  }
}
