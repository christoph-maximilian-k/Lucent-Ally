import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

// User with Settings and Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/secrets/secrets.dart';
import '/data/models/entries/entry.dart';
import '/data/models/failure.dart';
import '/data/models/files/file_item.dart';
import '/data/models/files/files.dart';
import '/data/models/groups/group.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';

// Pages.
import '/pages/view_files_page/view_files_page.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';

part 'view_files_page_state.dart';

class ViewFilesPageCubit extends Cubit<ViewFilesPageState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;

  ViewFilesPageCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    // Access these values on cubit creation.
    required ViewFilesPageArguments arguments,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        // * These needs to be supplied here to be available in ViewFilesPageState.initial().
        // ! Attention! Leads to errors if supplied in initialize() because create page will be called before initialze() is called.
        super(ViewFilesPageState.initial(arguments: arguments));

  // ############################################
  // State
  // ############################################

  /// This method can be used to load images from file system.
  Future<FileItem?> loadFileItem({required FileItem? fileItem}) async {
    return await _localStorageCubit.loadLocalFileItem(fromGroup: state.fromGroup, fileItem: fileItem);
  }

  /// This method can be used to close this sheet.
  void closePage() {
    // Do nothing if state is already set to close.
    if (state.status == ViewFilesPageStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ViewFilesPageStatus.close,
    ));
  }

  /// This method will be triggerd if user changes the page.
  void onPageChanged({required int index}) {
    try {
      // Do nothing if state items have not been initialized yet.
      if (state.files.items.isEmpty) return;

      // Access fileItem.
      final FileItem fielItem = state.files.items[index];

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        currentFileItem: fielItem,
        currentPage: index,
        status: ViewFilesPageStatus.failure,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onPageChanged() --> failure: ${failure.toString()}');
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onPageChanged() --> exception: ${exception.toString()}');
    }
  }

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ViewFilesPageStatus.waiting,
    ));
  }

  /// This method gets triggerd if user interact with the interactive view.
  void onZoomStart() {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      pageViewPhysics: NeverScrollableScrollPhysics(),
    ));
  }

  /// This method gets triggerd if user interact with the interactive view.
  void onZoomEnd({required TransformationController controller}) {
    // Do not update physics if user is zoomed in.
    if (controller.value.getMaxScaleOnAxis() > 1) return;

    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      pageViewPhysics: BouncingScrollPhysics(),
    ));
  }

  /// This method will be triggered if user tabs on page.
  void onTap() {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      overlayVisible: !state.overlayVisible,
    ));
  }

  /// This method will be triggered if user tabs on page.
  void onDoubleTap({required BuildContext context, required TransformationController transformationController, required TapDownDetails details}) {
    try {
      // Disable this feature if files are displayed.
      if (state.isFiles) return;

      // Check if user is zoomed.
      final bool isZoomed = transformationController.value.getMaxScaleOnAxis() > 1;

      // * User is already zoomed in, reset.
      if (isZoomed) {
        // Reset zoom.
        transformationController.value = Matrix4.identity();

        // Only emit states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          pageViewPhysics: BouncingScrollPhysics(),
        ));
      } else {
        final position = details.localPosition;

        // For a 3x zoom
        transformationController.value = Matrix4.identity()
          ..translate(-position.dx * 2, -position.dy * 2)
          ..scale(3.0);

        // Only emit states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          pageViewPhysics: NeverScrollableScrollPhysics(),
        ));
      }
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onDoubleTap() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ViewFilesPageStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onDoubleTap() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ViewFilesPageStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user swipes down on base page.
  void onBasePageSwipedDown({required DragStartDetails startDetails, required DragUpdateDetails updateDetails, required TransformationController transformationController}) {
    try {
      // Check if user is zoomed.
      final bool isZoomed = transformationController.value.getMaxScaleOnAxis() > 1;

      // If user is zoomed in, do nothing.
      if (isZoomed) return;

      // Track the vertical movement (y-axis).
      final double swipeDistance = updateDetails.localPosition.dy - startDetails.localPosition.dy;

      // Check if the swipe distance is greater than 150px.
      if (swipeDistance > 110) {
        // Only emit states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          status: ViewFilesPageStatus.close,
        ));
      }
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onBasePageSwipedDown() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ViewFilesPageStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onBasePageSwipedDown() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ViewFilesPageStatus.failure,
      ));
    }
  }

  /// This method is triggerd if user wants to view file options.
  Future<void> onMenuPressed({required BuildContext context}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Share file.
          optionOne: labels.basicLabelsShare(),
          optionOneIcon: AppIcons.share,
        ),
      );

      // * User wants to share file.
      if (option == 1) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          status: ViewFilesPageStatus.shareFile,
        ));
      }
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onMenuPressed() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ViewFilesPageStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> onMenuPressed() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ViewFilesPageStatus.failure,
      ));
    }
  }

  /// This method can be used to share files.
  Future<void> shareFile({required FileItem fileItem}) async {
    try {
      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: ViewFilesPageStatus.loading,
        loadingMessage: state.fromGroup.isEncrypted ? labels.decryptingFile() : '',
      ));

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access file path of file.
      final String filePath = await _localStorageCubit.createLocalFilePath(
        groupId: state.fromGroup.groupId,
        relativePath: fileItem.relativePath,
      );

      // Sanitize name.
      String sanitizedName = fileItem.title.replaceAll(' ', '_').replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');

      // Ensure that name is not empty.
      if (sanitizedName.isEmpty) {
        if (state.isFiles) sanitizedName = labels.basicLabelsFile();
        if (state.isFiles == false) sanitizedName = labels.basicLabelsImage();
      }

      // Read the bytes from local storage.
      final Uint8List? bytes = await _localStorageCubit.getLocalFileBytes(
        filePath: filePath,
        secrets: secrets,
        isEncrypted: state.fromGroup.isEncrypted,
      );

      // Ensure that bytes were accessed.
      if (bytes == null) throw Failure.genericError();

      // Create a temporary directory and file path.
      final String tempDir = Directory.systemTemp.path;
      final String tempFilePath = path.join(tempDir, '$sanitizedName.${fileItem.type}');

      // Write the bytes to a temporary file.
      final File tempFile = File(tempFilePath);

      // Populate temp file.
      await tempFile.writeAsBytes(bytes);

      // Share the file from the temporary path.
      final XFile xfile = XFile(tempFile.path);

      // Let user share the file.
      // * This also enables saveing it to local file system.
      final ShareResult shareResult = await Share.shareXFiles(
        [xfile],
      );

      // Cleanup: Delete the temporary file after sharing.
      await tempFile.delete();

      // Show a success mesage.
      if (shareResult.status == ShareResultStatus.success) {
        _appMessagesCubit.showNotification(message: labels.basicLabelsSuccess());
      }

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: ViewFilesPageStatus.waiting, // * Reset state!
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> shareFile() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ViewFilesPageStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewFilesPageCubit --> shareFile() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ViewFilesPageStatus.failure,
      ));
    }
  }
}
