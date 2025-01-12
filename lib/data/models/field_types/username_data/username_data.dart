import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/username_data/schemas/db_username_data.dart';

class UsernameData extends Equatable {
  final String value;

  /// This variable holds information about where this username is used.
  /// * Attention: it can be left empty because it is optional!
  final String service;

  final String? importReferenceValue;
  final String? importReferenceOptionalValue;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedService;

  const UsernameData({
    required this.value,
    required this.service,
    required this.importReferenceValue,
    required this.importReferenceOptionalValue,
    required this.encryptedValue,
    required this.encryptedService,
  });

  /// Initialize a new ```UsernameData``` object.
  factory UsernameData.initial() {
    return const UsernameData(
      value: '',
      service: '',
      importReferenceValue: null,
      importReferenceOptionalValue: null,
      encryptedValue: null,
      encryptedService: null,
    );
  }

  @override
  List<Object?> get props => [value, service, importReferenceValue, importReferenceOptionalValue, encryptedValue, encryptedService];

  /// This method can be used to indicate if this field should be included from being saved to local storage.
  static bool includeField({required UsernameData? usernameData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (usernameData == null) return false;

    // Convenience variables.
    final bool hasData = usernameData.value.trim().isNotEmpty;

    final bool hasRef = usernameData.importReferenceValue != null && usernameData.importReferenceValue!.trim().isNotEmpty;

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
  static String? getCopyValue({required UsernameData? usernameData}) {
    if (usernameData == null) return null;
    if (usernameData.value.isEmpty) return null;

    return usernameData.value;
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
  // Pie Chart Instructions
  // -------------------------------------

  /// Pie Chart identification to display username frequency shares.
  /// ```dart
  /// static const String pieChartUsernameDistribution = 'username_distribution';
  /// ```
  static const String pieChartUsernameDistribution = 'username_distribution';

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```UsernameData``` object to a ```DbUsernameData``` object.
  DbUsernameData toSchema() {
    return DbUsernameData(
      // * If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value,
      // * If encryption was applied, remove value.
      service: encryptedService?.isNotEmpty == true ? null : service,
      importReferenceValue: importReferenceValue,
      importReferenceOptionalValue: importReferenceOptionalValue,
      encryptedValue: encryptedValue,
      encryptedService: encryptedService,
    );
  }

  /// Convert a ```DbUsernameData``` object to a ```UsernameData``` object.
  static UsernameData? fromSchema({required DbUsernameData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return UsernameData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : schema.value!,
      // If encryption was applied, set value to a placeholder until decryption.
      service: schema.encryptedService?.isNotEmpty == true ? '' : schema.service!,
      importReferenceValue: schema.importReferenceValue,
      importReferenceOptionalValue: schema.importReferenceOptionalValue,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedService: schema.encryptedService != null ? Uint8List.fromList(schema.encryptedService!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```UsernameData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': value,
      'service': service,
    };
  }

  /// Decode a ```UsernameData``` object from JSON.
  static UsernameData fromCloudObject(document) {
    return UsernameData(
      value: document['value'],
      service: document['service'],
      importReferenceValue: null,
      importReferenceOptionalValue: null,
      encryptedValue: null,
      encryptedService: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  UsernameData copyWith({
    String? value,
    String? service,
    String? importReferenceValue,
    String? importReferenceOptionalValue,
    Uint8List? encryptedValue,
    Uint8List? encryptedService,
  }) {
    return UsernameData(
      value: value ?? this.value,
      service: service ?? this.service,
      importReferenceValue: importReferenceValue ?? this.importReferenceValue,
      importReferenceOptionalValue: importReferenceOptionalValue ?? this.importReferenceOptionalValue,
      encryptedValue: encryptedValue ?? this.encryptedValue,
      encryptedService: encryptedService ?? this.encryptedService,
    );
  }
}
