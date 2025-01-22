import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// User with Settings and Labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Repositories.
import '/data/repositories/location/location_repository.dart';
import '/data/repositories/local_notifications/local_notifications_repository.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/entries/entry.dart';
import '/data/models/entries/entries.dart';
import '/data/models/fields/field.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/group_prefs/group_prefs.dart';
import '/data/models/cloud_user/cloud_user.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';
import '/pages/entry_selected_page/cubit/entry_selected_page_cubit.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/cubit/charts_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_decision_sheet/cubit/entry_decision_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/create_group_sheet/cubit/create_group_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/cubit/entry_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/search_sheet/cubit/search_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/display_group_invite_info_sheet/cubit/display_group_invite_info_sheet_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';

// Pages.
import '/pages/entry_selected_page/entry_selected_page.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/create_group_sheet/create_group_sheet.dart';
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/shared_group_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_decision_sheet/entry_decision_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/entry_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/entry_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/search_sheet/search_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/display_message_sheet/display_message_sheet.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/charts_sheet.dart';
import '/widgets/modal_bottom_sheets/display_group_invite_info_sheet/display_group_invite_info_sheet.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/local_notification_sheet.dart';

part 'shared_group_selected_sheet_state.dart';

class SharedGroupSelectedSheetCubit extends Cubit<SharedGroupSelectedSheetState> with HelperFunctions {
  final LocalNotificationsRepository _localNotificationsRepository;
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;
  final MainScreenCubit _mainScreenCubit;

  SharedGroupSelectedSheetCubit({
    required LocalNotificationsRepository localNotificationsRepository,
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
    required MainScreenCubit mainScreenCubit,
  })  : _localNotificationsRepository = localNotificationsRepository,
        _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        _mainScreenCubit = mainScreenCubit,
        super(SharedGroupSelectedSheetState.initial());

  // ############################################
  // # Initialization.
  // ############################################

  /// Initialize a top level group.
  Future<void> initializeGroup({required Group initialGroup}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access desired group.
      final Group group = await _localStorageCubit.getSharedGroupById(
        groupId: initialGroup.groupId,
      );

      // Access all subgroups of this group.
      // * In this case reference id and topLevelGroupId are equal because it is a top level group.
      final Groups subgroups = await _localStorageCubit.getSharedSubgroupsOfGroup(
        rootGroupReference: group.groupId,
        groupId: group.groupId,
      );

      // Access modelEntriesRestriction.
      // * Returns ModelEntries.initial() if references are empty.
      ModelEntries commonModelEntries = await _localStorageCubit.getSharedCommonModelEntries(
        rootGroupReference: group.groupId,
        references: group.commonModelEntries,
        referenceId: group.groupId,
      );

      // Access quick add model entry.
      ModelEntry? quickAddModelEntry = await _localStorageCubit.getSharedModelEntryById(
        rootGroupReference: group.groupId,
        modelEntryId: group.groupPrefs.quickAddReference,
        referenceType: group.getReferenceType,
        referenceId: group.groupId,
      );

      // * Ensure that quick add model entry is allowed.
      if (group.isRestrictedToCommon && quickAddModelEntry != null) {
        final ModelEntry? modelEntry = commonModelEntries.getById(
          id: quickAddModelEntry.modelEntryId,
        );

        // Quick add model entry is invalid. Set it to null to inform user whenever it is used.
        if (modelEntry == null) quickAddModelEntry = null;
      }

      // Access relevant entries.
      final Entries entries = await _localStorageCubit.getSharedEntriesOfSharedGroup(
        rootGroupReference: group.groupId,
        referenceType: group.getReferenceType,
        referenceId: group.groupId,
        offset: 0,
        limit: state.entriesLimit,
      );

      // Access relevant model entries.
      // * Returns a ModelEntries.initial() if entries.isEmpty.
      final ModelEntries modelEntries = await _localStorageCubit.getSharedModelEntriesOfSharedEntries(
        rootGroupReference: group.groupId,
        referenceId: group.groupId,
        referenceType: group.getReferenceType,
        entries: entries,
      );

      // Users can add their own ModelEntries.
      if (group.isRestrictedToCommon == false) {
        // Self user model entries.
        final ModelEntries selfModelEntries = await _mainScreenCubit.state.modelEntries.getCreatedByCurrentUser;

        // Update common model entries.
        commonModelEntries = await commonModelEntries.addUniqueModelEntries(
          modelEntries: selfModelEntries,
        );
      }

      // Check if all entries have been accessed.
      final bool isFinished = entries.items.length < state.entriesLimit;

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        topLevelGroupOwner: group.groupCreator,
        group: group,
        subgroups: subgroups,
        commonModelEntries: commonModelEntries,
        quickAddModelEntry: quickAddModelEntry,
        entriesOffset: entries.items.length,
        entries: entries,
        isFinished: isFinished,
        modelEntries: modelEntries,
        status: SharedGroupSelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> initializeGroup() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: SharedGroupSelectedSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> initializeGroup() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize a subgroup.
  Future<void> initializeSubgroup({required Group initialGroup, required String topLevelGroupOwner}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access desired group.
      final Group subgroup = await _localStorageCubit.getSharedSubgroupById(
        rootGroupReference: initialGroup.rootGroupReference,
        subgroupId: initialGroup.groupId,
      );

      // Access all subgroups of this group.
      final Groups subgroups = await _localStorageCubit.getSharedSubgroupsOfGroup(
        rootGroupReference: subgroup.rootGroupReference,
        groupId: subgroup.groupId,
      );

      // Access common ModelEntries.
      // * Returns ModelEntries.initial() if references are empty.
      ModelEntries commonModelEntries = await _localStorageCubit.getSharedCommonModelEntries(
        rootGroupReference: subgroup.rootGroupReference,
        references: subgroup.commonModelEntries,
        referenceId: subgroup.groupId,
      );

      // Access quick add model entry.
      ModelEntry? quickAddModelEntry = await _localStorageCubit.getSharedModelEntryById(
        rootGroupReference: subgroup.rootGroupReference,
        modelEntryId: subgroup.groupPrefs.quickAddReference,
        referenceType: subgroup.getReferenceType,
        referenceId: subgroup.groupId,
      );

      // * Ensure that quick add model entry is allowed.
      if (subgroup.isRestrictedToCommon && quickAddModelEntry != null) {
        final ModelEntry? modelEntry = commonModelEntries.getById(
          id: quickAddModelEntry.modelEntryId,
        );

        // Quick add model entry is invalid. Set it to null to inform user whenever it is used.
        if (modelEntry == null) quickAddModelEntry = null;
      }

      // Access relevant entries.
      final Entries entries = await _localStorageCubit.getSharedEntriesOfSharedGroup(
        rootGroupReference: subgroup.rootGroupReference,
        referenceType: subgroup.getReferenceType,
        referenceId: subgroup.groupId,
        offset: 0,
        limit: state.entriesLimit,
      );

      // Access relevant model entries.
      // * Returns a ModelEntries.initial() if entries.isEmpty.
      final ModelEntries modelEntries = await _localStorageCubit.getSharedModelEntriesOfSharedEntries(
        rootGroupReference: subgroup.rootGroupReference,
        referenceId: subgroup.groupId,
        referenceType: subgroup.getReferenceType,
        entries: entries,
      );

      // Users can add their own ModelEntries.
      if (subgroup.isRestrictedToCommon == false) {
        // Self user model entries.
        final ModelEntries selfModelEntries = await _mainScreenCubit.state.modelEntries.getCreatedByCurrentUser;

        // Update common model entries.
        commonModelEntries = await commonModelEntries.addUniqueModelEntries(
          modelEntries: selfModelEntries,
        );
      }

      // Check if all entries have been accessed.
      final bool isFinished = entries.items.length < state.entriesLimit;

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        topLevelGroupOwner: topLevelGroupOwner,
        entries: entries,
        entriesOffset: entries.items.length,
        commonModelEntries: commonModelEntries,
        modelEntries: modelEntries,
        group: subgroup,
        subgroups: subgroups,
        isFinished: isFinished,
        quickAddModelEntry: quickAddModelEntry,
        status: SharedGroupSelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> initializeSubgroup() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: SharedGroupSelectedSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> initializeSubgroup() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State.
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: SharedGroupSelectedSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: SharedGroupSelectedSheetStatus.close,
    ));
  }

  /// This method can be used to give user a choice of what to add.
  Future<void> showSelectOptionSheet({required BuildContext context}) async {
    try {
      // * Add permissions alway get checked in the currently selected group because adds are about
      // * subsequent entries.
      final bool userHasEntryAddPermission = state.group.userHasEntryAddPermissions(
        isShared: true,
        topLevelGroupOwner: state.topLevelGroupOwner,
      );

      // * Add permissions alway get checked in the currently selected group because adds are about
      // * subsequent subgroups.
      final bool userHasSubgroupAddPermission = state.group.userHasSubgroupAddPermissions(
        isShared: true,
        topLevelGroupOwner: state.topLevelGroupOwner,
      );

      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          optionOne: userHasEntryAddPermission ? labels.groupSelectedSheetCubitOptionNewEntry() : null,
          optionOneIcon: userHasEntryAddPermission ? AppIcons.edit : null,
          optionTwo: userHasSubgroupAddPermission ? labels.groupSelectedSheetCubitOptionSubgroup() : null,
          optionTwoIcon: userHasSubgroupAddPermission ? AppIcons.groups : null,
        ),
      );

      // * User cancelled.
      if (option == null) return;

      // Let user know that group is locked.
      if (state.group.isLocked) throw Failure.groupIsLocked();

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'SharedGroupSelectedSheetCubit', sourceMethod: 'showSelectOptionSheet()');

      // * User selected first option, which in this case is: add new shared entry
      if (option == 1) {
        // * Show EntryDecisionSheet.
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (_) => BlocProvider<EntryDecisionSheetCubit>(
            create: (context) => EntryDecisionSheetCubit(
              localStorageCubit: _localStorageCubit,
              sharedGroupSelectedSheetCubit: this,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
            )..initializeShared(
                fromGroup: state.group,
              ),
            child: const EntryDecisionSheet(),
          ),
        );

        return;
      }

      // * User selected third option, which in this case is: add shared subgroup
      if (option == 2) {
        // Let user create a new shared sub group.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<CreateGroupSheetCubit>(
            create: (context) => CreateGroupSheetCubit(
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              sharedGroupSelectedSheetCubit: this,
            )..initializeSharedCreate(
                groupType: Group.groupTypeSharedSub,
                rootGroupCreator: state.topLevelGroupOwner,
                rootGroupReference: state.group.rootGroupReference,
                parentGroupReference: state.group.groupId,
              ),
            child: const CreateGroupSheet(
              // * These are all 0 because a new subgroup gets created.
              initialGroupEditPolicyItem: 0,
              initialGroupDeletePolicyItem: 0,
              initialEntryAddPolicyItem: 0,
              initialEntryEditPolicyItem: 0,
              initialEntryDeletePolicyItem: 0,
              initialSubgroupAddPolicyItem: 0,
            ),
          ),
        );

        return;
      }
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('SharedGroupSelectedSheetCubit --> showSelectOptionSheet() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('SharedGroupSelectedSheetCubit --> showSelectOptionSheet() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user long pressed the add button.
  Future<void> onQuickAddAction({required BuildContext context}) async {
    try {
      // Make sure a quick add reference was accessed.
      if (state.quickAddModelEntry == null) {
        // Model Entry was deleted.
        if (state.group.groupPrefs.quickAddReference.isNotEmpty) throw Failure.quickAddReferenceDeleted();

        throw Failure.invalidQuickAddReference();
      }

      // Make sure only user with correct permissions can add entries.
      final bool canAddEntries = state.group.userHasEntryAddPermissions(
        isShared: true,
        topLevelGroupOwner: state.topLevelGroupOwner,
      );

      // This user does not have necessary permissions to add entries.
      if (canAddEntries == false) throw Failure.entryAddProhibited();

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
          create: (context) => EntrySheetCubit(
            locationRepository: context.read<LocationRepository>(),
            localNotificationsCubit: localNotificationCubit,
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            sharedGroupSelectedSheetCubit: this,
          )..initializeSharedCreate(
              fromGroup: state.group,
              modelEntry: state.quickAddModelEntry!,
            ),
          child: const EntrySheet(),
        ),
      );

      // * Close cubit after useing it.
      localNotificationCubit.close();
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('SharedGroupSelectedSheetCubit --> onQuickAddAction() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('SharedGroupSelectedSheetCubit --> onQuickAddAction() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to copy a value to clipboard.
  Future<void> copyToClipboard({required BuildContext context, required Entry entry, required ModelEntry entryModel}) async {
    try {
      // Check if copyableFieldId has been set.
      if (entryModel.modelEntryPrefs.copyFieldId.isEmpty) throw Failure.copyFieldNotSet();

      // Access index of copy field.
      final int index = entry.fields.items.indexWhere(
        (element) => element.fieldId == entryModel.modelEntryPrefs.copyFieldId,
      );

      // * In this case field which has been set as copy field was deleted.
      if (index == -1) throw Failure.failureCopyFieldDoesNotExist();

      // Access copy field.
      final Field field = entry.fields.items[index];

      // Access field identification.
      final FieldIdentification fieldIdentification = entryModel.fieldIdentifications.items.firstWhere(
        (element) => element.fieldId == entryModel.modelEntryPrefs.copyFieldId,
        orElse: () => throw Failure.failureCopyFieldDoesNotExist(),
      );

      // Access copy value of field.
      final String? copyValue = field.getCopyValue;

      // * In this case field might have been deleted or set to empty.
      if (copyValue == null) throw Failure.copyValueEmpty();

      // Set data to clipboard.
      await Clipboard.setData(ClipboardData(text: copyValue));

      // Update recent items. Do not await for smoother UI ex.
      _localStorageCubit.putSharedRecentEntry(
        entryId: entry.entryId,
        groupReference: state.group.groupId,
      );

      // Let main screen know.
      _mainScreenCubit.onEntryInteracted(
        entry: entry,
        modelEntry: entryModel,
        fromGroup: state.group,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Revert state.
      emit(state.copyWith(
        status: SharedGroupSelectedSheetStatus.waiting,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.groupSelectedSheetCubitCopyField(label: fieldIdentification.label),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> copyToClipboard() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> copyToClipboard() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Users.
  // ############################################

  /// This method can be used to access a cloud user.
  Future<CloudUser?> getCloudUser({required String entryCreator}) async {
    try {
      // * Check for self user.
      if (entryCreator == user.userId) return CloudUser.self();

      // * Ensure that loading spinner is shown.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      return await _localStorageCubit.getCloudUserById(userId: entryCreator);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> getCloudUser() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> getCloudUser() --> exception: ${exception.toString()}');

      return null;
    }
  }

  // ############################################
  // # Group.
  // ############################################

  /// This method is triggerd if user wants to view group options.
  Future<void> onGroupOptionsPressed({required BuildContext context}) async {
    // Check if this user is the root group creator.
    final bool isRootGroupCreator = state.topLevelGroupOwner == user.userId;

    // * Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        // * Search in group.
        optionOne: labels.groupSelectedSheetCubitOptionSearchGroup(),
        optionOneIcon: AppIcons.search,
        // * Edit group.
        optionTwo: isRootGroupCreator ? labels.groupSelectedSheetCubitOptionEditGroup() : null,
        optionTwoIcon: isRootGroupCreator ? AppIcons.edit : null,
        // * Delete group.
        optionThree: isRootGroupCreator ? labels.groupSelectedSheetCubitOptionDeleteGroup() : null,
        optionThreeIcon: isRootGroupCreator ? AppIcons.delete : null,
        // * Show display group invite info sheet.
        optionFour: labels.basicLabelsInviteToGroup(),
        optionFourIcon: AppIcons.invite,
        optionFourSuffix: true,
        // * Leave group.
        optionFive: labels.groupSelectedSheetCubitOptionLeaveGroup(),
        optionFiveIcon: AppIcons.leave,
        // * Show group info.
        optionSix: state.group.groupDescription.isNotEmpty ? labels.basicLabelsGroupInfo() : null,
        optionSixIcon: AppIcons.description,
        optionSixSuffix: true,
        // * Set local group notification.
        optionSeven: labels.groupNotifications(),
        optionSevenIcon: AppIcons.notification,
        optionSevenSuffix: true,
        // * Pick quick add value.
        optionEight: labels.groupSelectedSheetCubitOptionPickQuickAddReference(),
        optionEightIcon: AppIcons.entryModels,
        optionEightSuffix: true,
        // * Show Charts.
        optionNine: labels.basicLabelsCharts(),
        optionNineIcon: AppIcons.charts,
        optionNineSuffix: true,
      ),
    );

    // * User cancled.
    if (option == null) return;

    // Make sure used context is still mounted. Output debug message.
    if (!context.mounted) return contextNotMountedHelper(parent: 'SharedGroupSelectedSheetCubit', sourceMethod: 'onGroupOptionsPressed()');

    // * User wants to search in group.
    if (option == 1) searchGroup(context: context);

    // * User wants to edit group.
    if (option == 2) editGroup(context: context);

    // * User wants to delete group.
    if (option == 3) deleteGroup(context: context);

    // * User wants to see group invite info sheet.
    if (option == 4) displayGroupInviteInfoSheet(context: context);

    // * User wants to leave this group.
    if (option == 5) leaveTopLevelGroup(context: context);

    // * User wants to view group info.
    if (option == 6) showGroupInfo(context: context);

    // * User wants set a local notification.
    if (option == 7) showGroupNotificationOptions(context: context);

    // * User wants to pick a quick add value.
    if (option == 8) pickQuickAddReference(context: context);

    // * User wants to view insights.
    if (option == 9) showChartsSheet(context: context);
  }

  /// This method will be triggered if user wanst to search entries of a group.
  Future<void> searchGroup({required BuildContext context}) async {
    // * Show SearchSheet.
    final Entry? entry = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<SearchSheetCubit>(
        create: (context) => SearchSheetCubit(
          localStorageCubit: _localStorageCubit,
          sharedGroupSelectedSheetCubit: this,
        )..initialize(
            isShared: true,
          ),
        child: const SearchSheet(),
      ),
    );

    // User closed the search sheet.
    if (entry == null || isClosed) return;

    // Make sure used context is still mounted. Output debug message.
    if (!context.mounted) return contextNotMountedHelper(parent: 'SharedGroupSelectedSheetCubit', sourceMethod: 'searchGroup()');

    // Display selected entry.
    showEntrySelectedSheet(context: context, entry: entry);
  }

  /// This method will be triggered if user wants to edit a group.
  Future<void> editGroup({required BuildContext context}) async {
    try {
      // Only the group owner can edit a top level group.
      final bool userIsRootGroupCreator = state.topLevelGroupOwner == user.userId;

      // * User does not have edit rights.
      if (userIsRootGroupCreator == false) throw Failure.groupEditPermitted();

      // Access initial group edit policy item.
      final int initialGroupEditPolicyItem = Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.editPolicy) ?? 0;

      // Access initial group delete policy item.
      final int initialGroupDeletePolicyItem = Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.deletePolicy) ?? 0;

      // Access initial subgroup add policy item.
      final int initialSubgroupAddPolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.subgroupAddPolicy) ?? 0;

      // Access initial entry add policy item.
      final int initialEntryAddPolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.entryAddPolicy) ?? 0;

      // Access initial entry edit policy item.
      final int initialEntryEditPolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.entryEditPolicy) ?? 0;

      // Access initial entry delete policy item.
      final int initialEntryDeletePolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.entryDeletePolicy) ?? 0;

      // Let user edit group.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateGroupSheetCubit>(
          create: (context) => CreateGroupSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            sharedGroupSelectedSheetCubit: this,
          )..initializeSharedEdit(
              initialGroup: state.group,
              rootGroupCreator: state.topLevelGroupOwner,
            ),
          child: CreateGroupSheet(
            initialGroupEditPolicyItem: initialGroupEditPolicyItem,
            initialGroupDeletePolicyItem: initialGroupDeletePolicyItem,
            initialEntryAddPolicyItem: initialEntryAddPolicyItem,
            initialEntryEditPolicyItem: initialEntryEditPolicyItem,
            initialEntryDeletePolicyItem: initialEntryDeletePolicyItem,
            initialSubgroupAddPolicyItem: initialSubgroupAddPolicyItem,
          ),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> editGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> editGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to delete a group.
  Future<void> deleteGroup({required BuildContext context}) async {
    try {
      // Make sure this is the correct group type.
      if (state.group.getIsSharedGroupType == false) throw Failure.failureInvalidGroupType();

      // Top level group can only be deleted by the group creator.
      if (state.group.getUserIsGroupCreator == false) throw Failure.groupDeletePermitted();

      // * Prompt user with confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.sharedGroupDeleteGroupTitle(),
              subtitle: labels.sharedGroupDeleteGroupSubtitle(),
            ),
          ) ??
          false;

      // * User dismissed.
      if (confirm == false || isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: SharedGroupSelectedSheetStatus.pageIsLoading,
      ));

      // Init LocalNotificationsCubit.
      final LocalNotificationCubit localNotificationCubit = LocalNotificationCubit(
        localNotificationsRepository: _localNotificationsRepository,
        appMessagesCubit: _appMessagesCubit,
      );

      // Init local notifications cubit.
      await localNotificationCubit.initializeWithGroup(group: state.group);

      // Access notifications.
      final List<PendingNotificationRequest> groupNotifications = localNotificationCubit.state.getAllNotificationsOfGroup;

      // Go through notifications and delete them.
      for (final PendingNotificationRequest request in groupNotifications) {
        // Delete the notification.
        await _localNotificationsRepository.deleteNotification(
          notificationsPlugin: localNotificationCubit.state.notificationsPlugin!,
          id: request.id,
        );
      }

      // Close cubit once it is not needed anymore.
      await localNotificationCubit.close();

      // Delete all files of group.
      // * For example exports.
      await _localStorageCubit.deleteAllLocalFilesOfGroup(group: state.group);

      // Delete group.
      await _localStorageCubit.deleteSharedGroup(
        group: state.group,
      );

      // This is a top level group, let main screen know.
      // * The keyword await is omitted because user should not have to wait in group screen while recent entries
      // * reload in main screen.
      _mainScreenCubit.onSharedGroupDeleted(group: state.group);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit close state.
      emit(state.copyWith(
        status: SharedGroupSelectedSheetStatus.close,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.groupSelectedSheetCubitGroupDeletedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> deleteGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> deleteGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if user wants to view group info.
  Future<void> showGroupInfo({required BuildContext context}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (_) => DisplayMessageSheet(
        title: labels.basicLabelsGroupInfo(),
        message: state.group.groupDescription,
      ),
    );
  }

  /// This method will be triggerd if user wants to copy the invite link to share this shared group with others.
  Future<void> displayGroupInviteInfoSheet({required BuildContext context}) async {
    // * Show EntrySelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<DisplayGroupInviteInfoSheetCubit>(
        create: (context) => DisplayGroupInviteInfoSheetCubit(
          appMessagesCubit: _appMessagesCubit,
        )..initialize(
            group: state.group,
          ),
        child: const DisplayGroupInviteInfoSheet(),
      ),
    );
  }

  /// This method will be triggerd if user wants to add a quick add model entry.
  Future<void> pickQuickAddReference({required BuildContext context}) async {
    try {
      // User has not created a model entry yet.
      if (state.commonModelEntries.items.isEmpty) throw Failure.noModelEntryCreatedYet();

      // Access PickerItems.
      // * CommonModelEntries only ever have the currently allowed ModelEntries set.
      final PickerItems pickerItems = state.commonModelEntries.toPickerItems();

      // Access initial item.
      final int initialItem = pickerItems.items.indexWhere(
        (element) => element.id == state.group.groupPrefs.quickAddReference,
      );

      // Show picker sheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          pickerItems: pickerItems,
          initialItem: initialItem == -1 ? 0 : initialItem,
          staticInfoMessage: labels.groupSelectedSheetQuickAddReferenceInfoMessage(),
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickedIndex];

      // Access picked entry model.
      final ModelEntry quickAddModelEntry = state.commonModelEntries.getById(
        id: pickedItem.id,
      )!;

      // Create updated group prefs.
      final GroupPrefs groupPrefs = state.group.groupPrefs.copyWith(
        quickAddReference: quickAddModelEntry.modelEntryId,
      );

      // Create updated group.
      final Group updatedGroup = state.group.copyWith(
        groupPrefs: groupPrefs,
      );

      // Update local storage.
      await _localStorageCubit.putSelfSharedGroupPrefs(
        groupId: state.group.groupId,
        groupPrefs: groupPrefs,
      );

      // Let dependent states know.
      await _mainScreenCubit.onSharedGroupEdited(group: updatedGroup);

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
        quickAddModelEntry: quickAddModelEntry,
        failure: Failure.initial(),
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.basicLabelsSuccess(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> pickQuickAddReference() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> pickQuickAddReference() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to leave a top level group.
  Future<void> leaveTopLevelGroup({required BuildContext context}) async {
    try {
      // * Prompt user with confirm sheet.
      final bool? confirm = await showModalBottomSheet(
        context: context,
        builder: (context) => ConfirmSheet(
          title: labels.sharedGroupLeaveGroup(),
        ),
      );

      // * User dismissed.
      if (confirm != true || isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: SharedGroupSelectedSheetStatus.pageIsLoading,
      ));

      // Delete all files of group.
      // * For example exports.
      await _localStorageCubit.deleteAllLocalFilesOfGroup(group: state.group);

      // Leave group.
      await _localStorageCubit.leaveSharedGroup(
        group: state.group,
      );

      // Let main screen know.
      _mainScreenCubit.onLeftSharedGroup(group: state.group);

      // * Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: SharedGroupSelectedSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> leaveTopLevelGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> leaveTopLevelGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to show a charts sheet.
  void showChartsSheet({required BuildContext context}) {
    try {
      // If there are no entries, do not show charts.
      // * This is a performance measurement.
      if (state.entries.items.isEmpty) throw Failure.chartFailureEmptyGroup();

      // Push LocalChartsSheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<ChartsSheetCubit>(
          create: (context) => ChartsSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            localGroupSelectedSheetCubit: null,
            sharedGroupSelectedSheetCubit: _sharedGroupSelectedSheetCubit,
          )..initializeShared(
              group: state.group,
              isRefresh: false,
            ),
          child: const ChartsSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> showChartsSheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> showChartsSheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to show group notification options.
  Future<void> showGroupNotificationOptions({required BuildContext context}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Info message.
          infoMessage: labels.notificationsAreOnlyVisibleToYou(),
          // * Set a new group notification.
          optionOne: labels.setNotification(),
          optionOneIcon: AppIcons.edit,
          optionOneSuffix: true,
          // * Delete a notification.
          optionTwo: labels.showNotification(),
          optionTwoIcon: AppIcons.visible,
          optionTwoSuffix: true,
        ),
      );

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'SharedGroupSelectedSheetCubit', sourceMethod: 'showGroupNotificationOptions()');

      // * User wants to set a notification.
      if (option == 1) setLocalGroupNotification(context: context);

      // * User wants to delete a notification
      if (option == 2) deleteLocalGroupNotification(context: context);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> showGroupNotificationOptions() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> showGroupNotificationOptions() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if user wants to set a local group notification.
  /// * Should be used in a try catch block.
  Future<void> setLocalGroupNotification({required BuildContext context}) async {
    // * Show LocalNotificationSheet.
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<LocalNotificationCubit>(
        create: (context) => LocalNotificationCubit(
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          appMessagesCubit: _appMessagesCubit,
        )..initializeWithGroup(
            group: state.group,
          ),
        child: const LocalNotificationSheet(),
      ),
    );
  }

  /// This method will be triggerd if user wants to delete a local group notification.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalGroupNotification({required BuildContext context}) async {
    // * Show LocalNotificationSheet.
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<LocalNotificationCubit>(
        create: (context) => LocalNotificationCubit(
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          appMessagesCubit: _appMessagesCubit,
        )..initializeDelete(
            group: state.group,
          ),
        child: const LocalNotificationSheet(),
      ),
    );
  }

  // ############################################
  // # Subgroups
  // ############################################

  /// This method is triggerd if user wants to view subgroup options.
  Future<void> onSubgroupOptionsPressed({required BuildContext context}) async {
    // Check group edit permission.
    final bool userHasSubgroupEditPermission = state.group.userHasGroupEditPermissions(
      isShared: true,
      topLevelGroupOwner: state.topLevelGroupOwner,
    );

    // Check group delete permission.
    final bool userHasSubgroupDeletePermission = state.group.userHasGroupDeletePermissions(
      isShared: true,
      topLevelGroupOwner: state.topLevelGroupOwner,
    );

    // * Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        // * Search in group.
        optionOne: labels.groupSelectedSheetCubitOptionSearchGroup(),
        optionOneIcon: AppIcons.search,
        // * Edit group.
        optionTwo: userHasSubgroupEditPermission ? labels.groupSelectedSheetCubitOptionEditGroup() : null,
        optionTwoIcon: userHasSubgroupEditPermission ? AppIcons.edit : null,
        // * Delete group.
        optionThree: userHasSubgroupDeletePermission ? labels.groupSelectedSheetCubitOptionDeleteGroup() : null,
        optionThreeIcon: userHasSubgroupDeletePermission ? AppIcons.delete : null,
        // * Show Charts.
        optionFour: labels.basicLabelsCharts(),
        optionFourIcon: AppIcons.charts,
        optionFourSuffix: true,
      ),
    );

    // Make sure used context is still mounted. Output debug message.
    if (!context.mounted) return contextNotMountedHelper(parent: 'SharedGroupSelectedSheetCubit', sourceMethod: 'onSubgroupOptionsPressed()');

    // * User wants to search in subgroup.
    if (option == 1) {
      searchGroup(context: context);
      return;
    }

    // * User wants to edit subgroup.
    if (option == 2) {
      editSubgroup(context: context);
      return;
    }

    // * User wants to delete subgroup.
    if (option == 3) {
      deleteSubgroup(context: context);
      return;
    }

    // * User wants to view charts.
    if (option == 4) showChartsSheet(context: context);
  }

  /// This method will be triggered if user wants to edit a Subgroup.
  Future<void> editSubgroup({required BuildContext context}) async {
    try {
      // Only the group owner can edit a top level group.
      final bool userIsRootGroupCreator = state.topLevelGroupOwner == user.userId;

      // Access initial group edit policy item.
      final int initialGroupEditPolicyItem = Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.editPolicy) ?? 0;

      // Access initial group delete policy item.
      final int initialGroupDeletePolicyItem = Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.deletePolicy) ?? 0;

      // Access initial subgroup add policy item.
      final int initialSubgroupAddPolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.subgroupAddPolicy) ?? 0;

      // Access initial entry add policy item.
      final int initialEntryAddPolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.entryAddPolicy) ?? 0;

      // Access initial entry edit policy item.
      final int initialEntryEditPolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.entryEditPolicy) ?? 0;

      // Access initial entry delete policy item.
      final int initialEntryDeletePolicyItem = Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator).getIndexOfId(id: state.group.entryDeletePolicy) ?? 0;

      // Let user edit subgroup.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateGroupSheetCubit>(
          create: (context) => CreateGroupSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            sharedGroupSelectedSheetCubit: this,
          )..initializeSharedEdit(
              initialGroup: state.group,
              rootGroupCreator: state.topLevelGroupOwner,
            ),
          child: CreateGroupSheet(
            initialGroupEditPolicyItem: initialGroupEditPolicyItem,
            initialGroupDeletePolicyItem: initialGroupDeletePolicyItem,
            initialEntryAddPolicyItem: initialEntryAddPolicyItem,
            initialEntryEditPolicyItem: initialEntryEditPolicyItem,
            initialEntryDeletePolicyItem: initialEntryDeletePolicyItem,
            initialSubgroupAddPolicyItem: initialSubgroupAddPolicyItem,
          ),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> editSubgroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> editSubgroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to delete a subgroup.
  Future<void> deleteSubgroup({required BuildContext context}) async {
    try {
      // * Prompt user with confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.sharedGroupDeleteGroupTitle(),
              subtitle: labels.sharedGroupDeleteGroupSubtitle(),
            ),
          ) ??
          false;

      // * User dismissed or cubit is closed.
      if (confirm == false || isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: SharedGroupSelectedSheetStatus.pageIsLoading,
      ));

      // Delete group.
      await _localStorageCubit.deleteSharedSubgroup(
        group: state.group,
      );

      // Notify dependent cubits.
      await subgroupDeleted(subgroup: state.group);

      // Let main screen know to remove recent entries if needed.
      _mainScreenCubit.onSharedSubgroupDeleted(subgroup: state.group);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit deleted state.
      emit(state.copyWith(
        status: SharedGroupSelectedSheetStatus.close,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.groupSelectedSheetCubitGroupDeletedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> deleteSubgroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> deleteSubgroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to show a group selected sheet.
  Future<void> showSubgroupSelectedSheet({required BuildContext context, required Group group}) async {
    // * Display GroupSelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<SharedGroupSelectedSheetCubit>(
        create: (context) => SharedGroupSelectedSheetCubit(
          localNotificationsRepository: _localNotificationsRepository,
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          sharedGroupSelectedSheetCubit: this,
          mainScreenCubit: _mainScreenCubit,
        )..initializeSubgroup(
            initialGroup: group,
            topLevelGroupOwner: state.topLevelGroupOwner,
          ),
        child: const SharedGroupSelectedSheet(),
      ),
    );
  }

  // ############################################
  // # Refresh page.
  // ############################################

  /// This method can be used to refresh a Subgroup.
  Future<void> refreshSubgroup() async {
    try {
      // * State Entries and ModelEntries are replaced in order to avoid having to
      // * to query for updated, deleted and created items individually. Once user scrolls
      // * down more entries will be loaded again.

      // Do not retrigger if currently is refreshing.
      if (state.status == SharedGroupSelectedSheetStatus.isRefreshing || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: SharedGroupSelectedSheetStatus.isRefreshing,
      ));

      // Access desired group.
      final Group subgroup = await _localStorageCubit.getSharedSubgroupById(
        rootGroupReference: state.group.rootGroupReference,
        subgroupId: state.group.groupId,
      );

      // Access all subgroups of this group.
      final Groups subgroups = await _localStorageCubit.getSharedSubgroupsOfGroup(
        rootGroupReference: subgroup.rootGroupReference,
        groupId: subgroup.groupId,
      );

      // Access quick add model entry.
      final ModelEntry? quickAddModelEntry = await _localStorageCubit.getSharedModelEntryById(
        rootGroupReference: subgroup.rootGroupReference,
        modelEntryId: subgroup.groupPrefs.quickAddReference,
        referenceType: subgroup.getReferenceType,
        referenceId: subgroup.rootGroupReference,
      );

      // Access relevant entries.
      // * In this case offset is 0 because user wants to refresh for new content.
      final Entries entries = await _localStorageCubit.getSharedEntriesOfSharedGroup(
        rootGroupReference: subgroup.rootGroupReference,
        referenceId: subgroup.groupId,
        referenceType: subgroup.getReferenceType,
        offset: 0,
        limit: state.entriesLimit,
      );

      // Access relevant model entries.
      // * Returns a ModelEntries.initial() if entries.isEmpty.
      final ModelEntries modelEntries = await _localStorageCubit.getSharedModelEntriesOfSharedEntries(
        rootGroupReference: subgroup.rootGroupReference,
        referenceId: subgroup.groupId,
        referenceType: subgroup.getReferenceType,
        entries: entries,
      );

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      // Emit state.
      emit(state.copyWith(
        group: subgroup,
        subgroups: subgroups,
        quickAddModelEntry: quickAddModelEntry,
        entriesOffset: entries.items.length,
        entries: entries,
        modelEntries: modelEntries,
        status: SharedGroupSelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> refreshTopLevelGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> refreshTopLevelGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to refresh a group.
  Future<void> refreshTopLevelGroup() async {
    try {
      // * State Entries and ModelEntries are replaced in order to avoid having to
      // * to query for updated, deleted and created items individually. Once user scrolls
      // * down more entries will be loaded again.

      // Do not retrigger if currently is refreshing.
      if (state.status == SharedGroupSelectedSheetStatus.isRefreshing || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: SharedGroupSelectedSheetStatus.isRefreshing,
      ));

      // Access desired group.
      final Group group = await _localStorageCubit.getSharedGroupById(
        groupId: state.group.groupId,
      );

      // Access all subgroups of this group.
      // * In this case reference id and topLevelGroupId are equal because it is a top level group.
      final Groups subgroups = await _localStorageCubit.getSharedSubgroupsOfGroup(
        rootGroupReference: group.groupId,
        groupId: group.groupId,
      );

      // Access common ModelEntries.
      // * Returns ModelEntries.initial() if references are empty.
      ModelEntries commonModelEntries = await _localStorageCubit.getSharedCommonModelEntries(
        rootGroupReference: group.rootGroupReference,
        references: group.commonModelEntries,
        referenceId: group.groupId,
      );

      // Access quick add model entry.
      ModelEntry? quickAddModelEntry = await _localStorageCubit.getSharedModelEntryById(
        rootGroupReference: group.rootGroupReference,
        modelEntryId: group.groupPrefs.quickAddReference,
        referenceType: group.getReferenceType,
        referenceId: group.groupId,
      );

      // * Ensure that quick add model entry is allowed.
      if (group.isRestrictedToCommon && quickAddModelEntry != null) {
        final ModelEntry? modelEntry = commonModelEntries.getById(
          id: quickAddModelEntry.modelEntryId,
        );

        // Quick add model entry is invalid. Set it to null to inform user whenever it is used.
        if (modelEntry == null) quickAddModelEntry = null;
      }

      // Access relevant entries.
      final Entries entries = await _localStorageCubit.getSharedEntriesOfSharedGroup(
        rootGroupReference: group.groupId,
        referenceId: group.groupId,
        referenceType: group.getReferenceType,
        offset: 0,
        limit: state.entriesLimit,
      );

      // Access relevant model entries.
      // * Returns a ModelEntries.initial() if entries.isEmpty.
      final ModelEntries modelEntries = await _localStorageCubit.getSharedModelEntriesOfSharedEntries(
        rootGroupReference: group.rootGroupReference,
        referenceId: group.groupId,
        referenceType: group.getReferenceType,
        entries: entries,
      );

      // Users can add their own ModelEntries.
      if (group.isRestrictedToCommon == false) {
        // Self user model entries.
        final ModelEntries selfModelEntries = await _mainScreenCubit.state.modelEntries.getCreatedByCurrentUser;

        // Update common model entries.
        commonModelEntries = await commonModelEntries.addUniqueModelEntries(
          modelEntries: selfModelEntries,
        );
      }

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      // Emit state.
      emit(state.copyWith(
        group: group,
        subgroups: subgroups,
        commonModelEntries: commonModelEntries,
        quickAddModelEntry: quickAddModelEntry,
        entriesOffset: entries.items.length,
        entries: entries,
        modelEntries: modelEntries,
        status: SharedGroupSelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> refreshTopLevelGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> refreshTopLevelGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Entries.
  // ############################################

  /// This method can be used to show an EntrySelectedSheet.
  /// * This will show entry selected sheet in a page view.
  void showEntrySelectedSheetWithPageView({required BuildContext context, required int entryIndex, required Entry entry}) {
    // * Show EntrySelectedSheet with a PageView.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return BlocProvider<EntrySelectedPageCubit>(
          create: (_) => EntrySelectedPageCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            sharedGroupSelectedSheetCubit: this,
            mainScreenCubit: _mainScreenCubit,
            initialPage: entryIndex,
            fromGroup: state.group,
            isShared: true,
          ),
          child: EntrySelectedPage(
            initialPage: entryIndex,
          ),
        );
      },
    );
  }

  /// This method can be used to show an EntrySelectedSheet.
  void showEntrySelectedSheet({required BuildContext context, required Entry entry}) {
    // * Show EntrySelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<EntrySelectedSheetCubit>(
        create: (context) => EntrySelectedSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          sharedGroupSelectedSheetCubit: this,
          mainScreenCubit: _mainScreenCubit,
        )..initializeShared(
            entry: entry,
            fromGroup: state.group,
            fromViewEntriesSheet: false,
          ),
        child: const EntrySelectedSheet(),
      ),
    );
  }

  /// This method can be used to load more entries.
  Future<void> loadMoreEntries({bool shouldRethrow = false}) async {
    try {
      // Do not trigger this method if it is already loading, if it is in a failure state or if state is closed.
      if (state.status == SharedGroupSelectedSheetStatus.isFetchingEntries || state.status == SharedGroupSelectedSheetStatus.failure || state.isFinished || isClosed) return;

      // Emit status.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: SharedGroupSelectedSheetStatus.isFetchingEntries,
      ));

      // Access relevant entries.
      final Entries entries = await _localStorageCubit.getSharedEntriesOfSharedGroup(
        rootGroupReference: state.group.rootGroupReference,
        referenceId: state.group.groupId,
        referenceType: state.group.getReferenceType,
        offset: state.entriesOffset,
        limit: state.entriesLimit,
      );

      // Access relevant model entries.
      // * Returns a ModelEntries.initial() if entries.isEmpty.
      final ModelEntries modelEntries = await _localStorageCubit.getSharedModelEntriesOfSharedEntries(
        rootGroupReference: state.group.rootGroupReference,
        referenceId: state.group.groupId,
        referenceType: state.group.getReferenceType,
        entries: entries,
      );

      // Add Entries to state Entries.
      final Entries stateEntries = await state.entries.addUniqueEntries(
        entries: entries,
        append: true,
      );

      // Add ModelEntries to state ModelEntries.
      final ModelEntries stateModelEntries = await state.modelEntries.addUniqueModelEntries(
        modelEntries: modelEntries,
      );

      // Get an indication about if all entries were accessed.
      final bool isFinished = entries.items.isEmpty;

      // * Make sure that new offset is only heightened if entries were returned.
      final int offset = entries.items.isEmpty ? state.entriesOffset : state.entriesOffset + state.entriesLimit;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entries: stateEntries,
        modelEntries: stateModelEntries,
        entriesOffset: offset,
        isFinished: isFinished,
        status: SharedGroupSelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> loadMoreEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SharedGroupSelectedSheetStatus.failure,
      ));

      // Rethrow if specified.
      // * Do this after state update!
      if (shouldRethrow) rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('SharedGroupSelectedSheetCubit --> loadMoreEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SharedGroupSelectedSheetStatus.failure,
      ));

      // Rethrow if specified.
      // * Do this after state update!
      if (shouldRethrow) rethrow;
    }
  }

  // ############################################
  // # Model Entry update Cascade.
  // ############################################

  /// This method can be used to edit a ModelEntry of this state.
  Future<void> onModelEntryEdited({required ModelEntry modelEntry}) async {
    // If subgroup ModelEntry changed, report to parent.
    if (_sharedGroupSelectedSheetCubit != null) {
      await _sharedGroupSelectedSheetCubit.onModelEntryEdited(modelEntry: modelEntry);
    }

    // Put model entry into state.
    final ModelEntries updatedModelEntries = state.modelEntries.put(
      modelEntry: modelEntry,
    );

    // Make sure cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      modelEntries: updatedModelEntries,
      status: SharedGroupSelectedSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Entry update Cascade.
  // ############################################

  /// This method can be used to add an entry to state entries.
  Future<void> onEntryAddedToGroup({required Entry entry, required ModelEntry modelEntry}) async {
    // Insert new entry, keep old entries.
    final Entries updatedEntries = state.entries.add(entry: entry);

    // Put model entry into state.
    final ModelEntries updatedModelEntries = state.modelEntries.put(
      modelEntry: modelEntry,
    );

    // Make sure cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      // * This is needed because if a entry gets added that has a created_at that is earlier then last entry it will
      // * be displayed in the wrong position.
      entries: updatedEntries.sortByRecentlyCreated,
      modelEntries: updatedModelEntries,
      status: SharedGroupSelectedSheetStatus.waiting,
    ));
  }

  /// This method gets triggered if user edited an entry.
  Future<void> onEntryEdited({required Entry editedEntry}) async {
    // If subgroup entries changed, report to parent.
    if (_sharedGroupSelectedSheetCubit != null) {
      await _sharedGroupSelectedSheetCubit.onEntryEdited(editedEntry: editedEntry);
    }

    // Create updated entries.
    final Entries? entries = state.entries.update(
      updatedEntry: editedEntry,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      // * This is needed because if a entry gets added that has a created_at that is earlier then last entry it will
      // * be displayed in the wrong position.
      entries: entries?.sortByRecentlyCreated,
      status: SharedGroupSelectedSheetStatus.waiting,
    ));
  }

  /// This method gets triggered if user deleted an entry.
  Future<void> onEntryDeleted({required Entry entry}) async {
    // Create updated entries.
    final Entries entries = state.entries.remove(
      entryId: entry.entryId,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      entries: entries,
      status: SharedGroupSelectedSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Group update Cascade.
  // ############################################

  /// This method gets triggered if user edited a group.
  Future<void> onGroupEdited({required Group editedGroup, required ModelEntries commonModelEntries}) async {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      commonModelEntries: commonModelEntries,
      group: editedGroup,
      failure: Failure.initial(),
      status: SharedGroupSelectedSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Subgroup update Cascade.
  // ############################################

  /// This method gets triggerd if user created a subgroup.
  Future<void> subgroupCreated({required Group subgroup}) async {
    // Create updated subgroups.
    final Groups updatedSubgroups = state.subgroups.add(
      group: subgroup,
    );

    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      subgroups: updatedSubgroups,
    ));
  }

  /// This method gets triggerd if user edited a subgroup.
  Future<void> subgroupEdited({required Group subgroup}) async {
    // Do nothing if there is no previous cubit. This happens if user goes to gorup from entry.
    if (_sharedGroupSelectedSheetCubit == null) return;

    // Create updated subgroups.
    final Groups? updatedSubgroups = _sharedGroupSelectedSheetCubit.state.subgroups.update(
      updatedGroup: subgroup,
    );

    // Only emit states if cubit is still open.
    if (_sharedGroupSelectedSheetCubit.isClosed) return;

    _sharedGroupSelectedSheetCubit.emit(_sharedGroupSelectedSheetCubit.state.copyWith(
      subgroups: updatedSubgroups,
    ));
  }

  /// This method gets trigger if user deleted a subgroup.
  /// * _sharedGroupSelectedSheetCubit is considered to be != null
  Future<void> subgroupDeleted({required Group subgroup}) async {
    // Do nothing if there is no previous cubit. This happens if user goes to gorup from entry.
    if (_sharedGroupSelectedSheetCubit == null) return;

    // Access parent subgroups.
    final Groups parentSubgroups = _sharedGroupSelectedSheetCubit.state.subgroups;

    // Create updated subgroups.
    final Groups updatedSubgroups = parentSubgroups.remove(
      groupId: subgroup.groupId,
    );

    // Only emit states if cubit is still open.
    if (_sharedGroupSelectedSheetCubit.isClosed) return;

    _sharedGroupSelectedSheetCubit.emit(_sharedGroupSelectedSheetCubit.state.copyWith(
      subgroups: updatedSubgroups,
    ));
  }
}
