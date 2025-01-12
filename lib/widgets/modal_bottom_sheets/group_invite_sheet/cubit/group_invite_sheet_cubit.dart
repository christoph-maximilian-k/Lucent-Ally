import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';

part 'group_invite_sheet_state.dart';

class GroupInviteSheetCubit extends Cubit<GroupInviteSheetState> {
  final MainScreenCubit _mainScreenCubit;
  final LocalStorageCubit _localStorageCubit;

  GroupInviteSheetCubit({
    required MainScreenCubit mainScreenCubit,
    required LocalStorageCubit localStorageCubit,
  })  : _localStorageCubit = localStorageCubit,
        _mainScreenCubit = mainScreenCubit,
        super(GroupInviteSheetState.initial());

  // ############################################
  // # Initialization.
  // ############################################

  // Initialize state.
  Future<void> initialize({required String groupId, required bool pinRequired}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Create updated group.
      final Group group = state.group.copyWith(
        groupId: groupId,
      );

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        pinRequired: pinRequired,
        group: group,
        // * If pin is required do not immediately trigger validation because user
        // * has to provide the pin first.
        status: pinRequired ? GroupInviteSheetStatus.waiting : GroupInviteSheetStatus.validate,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('GroupInviteSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: GroupInviteSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('GroupInviteSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: GroupInviteSheetStatus.pageHasError,
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
      status: GroupInviteSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet with data.
  void closeWithData({required BuildContext context}) => Navigator.of(context).pop(state.group);

  /// This method can be used to close this sheet with data.
  void closeWithoutData({required BuildContext context}) => Navigator.of(context).pop(null);

  /// This method can be used to trigger a cloud groupe validation.
  Future<void> triggerValidation() async {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    // * Set page to loading.
    emit(state.copyWith(
      failure: Failure.initial(),
      status: GroupInviteSheetStatus.loading,
    ));

    // Await micro service.
    await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

    // Only emit new state if cubit is still active.
    if (isClosed) return;

    // * Trigger the validation.
    emit(state.copyWith(
      status: GroupInviteSheetStatus.validate,
    ));
  }

  /// This method will be triggerd if user types in the access pin text field.
  void accessPinChanged({required String value, required TextEditingController controller}) {
    // If user wants to clear data.
    if (value.isEmpty) controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      providedPin: value,
      failure: Failure.initial(),
      status: GroupInviteSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Group Methods.
  // ############################################

  /// This method can be used to access group specifications preview from cloud.
  Future<void> validateCloudGroupInvite() async {
    try {
      // In this case do nothing.
      if (state.pinRequired && state.providedPin.isEmpty) throw Failure.accessPinRequired();

      // Fetch Group from server if request is permitted.
      final Group fetchedGroup = await _localStorageCubit.validateSharedGroupInvite(
        groupId: state.group.groupId,
        accessPin: state.providedPin,
      );

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        pinRequired: false,
        group: fetchedGroup,
        status: GroupInviteSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('GroupInviteSheetCubit --> validateCloudGroupInvite() --> failure: ${failure.toString()}');

      // * In this case, let user retry.
      if (state.pinRequired) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          failure: failure,
          status: GroupInviteSheetStatus.failure,
        ));

        return;
      }

      // * Otherwise show page error.

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: GroupInviteSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('GroupInviteSheetCubit --> validateCloudGroupInvite() --> exception: ${exception.toString()}');

      // * In this case, let user retry.
      if (state.pinRequired) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          failure: Failure.genericError(),
          status: GroupInviteSheetStatus.failure,
        ));

        return;
      }

      // * Otherwise show page error.

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: GroupInviteSheetStatus.pageHasError,
      ));
    }
  }

  /// This method gets invoked if user decides to join this group.
  Future<void> joinGroup() async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: GroupInviteSheetStatus.loading,
      ));

      // Join the group
      await _localStorageCubit.joinSharedGroup(
        groupId: state.group.groupId,
        accessPin: state.providedPin,
      );

      // Update dependent cubits.
      await _mainScreenCubit.onGroupCreated(group: state.group);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: GroupInviteSheetStatus.closeWithData,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('GroupInviteSheetCubit --> joinGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: GroupInviteSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('GroupInviteSheetCubit --> joinGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: GroupInviteSheetStatus.failure,
      ));
    }
  }
}
