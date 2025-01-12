import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/email_data/schemas/db_email_data.dart';

class EmailData extends Equatable {
  final String value;
  final String provider;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const EmailData({
    required this.value,
    required this.provider,
    required this.importReference,
    required this.encryptedValue,
  });

  /// Initialize a new ```EmailData``` object.
  factory EmailData.initial() {
    return const EmailData(
      value: '',
      provider: '',
      importReference: null,
      encryptedValue: null,
    );
  }

  @override
  List<Object?> get props => [value, provider, importReference, encryptedValue];

  /// This method can be used to indicate if this field should be included from being saved to local storage.
  static bool includeField({required EmailData? emailData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (emailData == null) return false;

    // Convenience variables.
    final bool hasData = emailData.value.trim().isNotEmpty;

    final bool hasRef = emailData.importReference != null && emailData.importReference!.trim().isNotEmpty;

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
  static String? getCopyValue({required EmailData? emailData}) {
    if (emailData == null) return null;
    if (emailData.value.isEmpty) return null;

    return emailData.value;
  }

  /// This method can be used to access the provider of a email value.
  /// * Returns an "" if provider cannot be found.
  static String accessProvider({required String? value}) {
    // No value provided.
    if (value == null || value.isEmpty) return "";

    // check if email contains a provider.
    if (value.contains("@")) {
      // Get last index of "@";
      // * Deals with cases where multiple "@" were supplied.
      final int index = value.lastIndexOf("@");

      // Only get provider.
      // * This is by far not perfect.
      final String provider = value.substring(index).replaceAll('@', '');

      return provider;
    }

    return "";
  }

  /// This method can be used to check if a valid email was provided.
  static bool isValidEmail({required String? value}) {
    // No value was given.
    if (value == null || value.trim().isEmpty) return false;

    // Define a regular expression for email validation.
    const String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(pattern);

    // Return true if the email matches the pattern, otherwise false.
    return regex.hasMatch(value);
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

  // -------------------------------------
  // Bar Chart Instructions
  // -------------------------------------

  /// Pie Chart identification to display email frequency distribution.
  /// ```dart
  /// static const String barChartFrequencyDistribution = 'frequency_distribution';
  /// ```
  static const String barChartFrequencyDistribution = 'frequency_distribution';

  // -------------------------------------
  // Pie Chart Instructions
  // -------------------------------------

  /// Pie Chart identification to display email frequency shares.
  /// ```dart
  /// static const String pieChartFrequencyShares = 'frequency_shares';
  /// ```
  static const String pieChartFrequencyShares = 'frequency_shares';

  /// Pie Chart identification to display email provider distribution.
  /// ```dart
  /// static const String pieChartProviderDistribution = 'provider_distribution';
  /// ```
  static const String pieChartProviderDistribution = 'provider_distribution';

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```EmailData``` object to a ```DbEmailData``` object.
  DbEmailData toSchema() {
    return DbEmailData(
      // * If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value,
      provider: provider,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbEmailData``` object to a ```EmailData``` object.
  static EmailData? fromSchema({required DbEmailData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return EmailData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : schema.value!,
      provider: schema.provider!,
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```EmailData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': value,
      'provider': provider,
    };
  }

  /// Decode a ```EmailData``` object from JSON.
  static EmailData fromCloudObject(document) {
    return EmailData(
      value: document['value'],
      provider: document['provider'],
      importReference: null,
      encryptedValue: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  EmailData copyWith({
    String? value,
    String? provider,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return EmailData(
      value: value ?? this.value,
      provider: provider ?? this.provider,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
