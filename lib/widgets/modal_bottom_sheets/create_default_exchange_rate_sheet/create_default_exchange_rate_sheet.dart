import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_drop_down_button.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/create_default_exchange_rate_sheet/cubit/create_default_exchange_rate_cubit.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';

class CreateDefaultExchangeRateSheet extends StatelessWidget {
  const CreateDefaultExchangeRateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Access height.
    final double height = MediaQuery.of(context).size.height;

    return BlocConsumer<CreateDefaultExchangeRateCubit, CreateDefaultExchangeRateState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == CreateDefaultExchangeRateStatus.close && current.status == CreateDefaultExchangeRateStatus.close) return false;

        return true;
      },
      listener: (context, state) async {
        // Close modal bottom sheet.
        if (state.status == CreateDefaultExchangeRateStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != CreateDefaultExchangeRateStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == CreateDefaultExchangeRateStatus.pageIsLoading;
        final bool pageHasError = state.status == CreateDefaultExchangeRateStatus.pageHasError;

        return CustomBasePage(
          height: height * 0.5,
          isScrollable: false,
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<CreateDefaultExchangeRateCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<CreateDefaultExchangeRateCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<CreateDefaultExchangeRateCubit>().closeSheet(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<CreateDefaultExchangeRateCubit>().closeSheet(),
          // Floating action button.
          floatingActionBarDisabled: true,
          // Content.
          contentHeight: height * 0.5,
          content: [
            const SizedBox(height: 20.0),
            Icon(
              AppIcons.first,
              size: 20.0,
            ),
            const SizedBox(height: 10.0),
            CustomDropDownButton(
              label: state.defaultExchangeRate.fromCurrencyCode.isEmpty ? labels.chooseFromCurrency() : state.defaultExchangeRate.fromCurrencyCode,
              onTap: () => context.read<CreateDefaultExchangeRateCubit>().chooseCurrency(
                    context: context,
                    isToCurrency: false,
                  ),
            ),
            const SizedBox(height: 20.0),
            Icon(
              AppIcons.second,
              size: 20.0,
            ),
            const SizedBox(height: 10.0),
            CustomDropDownButton(
              label: state.defaultExchangeRate.toCurrencyCode.isEmpty ? labels.chooseToCurrency() : state.defaultExchangeRate.toCurrencyCode,
              onTap: () => context.read<CreateDefaultExchangeRateCubit>().chooseCurrency(
                    context: context,
                    isToCurrency: true,
                  ),
            ),
            const SizedBox(height: 20.0),
            Icon(
              AppIcons.third,
              size: 20.0,
            ),
            const SizedBox(height: 10.0),
            CustomDropDownButton(
              label: state.defaultExchangeRate.exchangeRate <= 0 ? labels.setExchangeRate() : state.defaultExchangeRate.exchangeRate.toString(),
              onTap: () => context.read<CreateDefaultExchangeRateCubit>().chooseExchangeRate(
                    context: context,
                  ),
            ),
            const Spacer(),
            // * Ready button.
            CustomElevatedButton(
              label: labels.basicLabelsReady(),
              onPressed: () => context.read<CreateDefaultExchangeRateCubit>().validateData(context: context),
            ),
            const SizedBox(height: 60.0),
          ],
        );
      },
    );
  }
}
