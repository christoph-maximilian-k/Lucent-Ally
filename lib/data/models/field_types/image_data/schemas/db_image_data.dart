import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';
import '/data/models/files/schemas/db_file_item.dart';

part 'db_image_data.g.dart';

@embedded
class DbImageData {
  List<DbFileItem>? images;
  DbTagsData? tagsData;

  DbImageData({
    this.images,
    this.tagsData,
  });
}
