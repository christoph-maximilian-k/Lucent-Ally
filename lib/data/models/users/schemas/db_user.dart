import 'package:isar/isar.dart';

// Schemas.
import '/data/models/settings/schemas/db_settings.dart';
import '/data/models/password_generator/schemas/db_password_generator.dart';

part 'db_user.g.dart';

@collection
class DbUser {
  @Index()
  final String userId;

  // This is the recommended way of using string ids.
  Id get isarId => fastHash(userId);

  final int editedAtInUtc;
  final int interactedAtInUtc;

  final DbSettings settings;
  final DbPasswordGenerator passwordGenerator;

  const DbUser({
    required this.userId,
    required this.editedAtInUtc,
    required this.interactedAtInUtc,
    required this.settings,
    required this.passwordGenerator,
  });

  /// The name of this collection: ```users```.
  static const String collectionName = 'users';

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
