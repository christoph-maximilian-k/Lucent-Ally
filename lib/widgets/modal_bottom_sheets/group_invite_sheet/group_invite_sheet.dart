import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/group_invite_sheet/cubit/group_invite_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_input_tile.dart';

class GroupInviteSheet extends StatelessWidget {
  const GroupInviteSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupInviteSheetCubit, GroupInviteSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == GroupInviteSheetStatus.closeWithoutData && current.status == GroupInviteSheetStatus.closeWithoutData) return false;
        if (previous.status == GroupInviteSheetStatus.closeWithData && current.status == GroupInviteSheetStatus.closeWithData) return false;

        return true;
      },
      listener: (context, state) async {
        // Validate invite.
        if (state.status == GroupInviteSheetStatus.validate) {
          context.read<GroupInviteSheetCubit>().validateCloudGroupInvite();
        }

        // User wants to close this sheet without joining a group.
        if (state.status == GroupInviteSheetStatus.closeWithoutData) {
          context.read<GroupInviteSheetCubit>().closeWithoutData(context: context);
        }

        // User wants to close this sheet and join the group.
        if (state.status == GroupInviteSheetStatus.closeWithData) {
          context.read<GroupInviteSheetCubit>().closeWithData(context: context);
        }
      },
      // * Do not rebuild widget if status was set to close or validate to improve UX.
      buildWhen: (context, state) {
        if (state.status == GroupInviteSheetStatus.closeWithoutData) return false;
        if (state.status == GroupInviteSheetStatus.closeWithData) return false;
        if (state.status == GroupInviteSheetStatus.validate) return false;
        return true;
      },
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == GroupInviteSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == GroupInviteSheetStatus.pageHasError;
        final bool loading = state.status == GroupInviteSheetStatus.loading;

        // Convenience variables.
        final bool limitIsExhausted = state.group.inviteSpecs.usageLimit != null && state.group.inviteSpecs.usageLimit! <= 0;
        final bool inviteIsExpired = state.group.inviteSpecs.expirationDateInUtc != null && state.group.inviteSpecs.expirationDateInUtc!.isBefore(DateTime.now().toUtc());

        return CustomBasePage(
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          pageIsLoadingMessage: labels.groupInviteSheetIsLoadingMessage(),
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<GroupInviteSheetCubit>().closeWithoutData(context: context),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<GroupInviteSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<GroupInviteSheetCubit>().closeWithoutData(context: context),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<GroupInviteSheetCubit>().closeWithoutData(context: context),
          // Corner close button.
          onCornerClosePressed: () => context.read<GroupInviteSheetCubit>().closeWithoutData(context: context),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<GroupInviteSheetCubit>().closeWithoutData(context: context),
          // Floating Action Bar.
          actionBarIsLoading: loading,
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.groupInviteSheetMainButton(pinRequired: state.pinRequired),
          floatingActionBarDisabled: limitIsExhausted || inviteIsExpired,
          onFloatingActionBarPressed: () {
            // * A Pin is required, check if user has the correct pin.
            if (state.pinRequired) context.read<GroupInviteSheetCubit>().triggerValidation();

            // * A pin is not required, let user join.
            if (state.pinRequired == false) context.read<GroupInviteSheetCubit>().joinGroup();
          },
          // Content.
          content: [
            const SizedBox(height: 20.0),
            Icon(
              AppIcons.groups,
              color: Theme.of(context).iconTheme.color,
              size: 40.0,
            ),
            const SizedBox(height: 20.0),
            Builder(
              builder: (context) {
                // * Let user know that the max limit for this group has been reached.
                if (limitIsExhausted) {
                  return Column(
                    children: [
                      Text(
                        labels.infoMessageGroupLimitReached(),
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }

                // * Let user know that invite has expired.
                if (inviteIsExpired) {
                  return Column(
                    children: [
                      Text(
                        labels.infoMessageGroupInviteLinkExpired(),
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }

                // * To join this group, a pin is required.
                if (state.pinRequired) {
                  return Column(
                    children: [
                      Text(
                        labels.groupInviteSheetTitlePinRequired(),
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      CustomInputTile(
                        textFieldKey: const ValueKey('access_pin'),
                        icon: AppIcons.fieldTypePassword,
                        title: labels.groupInviteSheetAccessPin(),
                        initialData: state.group.accessPin,
                        infoMessage: labels.groupInviteSheetAccessPinInfoMessage(),
                        onChanged: (final String value, final TextEditingController controller) => context.read<GroupInviteSheetCubit>().accessPinChanged(
                              value: value.trim(),
                              controller: controller,
                            ),
                        onSubmitted: (final String value, final TextEditingController controller) => context.read<GroupInviteSheetCubit>().triggerValidation(),
                      ),
                    ],
                  );
                }

                // * A pin is not required to join this group.
                return Column(
                  children: [
                    Text(
                      labels.groupInviteSheetTitle(),
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            state.group.groupName,
                            style: Theme.of(context).textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        state.group.groupDescription.isEmpty ? labels.groupInviteSheetNoDescription() : state.group.groupDescription,
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
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
