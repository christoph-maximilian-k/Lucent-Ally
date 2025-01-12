import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/groups/group.dart';
import '/data/models/entries/entry.dart';
import '/data/models/model_entries/model_entry.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/cards/card_group_preview.dart';
import '/widgets/cards/card_entry_preview.dart';

class LocalGroupSelectedSheet extends StatelessWidget {
  const LocalGroupSelectedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalGroupSelectedSheetCubit, LocalGroupSelectedSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == LocalGroupSelectedSheetStatus.close && current.status == LocalGroupSelectedSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == LocalGroupSelectedSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != LocalGroupSelectedSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == LocalGroupSelectedSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == LocalGroupSelectedSheetStatus.pageHasError;
        final bool loading = state.status == LocalGroupSelectedSheetStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageIsLoadingMessage: state.loadingMessageGroupDelete,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<LocalGroupSelectedSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<LocalGroupSelectedSheetCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<LocalGroupSelectedSheetCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<LocalGroupSelectedSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<LocalGroupSelectedSheetCubit>().closeSheet(),
          // First trailing icon button.
          firstTrailingIconButtonIcon: AppIcons.moreOptions,
          onFirstTrailingIconButtonPressed: () => context.read<LocalGroupSelectedSheetCubit>().onGroupOptionsPressed(context: context),
          // Floating Action Bar.
          actionBarIsLoading: loading,
          floatingActionBarIcon: AppIcons.add,
          floatingActionBarLabel: labels.groupSelectedSheetAddEntries(),
          onFloatingActionBarPressed: () => context.read<LocalGroupSelectedSheetCubit>().showAddToGroupOptions(context: context),
          onLongPressFloatingActionBar: () => context.read<LocalGroupSelectedSheetCubit>().onQuickAddAction(context: context),
          // AppBar.
          appBarWidget: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    AppIcons.groups,
                    color: Theme.of(context).iconTheme.color,
                    size: Theme.of(context).iconTheme.size,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    state.group.getGroupTypeLabel,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.group.groupName,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ],
          ),
          // * GridView.
          gridViewVisible: state.subgroups.items.isNotEmpty,
          // * Grid view cannot have failure because if subgroups fail to be retreived either pageError or
          // * last succesfull state is emmitted.
          gridViewHasFailure: false,
          gridViewCount: state.subgroups.items.length,
          gridViewBuilder: (context, index) {
            // Convenience variables.
            final Group subgroup = state.subgroups.items[index];
            final String groupId = subgroup.groupId;

            final bool firstAndNeedsPadding = index == 0 && state.subgroups.items.length > 3;
            final bool lastAndNeedsPadding = index == state.subgroups.items.length - 1 && state.subgroups.items.length > 3;
            final bool needsPadding = firstAndNeedsPadding || lastAndNeedsPadding;

            return Container(
              padding: needsPadding == false
                  ? null
                  : firstAndNeedsPadding
                      ? const EdgeInsets.only(left: 15.0)
                      : const EdgeInsets.only(right: 15.0),
              child: CardGroupPreview(
                key: ValueKey(groupId), // * Prevents unneeded rebuilds.
                group: subgroup,
                onTap: (final Group group) => context.read<LocalGroupSelectedSheetCubit>().showSubgroupSelectedSheet(
                      context: context,
                      group: group,
                    ),
              ),
            );
          },
          // Content.
          moreContentIsLoading: state.moreContentIsLoading,
          onLoadMoreContent: () => context.read<LocalGroupSelectedSheetCubit>().loadMoreEntries(),
          content: [
            // * User a builder to be able to react to state changes.
            Builder(
              builder: (context) {
                // * Group is empty, meaning there are no entries and no subgroups.
                if (state.getIsGroupEmpty) {
                  return SizedBox(
                    height: 150.0,
                    child: Center(
                      child: Text(
                        labels.basicLabelsEmptyGroup(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  );
                }

                // * This group does not have entries but it has subgroups.
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
                          isShared: false,
                          modelEntry: modelEntry,
                          entry: entry,
                          onEntrySelected: (final Entry entry, final ModelEntry modelEntry) => context.read<LocalGroupSelectedSheetCubit>().showEntrySelectedSheetWithPageView(
                                context: context,
                                entry: entry,
                                entryIndex: index,
                              ),
                          secondTrailingIcon: AppIcons.copy,
                          onSecondTrailingPressed: (final Entry entry, final ModelEntry modelEntry) async => await context.read<LocalGroupSelectedSheetCubit>().copyToClipboard(
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
