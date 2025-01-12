import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Labels.
import '/main.dart';

// Repositories.
import '/data/repositories/files/file_repository.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/files/files.dart';
import '/data/models/files/file_item.dart';
import '/data/models/entries/entry.dart';
import '/data/models/groups/group.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';

part 'add_files_sheet_state.dart';

class AddFilesSheetCubit extends Cubit<AddFilesSheetState> {
  final FileRepository _fileRepository;
  final LocalStorageCubit _localStorageCubit;

  AddFilesSheetCubit({
    required FileRepository fileRepository,
    required LocalStorageCubit localStorageCubit,
  })  : _fileRepository = fileRepository,
        _localStorageCubit = localStorageCubit,
        super(AddFilesSheetState.initial());

  // ############################################
  // Initialization
  // ############################################

  /// Initialize state data.
  Future<void> initialize({required Files initialFiles, required Group fromGroup, required Entry entry, required String fieldId, required bool isAvatarImage, required bool isImages, required bool isFiles}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        fromGroup: fromGroup,
        entry: entry,
        fieldId: fieldId,
        isEdit: initialFiles.getFirstItemHasBytes,
        isAvatarImage: isAvatarImage,
        isFiles: isFiles,
        isImages: isImages,
        initialFiles: initialFiles,
        files: initialFiles,
        status: AddFilesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddFilesSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: AddFilesSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddFilesSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: AddFilesSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // State
  // ############################################

  /// This method can be used to load images from file system.
  Future<FileItem?> loadFileItem({required FileItem? fileItem}) async {
    // * Make UX smoother.
    await Future.delayed(const Duration(milliseconds: 100));

    return await _localStorageCubit.loadLocalFileItem(fromGroup: state.fromGroup, fileItem: fileItem);
  }

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == AddFilesSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AddFilesSheetStatus.waiting,
    ));
  }

  /// This method can be used to close add images sheet with a confirm message.
  Future<void> confirmCloseSheet({required BuildContext context}) async {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == AddFilesSheetStatus.loading) return;

    // * Check if user has unsaved data.
    final bool? confirm = state.initialFiles != state.files
        ? await showModalBottomSheet(
            context: context,
            // * This sheet returns either true or null.
            builder: (context) => ConfirmSheet(
              title: labels.addImagesSheetConfirmCloseSheet(isEdit: state.isEdit),
            ),
          )
        : true;

    // Only emit new state if user confirmed, cubit is still open and cubit is not loading.
    if (confirm == null || isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AddFilesSheetStatus.close,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AddFilesSheetStatus.close,
    ));
  }

  /// This method can be used to choose an image from gallery.
  Future<void> chooseImageFromGallery() async {
    try {
      // Only emit states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: AddFilesSheetStatus.loading,
      ));

      // Access a file.
      final FileItem? fileItem = await _fileRepository.selectImageFromDevice(entryId: state.entry.entryId, fieldId: state.fieldId);

      // No file was chosen.
      if (fileItem == null) {
        // Revert state.
        emit(state.copyWith(
          status: AddFilesSheetStatus.waiting,
        ));

        return;
      }

      // Create new images object.
      final Files updatedFiles = state.files.add(fileItem: fileItem);

      // Only emit states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        files: updatedFiles,
        status: AddFilesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddFilesSheetCubit --> chooseImageFromGallery() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: AddFilesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddFilesSheetCubit --> chooseImageFromGallery() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AddFilesSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to choose a file from gallery.
  Future<void> chooseFileFromDevice() async {
    try {
      // Only emit states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: AddFilesSheetStatus.loading,
      ));

      // Access file.
      final FileItem? fileItem = await _fileRepository.selectFileFromDevice(entryId: state.entry.entryId, fieldId: state.fieldId);

      // No file was chosen.
      if (fileItem == null) {
        // Revert state.
        emit(state.copyWith(
          status: AddFilesSheetStatus.waiting,
        ));

        return;
      }

      // Update files.
      final Files updatedFiles = state.files.add(fileItem: fileItem);

      // Only emit states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        files: updatedFiles,
        status: AddFilesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddFilesSheetCubit --> chooseFileFromDevice() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: AddFilesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddFilesSheetCubit --> chooseFileFromDevice() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AddFilesSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to remove a chosen image.
  void removeFile({required int index}) {
    // Create new images object.
    final Files updatedFiles = state.files.remove(index: index);

    // Only emit states if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      files: updatedFiles,
      status: AddFilesSheetStatus.waiting,
    ));
  }

  /// This method will be triggered if user is done selecting images.
  void onFilesSelected({required BuildContext context}) => Navigator.of(context).pop(state.files);
}
