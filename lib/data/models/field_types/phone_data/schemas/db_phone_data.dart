import 'package:isar/isar.dart';

part 'db_phone_data.g.dart';

@embedded
class DbPhoneData {
  String? value;
  String? internationalPrefix;
  String? importReference;
  String? importReferenceInternationalPrefix;

  List<byte>? encryptedValue;
  List<byte>? encryptedInternationalPrefix;

  DbPhoneData({
    this.value,
    this.internationalPrefix,
    this.importReference,
    this.importReferenceInternationalPrefix,
    this.encryptedValue,
    this.encryptedInternationalPrefix,
  });
}
