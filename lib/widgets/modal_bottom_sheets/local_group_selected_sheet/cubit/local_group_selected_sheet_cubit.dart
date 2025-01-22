import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Repositories.
import '/data/repositories/local_notifications/local_notifications_repository.dart';
import '/data/repositories/location/location_repository.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';
import '/pages/entry_selected_page/cubit/entry_selected_page_cubit.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_decision_sheet/cubit/entry_decision_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/create_group_sheet/cubit/create_group_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/cubit/entry_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/cubit/charts_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/search_sheet/cubit/search_sheet_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';

// Pages.
import '/pages/entry_selected_page/entry_selected_page.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/entry_decision_sheet/entry_decision_sheet.dart';
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/create_group_sheet/create_group_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/entry_sheet.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/local_group_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/charts_sheet.dart';
import '/widgets/modal_bottom_sheets/search_sheet/search_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/display_message_sheet/display_message_sheet.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/entry_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/local_notification_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/fields/field.dart';
import '/data/models/entries/entry.dart';
import '/data/models/entries/entries.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/group_prefs/group_prefs.dart';
import '/data/models/secrets/secrets.dart';

part 'local_group_selected_sheet_state.dart';

class LocalGroupSelectedSheetCubit extends Cubit<LocalGroupSelectedSheetState> with HelperFunctions {
  final LocalNotificationsRepository _localNotificationsRepository;
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final LocalGroupSelectedSheetCubit? _ancestorLocalGroupSelectedSheetCubit;
  final MainScreenCubit _mainScreenCubit;

  LocalGroupSelectedSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required LocalNotificationsRepository localNotificationsRepository,
    required AppMessagesCubit appMessagesCubit,
    required LocalGroupSelectedSheetCubit? ancestorLocalGroupSelectedSheetCubit,
    required MainScreenCubit mainScreenCubit,
  })  : _localNotificationsRepository = localNotificationsRepository,
        _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _ancestorLocalGroupSelectedSheetCubit = ancestorLocalGroupSelectedSheetCubit,
        _mainScreenCubit = mainScreenCubit,
        super(LocalGroupSelectedSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize state data.
  Future<void> initialize({required BuildContext context, required Group group, required String topLevelGroupId}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // * If this is a protected top level group, let user provide password.
      // ! Unless auth is fresh. In that case let user proceed.
      if (group.isProtected && group.getIsLocalGroupType && _localStorageCubit.state.authIsFresh == false) {
        // Make sure used context is still mounted.
        if (!context.mounted) {
          // Output debug message.
          contextNotMountedHelper(parent: 'LocalGroupSelectedSheetCubit', sourceMethod: 'initialize()');

          throw Failure.genericError();
        }

        // * Let user authenticate.
        final String? password = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) => TextFieldSheet(
            title: labels.basicLabelsAuthenticate(),
            hint: labels.basicLabelsPasswordHint(),
            autocorrect: false,
            canObscure: true,
          ),
        );

        // * User cancled, revert state.
        if (password == null || password.isEmpty) {
          // Only emit new state if cubit is still active.
          if (isClosed) return;

          emit(state.copyWith(
            status: LocalGroupSelectedSheetStatus.close,
          ));

          return;
        }

        // * Check if provided password is correct.
        // * This method throws failures.
        await _localStorageCubit.validateAppPassword(password: password);
      }

      // * If authentification process was successfull or skipped set local state indicator
      // * in order to enable auto close of encrypted groups after a while.
      if (group.isProtected) await _localStorageCubit.updateProtectedGroupIsShown(visible: true);

      // Access secrets.
      final Secrets? secrets = group.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access subgroups.
      final Groups subgroups = await _localStorageCubit.getAllLocalSubgroups(
        groupId: group.groupId,
      );

      // Access relevant entries.
      final Entries entries = await _localStorageCubit.getLocalEntriesInLocalGroup(
        groupId: group.groupId,
        offset: state.entriesOffset,
        limit: state.entriesLimit,
        secrets: secrets,
      );

      // Access ModelEntries.
      final ModelEntries modelEntries = await _localStorageCubit.getAllLocalModelEntries(
        shouldAccessPrefs: true,
      );

      // Access common model entries.
      final ModelEntries commonModelEntries = await modelEntries.getReferencedModelEntries(
        references: group.commonModelEntries,
        includeDeleted: false,
      );

      // Access quick add model entry.
      final ModelEntry? quickAddModelEntry = modelEntries.getById(
        id: group.groupPrefs.quickAddReference,
      );

      // Get an indication about if all entries were accessed.
      final bool isFinished = entries.items.length < state.entriesLimit;

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        group: group,
        subgroups: subgroups,
        modelEntries: modelEntries,
        commonModelEntries: commonModelEntries,
        quickAddModelEntry: quickAddModelEntry,
        isFinished: isFinished,
        entries: entries,
        entriesOffset: entries.items.length,
        status: LocalGroupSelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: LocalGroupSelectedSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: LocalGroupSelectedSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == LocalGroupSelectedSheetStatus.close) return;

    // Make sure that encrypted group is shown indicated gets resetted.
    await _localStorageCubit.updateProtectedGroupIsShown(visible: false);

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: LocalGroupSelectedSheetStatus.close,
    ));
  }

  /// This method can be used to give user a choice of what entry to add.
  Future<void> showAddToGroupOptions({required BuildContext context}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          optionOne: labels.groupSelectedSheetCubitOptionNewEntry(),
          optionOneIcon: AppIcons.edit,
          // TODO: Add existing entry to protected/encrypted groups (new_feature).
          // ! For now this option is not enabled for protected and encrypted groups.
          // ! Why? To make sure that entries that are in a protected group are not at the same time in a not protected group.
          // ! Maybe implement in the future.
          optionTwo: state.group.isProtected ? null : labels.groupSelectedSheetCubitOptionExistingEntry(),
          optionTwoIcon: AppIcons.entries,
          optionThree: labels.groupSelectedSheetCubitOptionSubgroup(),
          optionThreeIcon: AppIcons.groups,
          // TODO: Auto create entry in intervals, i.e. recurring entries (new_feature).
        ),
      );

      // * User cancelled.
      if (option == null) return;

      // Let user know that group is locked.
      if (state.group.isLocked) throw Failure.groupIsLocked();

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'LocalGroupSelectedSheetCubit', sourceMethod: 'showSelectOptionSheet()');

      // * User selected first option, which in this case is: add new entry
      if (option == 1) {
        // * Show EntryDecisionSheet.
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (_) => BlocProvider<EntryDecisionSheetCubit>(
            create: (context) => EntryDecisionSheetCubit(
              localStorageCubit: _localStorageCubit,
              localGroupSelectedSheetCubit: this,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
            )..initializeLocal(
                fromGroup: state.group,
              ),
            child: const EntryDecisionSheet(),
          ),
        );

        return;
      }

      // * User selected second option, which in this case is: add existing entries
      if (option == 2) {
        // * Show SearchSheet.
        final Entry? entry = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<SearchSheetCubit>(
            create: (context) => SearchSheetCubit(
              localStorageCubit: _localStorageCubit,
            )..initialize(
                isShared: false,
              ),
            child: const SearchSheet(),
          ),
        );

        // User did not pick an entry.
        if (entry == null) return;

        // Make sure the model entry of this entry is allowed.
        if (state.group.isRestrictedToCommon) {
          final ModelEntry? modelEntry = state.commonModelEntries.getById(
            id: entry.modelEntryReference,
          );

          if (modelEntry == null) throw Failure.modelEntryNotInRestrictions();
        }

        // Add entry to state entries.
        final Entries entries = state.entries.add(entry: entry);

        // Create the reference.
        await _localStorageCubit.state.database!.writeTxn(() async {
          await _localStorageCubit.createLocalGroupToEntryReference(
            group: state.group,
            entry: entry,
            addedBy: user.userId,
          );
        });

        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          entries: entries,
        ));

        return;
      }

      // * User selected third option, which in this case is: add local subgroup
      if (option == 3) {
        // Let user create a new local sub group.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<CreateGroupSheetCubit>(
            create: (context) => CreateGroupSheetCubit(
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              localGroupSelectedSheetCubit: this,
            )..initializeLocalCreate(
                groupType: Group.groupTypeLocalSub,
                parentGroupReference: state.group.groupId,
                rootGroupReference: state.topLevelGroupId,
              ),
            child: const CreateGroupSheet(
              // * These are irrelevant for local subgroups.
              initialGroupEditPolicyItem: 0,
              initialGroupDeletePolicyItem: 0,
              initialEntryAddPolicyItem: 0,
              initialEntryEditPolicyItem: 0,
              initialEntryDeletePolicyItem: 0,
              initialSubgroupAddPolicyItem: 0,
            ),
          ),
        );
      }
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalGroupSelectedSheetCubit --> showSelectOptionSheet() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalGroupSelectedSheetCubit --> showSelectOptionSheet() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
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
            localGroupSelectedSheetCubit: this,
          )..initializeLocalCreate(
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
      debugPrint('LocalGroupSelectedSheetCubit --> onQuickAddAction() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalGroupSelectedSheetCubit --> onQuickAddAction() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
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

      // Perform write transaction.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Update recent items.
        await _localStorageCubit.putLocalRecentEntry(
          entryId: entry.entryId,
          rootGroupReference: state.group.rootGroupReference,
          groupReference: state.group.groupId,
        );
      });

      // Let main screen know.
      _mainScreenCubit.onEntryInteracted(
        entry: entry,
        modelEntry: entryModel,
        fromGroup: state.group,
      );

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.groupSelectedSheetCubitCopyField(label: fieldIdentification.label),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> copyToClipboard() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> copyToClipboard() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Group
  // ############################################

  /// This method is triggerd if user wants to view group options.
  Future<void> onGroupOptionsPressed({required BuildContext context}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Edit group.
          optionOne: labels.groupSelectedSheetCubitOptionEditGroup(),
          optionOneIcon: AppIcons.edit,
          // * Search in group.
          optionTwo: labels.groupSelectedSheetCubitOptionSearchGroup(),
          optionTwoIcon: AppIcons.search,
          // * Delete group.
          optionThree: labels.groupSelectedSheetCubitOptionDeleteGroup(),
          optionThreeIcon: AppIcons.delete,
          // * Show group info.
          optionFour: state.group.groupDescription.isNotEmpty ? labels.basicLabelsGroupInfo() : null,
          optionFourIcon: AppIcons.description,
          optionFourSuffix: true,
          // * Set local group notification.
          optionFive: labels.groupNotifications(),
          optionFiveIcon: AppIcons.notification,
          optionFiveSuffix: true,
          // * Pick QuickAddReference.
          optionSix: labels.groupSelectedSheetCubitOptionPickQuickAddReference(),
          optionSixIcon: AppIcons.entryModels,
          optionSixSuffix: true,
          // * Show Charts Sheet.
          optionSeven: labels.basicLabelsCharts(),
          optionSevenIcon: AppIcons.charts,
          optionSevenSuffix: true,
        ),
      );

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'LocalGroupSelectedSheetCubit', sourceMethod: 'onGroupOptionsPressed()');

      // * User wants to edit group.
      if (option == 1) editGroup(context: context);

      // * User wants to search in group.
      if (option == 2) searchGroup(context: context);

      // * User wants to delete group.
      if (option == 3) deleteGroup(context: context);

      // * User wants view group info.
      if (option == 4) showGroupInfo(context: context);

      // * User wants to set a group notification.
      if (option == 5) showGroupNotificationOptions(context: context);

      // * User wants to see charts.
      if (option == 6) pickQuickAddReference(context: context);

      // * User wants to see charts.
      if (option == 7) showChartsSheet(context: context);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> onGroupOptionsPressed() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> onGroupOptionsPressed() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to delete a group.
  Future<void> deleteGroup({required BuildContext context}) async {
    try {
      // * Prompt user with confirm sheet.
      final bool? confirm = await showModalBottomSheet(
        context: context,
        builder: (context) => ConfirmSheet(
          title: labels.groupSelectedSheetCubitConfirmDeleteGroupTitle(),
          subtitle: labels.groupSelectedSheetCubitConfirmDeleteGroupSubtitle(),
        ),
      );

      // * User dismissed.
      if (confirm != true || isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        loadingMessageGroupDelete: labels.localGroupPrepareDeleteLoadingMessage(),
        status: LocalGroupSelectedSheetStatus.pageIsLoading,
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

      // Make sure that group does not contain subgroups.
      // * This is done to force user to manually delete subgroups. Otherwise this delete process is to
      // * heavy because of nested subgroups.
      if (state.subgroups.items.isNotEmpty) throw Failure.groupContainsSubgroups();

      // Get number of entries in this group.
      // * Needs to be outside of ISAR transaction.
      final int total = await _localStorageCubit.getNumberOfLocalEntriesInLocalGroup(groupId: state.group.groupId);

      // Delete all files of group.
      await _localStorageCubit.deleteAllLocalFilesOfGroup(group: state.group);

      // Perform delete.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Init Helper.
        int counter = 1;

        // Delete group prefs.
        await _localStorageCubit.deleteLocalGroupPrefs(
          groupPrefs: state.group.groupPrefs,
        );

        // Delete entries of group.
        await _localStorageCubit.deleteLocalEntriesOfLocalGroup(
            group: state.group,
            onDelete: (final String entryId) async {
              // Only emit state if cubit is open.
              if (isClosed) throw Failure.failedToDeleteGroup();

              // Emit deleted state.
              emit(state.copyWith(
                loadingMessageGroupDelete: labels.loadingMessageGroupDelete(
                  counter: counter,
                  total: total,
                ),
              ));

              // Remove recent entry from main screen.
              await _mainScreenCubit.onEntryDeleted(entryId: entryId);

              // Heighten counter.
              counter++;
            });

        // Delete group.
        await _localStorageCubit.deleteLocalGroup(
          group: state.group,
        );
      });

      // Check if deleted group is a subgroup.
      if (_ancestorLocalGroupSelectedSheetCubit != null) {
        // * update cubit.
        await subgroupDeleted(subgroup: state.group);
      }

      // If this is a top level group, let main screen know.
      if (state.group.getIsLocalGroupType) {
        _mainScreenCubit.onLocalGroupDeleted(group: state.group);
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit close state.
      emit(state.copyWith(
        status: LocalGroupSelectedSheetStatus.close,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.groupSelectedSheetCubitGroupDeletedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> deleteGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> deleteGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to edit a group.
  Future<void> editGroup({required BuildContext context}) async {
    // Let user create a new local group.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<CreateGroupSheetCubit>(
        create: (context) => CreateGroupSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          mainScreenCubit: _mainScreenCubit,
          localGroupSelectedSheetCubit: this,
        )..initializeLocalEdit(
            initialGroup: state.group,
          ),
        child: const CreateGroupSheet(
          // * These are irrelevant for local edits.
          initialGroupEditPolicyItem: 0,
          initialGroupDeletePolicyItem: 0,
          initialEntryAddPolicyItem: 0,
          initialEntryEditPolicyItem: 0,
          initialEntryDeletePolicyItem: 0,
          initialSubgroupAddPolicyItem: 0,
        ),
      ),
    );
  }

  /// This method will be triggerd if user wants to search in group.
  Future<void> searchGroup({required BuildContext context}) async {
    // * Show SearchSheet.
    final Entry? entry = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<SearchSheetCubit>(
        create: (context) => SearchSheetCubit(
          localGroupSelectedSheetCubit: this,
          localStorageCubit: _localStorageCubit,
        )..initialize(
            isShared: false,
          ),
        child: const SearchSheet(),
      ),
    );

    // User did not choose an entry.
    if (entry == null) return;

    // Make sure used context is still mounted. Output debug message.
    if (!context.mounted) return contextNotMountedHelper(parent: 'LocalGroupSelectedSheetCubit', sourceMethod: 'searchGroup()');

    // Display the selected entry.
    showEntrySelectedSheet(context: context, entry: entry);
  }

  /// This method will be triggerd if user wants to view group info.
  Future<void> showGroupInfo({required BuildContext context}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => DisplayMessageSheet(
        title: labels.basicLabelsGroupInfo(),
        message: state.group.groupDescription,
      ),
    );
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
      if (!context.mounted) return contextNotMountedHelper(parent: 'LocalGroupSelectedSheetCubit', sourceMethod: 'showGroupNotificationOptions()');

      // * User wants to set a notification.
      if (option == 1) setLocalGroupNotification(context: context);

      // * User wants to delete a notification
      if (option == 2) deleteLocalGroupNotification(context: context);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> showGroupNotificationOptions() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> showGroupNotificationOptions() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
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

  /// This method will be triggerd if user wants to add a quick add model entry.
  Future<void> pickQuickAddReference({required BuildContext context}) async {
    try {
      // User has not created a model entry yet.
      if (state.modelEntries.items.isEmpty) throw Failure.noModelEntryCreatedYet();

      // Modify model entries if restrictions have been set.
      final ModelEntries pickerModelEntries = state.group.isRestrictedToCommon ? state.commonModelEntries : state.modelEntries;

      // Access PickerItems.
      final PickerItems pickerItems = pickerModelEntries.toPickerItems();

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
      final ModelEntry quickAddModelEntry = pickerModelEntries.getById(
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
      await _localStorageCubit.state.database!.writeTxn(() async {
        await _localStorageCubit.putLocalGroupPrefs(
          groupId: state.group.groupId,
          groupPrefs: groupPrefs,
        );
      });

      // Update dependent cubits.
      await _mainScreenCubit.onLocalGroupEdited(group: updatedGroup);

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
      debugPrint('LocalGroupSelectedSheetCubit --> pickQuickAddReference() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> pickQuickAddReference() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
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
            localGroupSelectedSheetCubit: this,
            sharedGroupSelectedSheetCubit: null,
          )..initializeLocal(
              group: state.group,
            ),
          child: const ChartsSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> showChartsSheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSelectedSheetCubit --> showChartsSheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Subgroups
  // ############################################

  /// This method can be used to show a group selected sheet.
  Future<void> showSubgroupSelectedSheet({required BuildContext context, required Group group}) async {
    // * Display GroupSelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<LocalGroupSelectedSheetCubit>(
        create: (context) => LocalGroupSelectedSheetCubit(
          localNotificationsRepository: _localNotificationsRepository,
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          ancestorLocalGroupSelectedSheetCubit: this,
          mainScreenCubit: _mainScreenCubit,
        )..initialize(
            context: context,
            group: group,
            topLevelGroupId: state.topLevelGroupId,
          ),
        child: const LocalGroupSelectedSheet(),
      ),
    );
  }

  // ############################################
  // # Entries
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
            localGroupSelectedSheetCubit: this,
            mainScreenCubit: _mainScreenCubit,
            initialPage: entryIndex,
            fromGroup: state.group,
            isShared: false,
          ),
          child: EntrySelectedPage(
            initialPage: entryIndex,
          ),
        );
      },
    );
  }

  /// This method can be used to show a EntrySelectedSheet without a page view.
  void showEntrySelectedSheet({required BuildContext context, required Entry entry}) {
    // * Show EntrySelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<EntrySelectedSheetCubit>(
        create: (context) => EntrySelectedSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          localGroupSelectedSheetCubit: this,
          mainScreenCubit: _mainScreenCubit,
        )..initializeLocal(
            entry: entry,
            fromGroup: state.group,
            fromViewEntriesSheet: false,
          ),
        child: EntrySelectedSheet(),
      ),
    );
  }

  /// This method can be used to load more entries.
  Future<void> loadMoreEntries({bool shouldRethrow = false}) async {
    try {
      // Do not trigger if more content is already loading or if it is finished.
      if (state.moreContentIsLoading || state.isFinished) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: true,
        failure: Failure.initial(),
        status: LocalGroupSelectedSheetStatus.isFetchingEntries,
      ));

      // Access secrets.
      final Secrets? secrets = state.group.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access relevant entries.
      final Entries entries = await _localStorageCubit.getLocalEntriesInLocalGroup(
        groupId: state.group.groupId,
        offset: state.entriesOffset,
        limit: state.entriesLimit,
        secrets: secrets,
      );

      // Join entries.
      final Entries joined = await state.entries.addUniqueEntries(
        entries: entries,
        append: true,
      );

      // Get an indication about if all entries were accessed.
      final bool isFinished = entries.items.isEmpty;

      // * Make sure that new offset is only heightened if entries were returned.
      final int offset = entries.items.isEmpty ? state.entriesOffset : state.entriesOffset + state.entriesLimit;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        entriesOffset: offset,
        entries: joined.sortByRecentlyCreated,
        isFinished: isFinished,
        status: LocalGroupSelectedSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalGroupSheetCubit --> loadMoreEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        failure: failure,
        status: LocalGroupSelectedSheetStatus.failure,
      ));

      // Rethrow if specified.
      // * Do this after state update!
      if (shouldRethrow) rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalGroupSheetCubit --> loadMoreEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        failure: Failure.genericError(),
        status: LocalGroupSelectedSheetStatus.failure,
      ));

      // Rethrow if specified.
      // * Do this after state update!
      if (shouldRethrow) rethrow;
    }
  }

  // ############################################
  // # Model Entry update Cascade
  // ############################################

  /// This method can be used to edit a ModelEntry of this state.
  Future<void> onModelEntryEdited({required ModelEntry modelEntry}) async {
    // If subgroup ModelEntry changed, report to parent.
    if (_ancestorLocalGroupSelectedSheetCubit != null) {
      await _ancestorLocalGroupSelectedSheetCubit.onModelEntryEdited(modelEntry: modelEntry);
    }

    // Put model entry into state.
    final ModelEntries updatedModelEntries = state.modelEntries.put(
      modelEntry: modelEntry,
    );

    // Make sure cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      modelEntries: updatedModelEntries,
      status: LocalGroupSelectedSheetStatus.waiting,
    ));
  }

  /// This method can be used to add a ModelEntry of this state.
  Future<void> onModelEntryCreated({required ModelEntry modelEntry}) async {
    // If subgroup ModelEntry changed, report to parent.
    if (_ancestorLocalGroupSelectedSheetCubit != null) {
      await _ancestorLocalGroupSelectedSheetCubit.onModelEntryCreated(modelEntry: modelEntry);
    }

    // Put model entry into state.
    final ModelEntries updatedModelEntries = state.modelEntries.add(
      modelEntry: modelEntry,
    );

    // Make sure cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      modelEntries: updatedModelEntries,
    ));
  }

  // ############################################
  // # Entry update Cascade
  // ############################################

  /// This method can be used to add an entry to state entries.
  Future<void> onEntryAddedToGroup({required Entry entry}) async {
    // Insert new entry, keep old entries.
    final Entries updatedEntries = state.entries.add(entry: entry);

    // Make sure cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      // * This is needed because if a entry gets added that has a created_at that is earlier then last entry it will
      // * be displayed in the wrong position.
      entries: updatedEntries.sortByRecentlyCreated,
      status: LocalGroupSelectedSheetStatus.waiting,
    ));
  }

  /// This method gets triggered if user edited an entry.
  /// * updates entry in ```state.entries``` and rebuilds list
  /// * does not show notification
  Future<void> onEntryEdited({required Entry editedEntry}) async {
    // If subgroup entries changed, report to parent.
    if (_ancestorLocalGroupSelectedSheetCubit != null) {
      await _ancestorLocalGroupSelectedSheetCubit.onEntryEdited(editedEntry: editedEntry);
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
      status: LocalGroupSelectedSheetStatus.waiting,
    ));
  }

  /// This method gets triggered if user deleted an entry from local storage.
  /// * removes entry from ```state.entries``` and rebuilds list.
  /// * shows notification
  Future<void> onEntryDeleted({required String entryId}) async {
    // Remove entry from state.
    final Entries entriesOfGroup = state.entries.remove(
      entryId: entryId,
    );

    // Update parent cubit.
    if (_ancestorLocalGroupSelectedSheetCubit != null) {
      await _ancestorLocalGroupSelectedSheetCubit.onEntryDeleted(entryId: entryId);
    }

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove entry from state.
    emit(state.copyWith(
      entries: entriesOfGroup,
      status: LocalGroupSelectedSheetStatus.waiting,
    ));

    // Display anotification.
    _appMessagesCubit.showNotification(
      message: labels.groupSelectedSheetCubitEntryDeletedNotification(),
    );
  }

  // ############################################
  // # Group update Cascade
  // ############################################

  /// This method gets triggered if user edited a group.
  Future<void> onGroupEdited({required Group editedGroup, required ModelEntries commonModelEntries}) async {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: editedGroup,
      commonModelEntries: commonModelEntries,
      failure: Failure.initial(),
      status: LocalGroupSelectedSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Subgroup update Cascad
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

  /// This method gets trigger if user deleted a subgroup.
  /// * _groupSelectedSheetCubit is considered to be != null
  Future<void> subgroupDeleted({required Group subgroup}) async {
    // Only report changes if there is an underlaying cubit. There is no cubit if this group was navigated to
    // from recent entries.
    if (_ancestorLocalGroupSelectedSheetCubit == null) return;

    // Access parent subgroups.
    final Groups parentSubgroups = _ancestorLocalGroupSelectedSheetCubit.state.subgroups;

    // Create updated subgroups.
    final Groups updatedSubgroups = parentSubgroups.remove(
      groupId: subgroup.groupId,
    );

    // Only emit states if cubit is still open.
    if (_ancestorLocalGroupSelectedSheetCubit.isClosed) return;

    _ancestorLocalGroupSelectedSheetCubit.emit(_ancestorLocalGroupSelectedSheetCubit.state.copyWith(
      subgroups: updatedSubgroups,
    ));
  }
}
