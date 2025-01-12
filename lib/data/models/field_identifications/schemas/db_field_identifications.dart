import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_identifications/schemas/db_field_identification.dart';

part 'db_field_identifications.g.dart';

@embedded
class DbFieldIdentifications {
  List<DbFieldIdentification>? items;

  DbFieldIdentifications({
    this.items,
  });
}
