import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/group_prefs/schemas/db_group_prefs.dart';

class GroupPrefs extends Equatable {
  final String groupId;

  final DateTime createdAtInUtc;
  final DateTime editedAtInUtc;

  final String quickAddReference;

  final String subgroupsSortedBy;
  final String subgroupsDisplayFormat;
  final String entriesSortedBy;

  const GroupPrefs({
    required this.groupId,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.quickAddReference,
    required this.subgroupsSortedBy,
    required this.subgroupsDisplayFormat,
    required this.entriesSortedBy,
  });

  @override
  List<Object> get props => [
        groupId,
        createdAtInUtc,
        editedAtInUtc,
        quickAddReference,
        subgroupsSortedBy,
        subgroupsDisplayFormat,
        entriesSortedBy,
      ];

  /// Initialize a new ```GroupPrefs``` object.
  factory GroupPrefs.initial() {
    // Init now.
    final DateTime now = DateTime.now().toUtc();

    return GroupPrefs(
      groupId: '',
      createdAtInUtc: now,
      editedAtInUtc: now,
      quickAddReference: '',
      subgroupsSortedBy: '',
      subgroupsDisplayFormat: '',
      entriesSortedBy: '',
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```GroupPrefs``` object to a ```DbGroupPrefs``` object.
  DbGroupPrefs toSchema() {
    return DbGroupPrefs(
      groupId: groupId,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
      quickAddReference: quickAddReference,
      subgroupsSortedBy: subgroupsSortedBy,
      subgroupsDisplayFormat: subgroupsDisplayFormat,
      entriesSortedBy: entriesSortedBy,
    );
  }

  /// Convert a ```DbGroupPrefs``` object to a ```GroupPrefs``` object.
  static GroupPrefs fromSchema({required DbGroupPrefs schema}) {
    return GroupPrefs(
      groupId: schema.groupId,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
      quickAddReference: schema.quickAddReference,
      subgroupsSortedBy: schema.subgroupsSortedBy,
      subgroupsDisplayFormat: schema.subgroupsDisplayFormat,
      entriesSortedBy: schema.entriesSortedBy,
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode an ```GroupPrefs``` object to a ```JSON``` suitable for cloud storage.
  Map<String, dynamic> toCloudObject() {
    return {
      'quick_add_reference': quickAddReference,
      'subgroups_sorted_by': subgroupsSortedBy,
      'subgroups_display_format': subgroupsDisplayFormat,
      'entries_sorted_by': entriesSortedBy,
    };
  }

  /// Decode an ```GroupPrefs``` object from JSON provided by cloud service.
  /// * Returns ```GroupPrefs.initial()``` if prefs are ```null```.
  static GroupPrefs fromCloudObject(data) {
    // Check for null value.
    if (data["group_prefs"] == null) return GroupPrefs.initial();

    return GroupPrefs(
      groupId: data["group_prefs"]["group_id"],
      createdAtInUtc: DateTime.parse(data["group_prefs"]["created_at_in_utc"]),
      editedAtInUtc: DateTime.parse(data["group_prefs"]["edited_at_in_utc"]),
      quickAddReference: data["group_prefs"]["quick_add_reference"],
      subgroupsSortedBy: data["group_prefs"]["subgroups_sorted_by"],
      subgroupsDisplayFormat: data["group_prefs"]["subgroups_display_format"],
      entriesSortedBy: data["group_prefs"]["entries_sorted_by"],
    );
  }

  // #####################################
  // Copy With
  // #####################################

  GroupPrefs copyWith({
    String? groupId,
    DateTime? createdAtInUtc,
    DateTime? editedAtInUtc,
    String? quickAddReference,
    String? subgroupsSortedBy,
    String? subgroupsDisplayFormat,
    String? entriesSortedBy,
  }) {
    return GroupPrefs(
      groupId: groupId ?? this.groupId,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
      quickAddReference: quickAddReference ?? this.quickAddReference,
      subgroupsSortedBy: subgroupsSortedBy ?? this.subgroupsSortedBy,
      subgroupsDisplayFormat: subgroupsDisplayFormat ?? this.subgroupsDisplayFormat,
      entriesSortedBy: entriesSortedBy ?? this.entriesSortedBy,
    );
  }
}
