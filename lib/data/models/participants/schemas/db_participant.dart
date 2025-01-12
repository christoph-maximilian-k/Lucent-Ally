import 'package:isar/isar.dart';

part 'db_participant.g.dart';

@collection
class DbParticipant {
  final String participantId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(participantId);

  final int createdAtInUtc;
  final int editedAtInUtc;

  @Index(caseSensitive: false)
  final String participantName;

  @Index()
  final String participantCreator;

  const DbParticipant({
    required this.participantId,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.participantName,
    required this.participantCreator,
  });

  /// The name of this collection: ```participants```.
  static const String collectionName = 'participants';

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
