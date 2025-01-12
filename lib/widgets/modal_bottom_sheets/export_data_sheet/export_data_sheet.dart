import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/export_data_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/cards/card_menu_item.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/customs/custom_horizontal_divider.dart';
import '/widgets/cards/card_error.dart';
import '/widgets/customs/custom_loading_spinner.dart';

class ExportDataSheet extends StatelessWidget {
  const ExportDataSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExportDataSheetCubit, ExportDataSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ExportDataSheetStatus.close && current.status == ExportDataSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // A close event was triggerd.
        if (state.status == ExportDataSheetStatus.close) Navigator.of(context).pop();

        // A share file event was triggered.
        if (state.status == ExportDataSheetStatus.shareFile) context.read<ExportDataSheetCubit>().shareFile(filePath: state.sharedFilePath);

        // A load files event was triggered.
        if (state.loadFilesStatus == LoadFilesStatus.loading) context.read<ExportDataSheetCubit>().loadFiles();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != ExportDataSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ExportDataSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ExportDataSheetStatus.pageHasError;
        final bool loading = state.status == ExportDataSheetStatus.loading;

        final bool filesAreLoading = state.loadFilesStatus == LoadFilesStatus.loading;
        final bool filesFailure = state.loadFilesStatus == LoadFilesStatus.failure;

        return CustomBasePage(
          // State.
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          pageIsLoadingMessage: state.loadingMessage,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ExportDataSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ExportDataSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<ExportDataSheetCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ExportDataSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ExportDataSheetCubit>().closeSheet(),
          // Floating Action Bar.
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsExport(),
          actionBarIsLoading: loading,
          floatingActionBarDisabled: state.topLevelGroups.items.isEmpty,
          onFloatingActionBarPressed: () {
            // * User is in local mode.
            if (state.isShared == false) context.read<ExportDataSheetCubit>().conductLocalExport();

            // * User is in shared mode.
            if (state.isShared) context.read<ExportDataSheetCubit>().conductSharedExport();
          },
          // Content.
          content: [
            CustomHeader(
              icon: AppIcons.export,
              title: labels.exportData(),
              displayAsColumn: false,
            ),
            const SizedBox(height: 20.0),
            Builder(
              builder: (context) {
                // * In case there are no groups to export, display info message.
                if (state.topLevelGroups.items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                    child: Text(
                      labels.noGroupsForExport(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                }

                // * User is in shared mode.
                if (state.isShared) {
                  return Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            children: [
                              const SizedBox(width: 20.0),
                              Text(
                                labels.exportsleft(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              const Spacer(),
                              Text(
                                state.sharedExportsLeft.toString(),
                              ),
                              const SizedBox(width: 20.0),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          labels.sharedExportsLimitsInfoMessage(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      const CustomHorizontalDivider(marginAll: 15.0),
                      const SizedBox(height: 10.0),
                      CardMenuItem(
                        title: labels.basicLabelsChooseGroup(groupName: state.topLevelGroup.groupName),
                        leadingIcon: AppIcons.groups,
                        infoMessage: labels.exportDataInfoMessage(),
                        onTap: () => context.read<ExportDataSheetCubit>().chooseTopLevelGroup(
                              context: context,
                            ),
                      ),
                      if (state.subgroups.items.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: CardMenuItem(
                                  title: labels.basicLabelsChooseSubgroup(groupName: state.subgroup.groupName),
                                  leadingIcon: AppIcons.groups,
                                  onTap: () => context.read<ExportDataSheetCubit>().chooseSubgroup(
                                        context: context,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                                child: IconButton(
                                  icon: Icon(
                                    AppIcons.delete,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  onPressed: () => context.read<ExportDataSheetCubit>().removeSubgroup(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (state.selectedGroup.groupName.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Builder(
                            builder: (context) {
                              // Files are currently loading.
                              if (filesAreLoading) {
                                return CustomLoadingSpinner(
                                  loadingMessage: labels.checkingForFiles(),
                                );
                              }

                              // An error occurred while loading files.
                              if (filesFailure) {
                                return CardError(
                                  showCard: false,
                                  failure: state.loadFileFailure,
                                  buttonLabel: labels.basicLabelsTryAgain(),
                                  onButtonPressed: () => context.read<ExportDataSheetCubit>().retryLoadFiles(),
                                );
                              }

                              // Check if files are available.
                              if (state.filePaths.isEmpty) {
                                return Column(
                                  children: [
                                    Text(
                                      labels.basicLabelsAvailableFiles(),
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      labels.basicLabelsNoExportedFilesFound(),
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ],
                                );
                              }

                              // Display files.
                              return Column(
                                children: [
                                  Text(
                                    labels.basicLabelsAvailableFiles(),
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: 20.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    height: 150.0,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.filePaths.length,
                                      itemBuilder: (context, index) {
                                        // Access path.
                                        final String filePath = state.filePaths[index];
                                        final String basename = path.basename(filePath);

                                        return Column(
                                          children: [
                                            Container(
                                              height: 100.0,
                                              width: 100.0,
                                              padding: const EdgeInsets.only(right: 5.0),
                                              child: Card(
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Text(
                                                      basename,
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context).textTheme.labelSmall,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    AppIcons.share,
                                                  ),
                                                  onPressed: () => context.read<ExportDataSheetCubit>().shareFile(filePath: filePath),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    AppIcons.delete,
                                                  ),
                                                  onPressed: () => context.read<ExportDataSheetCubit>().deleteFile(
                                                        filePath: filePath,
                                                        context: context,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  );
                }

                // * User is in local mode.
                return Column(
                  children: [
                    CardMenuItem(
                      title: labels.basicLabelsChooseGroup(groupName: state.topLevelGroup.groupName),
                      leadingIcon: AppIcons.groups,
                      infoMessage: labels.exportDataInfoMessage(),
                      onTap: () => context.read<ExportDataSheetCubit>().chooseTopLevelGroup(
                            context: context,
                          ),
                    ),
                    if (state.subgroups.items.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: CardMenuItem(
                                title: labels.basicLabelsChooseSubgroup(groupName: state.subgroup.groupName),
                                leadingIcon: AppIcons.groups,
                                onTap: () => context.read<ExportDataSheetCubit>().chooseSubgroup(
                                      context: context,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                              child: IconButton(
                                icon: Icon(
                                  AppIcons.delete,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                onPressed: () => context.read<ExportDataSheetCubit>().removeSubgroup(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (state.selectedGroup.groupName.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Builder(
                          builder: (context) {
                            // Files are currently loading.
                            if (filesAreLoading) {
                              return CustomLoadingSpinner(
                                loadingMessage: labels.checkingForFiles(),
                              );
                            }

                            // An error occurred while loading files.
                            if (filesFailure) {
                              return CardError(
                                showCard: false,
                                failure: state.loadFileFailure,
                                buttonLabel: labels.basicLabelsTryAgain(),
                                onButtonPressed: () => context.read<ExportDataSheetCubit>().retryLoadFiles(),
                              );
                            }

                            // Check if files are available.
                            if (state.filePaths.isEmpty) {
                              return Column(
                                children: [
                                  Text(
                                    labels.basicLabelsAvailableFiles(),
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    labels.basicLabelsNoExportedFilesFound(),
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              );
                            }

                            // Display files.
                            return Column(
                              children: [
                                Text(
                                  labels.basicLabelsAvailableFiles(),
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  height: 150.0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.filePaths.length,
                                    itemBuilder: (context, index) {
                                      // Access path.
                                      final String filePath = state.filePaths[index];
                                      final String basename = path.basename(filePath);

                                      return Column(
                                        children: [
                                          Container(
                                            height: 100.0,
                                            width: 100.0,
                                            padding: const EdgeInsets.only(right: 5.0),
                                            child: Card(
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    basename,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context).textTheme.labelSmall,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  AppIcons.share,
                                                ),
                                                onPressed: () => context.read<ExportDataSheetCubit>().shareFile(filePath: filePath),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  AppIcons.delete,
                                                ),
                                                onPressed: () => context.read<ExportDataSheetCubit>().deleteFile(
                                                      filePath: filePath,
                                                      context: context,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
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
