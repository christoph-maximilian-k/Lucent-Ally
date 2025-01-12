import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Config.
import '/config/country_specification.dart';

// Schemas.
import '/data/models/field_types/phone_data/schemas/db_phone_data.dart';

class PhoneData extends Equatable {
  final String value;
  final String internationalPrefix;

  final String? importReference;
  final String? importReferenceInternationalPrefix;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedInternationalPrefix;

  const PhoneData({
    required this.value,
    required this.internationalPrefix,
    required this.importReference,
    required this.importReferenceInternationalPrefix,
    required this.encryptedValue,
    required this.encryptedInternationalPrefix,
  });

  /// Initialize a new ```PhoneData``` object.
  factory PhoneData.initial() {
    return const PhoneData(
      value: '',
      internationalPrefix: '',
      importReference: null,
      importReferenceInternationalPrefix: null,
      encryptedValue: null,
      encryptedInternationalPrefix: null,
    );
  }

  @override
  List<Object?> get props => [value, internationalPrefix, importReference, importReferenceInternationalPrefix, encryptedValue, encryptedInternationalPrefix];

  /// This getter can be used to access relevant phone data.
  String get getValue {
    if (internationalPrefix.isNotEmpty) return '$internationalPrefix $value';
    return value;
  }

  /// This method can be used to validate a given international prefix and return a cleaned version of it.
  /// * Returns ```null``` if a invalid prefix is found.
  /// * Returns ```""``` if value is empty or null because prefix is optional.
  static String? validatePrefix({required String? value}) {
    // Return empty if no value is provided.
    if (value == null || value.trim().isEmpty) return "";

    // Clean value.
    final String cleaned = value.replaceAll(RegExp(r'[^0-9\+]'), '');

    // Ensure that this prefix exists.
    final bool isValidPrefix = CountrySpecification.internationalPrefixFound(prefix: cleaned);

    // Prefix was found.
    if (isValidPrefix) return cleaned;

    // Prefix is invalid.
    return null;
  }

  /// This method can be used to validate a given phone number and return a cleaned version of it.
  /// * Returns ```null``` if a invalid phone is found.
  static String? validatePhone({required String? value}) {
    // Return empty if no value is provided.
    if (value == null || value.trim().isEmpty) return null;

    // Clean value.
    // * This is done with two RegExp because for some reason fucking escaping " and ' gave me a hard time and this was quicker.
    String cleaned = value.replaceAll(RegExp(r'["\s-]'), '');
    cleaned = value.replaceAll(RegExp(r"[']"), '');

    // No phone provided.
    if (cleaned.isEmpty) return null;

    // Phone is valid.
    return cleaned;
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required PhoneData? phoneData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (phoneData == null) return false;

    // Convenience variables.
    final bool hasData = phoneData.value.trim().isNotEmpty;

    final bool hasRef = phoneData.importReference != null && phoneData.importReference!.trim().isNotEmpty;

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
  static String? getCopyValue({required PhoneData? phoneData}) {
    if (phoneData == null) return null;
    if (phoneData.value.isEmpty) return null;

    if (phoneData.internationalPrefix.isNotEmpty) return '${phoneData.internationalPrefix} ${phoneData.value}';
    return phoneData.value;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// ```dart
  /// if (internationalPrefix.isNotEmpty) return '$fieldLabel · $internationalPrefix $value';
  /// return '$fieldLabel · $value';
  /// ```
  String getSubtitle({required String fieldLabel}) {
    if (internationalPrefix.isNotEmpty) return '$fieldLabel · $internationalPrefix $value';
    return '$fieldLabel · $value';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// ```dart
  /// if (internationalPrefix.isNotEmpty) return '$fieldLabel · $internationalPrefix $value';
  /// return '$fieldLabel · $value';
  /// ```
  String getThirdline({required String fieldLabel}) {
    if (internationalPrefix.isNotEmpty) return '$fieldLabel · $internationalPrefix $value';
    return '$fieldLabel · $value';
  }

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```PhoneData``` object to a ```DbPhoneData``` object.
  DbPhoneData toSchema() {
    return DbPhoneData(
      // If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value,
      // If encryption was applied, remove prefix.
      internationalPrefix: encryptedInternationalPrefix?.isNotEmpty == true ? null : internationalPrefix,
      importReference: importReference,
      importReferenceInternationalPrefix: importReferenceInternationalPrefix,
      encryptedValue: encryptedValue,
      encryptedInternationalPrefix: encryptedInternationalPrefix,
    );
  }

  /// Convert a ```DbPhoneData``` object to a ```PasswordData``` object.
  static PhoneData? fromSchema({required DbPhoneData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return PhoneData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : schema.value!,
      // If encryption was applied, set value to a placeholder until decryption.
      internationalPrefix: schema.encryptedInternationalPrefix?.isNotEmpty == true ? '' : schema.internationalPrefix!,
      importReference: schema.importReference,
      importReferenceInternationalPrefix: schema.importReferenceInternationalPrefix,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedInternationalPrefix: schema.encryptedInternationalPrefix != null ? Uint8List.fromList(schema.encryptedInternationalPrefix!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```PhoneData``` object to JSON.
  Map<String, String> toCloudObject() {
    return {
      'value': value,
      'international_prefix': internationalPrefix,
    };
  }

  /// Decode a ```PhoneData``` object from JSON.
  static PhoneData fromCloudObject(document) {
    return PhoneData(
      value: document['value'],
      internationalPrefix: document['international_prefix'],
      importReference: null,
      importReferenceInternationalPrefix: null,
      encryptedValue: null,
      encryptedInternationalPrefix: null,
    );
  }

  PhoneData copyWith({
    String? value,
    String? internationalPrefix,
    String? importReference,
    String? importReferenceInternationalPrefix,
    Uint8List? encryptedValue,
    Uint8List? encryptedInternationalPrefix,
  }) {
    return PhoneData(
      value: value ?? this.value,
      internationalPrefix: internationalPrefix ?? this.internationalPrefix,
      importReference: importReference ?? this.importReference,
      importReferenceInternationalPrefix: importReferenceInternationalPrefix ?? this.importReferenceInternationalPrefix,
      encryptedValue: encryptedValue ?? this.encryptedValue,
      encryptedInternationalPrefix: encryptedInternationalPrefix ?? this.encryptedInternationalPrefix,
    );
  }
}
