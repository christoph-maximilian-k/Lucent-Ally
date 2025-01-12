import 'package:isar/isar.dart';

part 'db_settings.g.dart';

@embedded
class DbSettings {
  int? notificationDurationInSeconds;
  int? maxLinesForTextFields;

  String? defaultCurrency;

  bool? acceptedTermsAndConditions;

  DbSettings({
    this.notificationDurationInSeconds,
    this.maxLinesForTextFields,
    this.acceptedTermsAndConditions,
    this.defaultCurrency,
  });
}
