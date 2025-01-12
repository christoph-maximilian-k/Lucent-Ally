import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/model_entry_prefs/schemas/db_default_fields.dart';

// Models.
import '/data/models/fields/fields.dart';

class DefaultFields extends Equatable {
  final String defaultEntryName;
  final Fields? fields;

  const DefaultFields({
    required this.defaultEntryName,
    required this.fields,
  });

  @override
  List<Object?> get props => [
        defaultEntryName,
        fields,
      ];

  /// Initialize a new ```DefaultFields``` object.
  factory DefaultFields.initial() {
    return const DefaultFields(
      defaultEntryName: '',
      fields: null,
    );
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```DefaultFields``` object to a ```DbDefaultFields``` object.
  DbDefaultFields toSchema({required bool isDefault, required bool isImport}) {
    return DbDefaultFields(
      defaultEntryName: defaultEntryName,
      fields: fields?.toSchema(isDefault: isDefault, isImport: isImport),
    );
  }

  /// Convert a ```DbDefaultFields``` object to a ```DefaultFields``` object.
  static DefaultFields fromSchema({required DbDefaultFields schema}) {
    return DefaultFields(
      defaultEntryName: schema.defaultEntryName!,
      fields: schema.fields == null ? null : Fields.fromSchema(schema: schema.fields!),
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```ModelEntryPrefs``` object to a ```JSON``` suitable for cloud storage.
  Map<String, dynamic> toCloudObject({required bool isDefault, required bool isImport}) {
    return {
      'default_entry_name': defaultEntryName,
      'default_fields': fields?.toCloudObject(isDefault: isDefault, isImport: isImport),
    };
  }

  /// Decode an ```DefaultFields``` object from JSON provided by cloud service.
  /// * Returns ```DefaultFields.initial()``` if defaults are ```null```.
  static DefaultFields fromCloudObject({required dynamic data, required String modelEntryId}) {
    return DefaultFields(
      defaultEntryName: data["default_entry_name"],
      fields: data["default_fields"] == null
          ? null
          : Fields.fromCloudObject(
              data["default_fields"],
            ),
    );
  }

  // ######################################
  // Copy with
  // ######################################

  DefaultFields copyWith({
    String? defaultEntryName,
    Fields? fields,
  }) {
    return DefaultFields(
      defaultEntryName: defaultEntryName ?? this.defaultEntryName,
      fields: fields ?? this.fields,
    );
  }
}
