import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Schemas.
import '/data/models/field_identifications/schemas/db_field_identification.dart';

class FieldIdentification extends Equatable {
  final String fieldId;
  final String fieldType;

  /// This is the id to the ```ModelEntry``` this ```FieldIdentification``` is part of.
  final String modelEntryId;

  final String label;
  final bool required;

  const FieldIdentification({
    required this.fieldId,
    required this.modelEntryId,
    required this.fieldType,
    required this.label,
    required this.required,
  });

  /// Initialize a new [FieldIdentification] object.
  factory FieldIdentification.initial({required String fieldType, required String entryModelId}) {
    return FieldIdentification(
      fieldId: const Uuid().v4(),
      modelEntryId: entryModelId,
      fieldType: fieldType,
      label: '',
      required: false,
    );
  }

  @override
  List<Object?> get props => [fieldId, modelEntryId, fieldType, label, required];

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```FieldIdentification``` object to a ```DbFieldIdentification``` object.
  DbFieldIdentification toSchema() {
    return DbFieldIdentification(
      fieldId: fieldId,
      fieldType: fieldType,
      modelEntryId: modelEntryId,
      label: label,
      required: required,
    );
  }

  /// Convert a ```DbFieldIdentification``` object to a ```FieldIdentification``` object.
  static FieldIdentification fromSchema({required DbFieldIdentification schema}) {
    return FieldIdentification(
      fieldId: schema.fieldId!,
      modelEntryId: schema.modelEntryId!,
      fieldType: schema.fieldType!,
      label: schema.label!,
      required: schema.required!,
    );
  }

  // --------------------------------------
  // ------------ Cloud -------------------
  // --------------------------------------

  /// Encode a [FieldIdentification] object to JSON.
  /// * do not encode ```entryModelId``` because it gets passed down in ```fromDocument()```
  Map<String, dynamic> toDocument() {
    return {
      'field_id': fieldId,
      'field_type': fieldType,
      'label': label,
      'required': required,
    };
  }

  /// Decode a [FieldIdentification] object from JSON.
  static FieldIdentification fromDocument({required Map<String, dynamic> document, required String entryModelId}) {
    return FieldIdentification(
      fieldId: document['field_id'],
      modelEntryId: entryModelId,
      fieldType: document['field_type'],
      label: document['label'],
      required: document['required'],
    );
  }

  FieldIdentification copyWith({
    String? fieldId,
    String? fieldType,
    String? modelEntryId,
    String? label,
    bool? required,
  }) {
    return FieldIdentification(
      fieldId: fieldId ?? this.fieldId,
      fieldType: fieldType ?? this.fieldType,
      modelEntryId: modelEntryId ?? this.modelEntryId,
      label: label ?? this.label,
      required: required ?? this.required,
    );
  }
}
