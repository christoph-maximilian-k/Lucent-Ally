import 'package:isar/isar.dart';

part 'db_group.g.dart';

@collection
class DbGroup {
  @Index(unique: true)
  final String groupId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(groupId);

  @Index()
  final String groupType;

  @Index()
  final bool isProtected;

  @Index()
  final bool isEncrypted;

  final int createdAtInUtc;
  final int editedAtInUtc;

  @Index(caseSensitive: false)
  final String groupName;

  final String groupDescription;

  final String groupCreator;

  final bool isLocked;

  final List<String> commonModelEntries;
  final bool isRestrictedToCommon;

  @Index()
  final String rootGroupReference;

  @Index()
  final String parentGroupReference;

  @Index()
  final String participantReference;
  final String defaultCurrencyCode;

  const DbGroup({
    required this.groupId,
    required this.groupType,
    required this.isProtected,
    required this.isEncrypted,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.groupName,
    required this.groupDescription,
    required this.groupCreator,
    required this.isLocked,
    required this.commonModelEntries,
    required this.isRestrictedToCommon,
    required this.rootGroupReference,
    required this.parentGroupReference,
    required this.participantReference,
    required this.defaultCurrencyCode,
  });

  /// The name of this collection: ```groups```
  static const String collectionName = 'groups';

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
