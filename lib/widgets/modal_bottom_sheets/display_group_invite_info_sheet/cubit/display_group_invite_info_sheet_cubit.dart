import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';
import '/api/api_paths.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';

// Cubits.
import '/logic/app_messages_cubit/app_messages_cubit.dart';

part 'display_group_invite_info_sheet_state.dart';

class DisplayGroupInviteInfoSheetCubit extends Cubit<DisplayGroupInviteInfoSheetState> {
  final AppMessagesCubit _appMessagesCubit;

  DisplayGroupInviteInfoSheetCubit({
    required AppMessagesCubit appMessagesCubit,
  })  : _appMessagesCubit = appMessagesCubit,
        super(DisplayGroupInviteInfoSheetState.initial());

  // ############################################
  // # Initialization.
  // ############################################

  /// Initialize display group invite sheet.
  Future<void> initialize({required Group group}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Create invite link.
      final String inviteLink = '${ApiPaths.baseEndpointDeepLinks}/deep?alias=${group.alias}';

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        group: group,
        inviteLink: inviteLink,
        status: DisplayGroupInviteInfoSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('DisplayGroupInviteInfoSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: DisplayGroupInviteInfoSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('DisplayGroupInviteInfoSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: DisplayGroupInviteInfoSheetStatus.pageHasError,
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
      status: DisplayGroupInviteInfoSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: DisplayGroupInviteInfoSheetStatus.close,
    ));
  }

  /// This method will be triggerd if user wants to copy a value to clipboard.
  Future<void> copyToClipboard({required BuildContext context, required String value, required String notification}) async {
    try {
      // Make sure there is data available to copy.
      if (value.isEmpty) throw Failure.genericError();

      // Set data to clipboard.
      await Clipboard.setData(ClipboardData(text: value));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: notification,
      );
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('DisplayGroupInviteInfoSheetCubit --> copyToClipboard() --> Failure: ${failure.toString()}');
      debugPrint(failure.toString());

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: DisplayGroupInviteInfoSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('DisplayGroupInviteInfoSheetCubit --> copyToClipboard() --> Exception: ${exception.toString()}');
      debugPrint(exception.toString());

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: DisplayGroupInviteInfoSheetStatus.failure,
      ));
    }
  }
}
