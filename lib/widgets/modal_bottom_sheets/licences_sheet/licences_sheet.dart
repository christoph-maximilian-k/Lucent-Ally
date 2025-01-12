import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/licences_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';

class LicencesSheet extends StatelessWidget {
  const LicencesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LicencesSheetCubit, LicencesSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == LicencesSheetStatus.close && current.status == LicencesSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == LicencesSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != LicencesSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == LicencesSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == LicencesSheetStatus.pageHasError;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<LicencesSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<LicencesSheetCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<LicencesSheetCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<LicencesSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<LicencesSheetCubit>().closeSheet(),
          // Floating action button.
          floatingActionBarDisabled: true,
          // Content.
          content: [
            Text(
              labels.licencesSheetTitle(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 5.0),
            Text(
              labels.licencesSheetPoweredByFlutter(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 25.0),
            ListView.builder(
              itemCount: state.licences.items.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // Convenience variables.
                final String packageName = state.licences.items[index].packageName;
                final int numberOfLicenses = state.licences.items[index].licences.length;

                // Return Licence Items.
                return IntrinsicHeight(
                  child: Card(
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      onTap: () => context.read<LicencesSheetCubit>().showLicences(
                            context: context,
                            licenceItem: state.licences.items[index],
                          ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                packageName,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                labels.licencesSheetNumberOfLicenses(numberOfLicenses: numberOfLicenses),
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
