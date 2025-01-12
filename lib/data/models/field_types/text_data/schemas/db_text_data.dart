import 'package:isar/isar.dart';

part 'db_text_data.g.dart';

@embedded
class DbTextData {
  String? value;
  String? importReference;

  List<byte>? encryptedValue;

  DbTextData({
    this.value,
    this.importReference,
    this.encryptedValue,
  });
}
