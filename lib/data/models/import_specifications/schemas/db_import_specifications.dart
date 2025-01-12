import 'package:isar/isar.dart';

// Schemas.
import '/data/models/fields/schemas/db_fields.dart';

part 'db_import_specifications.g.dart';

@embedded
class DbImportSpecifications {
  String? entryNameInstruction;
  String? entryNameDefault;
  String? createdAtInstruction;
  String? missingValueRule;
  String? invalidValueRule;
  DbFields? fields;

  DbImportSpecifications({
    this.entryNameInstruction,
    this.entryNameDefault,
    this.createdAtInstruction,
    this.missingValueRule,
    this.invalidValueRule,
    this.fields,
  });
}
