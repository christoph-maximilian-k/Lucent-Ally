import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/exchange_rates/exchange_rates.dart';
import '/data/models/field_types/tags_data/tags_data.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';

// Schemas.
import '/data/models/field_types/money_data/schemas/db_money_data.dart';

class MoneyData extends Equatable {
  final String value;
  final String currencyCode;

  /// This can be null to enable not setting a value for createdAtInUtc when setting defaults.
  final DateTime? createdAtInUtc;

  /// This value can be used to save a "dumb" date as a default value.
  final String? defaultDate;

  /// This value can be used to save a "dumb" time as a default value.
  final String? defaultTime;

  /// This can be empty in case of default.
  final String timezone;

  final TagsData tagsData;

  final ExchangeRates customExchangeRates;

  final String? importReferenceValue;
  final String? importReferenceCurrency;
  final String? importReferenceExchangeRate;
  final String? importReferenceTags;
  final String? importReferenceDate;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedCurrency;

  const MoneyData({
    required this.value,
    required this.currencyCode,
    required this.createdAtInUtc,
    required this.timezone,
    required this.tagsData,
    required this.defaultDate,
    required this.defaultTime,
    required this.customExchangeRates,
    required this.importReferenceValue,
    required this.importReferenceCurrency,
    required this.importReferenceExchangeRate,
    required this.importReferenceTags,
    required this.importReferenceDate,
    required this.encryptedValue,
    required this.encryptedCurrency,
  });

  @override
  List<Object?> get props => [
        value,
        currencyCode,
        tagsData,
        createdAtInUtc,
        defaultDate,
        defaultTime,
        timezone,
        customExchangeRates,
        importReferenceValue,
        importReferenceCurrency,
        importReferenceExchangeRate,
        importReferenceDate,
        encryptedValue,
        encryptedCurrency,
        importReferenceTags,
      ];

  /// Initialize a new ```MoneyData``` object.
  factory MoneyData.initial() {
    return MoneyData(
      value: "",
      currencyCode: "",
      createdAtInUtc: null,
      timezone: '',
      defaultDate: null,
      defaultTime: null,
      customExchangeRates: ExchangeRates.initial(),
      tagsData: TagsData.initial(),
      importReferenceValue: null,
      importReferenceCurrency: null,
      importReferenceExchangeRate: null,
      importReferenceDate: null,
      encryptedValue: null,
      encryptedCurrency: null,
      importReferenceTags: null,
    );
  }

  /// This getter can be used to access createdAt in a readable format.
  /// * Assumes values are not null.
  String getCreatedAt({required bool preserveUtc, required bool date, required bool time, String dateFormat = 'yyyy-MM-dd'}) {
    // Convert value.
    final DateTime converted = HelperFunctions.convertToTimezone(
      dateTimeInUtc: createdAtInUtc!,
      timezone: timezone,
      preserveUtc: preserveUtc,
    );

    if (date && time) return '${DateFormat(dateFormat).format(converted)} ${labels.basicLabelsAt()} ${DateFormat("HH:mm").format(converted)}';

    if (date) return DateFormat(dateFormat).format(converted);

    return DateFormat("HH:mm").format(converted);
  }

  /// This getter can be used to access timezone in a readable format.
  String getTimezone({required bool preserveUtc}) {
    // If the value was stored in utc, use local timezone.
    if (timezone.isEmpty || timezone == "UTC") {
      // If flag was set, return UTC timezone.
      if (preserveUtc) return "UTC";

      // Try and access local timezone.
      final String? localTimezone = HelperFunctions.getCurrentTimezone();

      // It seems like local timezone could not be accessed.
      if (localTimezone == null || localTimezone.isEmpty) return "UTC";

      return localTimezone;
    }

    // Otherwise return stored timezone.
    return timezone;
  }

  /// This getter can be used to parse ```value``` to a double.
  /// * This getter assumes that value is a valid double.
  double get valueAsDouble {
    return double.parse(value);
  }

  /// This getter can be used to access value as string.
  String get getFormattedNumber {
    if (valueAsDouble % 1 == 0) return valueAsDouble.toStringAsFixed(0);

    return valueAsDouble.toString();
  }

  /// This method can be used to access the converted total depending on exchange rate.
  double calculateConvertedTotal({required double exchangeRateToDefault}) {
    return valueAsDouble * exchangeRateToDefault;
  }

  /// This method can be used to indicate if this field should be included from being saved to local storage.
  static bool includeField({required MoneyData? moneyData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (moneyData == null) return false;

    final bool hasValue = moneyData.value.trim().isNotEmpty;
    final bool hasCurrency = moneyData.currencyCode.trim().isNotEmpty;
    final bool hasDate = moneyData.createdAtInUtc != null;
    final bool hasTimezone = moneyData.timezone.isNotEmpty;
    final bool hasTags = moneyData.tagsData.tagReferences.isNotEmpty;

    final bool hasDefaultDate = moneyData.defaultDate != null && moneyData.defaultDate!.isNotEmpty;
    final bool hasDefaultTime = moneyData.defaultTime != null && moneyData.defaultTime!.isNotEmpty;

    final bool hasCustomExchangeRates = moneyData.customExchangeRates.items.isNotEmpty; // * This is also used for default exchange rates.

    final bool hasValueRef = moneyData.importReferenceValue != null && moneyData.importReferenceValue!.trim().isNotEmpty;
    final bool hasCurrencyRef = moneyData.importReferenceCurrency != null && moneyData.importReferenceCurrency!.trim().isNotEmpty;

    // In case of default, different cases apply.
    if (isDefault) {
      // If any value is set, return true.
      // * In default date should be null because defaultDate and defaultTime should be used.
      return [
        hasValue,
        hasCurrency,
        hasDefaultDate,
        hasDefaultTime,
        hasTimezone,
        hasTags,
        hasCustomExchangeRates,
      ].any((condition) => condition);
    }

    // * User is in import mode.
    if (isImport) {
      // User set required import references.
      if (hasValueRef && hasCurrencyRef) return true;

      // User set a value ref and a default currency.
      if (hasValueRef && hasCurrency) return true;

      // * User might also have set other default values but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include if all required values are set.
    if (hasValue && hasCurrency && hasDate && hasTimezone) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required MoneyData? moneyData}) {
    if (moneyData == null) return null;
    if (moneyData.value.isEmpty) return null;
    if (moneyData.currencyCode.isEmpty) return null;

    return moneyData.getFormattedNumber;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// ```dart
  /// return '$formattedNumber $currencyCode';
  /// ```
  String? getSubtitle({required String fieldLabel}) {
    // No value available.
    if (value.isEmpty) return null;

    return '$getFormattedNumber $currencyCode';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// ```dart
  /// return '$formattedNumber $currencyCode';
  /// ```
  String? getThirdline({required String fieldLabel}) {
    // No value available.
    if (value.isEmpty) return null;

    return '$getFormattedNumber $currencyCode';
  }

  // #####################################
  // Pie Chart Instructions
  // #####################################

  /// Pie Chart identification to display currency distribution.
  /// ```dart
  /// static const String pieChartCurrencyDistribution = 'currency_distribution';
  /// ```
  static const String pieChartCurrencyDistribution = 'currency_distribution';

  /// Pie Chart identification to display expenses by category.
  /// ```dart
  /// static const String pieChartExpensesByCategory = 'expenses_by_category';
  /// ```
  static const String pieChartExpensesByCategory = 'expenses_by_category';

  /// Pie Chart identification to display income by category.
  /// ```dart
  /// static const String pieChartIncomeByCategory = 'income_by_category';
  /// ```
  static const String pieChartIncomeByCategory = 'income_by_category';

  // #####################################
  // Bar Chart Instructions
  // #####################################

  /// Bar Chart identification to display income over time.
  /// ```dart
  /// static const String chartInstructionIncomeOverTime = 'income_over_time';
  /// ```
  static const String chartInstructionIncomeOverTime = 'income_over_time';

  /// Bar Chart identification to display expenses over time.
  /// ```dart
  /// static const String chartInstructionExpensesOverTime = 'expenses_over_time';
  /// ```
  static const String chartInstructionExpensesOverTime = 'expenses_over_time';

  /// Bar Chart identification to display values by entry.
  /// ```dart
  /// static const String chartInstructionValuesByEntry = 'values_by_entry';
  /// ```
  static const String chartInstructionValuesByEntry = 'values_by_entry';

  // #####################################
  // Line Chart Instructions
  // #####################################

  /// Line Chart identification to calculate the money progression accumulated
  /// ```dart
  /// static const String chartInstructionMoneyProgression = 'money_progression_accumulated';
  /// ```
  static const String chartInstructionMoneyProgressionAccumulated = 'money_progression_accumulated';

  // #####################################
  // Database
  // #####################################

  /// Convert a ```MoneyData``` object to a ```DbMoneyData``` object.
  DbMoneyData toSchema() {
    return DbMoneyData(
      // * Use try parse here because in case of import match there might not be a valid double here (empty)
      // * but the schema conversion is still needed.
      // * If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : double.tryParse(value),
      customExchangeRates: customExchangeRates.toEmbeddedSchema(),
      // These can be null in case of default.
      createdAtInUtc: createdAtInUtc?.millisecondsSinceEpoch,
      defaultDate: defaultDate,
      defaultTime: defaultTime,
      timezone: timezone.isEmpty ? null : timezone,
      tagsData: tagsData.toSchema(),
      // * If encryption was applied, remove value.
      currencyCode: encryptedCurrency?.isNotEmpty == true ? null : currencyCode,
      importReferenceValue: importReferenceValue,
      importReferenceCurrency: importReferenceCurrency,
      importReferenceExchangeRate: importReferenceExchangeRate,
      importReferenceDate: importReferenceDate,
      importReferenceTags: importReferenceTags,
      encryptedValue: encryptedValue,
      encryptedCurrency: encryptedCurrency,
    );
  }

  /// Convert a ```DbMoneyData``` object to a ```MoneyData``` object.
  static MoneyData? fromSchema({required DbMoneyData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // * This manual conversion is needed here because in case of an import match schema.value might be null.
    final String value = schema.value == null ? '' : schema.value.toString();

    return MoneyData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : value,
      customExchangeRates: ExchangeRates.fromEmbeddedSchema(schema: schema.customExchangeRates),
      // * These can be null in case of defaults.
      createdAtInUtc: schema.createdAtInUtc == null ? null : DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc!, isUtc: true),
      defaultDate: schema.defaultDate,
      defaultTime: schema.defaultTime,
      // * This can be null in case of defaults.
      timezone: schema.timezone ?? "",
      // If encryption was applied, set value to a placeholder until decryption.
      currencyCode: schema.encryptedCurrency?.isNotEmpty == true ? '' : schema.currencyCode!,
      tagsData: TagsData.fromSchema(schema: schema.tagsData)!,
      importReferenceValue: schema.importReferenceValue,
      importReferenceCurrency: schema.importReferenceCurrency,
      importReferenceExchangeRate: schema.importReferenceExchangeRate,
      importReferenceDate: schema.importReferenceDate,
      importReferenceTags: schema.importReferenceTags,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedCurrency: schema.encryptedCurrency != null ? Uint8List.fromList(schema.encryptedCurrency!) : null,
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode a ```MoneyData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      // In case of default, this might be empty.
      'value': value.isEmpty ? null : valueAsDouble,
      'currency_code': currencyCode,
      // In case of default, this might be null.
      'created_at_in_utc': createdAtInUtc?.toIso8601String(),
      'default_date': defaultDate,
      'default_time': defaultTime,
      'timezone': timezone.isEmpty ? null : timezone,
      'tags_data': tagsData.toCloudObject(),
      'custom_exchange_rates': customExchangeRates.toCloudObject(includeDate: false),
    };
  }

  /// Decode a ```MoneyData``` object from JSON.
  static MoneyData fromCloudObject(document) {
    return MoneyData(
      // In case of default, this might be null.
      value: document['value'] == null ? '' : document['value'].toString(),
      currencyCode: document['currency_code'],
      // In case of default, this might be null.
      createdAtInUtc: document['created_at_in_utc'] == null ? null : DateTime.parse(document['created_at_in_utc']),
      defaultDate: document['default_date'],
      defaultTime: document['default_time'],
      // In case of default, this might be null.
      timezone: document['timezone'] ?? "",
      tagsData: TagsData.fromCloudObject(document['tags_data']),
      customExchangeRates: ExchangeRates.fromCloudObject(document['custom_exchange_rates']),
      importReferenceValue: null,
      importReferenceCurrency: null,
      importReferenceExchangeRate: null,
      importReferenceDate: null,
      importReferenceTags: null,
      encryptedValue: null,
      encryptedCurrency: null,
    );
  }

  // #####################################
  // Copy With
  // #####################################

  MoneyData copyWith({
    String? value,
    String? currencyCode,
    DateTime? createdAtInUtc,
    String? defaultDate,
    String? defaultTime,
    String? timezone,
    TagsData? tagsData,
    ExchangeRates? customExchangeRates,
    String? importReferenceValue,
    String? importReferenceCurrency,
    String? importReferenceExchangeRate,
    String? importReferenceTags,
    String? importReferenceDate,
    Uint8List? encryptedValue,
    Uint8List? encryptedCurrency,
  }) {
    return MoneyData(
      value: value ?? this.value,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      defaultDate: defaultDate ?? this.defaultDate,
      defaultTime: defaultTime ?? this.defaultTime,
      timezone: timezone ?? this.timezone,
      tagsData: tagsData ?? this.tagsData,
      customExchangeRates: customExchangeRates ?? this.customExchangeRates,
      importReferenceValue: importReferenceValue ?? this.importReferenceValue,
      importReferenceCurrency: importReferenceCurrency ?? this.importReferenceCurrency,
      importReferenceExchangeRate: importReferenceExchangeRate ?? this.importReferenceExchangeRate,
      importReferenceTags: importReferenceTags ?? this.importReferenceTags,
      importReferenceDate: importReferenceDate ?? this.importReferenceDate,
      encryptedValue: encryptedValue ?? this.encryptedValue,
      encryptedCurrency: encryptedCurrency ?? this.encryptedCurrency,
    );
  }
}
