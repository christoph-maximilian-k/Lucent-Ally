import 'package:isar/isar.dart';

// Schemas.

part 'db_group_prefs.g.dart';

@collection
class DbGroupPrefs {
  @Index()
  final String groupId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(groupId);

  final int createdAtInUtc;
  final int editedAtInUtc;

  final String quickAddReference;
  final String subgroupsSortedBy;
  final String subgroupsDisplayFormat;
  final String entriesSortedBy;

  const DbGroupPrefs({
    required this.groupId,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.quickAddReference,
    required this.subgroupsSortedBy,
    required this.subgroupsDisplayFormat,
    required this.entriesSortedBy,
  });

  /// The name of this collection: ```group_prefs```
  static const String collectionName = 'group_prefs';

  /// FNV-1a 64bit hash algorithm optimized for Dart Strings
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
