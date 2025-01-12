import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';

// Repositories.
import '/data/repositories/api/api_repository.dart';

part 'privacy_policy_sheet_state.dart';

class PrivacyPolicySheetCubit extends Cubit<PrivacyPolicySheetState> {
  final ApiRepository _apiRepository;

  PrivacyPolicySheetCubit({required ApiRepository apiRepository})
      : _apiRepository = apiRepository,
        super(PrivacyPolicySheetState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize state data.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Emit loading state.
      if (state.status != PrivacyPolicySheetStatus.pageIsLoading) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          failure: Failure.initial(),
          status: PrivacyPolicySheetStatus.pageIsLoading,
        ));
      }

      // Access privacy policy.
      final String privacyPolicy = await _apiRepository.getPrivacyPolicy();

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        privacyPolicy: privacyPolicy,
        status: PrivacyPolicySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('PrivacyPolicySheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: PrivacyPolicySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('PrivacyPolicySheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: PrivacyPolicySheetStatus.pageHasError,
      ));
    }
  }

  // #############################
  // State
  // #############################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: PrivacyPolicySheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == PrivacyPolicySheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: PrivacyPolicySheetStatus.close,
    ));
  }
}
