import 'package:isar/isar.dart';

part 'db_number_data.g.dart';

@embedded
class DbNumberData {
  double? value;
  double? quickActionValue;
  String? importReference;
  List<byte>? encryptedValue;

  DbNumberData({
    this.value,
    this.quickActionValue,
    this.importReference,
    this.encryptedValue,
  });
}
