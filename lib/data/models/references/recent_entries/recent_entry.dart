import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/references/recent_entries/schemas/db_recent_entry.dart';

class RecentEntry extends Equatable {
  final String entryId;

  final String rootGroupReference;
  final String groupReference;

  final DateTime interactedAtInUtc;

  const RecentEntry({
    required this.entryId,
    required this.rootGroupReference,
    required this.groupReference,
    required this.interactedAtInUtc,
  });

  @override
  List<Object> get props => [entryId, rootGroupReference, groupReference, interactedAtInUtc];

  /// Initialize a new ```RecentEntry``` object.
  factory RecentEntry.initial() {
    return RecentEntry(
      entryId: '',
      rootGroupReference: '',
      groupReference: '',
      interactedAtInUtc: DateTime.now().toUtc(),
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```RecentEntry``` object to a ```DbRecentEntry``` object.
  DbRecentEntry toSchema() {
    return DbRecentEntry(
      entryId: entryId,
      rootGroupReference: rootGroupReference,
      groupReference: groupReference,
      interactedAtInUtc: interactedAtInUtc.millisecondsSinceEpoch,
    );
  }

  /// Convert a ```DbRecentEntry``` object to a ```RecentEntry``` object.
  static RecentEntry fromSchema({required DbRecentEntry schema}) {
    return RecentEntry(
      entryId: schema.entryId,
      rootGroupReference: schema.rootGroupReference,
      groupReference: schema.groupReference,
      interactedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.interactedAtInUtc, isUtc: true),
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Decode an ```RecentEntry``` object from JSON provided by cloud service.
  static RecentEntry fromCloudObject(recentEntry) {
    return RecentEntry(
      entryId: recentEntry["entry_id"],
      rootGroupReference: recentEntry["root_group_reference"],
      groupReference: recentEntry["group_reference"],
      interactedAtInUtc: DateTime.parse(recentEntry["interacted_at_in_utc"]),
    );
  }

  // #####################################
  // Copy With
  // #####################################

  RecentEntry copyWith({
    String? entryId,
    String? rootGroupReference,
    String? groupReference,
    DateTime? interactedAtInUtc,
  }) {
    return RecentEntry(
      entryId: entryId ?? this.entryId,
      rootGroupReference: rootGroupReference ?? this.rootGroupReference,
      groupReference: groupReference ?? this.groupReference,
      interactedAtInUtc: interactedAtInUtc ?? this.interactedAtInUtc,
    );
  }
}
