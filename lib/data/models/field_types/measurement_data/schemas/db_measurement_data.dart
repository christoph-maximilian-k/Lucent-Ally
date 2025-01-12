import 'package:isar/isar.dart';

part 'db_measurement_data.g.dart';

@embedded
class DbMeasurementData {
  String? category;
  String? unit;
  double? value;

  int? createdAtInUtc;
  String? createdAtTimezone;

  String? createdAtDefaultDate;
  String? createdAtDefaultTime;

  String? importReferenceCategory;
  String? importReferenceUnit;
  String? importReferenceValue;
  String? importReferenceDate;

  List<byte>? encryptedCategory;
  List<byte>? encryptedUnit;
  List<byte>? encryptedValue;

  DbMeasurementData({
    this.category,
    this.unit,
    this.value,
    this.createdAtInUtc,
    this.createdAtTimezone,
    this.createdAtDefaultDate,
    this.createdAtDefaultTime,
    this.importReferenceCategory,
    this.importReferenceUnit,
    this.importReferenceValue,
    this.importReferenceDate,
    this.encryptedCategory,
    this.encryptedUnit,
    this.encryptedValue,
  });
}
