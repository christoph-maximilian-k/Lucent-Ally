import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';
import '/data/models/files/schemas/db_file_item.dart';

part 'db_file_data.g.dart';

@embedded
class DbFileData {
  List<DbFileItem>? value;
  DbTagsData? tagsData;

  DbFileData({
    this.value,
    this.tagsData,
  });
}
