import 'package:equatable/equatable.dart';

class CompoundKeyParticipantToMember extends Equatable {
  final String participantId;
  final String memberId;

  const CompoundKeyParticipantToMember({
    required this.participantId,
    required this.memberId,
  });

  @override
  List<Object> get props => [participantId, memberId];

  /// Initialize a new ```CompoundKeyParticipantToMember``` object.
  factory CompoundKeyParticipantToMember.initial() {
    return const CompoundKeyParticipantToMember(
      participantId: '',
      memberId: '',
    );
  }

  /// This getter can be used to access the compound key.
  /// ```dart
  /// return '$participantId/$memberId';
  /// ```
  String get getCompoundKey => '$participantId/$memberId';

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```CompoundKeyParticipantToMember``` object to a ```DbCompoundKeyParticipantToMember``` object.
  /// ```dart
  /// return getCompoundKey;
  /// ```
  String toSchema() {
    return getCompoundKey;
  }

  /// Convert a ```DbCompoundKeyParticipantToMember``` object to a ```CompoundKeyParticipantToMember``` object.
  static CompoundKeyParticipantToMember fromSchema({required String schema}) {
    // Get list.
    final List<String> helper = schema.split('/');

    return CompoundKeyParticipantToMember(
      participantId: helper[0],
      memberId: helper[1],
    );
  }

  // --------------------------------------
  // ------------ CopyWith ----------------
  // --------------------------------------

  CompoundKeyParticipantToMember copyWith({
    String? participantId,
    String? memberId,
  }) {
    return CompoundKeyParticipantToMember(
      participantId: participantId ?? this.participantId,
      memberId: memberId ?? this.memberId,
    );
  }
}
