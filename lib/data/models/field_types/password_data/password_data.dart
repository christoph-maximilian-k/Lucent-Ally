import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/password_data/schemas/db_password_data.dart';

class PasswordData extends Equatable {
  final String value;
  final bool obscure;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const PasswordData({
    required this.value,
    required this.obscure,
    required this.importReference,
    required this.encryptedValue,
  });

  /// Initialize a new ```PasswordData``` object.
  factory PasswordData.initial() {
    return const PasswordData(
      value: '',
      obscure: true,
      importReference: null,
      encryptedValue: null,
    );
  }

  @override
  List<Object?> get props => [value, obscure, importReference, encryptedValue];

  /// This getter can be used to get password data depending on ```obscure```.
  /// ```dart
  /// return obscure ? "·" * value.length : value;
  /// ```
  String get getObscuredValue {
    return obscure ? "·" * value.length : value;
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required PasswordData? passwordData, required bool isDefault, required bool isImport}) {
    // No value suplied, exclude.
    if (passwordData == null) return false;

    // Convenience variables.
    final bool hasData = passwordData.value.trim().isNotEmpty;

    final bool hasRef = passwordData.importReference != null && passwordData.importReference!.trim().isNotEmpty;

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
  static String? getCopyValue({required PasswordData? passwordData}) {
    if (passwordData == null) return null;
    if (passwordData.value.isEmpty) return null;

    return passwordData.value;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` because password should not be available to be set as a subtitle.
  String? getSubtitle({required String fieldLabel}) {
    return null;
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` because password should not be available to be set as a thirdline.
  String? getThirdline({required String fieldLabel}) {
    return null;
  }

  /// ######################################
  /// Statistics
  /// ######################################

  /// This method can be used to access label of provided chart instruction.
  /// * returns ```null``` if ```instructionType``` is not known
  static String? instructionTypeLabels({required String instructionType}) {
    return null;
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```PasswordData``` object to a ```DbPasswordData``` object.
  DbPasswordData toSchema() {
    return DbPasswordData(
      // If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbPasswordData``` object to a ```PasswordData``` object.
  static PasswordData? fromSchema({required DbPasswordData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return PasswordData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : schema.value!,
      obscure: true,
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```PasswordData``` object to JSON.
  /// * Do not encode ```obscure``` because it is a state variable.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': value,
    };
  }

  /// Decode a ```PasswordData``` object from JSON.
  static PasswordData fromCloudObject(document) {
    return PasswordData(
      value: document['value'],
      obscure: true,
      importReference: null,
      encryptedValue: null,
    );
  }

  PasswordData copyWith({
    String? value,
    bool? obscure,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return PasswordData(
      value: value ?? this.value,
      obscure: obscure ?? this.obscure,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
