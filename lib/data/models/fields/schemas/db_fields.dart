import 'package:isar/isar.dart';

// Schemas.
import '/data/models/fields/schemas/db_field.dart';

part 'db_fields.g.dart';

@embedded
class DbFields {
  List<DbField>? items;

  DbFields({
    this.items,
  });
}
