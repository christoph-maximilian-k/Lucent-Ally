import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';

// Repositories.
import '/data/repositories/api/api_repository.dart';

part 'user_agreement_sheet_state.dart';

class UserAgreementSheetCubit extends Cubit<UserAgreementSheetState> {
  final ApiRepository _apiRepository;

  UserAgreementSheetCubit({required ApiRepository apiRepository})
      : _apiRepository = apiRepository,
        super(UserAgreementSheetState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize state data.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Emit loading screen.
      if (state.status != UserAgreementSheetStatus.pageIsLoading) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          failure: Failure.initial(),
          status: UserAgreementSheetStatus.pageIsLoading,
        ));
      }

      // Access user agreement.
      final String userAgreement = await _apiRepository.getUserAgreement();

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        userAgreement: userAgreement,
        status: UserAgreementSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('UserAgreementSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: UserAgreementSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('UserAgreementSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: UserAgreementSheetStatus.pageHasError,
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
      status: UserAgreementSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == UserAgreementSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: UserAgreementSheetStatus.close,
    ));
  }
}
