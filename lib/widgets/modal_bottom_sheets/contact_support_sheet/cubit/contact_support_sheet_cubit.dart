import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Config.
import '/config/app_durations.dart';

// Repositories.
import '/data/repositories/api/api_repository.dart';

// Cubits.
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';

// Models.
import '/data/models/failure.dart';

part 'contact_support_sheet_state.dart';

class ContactSupportSheetCubit extends Cubit<ContactSupportSheetState> with HelperFunctions {
  final ApiRepository _apiRepository;
  final AppMessagesCubit _appMessagesCubit;

  ContactSupportSheetCubit({
    required ApiRepository apiRepository,
    required AppMessagesCubit appMessagesCubit,
  })  : _apiRepository = apiRepository,
        _appMessagesCubit = appMessagesCubit,
        super(ContactSupportSheetState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize state data.
  Future<void> initialize() async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Emit loading state.
      if (state.status != ContactSupportSheetStatus.pageIsLoading) {
        // Only emit new states if cubit is open.
        if (isClosed) return;

        emit(state.copyWith(
          failure: Failure.initial(),
          status: ContactSupportSheetStatus.pageIsLoading,
        ));
      }

      // Access Package info.
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      // Access Platform.
      final String platform = getCurrentPlatform();

      // Access build number.
      final String buildNumber = packageInfo.buildNumber;

      // Access version.
      final String version = packageInfo.version;

      // * Send the support ticket.
      final String supportEmail = await _apiRepository.getSupportEmail();

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        supportEmail: supportEmail,
        buildNumber: buildNumber,
        platform: platform,
        version: version,
        status: ContactSupportSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('ContactSupportSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: ContactSupportSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('ContactSupportSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ContactSupportSheetStatus.pageHasError,
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
      status: ContactSupportSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == ContactSupportSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ContactSupportSheetStatus.close,
    ));
  }

  /// This method can be used to copy a value to clipboard.
  Future<void> copyToClipboard({required BuildContext context, required String data, required String notification}) async {
    try {
      // Set data to clipboard.
      await Clipboard.setData(ClipboardData(text: data));

      // Display notification.
      _appMessagesCubit.showNotification(
        message: notification,
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ContactSupportSheetCubit --> copyToClipboard() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ContactSupportSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ContactSupportSheetCubit --> copyToClipboard() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ContactSupportSheetStatus.failure,
      ));
    }
  }
}
