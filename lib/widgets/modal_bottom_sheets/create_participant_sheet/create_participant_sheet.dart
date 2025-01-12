import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// User with Settings and Labels.
import '/main.dart';

// Models.
import '/data/models/members/member.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/create_participant_sheet/cubit/create_participant_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_input_tile.dart';
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_horizontal_divider.dart';

class CreateParticipantSheet extends StatefulWidget {
  const CreateParticipantSheet({super.key});

  @override
  State<CreateParticipantSheet> createState() => _CreateParticipantSheetState();
}

class _CreateParticipantSheetState extends State<CreateParticipantSheet> {
  // Get access to focus scope throughout widget.
  late FocusScopeNode node;

  @override
  void initState() {
    super.initState();

    // Init the node.
    node = FocusScopeNode();
  }

  @override
  void dispose() {
    // Remove focus scope.
    node.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateParticipantSheetCubit, CreateParticipantSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == CreateParticipantSheetStatus.close && current.status == CreateParticipantSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == CreateParticipantSheetStatus.close) Navigator.of(context).pop();

        // * User wants to create a new member.
        if (state.status == CreateParticipantSheetStatus.newMember) {
          context.read<CreateParticipantSheetCubit>().createNewMember(context: context);
        }

        // * User wants to choose from existing members.
        if (state.status == CreateParticipantSheetStatus.existingMember) {
          context.read<CreateParticipantSheetCubit>().chooseFromExistingMembers(context: context);
        }
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != CreateParticipantSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == CreateParticipantSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == CreateParticipantSheetStatus.pageHasError;
        final bool failure = state.status == CreateParticipantSheetStatus.failure;
        final bool loading = state.status == CreateParticipantSheetStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Focus Scope.
          focusScopeNode: node,
          onBasePageTap: () => node.unfocus(),
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<CreateParticipantSheetCubit>().confirmCloseSheet(context: context),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<CreateParticipantSheetCubit>().dismissFailure(),
          // On pop route.
          onHorizontalPopRoute: () => context.read<CreateParticipantSheetCubit>().confirmCloseSheet(context: context),
          // Corner close.
          onCornerClosePressed: () => context.read<CreateParticipantSheetCubit>().confirmCloseSheet(context: context),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<CreateParticipantSheetCubit>().closeSheet(),
          // Close button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<CreateParticipantSheetCubit>().confirmCloseSheet(context: context),
          // Trailing icon button.
          firstTrailingIconButtonIcon: state.isEdit ? AppIcons.moreOptions : null,
          onFirstTrailingIconButtonPressed: () => context.read<CreateParticipantSheetCubit>().showParticipantMenuChoices(context: context),
          // Floating Action Bar.
          actionBarIsLoading: loading,
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsReady(),
          onFloatingActionBarPressed: () {
            // Local Participant.
            if (state.isShared == false) {
              if (state.isEdit) context.read<CreateParticipantSheetCubit>().editLocal();
              if (state.isEdit == false) context.read<CreateParticipantSheetCubit>().createLocal();
              return;
            }

            // Shared Participant.
            if (state.isShared) {
              if (state.isEdit) context.read<CreateParticipantSheetCubit>().editShared();
              if (state.isEdit == false) context.read<CreateParticipantSheetCubit>().createShared();
            }
          },
          // Content.
          content: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AppIcons.participants,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                ),
                const SizedBox(width: 10.0),
                Text(
                  labels.createParticipantSheetTitle(isEdit: state.isEdit),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // * Participant name.
            CustomInputTile(
              textFieldKey: const ValueKey('participant_name'),
              icon: AppIcons.names,
              title: labels.createParticipantSheetParticipantName(),
              hint: labels.createParticipantSheetParticipantHints(),
              initialData: state.participant.participantName,
              shouldRequestFocus: state.isEdit == false && failure == false,
              onChanged: (final String value, final TextEditingController controller) => context.read<CreateParticipantSheetCubit>().updateParticipantName(
                    value: value.trim(),
                    controller: controller,
                  ),
            ),
            // * Members.
            Card(
              child: Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 0.0,
                    leading: Icon(
                      AppIcons.members,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    title: Text(
                      labels.basicLabelsMembers(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          label: labels.createParticipantSheetAddMember(),
                          onPressed: () => context.read<CreateParticipantSheetCubit>().showAddMemberChoice(
                                context: context,
                                node: node,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                          child: Column(
                            children: [
                              // * Display members.
                              if (state.participantMembers.items.isNotEmpty)
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 250.0,
                                  ),
                                  color: Theme.of(context).colorScheme.surface,
                                  margin: const EdgeInsets.all(10.0),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) => const CustomHorizontalDivider(
                                      marginLeft: 10.0,
                                      marginRight: 10.0,
                                    ),
                                    itemCount: state.participantMembers.items.length,
                                    itemBuilder: (context, index) {
                                      final Member member = state.participantMembers.items[index];

                                      return Container(
                                        height: 50.0,
                                        padding: const EdgeInsets.only(left: 20.0, right: 5.0, bottom: 5.0, top: 5.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                member.memberName,
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context).textTheme.displaySmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: IconButton(
                                                onPressed: () => context.read<CreateParticipantSheetCubit>().removeMember(
                                                      context: context,
                                                      member: member,
                                                    ),
                                                icon: Icon(
                                                  AppIcons.delete,
                                                  color: Theme.of(context).colorScheme.error,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
