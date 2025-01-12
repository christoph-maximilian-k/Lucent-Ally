import 'package:isar/isar.dart';

part 'db_share_reference.g.dart';

@embedded
class DbShareReference {
  String? shareReferenceId;
  double? value;

  DbShareReference({
    this.shareReferenceId,
    this.value,
  });
}
