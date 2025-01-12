import 'package:isar/isar.dart';

part 'db_password_generator.g.dart';

@embedded
class DbPasswordGenerator {
  bool? usesLowerCase;
  bool? usesUpperCase;
  bool? usesSymbols;
  bool? usesNumbers;
  bool? usesUuid;

  int? minPasswordLength;
  int? maxPasswordLength;
  int? passwordLength;

  DbPasswordGenerator({
    this.usesLowerCase,
    this.usesUpperCase,
    this.usesSymbols,
    this.usesNumbers,
    this.usesUuid,
    this.minPasswordLength,
    this.maxPasswordLength,
    this.passwordLength,
  });
}
