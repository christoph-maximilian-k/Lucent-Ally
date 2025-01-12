import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// User, with settings and labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';
import '/data/repositories/api/api_repository.dart';
import '/data/models/settings/settings.dart';
import '/data/models/users/user.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/privacy_policy_sheet/privacy_policy_sheet.dart';
import '/widgets/modal_bottom_sheets/user_agreement_sheet/user_agreement_sheet.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/widgets/modal_bottom_sheets/privacy_policy_sheet/cubit/privacy_policy_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/user_agreement_sheet/cubit/user_agreement_sheet_cubit.dart';

part 'accept_cookies_sheet_state.dart';

class AcceptCookiesSheetCubit extends Cubit<AcceptCookiesSheetState> {
  final LocalStorageCubit _localStorageCubit;
  AcceptCookiesSheetCubit({
    required LocalStorageCubit localStorageCubit,
  })  : _localStorageCubit = localStorageCubit,
        super(AcceptCookiesSheetState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize state data.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Emit loading state.
      if (state.status != AcceptCookiesSheetStatus.pageIsLoading) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          failure: Failure.initial(),
          status: AcceptCookiesSheetStatus.pageIsLoading,
        ));
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: AcceptCookiesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('AcceptCookiesSheet --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: AcceptCookiesSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('AcceptCookiesSheet --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: AcceptCookiesSheetStatus.pageHasError,
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
      status: AcceptCookiesSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == AcceptCookiesSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AcceptCookiesSheetStatus.close,
    ));
  }

  // #############################
  // Terms and Condition sheets.
  // #############################

  /// This method can be used to show privacy policy sheet.
  void viewPrivacyPolicy({required BuildContext context}) {
    // * Show PrivacyPolicySheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<PrivacyPolicySheetCubit>(
        create: (context) => PrivacyPolicySheetCubit(
          apiRepository: context.read<ApiRepository>(),
        )..initialize(),
        child: const PrivacyPolicySheet(),
      ),
    );
  }

  /// This method can be used to show user agreement sheet.
  void viewUserAgreement({required BuildContext context}) {
    // * Show UserAgreementSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<UserAgreementSheetCubit>(
        create: (context) => UserAgreementSheetCubit(
          apiRepository: context.read<ApiRepository>(),
        )..initialize(),
        child: const UserAgreementSheet(),
      ),
    );
  }

  // #############################
  // Accept
  // #############################

  /// This method will be triggerd if user wants to accept terms and conditions.
  Future<void> acceptTermsAndConditions() async {
    try {
      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: AcceptCookiesSheetStatus.pageIsLoading,
      ));

      // * Smoother ux.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Create updated settings.
      final Settings updatedSettings = user.settings.copyWith(
        acceptedTermsAndConditions: true,
      );

      // Create updated user.
      final User updatedUser = user.copyWith(
        settings: updatedSettings,
      );

      // Put settings into store.
      await _localStorageCubit.state.database!.writeTxn(() async {
        await _localStorageCubit.updateLocalUser(
          updatedUser: updatedUser,
        );
      });

      // * Make sure that update is respected app wide.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: AcceptCookiesSheetStatus.accept,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('AcceptCookiesSheet --> acceptTermsAndConditions() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: AcceptCookiesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('AcceptCookiesSheet --> acceptTermsAndConditions() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AcceptCookiesSheetStatus.failure,
      ));
    }
  }
}
