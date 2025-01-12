import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Schemas.
import '/data/models/tags/schemas/db_tag.dart';

class Tag extends Equatable {
  final String tagId;
  final DateTime createdAtInUtc;
  final String creator;
  final String label;
  final String description;

  const Tag({
    required this.tagId,
    required this.createdAtInUtc,
    required this.creator,
    required this.label,
    required this.description,
  });

  @override
  List<Object> get props => [tagId, createdAtInUtc, creator, label, description];

  /// Initialize a new ```Tag``` object.
  factory Tag.initial() {
    return Tag(
      tagId: const Uuid().v4(),
      createdAtInUtc: DateTime.now().toUtc(),
      creator: '',
      label: '',
      description: '',
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```Tag``` object to a ```DbTag``` object.
  DbTag toSchema() {
    return DbTag(
      tagId: tagId,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      creator: creator,
      label: label,
      description: description,
    );
  }

  /// Convert a ```DbTag``` object to a ```Tag``` object.
  static Tag fromSchema({required DbTag schema}) {
    return Tag(
      tagId: schema.tagId,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      creator: schema.creator,
      label: schema.label,
      description: schema.description,
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode a ```Tag``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'label': label,
      'description': description,
    };
  }

  /// Decode a ```Tag``` object from JSON.
  static Tag fromCloudObject(tag) {
    return Tag(
      tagId: tag["_id"],
      createdAtInUtc: DateTime.parse(tag["created_at_in_utc"]),
      creator: tag["creator"],
      label: tag["label"],
      description: tag["description"],
    );
  }

  // #####################################
  // Copy With
  // #####################################

  Tag copyWith({
    String? tagId,
    DateTime? createdAtInUtc,
    String? creator,
    String? label,
    String? description,
  }) {
    return Tag(
      tagId: tagId ?? this.tagId,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      creator: creator ?? this.creator,
      label: label ?? this.label,
      description: description ?? this.description,
    );
  }
}
