import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/add_file_details_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_input_tile.dart';
import '/widgets/customs/custom_file_avatar.dart';
import '/widgets/customs/custom_image_avatar.dart';

class AddFileDetailsSheet extends StatelessWidget {
  const AddFileDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddFileDetailsSheetCubit, AddFileDetailsSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == AddFileDetailsSheetStatus.close && current.status == AddFileDetailsSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == AddFileDetailsSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != AddFileDetailsSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == AddFileDetailsSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == AddFileDetailsSheetStatus.pageHasError;
        final bool loading = state.status == AddFileDetailsSheetStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<AddFileDetailsSheetCubit>().confirmCloseSheet(context: context),
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<AddFileDetailsSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<AddFileDetailsSheetCubit>().dismissFailure(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<AddFileDetailsSheetCubit>().closeSheet(),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<AddFileDetailsSheetCubit>().confirmCloseSheet(
                context: context,
              ),
          // FLoatingActionButton.
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsReady(),
          actionBarIsLoading: loading,
          onFloatingActionBarPressed: () => context.read<AddFileDetailsSheetCubit>().onDetailsReady(context: context),
          // Content.
          content: [
            if (state.isImages || state.isAvatarImage)
              CustomImageAvatar(
                fileItemFuture: () => context.read<AddFileDetailsSheetCubit>().imageFuture(fileItem: state.fileItem),
                fileItem: state.fileItem,
                shouldReload: false,
              ),
            if (state.isFiles)
              CustomFileAvatar(
                fileItem: state.fileItem,
              ),
            const SizedBox(height: 20.0),
            CustomInputTile(
              textFieldKey: const ValueKey('file_title'),
              icon: AppIcons.names,
              title: labels.addImageDetailsImageTitle(isImage: state.isAvatarImage || state.isImages),
              initialData: state.fileItem.title,
              // Trailing Icon.
              trailingIcon: AppIcons.delete,
              trailingIconColor: Theme.of(context).colorScheme.error,
              onTrailingIconPressed: (final TextEditingController controller, _) => context.read<AddFileDetailsSheetCubit>().fileTitleChanged(
                    value: '',
                    controller: controller,
                  ),
              // On Title changed.
              onChanged: (final String value, final TextEditingController controller) => context.read<AddFileDetailsSheetCubit>().fileTitleChanged(
                    value: value.trim(),
                    controller: controller,
                  ),
            ),
            CustomInputTile(
              textFieldKey: const ValueKey('file_caption'),
              icon: AppIcons.edit,
              title: labels.caption(isImage: state.isAvatarImage || state.isImages),
              initialData: state.fileItem.caption,
              maxLines: 15,
              // Trailing Icon.
              trailingIcon: AppIcons.delete,
              trailingIconColor: Theme.of(context).colorScheme.error,
              onTrailingIconPressed: (final TextEditingController controller, _) => context.read<AddFileDetailsSheetCubit>().fileCaptionChanged(
                    value: '',
                    controller: controller,
                  ),
              // On Caption changed.
              onChanged: (final String value, final TextEditingController controller) => context.read<AddFileDetailsSheetCubit>().fileCaptionChanged(
                    value: value.trim(),
                    controller: controller,
                  ),
            ),
            const SizedBox(height: 10.0),
          ],
        );
      },
    );
  }
}
