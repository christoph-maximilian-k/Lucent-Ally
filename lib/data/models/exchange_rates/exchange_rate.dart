import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Schemas.
import '/data/models/exchange_rates/schemas/db_exchange_rate.dart';

class ExchangeRate extends Equatable {
  final String exchangeRateId;

  /// This value is `null` if the object is used as a CustomExchangeRate object or a DefaultExchangeRate object.
  final DateTime? exchangeRateDateInUtc;

  final String fromCurrencyCode;
  final String toCurrencyCode;

  final double exchangeRate;

  const ExchangeRate({
    required this.exchangeRateId,
    required this.exchangeRateDateInUtc,
    required this.fromCurrencyCode,
    required this.toCurrencyCode,
    required this.exchangeRate,
  });

  @override
  List<Object?> get props => [
        exchangeRateId,
        exchangeRateDateInUtc,
        fromCurrencyCode,
        toCurrencyCode,
        exchangeRate,
      ];

  // ######################################
  // Factories
  // ######################################

  /// Initialize a new ```ExchangeRate``` object.
  factory ExchangeRate.initial() {
    return ExchangeRate(
      exchangeRateId: const Uuid().v4(),
      exchangeRateDateInUtc: DateTime.now().toUtc(),
      fromCurrencyCode: '',
      toCurrencyCode: '',
      exchangeRate: 0.0,
    );
  }

  // ######################################
  // Static methods
  // ######################################

  /// This can be used to access the database key which is used to uniquly identify this exchange rate.
  /// * This is done so that exchange rates and its reciprocal can be identified using one query.
  static String getExchangeRateKey({required String fromCurrencyCode, required String toCurrencyCode}) {
    return (fromCurrencyCode.compareTo(toCurrencyCode) < 0) ? '$fromCurrencyCode-$toCurrencyCode' : '$toCurrencyCode-$fromCurrencyCode';
  }

  // ######################################
  // Identifiers
  // ######################################

  /// Exchange rate status: initial
  /// ```dart
  /// static const String exchangeRateStatusInitial = 'initial';
  /// ```
  static const String exchangeRateStatusInitial = 'initial';

  /// Exchange rate status: custom
  /// ```dart
  /// static const String exchangeRateStatusCustom = 'custom';
  /// ```
  static const String exchangeRateStatusCustom = 'custom';

  /// Exchange rate status: in_future
  /// ```dart
  /// static const String exchangeRateStatusInFuture = 'in_future';
  /// ```
  static const String exchangeRateStatusInFuture = 'in_future';

  /// Exchange rate status: not_found_local
  /// ```dart
  /// static const String exchangeRateStatusNotFoundLocal = 'not_found_local';
  /// ```
  static const String exchangeRateStatusNotFoundLocal = 'not_found_local';

  /// Exchange rate status: not_found_cloud
  /// ```dart
  /// static const String exchangeRateStatusNotFoundCloud = 'not_found_cloud';
  /// ```
  static const String exchangeRateStatusNotFoundCloud = 'not_found_cloud';

  /// Exchange rate status: failure
  /// ```dart
  /// static const String exchangeRateStatusFailure = 'failure';
  /// ```
  static const String exchangeRateStatusFailure = 'failure';

  /// Exchange rate status: success_local
  /// ```dart
  /// static const String exchangeRateStatusSuccessLocal = 'success_local';
  /// ```
  static const String exchangeRateStatusSuccessLocal = 'success_local';

  /// Exchange rate status: success_cloud
  /// ```dart
  /// static const String exchangeRateStatusSuccessCloud = 'success_cloud';
  /// ```
  static const String exchangeRateStatusSuccessCloud = 'success_cloud';

  // #####################################
  // Database
  // #####################################

  /// Convert a ```ExchangeRate``` object to a ```DbExchangeRate``` object.
  DbExchangeRate toSchema() {
    return DbExchangeRate(
      exchangeRateId: exchangeRateId,
      exchangeRateDateInUtc: exchangeRateDateInUtc!.millisecondsSinceEpoch,
      fromCurrencyCode: fromCurrencyCode,
      toCurrencyCode: toCurrencyCode,
      exchangeRate: exchangeRate,
    );
  }

  /// Convert a ```DbExchangeRate``` object to a ```ExchangeRate``` object.
  static ExchangeRate? fromSchema({required DbExchangeRate? schema}) {
    // Do null check.
    if (schema == null) return null;

    return ExchangeRate(
      exchangeRateId: schema.exchangeRateId,
      exchangeRateDateInUtc: DateTime.fromMillisecondsSinceEpoch(schema.exchangeRateDateInUtc, isUtc: true),
      fromCurrencyCode: schema.fromCurrencyCode,
      toCurrencyCode: schema.toCurrencyCode,
      exchangeRate: schema.exchangeRate,
    );
  }

  /// Encode an ```ExchangeRate``` object to JSON suitable for cloud storage.
  Map<String, dynamic> toEmbeddedSchema() {
    return {
      'id': exchangeRateId,
      'from_currency_code': fromCurrencyCode,
      'to_currency_code': toCurrencyCode,
      'exchange_rate': exchangeRate,
    };
  }

  /// Decode an ```ExchangeRate``` object from JSON provided by cloud service.
  static ExchangeRate? fromEmbeddedSchema({required Map<String, dynamic>? data}) {
    // ! The reason why exchangeRateDate is supplied like this is that a custom exchange rate is not dependent on date.
    // Do null check.
    if (data == null || data.isEmpty) return null;

    return ExchangeRate(
      exchangeRateId: data["id"],
      exchangeRateDateInUtc: null,
      fromCurrencyCode: data["from_currency_code"],
      toCurrencyCode: data["to_currency_code"],
      exchangeRate: data["exchange_rate"],
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode an ```ExchangeRate``` object to JSON suitable for cloud storage.
  Map<String, dynamic> toCloudObject({required bool includeExchangeRate, required bool includeDate}) {
    return {
      'id': exchangeRateId,
      if (includeDate) 'exchange_rate_date_in_utc': exchangeRateDateInUtc!.toIso8601String(),
      'from_currency_code': fromCurrencyCode,
      'to_currency_code': toCurrencyCode,
      if (includeExchangeRate) 'exchange_rate': exchangeRate,
    };
  }

  /// Decode an ```ExchangeRate``` object from JSON provided by cloud service.
  static ExchangeRate? fromCloudObject({required Map<String, dynamic>? data}) {
    // Do null check.
    if (data == null || data.isEmpty) return null;

    return ExchangeRate(
      exchangeRateId: data["id"],
      exchangeRateDateInUtc: data["exchange_rate_date_in_utc"] == null ? null : DateTime.parse(data["exchange_rate_date_in_utc"]),
      fromCurrencyCode: data["from_currency_code"],
      toCurrencyCode: data["to_currency_code"],
      exchangeRate: data["exchange_rate"],
    );
  }

  // #####################################
  // Copy With
  // #####################################

  ExchangeRate copyWith({
    String? exchangeRateId,
    DateTime? exchangeRateDateInUtc,
    String? fromCurrencyCode,
    String? toCurrencyCode,
    double? exchangeRate,
  }) {
    return ExchangeRate(
      exchangeRateId: exchangeRateId ?? this.exchangeRateId,
      exchangeRateDateInUtc: exchangeRateDateInUtc ?? this.exchangeRateDateInUtc,
      fromCurrencyCode: fromCurrencyCode ?? this.fromCurrencyCode,
      toCurrencyCode: toCurrencyCode ?? this.toCurrencyCode,
      exchangeRate: exchangeRate ?? this.exchangeRate,
    );
  }
}
