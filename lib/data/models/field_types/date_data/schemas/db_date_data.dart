import 'package:isar/isar.dart';

part 'db_date_data.g.dart';

@embedded
class DbDateData {
  int? valueInUtc;
  String? valueDefaultDate;
  String? timezone;
  String? importReference;
  List<byte>? encryptedValue;

  DbDateData({
    this.valueInUtc,
    this.valueDefaultDate,
    this.timezone,
    this.importReference,
    this.encryptedValue,
  });
}
