import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// Labels.
import '/main.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';

// Schemas.
import '/data/models/field_types/date_and_time_data/schemas/db_date_and_time_data.dart';

class DateAndTimeData extends Equatable {
  /// This can be null to enable not setting a value for defaults.
  final DateTime? valueInUtc;

  /// This value can be used to save a "dumb" date as a default value.
  final String? valueDefaultDate;

  /// This value can be used to save a "dumb" time as a default value.
  final String? valueDefaultTime;

  /// This can be empty in case of default.
  final String timezone;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const DateAndTimeData({
    required this.valueInUtc,
    required this.valueDefaultDate,
    required this.valueDefaultTime,
    required this.timezone,
    required this.importReference,
    required this.encryptedValue,
  });

  /// Initialize a new ```DateAndTimeData``` object.
  factory DateAndTimeData.initial() {
    return const DateAndTimeData(
      valueInUtc: null,
      valueDefaultDate: null,
      valueDefaultTime: null,
      timezone: "",
      importReference: null,
      encryptedValue: null,
    );
  }

  @override
  List<Object?> get props => [
        valueInUtc,
        valueDefaultDate,
        valueDefaultTime,
        timezone,
        importReference,
        encryptedValue,
      ];

  /// This getter can be used to access createdAt in a readable format.
  /// * Assumes values are not null.
  String getCreatedAt({required bool preserveUtc, required bool date, required bool time, String dateFormat = 'yyyy-MM-dd'}) {
    // Convert value.
    final DateTime converted = HelperFunctions.convertToTimezone(
      dateTimeInUtc: valueInUtc,
      timezone: timezone,
      preserveUtc: preserveUtc,
    );

    if (date && time) return '${DateFormat(dateFormat).format(converted)} ${labels.basicLabelsAt()} ${DateFormat("HH:mm").format(converted)}';

    if (date) return DateFormat(dateFormat).format(converted);

    return DateFormat("HH:mm").format(converted);
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
  static bool includeField({required DateAndTimeData? dateAndTimeData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (dateAndTimeData == null) return false;

    // Convenience variables.
    final bool hasDate = dateAndTimeData.valueInUtc != null;
    final bool hasTimezone = dateAndTimeData.timezone.isNotEmpty;

    final bool hasDateDefault = dateAndTimeData.valueDefaultDate != null && dateAndTimeData.valueDefaultDate!.isNotEmpty;
    final bool hasTimeDefault = dateAndTimeData.valueDefaultTime != null && dateAndTimeData.valueDefaultTime!.isNotEmpty;

    final bool hasDateRef = dateAndTimeData.importReference != null && dateAndTimeData.importReference!.trim().isNotEmpty;

    // * User is in set default mode.
    if (isDefault) {
      // If any value is set, return true.
      // * In default date should be null because defaultDate and defaultTime should be used.
      return [
        hasDateDefault,
        hasTimeDefault,
        hasTimezone,
      ].any((condition) => condition);
    }

    // * User is in import mode.
    if (isImport) {
      // User set an import reference.
      if (hasDateRef) return true;

      // * User might also have set a default value but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if required values are set.
    if (hasDate && hasTimezone) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required DateAndTimeData? dateAndTimeData}) {
    if (dateAndTimeData == null) return null;
    if (dateAndTimeData.valueInUtc == null) return null;

    return labels.basicLabelsDateTimeAndTimezone(
      date: dateAndTimeData.getCreatedAt(preserveUtc: true, date: true, time: true),
      timezone: dateAndTimeData.getCreatedAtTimezone(preserveUtc: true),
    );
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` if ```value == null```
  /// ```dart
  /// return '$fieldLabel · $getFormatedDate';
  /// ```
  String? getSubtitle({required String fieldLabel}) {
    // Test for null value.
    if (valueInUtc == null) return null;

    // Access date.
    final String dateValue = labels.basicLabelsDateTimeAndTimezone(
      date: getCreatedAt(preserveUtc: true, date: true, time: true),
      timezone: getCreatedAtTimezone(preserveUtc: true),
    );

    return '$fieldLabel · $dateValue';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` if ```value == null```
  /// ```dart
  /// return '$fieldLabel · $getFormatedDate';
  /// ```
  String? getThirdline({required String fieldLabel}) {
    // Test for null value.
    if (valueInUtc == null) return null;

    // Access date.
    final String dateValue = labels.basicLabelsDateTimeAndTimezone(
      date: getCreatedAt(preserveUtc: true, date: true, time: true),
      timezone: getCreatedAtTimezone(preserveUtc: true),
    );

    return '$fieldLabel · $dateValue';
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```DateAndTimeData``` object to a ```DbDateAndTimeData``` object.
  DbDateAndTimeData toSchema() {
    return DbDateAndTimeData(
      // If encryption was applied, remove value.
      // * Value can be null in case of default.
      valueInUtc: encryptedValue?.isNotEmpty == true ? null : valueInUtc?.millisecondsSinceEpoch,
      valueDefaultDate: valueDefaultDate,
      valueDefaultTime: valueDefaultTime,
      timezone: timezone.isEmpty ? null : timezone,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbDateAndTimeData``` object to a ```DateAndTimeData``` object.
  static DateAndTimeData? fromSchema({required DbDateAndTimeData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return DateAndTimeData(
      // If encryption was applied, set value to a placeholder until decryption.
      // * These can be null in case of defaults.
      // ! This is also null if a ModelEntry with import specs is loaded from local storage. Because in that case only the importReference is set.
      valueInUtc: schema.encryptedValue?.isNotEmpty == true || schema.valueInUtc == null ? null : DateTime.fromMillisecondsSinceEpoch(schema.valueInUtc!, isUtc: true),
      valueDefaultDate: schema.valueDefaultDate,
      valueDefaultTime: schema.valueDefaultTime,
      timezone: schema.timezone ?? "",
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```DateAndTimeData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      // * Can be null in case of default.
      'value_in_utc': valueInUtc?.toIso8601String(),
      'default_date': valueDefaultDate,
      'default_time': valueDefaultTime,
      // * Can be null in case of default.
      'timezone': timezone.isEmpty ? null : timezone,
    };
  }

  /// Decode a ```DateAndTimeData``` object from JSON.
  static DateAndTimeData fromCloudObject(document) {
    return DateAndTimeData(
      // In case of default, this might be null.
      valueInUtc: document['value_in_utc'] == null ? null : DateTime.parse(document['value_in_utc']),
      valueDefaultDate: document['default_date'],
      valueDefaultTime: document['default_time'],
      // In case of default, this might be null.
      timezone: document['timezone'] ?? "",
      importReference: null,
      encryptedValue: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  DateAndTimeData copyWith({
    DateTime? valueInUtc,
    String? valueDefaultDate,
    String? valueDefaultTime,
    String? timezone,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return DateAndTimeData(
      valueInUtc: valueInUtc ?? this.valueInUtc,
      valueDefaultDate: valueDefaultDate ?? this.valueDefaultDate,
      valueDefaultTime: valueDefaultTime ?? this.valueDefaultTime,
      timezone: timezone ?? this.timezone,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
