import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/model_entry_prefs/schemas/db_model_entry_prefs.dart';

// Models.
import '/data/models/model_entry_prefs/default_fields.dart';

class ModelEntryPrefs extends Equatable {
  final String modelEntryId;

  final DateTime createdAtInUtc;
  final DateTime editedAtInUtc;

  final String copyFieldId;
  final String subtitleFieldId;
  final String thirdLineFieldId;

  final DefaultFields defaultSelf;
  final DefaultFields defaultEveryone;

  const ModelEntryPrefs({
    required this.modelEntryId,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.copyFieldId,
    required this.subtitleFieldId,
    required this.thirdLineFieldId,
    required this.defaultSelf,
    required this.defaultEveryone,
  });

  @override
  List<Object> get props => [
        modelEntryId,
        createdAtInUtc,
        editedAtInUtc,
        copyFieldId,
        subtitleFieldId,
        thirdLineFieldId,
        defaultSelf,
        defaultEveryone,
      ];

  /// Initialize a new ```ModelEntryPrefs``` object.
  factory ModelEntryPrefs.initial() {
    // Init now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    return ModelEntryPrefs(
      modelEntryId: '',
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      copyFieldId: '',
      subtitleFieldId: '',
      thirdLineFieldId: '',
      defaultSelf: DefaultFields.initial(),
      defaultEveryone: DefaultFields.initial(),
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```ModelEntryPrefs``` object to a ```DbModelEntryPrefs``` object.
  DbModelEntryPrefs toSchema() {
    return DbModelEntryPrefs(
      modelEntryId: modelEntryId,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
      copyFieldId: copyFieldId,
      subtitleFieldId: subtitleFieldId,
      thirdLineFieldId: thirdLineFieldId,
      defaultSelf: defaultSelf.toSchema(isDefault: true, isImport: false),
      defaultEveryone: defaultEveryone.toSchema(isDefault: true, isImport: false),
    );
  }

  /// Convert a ```DbModelEntryPrefs``` object to a ```ModelEntryPrefs``` object.
  static ModelEntryPrefs fromSchema({required DbModelEntryPrefs schema}) {
    return ModelEntryPrefs(
      modelEntryId: schema.modelEntryId,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
      copyFieldId: schema.copyFieldId,
      subtitleFieldId: schema.subtitleFieldId,
      thirdLineFieldId: schema.thirdLineFieldId,
      defaultSelf: DefaultFields.fromSchema(schema: schema.defaultSelf),
      defaultEveryone: DefaultFields.fromSchema(schema: schema.defaultEveryone),
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode an ```ModelEntryPrefs``` object to a ```JSON``` suitable for cloud storage.
  Map<String, dynamic> toCloudObject() {
    return {
      'copy_field_id': copyFieldId,
      'subtitle_field_id': subtitleFieldId,
      'thirdline_field_id': thirdLineFieldId,
      'default_self': defaultSelf.toCloudObject(isDefault: true, isImport: false),
      'default_everyone': defaultEveryone.toCloudObject(isDefault: true, isImport: false),
    };
  }

  /// Decode an ```ModelEntryPrefs``` object from JSON provided by cloud service.
  /// * Returns ```ModelEntryPrefs.initial()``` if prefs are ```null```.
  static ModelEntryPrefs fromCloudObject(data) {
    // Check for null value.
    if (data["model_entry_prefs"] == null || data["model_entry_prefs"].isEmpty || data["model_entry_prefs"]["model_entry_id"] == null) {
      return ModelEntryPrefs.initial();
    }

    // Convenience variables.
    final String modelEntryId = data["model_entry_prefs"]["model_entry_id"];

    return ModelEntryPrefs(
      modelEntryId: modelEntryId,
      createdAtInUtc: DateTime.parse(data["model_entry_prefs"]["created_at_in_utc"]),
      editedAtInUtc: DateTime.parse(data["model_entry_prefs"]["edited_at_in_utc"]),
      copyFieldId: data["model_entry_prefs"]["copy_field_id"],
      subtitleFieldId: data["model_entry_prefs"]["subtitle_field_id"],
      thirdLineFieldId: data["model_entry_prefs"]["thirdline_field_id"],
      defaultSelf: DefaultFields.fromCloudObject(
        data: data["model_entry_prefs"]["default_self"],
        modelEntryId: modelEntryId,
      ),
      defaultEveryone: DefaultFields.fromCloudObject(
        data: data["model_entry_prefs"]["default_everyone"],
        modelEntryId: modelEntryId,
      ),
    );
  }

  // #####################################
  // Copy With
  // #####################################

  ModelEntryPrefs copyWith({
    String? modelEntryId,
    DateTime? createdAtInUtc,
    DateTime? editedAtInUtc,
    String? copyFieldId,
    String? subtitleFieldId,
    String? thirdLineFieldId,
    DefaultFields? defaultSelf,
    DefaultFields? defaultEveryone,
  }) {
    return ModelEntryPrefs(
      modelEntryId: modelEntryId ?? this.modelEntryId,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
      copyFieldId: copyFieldId ?? this.copyFieldId,
      subtitleFieldId: subtitleFieldId ?? this.subtitleFieldId,
      thirdLineFieldId: thirdLineFieldId ?? this.thirdLineFieldId,
      defaultSelf: defaultSelf ?? this.defaultSelf,
      defaultEveryone: defaultEveryone ?? this.defaultEveryone,
    );
  }
}
