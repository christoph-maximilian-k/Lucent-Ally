import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';

part 'db_money_data.g.dart';

@embedded
class DbMoneyData {
  double? value;
  String? currencyCode;
  int? createdAtInUtc;
  String? defaultDate;
  String? defaultTime;
  String? timezone;
  String? customExchangeRates;
  DbTagsData? tagsData;
  String? importReferenceValue;
  String? importReferenceCurrency;
  String? importReferenceExchangeRate;
  String? importReferenceDate;
  String? importReferenceTags;
  List<byte>? encryptedValue;
  List<byte>? encryptedCurrency;

  DbMoneyData({
    this.value,
    this.currencyCode,
    this.createdAtInUtc,
    this.defaultDate,
    this.defaultTime,
    this.timezone,
    this.tagsData,
    this.customExchangeRates,
    this.importReferenceValue,
    this.importReferenceTags,
    this.importReferenceCurrency,
    this.importReferenceExchangeRate,
    this.importReferenceDate,
    this.encryptedValue,
    this.encryptedCurrency,
  });
}
