import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// User with Settings and Labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/widgets/modal_bottom_sheets/create_group_sheet/cubit/create_group_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_decision_sheet/cubit/entry_decision_sheet_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/create_group_sheet/create_group_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_decision_sheet/entry_decision_sheet.dart';

// Screens.
import '/screens/main/cubit/main_screen_cubit.dart';

part 'group_decision_sheet_state.dart';

class GroupDecisionSheetCubit extends Cubit<GroupDecisionSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;

  GroupDecisionSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        super(GroupDecisionSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize state data.
  Future<void> initializeLocal() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access local groups.
      final Groups groups = await _localStorageCubit.getAllLocalTopLevelGroups();

      // Sort groups.
      final Groups sortedGroups = groups.sortAtoZ;

      // Access group.
      final Group group = sortedGroups.items.isEmpty ? Group.initial() : sortedGroups.items.first;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        groups: sortedGroups,
        selectedGroup: group,
        status: GroupDecisionSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> initializeLocal() --> Failure: ${failure.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: GroupDecisionSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> initializeLocal() --> Exception: ${exception.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: GroupDecisionSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data.
  Future<void> initializeShared() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access local groups.
      final Groups groups = await _localStorageCubit.getSelfAllSharedTopLevelGroups();

      // Sort groups.
      final Groups sortedGroups = groups.sortAtoZ;

      // Access group.
      final Group group = sortedGroups.items.isEmpty ? Group.initial() : sortedGroups.items.first;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        groups: sortedGroups,
        selectedGroup: group,
        status: GroupDecisionSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> initializeShared() --> Failure: ${failure.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: GroupDecisionSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> initializeShared() --> Exception: ${exception.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: GroupDecisionSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method gets invoked if user wants to dismiss a failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: GroupDecisionSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Do nothing if state is already set to close.
    if (state.status == GroupDecisionSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: GroupDecisionSheetStatus.close,
    ));
  }

  /// This method can be used to jump to a specific item in ScrollWheel.
  /// * jumps to first item in list if Group was not found
  Future<void> jumpToScrollWeelItem({required FixedExtentScrollController fixedExtentScrollController}) async {
    try {
      // Access currently selected group.
      final int currentlySelectedIndex = state.groups.items.indexWhere(
        (element) => element.groupId == state.selectedGroup.groupId,
      );

      // Select created group in picker.
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => fixedExtentScrollController.jumpToItem(
          currentlySelectedIndex < 0 ? 0 : currentlySelectedIndex,
        ),
      );

      // * This line is needed to let state update first.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: GroupDecisionSheetStatus.showEntryDecisionSheet,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> jumpToScrollWeelItem() --> exception: ${exception.toString()}');
    }
  }

  /// Triggered when user scrolls through picker.
  void updateSelectedGroup({required int index}) {
    // Access relevant data.
    final Group group = state.groups.items[index];

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      selectedGroup: group,
    ));
  }

  // ############################################
  // # Shared mode
  // ############################################

  /// This method can be used to create a new shared group.
  Future<void> showCreateSharedGroupSheet({required BuildContext context}) async {
    // Let user create a new shared group.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<CreateGroupSheetCubit>(
        create: (context) => CreateGroupSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          mainScreenCubit: _mainScreenCubit,
          groupDecisionSheetCubit: this,
        )..initializeSharedCreate(
            rootGroupReference: '',
            parentGroupReference: '',
            rootGroupCreator: user.userId,
            groupType: Group.groupTypeShared,
          ),
        child: const CreateGroupSheet(
          // * These are irrelevant here because this is a local group.
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

  /// This method will be triggered if user wants to add an entry to a shared group.
  Future<void> showSharedEntryDecisionSheet({required BuildContext context}) async {
    try {
      // Make sure user has correct permissions.
      final bool hasPermission = state.selectedGroup.userHasEntryAddPermissions(
        isShared: state.isShared,
        // * Only top level groups are displayed here.
        topLevelGroupOwner: state.selectedGroup.groupCreator,
      );

      // Let user know.
      if (hasPermission == false) throw Failure.entryAddProhibited();

      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => BlocProvider<EntryDecisionSheetCubit>(
          create: (context) => EntryDecisionSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
          )..initializeShared(
              fromGroup: state.selectedGroup,
            ),
          child: const EntryDecisionSheet(),
        ),
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // Reset state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: GroupDecisionSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> showSharedEntryDecisionSheet() --> Failure: ${failure.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: GroupDecisionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> showSharedEntryDecisionSheet() --> Exception: ${exception.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: GroupDecisionSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Local mode
  // ############################################

  /// This method can be used to create a new local group.
  Future<void> showCreateLocalGroupSheet({required BuildContext context}) async {
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
          groupDecisionSheetCubit: this,
        )..initializeLocalCreate(
            groupType: Group.groupTypeLocal,
            parentGroupReference: '',
            rootGroupReference: '',
          ),
        child: const CreateGroupSheet(
          // * These are irrelevant here because this is a local group.
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

  /// This method will be triggered if user wants to add an entry to a local group.
  Future<void> showLocalEntryDecisionSheet({required BuildContext context}) async {
    try {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => BlocProvider<EntryDecisionSheetCubit>(
          create: (context) => EntryDecisionSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
          )..initializeLocal(
              fromGroup: state.selectedGroup,
            ),
          child: const EntryDecisionSheet(),
        ),
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // Reset state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: GroupDecisionSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> showLocalEntryDecisionSheet() --> Failure: ${failure.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: GroupDecisionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('GroupDecisionSheetCubit --> showLocalEntryDecisionSheet() --> Exception: ${exception.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: GroupDecisionSheetStatus.failure,
      ));
    }
  }

  // ------------------------------------------------------------------
  // * Below methods are called from other cubits
  // ------------------------------------------------------------------

  /// This method will be triggered if user created a new group.
  Future<void> onGroupCreated({required Group group}) async {
    // Only perform this method if user created a corresponding group to be currently shown.
    if (_mainScreenCubit.state.isShared == false && group.getIsSharedGroupType) return;

    if (_mainScreenCubit.state.isShared && group.getIsLocalGroupType) return;

    // Create updated state groups.
    final Groups updatedGroups = state.groups.add(group: group).sortAtoZ;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      groups: updatedGroups,
      selectedGroup: group,
      status: GroupDecisionSheetStatus.updateScrollWeel,
    ));

    // Display notification.
    _appMessagesCubit.showNotification(
      message: labels.groupDecisionSheetGroupCreatedNotification(),
    );
  }
}
