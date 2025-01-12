import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/entries/entry.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/groups/group.dart';

// Cubits.
import 'cubit/main_screen_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/cubit/local_storage_cubit.dart';

// Widgets.
import '/widgets/logo/logo.dart';
import '/widgets/cards/card_entry_preview.dart';
import '/widgets/cards/card_group_preview.dart';
import '/widgets/customs/custom_title_bar.dart';
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_loading_spinner.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  /// The route name for navigation purposes.
  /// ```dart
  /// static const String routeName = '/main-screen';
  /// ```
  static const String routeName = '/main-screen';

  /// Main screen route.
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<MainScreenCubit>(
        create: (_) => MainScreenCubit(
          localStorageCubit: context.read<LocalStorageCubit>(),
          appMessagesCubit: context.read<AppMessagesCubit>(),
        )..initialize(),
        child: const MainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppMessagesCubit, AppMessagesState>(
      // * This listener has to be supplied here because Overlay needs a context below MaterialApp.
      listener: (context, appMessagesState) {
        // * Display a notification overlay.
        if (appMessagesState.status == AppMessagesStatus.showNotification) {
          context.read<AppMessagesCubit>().displayNotificationOverlay(
                context: context,
                durationInSeconds: user.settings.notificationDurationInSeconds,
              );
        }
      },
      child: BlocListener<LocalStorageCubit, LocalStorageState>(
        listener: (context, localStorageState) {
          // * This will close encrypted groups if they are in the foreground.
          if (localStorageState.status == LocalStorageStatus.logout) {
            context.read<LocalStorageCubit>().onLogoutEvent(context: context);
          }

          // * User navigated from a deep link and app was NOT booted.
          if (localStorageState.status == LocalStorageStatus.deepLink) {
            context.read<MainScreenCubit>().handleGroupInvite(
                  context: context,
                  groupAlias: localStorageState.lastDeepLinkArgs['alias'],
                );
          }

          // * Show protected entries changed.
          if (localStorageState.status == LocalStorageStatus.showProtectedEntriesChanged) {
            context.read<MainScreenCubit>().onShowProtectedEntriesChanged();
          }
        },
        child: BlocConsumer<MainScreenCubit, MainScreenState>(
          listener: (context, state) {
            // * A reload recent entries event was triggered.
            if (state.status == MainScreenStatus.reloadRecentEntries) {
              if (state.isShared == false) context.read<MainScreenCubit>().reloadLocalRecentEntries();
              if (state.isShared) context.read<MainScreenCubit>().reloadSharedRecentEntries();
            }

            // * A deep link event was triggered and app WAS booted with it.
            if (state.status == MainScreenStatus.deepLink) {
              context.read<MainScreenCubit>().handleGroupInvite(
                    context: context,
                    groupAlias: context.read<LocalStorageCubit>().state.lastDeepLinkArgs['alias'],
                  );
            }
          },
          // * Do not build if this is a deep link event so UI does not fuck up.
          buildWhen: (previous, current) => current.status != MainScreenStatus.deepLink,
          builder: (context, state) {
            // Convenience variables.
            final bool pageIsLoading = state.status == MainScreenStatus.pageIsLoading;
            final bool pageHasError = state.status == MainScreenStatus.pageHasError;
            final bool loading = state.status == MainScreenStatus.loading;
            final bool reloadRecentEntries = state.status == MainScreenStatus.reloadRecentEntries;

            return CustomBasePage(
              isModalSheet: false,
              // Ensure that this screen cannot be popped.
              canPop: false,
              // Page is loading.
              pageIsLoading: pageIsLoading,
              showPageLoadingButton: state.showCancleButton,
              onPageLoadingButtonLabel: labels.basicLabelsCancle(),
              onPageLoadingButtonPressed: () => context.read<MainScreenCubit>().cancleRequest(),
              // Refresh page.
              isRefreshable: state.isShared,
              onRefresh: () async => context.read<MainScreenCubit>().refreshSharedMode(),
              // Page Failure.
              pageHasError: pageHasError,
              pageFailure: state.pageFailure,
              pageErrorButtonLabel: labels.basicLabelsTryAgain(),
              // * Page error can only occur if local mode gets initialized.
              onPageErrorButtonPressed: () => context.read<MainScreenCubit>().initialize(),
              // Common Failure.
              failure: state.failure,
              onDismissFailure: () => context.read<MainScreenCubit>().dismissFailure(),
              // Leading Icon Button.
              leadingIconButtonIcon: AppIcons.menu,
              onLeadingIconButtonPressed: () {
                if (state.isShared) context.read<MainScreenCubit>().showSharedMenuSheet(context: context);
                if (state.isShared == false) context.read<MainScreenCubit>().showLocalMenuSheet(context: context);
              },
              // First trailing IconButton.
              firstTrailingIconButtonIcon: state.isShared == false ? AppIcons.search : AppIcons.moreOptions,
              onFirstTrailingIconButtonPressed: () {
                if (state.isShared == false) context.read<MainScreenCubit>().showSearchSheet(context: context);
                if (state.isShared) context.read<MainScreenCubit>().showSharedGroupsOptions(context: context);
              },
              // Floating Action Bar.
              actionBarIsLoading: loading,
              floatingActionBarIcon: AppIcons.add,
              floatingActionBarLabel: labels.mainScreenFloatingActionBarLabel(),
              onFloatingActionBarPressed: () => context.read<MainScreenCubit>().showGroupDecisionSheet(context: context),
              // App Bar.
              appBarWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Logo(
                    size: 45.0,
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                  const Spacer(),
                  CustomDropDownButton(
                    label: labels.mainScreenGroupsDropDownButtonLabel(isShared: state.isShared),
                    onTap: () => context.read<MainScreenCubit>().groupsDropDownPressed(context: context),
                  )
                ],
              ),
              // * GridView.
              gridViewVisible: state.groups.items.isNotEmpty,
              // * Grid view cannot have failure because if groups fail to be retreived either pageError or
              // * last succesfull state is emmitted.
              gridViewHasFailure: false,
              gridViewCount: state.groups.items.length,
              gridViewBuilder: (context, index) {
                // Convenience variables.
                final Group group = state.groups.items[index];
                final String groupId = group.groupId;

                final bool firstAndNeedsPadding = index == 0 && state.groups.items.length > 3;
                final bool lastAndNeedsPadding = index == state.groups.items.length - 1 && state.groups.items.length > 3;
                final bool needsPadding = firstAndNeedsPadding || lastAndNeedsPadding;

                return Container(
                  padding: needsPadding == false
                      ? null
                      : firstAndNeedsPadding
                          ? const EdgeInsets.only(left: 15.0)
                          : const EdgeInsets.only(right: 15.0),
                  child: CardGroupPreview(
                    key: ValueKey(groupId), // * This prevents unneeded rebuilds.
                    group: group,
                    onTap: (final Group tappedGroup) {
                      // * User is in local mode.
                      if (state.isShared == false) {
                        context.read<MainScreenCubit>().showLocalGroupSelectedSheet(
                              context: context,
                              group: tappedGroup,
                            );
                      }

                      // * User is in shared mode.
                      if (state.isShared) {
                        context.read<MainScreenCubit>().showSharedGroupSelectedSheet(
                              context: context,
                              group: tappedGroup,
                            );
                      }
                    },
                  ),
                );
              },
              // * Content.
              moreContentIsLoading: state.moreContentIsLoading,
              onLoadMoreContent: () {
                // * User has selected local state.
                if (state.isShared == false) context.read<MainScreenCubit>().loadMoreLocalRecentEntries();

                // * User has selected shared state.
                if (state.isShared) context.read<MainScreenCubit>().loadMoreSharedRecentEntries();
              },
              content: [
                CustomTitleBar(
                  title: labels.mainScreenRecentItems(),
                  // ! Currently options are only visible if encrypted values exist and user is in local mode.
                  onMoreOptionsPressed: state.isShared == false && state.protectedGroupIds.isNotEmpty
                      ? () => context.read<MainScreenCubit>().showRecentEntriesOptions(
                            context: context,
                          )
                      : null,
                ),
                // * Use builder to enable react to state changes.
                Builder(
                  builder: (context) {
                    // * Show a loading spinner if reloadRecentEntries was triggered.
                    if (reloadRecentEntries) {
                      return const SizedBox(
                        height: 50.0,
                        child: CustomLoadingSpinner(),
                      );
                    }

                    // * No entries available.
                    if (state.recentEntries.items.isEmpty) {
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
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.recentEntries.items.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // Access relevant entry.
                            final Entry entry = state.recentEntries.items[index];
                            final ModelEntry? modelEntry = state.modelEntries.getById(id: entry.modelEntryReference);

                            return CardEntryPreview(
                              // * Indications.
                              isShared: state.isShared,
                              // * Data.
                              modelEntry: modelEntry,
                              entry: entry,
                              // * User.
                              getCloudUserFuture: () => context.read<MainScreenCubit>().getCloudUser(
                                    entryCreator: entry.entryCreator,
                                  ),

                              // * Second trailing icon.
                              secondTrailingIcon: AppIcons.copy,
                              onSecondTrailingPressed: (final Entry entry, final ModelEntry modelEntry) async => await context.read<MainScreenCubit>().copyToClipboard(
                                    context: context,
                                    entry: entry,
                                    entryModel: modelEntry,
                                  ),
                              // * On entry selected.
                              onEntrySelected: (final Entry entry, final ModelEntry modelEntry) {
                                // * User is in local mode.
                                if (state.isShared == false) {
                                  context.read<MainScreenCubit>().showLocalEntrySelectedSheet(
                                        context: context,
                                        entry: entry,
                                      );
                                }

                                // * User is in shared mode.
                                if (state.isShared) {
                                  context.read<MainScreenCubit>().showSharedEntrySelectedSheet(
                                        context: context,
                                        entry: entry,
                                      );
                                }
                              },
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
        ),
      ),
    );
  }
}
