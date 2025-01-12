import 'package:isar/isar.dart';

part 'db_boolean_data.g.dart';

@embedded
class DbBooleanData {
  bool? value;
  String? importReference;

  List<byte>? encryptedValue;

  DbBooleanData({
    this.value,
    this.importReference,
    this.encryptedValue,
  });
}
