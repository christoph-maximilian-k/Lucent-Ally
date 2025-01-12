import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/references/participant_to_member/schemas/db_participant_to_member.dart';

// Models.
import '/data/models/compound_keys/compound_key_participant_to_member.dart';

class ParticipantToMember extends Equatable {
  final CompoundKeyParticipantToMember participantToMemberId;

  final DateTime addedAtInUtc;
  final String addedBy;

  const ParticipantToMember({
    required this.participantToMemberId,
    required this.addedAtInUtc,
    required this.addedBy,
  });

  @override
  List<Object> get props => [participantToMemberId, addedAtInUtc, addedBy];

  /// Initialize a new ```ParticipantToMember``` object.
  factory ParticipantToMember.initial() {
    return ParticipantToMember(
      participantToMemberId: CompoundKeyParticipantToMember.initial(),
      addedAtInUtc: DateTime.now().toUtc(),
      addedBy: '',
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```ParticipantToMember``` object to a ```DbParticipantToMember``` object.
  DbParticipantToMember toSchema() {
    return DbParticipantToMember(
      participantToMemberId: participantToMemberId.toSchema(),
      participantId: participantToMemberId.participantId,
      memberId: participantToMemberId.memberId,
      addedAtInUtc: addedAtInUtc.millisecondsSinceEpoch,
      addedBy: addedBy,
    );
  }

  /// Convert a ```DbParticipantToMember``` object to a ```ParticipantToMember``` object.
  static ParticipantToMember fromSchema({required DbParticipantToMember schema}) {
    return ParticipantToMember(
      participantToMemberId: CompoundKeyParticipantToMember.fromSchema(schema: schema.participantToMemberId),
      addedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.addedAtInUtc, isUtc: true),
      addedBy: schema.addedBy,
    );
  }

  // #####################################
  // CopyWith
  // #####################################

  ParticipantToMember copyWith({
    CompoundKeyParticipantToMember? participantToMemberId,
    DateTime? addedAtInUtc,
    String? addedBy,
  }) {
    return ParticipantToMember(
      participantToMemberId: participantToMemberId ?? this.participantToMemberId,
      addedAtInUtc: addedAtInUtc ?? this.addedAtInUtc,
      addedBy: addedBy ?? this.addedBy,
    );
  }
}
