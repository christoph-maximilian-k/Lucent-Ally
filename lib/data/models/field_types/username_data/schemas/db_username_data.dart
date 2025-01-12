import 'package:isar/isar.dart';

part 'db_username_data.g.dart';

@embedded
class DbUsernameData {
  String? value;
  String? service;
  String? importReferenceValue;
  String? importReferenceOptionalValue;
  List<byte>? encryptedValue;
  List<byte>? encryptedService;

  DbUsernameData({
    this.value,
    this.service,
    this.importReferenceValue,
    this.importReferenceOptionalValue,
    this.encryptedValue,
    this.encryptedService,
  });
}
