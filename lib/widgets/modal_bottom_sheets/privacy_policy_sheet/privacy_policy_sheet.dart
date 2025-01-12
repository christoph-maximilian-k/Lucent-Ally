import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/privacy_policy_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';

class PrivacyPolicySheet extends StatelessWidget {
  const PrivacyPolicySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivacyPolicySheetCubit, PrivacyPolicySheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == PrivacyPolicySheetStatus.close && current.status == PrivacyPolicySheetStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == PrivacyPolicySheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != PrivacyPolicySheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == PrivacyPolicySheetStatus.pageIsLoading;
        final bool pageHasError = state.status == PrivacyPolicySheetStatus.pageHasError;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<PrivacyPolicySheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<PrivacyPolicySheetCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<PrivacyPolicySheetCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<PrivacyPolicySheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<PrivacyPolicySheetCubit>().closeSheet(),
          // Floating action button.
          floatingActionBarDisabled: true,
          // Content.
          content: [
            Text(
              labels.privacyPolicySheetTitle(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              width: double.infinity,
              child: Text(
                state.privacyPolicy,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
