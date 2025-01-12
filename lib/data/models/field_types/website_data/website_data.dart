import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Config.
import '/config/country_specification.dart';

// Schemas.
import '/data/models/field_types/website_data/schemas/db_website_data.dart';

class WebsiteData extends Equatable {
  final String value;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const WebsiteData({
    required this.value,
    required this.importReference,
    required this.encryptedValue,
  });

  /// Initialize a new ```WebsiteData``` object.
  factory WebsiteData.initial() {
    return const WebsiteData(
      value: '',
      importReference: null,
      encryptedValue: null,
    );
  }

  @override
  List<Object?> get props => [value, importReference, encryptedValue];

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required WebsiteData? websiteData, required bool isDefault, required bool isImport}) {
    // No value suplied, exclude.
    if (websiteData == null) return false;

    // Convenience variables.
    final bool hasData = websiteData.value.trim().isNotEmpty;

    final bool hasRef = websiteData.importReference != null && websiteData.importReference!.trim().isNotEmpty;

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
  static String? getCopyValue({required WebsiteData? websiteData}) {
    if (websiteData == null) return null;
    if (websiteData.value.isEmpty) return null;

    return websiteData.value;
  }

  /// This method can be used to access the top level domain of a website value.
  /// * Returns "" if top level domain cannot be found.
  static String accessTopLevelDomain({required String? value}) {
    // No value provided.
    if (value == null || value.isEmpty) return "";

    // check if website contains a topLevelDomain.
    if (value.contains(".")) {
      // Get last index of "@";
      // * Deals with cases where multiple "." were supplied.
      final int index = value.lastIndexOf(".");

      // Get last desired index.
      final int lastDesired = (index + 4) > value.length ? value.length : (index + 4);

      // Only get topLevelDomain.
      // * this is by far not perfect.
      String topLevelDomain = value.substring(index, lastDesired).replaceAll("/", "");
      topLevelDomain = value.substring(index, lastDesired).replaceAll("?", "");
      topLevelDomain = value.substring(index, lastDesired).replaceAll("#", "");
      topLevelDomain = value.substring(index, lastDesired).replaceAll("%", "");
      topLevelDomain = value.substring(index, lastDesired).replaceAll("@", "");

      // Check if this topLevelDomain is in CountrySpecification.
      final bool topLevelDomainValid = CountrySpecification.topLevelDomainFound(
        topLevelDomain: topLevelDomain,
      );

      // If domain was not found, reset to empty.
      topLevelDomain = topLevelDomainValid ? topLevelDomain.toLowerCase() : "";

      return topLevelDomain;
    }

    return "";
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

  /// Convert a ```WebsiteData``` object to a ```DbWebsiteData``` object.
  DbWebsiteData toSchema() {
    return DbWebsiteData(
      // * If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbWebsiteData``` object to a ```WebsiteData``` object.
  static WebsiteData? fromSchema({required DbWebsiteData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return WebsiteData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : schema.value!,
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```WebsiteData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': value,
    };
  }

  /// Decode a ```WebsiteData``` object from JSON.
  static WebsiteData fromCloudObject(document) {
    return WebsiteData(
      value: document['value'],
      importReference: null,
      encryptedValue: null,
    );
  }

  WebsiteData copyWith({
    String? value,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return WebsiteData(
      value: value ?? this.value,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
