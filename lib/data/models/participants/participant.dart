import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Schemas.
import '/data/models/participants/schemas/db_participant.dart';

class Participant extends Equatable {
  final String participantId;

  final DateTime createdAtInUtc;
  final DateTime editedAtInUtc;

  final String participantName;

  final String participantCreator;

  const Participant({
    required this.participantId,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.participantName,
    required this.participantCreator,
  });

  // #####################################
  // Reference type
  // #####################################

  /// Reference identification: participant.
  /// ```dart
  /// static const String referenceType = 'participant';
  /// ```
  static const String referenceType = 'participant';

  @override
  List<Object> get props => [
        participantId,
        createdAtInUtc,
        editedAtInUtc,
        participantName,
        participantCreator,
      ];

  /// Initialize a new ```Participant``` object.
  factory Participant.initial() {
    // Init now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    return Participant(
      participantId: const Uuid().v4(),
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      participantName: '',
      participantCreator: '',
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```Participant``` object to a ```DbParticipant``` object.
  DbParticipant toSchema() {
    return DbParticipant(
      participantId: participantId,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
      participantName: participantName,
      participantCreator: participantCreator,
    );
  }

  /// Convert a ```DbParticipant``` object to a ```Participant``` object.
  static Participant fromSchema({required DbParticipant schema}) {
    return Participant(
      participantId: schema.participantId,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
      participantName: schema.participantName,
      participantCreator: schema.participantCreator,
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode a ```Participant``` object to JSON suitable for cloud storage.
  Map<String, dynamic> toCloudObject() {
    return {
      'participant_name': participantName,
      'participant_creator': participantCreator,
    };
  }

  /// Decode a ```Participant``` object from JSON returned by API.
  static Participant fromCloudObject(data) {
    return Participant(
      participantId: data["_id"],
      createdAtInUtc: DateTime.parse(data["created_at_in_utc"]),
      editedAtInUtc: DateTime.parse(data["edited_at_in_utc"]),
      participantCreator: data["creator"],
      participantName: data["participant_name"],
    );
  }

  // #####################################
  // Copy With
  // #####################################

  Participant copyWith({
    String? participantId,
    DateTime? createdAtInUtc,
    DateTime? editedAtInUtc,
    String? participantName,
    String? participantCreator,
  }) {
    return Participant(
      participantId: participantId ?? this.participantId,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
      participantName: participantName ?? this.participantName,
      participantCreator: participantCreator ?? this.participantCreator,
    );
  }
}
