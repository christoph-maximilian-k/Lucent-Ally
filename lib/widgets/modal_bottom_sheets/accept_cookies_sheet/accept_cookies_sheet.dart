import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/accept_cookies_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_elevated_button.dart';

class AcceptCookiesSheet extends StatelessWidget {
  const AcceptCookiesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptCookiesSheetCubit, AcceptCookiesSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == AcceptCookiesSheetStatus.close && current.status == AcceptCookiesSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == AcceptCookiesSheetStatus.close) Navigator.of(context).pop();

        // Close modal bottom sheet.
        if (state.status == AcceptCookiesSheetStatus.accept) Navigator.of(context).pop(true);
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != AcceptCookiesSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == AcceptCookiesSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == AcceptCookiesSheetStatus.pageHasError;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<AcceptCookiesSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<AcceptCookiesSheetCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<AcceptCookiesSheetCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<AcceptCookiesSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<AcceptCookiesSheetCubit>().closeSheet(),
          // Floating action button.
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsAccept(),
          onFloatingActionBarPressed: () => context.read<AcceptCookiesSheetCubit>().acceptTermsAndConditions(),
          // Content.
          content: [
            Text(
              labels.basicLabelsTermsAndConditions(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                labels.basicLabelsTermsAndConditionsInfoMessage(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(height: 80.0),
            Icon(
              AppIcons.privacyPolicy,
              size: 25.0,
            ),
            const SizedBox(height: 20.0),
            CustomElevatedButton(
              label: labels.privacyPolicySheetTitle(),
              onPressed: () => context.read<AcceptCookiesSheetCubit>().viewPrivacyPolicy(context: context),
            ),
            const SizedBox(height: 60.0),
            Icon(
              AppIcons.userAgreement,
              size: 25.0,
            ),
            const SizedBox(height: 20.0),
            CustomElevatedButton(
              label: labels.userAgreementSheetTitle(),
              onPressed: () => context.read<AcceptCookiesSheetCubit>().viewUserAgreement(context: context),
            ),
          ],
        );
      },
    );
  }
}
