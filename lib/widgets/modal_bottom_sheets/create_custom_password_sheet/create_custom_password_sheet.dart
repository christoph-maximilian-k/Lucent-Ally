import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/create_custom_password_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/customs/custom_input_tile.dart';

class CreateCustomPasswordSheet extends StatelessWidget {
  const CreateCustomPasswordSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCustomPasswordSheetCubit, CreateCustomPasswordSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == CreateCustomPasswordSheetStatus.close && current.status == CreateCustomPasswordSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // A close event was triggerd.
        if (state.status == CreateCustomPasswordSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != CreateCustomPasswordSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == CreateCustomPasswordSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == CreateCustomPasswordSheetStatus.pageHasError;

        return CustomBasePage(
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<CreateCustomPasswordSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<CreateCustomPasswordSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<CreateCustomPasswordSheetCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<CreateCustomPasswordSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<CreateCustomPasswordSheetCubit>().closeSheet(),
          // Floating Action Bar.
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsReady(),
          onFloatingActionBarPressed: () {
            // * A password was not set yet.
            if (state.passwordExists == false) {
              context.read<CreateCustomPasswordSheetCubit>().confirmSetPassword(
                    context: context,
                  );
            }

            // * A password has been set.
            if (state.passwordExists) {
              if (state.isAuthenticated == false) context.read<CreateCustomPasswordSheetCubit>().authenticate();
              if (state.isAuthenticated) context.read<CreateCustomPasswordSheetCubit>().confirmUpdatePassword(context: context);
            }
          },
          // Content.
          content: [
            CustomHeader(
              icon: AppIcons.fieldTypePassword,
              title: labels.createCustomPasswordSheetTitle(),
              displayAsColumn: false,
            ),
            const SizedBox(height: 10.0),
            Builder(
              builder: (context) {
                // * User has not set a password yet.
                if (state.passwordExists == false) {
                  return CustomInputTile(
                    textFieldKey: const ValueKey('new_password_field'),
                    icon: AppIcons.edit,
                    title: labels.createNewPassword(),
                    initialData: state.newPassword,
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<CreateCustomPasswordSheetCubit>().onCreatePasswordChanged(
                          value: value,
                          controller: controller,
                        ),
                    obscure: state.obscure,
                    // Trailing icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, _) => context.read<CreateCustomPasswordSheetCubit>().onClearCreatePasswordField(
                          controller: controller,
                        ),
                    // TextField trailing.
                    textFieldTrailingIcon: state.obscure ? AppIcons.visible : AppIcons.hidden,
                    onTextFieldTrailingIconPressed: (final TextEditingController controller) => context.read<CreateCustomPasswordSheetCubit>().onObsureCreatePasswordChanged(),
                  );
                }

                // * User has has set a password and is authentificated.
                if (state.isAuthenticated) {
                  return CustomInputTile(
                    textFieldKey: const ValueKey('update_password_field'),
                    icon: AppIcons.edit,
                    title: labels.updatePassword(),
                    initialData: state.updatePassword,
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<CreateCustomPasswordSheetCubit>().onUpdatePasswordChanged(
                          value: value,
                          controller: controller,
                        ),
                    obscure: state.obscure,
                    // Trailing icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, _) => context.read<CreateCustomPasswordSheetCubit>().onClearUpdatePasswordField(
                          controller: controller,
                        ),
                    // TextField trailing.
                    textFieldTrailingIcon: state.obscure ? AppIcons.visible : AppIcons.hidden,
                    onTextFieldTrailingIconPressed: (final TextEditingController controller) => context.read<CreateCustomPasswordSheetCubit>().onObscureUpdatePasswordChanged(),
                  );
                }

                // * User has already set a password. User must authenticate before proceeding.
                return CustomInputTile(
                  textFieldKey: const ValueKey('authenticate_password_field'),
                  icon: AppIcons.edit,
                  title: labels.basicLabelsAuthenticate(),
                  hint: labels.basicLabelsPasswordHint(),
                  initialData: state.authPassword,
                  // On changed.
                  onChanged: (final String value, final TextEditingController controller) => context.read<CreateCustomPasswordSheetCubit>().onAuthenticatePasswordChanged(
                        value: value,
                        controller: controller,
                      ),
                  obscure: state.obscure,
                  // Trailing icon.
                  trailingIcon: AppIcons.delete,
                  trailingIconColor: Theme.of(context).colorScheme.error,
                  onTrailingIconPressed: (final TextEditingController controller, _) => context.read<CreateCustomPasswordSheetCubit>().onClearAuthenticatePasswordField(
                        controller: controller,
                      ),
                  // TextField trailing.
                  textFieldTrailingIcon: state.obscure ? AppIcons.visible : AppIcons.hidden,
                  onTextFieldTrailingIconPressed: (final TextEditingController controller) => context.read<CreateCustomPasswordSheetCubit>().onObsureAuthenticatePasswordChanged(),
                );
              },
            )
          ],
        );
      },
    );
  }
}
