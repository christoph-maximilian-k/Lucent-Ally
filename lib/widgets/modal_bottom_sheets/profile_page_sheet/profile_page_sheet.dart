import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucent_ally/widgets/cards/card_menu_item.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/profile_page_sheet_cubit.dart';

// Models.
import '/data/models/files/file_item.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_image_avatar.dart';

// TODO: instead of like this, change that this is just another version of entry selected

class ProfilePageSheet extends StatelessWidget {
  const ProfilePageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageSheetCubit, ProfilePageSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ProfilePageSheetStatus.close && current.status == ProfilePageSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // A close event was triggerd.
        if (state.status == ProfilePageSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != ProfilePageSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ProfilePageSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ProfilePageSheetStatus.pageHasError;

        return CustomBasePage(
          // State.
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ProfilePageSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ProfilePageSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<ProfilePageSheetCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ProfilePageSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ProfilePageSheetCubit>().closeSheet(),
          // Floating Action Bar.
          floatingActionBarDisabled: true,
          // Content.
          content: [
            CustomImageAvatar(
              isCircular: true,
              fileItemFuture: () => context.read<ProfilePageSheetCubit>().loadAvatar(),
              fileItem: state.avatar,
            ),
            const SizedBox(height: 20.0),
            Text(
              user.username,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            CardMenuItem(
              padding: const EdgeInsets.only(top: 20.0),
              onTap: () => context.read<ProfilePageSheetCubit>().changeUsername(context: context),
              title: labels.menuSheetChangeUsername(),
              leadingIcon: AppIcons.fieldTypeUsername,
            ),
          ],
        );
      },
    );
  }
}
