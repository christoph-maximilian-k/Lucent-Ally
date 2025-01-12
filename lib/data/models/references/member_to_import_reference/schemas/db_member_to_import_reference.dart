import 'package:isar/isar.dart';

part 'db_member_to_import_reference.g.dart';

@embedded
class DbMemberToImportReference {
  String? id;
  String? memberId;
  String? importReference;

  DbMemberToImportReference({
    this.id,
    this.memberId,
    this.importReference,
  });
}
