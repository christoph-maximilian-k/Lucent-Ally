import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// Labels.
import '/main.dart';

// Schemas.
import 'schemas/db_payment_data.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/references/member_to_import_reference/member_to_import_references.dart';
import '/data/models/members/members.dart';
import '/data/models/exchange_rates/exchange_rates.dart';
import 'share_reference.dart';
import 'share_references.dart';

class PaymentData extends Equatable {
  final String participantReference;

  /// This can be null to enable not setting a value for paymentDateInUtc when setting defaults.
  final DateTime? paymentDateInUtc;

  /// This value can be used to save a "dumb" date as a default value.
  final String? paymentDateDefaultDate;

  /// This value can be used to save a "dumb" time as a default value.
  final String? paymentDateDefaultTime;

  /// This can be empty in case of default.
  final String paymentDateTimezone;

  final String paidById;

  final String total;

  final String currencyCode;

  final bool isCompensated;

  final bool distributeEqually;

  final ShareReferences shareReferences;

  final TagsData tagsData;

  final ExchangeRates customExchangeRates;

  // ####################
  // Import references.
  // ####################

  final String? importReferenceTotalValue;
  final String? importReferenceTotalCurrency;
  final String? importReferenceExchangeRate;
  final String? importReferencePaidById;
  final String? importReferenceIsCompensated;
  final bool importReferenceForceMemberValueImport;
  final MemberToImportReferences? importReferencesMembers;
  final String? importReferencePaymentDate;
  final String? importReferenceTags;

  // ####################
  // Encryption.
  // ####################

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedTotal;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedPaymentDate;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedCurrency;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedShareReferences;

  // ####################
  // State data.
  // ####################

  /// These are the members associated with the participant of this payment. They have to be loaded into state whenever this payment is accessed.
  final Members members;

  const PaymentData({
    required this.participantReference,
    required this.total,
    required this.currencyCode,
    required this.tagsData,
    required this.paidById,
    required this.paymentDateInUtc,
    required this.paymentDateDefaultDate,
    required this.paymentDateDefaultTime,
    required this.paymentDateTimezone,
    required this.isCompensated,
    required this.distributeEqually,
    required this.shareReferences,
    required this.customExchangeRates,
    // Import references.
    required this.importReferenceTotalValue,
    required this.importReferenceTotalCurrency,
    required this.importReferenceExchangeRate,
    required this.importReferencePaidById,
    required this.importReferenceIsCompensated,
    required this.importReferenceForceMemberValueImport,
    required this.importReferencesMembers,
    required this.importReferencePaymentDate,
    required this.importReferenceTags,
    // Encryption.
    required this.encryptedTotal,
    required this.encryptedPaymentDate,
    required this.encryptedCurrency,
    required this.encryptedShareReferences,
    // State data.
    required this.members,
  });

  @override
  List<Object?> get props => [
        participantReference,
        total,
        currencyCode,
        tagsData,
        paidById,
        paymentDateInUtc,
        paymentDateDefaultDate,
        paymentDateDefaultTime,
        paymentDateTimezone,
        isCompensated,
        distributeEqually,
        importReferenceExchangeRate,
        customExchangeRates,
        shareReferences,
        importReferenceTotalValue,
        importReferenceTotalCurrency,
        importReferencePaidById,
        importReferenceIsCompensated,
        importReferenceForceMemberValueImport,
        importReferencesMembers,
        importReferencePaymentDate,
        importReferenceTags,
        encryptedTotal,
        encryptedPaymentDate,
        encryptedCurrency,
        encryptedShareReferences,
        members,
      ];

  /// Initialize a new ```PaymentData``` object.
  factory PaymentData.initial() {
    return PaymentData(
      participantReference: '',
      total: '',
      currencyCode: '',
      tagsData: TagsData.initial(),
      paidById: '',
      paymentDateInUtc: null,
      paymentDateDefaultDate: null,
      paymentDateDefaultTime: null,
      paymentDateTimezone: "",
      distributeEqually: true,
      isCompensated: false,
      shareReferences: ShareReferences.initial(),
      customExchangeRates: ExchangeRates.initial(),
      // Import references.
      importReferenceTotalValue: null,
      importReferenceTotalCurrency: null,
      importReferenceExchangeRate: null,
      importReferencePaidById: null,
      importReferenceIsCompensated: null,
      importReferenceForceMemberValueImport: false,
      importReferencesMembers: null,
      importReferencePaymentDate: null,
      importReferenceTags: null,
      encryptedTotal: null,
      encryptedPaymentDate: null,
      encryptedCurrency: null,
      encryptedShareReferences: null,
      // State data.
      members: Members.initial(),
    );
  }

  /// This getter can be used to access payment date in a readable format.
  /// * Assumes values are not null.
  String getCreatedAt({required bool preserveUtc, required bool date, required bool time, String dateFormat = 'yyyy-MM-dd'}) {
    // Convert value.
    final DateTime converted = HelperFunctions.convertToTimezone(
      dateTimeInUtc: paymentDateInUtc!,
      timezone: paymentDateTimezone,
      preserveUtc: preserveUtc,
    );

    if (date && time) return '${DateFormat(dateFormat).format(converted)} ${labels.basicLabelsAt()} ${DateFormat("HH:mm").format(converted)}';

    if (date) return DateFormat(dateFormat).format(converted);

    return DateFormat("HH:mm").format(converted);
  }

  /// This getter can be used to access timezone in a readable format.
  String getCreatedAtTimezone({required bool preserveUtc}) {
    // If the value was stored in utc, use local timezone.
    if (paymentDateTimezone.isEmpty || paymentDateTimezone == "UTC") {
      // If flag was set, return UTC timezone.
      if (preserveUtc) return "UTC";

      // Try and access local timezone.
      final String? localTimezone = HelperFunctions.getCurrentTimezone();

      // It seems like local timezone could not be accessed.
      if (localTimezone == null || localTimezone.isEmpty) return "UTC";

      return localTimezone;
    }

    // Otherwise return stored timezone.
    return paymentDateTimezone;
  }

  /// This getter can be used to access all involved members of this payment.
  /// ```dart
  /// return [...shareReferences.getIds, paidById];
  /// ```
  List<String> get involvedMemberIds {
    return [...shareReferences.getIds, paidById];
  }

  /// This getter can be used to parse ```total``` to a double.
  /// * This getter assumes that total is a valid double.
  double get totalAsDouble {
    return double.parse(total);
  }

  /// This method can be used to access the converted total depending on exchange rate.
  double calculateConvertedTotal({required double exchangeRateToDefault}) {
    return totalAsDouble * exchangeRateToDefault;
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  /// * Should be used in a try catch block.
  static bool includeField({required PaymentData? paymentData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (paymentData == null) return false;

    final bool valueRef = paymentData.importReferenceTotalValue != null && paymentData.importReferenceTotalValue!.trim().isNotEmpty;
    final bool currencyRef = paymentData.importReferenceTotalCurrency != null && paymentData.importReferenceTotalCurrency!.trim().isNotEmpty;
    final bool paidByRef = paymentData.importReferencePaidById != null && paymentData.importReferencePaidById!.trim().isNotEmpty;
    final bool membersRef = paymentData.importReferencesMembers != null && paymentData.importReferencesMembers!.items.isNotEmpty;

    // ! Currently setting defaults for this field is not possible.
    if (isDefault) return false;

    // * User is in import mode.
    if (isImport) {
      // Ensure basic import refs are set.
      final bool basicIsSet = paidByRef && membersRef;

      // * Basic refs are not set, return false.
      if (basicIsSet == false) return false;

      // All references are set.
      if (valueRef && currencyRef) return true;

      // * Otherwise check for default values.
      final bool hasDefaultValue = paymentData.getTotalIsSet;
      final bool hasDefaultCurrency = paymentData.currencyCode.trim().isNotEmpty;

      // Value ref is valid but currency ref is not. Check for default currency.
      if (valueRef && currencyRef == false) {
        if (hasDefaultCurrency) return true;
      }

      // Currency is valid but value is not. Check for default value.
      if (valueRef == false && currencyRef) {
        if (hasDefaultValue) return true;
      }

      // * User might also have set a default value but this is optional so it wont be checked.

      // Import values are invalid.
      throw Failure.invalidPaymentImportReferences();
    }

    // * User is in normal set entry mode.

    // Check values.
    final bool totalIsInit = paymentData.getTotalIsSet == false || paymentData.totalAsDouble == 0;
    final bool sharesIsInit = paymentData.getCombinedSharedAmount == 0.0;

    if (totalIsInit == false && sharesIsInit == false) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required PaymentData? paymentData}) {
    if (paymentData == null) return null;
    if (paymentData.total.isEmpty) return null;
    if (paymentData.currencyCode.isEmpty) return null;

    return '${paymentData.totalAsDouble.toStringAsFixed(2)} ${paymentData.currencyCode}';
  }

  /// This getter can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` if ```total == null```
  String? getSubtitle({required String fieldLabel}) {
    // * No total available.
    if (getTotalIsSet == false) return null;

    return '${labels.paymentDataBarItemTotalSpent()} · ${totalAsDouble.toStringAsFixed(2)} $currencyCode';
  }

  /// This getter can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` if ```total == null```
  String? getThirdline({required String fieldLabel}) {
    // * No total available.
    if (getTotalIsSet == false) return null;

    return '${labels.paymentDataBarItemTotalSpent()} · ${totalAsDouble.toStringAsFixed(2)} $currencyCode';
  }

  /// This getter can be used to indicate if ```total``` has a value set.
  bool get getTotalIsSet {
    if (total.isEmpty) return false;

    return true;
  }

  /// This getter can be used to indicate if [total] has a value greater zero.
  bool get getTotalIsGreaterZero {
    if (totalAsDouble > 0 == false) return false;

    return true;
  }

  /// This getter can be used to indicate if a [total.currencyCode] was set.
  /// * assumes ```total != null```
  bool get getTotalCurrencyIsSet {
    if (currencyCode.isEmpty) return false;

    return true;
  }

  /// This getter can be used to get the combined amount of all shares.
  double get getCombinedSharedAmount {
    // Init helper.
    double combined = 0.0;

    for (final ShareReference item in shareReferences.items) {
      combined = combined + item.valueAsDouble;
    }

    return combined;
  }

  /// This getter can be used to indicate if [total] and [getCombinedSharedAmount] add up.
  /// * assumes ```total != null``` and ```total.value != null```
  bool get getTotalEqualsShares {
    if (totalAsDouble != getCombinedSharedAmount) return false;
    return true;
  }

  /// This getter can be used to inidcate if [paidById] is set.
  bool get getPaidByIdIsSet {
    if (paidById.isEmpty) return false;
    return true;
  }

  /// This method can be used to validate a ```PaymentData``` object.
  /// * should be used in a try catch block
  void validatePaymentData({required String fieldName, required bool tagsRequired}) {
    // * Total is not set.
    if (getTotalIsSet == false) {
      throw Failure.paymentTotalNotSet(fieldName: fieldName);
    }

    // * Total is not greater 0.0.
    if (getTotalIsGreaterZero == false) {
      throw Failure.paymentTotalNotGreaterZero(fieldName: fieldName);
    }

    // * No currency was set.
    if (getTotalCurrencyIsSet == false) {
      throw Failure.paymentTotalCurrencyNotSet(fieldName: fieldName);
    }

    // * Total amount and shares do not add up.
    if (getTotalEqualsShares == false) {
      throw Failure.paymentTotalDiffersFromShares(fieldName: fieldName);
    }

    // * Make sure a paid by was selected.
    if (getPaidByIdIsSet == false) {
      throw Failure.paymentPaidByNotSelected(fieldName: fieldName);
    }

    // * Make sure that tags are set if they are required.
    if (tagsRequired && tagsData.tagReferences.isEmpty) {
      throw Failure.tagsRequired(fieldName: fieldName);
    }
  }

  /// This method can be used to convert `ShareReferences` to a format suitable for encryption.
  String sharedReferencesToString() {
    // Init helper.
    String helper = '';

    for (final ShareReference element in shareReferences.items) {
      // Create String.
      final String pair = '${element.id}:${element.value}';

      // Update helper.
      helper = '$helper|$pair';
    }

    return helper;
  }

  /// This method can be used to convert `ShareReferences` to a format suitable for encryption.
  static ShareReferences shareReferencesFromString({required String value}) {
    // Remove the leading '|' if present (from the first appended element).
    final cleanStr = value.startsWith('|') ? value.substring(1) : value;

    // Split the string by '|' to separate each `id:value` pair.
    List<ShareReference> shareReferences = cleanStr.split('|').map((pair) {
      // Access ShareReference parts.
      final List<String> parts = pair.split(':');

      // Convert parts.
      return ShareReference(id: parts[0], value: parts[1]);
    }).toList();

    return ShareReferences(items: shareReferences);
  }

  /// #####################################
  /// Pie Chart Instructions
  /// #####################################

  /// Pie Chart identification to calculate the member share of overall costs.
  /// ```dart
  /// static const String pieChartMemberCostsOfOverallCosts = 'member_costs_of_overall_costs';
  /// ```
  static const String pieChartMemberCostsOfOverallCosts = 'member_costs_of_overall_costs';

  /// Pie Chart identification to calculate the member cost shares by tag.
  /// ```dart
  /// static const String pieChartMemberCostSharesByTag = 'member_cost_shares_by_tag';
  /// ```
  static const String pieChartMemberCostSharesByTag = 'member_cost_shares_by_tag';

  /// Pie Chart identification to calculate the overall cost shares by tag.
  /// ```dart
  /// static const String pieChartOverallCostSharesByTag = 'overall_cost_shares_by_tag';
  /// ```
  static const String pieChartOverallCostSharesByTag = 'overall_cost_shares_by_tag';

  /// #####################################
  /// Bar Chart Instructions
  /// #####################################

  /// Statistic identification to calculate the debt balance of all members.
  /// ```dart
  /// static const String chartInstructionMembersDebtBalances = 'members_debt_balances';
  /// ```
  static const String chartInstructionMembersDebtBalances = 'members_debt_balances';

  /// Statistic identification to calculate the total costs for all members.
  /// ```dart
  /// static const String chartInstructionMembersTotalCosts = 'members_total_costs';
  /// ```
  static const String chartInstructionMembersTotalCosts = 'members_total_costs';

  /// Statistic identification to calculate member specific costs over time.
  /// ```dart
  /// static const String chartInstructionCostsByMemberOverTime = 'costs_by_member_over_time';
  /// ```
  static const String chartInstructionCostsByMemberOverTime = 'costs_by_member_over_time';

  /// Statistic identification to calculate member specific costs by tags.
  /// ```dart
  /// static const String chartInstructionMemberCostsByTag = 'member_costs_by_tags';
  /// ```
  static const String chartInstructionMemberCostsByTag = 'member_costs_by_tags';

  /// Statistic identification to calculate member specific absolut expenses over time.
  /// ```dart
  /// static const String chartInstructionMemberAbsolutExpensesOverTime = 'member_absolut_expenses_over_time';
  /// ```
  static const String chartInstructionMemberAbsolutExpensesOverTime = 'member_absolut_expenses_over_time';

  /// Statistic identification to calculate member specific total income over time.
  /// ```dart
  /// static const String chartInstructionMemberAbsolutIncomeOverTime = 'member_absolut_income_over_time';
  /// ```
  static const String chartInstructionMemberAbsolutIncomeOverTime = 'member_absolut_income_over_time';

  /// Statistic identification to calculate member specific absolut profits and losses over time.
  /// ```dart
  /// static const String chartInstructionMemberProfitsAndLosses = 'member_absolut_profits_and_losses_over_time';
  /// ```
  static const String chartInstructionMemberAbsolutProfitsAndLosses = 'member_absolut_profits_and_losses_over_time';

  /// Statistic identification to calculate overall costs by tag.
  /// ```dart
  /// static const String chartInstructionOverallCostsByTag = 'overall_costs_by_tag';
  /// ```
  static const String chartInstructionOverallCostsByTag = 'overall_costs_by_tag';

  // #####################################
  // Database
  // #####################################

  /// Convert a ```PaymentData``` object to a ```DbPaymentData``` object.
  DbPaymentData toSchema() {
    return DbPaymentData(
      participantReference: participantReference,
      // * Use try parse here because in case of import match there might not be a valid double here (empty)
      // * but the schema conversion is still needed.
      // * If encryption was applied, remove value.
      total: encryptedTotal?.isNotEmpty == true ? null : double.tryParse(total),
      // * If encryption was applied, remove value.
      currencyCode: encryptedCurrency?.isNotEmpty == true ? null : currencyCode,
      tagsData: tagsData.toSchema(),
      paidById: paidById,
      isCompensated: isCompensated,
      // * If encryption was applied, remove value.
      paymentDateInUtc: encryptedPaymentDate?.isNotEmpty == true ? null : paymentDateInUtc?.millisecondsSinceEpoch, // This can be null in case of default.
      paymentDateDefaultDate: paymentDateDefaultDate,
      paymentDateDefaultTime: paymentDateDefaultTime,
      paymentDateTimezone: paymentDateTimezone.isEmpty ? null : paymentDateTimezone,
      distributeEqually: distributeEqually,
      // * If encryption was applied, remove value.
      shareReferences: encryptedShareReferences?.isNotEmpty == true ? null : shareReferences.toSchema(),
      customExchangeRates: customExchangeRates.toEmbeddedSchema(),
      // Import references.
      importReferenceTotalValue: importReferenceTotalValue,
      importReferenceTotalCurrency: importReferenceTotalCurrency,
      importReferenceExchangeRate: importReferenceExchangeRate,
      importReferencePaidById: importReferencePaidById,
      importReferenceIsCompensated: importReferenceIsCompensated,
      // * This is done so that schema can be nullable. This is for consistency and to save some space because otherwise
      // * this would always get saved even though it is not needed sometimes.
      importReferenceForceMemberValueImport: importReferenceForceMemberValueImport == false ? null : true,
      importReferencesMembers: importReferencesMembers?.toSchema(),
      importReferencePaymentDate: importReferencePaymentDate,
      importReferenceTags: importReferenceTags,
      // Encryption.
      encryptedTotal: encryptedTotal,
      encryptedPaymentDate: encryptedPaymentDate,
      encryptedCurrency: encryptedCurrency,
      encryptedShareReferences: encryptedShareReferences,
    );
  }

  /// Convert a ```DbPaymentData``` object to a ```PaymentData``` object.
  static PaymentData? fromSchema({required DbPaymentData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // * This manual conversion is needed here because in case of an import match schema.value might be null.
    final String convertedTotal = schema.total == null ? '' : schema.total.toString();

    return PaymentData(
      participantReference: schema.participantReference!,
      // If encryption was applied, set value to a placeholder until decryption.
      total: schema.encryptedTotal?.isNotEmpty == true ? '' : convertedTotal,
      // If encryption was applied, set value to a placeholder until decryption.
      currencyCode: schema.encryptedCurrency?.isNotEmpty == true ? '' : schema.currencyCode!,
      tagsData: TagsData.fromSchema(schema: schema.tagsData)!,
      paidById: schema.paidById!,
      // If encryption was applied, set value to a placeholder until decryption.
      // * This can also be null in case of defaults.
      paymentDateInUtc: schema.encryptedPaymentDate?.isNotEmpty == true || schema.paymentDateInUtc == null ? null : DateTime.fromMillisecondsSinceEpoch(schema.paymentDateInUtc!, isUtc: true),
      paymentDateDefaultDate: schema.paymentDateDefaultDate,
      paymentDateDefaultTime: schema.paymentDateDefaultTime,
      // * This can be null in case of defaults.
      paymentDateTimezone: schema.paymentDateTimezone ?? "",
      isCompensated: schema.isCompensated!,
      distributeEqually: schema.distributeEqually!,
      // If encryption was applied, set value to a placeholder until decryption.
      shareReferences: schema.encryptedShareReferences?.isNotEmpty == true ? ShareReferences.initial() : ShareReferences.fromSchema(schema: schema.shareReferences)!,
      customExchangeRates: ExchangeRates.fromEmbeddedSchema(schema: schema.customExchangeRates),
      // Import references.
      importReferenceTotalValue: schema.importReferenceTotalValue,
      importReferenceTotalCurrency: schema.importReferenceTotalCurrency,
      importReferenceExchangeRate: schema.importReferenceExchangeRate,
      importReferencePaidById: schema.importReferencePaidById,
      importReferenceIsCompensated: schema.importReferenceIsCompensated,
      importReferenceForceMemberValueImport: schema.importReferenceForceMemberValueImport ?? false,
      importReferencesMembers: MemberToImportReferences.fromSchema(schema: schema.importReferencesMembers),
      importReferencePaymentDate: schema.importReferencePaymentDate,
      importReferenceTags: schema.importReferenceTags,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedTotal: schema.encryptedTotal != null ? Uint8List.fromList(schema.encryptedTotal!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedCurrency: schema.encryptedCurrency != null ? Uint8List.fromList(schema.encryptedCurrency!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedPaymentDate: schema.encryptedPaymentDate != null ? Uint8List.fromList(schema.encryptedPaymentDate!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedShareReferences: schema.encryptedShareReferences != null ? Uint8List.fromList(schema.encryptedShareReferences!) : null,
      // State data.
      members: Members.initial(),
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```PaymentData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'participant_reference': participantReference,
      'total': totalAsDouble,
      'currency_code': currencyCode,
      'tags_data': tagsData.toCloudObject(),
      'paid_by_id': paidById,
      'is_compensated': isCompensated,
      // * In case of default, this might be null.
      'payment_date_in_utc': paymentDateInUtc?.toIso8601String(),
      'default_date': paymentDateDefaultDate,
      'default_time': paymentDateDefaultTime,
      'timezone': paymentDateTimezone.isEmpty ? null : paymentDateTimezone,
      'distribute_equally': distributeEqually,
      'share_references': shareReferences.toCloudObject(),
      'custom_exchange_rates': customExchangeRates.toCloudObject(includeDate: false),
    };
  }

  /// Decode a ```PaymentData``` object from JSON.
  static PaymentData fromCloudObject(document) {
    return PaymentData(
      participantReference: document['participant_reference'],
      total: document['total'].toString(),
      currencyCode: document['currency_code'],
      tagsData: TagsData.fromCloudObject(document['tags_data']),
      paidById: document['paid_by_id'],
      isCompensated: document['is_compensated'],
      // In case of default, this might be null.
      paymentDateInUtc: document['payment_date_in_utc'] == null ? null : DateTime.parse(document['payment_date_in_utc']),
      paymentDateDefaultDate: document['default_date'],
      paymentDateDefaultTime: document['default_time'],
      // In case of default, this might be null.
      paymentDateTimezone: document['timezone'] ?? "",
      distributeEqually: document['distribute_equally'],
      shareReferences: ShareReferences.fromCloudObject(document['share_references']),
      customExchangeRates: ExchangeRates.fromCloudObject(document['custom_exchange_rates']),
      // Import references.
      importReferenceTotalValue: null,
      importReferenceTotalCurrency: null,
      importReferenceExchangeRate: null,
      importReferencePaidById: null,
      importReferenceIsCompensated: null,
      importReferenceForceMemberValueImport: false,
      importReferencesMembers: null,
      importReferencePaymentDate: null,
      importReferenceTags: null,
      // Encryption.
      encryptedTotal: null,
      encryptedPaymentDate: null,
      encryptedCurrency: null,
      encryptedShareReferences: null,
      // State data.
      members: Members.initial(),
    );
  }

  // ######################################
  // Copy With
  // ######################################

  PaymentData copyWith({
    String? participantReference,
    DateTime? paymentDateInUtc,
    String? paymentDateDefaultDate,
    String? paymentDateDefaultTime,
    String? paymentDateTimezone,
    String? paidById,
    String? total,
    String? currencyCode,
    bool? isCompensated,
    bool? distributeEqually,
    ShareReferences? shareReferences,
    TagsData? tagsData,
    ExchangeRates? customExchangeRates,
    String? importReferenceTotalValue,
    String? importReferenceTotalCurrency,
    String? importReferenceExchangeRate,
    String? importReferencePaidById,
    String? importReferenceIsCompensated,
    bool? importReferenceForceMemberValueImport,
    MemberToImportReferences? importReferencesMembers,
    String? importReferencePaymentDate,
    String? importReferenceTags,
    Uint8List? encryptedTotal,
    Uint8List? encryptedPaymentDate,
    Uint8List? encryptedCurrency,
    Uint8List? encryptedShareReferences,
    Members? members,
  }) {
    return PaymentData(
      participantReference: participantReference ?? this.participantReference,
      paymentDateInUtc: paymentDateInUtc ?? this.paymentDateInUtc,
      paymentDateDefaultDate: paymentDateDefaultDate ?? this.paymentDateDefaultDate,
      paymentDateDefaultTime: paymentDateDefaultTime ?? this.paymentDateDefaultTime,
      paymentDateTimezone: paymentDateTimezone ?? this.paymentDateTimezone,
      paidById: paidById ?? this.paidById,
      total: total ?? this.total,
      currencyCode: currencyCode ?? this.currencyCode,
      isCompensated: isCompensated ?? this.isCompensated,
      distributeEqually: distributeEqually ?? this.distributeEqually,
      shareReferences: shareReferences ?? this.shareReferences,
      tagsData: tagsData ?? this.tagsData,
      customExchangeRates: customExchangeRates ?? this.customExchangeRates,
      importReferenceTotalValue: importReferenceTotalValue ?? this.importReferenceTotalValue,
      importReferenceTotalCurrency: importReferenceTotalCurrency ?? this.importReferenceTotalCurrency,
      importReferenceExchangeRate: importReferenceExchangeRate ?? this.importReferenceExchangeRate,
      importReferencePaidById: importReferencePaidById ?? this.importReferencePaidById,
      importReferenceIsCompensated: importReferenceIsCompensated ?? this.importReferenceIsCompensated,
      importReferenceForceMemberValueImport: importReferenceForceMemberValueImport ?? this.importReferenceForceMemberValueImport,
      importReferencesMembers: importReferencesMembers ?? this.importReferencesMembers,
      importReferencePaymentDate: importReferencePaymentDate ?? this.importReferencePaymentDate,
      importReferenceTags: importReferenceTags ?? this.importReferenceTags,
      encryptedTotal: encryptedTotal ?? this.encryptedTotal,
      encryptedPaymentDate: encryptedPaymentDate ?? this.encryptedPaymentDate,
      encryptedCurrency: encryptedCurrency ?? this.encryptedCurrency,
      encryptedShareReferences: encryptedShareReferences ?? this.encryptedShareReferences,
      members: members ?? this.members,
    );
  }
}
