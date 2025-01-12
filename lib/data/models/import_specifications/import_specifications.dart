import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

// User with Settings and Labels.
import '/main.dart';

// Logic.
import '/logic/helper_functions/helper_functions.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';

// Models.
import '/data/models/fields/fields.dart';
import '/data/models/fields/field.dart';

// Schemas.
import '/data/models/import_specifications/schemas/db_import_specifications.dart';

class ImportSpecifications extends Equatable {
  final String entryNameInstruction;
  final String entryNameDefault;
  final String createdAtInstruction;
  final String missingValueRule;
  final String invalidValueRule;
  final Fields fields;

  const ImportSpecifications({
    required this.entryNameInstruction,
    required this.entryNameDefault,
    required this.createdAtInstruction,
    required this.missingValueRule,
    required this.invalidValueRule,
    required this.fields,
  });

  /// Object reference for the value.
  /// ```dart
  /// static const String objectReferenceValue = 'value';
  /// ```
  static const String objectReferenceValue = 'value';

  /// Object reference for a optional value.
  /// ```dart
  /// static const String objectReferenceOptionalValue = 'optional_value';
  /// ```
  static const String objectReferenceOptionalValue = 'optional_value';

  /// Object reference for the value.
  /// ```dart
  /// static const String objectReferenceCurrency = 'currency';
  /// ```
  static const String objectReferenceCurrency = 'currency';

  /// Object reference for the paid_by.
  /// ```dart
  /// static const String objectReferencePaidBy = 'paid_by';
  /// ```
  static const String objectReferencePaidBy = 'paid_by';

  /// Object reference for the is_compensated.
  /// ```dart
  /// static const String objectReferenceIsCompensated = 'is_compensated';
  /// ```
  static const String objectReferenceIsCompensated = 'is_compensated';

  /// Object reference for a member.
  /// ```dart
  /// static const String objectReferenceMember = 'member';
  /// ```
  static const String objectReferenceMember = 'member';

  /// Object reference for a date.
  /// ```dart
  /// static const String objectReferenceDate = 'date';
  /// ```
  static const String objectReferenceDate = 'date';

  /// Object reference for a tags.
  /// ```dart
  /// static const String objectReferenceTags = 'tags';
  /// ```
  static const String objectReferenceTags = 'tags';

  /// Object reference for a latitude.
  /// ```dart
  /// static const String objectReferenceLatitude = 'latitude';
  /// ```
  static const String objectReferenceLatitude = 'latitude';

  /// Object reference for a longitude.
  /// ```dart
  /// static const String objectReferenceLongitude = 'longitude';
  /// ```
  static const String objectReferenceLongitude = 'longitude';

  /// Object reference for a category.
  /// ```dart
  /// static const String objectReferenceCategory = 'category';
  /// ```
  static const String objectReferenceCategory = 'category';

  /// Object reference for a unit.
  /// ```dart
  /// static const String objectReferenceUnit = 'unit';
  /// ```
  static const String objectReferenceUnit = 'unit';

  /// Object reference for a emotion.
  /// ```dart
  /// static const String objectReferenceEmotion = 'emotion';
  /// ```
  static const String objectReferenceEmotion = 'emotion';

  /// Object reference for a intensity.
  /// ```dart
  /// static const String objectReferenceIntensity = 'intensity';
  /// ```
  static const String objectReferenceIntensity = 'intensity';

  /// Object reference for a occurrence.
  /// ```dart
  /// static const String objectReferenceOccurrence = 'occurrence';
  /// ```
  static const String objectReferenceOccurrence = 'occurrence';

  /// Object reference for exchange rate.
  /// ```dart
  /// static const String objectReferenceCustomExchangeRate = 'exchange_rate';
  /// ```
  static const String objectReferenceCustomExchangeRate = 'exchange_rate';

  // ##########################################

  /// Identification for the import rule: fail
  /// ```dart
  /// static const String importRuleFail = 'fail';
  /// ```
  static const String importRuleFail = 'fail';

  /// Identification for the import rule: skip
  /// ```dart
  /// static const String importRuleSkip = 'skip';
  /// ```
  static const String importRuleSkip = 'skip';

  /// Identification for the import rule: default or fail
  /// ```dart
  /// static const String importRuleDefaultOrFail = 'default_or_fail';
  /// ```
  static const String importRuleDefaultOrFail = 'default_or_fail';

  /// Identification for the import rule: default or skip
  /// ```dart
  /// static const String importRuleDefaultOrSkip = 'default_or_skip';
  /// ```
  static const String importRuleDefaultOrSkip = 'default_or_skip';

  // ###########################################

  /// Can be used to indicate that a value is missing.
  /// ```dart
  /// static const String missingValue = 'missing';
  /// ```
  static const String missingValue = 'missing';

  /// Can be used to indicate that a value is invalid.
  /// ```dart
  /// static const String invalidValue = 'invalid';
  /// ```
  static const String invalidValue = 'invalid';

  /// Initialize a new ```ImportSpecifications``` object.
  factory ImportSpecifications.initial() {
    return ImportSpecifications(
      entryNameInstruction: '',
      entryNameDefault: '',
      createdAtInstruction: '',
      missingValueRule: '',
      invalidValueRule: '',
      fields: Fields.initial(),
    );
  }

  @override
  List<Object> get props => [entryNameInstruction, entryNameDefault, createdAtInstruction, missingValueRule, invalidValueRule, fields];

  /// This method can be used to generate entry fields from import instructions.
  /// * Should be used in a try catch block.
  Future<Fields> fieldsFromImportInstructions({required Map<String, dynamic> row, required int currentRow, required LocalStorageCubit localStorageCubit, required String defaultCurrencyCode, required String groupParticipantReference}) async {
    // Init helper.
    List<Field> helper = [];

    // Go through instructions and create fields based on it.
    for (final Field instructionField in fields.items) {
      // Create field.
      final Map<String, dynamic>? importValue = await instructionField.importField(
        row: row,
        defaultCurrencyCode: defaultCurrencyCode,
        localStorageCubit: localStorageCubit,
        currentRow: currentRow,
        invalidValueRule: invalidValueRule,
        missingValueRule: missingValueRule,
        participantReference: groupParticipantReference,
      );

      // * If value is null output debug message and skip value.
      if (importValue == null) {
        // Output message.
        debugPrint('ImportSpecifications --> fieldsFromImportInstructions() --> unknown field type.');
        continue;
      }

      // Access map keys.
      final bool skip = importValue['skip'];
      final Field? field = importValue['field'];

      // Value should be skipped.
      if (skip) continue;

      // Add to helper.
      helper.add(field!);
    }

    return Fields(items: helper);
  }

  /// This method can be used to access the correct entry name.
  String getImportEntryName({required Map<String, dynamic> row, required String defaultEntryName}) {
    // Check if specified instruction results in a value.
    final bool rowValueExists = row[entryNameInstruction] != null && row[entryNameInstruction].toString().trim().isNotEmpty;

    // A row value exists, return it.
    if (rowValueExists) return row[entryNameInstruction].toString();

    // Otherwise check if a default value was set.
    if (defaultEntryName.isNotEmpty) return defaultEntryName;

    // If neither a row value nor a default value exists, return static name.
    return labels.basicLabelsUnnamed();
  }

  /// This method can be used to access the correct created at.
  DateTime getImportCreatedAtInUtc({required Map<String, dynamic> row}) {
    // Check if specified instruction results in a value.
    final bool rowValueExists = row[createdAtInstruction] != null && row[createdAtInstruction].toString().trim().isNotEmpty;

    // If row value does not exist, return now.
    if (rowValueExists == false) return DateTime.now().toUtc();

    // Try and parse value.
    final DateTime? parsed = HelperFunctions.parseDate(value: row[createdAtInstruction].toString().trim());

    // A row value exists, return it.
    if (parsed != null) return parsed.toUtc();

    // Otherwise return now.
    return DateTime.now().toUtc();
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```ImportSpecifications``` object to a ```DbImportSpecifications``` object.
  DbImportSpecifications toSchema() {
    return DbImportSpecifications(
      entryNameInstruction: entryNameInstruction,
      entryNameDefault: entryNameDefault,
      createdAtInstruction: createdAtInstruction,
      missingValueRule: missingValueRule,
      invalidValueRule: invalidValueRule,
      fields: fields.toSchema(isDefault: false, isImport: true),
    );
  }

  /// Convert a ```DbImportSpecifications``` object to a ```ImportSpecifications``` object.
  static ImportSpecifications? fromSchema({required DbImportSpecifications? schema}) {
    // If no import specifications were supplied return null.
    if (schema == null) return null;

    return ImportSpecifications(
      entryNameInstruction: schema.entryNameInstruction!,
      entryNameDefault: schema.entryNameDefault!,
      createdAtInstruction: schema.createdAtInstruction!,
      missingValueRule: schema.missingValueRule!,
      invalidValueRule: schema.invalidValueRule!,
      fields: Fields.fromSchema(schema: schema.fields!),
    );
  }

  ImportSpecifications copyWith({
    String? entryNameInstruction,
    String? entryNameDefault,
    String? createdAtInstruction,
    String? missingValueRule,
    String? invalidValueRule,
    Fields? fields,
  }) {
    return ImportSpecifications(
      entryNameInstruction: entryNameInstruction ?? this.entryNameInstruction,
      entryNameDefault: entryNameDefault ?? this.entryNameDefault,
      createdAtInstruction: createdAtInstruction ?? this.createdAtInstruction,
      missingValueRule: missingValueRule ?? this.missingValueRule,
      invalidValueRule: invalidValueRule ?? this.invalidValueRule,
      fields: fields ?? this.fields,
    );
  }
}
