import 'package:isar/isar.dart';

// Schemas.
// Deep nested Schemas need to be accessed in top level even if they are accessed in lower level.
import '/data/models/field_identifications/schemas/db_field_identification.dart';
import '/data/models/field_identifications/schemas/db_field_identifications.dart';
import '/data/models/fields/schemas/db_field.dart';
import '/data/models/fields/schemas/db_fields.dart';
import '/data/models/import_specifications/schemas/db_import_specifications.dart';
import '/data/models/field_types/date_data/schemas/db_date_data.dart';
import '/data/models/field_types/date_and_time_data/schemas/db_date_and_time_data.dart';
import '/data/models/field_types/time_data/schemas/db_time_data.dart';
import '/data/models/field_types/date_of_birth_data/schemas/db_date_of_birth_data.dart';
import '/data/models/field_types/number_data/schemas/db_number_data.dart';
import '/data/models/field_types/money_data/schemas/db_money_data.dart';
import '/data/models/field_types/password_data/schemas/db_password_data.dart';
import '/data/models/field_types/phone_data/schemas/db_phone_data.dart';
import '/data/models/field_types/text_data/schemas/db_text_data.dart';
import '/data/models/field_types/email_data/schemas/db_email_data.dart';
import '/data/models/field_types/website_data/schemas/db_website_data.dart';
import '/data/models/field_types/username_data/schemas/db_username_data.dart';
import '/data/models/field_types/location_data/schemas/db_location_data.dart';
import '/data/models/field_types/image_data/schemas/db_image_data.dart';
import '/data/models/field_types/file_data/schemas/db_file_data.dart';
import '/data/models/field_types/payment_data/schemas/db_payment_data.dart';
import '/data/models/field_types/payment_data/schemas/db_share_reference.dart';
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';
import '/data/models/field_types/measurement_data/schemas/db_measurement_data.dart';
import '/data/models/field_types/emotion_data/schemas/db_emotion_data.dart';
import '/data/models/field_types/emotion_data/schemas/db_emotion_item.dart';
import '/data/models/field_types/avatar_image_data/schemas/db_avatar_image_data.dart';
import '/data/models/field_types/boolean_data/schemas/db_boolean_data.dart';
import '/data/models/files/schemas/db_file_item.dart';
import '/data/models/references/member_to_import_reference/schemas/db_member_to_import_reference.dart';

part 'db_model_entry.g.dart';

@collection
class DbModelEntry {
  @Index()
  final String modelEntryId;

  /// This is the recommended way of using string ids.
  Id get isarId => fastHash(modelEntryId);

  final bool entryCreatedAtIsEditable;

  final int createdAtInUtc;
  final int editedAtInUtc;

  final String modelEntryCreator;

  @Index(caseSensitive: false)
  final String modelEntryName;

  final DbFieldIdentifications fieldIdentifications;

  final DbImportSpecifications? importSpecifications;

  const DbModelEntry({
    required this.modelEntryId,
    required this.entryCreatedAtIsEditable,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.modelEntryCreator,
    required this.modelEntryName,
    required this.fieldIdentifications,
    required this.importSpecifications,
  });

  /// The name of this collection: ```model_entries```.
  static const String collectionName = 'model_entries';

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
