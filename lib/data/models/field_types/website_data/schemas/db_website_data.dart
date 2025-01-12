import 'package:isar/isar.dart';

part 'db_website_data.g.dart';

@embedded
class DbWebsiteData {
  String? value;
  String? importReference;
  List<byte>? encryptedValue;

  DbWebsiteData({
    this.value,
    this.importReference,
    this.encryptedValue,
  });
}
