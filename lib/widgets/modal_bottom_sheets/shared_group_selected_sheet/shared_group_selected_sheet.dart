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
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/cards/card_group_preview.dart';
import '/widgets/cards/card_entry_preview.dart';

// TODO: Let users request/deny access to a group (new_feature).
// TODO: Let users specify restrictions on who can join with "permissionRestricted" (new_feature).

class SharedGroupSelectedSheet extends StatelessWidget {
  const SharedGroupSelectedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharedGroupSelectedSheetCubit, SharedGroupSelectedSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == SharedGroupSelectedSheetStatus.close && current.status == SharedGroupSelectedSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // Close modal bottom sheet.
        if (state.status == SharedGroupSelectedSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != SharedGroupSelectedSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == SharedGroupSelectedSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == SharedGroupSelectedSheetStatus.pageHasError;

        final bool loading = state.status == SharedGroupSelectedSheetStatus.loading;
        final bool isFetchingEntries = state.status == SharedGroupSelectedSheetStatus.isFetchingEntries;

        // * Add permissions alway get checked in the currently selected group because adds are about
        // * subsequent entries.
        final bool userHasEntryAddPermission = state.group.userHasEntryAddPermissions(
          isShared: true,
          topLevelGroupOwner: state.topLevelGroupOwner,
        );

        // * Add permissions alway get checked in the currently selected group because adds are about
        // * subsequent subgroups.
        final bool userHasSubgroupAddPermission = state.group.userHasSubgroupAddPermissions(
          isShared: true,
          topLevelGroupOwner: state.topLevelGroupOwner,
        );

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<SharedGroupSelectedSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<SharedGroupSelectedSheetCubit>().dismissFailure(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<SharedGroupSelectedSheetCubit>().closeSheet(),
          // On horizontal gesture.
          onHorizontalPopRoute: () => context.read<SharedGroupSelectedSheetCubit>().closeSheet(),
          // Leading Icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<SharedGroupSelectedSheetCubit>().closeSheet(),
          // First trailing icon button.
          firstTrailingIconButtonIcon: AppIcons.moreOptions,
          onFirstTrailingIconButtonPressed: () {
            // * User has a subgroup selected.
            if (state.group.getIsSharedSubgroupType) {
              context.read<SharedGroupSelectedSheetCubit>().onSubgroupOptionsPressed(
                    context: context,
                  );
              return;
            }

            // * User has a top level group selected.
            if (state.group.getIsSharedGroupType) {
              context.read<SharedGroupSelectedSheetCubit>().onGroupOptionsPressed(
                    context: context,
                  );
              return;
            }
          },
          // Floating action bar.
          floatingActionBarDisabled: userHasEntryAddPermission == false && userHasSubgroupAddPermission == false,
          actionBarIsLoading: loading,
          floatingActionBarIcon: AppIcons.add,
          floatingActionBarLabel: labels.basicLabelsAdd(),
          onFloatingActionBarPressed: () => context.read<SharedGroupSelectedSheetCubit>().showSelectOptionSheet(context: context),
          onLongPressFloatingActionBar: () => context.read<SharedGroupSelectedSheetCubit>().onQuickAddAction(context: context),
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
            final Group group = state.subgroups.items[index];

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
                key: ValueKey(group.groupId), // * Prevents unneeded rebuilds.
                group: group,
                onTap: (final Group group) => context.read<SharedGroupSelectedSheetCubit>().showSubgroupSelectedSheet(
                      context: context,
                      group: group,
                    ),
              ),
            );
          },
          // * Refreshable.
          isRefreshable: true,
          onRefresh: () async {
            if (state.group.getIsSharedGroupType) {
              context.read<SharedGroupSelectedSheetCubit>().refreshTopLevelGroup();
              return;
            }

            if (state.group.getIsSharedSubgroupType) {
              context.read<SharedGroupSelectedSheetCubit>().refreshSubgroup();
              return;
            }
          },
          // * Content.
          moreContentIsLoading: isFetchingEntries,
          onLoadMoreContent: () => context.read<SharedGroupSelectedSheetCubit>().loadMoreEntries(),
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
                          isShared: true,
                          rootGrouOwner: state.topLevelGroupOwner,
                          getCloudUserFuture: () => context.read<SharedGroupSelectedSheetCubit>().getCloudUser(entryCreator: entry.entryCreator),
                          modelEntry: modelEntry,
                          entry: entry,
                          onEntrySelected: (final Entry entry, final ModelEntry modelEntry) => context.read<SharedGroupSelectedSheetCubit>().showEntrySelectedSheetWithPageView(
                                context: context,
                                entry: entry,
                                entryIndex: index,
                              ),
                          secondTrailingIcon: AppIcons.copy,
                          onSecondTrailingPressed: (final Entry entry, final ModelEntry modelEntry) async => await context.read<SharedGroupSelectedSheetCubit>().copyToClipboard(
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
