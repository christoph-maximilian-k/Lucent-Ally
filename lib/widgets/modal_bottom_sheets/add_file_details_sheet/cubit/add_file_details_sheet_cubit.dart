import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/files/file_item.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';

part 'add_file_details_sheet_state.dart';

class AddFileDetailsSheetCubit extends Cubit<AddFileDetailsSheetState> {
  AddFileDetailsSheetCubit() : super(AddFileDetailsSheetState.initial());

  // ############################################
  // Initialization
  // ############################################

  /// Initialize state data.
  Future<void> initialize({required FileItem initialFileItem, required bool isAvatarImage, required bool isImages, required bool isFiles}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isAvatarImage: isAvatarImage,
        isImages: isImages,
        isFiles: isFiles,
        initialFileItem: initialFileItem,
        fileItem: initialFileItem,
        status: AddFileDetailsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddFileDetailsSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isAvatarImage: isAvatarImage,
        isImages: isImages,
        isFiles: isFiles,
        pageFailure: failure,
        status: AddFileDetailsSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddFileDetailsSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: AddFileDetailsSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // State
  // ############################################

  /// This method is used to load image into CustomImageAvatar.
  /// * It primarily serves comsetic reasons. If this is not accessed like that a state update will happen to quickly and UI will look jancky.
  Future<FileItem> imageFuture({required FileItem fileItem}) async {
    // * Necessary to avoid UI delay.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    return fileItem;
  }

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == AddFileDetailsSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AddFileDetailsSheetStatus.waiting,
    ));
  }

  /// This method will be triggered if file title changes.
  void fileTitleChanged({required String value, required TextEditingController controller}) {
    // If user wants to clear data.
    if (value.isEmpty) controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      fileItem: state.fileItem.copyWith(
        title: value,
      ),
    ));
  }

  /// This method will be triggered if file caption changes.
  void fileCaptionChanged({required String value, required TextEditingController controller}) {
    // If user wants to clear data.
    if (value.isEmpty) controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      fileItem: state.fileItem.copyWith(
        caption: value,
      ),
    ));
  }

  /// This method can be used to confirm close this sheet.
  Future<void> confirmCloseSheet({required BuildContext context}) async {
    try {
      // Only emit new state if cubit is still open and not loading.
      if (isClosed || state.status == AddFileDetailsSheetStatus.loading) return;

      // * Check if user has unsaved data.
      final bool? confirm = state.initialFileItem != state.fileItem
          ? await showModalBottomSheet(
              context: context,
              // * This sheet returns either true or null.
              builder: (context) => ConfirmSheet(
                title: labels.basicLabelsUnsavedChanges(),
              ),
            )
          : true;

      // Only emit new state if user confirmed, cubit is still open and cubit is not loading.
      if (confirm == null || isClosed) return;

      emit(state.copyWith(
        status: AddFileDetailsSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddFileDetailsSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: AddFileDetailsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddFileDetailsSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AddFileDetailsSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Only emit new state if user confirmed, cubit is still open and cubit is not loading.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AddFileDetailsSheetStatus.close,
    ));
  }

  /// This method will be called if user wants to save details.
  void onDetailsReady({required BuildContext context}) => Navigator.of(context).pop(state.fileItem);
}
