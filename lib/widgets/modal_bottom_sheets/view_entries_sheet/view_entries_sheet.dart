import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/entries/entry.dart';
import '/data/models/model_entries/model_entry.dart';

// Cubits.
import 'cubit/view_entries_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/cards/card_entry_preview.dart';
import '/widgets/customs/custom_header.dart';

class ViewEntriesSheet extends StatelessWidget {
  const ViewEntriesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewEntriesSheetCubit, ViewEntriesSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ViewEntriesSheetStatus.close && current.status == ViewEntriesSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == ViewEntriesSheetStatus.close) {
          // If a change was made, trigger reload of charts sheet if applicable.
          context.read<ViewEntriesSheetCubit>().refreshChartsSheet();

          // If a change was made, trigger reload of charts sheet if applicable.
          context.read<ViewEntriesSheetCubit>().refreshExpenseReportSheet();

          // Pop the route.
          Navigator.of(context).pop();
        }

        // Close modal bottom sheet.
        if (state.status == ViewEntriesSheetStatus.closeBelow) Navigator.of(context).removeRouteBelow(ModalRoute.of(context)!);

        // * Load more entries.
        if (state.status == ViewEntriesSheetStatus.loadMoreEntries) {
          context.read<ViewEntriesSheetCubit>().loadMoreEntries();
        }
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != ViewEntriesSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ViewEntriesSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ViewEntriesSheetStatus.pageHasError;

        final bool loading = state.status == ViewEntriesSheetStatus.loading;
        final bool loadMoreEntries = state.status == ViewEntriesSheetStatus.loadMoreEntries;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ViewEntriesSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ViewEntriesSheetCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<ViewEntriesSheetCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ViewEntriesSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ViewEntriesSheetCubit>().closeSheet(),
          // Floating action button.
          floatingActionBarDisabled: true,
          // * Load more content.
          onLoadMoreContent: () => context.read<ViewEntriesSheetCubit>().loadMoreEntries(),
          moreContentIsLoading: loadMoreEntries || loading,
          // Content.
          content: [
            CustomHeader(
              icon: AppIcons.fieldTypeTags,
              title: state.title,
              displayAsColumn: true,
            ),
            const SizedBox(height: 10.0),
            // * User a builder to be able to react to state changes.
            Builder(
              builder: (context) {
                // * No entries found.
                if (state.entries.items.isEmpty) {
                  return SizedBox(
                    height: 150.0,
                    child: Center(
                      child: Text(
                        labels.basicLabelsNoEntriesMessage(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  );
                }

                // * Entries are available.
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.entries.items.length,
                      itemBuilder: (context, index) {
                        // Access relevant entries.
                        final Entry entry = state.entries.items[index];
                        final ModelEntry? modelEntry = state.modelEntries.getById(id: entry.modelEntryReference);

                        return CardEntryPreview(
                          isShared: state.isShared,
                          modelEntry: modelEntry,
                          entry: entry,
                          onEntrySelected: (final Entry entry, final ModelEntry modelEntry) => context.read<ViewEntriesSheetCubit>().showEntrySelectedSheet(
                                context: context,
                                entry: entry,
                              ),
                          secondTrailingIcon: AppIcons.copy,
                          onSecondTrailingPressed: (final Entry entry, final ModelEntry modelEntry) async => await context.read<ViewEntriesSheetCubit>().copyToClipboard(
                                context: context,
                                entry: entry,
                                entryModel: modelEntry,
                              ),
                        );
                      },
                    ),
                    // * Show indication that all entries are loaded.
                    if (state.isFinished)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20.0),
                          Icon(
                            AppIcons.finished,
                            color: Theme.of(context).iconTheme.color,
                            size: 20.0,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            labels.noMoreContent(),
                            style: Theme.of(context).textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
