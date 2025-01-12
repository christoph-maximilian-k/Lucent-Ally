import 'package:isar/isar.dart';

part 'db_date_of_birth_data.g.dart';

@embedded
class DbDateOfBirthData {
  int? value;
  String? importReference;
  List<byte>? encryptedValue;

  DbDateOfBirthData({
    this.value,
    this.importReference,
    this.encryptedValue,
  });
}
