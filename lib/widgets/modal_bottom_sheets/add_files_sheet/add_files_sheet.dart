import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/add_files_sheet_cubit.dart';

// models.
import '/data/models/files/file_item.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_file_avatar.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/customs/custom_image_avatar.dart';

class AddFilesSheet extends StatelessWidget {
  const AddFilesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return BlocConsumer<AddFilesSheetCubit, AddFilesSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == AddFilesSheetStatus.close && current.status == AddFilesSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == AddFilesSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != AddFilesSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == AddFilesSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == AddFilesSheetStatus.pageHasError;
        final bool loading = state.status == AddFilesSheetStatus.loading;

        // * For avatar image only show add button if there is no image already selected.
        final bool hideAddFileButton = state.isAvatarImage && state.files.items.isNotEmpty;

        return CustomBasePage(
          height: height * 0.5,
          isModalSheet: true,
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<AddFilesSheetCubit>().confirmCloseSheet(context: context),
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<AddFilesSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<AddFilesSheetCubit>().dismissFailure(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<AddFilesSheetCubit>().closeSheet(),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<AddFilesSheetCubit>().confirmCloseSheet(
                context: context,
              ),
          isScrollable: false,
          // Trailing Icon Button.
          firstTrailingIconButtonIcon: hideAddFileButton ? null : AppIcons.add,
          onFirstTrailingIconButtonPressed: () {
            // Ensure that button can only be used if it is visible.
            if (hideAddFileButton == false) {
              // User is in avatar image mode.
              if (state.isAvatarImage) context.read<AddFilesSheetCubit>().chooseImageFromGallery();

              // User is in image date mode.
              if (state.isImages) context.read<AddFilesSheetCubit>().chooseImageFromGallery();

              // User is in file data mode.
              if (state.isFiles) context.read<AddFilesSheetCubit>().chooseFileFromDevice();
            }
          },
          // FLoatingActionButton.
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsReady(),
          actionBarIsLoading: loading,
          onFloatingActionBarPressed: () => context.read<AddFilesSheetCubit>().onFilesSelected(context: context),
          content: [
            const SizedBox(height: 20.0),
            CustomHeader(
              icon: state.isAvatarImage
                  ? AppIcons.fieldTypeAvatarImage
                  : state.isImages
                      ? AppIcons.fieldTypeImages
                      : AppIcons.fieldTypeFiles,
              title: labels.addFilesSheetTitle(isAvatarImage: state.isAvatarImage, isImages: state.isImages, isFiles: state.isFiles),
            ),
            Builder(
              builder: (context) {
                // * Show image replacement message.
                if (state.files.getFirstItemHasBytes == false) {
                  return Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 80.0),
                    child: Text(
                      state.isAvatarImage
                          ? labels.basicLabelsNoImageSelected()
                          : state.isImages
                              ? labels.basicLabelsNoImagesSelected()
                              : labels.basicLabelsNoFilesSelected(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  );
                }

                // * User is in avatar image mode.
                if (state.isAvatarImage) {
                  return CustomImageAvatar(
                    fileItem: state.files.items[0],
                    fileItemFuture: () => context.read<AddFilesSheetCubit>().loadFileItem(fileItem: state.files.items[0]),
                    onRemoveImage: () => context.read<AddFilesSheetCubit>().removeFile(index: 0),
                  );
                }

                // * User is in files/images mode.
                return SizedBox(
                  height: 175.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.files.items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // Access File item.
                      final FileItem fileItem = state.files.items[index];

                      if (state.isImages) {
                        return CustomImageAvatar(
                          fileItemFuture: () => context.read<AddFilesSheetCubit>().loadFileItem(fileItem: fileItem),
                          fileItem: fileItem,
                          onRemoveImage: () => context.read<AddFilesSheetCubit>().removeFile(index: index),
                        );
                      }

                      return CustomFileAvatar(
                        fileItem: fileItem,
                        onRemoveFile: () => context.read<AddFilesSheetCubit>().removeFile(index: index),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
