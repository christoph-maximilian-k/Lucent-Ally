import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/model_entries/model_entry.dart';

// Cubits.
import 'cubit/menu_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/cards/card_model_entry_preview.dart';
import '/widgets/cards/card_menu_item.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuSheetCubit, MenuSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == MenuSheetStatus.close && current.status == MenuSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // A close event was triggerd.
        if (state.status == MenuSheetStatus.close) Navigator.of(context).pop();

        // User wants to edit a model entry.
        if (state.status == MenuSheetStatus.editModelEntry) {
          if (state.isShared == false) context.read<MenuSheetCubit>().editLocalModelEntry(context: context);
          if (state.isShared) context.read<MenuSheetCubit>().editSharedModelEntry(context: context);
        }

        // User wants to delete a model entry.
        if (state.status == MenuSheetStatus.deleteModelEntry) {
          if (state.isShared == false) context.read<MenuSheetCubit>().deleteLocalModelEntry(context: context);
          if (state.isShared) context.read<MenuSheetCubit>().deleteSharedModelEntry(context: context);
        }

        // User is in shared mode, show default choice.
        if (state.status == MenuSheetStatus.showDefaultChoice) {
          context.read<MenuSheetCubit>().showDefaultChoice(context: context);
        }

        // User wants to create a default entry for themselves.
        if (state.status == MenuSheetStatus.createDefaultEntrySelf) {
          context.read<MenuSheetCubit>().createDefaultEntry(context: context, isSelfDefault: true);
        }

        // User wants to create a default entry for themselves.
        if (state.status == MenuSheetStatus.createDefaultEntryEveryone) {
          context.read<MenuSheetCubit>().createDefaultEntry(context: context, isSelfDefault: false);
        }

        // User wants to remove thirdline.
        if (state.status == MenuSheetStatus.removeThirdline) {
          context.read<MenuSheetCubit>().removeThirdline(context: context);
        }

        // User wants to remove subtitle.
        if (state.status == MenuSheetStatus.removeSubtitle) {
          context.read<MenuSheetCubit>().removeSubtitle(context: context);
        }
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != MenuSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == MenuSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == MenuSheetStatus.pageHasError;

        return CustomBasePage(
          // State.
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<MenuSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<MenuSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<MenuSheetCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<MenuSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<MenuSheetCubit>().closeSheet(),
          // Floating Action Bar.
          floatingActionBarDisabled: true,
          // GridView.
          displayGridViewTitleAsColumn: false,
          gridViewVisible: true,
          gridViewHasFailure: false,
          gridViewTitle: labels.menuSheetGridViewTitle(),
          gridViewIcon: AppIcons.entryModels,
          gridViewCount: state.entryModels.items.length,
          gridViewBuilder: (context, index) {
            // Convenience variables.
            final ModelEntry modelEntry = state.entryModels.items[index];

            final bool firstAndNeedsPadding = index == 0 && state.entryModels.items.length > 3;
            final bool lastAndNeedsPadding = index == state.entryModels.items.length - 1 && state.entryModels.items.length > 3;
            final bool needsPadding = firstAndNeedsPadding || lastAndNeedsPadding;

            return Container(
              padding: needsPadding == false
                  ? null
                  : firstAndNeedsPadding
                      ? const EdgeInsets.only(left: 15.0)
                      : const EdgeInsets.only(right: 15.0),
              child: CardModelEntryPreview(
                title: modelEntry.modelEntryName,
                subtitle: '',
                onTap: () => context.read<MenuSheetCubit>().showModelEntryChoices(
                      context: context,
                      modelEntry: modelEntry,
                    ),
              ),
            );
          },
          gridViewActionVisible: true,
          gridViewActionLabel: labels.menuSheetCreateEntryModelButton(),
          gridViewActionIcon: AppIcons.add,
          onGridViewActionPressed: () {
            if (state.isShared == false) context.read<MenuSheetCubit>().showCreateLocalModelSheet(context: context);
            if (state.isShared) context.read<MenuSheetCubit>().showCreateSharedModelSheet(context: context);
          },
          // Content.
          content: [
            // * Profile.
            Visibility(
              visible: state.usernameCanChange,
              child: Column(
                children: [
                  CustomHeader(
                    displayAsColumn: false,
                    icon: AppIcons.profile,
                    title: labels.menuSheetHeaderProfile(),
                  ),
                  CardMenuItem(
                    onTap: () => context.read<MenuSheetCubit>().changeUsername(context: context),
                    title: labels.menuSheetChangeUsername(),
                    leadingIcon: AppIcons.fieldTypeUsername,
                  ),
                ],
              ),
            ),
            // * Utilities.
            CustomHeader(
              displayAsColumn: false,
              icon: AppIcons.utility,
              title: labels.menuSheetHeaderUtility(),
            ),
            CardMenuItem(
              onTap: () => context.read<MenuSheetCubit>().showPasswordGeneratorSheet(context: context),
              title: labels.passwordGenerator(),
              leadingIcon: AppIcons.passwordGenerator,
            ),
            // * Do not display in shared mode because functionality is currently only enabled for local mode.
            if (state.isShared == false)
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CardMenuItem(
                  onTap: () => context.read<MenuSheetCubit>().showLocalImportSheet(context: context),
                  title: labels.menuSheetImportDataButton(),
                  leadingIcon: AppIcons.import,
                ),
              ),
            CardMenuItem(
              title: labels.menuSheetExportDataButton(),
              leadingIcon: AppIcons.export,
              onTap: () {
                // * User is in local mode.
                if (state.isShared == false) context.read<MenuSheetCubit>().showLocalExportSheet(context: context);

                // * User is in shared mode.
                if (state.isShared) context.read<MenuSheetCubit>().showSharedExportSheet(context: context);
              },
            ),
            CustomHeader(
              displayAsColumn: false,
              icon: AppIcons.appSettings,
              title: labels.menuSheetHeaderApp(),
            ),
            CardMenuItem(
              title: labels.menuSheetShowSettingsButton(),
              leadingIcon: AppIcons.settings,
              onTap: () => context.read<MenuSheetCubit>().showSettingsSheet(context: context),
            ),
            // * Do not display in shared mode because functionality behind it is ment for local mode.
            if (state.isShared == false)
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: CardMenuItem(
                  onTap: () => context.read<MenuSheetCubit>().showCreateCustomPasswordSheet(context: context),
                  title: labels.menuSheetCreateCustomPassword(),
                  infoMessage: labels.menuSheetCreateCustomPasswordInfoMessage(),
                  leadingIcon: AppIcons.fieldTypePassword,
                ),
              ),
            CardMenuItem(
              onTap: () => context.read<MenuSheetCubit>().showPrivacyPolicySheet(context: context),
              title: labels.menuSheetPrivacyPolicyButton(),
              leadingIcon: AppIcons.privacyPolicy,
            ),
            CardMenuItem(
              onTap: () => context.read<MenuSheetCubit>().showUserAgreementSheet(context: context),
              title: labels.menuSheetUserAgreementButton(),
              leadingIcon: AppIcons.userAgreement,
            ),
            CardMenuItem(
              onTap: () => context.read<MenuSheetCubit>().showLicencesSheet(context: context),
              title: labels.menuSheetAcknowledgementsButton(),
              leadingIcon: AppIcons.licences,
            ),
            CardMenuItem(
              onTap: () => context.read<MenuSheetCubit>().showContactSupportSheet(context: context),
              title: labels.menuSheetContactSupportButton(),
              leadingIcon: AppIcons.support,
            ),
            // * Do not show in shared mode because the functionality behind it is ment to only apply to local mode.
            if (state.isShared == false)
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: CardMenuItem(
                  onTap: () => context.read<MenuSheetCubit>().performLogout(),
                  title: labels.menuSheetLogoutButton(),
                  infoMessage: labels.menuSheetLogoutInfoMessage(minutes: user.autoLogoutInMinutes),
                  leadingIcon: AppIcons.logout,
                  hideTrailingIcon: true,
                ),
              ),
          ],
        );
      },
    );
  }
}
