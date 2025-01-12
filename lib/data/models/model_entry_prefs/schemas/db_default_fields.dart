import 'package:isar/isar.dart';

// Schemas.
import '/data/models/fields/schemas/db_fields.dart';

part 'db_default_fields.g.dart';

@embedded
class DbDefaultFields {
  String? defaultEntryName;
  DbFields? fields;

  DbDefaultFields({
    this.defaultEntryName,
    this.fields,
  });
}
