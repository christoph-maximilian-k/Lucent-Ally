import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import 'package:lucent_ally/data/models/failure.dart';

part 'show_data_sample_sheet_state.dart';

class ShowDataSampleSheetCubit extends Cubit<ShowDataSampleSheetState> {
  ShowDataSampleSheetCubit() : super(ShowDataSampleSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize local create.
  Future<void> initialize({required List<List<dynamic>> csvTable}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        csvTable: csvTable,
        status: ShowDataSampleSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('ShowDataSampleSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: ShowDataSampleSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('ShowDataSampleSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ShowDataSampleSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == ShowDataSampleSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ShowDataSampleSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ShowDataSampleSheetStatus.close,
    ));
  }
}
