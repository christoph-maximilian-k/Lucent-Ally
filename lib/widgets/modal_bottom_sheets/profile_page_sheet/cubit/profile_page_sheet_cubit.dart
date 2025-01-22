import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import 'package:lucent_ally/config/app_durations.dart';
import 'package:lucent_ally/data/models/failure.dart';
import 'package:lucent_ally/data/models/files/file_item.dart';

// Cubits.
import 'package:lucent_ally/logic/cubit/local_storage_cubit.dart';
import 'package:lucent_ally/widgets/modal_bottom_sheets/menu_sheet/cubit/menu_sheet_cubit.dart';

part 'profile_page_sheet_state.dart';

class ProfilePageSheetCubit extends Cubit<ProfilePageSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final MenuSheetCubit _menuSheetCubit;

  ProfilePageSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required MenuSheetCubit menuSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _menuSheetCubit = menuSheetCubit,
        super(ProfilePageSheetState.initial());

  // ############################################
  // Initialization
  // ############################################

  /// Initialize local state data.
  Future<void> initialize({required FileItem? avatar}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Try and reload avatar.
      if (avatar == null) {
        // TODO: load avatar again, because it failed in previous cubit.

        // TODO: let previous cubit know on success.
      }

      emit(state.copyWith(
        avatar: avatar,
        status: ProfilePageSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ProfilePageSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        avatar: avatar,
        status: ProfilePageSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ProfilePageSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ProfilePageSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // State
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open and not loading.
    if (isClosed || state.status == ProfilePageSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ProfilePageSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == ProfilePageSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ProfilePageSheetStatus.close,
    ));
  }

  // ############################################
  // Avatar
  // ############################################

  /// This method will be triggered if user taps on the avatar image.
  Future<void> onTapAvatar({required BuildContext context}) async {
    // TODO: reload avatar.
  }

  /// This method is used to load image into CustomImageAvatar.
  /// * It primarily serves comsetic reasons. If this is not accessed like that a state update will happen to quickly and UI will look jancky.
  Future<FileItem?> loadAvatar() async {
    // * Necessary to avoid UI delay.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    return state.avatar;
  }

  // ############################################
  // Username
  // ############################################

  /// This method can be used to let user change their username.
  Future<void> changeUsername({required BuildContext context}) async {}
}
