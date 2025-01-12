import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Labels.
import '/main.dart';

// Cubit.
import 'cubit/group_decision_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_text_button.dart';
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_cupertino_picker.dart';

class GroupDecisionSheet extends StatefulWidget {
  const GroupDecisionSheet({super.key});

  @override
  State<GroupDecisionSheet> createState() => _GroupDecisionSheetState();
}

class _GroupDecisionSheetState extends State<GroupDecisionSheet> {
  // Variables.
  final FixedExtentScrollController fixedExtentScrollController = FixedExtentScrollController();

  @override
  void dispose() {
    // fixedExtentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size.
    final Size size = MediaQuery.of(context).size;

    return BlocConsumer<GroupDecisionSheetCubit, GroupDecisionSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == GroupDecisionSheetStatus.close && current.status == GroupDecisionSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // Close modal bottom sheet.
        if (state.status == GroupDecisionSheetStatus.close) Navigator.of(context).pop();

        // * If a new group was created, move scroll weel to created item.
        if (state.status == GroupDecisionSheetStatus.updateScrollWeel) {
          context.read<GroupDecisionSheetCubit>().jumpToScrollWeelItem(
                fixedExtentScrollController: fixedExtentScrollController,
              );
        }

        // * If user creates a group, entry decision sheet should show.
        if (state.status == GroupDecisionSheetStatus.showEntryDecisionSheet) {
          // * User is in local mode.
          if (state.isShared == false) {
            context.read<GroupDecisionSheetCubit>().showLocalEntryDecisionSheet(
                  context: context,
                );
          }

          // * User is in shared mode.
          if (state.isShared) {
            context.read<GroupDecisionSheetCubit>().showSharedEntryDecisionSheet(
                  context: context,
                );
          }
        }
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != GroupDecisionSheetStatus.close,
      builder: (context, state) {
        // Convenience variables.
        final bool pageIsLoading = state.status == GroupDecisionSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == GroupDecisionSheetStatus.pageHasError;

        final int numberOfGroups = state.groups.items.length;

        return SizedBox(
          height: size.height * 0.5,
          child: CustomBasePage(
            isModalSheet: true,
            isScrollable: false,
            floatingActionBarDisabled: true,
            pageIsLoading: pageIsLoading,
            // Page Failure.
            pageHasError: pageHasError,
            pageFailure: state.pageFailure,
            pageErrorButtonLabel: labels.basicLabelsClose(),
            onPageErrorButtonPressed: () => context.read<GroupDecisionSheetCubit>().closeSheet(),
            // Common Failure.
            failure: state.failure,
            onDismissFailure: () => context.read<GroupDecisionSheetCubit>().dismissFailure(),
            // Close while loading.
            onCloseWhilePageLoadingButtonPressed: () => context.read<GroupDecisionSheetCubit>().closeSheet(),
            // On horizontal gesture.
            onHorizontalPopRoute: () => context.read<GroupDecisionSheetCubit>().closeSheet(),
            // Content.
            content: [
              SizedBox(
                height: size.height * 0.5,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      labels.groupDecisionSheetTitle(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Expanded(
                      child: numberOfGroups == 0
                          ? Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  labels.groupDecisionSheetEmptyGroupsMessage(isShared: state.isShared),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            )
                          : CustomCupertinoPicker(
                              // * Data.
                              groups: state.groups,
                              // * In this case supply a fixedExtentScrollController from parent because
                              // * on group creation it is needed.
                              fixedExtentScrollController: fixedExtentScrollController,
                              // * Wheel methods.
                              onSelectedItemChanged: (final int index, _) => context.read<GroupDecisionSheetCubit>().updateSelectedGroup(
                                    index: index,
                                  ),
                            ),
                    ),
                    if (numberOfGroups != 0)
                      CustomElevatedButton(
                        margin: const EdgeInsets.all(15.0),
                        label: labels.basicLabelsChoose(),
                        onPressed: () {
                          // * User is in local mode.
                          if (state.isShared == false) {
                            context.read<GroupDecisionSheetCubit>().showLocalEntryDecisionSheet(context: context);
                          }

                          // * User is in shared mode.
                          if (state.isShared) {
                            context.read<GroupDecisionSheetCubit>().showSharedEntryDecisionSheet(context: context);
                          }
                        },
                      ),
                    CustomTextButton(
                      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 25.0),
                      label: labels.groupDecisionSheetCreateNewGroup(),
                      onPressed: () {
                        // * User is in local mode.
                        if (state.isShared == false) {
                          context.read<GroupDecisionSheetCubit>().showCreateLocalGroupSheet(
                                context: context,
                              );
                        }

                        // * User is in shared mode.
                        if (state.isShared) {
                          context.read<GroupDecisionSheetCubit>().showCreateSharedGroupSheet(
                                context: context,
                              );
                        }
                      },
                    ),
                    if (Platform.isIOS) const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
