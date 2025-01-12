import 'package:isar/isar.dart';

part 'db_tags_data.g.dart';

@embedded
class DbTagsData {
  List<String>? tagReferences;
  String? importReference;

  DbTagsData({
    this.tagReferences,
    this.importReference,
  });
}
