import 'package:isar/isar.dart';

part 'db_member.g.dart';

@collection
class DbMember {
  final String memberId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(memberId);

  @Index()
  final String memberType;

  final String creator;

  @Index(caseSensitive: false)
  final String memberName;

  final int createdAtInUtc;
  final int editedAtInUtc;

  const DbMember({
    required this.memberId,
    required this.memberType,
    required this.creator,
    required this.memberName,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
  });

  /// The name of this collection: ```members```.
  static const String collectionName = 'members';

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
