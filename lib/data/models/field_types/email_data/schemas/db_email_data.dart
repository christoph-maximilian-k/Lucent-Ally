import 'package:isar/isar.dart';

part 'db_email_data.g.dart';

@embedded
class DbEmailData {
  String? value;
  String? provider;
  String? importReference;
  List<byte>? encryptedValue;

  DbEmailData({
    this.value,
    this.provider,
    this.importReference,
    this.encryptedValue,
  });
}
