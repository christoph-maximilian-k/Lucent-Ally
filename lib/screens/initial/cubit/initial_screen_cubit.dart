import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/model_entries/model_entry.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';

part 'initial_screen_state.dart';

class InitialScreenCubit extends Cubit<InitialScreenState> {
  final LocalStorageCubit _localStorageCubit;

  InitialScreenCubit({required LocalStorageCubit localStorageCubit})
      : _localStorageCubit = localStorageCubit,
        super(InitialScreenState.initial());

  // ##############################
  // # Initialization.
  // ##############################

  /// Initialize state data.
  Future<void> initialize() async {
    try {
      // Set page to loading if this is a retry.
      if (state.status != InitialScreenStatus.pageIsLoading) {
        // Only emit states if cubit is open.
        if (isClosed) return;

        // Update user status and emit loading state.
        emit(state.copyWith(
          failure: Failure.initial(),
          pageFailure: Failure.initial(),
          status: InitialScreenStatus.pageIsLoading,
        ));
      }

      // * This is done for UX, so that logo and loading shows for abit. Otherwise it might be confuseing.
      await Future.delayed(const Duration(milliseconds: 500));

      // Initialize local storage and user.
      final bool firstAppLaunch = await _localStorageCubit.initialize();

      // Await micro service to ensure app wide user update.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Set predefined model entries.
      if (firstAppLaunch) {
        // Create predefined model entries.
        await _localStorageCubit.state.database!.writeTxn(() async {
          // Create predefined login ModelEntry.
          await _localStorageCubit.createLocalModelEntry(
            modelEntry: ModelEntry.login(),
          );

          // Create predefined person ModelEntry.
          await _localStorageCubit.createLocalModelEntry(
            modelEntry: ModelEntry.person(),
          );

          // Create predefined test ModelEntry.
          await _localStorageCubit.createLocalModelEntry(
            modelEntry: ModelEntry.entry(isShared: false),
          );

          // Create predefined test ModelEntry.
          await _localStorageCubit.createLocalModelEntry(
            modelEntry: ModelEntry.sharedExpenses(),
          );

          // Create predefined test ModelEntry.
          await _localStorageCubit.createLocalModelEntry(
            modelEntry: ModelEntry.mood(),
          );

          // Create predefined test ModelEntry.
          await _localStorageCubit.createLocalModelEntry(
            modelEntry: ModelEntry.incomeExpense(),
          );
        });
      }

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Update status.
      emit(state.copyWith(
        firstAppLaunch: firstAppLaunch,
        status: InitialScreenStatus.success,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('InitialScreenCubit --> initialize() --> failure --> ${failure.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: InitialScreenStatus.pageHasError,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('InitialScreenCubit --> initialize() --> exception --> ${exception.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: InitialScreenStatus.pageHasError,
      ));
    }
  }

  // ##############################
  // # State.
  // ##############################

  /// This method gets invoked if user wants to dismiss a failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: InitialScreenStatus.waiting,
    ));
  }
}
