import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';
import '/config/country_specification.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';
import '/data/models/exchange_rates/exchange_rate.dart';

// Widgets.
import '/widgets/modal_bottom_sheets/list_selector_sheet/cubit/list_selector_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/list_selector_sheet/list_selector_sheet.dart';

part 'create_default_exchange_rate_state.dart';

class CreateDefaultExchangeRateCubit extends Cubit<CreateDefaultExchangeRateState> {
  CreateDefaultExchangeRateCubit() : super(CreateDefaultExchangeRateState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize state data.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: CreateDefaultExchangeRateStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: CreateDefaultExchangeRateStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateDefaultExchangeRateStatus.pageHasError,
      ));
    }
  }

  // #############################
  // State
  // #############################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateDefaultExchangeRateStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == CreateDefaultExchangeRateStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateDefaultExchangeRateStatus.close,
    ));
  }

  /// This method can be used to choose a currency.
  Future<void> chooseCurrency({required bool isToCurrency, required BuildContext context}) async {
    try {
      // Show available countries.
      final CountrySpecification? countrySpecification = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => BlocProvider<ListSelectorSheetCubit>(
          create: (context) => ListSelectorSheetCubit()
            ..initialize(
              isCurrencySelector: true,
            ),
          child: const ListSelectorSheet(),
        ),
      );

      // User closed sheet or selected the same currency again.
      if (countrySpecification == null) return;

      // Create updated default exchange rate.
      final ExchangeRate updated = state.defaultExchangeRate.copyWith(
        fromCurrencyCode: isToCurrency ? null : countrySpecification.currencyCode,
        toCurrencyCode: isToCurrency ? countrySpecification.currencyCode : null,
      );

      // Ensure chosen currency differs from other.
      final bool differs = updated.fromCurrencyCode != updated.toCurrencyCode;

      if (differs == false) throw Failure.currenciesMustDiffer();

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        defaultExchangeRate: updated,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> chooseCurrency() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateDefaultExchangeRateStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> chooseCurrency() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateDefaultExchangeRateStatus.failure,
      ));
    }
  }

  /// This method can be used to set a exchange rate.
  Future<void> chooseExchangeRate({required BuildContext context}) async {
    try {
      // Show text sheet.
      // * Let user authenticate.
      final String? customExchangeRateValue = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => TextFieldSheet(
          textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
          title: labels.basicLabelsExchangeRate(),
          autocorrect: false,
        ),
      );

      // * User cancled.
      if (customExchangeRateValue == null || customExchangeRateValue.isEmpty) return;

      // Try and parse to default number data.
      final String converted = NumberData.convertToDefaultNumberFormat(value: customExchangeRateValue);

      // Check value.
      final bool isValidNumber = NumberData.numberValidator(input: converted);

      // * Invalid number discovered.
      if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: '');

      // Ensure that value is not to big.
      final bool tooManyChars = NumberData.tooManyNumberCharacters(input: converted);

      // Raise error.
      if (tooManyChars) throw Failure.numberHasTooManyCharacters();

      // Convert to double.
      final double asDouble = double.parse(converted);

      // * Must be greater zero.
      if (asDouble <= 0) throw Failure.customExchangeRateMustBeGreaterZero();

      // Create updated exchange rate object.
      final ExchangeRate updated = state.defaultExchangeRate.copyWith(
        exchangeRate: asDouble,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        defaultExchangeRate: updated,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> chooseExchangeRate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateDefaultExchangeRateStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> chooseExchangeRate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateDefaultExchangeRateStatus.failure,
      ));
    }
  }

  // #############################
  // On Ready function
  // #############################

  /// This method will be triggered if user is done creating a default exchange rate.
  Future<void> validateData({required BuildContext context}) async {
    try {
      // Ensure that all values are set.
      final bool hasToCurrency = state.defaultExchangeRate.toCurrencyCode.trim().isNotEmpty;
      final bool hasFromCurrency = state.defaultExchangeRate.fromCurrencyCode.trim().isNotEmpty;

      // User did not set a from currency.
      if (hasFromCurrency == false) throw Failure.fromCurrencyRequired();

      // User did not set a to currency.
      if (hasToCurrency == false) throw Failure.toCurrencyRequired();

      // Try and parse to default number data.
      final String converted = NumberData.convertToDefaultNumberFormat(value: state.defaultExchangeRate.exchangeRate.toString());

      // Check value.
      final bool isValidNumber = NumberData.numberValidator(input: converted);

      // * Invalid number discovered.
      if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: '');

      // Ensure that value is not to big.
      final bool tooManyChars = NumberData.tooManyNumberCharacters(input: converted);

      // Raise error.
      if (tooManyChars) throw Failure.numberHasTooManyCharacters();

      // Convert to double.
      final double asDouble = double.parse(converted);

      // * Must be greater zero.
      if (asDouble <= 0) throw Failure.customExchangeRateMustBeGreaterZero();

      // Pop with data.
      Navigator.of(context).pop(state.defaultExchangeRate);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> validateData() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateDefaultExchangeRateStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateDefaultExchangeRateSheet --> validateData() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateDefaultExchangeRateStatus.failure,
      ));
    }
  }
}
