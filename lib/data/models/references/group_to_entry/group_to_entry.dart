import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/references/group_to_entry/schemas/db_group_to_entry.dart';

// Models.
import '/data/models/compound_keys/compound_key_group_to_entry.dart';

class GroupToEntry extends Equatable {
  final CompoundKeyGroupToEntry groupToEntryId;

  final String modelEntryReference;

  /// This variable holds the moment when this GroupToEntry object got created.
  /// * It might be that this is before `entryCreatedAt` because user can edit the `createdAt` variable in the `Entry` object and thus also the `entryCreatedAt` will be edited.
  final DateTime createdAtInUtc;

  /// This variable holds the moment of entry creation.
  /// * This variable will be updated if user edits the `createdAt` variable in the `Entry` object.
  final DateTime entryCreatedAtInUtc;

  final String addedBy;

  const GroupToEntry({
    required this.groupToEntryId,
    required this.modelEntryReference,
    required this.createdAtInUtc,
    required this.entryCreatedAtInUtc,
    required this.addedBy,
  });

  @override
  List<Object> get props => [groupToEntryId, modelEntryReference, createdAtInUtc, entryCreatedAtInUtc, addedBy];

  /// Initialize a new ```GroupToEntry``` object.
  factory GroupToEntry.initial() {
    // Init now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    return GroupToEntry(
      groupToEntryId: CompoundKeyGroupToEntry.initial(),
      modelEntryReference: '',
      createdAtInUtc: nowInUtc,
      entryCreatedAtInUtc: nowInUtc,
      addedBy: '',
    );
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```GroupToEntry``` object to a ```DbGroupToEntry``` object.
  DbGroupToEntry toSchema() {
    return DbGroupToEntry(
      groupToEntryId: groupToEntryId.toSchema(),
      modelEntryReference: modelEntryReference,
      groupId: groupToEntryId.groupId,
      entryId: groupToEntryId.entryId,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      entryCreatedAtInUtc: entryCreatedAtInUtc.millisecondsSinceEpoch,
      addedBy: addedBy,
    );
  }

  /// Convert a ```DbGroupToEntry``` object to a ```GroupToEntry``` object.
  static GroupToEntry fromSchema({required DbGroupToEntry schema}) {
    return GroupToEntry(
      groupToEntryId: CompoundKeyGroupToEntry.fromSchema(schema: schema.groupToEntryId),
      modelEntryReference: schema.modelEntryReference,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      entryCreatedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.entryCreatedAtInUtc, isUtc: true),
      addedBy: schema.addedBy,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  GroupToEntry copyWith({
    CompoundKeyGroupToEntry? groupToEntryId,
    String? modelEntryReference,
    DateTime? createdAtInUtc,
    DateTime? entryCreatedAtInUtc,
    String? addedBy,
  }) {
    return GroupToEntry(
      groupToEntryId: groupToEntryId ?? this.groupToEntryId,
      modelEntryReference: modelEntryReference ?? this.modelEntryReference,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      entryCreatedAtInUtc: entryCreatedAtInUtc ?? this.entryCreatedAtInUtc,
      addedBy: addedBy ?? this.addedBy,
    );
  }
}
