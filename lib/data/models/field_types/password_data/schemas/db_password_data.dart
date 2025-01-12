import 'package:isar/isar.dart';

part 'db_password_data.g.dart';

@embedded
class DbPasswordData {
  String? value;
  String? importReference;
  List<byte>? encryptedValue;

  DbPasswordData({
    this.value,
    this.importReference,
    this.encryptedValue,
  });
}
