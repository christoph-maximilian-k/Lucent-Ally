import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/users/user.dart';

// Cubits.
import 'cubit/settings_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/cards/card_menu_item.dart';
import '/widgets/cards/card_main_screen_preview.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsSheetCubit, SettingsSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == SettingsSheetStatus.close && current.status == SettingsSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == SettingsSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != SettingsSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == SettingsSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == SettingsSheetStatus.pageHasError;
        final bool loading = state.status == SettingsSheetStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<SettingsSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<SettingsSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<SettingsSheetCubit>().confirmCloseSheet(context: context),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<SettingsSheetCubit>().closeSheet(),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<SettingsSheetCubit>().confirmCloseSheet(context: context),
          // FLoatingActionButton.
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsReady(),
          actionBarIsLoading: loading,
          onFloatingActionBarPressed: () => context.read<SettingsSheetCubit>().saveSettings(),
          content: [
            CustomHeader(
              icon: AppIcons.appearance,
              title: labels.settingsSheetAppearance(),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardMainScreenPreview(
                    isDark: true,
                    onTap: () => context.read<SettingsSheetCubit>().changeTheme(
                          theme: User.themeDark,
                        ),
                  ),
                  CardMainScreenPreview(
                    isDark: false,
                    onTap: () => context.read<SettingsSheetCubit>().changeTheme(
                          theme: User.themeLight,
                        ),
                  ),
                ],
              ),
            ),
            CustomHeader(
              icon: AppIcons.settings,
              title: labels.settingsSheetSettings(),
            ),
            CardMenuItem(
              title: labels.settingsSheetLanguage(language: state.user.languageLocale),
              leadingIcon: AppIcons.language,
              infoMessage: labels.settingsSheetLanguageInfoMessage(),
              onTap: () => context.read<SettingsSheetCubit>().changeLanguage(context: context),
            ),
            CardMenuItem(
              title: state.user.settings.defaultCurrency.isEmpty? labels.basicLabelsDefaultCurrency() : state.user.settings.defaultCurrency,
              leadingIcon: AppIcons.currency,
              infoMessage: labels.settingsSheetDefaultCurrencyInfoMessage(),
              onTap: () => context.read<SettingsSheetCubit>().changeDefaultCurrency(context: context),
            ),
            CardMenuItem(
              title: labels.settingsSheetMaxTextFieldLines(numberOfLines: state.user.settings.maxLinesForTextFields),
              leadingIcon: AppIcons.fieldTypeText,
              infoMessage: labels.settingsSheetMaxTextFieldLinesInfoMessage(),
              onTap: () => context.read<SettingsSheetCubit>().changeMaxLines(context: context),
            ),
            CardMenuItem(
              title: labels.settingsSheetNotificationDuration(durationInSeconds: state.user.settings.notificationDurationInSeconds),
              leadingIcon: AppIcons.notification,
              infoMessage: labels.settingsSheetNotificationDurationInfoMessage(),
              onTap: () => context.read<SettingsSheetCubit>().changeNotificationDuration(context: context),
            ),
            CustomHeader(
              icon: AppIcons.security,
              title: labels.settingsSheetSecurity(),
            ),
            CardMenuItem(
              title: labels.settingsSheetAutoLogoutAfter(autoLogoutInMinutes: state.user.autoLogoutInMinutes),
              leadingIcon: AppIcons.logout,
              infoMessage: labels.settingsSheetAutoLogoutAfterInfoMessage(),
              onTap: () => context.read<SettingsSheetCubit>().changeAutoLogout(context: context),
            ),
          ],
        );
      },
    );
  }
}
