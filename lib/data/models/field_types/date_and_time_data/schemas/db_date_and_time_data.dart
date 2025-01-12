import 'package:isar/isar.dart';

part 'db_date_and_time_data.g.dart';

@embedded
class DbDateAndTimeData {
  int? valueInUtc;
  String? valueDefaultDate;
  String? valueDefaultTime;
  String? timezone;
  String? importReference;
  List<byte>? encryptedValue;

  DbDateAndTimeData({
    this.valueInUtc,
    this.valueDefaultDate,
    this.valueDefaultTime,
    this.timezone,
    this.importReference,
    this.encryptedValue,
  });
}
