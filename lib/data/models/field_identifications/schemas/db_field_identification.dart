import 'package:isar/isar.dart';

part 'db_field_identification.g.dart';

@embedded
class DbFieldIdentification {
  String? fieldId;
  String? fieldType;

  String? modelEntryId;

  String? label;
  bool? required;
  bool? isOneLine;

  DbFieldIdentification({
    this.fieldId,
    this.fieldType,
    this.modelEntryId,
    this.label,
    this.required,
    this.isOneLine,
  });
}
