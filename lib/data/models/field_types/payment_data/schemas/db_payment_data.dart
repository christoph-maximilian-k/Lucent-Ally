import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';
import '/data/models/references/member_to_import_reference/schemas/db_member_to_import_reference.dart';

import 'db_share_reference.dart';

part 'db_payment_data.g.dart';

@embedded
class DbPaymentData {
  String? participantReference;
  double? total;
  String? currencyCode;
  DbTagsData? tagsData;
  String? paidById;
  int? paymentDateInUtc;
  String? paymentDateDefaultDate;
  String? paymentDateDefaultTime;
  String? paymentDateTimezone;
  bool? isCompensated;
  bool? distributeEqually;
  List<DbShareReference>? shareReferences;
  String? customExchangeRates;
  String? importReferenceTotalValue;
  String? importReferenceTotalCurrency;
  String? importReferenceExchangeRate;
  String? importReferencePaidById;
  String? importReferenceIsCompensated;
  bool? importReferenceForceMemberValueImport;
  List<DbMemberToImportReference>? importReferencesMembers;
  String? importReferencePaymentDate;
  String? importReferenceTags;

  List<byte>? encryptedTotal;
  List<byte>? encryptedPaymentDate;
  List<byte>? encryptedCurrency;
  List<byte>? encryptedShareReferences;

  DbPaymentData({
    this.participantReference,
    this.total,
    this.currencyCode,
    this.tagsData,
    this.paidById,
    this.paymentDateInUtc,
    this.paymentDateDefaultDate,
    this.paymentDateDefaultTime,
    this.paymentDateTimezone,
    this.isCompensated,
    this.distributeEqually,
    this.shareReferences,
    this.customExchangeRates,
    this.importReferenceTotalValue,
    this.importReferenceTotalCurrency,
    this.importReferenceExchangeRate,
    this.importReferencePaidById,
    this.importReferenceIsCompensated,
    this.importReferenceForceMemberValueImport,
    this.importReferencesMembers,
    this.importReferencePaymentDate,
    this.importReferenceTags,
    this.encryptedTotal,
    this.encryptedPaymentDate,
    this.encryptedCurrency,
    this.encryptedShareReferences,
  });
}
