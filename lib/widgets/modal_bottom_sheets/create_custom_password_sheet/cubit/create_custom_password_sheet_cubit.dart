import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Labels.
import '/main.dart';

// Cubits.
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/cubit/local_storage_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/secrets/secrets.dart';

part 'create_custom_password_sheet_state.dart';

class CreateCustomPasswordSheetCubit extends Cubit<CreateCustomPasswordSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;

  CreateCustomPasswordSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        super(CreateCustomPasswordSheetState.initial());

  // ############################################
  // # Initialization.
  // ############################################

  /// Initialize local state data.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        passwordExists: user.localGroupsPasswordSet,
        status: CreateCustomPasswordSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: CreateCustomPasswordSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateCustomPasswordSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State.
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Do nothing if state is already set to close.
    if (state.status == CreateCustomPasswordSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      status: CreateCustomPasswordSheetStatus.close,
    ));
  }

  // ############################################
  // # Create Password methods.
  // ############################################

  /// This method will be triggerd if user types in create new password field.
  void onCreatePasswordChanged({required String value, required TextEditingController controller}) {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      newPassword: value,
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user wants to clear the content of the create new password field.
  void onClearCreatePasswordField({required TextEditingController controller}) {
    // Clear the controller.
    controller.clear();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      newPassword: '',
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user types in create new password field.
  void onObsureCreatePasswordChanged() {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      obscure: !state.obscure,
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Update Password methods.
  // ############################################

  /// This method will be triggerd if user types in the update password field.
  void onUpdatePasswordChanged({required String value, required TextEditingController controller}) {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      updatePassword: value,
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user wants to clear the content of the update password field.
  void onClearUpdatePasswordField({required TextEditingController controller}) {
    // Clear the controller.
    controller.clear();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      updatePassword: '',
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user types in update password field.
  void onObscureUpdatePasswordChanged() {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      obscure: !state.obscure,
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Authenticate methods.
  // ############################################

  /// This method will be triggerd if user types in authenticate field.
  void onAuthenticatePasswordChanged({required String value, required TextEditingController controller}) {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      authPassword: value,
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user wants to clear the content of the authenticate password field.
  void onClearAuthenticatePasswordField({required TextEditingController controller}) {
    // Clear the controller.
    controller.clear();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      authPassword: '',
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user types in authenticate field.
  void onObsureAuthenticatePasswordChanged() {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      obscure: !state.obscure,
      failure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Database.
  // ############################################

  /// This method gets triggerd if user wants to save custom password.
  Future<void> confirmSetPassword({required BuildContext context}) async {
    try {
      // Make sure password is not empty.
      // * Use trim here to ensure that password cannot be only spaces.
      // * Sometimes it is better to prohibit something...
      if (state.newPassword.trim().isEmpty) throw Failure.passwordCannotBeEmpty();

      // Make sure password does not exceed 50 chars.
      if (state.newPassword.length > 50) throw Failure.passwordIsTooLong();

      // Show confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.initialScreenAnonConfirmMessage(),
              subtitle: labels.initialScreenAnonInfoMessage(),
            ),
          ) ??
          false;

      // Only emit new states if cubit is still open.
      if (isClosed || confirm == false) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateCustomPasswordSheetStatus.pageIsLoading,
      ));

      // Can be used to set an app password.
      await _localStorageCubit.setAppPassword(password: state.newPassword);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: CreateCustomPasswordSheetStatus.close,
      ));

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.basicLabelsPasswordCreated(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> confirmSetPassword() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateCustomPasswordSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> confirmSetPassword() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateCustomPasswordSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to save custom password.
  Future<void> confirmUpdatePassword({required BuildContext context}) async {
    try {
      // Make sure password is not empty.
      // * Use trim here to ensure that password cannot be only spaces.
      // * Sometimes it is better to prohibit something...
      if (state.updatePassword.trim().isEmpty) throw Failure.passwordCannotBeEmpty();

      // Make sure password does not exceed 50 chars.
      if (state.updatePassword.length > 50) throw Failure.passwordIsTooLong();

      // Show confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.initialScreenAnonConfirmMessage(),
              subtitle: labels.initialScreenAnonInfoMessage(),
            ),
          ) ??
          false;

      // Only emit new states if cubit is still open.
      if (confirm == false) return;

      // Update user created password
      await _localStorageCubit.putValueToSecureStorage(key: Secrets.mapKeyAppPassword, value: state.updatePassword);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: CreateCustomPasswordSheetStatus.close,
      ));

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.basicLabelsPasswordUpdated(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> confirmUpdatePassword() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateCustomPasswordSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> confirmUpdatePassword() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateCustomPasswordSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to authenticate.
  Future<void> authenticate() async {
    try {
      // Make sure password is not empty.
      // * Use trim here to ensure that password cannot be only spaces.
      // * Sometimes it is better to prohibit something...
      if (state.authPassword.trim().isEmpty) throw Failure.passwordCannotBeEmpty();

      // Make sure password does not exceed 50 chars.
      if (state.authPassword.length > 50) throw Failure.passwordIsTooLong();

      // ! This page is loading state update in conjunction with the micro service is needed!
      // ! Otherwise there is a bug which leaves the typed value of the auth input field in the update input field.

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: CreateCustomPasswordSheetStatus.pageIsLoading,
      ));

      // Perform micro service.
      await Future.delayed(const Duration(milliseconds: 500));

      // * Check if provided password is correct.
      // * This method throws failures.
      await _localStorageCubit.validateAppPassword(password: state.authPassword);

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isAuthenticated: true,
        authPassword: '',
        status: CreateCustomPasswordSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> authenticate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isAuthenticated: false,
        failure: failure,
        status: CreateCustomPasswordSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateCustomPasswordSheetCubit --> authenticate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        isAuthenticated: false,
        failure: Failure.genericError(),
        status: CreateCustomPasswordSheetStatus.failure,
      ));
    }
  }
}
