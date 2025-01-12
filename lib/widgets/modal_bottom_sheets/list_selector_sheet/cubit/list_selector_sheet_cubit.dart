import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/country_specification.dart';
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';

part 'list_selector_sheet_state.dart';

class ListSelectorSheetCubit extends Cubit<ListSelectorSheetState> {
  ListSelectorSheetCubit() : super(ListSelectorSheetState.initial());

  /// Initialize state data.
  Future<void> initialize({required bool isCurrencySelector}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        items: isCurrencySelector ? CountrySpecification.getCurrencies : CountrySpecification.countrySpecifications,
        matching: [],
        isCurrencySelector: isCurrencySelector,
        status: ListSelectorSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('ListSelectorSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: ListSelectorSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('ListSelectorSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ListSelectorSheetStatus.pageHasError,
      ));
    }
  }

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == ListSelectorSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ListSelectorSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ListSelectorSheetStatus.close,
    ));
  }

  /// This method will be triggered if user searches in search field.
  Future<void> onSearched({required String value}) async {
    // Set state to initial if value is empty.
    if (value.isEmpty) {
      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit initial state.
      emit(state.copyWith(
        matching: [],
        currentSearchCriteria: '',
        status: ListSelectorSheetStatus.waiting,
      ));

      return;
    }

    // Only emit states if cubit is open.
    if (isClosed) return;

    // Emit loading state.
    emit(state.copyWith(
      currentSearchCriteria: value,
      status: ListSelectorSheetStatus.loading,
    ));

    // Init matching.
    List matching = [];

    for (final item in state.items) {
      // Convenience check to know what List was initialized with.
      if (item is CountrySpecification && state.isCurrencySelector) {
        // Add relevant items to list.
        if (item.currencyName.toLowerCase().contains(value.toLowerCase())) matching.add(item);

        continue;
      }

      // Convenience check to know what List was initialized with.
      if (item is CountrySpecification) {
        // Add relevant items to list.
        if (item.countryName.toLowerCase().contains(value.toLowerCase())) matching.add(item);
      }
    }

    // Only emit states if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      matching: matching,
      status: ListSelectorSheetStatus.waiting,
    ));
  }
}
