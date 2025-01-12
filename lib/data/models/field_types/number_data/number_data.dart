import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/number_data/schemas/db_number_data.dart';

class NumberData extends Equatable {
  /// This is a String to simplify creation and editing of this value.
  final String value;
  final double quickActionValue;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const NumberData({
    required this.value,
    required this.quickActionValue,
    required this.importReference,
    required this.encryptedValue,
  });

  /// Quicknumber action identification for adding.
  /// ```dart
  /// static const String quickNumberActionAdd = 'add';
  /// ```
  static const String quickNumberActionAdd = 'add';

  /// Quicknumber action identification for subtracting.
  /// ```dart
  /// static const String quickNumberActionSubtract = 'subtract';
  /// ```
  static const String quickNumberActionSubtract = 'subtract';

  /// Quicknumber action identification for inverting.
  /// ```dart
  /// static const String quickNumberActionInvert = 'invert';
  /// ```
  static const String quickNumberActionInvert = 'invert';

  /// Available quick number actions.
  /// ```dart
  /// static const String availableQuickNumberActions = [quickNumberActionAdd, quickNumberActionSubtract, quickNumberActionInvert];
  /// ```
  static const List<String> availableQuickNumberActions = [quickNumberActionAdd, quickNumberActionSubtract, quickNumberActionInvert];

  @override
  List<Object?> get props => [value, quickActionValue, importReference, encryptedValue];

  /// Initialize a new ```NumberData``` object.
  factory NumberData.initial() {
    return const NumberData(
      value: "",
      quickActionValue: 1.0,
      importReference: null,
      encryptedValue: null,
    );
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

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required NumberData? numberData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (numberData == null) return false;

    // Convenience variables.
    final bool hasData = numberData.value.trim().isNotEmpty;

    final bool hasRef = numberData.importReference != null && numberData.importReference!.trim().isNotEmpty;

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

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required NumberData? numberData}) {
    if (numberData == null) return null;
    if (numberData.value.isEmpty) return null;

    return numberData.getFormattedNumber;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` if ```value.isEmpty```
  /// ```dart
  /// return '$fieldLabel · $getFormatedNumber';
  /// ```
  String? getSubtitle({required String fieldLabel}) {
    if (value.isEmpty) return null;
    return '$fieldLabel · $getFormattedNumber';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` if ```value.isEmpty```
  /// ```dart
  /// return '$fieldLabel · $getFormatedNumber';
  /// ```
  String? getThirdline({required String fieldLabel}) {
    if (value.isEmpty) return null;
    return '$fieldLabel · $getFormattedNumber';
  }

  /// This getter returns the ```quickActionValue``` as String with or without decimals depending on if the number is a whole or not.
  /// ```dart
  /// if (quickActionValue % 1 == 0) return quickActionValue.toStringAsFixed(0);
  /// return quickActionValue.toString();
  /// ```
  String get getQuickActionValue {
    if (quickActionValue % 1 == 0) return quickActionValue.toStringAsFixed(0);

    return quickActionValue.toString();
  }

  /// This method can be used to convert certain number formats to the default format.
  static String convertToDefaultNumberFormat({required String value, bool absoluteValue = false}) {
    // Remove all non-numeric characters except for "." and "," and "-" and "e".
    String cleanedValue = value.replaceAll(RegExp(r'[^0-9,-.e]'), '');

    // Get index of last comma.
    final int lastCommaIndex = cleanedValue.lastIndexOf(RegExp(r','));

    // Create a new string where all commas except the last one are removed
    String resultComma = '';
    for (int i = 0; i < cleanedValue.length; i++) {
      if (cleanedValue[i] == ',' && i != lastCommaIndex) {
        continue; // Skip the commas that are not the last one
      }
      resultComma += cleanedValue[i];
    }

    // Set value.
    cleanedValue = resultComma;

    // If only "," exists, treat it as the decimal separator convert comma to dot for decimals.
    if (cleanedValue.contains(',')) cleanedValue = cleanedValue.replaceAll(',', '.');

    // Get index of last dot.
    final int lastDotIndex = cleanedValue.lastIndexOf('.');

    // Create a new string where all commas except the last one are removed
    String resultDot = '';
    for (int i = 0; i < cleanedValue.length; i++) {
      if (cleanedValue[i] == '.' && i != lastDotIndex) {
        continue; // Skip the dots that are not the last one
      }
      resultDot += cleanedValue[i];
    }

    // Set value.
    cleanedValue = resultDot;

    // Remove leading zeros.
    if (cleanedValue.length > 1) cleanedValue = cleanedValue.replaceFirst(RegExp(r'^0+'), '');

    // If value starts with ".", add 0.
    if (cleanedValue.startsWith('.')) {
      cleanedValue = "0$cleanedValue";
    }

    // Handle absolute value if the flag is true.
    if (absoluteValue && cleanedValue.startsWith('-')) {
      cleanedValue = cleanedValue.substring(1);
    }

    // Combine the cleaned parts.
    return cleanedValue;
  }

  /// Method to validate number input.
  static bool numberValidator({required String? input}) {
    try {
      // Check that value is not null.
      if (input == null) return false;

      // Trim value to make sure, users can not only provide dashes.
      input = input.trim();

      // Check if value is empty.
      if (input.isEmpty) return false;

      // Parse double.
      double.parse(input);

      return true;
    } catch (error) {
      return false;
    }
  }

  /// This method can be used to check if a number has to many characters.
  static bool tooManyNumberCharacters({required String input}) {
    try {
      // Ensure that input is not to long.
      if (input.length > 14) return true;

      return false;
    } catch (error) {
      return true;
    }
  }

  // ######################################
  // Line Chart Instructions
  // ######################################

  /// Line Chart identification to calculate the numerical progression of individual values.
  /// ```dart
  /// static const String chartInstructionNumericalProgressionIndividual = 'numerical_progression_individual';
  /// ```
  static const String chartInstructionNumericalProgressionIndividual = 'numerical_progression_individual';

  /// Line Chart identification to calculate the numerical progression of accumulated values.
  /// ```dart
  /// static const String chartInstructionNumericalProgressionAccumulated = 'numerical_progression_accumulated';
  /// ```
  static const String chartInstructionNumericalProgressionAccumulated = 'numerical_progression_accumulated';

  /// Line Chart identification to calculate the numerical order.
  /// ```dart
  /// static const String chartInstructionNumericalOrder = 'numerical_order';
  /// ```
  static const String chartInstructionNumericalOrder = 'numerical_order';

  // ######################################
  // Database
  // ######################################

  /// Convert a ```NumberData``` object to a ```DbNumberData``` object.
  DbNumberData toSchema() {
    return DbNumberData(
      // * If encryption was applied, remove value.
      // * Use try parse here because in case of import match there might not be a valid double here (empty)
      // * but the schema conversion is still needed.
      value: encryptedValue?.isNotEmpty == true ? null : double.tryParse(value),
      quickActionValue: quickActionValue,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbNumberData``` object to a ```NumberData``` object.
  static NumberData? fromSchema({required DbNumberData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // * This manual conversion is needed here because in case of an import match schema.value might be null.
    final String convertedValue = schema.value == null ? '' : schema.value.toString();

    return NumberData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : convertedValue,
      quickActionValue: schema.quickActionValue!,
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```NumberData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': valueAsDouble,
      'quick_action_value': quickActionValue,
    };
  }

  /// Decode a ```NumberData``` object from JSON.
  static NumberData fromCloudObject(document) {
    return NumberData(
      value: document['value'].toString(),
      quickActionValue: document['quick_action_value'],
      importReference: null,
      encryptedValue: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  NumberData copyWith({
    String? value,
    double? quickActionValue,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return NumberData(
      value: value ?? this.value,
      quickActionValue: quickActionValue ?? this.quickActionValue,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
