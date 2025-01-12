import 'package:flutter/foundation.dart';

class ApiPaths {
  /// Base endpoint for API.
  /// - For local development internet connection server is connected to, has to be set to home network.
  /// - Also for local server use baseEndpoint like this. 'http://xxx.xxx.x.xxx:5000'
  static const String baseEndpointApi = kReleaseMode ? 'https://www.lucentally.com/api' : 'http://192.168.2.183:5000/api';

  /// Base endpoint for deep links.
  /// * Do not include the /api/ here.
  static const String baseEndpointDeepLinks = kReleaseMode ? 'https://www.lucentally.com' : 'http://192.168.2.183:5000';

  // ----------------------------
  // --------- Versioning -------
  // ----------------------------

  /// API version.
  /// ```dart
  /// static const String apiVersion = "2024-01";
  /// ```
  static const String apiVersion = "2024-01";

  // ----------------------------
  // --------- Legal ------------
  // ----------------------------

  /// Base Legal endpoint.
  /// ```dart
  /// static const String endpointLegal = "$baseEndpoint/$apiVersion/legal";
  /// ```
  static const String endpointLegal = "$baseEndpointApi/$apiVersion/legal";

  /// Privacy policy endpoint.
  /// ```dart
  /// static const String privacyPolicy = "privacy-policy";
  /// ```
  static const String privacyPolicy = "privacy-policy";

  /// User Agreement endpoint.
  /// ```dart
  /// static const String userAgreement = "user-agreement";
  /// ```
  static const String userAgreement = "user-agreement";

  // ----------------------------
  // --------- Support ----------
  // ----------------------------

  /// Support email.
  /// ```dart
  /// static const String supportEmail = "$baseEndpoint/$apiVersion/support/support-email";
  /// ```
  static const String supportEmail = "$baseEndpointApi/$apiVersion/support/support-email";

  // ----------------------------
  // --------- Auth -------------
  // ----------------------------

  /// Base Auth endpoint.
  /// ```dart
  /// static const String baseEndpointAuth = "$baseEndpoint/$apiVersion/auth";
  /// ```
  static const String baseEndpointAuth = "$baseEndpointApi/$apiVersion/auth";

  /// Register anon user endpoint.
  /// ```dart
  /// static const String registerAnonUser = "$baseEndpointAuth/$actionRegister/anon";
  /// ```
  static const String registerAnonUser = "$baseEndpointAuth/$actionRegister/anon";

  // ----------------------------
  // --------- Entries ----------
  // ----------------------------

  /// Base Entries endpoint.
  /// ```dart
  /// static const String baseEndpointEntries = "$baseEndpoint/$apiVersion/entries";
  /// ```
  static const String baseEndpointEntries = "$baseEndpointApi/$apiVersion/entries";

  // ----------------------------
  // --------- Entry Models -----
  // ----------------------------

  /// Base Entry Models endpoint.
  /// ```dart
  /// static const String baseEndpointModelEntries = "$baseEndpoint/$apiVersion/model-entries";
  /// ```
  static const String baseEndpointModelEntries = "$baseEndpointApi/$apiVersion/model-entries";

  // ----------------------------
  // --------- Groups -----------
  // ----------------------------

  /// Base Groups endpoint.
  /// ```dart
  /// static const String baseEndpointGroups = "$baseEndpoint/$apiVersion/groups";
  /// ```
  static const String baseEndpointGroups = "$baseEndpointApi/$apiVersion/groups";

  // ----------------------------
  // --------- Subgroups --------
  // ----------------------------

  /// Base Subgroups endpoint.
  /// ```dart
  /// static const String baseEndpointSubgroups = "$baseEndpoint/$apiVersion/subgroups";
  /// ```
  static const String baseEndpointSubgroups = "$baseEndpointApi/$apiVersion/subgroups";

  // ----------------------------
  // --------- Participants -----
  // ----------------------------

  /// Base Participants endpoint.
  /// ```dart
  /// static const String baseEndpointParticipants = "$baseEndpoint/$apiVersion/participants";
  /// ```
  static const String baseEndpointParticipants = "$baseEndpointApi/$apiVersion/participants";

  // ----------------------------
  // --------- Members ----------
  // ----------------------------

  /// Base Members endpoint.
  /// ```dart
  /// static const String baseEndpointMembers = "$baseEndpoint/$apiVersion/members";
  /// ```
  static const String baseEndpointMembers = "$baseEndpointApi/$apiVersion/members";

  // ----------------------------
  // --------- Tags -------------
  // ----------------------------

  /// Base Tags endpoint.
  /// ```dart
  /// static const String baseEndpointTags = "$baseEndpoint/$apiVersion/tags";
  /// ```
  static const String baseEndpointTags = "$baseEndpointApi/$apiVersion/tags";

  // ----------------------------
  // --------- Exchange Rates ---
  // ----------------------------

  /// Base Exchange Rates endpoint.
  /// ```dart
  /// static const String baseEndpointExchangeRates = "$baseEndpoint/$apiVersion/exchange-rates";
  /// ```
  static const String baseEndpointExchangeRates = "$baseEndpointApi/$apiVersion/exchange-rates";

  // #################################
  // # Charts
  // #################################

  /// Base Charts endpoint.
  /// ```dart
  /// static const String baseEndpointCharts = "$baseEndpoint/$apiVersion/charts";
  /// ```
  static const String baseEndpointCharts = "$baseEndpointApi/$apiVersion/charts";

  // ----------------------------
  // --------- Actions ----------
  // ----------------------------

  /// Action: actionAvailableExports.
  /// ```dart
  /// static const String actionAvailableExports = "available-exports";
  /// ```
  static const String actionAvailableExports = "available-exports";

  /// Action: actionDecrementAvailableExports.
  /// ```dart
  /// static const String actionDecrementAvailableExports = "decrement-available-exports";
  /// ```
  static const String actionDecrementAvailableExports = "decrement-available-exports";

  /// Action: actionNextBirthdays.
  /// ```dart
  /// static const String actionNextBirthdays = "next-birthdays";
  /// ```
  static const String actionNextBirthdays = "next-birthdays";

  /// Action: actionCreditorsDebitors.
  /// ```dart
  /// static const String actionCreditorsDebitors = "creditors-debitors";
  /// ```
  static const String actionCreditorsDebitors = "creditors-debitors";

  /// Action: actionInitial.
  /// ```dart
  /// static const String actionInitial = "initial";
  /// ```
  static const String actionInitial = "initial";

  /// Action: actionItems.
  /// ```dart
  /// static const String actionItems = "items";
  /// ```
  static const String actionItems = "items";

  /// Action: actionCanChange.
  /// ```dart
  /// static const String actionCanChange = "can-change";
  /// ```
  static const String actionCanChange = "can-change";

  /// Action: actionChangeUsername.
  /// ```dart
  /// static const String actionChangeUsername = "change-username";
  /// ```
  static const String actionChangeUsername = "change-username";

  /// Action: actionOfDate.
  /// ```dart
  /// static const String actionOfDate = "of-date";
  /// ```
  static const String actionOfDate = "of-date";

  /// Action: actionPaginate.
  /// ```dart
  /// static const String actionPaginate = "paginate";
  /// ```
  static const String actionPaginate = "paginate";

  /// Action: create.
  /// ```dart
  /// static const String actionCreate = "create";
  /// ```
  static const String actionCreate = "create";

  /// Action: edit.
  /// ```dart
  /// static const String actionEdit = "edit";
  /// ```
  static const String actionEdit = "edit";

  /// Action: delete.
  /// ```dart
  /// static const String actionDelete = "delete";
  /// ```
  static const String actionDelete = "delete";

  /// Action: register.
  /// ```dart
  /// static const String actionRegister = "register";
  /// ```
  static const String actionRegister = "register";

  /// Action: by-id.
  /// ```dart
  /// static const String actionById = "by-id";
  /// ```
  static const String actionById = "by-id";

  /// Action: get-batch.
  /// ```dart
  /// static const String actionGetBatch = "get-batch";
  /// ```
  static const String actionGetBatch = "get-batch";

  /// Action: validate-invite.
  /// ```dart
  /// static const String actionValidateInvite = "validate-invite";
  /// ```
  static const String actionValidateInvite = "validate-invite";

  /// Action: actionjoin.
  /// ```dart
  /// static const String actionjoin = "join";
  /// ```
  static const String actionJoin = "join";

  /// Action: actionOfReference.
  /// ```dart
  /// static const String actionOfReference = "of-reference";
  /// ```
  static const String actionOfReference = "of-reference";

  /// Action: self-all.
  /// ```dart
  /// static const String actionSelfAll = "self-all";
  /// ```
  static const String actionSelfAll = "self-all";

  /// Action: self-all-of.
  /// ```dart
  /// static const String actionSelfAllOf = "self-all-of";
  /// ```
  static const String actionSelfAllOf = "self-all-of";

  /// Action: subgroups.
  /// ```dart
  /// static const String actionSubgroups = "subgroups";
  /// ```
  static const String actionSubgroups = "subgroups";

  /// Action: subgroup.
  /// ```dart
  /// static const String actionSubgroup = "subgroup";
  /// ```
  static const String actionSubgroup = "subgroup";

  /// Action: members.
  /// ```dart
  /// static const String actionMembers = "members";
  /// ```
  static const String actionMembers = "members";

  /// Action: removed-entries.
  /// ```dart
  /// static const String actionRemovedEntries = "removed-entries";
  /// ```
  static const String actionRemovedEntries = "removed-entries";

  /// Action: created-entries.
  /// ```dart
  /// static const String actionCreatedEntries = "created-entries";
  /// ```
  static const String actionCreatedEntries = "created-entries";

  /// Action: add-entry.
  /// ```dart
  /// static const String actionAddEntry = "add-entry";
  /// ```
  static const String actionAddEntry = "add-entry";

  /// Action: of-entry.
  /// ```dart
  /// static const String actionOfEntry = "of-entry";
  /// ```
  static const String actionOfEntry = "of-entry";

  /// Action: count-entries.
  /// ```dart
  /// static const String actionCountEntries = "count-entries";
  /// ```
  static const String actionCountEntries = "count-entries";

  /// Action: referenced-model-entry.
  /// ```dart
  /// static const String actionReferencedModelEntry = "referenced-model-entry";
  /// ```
  static const String actionReferencedModelEntry = "referenced-model-entry";

  /// Action: referenced-participant.
  /// ```dart
  /// static const String actionReferencedParticipant = "referenced-participant";
  /// ```
  static const String actionReferencedParticipant = "referenced-participant";

  /// Action: self-recent-by-id.
  /// ```dart
  /// static const String actionSelfRecentById = "self-recent-by-id";
  /// ```
  static const String actionSelfRecentById = "self-recent-by-id";

  /// Action: self-recent.
  /// ```dart
  /// static const String actionSelfRecent = "self-recent";
  /// ```
  static const String actionSelfRecent = "self-recent";

  /// Action: put-recent.
  /// ```dart
  /// static const String actionPutRecent = "put-recent";
  /// ```
  static const String actionPutRecent = "put-recent";

  /// Action: search-in-group.
  /// ```dart
  /// static const String actionSearchInGroup = "search-in-group";
  /// ```
  static const String actionSearchInGroup = "search-in-group";

  /// Action: by-label.
  /// ```dart
  /// static const String actionByLabel = "by-label";
  /// ```
  static const String actionByLabel = "by-label";

  /// Action: suggestions.
  /// ```dart
  /// static const String actionSuggestions = "suggestions";
  /// ```
  static const String actionSuggestions = "suggestions";

  /// Action: leave.
  /// ```dart
  /// static const String actionLeave = "leave";
  /// ```
  static const String actionLeave = "leave";

  /// Action: all-of.
  /// ```dart
  /// static const String actionAllOf = "all-of";
  /// ```
  static const String actionAllOf = "all-of";

  /// Action: prefs.
  /// ```dart
  /// static const String actionPrefs = "prefs";
  /// ```
  static const String actionPrefs = "prefs";

  /// Action: ban.
  /// ```dart
  /// static const String actionBan = "ban";
  /// ```
  static const String actionBan = "ban";

  /// Action: revoke-ban.
  /// ```dart
  /// static const String actionRevokeBan = "revoke-ban";
  /// ```
  static const String actionRevokeBan = "revoke-ban";

  /// Action: is-banned.
  /// ```dart
  /// static const String actionIsBanned = "is-banned";
  /// ```
  static const String actionIsBanned = "is-banned";

  /// Action: alias.
  /// ```dart
  /// static const String actionAlias = "alias";
  /// ```
  static const String actionAlias = "alias";

  /// Action: api-requirements.
  /// ```dart
  /// static const String apiRequirements = "api-requirements";
  /// ```
  static const String apiRequirements = "api-requirements";

  // ----------------------------
  // --------- Methods ----------
  // ----------------------------

  /// This method can be used to create an endpoint depending on a country.
  /// ```dart
  /// return "$base/$countryCode/$suffix";
  /// ```
  static String createCountryEndpoint({required String base, required String countryCode, required String suffix}) {
    return "$base/$countryCode/$suffix";
  }

  /// This method can be used to create an endpoint following best practices.
  /// ```dart
  /// if (id == null) return "$baseEndpoint/$action";
  /// return "$baseEndpoint/$action/$id";
  /// ```
  static String buildEndpoint({required String baseEndpoint, required String action, String? id}) {
    if (id == null) return "$baseEndpoint/$action";
    return "$baseEndpoint/$action/$id";
  }
}
