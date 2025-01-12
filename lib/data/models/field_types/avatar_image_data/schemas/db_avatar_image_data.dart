import 'package:isar/isar.dart';

// Schemas.
import '/data/models/files/schemas/db_file_item.dart';

part 'db_avatar_image_data.g.dart';

@embedded
class DbAvatarImageData {
  DbFileItem? image;

  DbAvatarImageData({
    this.image,
  });
}
