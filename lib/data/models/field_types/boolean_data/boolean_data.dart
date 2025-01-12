import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/boolean_data/schemas/db_boolean_data.dart';

class BooleanData extends Equatable {
  final bool? value;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const BooleanData({
    required this.value,
    required this.importReference,
    required this.encryptedValue,
  });

  @override
  List<Object?> get props => [value, importReference, encryptedValue];

  /// Initialize a new ```BooleanData``` object.
  factory BooleanData.initial() {
    return const BooleanData(
      value: null,
      importReference: null,
      encryptedValue: null,
    );
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required BooleanData? booleanData, required bool isDefault, required bool isImport}) {
    // NO field supplied.
    if (booleanData == null) return false;

    // Convenience variables.
    final bool hasData = booleanData.value != null;

    final bool hasRef = booleanData.importReference != null && booleanData.importReference!.trim().isNotEmpty;

    // * User is in set default mode.
    if (isDefault) {
      // User set a default value.
      if (hasData) return true;

      return false;
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import reference.
      if (hasRef) return true;

      // * User might also have set a default value but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if value is set.
    if (hasData) return true;

    return false;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// ```dart
  /// return '$fieldLabel · $value';
  /// ```
  String getSubtitle({required String fieldLabel}) {
    return '$fieldLabel · $value';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// ```dart
  /// return '$fieldLabel · $value';
  /// ```
  String getThirdline({required String fieldLabel}) {
    return '$fieldLabel · $value';
  }

  /// This method can be used to try an parse a String to a boolean.
  /// * This method returns ```null``` if it cannot convert given String to a boolean.
  static bool? tryParse({required String? value}) {
    // * No value provided.
    if (value == null) return null;

    // Access desired row value.
    String accessedValue = value.trim().toLowerCase();

    if (accessedValue == "yes") accessedValue = "true";
    if (accessedValue == "no") accessedValue = "false";

    if (accessedValue == "on") accessedValue = "true";
    if (accessedValue == "off") accessedValue = "false";

    if (accessedValue == "ja") accessedValue = "true";
    if (accessedValue == "nein") accessedValue = "false";

    if (accessedValue == "oui") accessedValue = "true";
    if (accessedValue == "non") accessedValue = "false";

    if (accessedValue == "si") accessedValue = "true";
    if (accessedValue == "no") accessedValue = "false";

    if (accessedValue == "0") accessedValue = "false";
    if (accessedValue == "1") accessedValue = "true";

    // Try and parse value.
    final bool? parsed = bool.tryParse(accessedValue, caseSensitive: false);

    return parsed;
  }

  // ######################################
  // Pie Chart Instructions
  // ######################################

  /// Pie Chart identification to calculate true false distribution
  /// ```dart
  /// static const String pieChartTrueFalseDistribution = 'true_false_distribution';
  /// ```
  static const String pieChartTrueFalseDistribution = 'true_false_distribution';

  // ######################################
  // Bar Chart Instructions
  // ######################################

  /// Pie Chart identification to display true false history
  /// ```dart
  /// static const String barChartTrueFalseHistory = 'true_false_history';
  /// ```
  static const String barChartTrueFalseHistory = 'true_false_history';

  // ######################################
  // Database
  // ######################################

  /// Convert a ```BooleanData``` object to a ```DbBooleanData``` object.
  DbBooleanData toSchema() {
    return DbBooleanData(
      // If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbBooleanData``` object to a ```BooleanData``` object.
  static BooleanData? fromSchema({required DbBooleanData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return BooleanData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? null : schema.value,
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```BooleanData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': value!,
    };
  }

  /// Decode a ```BooleanData``` object from JSON.
  static BooleanData fromCloudObject(document) {
    return BooleanData(
      value: document['value'],
      importReference: null,
      encryptedValue: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  BooleanData copyWith({
    bool? value,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return BooleanData(
      value: value ?? this.value,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
