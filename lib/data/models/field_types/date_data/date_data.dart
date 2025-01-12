import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// Labels.
import '/main.dart';

// Schemas.
import '/data/models/field_types/date_data/schemas/db_date_data.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';

class DateData extends Equatable {
  /// This can be null to enable not setting a value for defaults.
  final DateTime? valueInUtc;

  /// This value can be used to save a "dumb" date as a default value.
  final String? valueDefaultDate;

  /// This can be empty in case of default.
  final String timezone;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const DateData({
    required this.valueInUtc,
    required this.valueDefaultDate,
    required this.timezone,
    required this.importReference,
    required this.encryptedValue,
  });

  @override
  List<Object?> get props => [
        valueInUtc,
        timezone,
        valueDefaultDate,
        importReference,
        encryptedValue,
      ];

  /// Initialize a new ```DateData``` object.
  factory DateData.initial() {
    return const DateData(
      valueInUtc: null,
      timezone: "",
      valueDefaultDate: null,
      importReference: null,
      encryptedValue: null,
    );
  }

  /// This getter can be used to access createdAt in a readable format.
  /// * Assumes values are not null.
  String getCreatedAt({required bool preserveUtc, String format = 'yyyy-MM-dd'}) {
    // Convert value.
    final DateTime converted = HelperFunctions.convertToTimezone(
      dateTimeInUtc: valueInUtc!,
      timezone: timezone,
      preserveUtc: preserveUtc,
    );

    return DateFormat(format).format(converted);
  }

  /// This getter can be used to access timezone in a readable format.
  String getCreatedAtTimezone({required bool preserveUtc}) {
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

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required DateData? dateData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (dateData == null) return false;

    // Has date.
    final bool hasData = dateData.valueInUtc != null;
    final bool hasTimezone = dateData.timezone.isNotEmpty;

    final bool hasDefaultDate = dateData.valueDefaultDate != null && dateData.valueDefaultDate!.isNotEmpty;

    final bool hasDateRef = dateData.importReference != null && dateData.importReference!.trim().isNotEmpty;

    // * User is in set default mode.
    if (isDefault) {
      // If any value is set, return true.
      return [
        hasDefaultDate,
        hasTimezone,
      ].any((condition) => condition);
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import reference.
      if (hasDateRef) return true;

      // * User might also have set a default value but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if required values are set.
    if (hasData && hasTimezone) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required DateData? dateData}) {
    if (dateData == null) return null;
    if (dateData.valueInUtc == null) return null;

    return labels.basicLabelsDateTimeAndTimezone(
      date: dateData.getCreatedAt(preserveUtc: true),
      timezone: dateData.getCreatedAtTimezone(preserveUtc: true),
    );
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * Returns ```null``` if ```value == null```
  /// ```dart
  /// return '$fieldLabel · $dateValue';
  /// ```
  String? getSubtitle({required String fieldLabel}) {
    // Test for null value.
    if (valueInUtc == null) return null;

    // Access date.
    final String dateValue = labels.basicLabelsDateTimeAndTimezone(
      date: getCreatedAt(preserveUtc: true),
      timezone: getCreatedAtTimezone(preserveUtc: true),
    );

    return '$fieldLabel · $dateValue';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * Returns ```null``` if ```value == null```
  /// ```dart
  /// return '$fieldLabel · $dateValue';
  /// ```
  String? getThirdline({required String fieldLabel}) {
    // Test for null value.
    if (valueInUtc == null) return null;

    // Access date.
    final String dateValue = labels.basicLabelsDateTimeAndTimezone(
      date: getCreatedAt(preserveUtc: true),
      timezone: getCreatedAtTimezone(preserveUtc: true),
    );

    return '$fieldLabel · $dateValue';
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```DateData``` object to a ```DbDateData``` object.
  DbDateData toSchema() {
    return DbDateData(
      // If encryption was applied, remove value.
      // * Value can be null in case of default.
      valueInUtc: encryptedValue?.isNotEmpty == true ? null : valueInUtc?.millisecondsSinceEpoch,
      valueDefaultDate: valueDefaultDate,
      timezone: timezone.isEmpty ? null : timezone,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbDateData``` object to a ```DateData``` object.
  static DateData? fromSchema({required DbDateData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return DateData(
      // If encryption was applied, set value to a placeholder until decryption.
      // * This can be null in case of defaults.
      // ! This is also null if a ModelEntry with import specs is loaded from local storage. Because in that case only the importReference is set.
      valueInUtc: schema.encryptedValue?.isNotEmpty == true || schema.valueInUtc == null ? null : DateTime.fromMillisecondsSinceEpoch(schema.valueInUtc!, isUtc: true),
      valueDefaultDate: schema.valueDefaultDate,
      // * This can be null in case of defaults.
      timezone: schema.timezone ?? "",
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```DateData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      // * Can be null in case of default.
      'value_in_utc': valueInUtc?.toIso8601String(),
      'default_date': valueDefaultDate,
      // * Can be null in case of default.
      'timezone': timezone.isEmpty ? null : timezone,
    };
  }

  /// Decode a ```DateData``` object from JSON.
  static DateData fromCloudObject(document) {
    return DateData(
      // In case of default, this might be null.
      valueInUtc: document['value_in_utc'] == null ? null : DateTime.parse(document['value_in_utc']),
      valueDefaultDate: document['default_date'],
      // In case of default, this might be null.
      timezone: document['timezone'] ?? "",
      importReference: null,
      encryptedValue: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  DateData copyWith({
    DateTime? valueInUtc,
    String? valueDefaultDate,
    String? timezone,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return DateData(
      valueInUtc: valueInUtc ?? this.valueInUtc,
      valueDefaultDate: valueDefaultDate ?? this.valueDefaultDate,
      timezone: timezone ?? this.timezone,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
