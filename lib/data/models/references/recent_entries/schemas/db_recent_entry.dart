import 'package:isar/isar.dart';

part 'db_recent_entry.g.dart';

@collection
class DbRecentEntry {
  final String entryId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(entryId);

  @Index()
  final String rootGroupReference;

  @Index()
  final String groupReference;

  @Index()
  final int interactedAtInUtc;

  const DbRecentEntry({
    required this.entryId,
    required this.rootGroupReference,
    required this.groupReference,
    required this.interactedAtInUtc,
  });

  /// The name of this collection: ```recent_entries```.
  static const String collectionName = 'recent_entries';

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
