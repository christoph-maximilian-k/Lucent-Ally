import 'dart:convert';

import 'package:equatable/equatable.dart';

// Models.
import 'exchange_rate.dart';

class ExchangeRates extends Equatable {
  final List<ExchangeRate> items;

  const ExchangeRates({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```ExchangeRates``` object.
  factory ExchangeRates.initial() {
    return const ExchangeRates(
      items: [],
    );
  }

  /// This method can be used to find a matching exchange rate.
  /// * Returns `null` if no matchting item is found.
  /// * Also checks if reciprocal exists.
  ExchangeRate? findMatchingExchangeRate({required String fromCurrencyCode, required String toCurrencyCode}) {
    for (final ExchangeRate item in items) {
      // Convenience variables.
      final bool fromHasMatch = item.fromCurrencyCode == fromCurrencyCode;
      final bool toHasMatch = item.toCurrencyCode == toCurrencyCode;

      // A match was found, return item.
      if (fromHasMatch && toHasMatch) return item;

      // Check the reciprocal.
      final bool fromHasReciMatch = item.fromCurrencyCode == toCurrencyCode;
      final bool toHasReciMatch = item.toCurrencyCode == fromCurrencyCode;

      // A match was found, return item.
      if (fromHasReciMatch && toHasReciMatch) {
        // Make sure value is not zero.
        if (item.exchangeRate == 0.0 || item.exchangeRate == 0) continue;

        // Create updated item.
        final ExchangeRate reci = item.copyWith(
          exchangeRate: 1 / item.exchangeRate,
        );

        return reci;
      }
    }

    return null;
  }

  /// This method can be used to add a `ExchangeRate` to `items` if items does not contain this exchange rate yet and also does not contain its reciprocal version.
  /// * The `ignoreDate` paramter is primarily used for setting defaults because there dates do not matter.
  ExchangeRates addUniqueWithReciprocalCheck({required ExchangeRate exchangeRate, bool ignoreDate = false}) {
    for (final ExchangeRate item in items) {
      // Convenience variables.
      final bool isSameFromCurrency = item.fromCurrencyCode == exchangeRate.fromCurrencyCode;
      final bool isSameToCurrency = item.toCurrencyCode == exchangeRate.toCurrencyCode;
      final bool isSameDate = item.exchangeRateDateInUtc == exchangeRate.exchangeRateDateInUtc;

      // Exchange rate already in items.
      if (isSameFromCurrency && isSameToCurrency && (ignoreDate || isSameDate)) return this;

      final bool isSameReciFromCurrency = item.fromCurrencyCode == exchangeRate.toCurrencyCode;
      final bool isSameReciToCurrency = item.toCurrencyCode == exchangeRate.fromCurrencyCode;

      // Reci exchange rate already in items.
      if (isSameReciFromCurrency && isSameReciToCurrency && (ignoreDate || isSameDate)) return this;
    }

    // No match was found, add item.
    final ExchangeRates updatedExchangeRates = ExchangeRates(items: [...items, exchangeRate]);

    return updatedExchangeRates;
  }

  /// This method can be used to get a ExchangeRate by its id.
  /// * Returns `null` if `id` cannot be found.
  ExchangeRate? byId({required String id}) {
    for (final ExchangeRate item in items) {
      if (item.exchangeRateId == id) return item;
    }

    return null;
  }

  /// This method can be used to remove a ExchangeRate from items.
  ExchangeRates remove({required ExchangeRate? exchangeRate}) {
    // Do null check.
    if (exchangeRate == null) return this;

    // init helper.
    List<ExchangeRate> helper = [];

    for (final ExchangeRate item in items) {
      if (item.exchangeRateId == exchangeRate.exchangeRateId) continue;

      helper.add(item);
    }

    return ExchangeRates(items: helper);
  }

  /// This method can be used to set a `ExchangeRate` in `items`.
  ExchangeRates set({required ExchangeRate exchangeRate}) {
    // Init helper.
    List<ExchangeRate> helper = [];
    bool updated = false;

    for (final ExchangeRate item in items) {
      // Convenience variables.
      final bool hasFromMatch = item.fromCurrencyCode == exchangeRate.fromCurrencyCode;
      final bool hasToMatch = item.toCurrencyCode == exchangeRate.toCurrencyCode;

      // Update item.
      if (hasFromMatch && hasToMatch) {
        // Add the provided item instead of the old item.
        helper.add(exchangeRate);

        // Update flag.
        updated = true;

        // Continue with next item.
        continue;
      }

      // Retain items.
      helper.add(item);
    }

    if (updated == false) helper.add(exchangeRate);

    return ExchangeRates(items: helper);
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```ExchangeRates``` object to a object suitable for embdedded storage.
  /// * In this specific case convert the objects to a JSON because the `DbExchangeRate` object
  /// * cannot be used as an embedded object because it is defined as a colleciton object.
  String toEmbeddedSchema() {
    // Init helper.
    List<Map<String, dynamic>> helper = [];

    for (final ExchangeRate exchangeRate in items) {
      // Convert field to embedded schema.
      final Map<String, dynamic> schema = exchangeRate.toEmbeddedSchema();

      // Add to helper.
      helper.add(schema);
    }

    return jsonEncode(helper);
  }

  /// Convert Exchange Rates that were encoded using [toEmbeddedSchema] to a ```ExchangeRates``` object.
  /// * Returns `ExchangeRates.initial()` if `schema == null`.
  static ExchangeRates fromEmbeddedSchema({required String? schema}) {
    // Do null check.
    if (schema == null) return ExchangeRates.initial();

    // Decode schema.
    final List<dynamic> decoded = jsonDecode(schema);

    // Helper.
    List<ExchangeRate> helper = [];

    for (final dynamic item in decoded) {
      // Convert to ExchangeRate object.
      final ExchangeRate entry = ExchangeRate.fromEmbeddedSchema(
        data: item,
      )!;

      helper.add(entry);
    }

    return ExchangeRates(items: helper);
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```ExchangeRates``` object to JSON suitable fro cloud storage.
  List<Map<String, dynamic>> toCloudObject({bool includeExchangeRate = true, bool includeDate = true}) {
    // Init json list.
    List<Map<String, dynamic>> jsonList = [];

    // Populate jsonList with data.
    for (final ExchangeRate item in items) {
      jsonList.add(item.toCloudObject(includeExchangeRate: includeExchangeRate, includeDate: includeDate));
    }

    return jsonList;
  }

  /// Decode a ```ExchangeRates``` object from JSON.
  static ExchangeRates fromCloudObject(document) {
    // Initialize Fields object.
    List<ExchangeRate> helper = [];

    // Go through list and add converted json to list.
    for (final Map<String, dynamic> item in document) {
      // Do conversion.
      final ExchangeRate? exchangeRate = ExchangeRate.fromCloudObject(data: item);

      if (exchangeRate == null) continue;

      helper.add(exchangeRate);
    }

    return ExchangeRates(
      items: helper,
    );
  }

  // #####################################
  // Copy With
  // #####################################

  ExchangeRates copyWith({
    List<ExchangeRate>? items,
  }) {
    return ExchangeRates(
      items: items ?? this.items,
    );
  }
}
