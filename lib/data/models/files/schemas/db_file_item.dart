import 'package:isar/isar.dart';

part 'db_file_item.g.dart';

@embedded
class DbFileItem {
  String? id;
  String? relativePath;
  int? createdAtInUtc;
  int? lastModifiedInUtc;
  String? hash;
  String? type;
  int? sizeInBytes;
  int? mediaWidth;
  int? mediaHeight;
  double? duration;
  String? title;
  String? caption;

  DbFileItem({
    this.id,
    this.relativePath,
    this.createdAtInUtc,
    this.lastModifiedInUtc,
    this.hash,
    this.type,
    this.sizeInBytes,
    this.mediaWidth,
    this.mediaHeight,
    this.duration,
    this.title,
    this.caption,
  });
}
