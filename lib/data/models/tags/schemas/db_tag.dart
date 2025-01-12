import 'package:isar/isar.dart';

part 'db_tag.g.dart';

@collection
class DbTag {
  @Index()
  final String tagId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(tagId);

  final int createdAtInUtc;

  final String creator;

  @Index(unique: true)
  final String label;

  final String description;

  const DbTag({
    required this.tagId,
    required this.createdAtInUtc,
    required this.creator,
    required this.label,
    required this.description,
  });

  /// The name of this collection: ```tags```.
  static const String collectionName = 'tags';

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
