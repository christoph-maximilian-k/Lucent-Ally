import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qr_flutter/qr_flutter.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/display_group_invite_info_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';

class DisplayGroupInviteInfoSheet extends StatelessWidget {
  const DisplayGroupInviteInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Access screen height:
    final double height = MediaQuery.of(context).size.height;

    return BlocConsumer<DisplayGroupInviteInfoSheetCubit, DisplayGroupInviteInfoSheetState>(
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == DisplayGroupInviteInfoSheetStatus.close) Navigator.of(context).pop();
      },
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == DisplayGroupInviteInfoSheetStatus.close && current.status == DisplayGroupInviteInfoSheetStatus.close) return false;

        return true;
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != DisplayGroupInviteInfoSheetStatus.close,
      builder: (context, state) {
        // Cubit states.
        final bool pageIsLoading = state.status == DisplayGroupInviteInfoSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == DisplayGroupInviteInfoSheetStatus.pageHasError;

        return CustomBasePage(
          // State.
          height: height * 0.85,
          isModalSheet: true,
          isScrollable: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<DisplayGroupInviteInfoSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<DisplayGroupInviteInfoSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<DisplayGroupInviteInfoSheetCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<DisplayGroupInviteInfoSheetCubit>().closeSheet(),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<DisplayGroupInviteInfoSheetCubit>().closeSheet(),
          // Floating Action Bar.
          floatingActionBarDisabled: true,
          // Content.
          content: [
            Text(
              labels.basicLabelsInviteToGroup(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 25.0),
            // * Group alias.
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Card(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        labels.groupAlias(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 10.0, bottom: 10.0),
                      child: Text(
                        state.group.alias,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        AppIcons.copy,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () => context.read<DisplayGroupInviteInfoSheetCubit>().copyToClipboard(
                            context: context,
                            value: state.group.alias,
                            notification: labels.aliasCopied(),
                          ),
                    ),
                  ),
                ),
              ),
            ),
            // * Group invite link.
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            labels.groupInviteLink(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 10.0, bottom: 10.0),
                          child: Text(
                            state.inviteLink,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            AppIcons.copy,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () => context.read<DisplayGroupInviteInfoSheetCubit>().copyToClipboard(
                                context: context,
                                value: state.inviteLink,
                                notification: labels.inviteLinkCopied(),
                              ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      if (labels.infoMessageInviteLink(inviteSpecs: state.group.inviteSpecs).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
                          child: Column(
                            children: [
                              Text(
                                labels.basicLabelsAttention(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                labels.infoMessageInviteLink(inviteSpecs: state.group.inviteSpecs),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Card(
                child: Column(
                  children: [
                    const SizedBox(height: 18.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          labels.groupInviteLinkAsQrCode(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    QrImageView(
                      padding: const EdgeInsets.all(20.0),
                      data: state.inviteLink,
                      eyeStyle: QrEyeStyle(color: Theme.of(context).colorScheme.onSurface, eyeShape: QrEyeShape.square),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (Platform.isIOS) const SizedBox(height: 25.0),
          ],
        );
      },
    );
  }
}
