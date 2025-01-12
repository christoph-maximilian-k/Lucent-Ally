import 'package:isar/isar.dart';

part 'db_participant_to_member.g.dart';

@collection
class DbParticipantToMember {
  final String participantToMemberId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(participantToMemberId);

  @Index()
  final String participantId;

  @Index()
  final String memberId;

  final int addedAtInUtc;

  @Index()
  final String addedBy;

  const DbParticipantToMember({
    required this.participantToMemberId,
    required this.participantId,
    required this.memberId,
    required this.addedAtInUtc,
    required this.addedBy,
  });

  /// The name of this collection: ```participant_to_members```.
  static const String collectionName = 'participant_to_members';

  /// FNV-1a 64bit hash algorithm optimized for Dart Strings.
  static int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
