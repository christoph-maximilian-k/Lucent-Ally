import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/text_data/schemas/db_text_data.dart';

class TextData extends Equatable {
  final String value;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const TextData({
    required this.value,
    required this.importReference,
    required this.encryptedValue,
  });

  @override
  List<Object?> get props => [value, importReference, encryptedValue];

  /// Initialize a new ```TextData``` object.
  factory TextData.initial() {
    return const TextData(
      value: '',
      importReference: null,
      encryptedValue: null,
    );
  }

  /// This method can be used to indicate if this field should be included from being saved to local storage.
  static bool includeField({required TextData? textData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (textData == null) return false;

    // Convenience variables.
    final bool hasData = textData.value.trim().isNotEmpty;

    final bool hasRef = textData.importReference != null && textData.importReference!.trim().isNotEmpty;

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
  static String? getCopyValue({required TextData? textData}) {
    if (textData == null) return null;
    if (textData.value.isEmpty) return null;

    return textData.value;
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

  // #####################################
  // Database
  // #####################################

  /// Convert a ```TextData``` object to a ```DbTextData``` object.
  DbTextData toSchema() {
    return DbTextData(
      // If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbTextData``` object to a ```TextData``` object.
  static TextData? fromSchema({required DbTextData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return TextData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : schema.value!,
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode a ```TextData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': value,
    };
  }

  /// Decode a ```TextData``` object from JSON.
  static TextData fromCloudObject(document) {
    return TextData(
      value: document['value'],
      importReference: null,
      encryptedValue: null,
    );
  }

  // #####################################
  // Copy With
  // #####################################

  TextData copyWith({
    String? value,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return TextData(
      value: value ?? this.value,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
