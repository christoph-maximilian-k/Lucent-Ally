import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubit.
import 'cubit/contact_support_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';

class ContactSupportSheet extends StatelessWidget {
  const ContactSupportSheet({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ContactSupportSheetCubit, ContactSupportSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ContactSupportSheetStatus.close && current.status == ContactSupportSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == ContactSupportSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != ContactSupportSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ContactSupportSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ContactSupportSheetStatus.pageHasError;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ContactSupportSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ContactSupportSheetCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<ContactSupportSheetCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ContactSupportSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ContactSupportSheetCubit>().closeSheet(),
          // FLoating action button.
          floatingActionBarDisabled: true,
          // Content.
          content: [
            Text(
              labels.contactSupportSheetTitle(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                labels.contactSupportSheetPledge(),
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      labels.contactSupportSheetEmailTitle(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  subtitle: Text(
                    state.supportEmail,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      AppIcons.copy,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => context.read<ContactSupportSheetCubit>().copyToClipboard(
                          context: context,
                          data: state.supportEmail,
                          notification: labels.contactSupportSheetEmailNotification(),
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      labels.contactSupportSheetDetailsTitle(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  subtitle: Text(
                    labels.contactSupportSheetDetails(
                      platform: state.platform,
                      buildNumber: state.buildNumber,
                      version: state.version,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      AppIcons.copy,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => context.read<ContactSupportSheetCubit>().copyToClipboard(
                          context: context,
                          data: labels.contactSupportSheetDetails(
                            platform: state.platform,
                            buildNumber: state.buildNumber,
                            version: state.version,
                          ),
                          notification: labels.contactSupportSheetDetailsNotification(),
                        ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
