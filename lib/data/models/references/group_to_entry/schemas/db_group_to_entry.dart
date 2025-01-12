import 'package:isar/isar.dart';

part 'db_group_to_entry.g.dart';

@collection
class DbGroupToEntry {
  final String groupToEntryId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(groupToEntryId);

  @Index()
  final String modelEntryReference;

  @Index()
  final String groupId;

  @Index()
  final String entryId;

  @Index()
  final int createdAtInUtc;

  @Index()
  final int entryCreatedAtInUtc;

  @Index()
  final String addedBy;

  const DbGroupToEntry({
    required this.groupToEntryId,
    required this.modelEntryReference,
    required this.groupId,
    required this.entryId,
    required this.createdAtInUtc,
    required this.entryCreatedAtInUtc,
    required this.addedBy,
  });

  /// The name of this collection: ```group_to_entries```
  static const String collectionName = 'group_to_entries';

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
