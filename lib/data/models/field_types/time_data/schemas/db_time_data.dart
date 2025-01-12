import 'package:isar/isar.dart';

part 'db_time_data.g.dart';

@embedded
class DbTimeData {
  int? hour;
  int? minute;
  String? importReference;
  List<byte>? encryptedValue;

  DbTimeData({
    this.hour,
    this.minute,
    this.importReference,
    this.encryptedValue,
  });
}
