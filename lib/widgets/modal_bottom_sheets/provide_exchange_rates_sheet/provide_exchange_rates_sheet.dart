import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// User with Settings and Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/provide_exchange_rates_sheet/cubit/provide_exchange_rates_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_header.dart';

// Models.
import '/data/models/entries/entry.dart';

class ProvideExchangeRatesSheet extends StatelessWidget {
  const ProvideExchangeRatesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProvideExchangeRatesSheetCubit, ProvideExchangeRatesSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ProvideExchangeRatesSheetStatus.close && current.status == ProvideExchangeRatesSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == ProvideExchangeRatesSheetStatus.close) Navigator.of(context).pop();

        // * Load more entries.
        if (state.status == ProvideExchangeRatesSheetStatus.loadMoreEntries) {
          context.read<ProvideExchangeRatesSheetCubit>().loadMoreEntriesWithInvalidExchangeRates();
        }
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != ProvideExchangeRatesSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ProvideExchangeRatesSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ProvideExchangeRatesSheetStatus.pageHasError;
        final bool loading = state.status == ProvideExchangeRatesSheetStatus.loading;
        final bool loadMoreEntries = state.status == ProvideExchangeRatesSheetStatus.loadMoreEntries;

        return CustomBasePage(
          key: const ValueKey('provide_exchange_rates_sheet'),
          isModalSheet: true,
          pageIsLoading: pageIsLoading,
          // * Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ProvideExchangeRatesSheetCubit>().closeSheet(),
          // * Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ProvideExchangeRatesSheetCubit>().dismissFailure(),
          // * Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ProvideExchangeRatesSheetCubit>().closeSheet(),
          // Horizontal swipe to close.
          onHorizontalPopRoute: () => context.read<ProvideExchangeRatesSheetCubit>().closeSheet(),
          // * Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ProvideExchangeRatesSheetCubit>().closeSheet(),
          // * Floating Action Bar.
          floatingActionBarDisabled: true,
          // * Load more content.
          onLoadMoreContent: () => context.read<ProvideExchangeRatesSheetCubit>().loadMoreEntriesWithInvalidExchangeRates(),
          moreContentIsLoading: loadMoreEntries || loading,
          // * Content.
          content: [
            CustomHeader(
              icon: AppIcons.error,
              title: labels.basicLabelsInvalidEntries(),
              displayAsColumn: false,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                labels.invalidEntriesInfoMessage(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 10.0),
            // * User a builder to be able to react to state changes.
            Builder(
              builder: (context) {
                // * State does not have invalid entries available.
                if (state.invalidEntries.items.isEmpty) {
                  // * If entries are empty but state is currently loading or about to load, show nothing.
                  if (loadMoreEntries || loading) return const SizedBox.shrink();

                  // * Otherwise shows done screen.
                  return SizedBox(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 50.0,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          labels.infoMessageNoInvalidExchangeRatesFound(),
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40.0),
                        CustomElevatedButton(
                          label: labels.basicLabelsReady(),
                          onPressed: () => context.read<ProvideExchangeRatesSheetCubit>().onFinish(),
                        ),
                      ],
                    ),
                  );
                }

                // * Entries are available.
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.invalidEntries.items.length,
                  itemBuilder: (context, index) {
                    // Access relevant entries.
                    final Entry entry = state.invalidEntries.items[index];

                    return Container(
                      height: 60.0,
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Card(
                        child: InkWell(
                          onTap: () => context.read<ProvideExchangeRatesSheetCubit>().showEntrySheet(
                                context: context,
                                entry: entry,
                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(
                                      entry.entryName,
                                      style: Theme.of(context).textTheme.labelSmall,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
