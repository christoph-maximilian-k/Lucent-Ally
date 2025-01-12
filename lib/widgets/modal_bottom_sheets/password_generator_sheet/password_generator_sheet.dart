import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_elevated_button.dart';

// Cubits.
import 'cubit/password_generator_cubit.dart';

class PasswordGeneratorSheet extends StatelessWidget {
  const PasswordGeneratorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordGeneratorCubit, PasswordGeneratorState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == PasswordGeneratorStatus.close && current.status == PasswordGeneratorStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == PasswordGeneratorStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != PasswordGeneratorStatus.close,
      builder: (context, state) {
        // Convenience variables.
        final bool pageIsLoading = state.status == PasswordGeneratorStatus.pageIsLoading;
        final bool pageHasError = state.status == PasswordGeneratorStatus.pageHasError;
        final bool initializeData = state.status == PasswordGeneratorStatus.initializeData;
        final bool loading = state.status == PasswordGeneratorStatus.loading;

        return CustomBasePage(
          isModalSheet: true,

          // Page loading.
          pageIsLoading: pageIsLoading || initializeData,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<PasswordGeneratorCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<PasswordGeneratorCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<PasswordGeneratorCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<PasswordGeneratorCubit>().closeSheet(),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<PasswordGeneratorCubit>().closeSheet(),
          // Floating action bar.
          floatingActionBarDisabled: true,
          actionBarIsLoading: loading,
          // Content.
          content: [
            CustomHeader(
              icon: AppIcons.passwordGenerator,
              title: labels.passwordGenerator(),
              displayAsColumn: false,
            ),
            // * Options.
            Card(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
                    horizontalTitleGap: 5.0,
                    leading: Icon(
                      AppIcons.settings,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          labels.passwordGeneratorOptions(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  CustomSwitchListTile(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0),
                    title: labels.passwordGeneratorLowerCaseLetters(),
                    value: state.passwordGenerator.usesLowerCase,
                    onChanged: (_) => context.read<PasswordGeneratorCubit>().lowerCaseChanged(),
                  ),
                  CustomSwitchListTile(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0),
                    title: labels.passwordGeneratorUpperCaseLetters(),
                    value: state.passwordGenerator.usesUpperCase,
                    onChanged: (_) => context.read<PasswordGeneratorCubit>().upperCaseChanged(),
                  ),
                  CustomSwitchListTile(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0),
                    title: labels.passwordGeneratorSymbols(),
                    value: state.passwordGenerator.usesSymbols,
                    onChanged: (_) => context.read<PasswordGeneratorCubit>().symbolsChanged(),
                  ),
                  CustomSwitchListTile(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0),
                    title: labels.passwordGeneratorNumbers(),
                    value: state.passwordGenerator.usesNumbers,
                    onChanged: (_) => context.read<PasswordGeneratorCubit>().numbersChanged(),
                  ),
                ],
              ),
            ),
            // * Generated password length.
            Card(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
                    horizontalTitleGap: 5.0,
                    leading: Icon(
                      AppIcons.length,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          labels.passwordGeneratorCurrentPasswordLength(length: state.passwordGenerator.passwordLength),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          '${state.passwordGenerator.minPasswordLength}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: state.passwordGenerator.passwordLength.toDouble(),
                          min: state.passwordGenerator.minPasswordLength.toDouble(),
                          max: state.passwordGenerator.maxPasswordLength.toDouble(),
                          activeColor: Theme.of(context).colorScheme.onSurface,
                          inactiveColor: Theme.of(context).colorScheme.surface,
                          thumbColor: Theme.of(context).colorScheme.secondary,
                          onChangeEnd: (final double value) => context.read<PasswordGeneratorCubit>().rerollGeneratedPassword(),
                          onChanged: (final double value) => context.read<PasswordGeneratorCubit>().updatePasswordLength(length: value.toInt()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          '${state.passwordGenerator.maxPasswordLength}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // * Generated password.
            SizedBox(
              height: 190.0,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
                      horizontalTitleGap: 5.0,
                      leading: Icon(
                        AppIcons.generatePassword,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: Theme.of(context).primaryIconTheme.size,
                      ),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            labels.passwordGeneratorGeneratePassword(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(
                              state.generatedPassword,
                              style: Theme.of(context).textTheme.displayMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.read<PasswordGeneratorCubit>().rerollGeneratedPassword(),
                          icon: Icon(
                            AppIcons.refresh,
                            color: Theme.of(context).primaryIconTheme.color,
                            size: Theme.of(context).primaryIconTheme.size,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomElevatedButton(
                      margin: const EdgeInsets.all(10.0),
                      label: labels.passwordGeneratorCopyPassword(),
                      onPressed: () => context.read<PasswordGeneratorCubit>().copyPassword(
                            context: context,
                          ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
