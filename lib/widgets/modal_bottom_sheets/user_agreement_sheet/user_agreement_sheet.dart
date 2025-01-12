import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/user_agreement_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';

class UserAgreementSheet extends StatelessWidget {
  const UserAgreementSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAgreementSheetCubit, UserAgreementSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == UserAgreementSheetStatus.close && current.status == UserAgreementSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == UserAgreementSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != UserAgreementSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == UserAgreementSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == UserAgreementSheetStatus.pageHasError;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<UserAgreementSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<UserAgreementSheetCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<UserAgreementSheetCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<UserAgreementSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<UserAgreementSheetCubit>().closeSheet(),
          // Floating action button.
          floatingActionBarDisabled: true,
          // Content.
          content: [
            Text(
              labels.userAgreementSheetTitle(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              width: double.infinity,
              child: Text(
                state.userAgreement,
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
