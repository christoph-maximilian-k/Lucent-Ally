import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// API.
import '/api/api_helpers.dart';
import '/api/api_paths.dart';

// Models.
import '/data/models/users/user.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';
import '/data/models/participants/participant.dart';
import '/data/models/participants/participants.dart';
import '/data/models/members/members.dart';
import '/data/models/entries/entry.dart';
import '/data/models/entries/entries.dart';
import '/data/models/references/recent_entries/recent_entry.dart';
import '/data/models/tags/tag.dart';
import '/data/models/tags/tags.dart';
import '/data/models/model_entry_prefs/model_entry_prefs.dart';
import '/data/models/group_prefs/group_prefs.dart';
import '/data/models/charts/chart.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/field_types/measurement_data/measurements.dart';
import '/data/models/exchange_rates/exchange_rates.dart';
import '/data/models/cloud_user/cloud_user.dart';

class ApiRepository {
  /// This method can be used to access privacy policy.
  /// * should be used in a try catch block
  Future<String> getPrivacyPolicy() async {
    // Output debug message.
    debugPrint("ApiRepository --> getPrivacyPolicy() --> privacy policy requested");

    // Access country code.
    // * If null, use english as default.
    final String countryCode = WidgetsBinding.instance.platformDispatcher.locales.first.countryCode ?? 'en';

    // Access country dependent endpoint.
    final String endpoint = ApiPaths.createCountryEndpoint(
      base: ApiPaths.endpointLegal,
      countryCode: countryCode.toLowerCase(),
      suffix: ApiPaths.privacyPolicy,
    );

    // Target create offer endpoint.
    final Uri uri = Uri.parse(endpoint);

    // Conduct API call.
    final http.Response response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getPrivacyPolicy()',
    );

    // Return privacy policy
    return data['privacy_policy'];
  }

  /// This method can be used to access user agreement.
  /// * should be used in a try catch block
  Future<String> getUserAgreement() async {
    // Output debug message.
    debugPrint("ApiRepository --> getUserAgreement() --> user agreement requested");

    // Access country code.
    // * If null, use english as default.
    final String countryCode = WidgetsBinding.instance.platformDispatcher.locales.first.countryCode ?? 'en';

    // Access country dependent endpoint.
    final String endpoint = ApiPaths.createCountryEndpoint(
      base: ApiPaths.endpointLegal,
      countryCode: countryCode.toLowerCase(),
      suffix: ApiPaths.userAgreement,
    );

    // Target create offer endpoint.
    final Uri uri = Uri.parse(endpoint);

    // Conduct API call.
    final http.Response response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getUserAgreement()',
    );

    // Return user agreement
    return data['user_agreement'];
  }

  /// This method can be used to access current support email.
  /// * should be used in a try catch block
  Future<String> getSupportEmail() async {
    // Output debug message.
    debugPrint("ApiRepository --> getSupportEmail() --> support email requested");

    // Target create offer endpoint.
    final Uri uri = Uri.parse(ApiPaths.supportEmail);

    // Conduct API call.
    final http.Response response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSupportEmail()',
    );

    // Return user agreement
    return data['support_email'];
  }

  // #####################################
  // Authentification
  // #####################################

  /// This method can be used to create a anonymous cloud user.
  /// * Should be used in a try catch block.
  Future<User> createCloudAnonUser({required User user}) async {
    // * Create User JSON.
    final Map<String, dynamic> json = user.toCloudObject();

    // * Create user register url.
    final Uri url = Uri.parse(ApiPaths.registerAnonUser);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> createCloudAnonUser()',
    );

    // Create updated User.
    final User updatedUser = User.fromCloudObject(data);

    return updatedUser;
  }

  /// This method can be used to change the username.
  /// * Should be used in a try catch bock.
  Future<void> selfChangeUsername({required User user, required String username}) async {
    // * Create User JSON.
    final Map<String, dynamic> json = {
      'username': username,
    };

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointAuth,
      action: ApiPaths.actionChangeUsername,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> selfChangeUsername()',
    );
  }

  /// This method can be used to check if a user can still change there username.
  /// * Should be used in a try catch block.
  Future<bool> getSelfUsernameCanChange({required User user}) async {
    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointAuth,
      action: ApiPaths.actionCanChange,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSelfUsernameCanChange()',
    );

    // Access data.
    final bool canChange = data['can_change'];

    return canChange;
  }

  /// This method can be used to verify that this app build is still meets API requirements.
  /// * Should be used in a try catch block.
  Future<void> meetsApiRequirements({required User user, required Map<String, dynamic> data}) async {
    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointAuth,
      action: ApiPaths.apiRequirements,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // * Do not use with bearer token because this method needs to work no matter what.
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(data),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> meetsApiRequirements()',
    );
  }

  /// This method can be used to access a user by its id.
  /// * Should be used in a try catch block.
  Future<CloudUser?> getCloudUserById({required User user, required String otherUserId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointAuth,
      action: ApiPaths.actionById,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'user_id': otherUserId,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getCloudUserById()',
    );

    // Create local User object.
    final CloudUser cloudUser = CloudUser.fromCloudObject(data["user"]);

    return cloudUser;
  }

  // #####################################
  // Tags
  // #####################################

  /// This method can be used to create a new shared ```Tag```.
  /// * Should be used in a try catch block.
  Future<Tag> createSharedTag({required User user, required Tag tag}) async {
    // * Create Entry JSON.
    final Map<String, dynamic> json = tag.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointTags,
      action: ApiPaths.actionCreate,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> createSharedTag()',
    );

    // Create updated tag.
    final Tag updatedTag = tag.copyWith(
      tagId: data["tag_id"],
    );

    return updatedTag;
  }

  /// This method can be used to access a  ```Tag``` by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```tagId``` was not found.
  Future<Tag?> getSharedTagById({required User user, required String tagId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointTags,
      action: ApiPaths.actionById,
      id: tagId,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedTagById()',
    );

    // Tag not found.
    if (data['tag'] == null) return null;

    // Access Tag.
    final Tag tag = Tag.fromCloudObject(data['tag']);

    return tag;
  }

  /// This method can be used to access a  ```Tag``` by its label.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```tagLabel``` was not found.
  Future<Tag?> getSharedTagByLabel({required User user, required String tagLabel}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointTags,
      action: ApiPaths.actionByLabel,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'value': tagLabel,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedTagById()',
    );

    // Tag not found.
    if (data['tag'] == null) return null;

    // Access Tag.
    final Tag tag = Tag.fromCloudObject(data['tag']);

    return tag;
  }

  /// This method can be used to access  suggestions for ```Tags```.
  /// * Should be used in a try catch block.
  Future<Tags> getSharedTagSuggestions({required User user, required String value}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointTags,
      action: ApiPaths.actionSuggestions,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'value': value,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedTagSuggestions()',
    );

    final List<dynamic> decodedTags = data['tags'];

    // No tags were found.
    if (decodedTags.isEmpty) return Tags.initial();

    // Access Tags.
    final Tags tags = Tags.fromCloudObject(decodedTags);

    return tags;
  }

  // #####################################
  // Entry
  // #####################################

  /// This method can be used to create a new ```Entry``` in the cloud.
  /// * Should be used in a try catch block.
  Future<Entry> createSharedEntry({required User user, required Entry entry, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // * Create Entry JSON.
    final Map<String, dynamic> json = entry.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionCreate,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> createSharedEntry()',
    );

    // Create updated entry.
    final Entry updatedEntry = entry.copyWith(
      entryId: data["entry_id"],
    );

    return updatedEntry;
  }

  /// This method can be used to edit a shared ```Entry```,
  /// * Should be used in a try catch block.
  Future<Entry> editSharedEntry({required User user, required Entry entry, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // * Create Entry JSON.
    final Map<String, dynamic> json = entry.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionEdit,
      id: entry.entryId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> editSharedEntry()',
    );

    return entry;
  }

  /// This method can be used to delete a shared ```Entry```.
  /// * Should be used in a try catch block.
  Future<void> deleteSharedEntry({required User user, required Entry entry, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionById,
      id: entry.entryId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> deleteSharedEntry()',
    );
  }

  /// This method can be used to get a shared ```Entry``` by its id.
  /// * Should be used in a try catch block.
  Future<Entry> getSharedEntryById({required User user, required String rootGroupReference, required String entryId, required String referenceType, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionById,
      id: entryId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedEntryById()',
    );

    // Parse entry.
    final Entry entry = Entry.fromCloudObject(data['entry']);

    return entry;
  }

  /// This method can be used to access a specified recent entry.
  /// * Should be used in a try catch block.
  Future<RecentEntry> getSelfSharedRecentEntryById({required User user, required String entryId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionSelfRecentById,
      id: entryId,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSelfSharedRecentEntryById()',
    );

    final dynamic decodedRecentEntry = data['recent_entry'];

    // Convert from JSON.
    final RecentEntry recentEntry = RecentEntry.fromCloudObject(decodedRecentEntry);

    return recentEntry;
  }

  /// This method can be used to access specified entries.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getSelfSharedRecentEntries({required User user, required int offset, required int limit}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionSelfRecent,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSelfSharedRecentEntries()',
    );

    final List<dynamic> decodedEntries = data['entries'];
    final List<dynamic> decodedModelEntries = data['model_entries'];

    // Convert from JSON.
    final Entries entries = Entries.fromCloudObject(decodedEntries);
    final ModelEntries modelEntries = ModelEntries.fromCloudObject(decodedModelEntries);

    return {
      "entries": entries,
      "model_entries": modelEntries,
    };
  }

  /// This method can be used to put a recent entry in to cloud storage.
  /// * Should be used in a try catch block.
  Future<void> putSharedRecentEntry({required User user, required String entryId, required String referenceType, required String referenceId}) async {
    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionPutRecent,
      id: entryId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> putSharedRecentEntry()',
    );
  }

  /// This method can be used to access ```Entries``` of a shared group.
  /// * Should be used in a try catch block.
  Future<Entries> getEntriesOfSharedGroup({required User user, required String rootGroupReference, required String referenceType, required String referenceId, required int offset, required int limit}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionPaginate,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getEntriesOfSharedGroup()',
    );

    final List<dynamic> decoded = data['entries'];

    // Convert from JSON.
    final Entries entries = Entries.fromCloudObject(decoded);

    return entries;
  }

  /// This method can be used to search Entries by their name.
  /// * Should be used in a try catch block.
  Future<Entries> searchEntriesOfGroupByName({required User user, required String searchCriteria, required String rootGroupReference, required String groupId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointEntries,
      action: ApiPaths.actionSearchInGroup,
    );

    // Create url.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'search_criteria': searchCriteria,
      'group_id': groupId,
    };

    // Create the complete URL with query parameters.
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> searchEntriesOfGroupByName()',
    );

    final List<dynamic> decoded = data['entries'];

    // Convert from JSON.
    final Entries entries = Entries.fromCloudObject(decoded);

    return entries;
  }

  // #####################################
  // Exchange rates
  // #####################################

  /// This method can be used to find a exchange rate depending on its ```expenseDate``` in the cloud.
  /// * Should be used in a try catch block.
  /// * Returns ```0.0``` if exchange rate was not found.
  Future<double> findCloudExchangeRate({required User user, required DateTime exchangeRateDateInUtc, required String fromCurrencyCode, required String toCurrencyCode}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointExchangeRates,
      action: ApiPaths.actionOfDate,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'date': exchangeRateDateInUtc.toIso8601String(),
      'from_currency_code': fromCurrencyCode,
      'to_currency_code': toCurrencyCode,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> findCloudExchangeRate()',
    );

    return data['exchange_rate'];
  }

  /// This method can be used to access exchange rates in batches.
  /// * Should be used in a try catch block.
  Future<List<dynamic>> getExchangeRatesBatch({required User user, required Group group, required ExchangeRates batch}) async {
    // Create ModelEntry JSON.
    // Set includeExchangeRate to false in order to exclude the actual exchange rate value for efficiency gains.
    List<Map<String, dynamic>> json = batch.toCloudObject(includeExchangeRate: false);

    // Create body.
    final Map<String, dynamic> body = {
      'references': json,
    };

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointExchangeRates,
      action: ApiPaths.actionGetBatch,
    );

    // * Create uri.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> result = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getExchangeRatesBatch()',
    );

    return result['data'];
  }

  // #####################################
  // Model Entry Prefs
  // #####################################

  /// This method can be used to put a model entry prefs into cloud storage.
  /// * Should be used in a try catch block.
  Future<void> putSelfSharedModelEntryPrefs({required User user, required String modelEntryId, required ModelEntryPrefs modelEntryPrefs, required bool? isSelfDefault}) async {
    // Create ModelEntry JSON.
    final Map<String, dynamic> body = modelEntryPrefs.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointModelEntries,
      action: ApiPaths.actionPrefs,
      id: modelEntryId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'is_self_default': isSelfDefault.toString(),
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> putSelfSharedModelEntryPrefs()',
    );
  }

  // #####################################
  // Model Entries
  // #####################################

  /// This method can be used to create a new ```ModelEntry``` in the cloud.
  /// * Should be used in a try catch block.
  Future<ModelEntry> createSharedModelEntry({required User user, required ModelEntry modelEntry}) async {
    // Create ModelEntry JSON.
    final Map<String, dynamic> modelEntryJSON = modelEntry.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointModelEntries,
      action: ApiPaths.actionCreate,
    );

    // * Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(modelEntryJSON),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> createSharedModelEntry()',
    );

    // Create updated ModelEntry.
    final ModelEntry createdModelEntry = modelEntry.copyWith(
      modelEntryId: data['model_entry_id'],
    );

    return createdModelEntry;
  }

  /// This method can be used to edit a ```ModelEntry``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> editSharedModelEntry({required User user, required ModelEntry modelEntry}) async {
    // * Create ModelEntry JSON.
    final Map<String, dynamic> json = modelEntry.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointModelEntries,
      action: ApiPaths.actionEdit,
      id: modelEntry.modelEntryId,
    );

    // * Create uri.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> editSharedModelEntry()',
    );
  }

  /// This method can be used to access a  ```EntryModel``` referenced in provided location.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```modelEntryId``` was not found.
  Future<ModelEntry?> getSharedModelEntryById({required User user, required String rootGroupReference, required String modelEntryId, required String referenceType, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointModelEntries,
      action: ApiPaths.actionById,
      id: modelEntryId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedModelEntryById()',
    );

    // ModelEntry not found.
    if (data['model_entry'] == null) return null;

    // Access EntryModel.
    final ModelEntry modelEntry = ModelEntry.fromCloudObject(data['model_entry']);

    return modelEntry;
  }

  /// This method can be used to access all shared ```ModelEntries``` of a user.
  /// * Should be used in a try catch block.
  Future<ModelEntries> selfGetAllModelEntries({required User user}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointModelEntries,
      action: ApiPaths.actionSelfAll,
    );

    // Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> selfGetAllModelEntries()',
    );

    final List<dynamic> decoded = data['model_entries'];

    // Convert from JSON.
    final ModelEntries modelEntries = ModelEntries.fromCloudObject(decoded);

    return modelEntries;
  }

  /// This method can be used to access batch of shared ```ModelEntires```.
  /// * Should be used in a try catch block.
  Future<ModelEntries> getSharedModelEntriesBatch({required User user, required List<String> references, required String rootGroupReference, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointModelEntries,
      action: ApiPaths.actionGetBatch,
    );

    // Create body.
    final Map<String, dynamic> body = {
      'references': references,
    };

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedModelEntriesBatch()',
    );

    // Convert from JSON.
    final ModelEntries modelEntries = ModelEntries.fromCloudObject(data['model_entries']);

    return modelEntries;
  }

  /// This method can be used to delete a shared ```ModelEntry```.
  /// * Should be used in a try cach block.
  Future<void> deleteSharedModelEntry({required User user, required ModelEntry modelEntry}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointModelEntries,
      action: ApiPaths.actionById,
      id: modelEntry.modelEntryId,
    );

    // Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> deleteSharedModelEntry()',
    );
  }

  // #####################################
  // Groups
  // #####################################

  /// This method can be used to create a ```Group``` in the cloud.
  /// * Should be used in a try catch block.
  /// * Returns the ```id``` of the created group.
  Future<String> createSharedGroup({required User user, required Group group}) async {
    // * Create Group JSON.
    final Map<String, dynamic> json = group.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionCreate,
    );

    // * Create uri.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> createSharedGroup()',
    );

    return data['group_id'];
  }

  /// This method can be used to create a ```Subggroup``` in the cloud.
  /// * Should be used in a try catch block.
  /// * Returns the ```id``` of the created group.
  Future<String> createSharedSubgroup({required User user, required Group group}) async {
    // * Create Group JSON.
    final Map<String, dynamic> json = group.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointSubgroups,
      action: ApiPaths.actionCreate,
    );

    // * Create uri.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> createSharedSubgroup()',
    );

    return data['group_id'];
  }

  /// This method can be used to edit a shared ```Group```.
  /// * Should be used in a try catch block.
  Future<void> editSharedGroup({required User user, required Group group}) async {
    // * Create Group JSON.
    final Map<String, dynamic> json = group.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionEdit,
      id: group.groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': group.rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> editSharedGroup()',
    );
  }

  /// This method can be used to edit a shared ```Subgroup```.
  /// * Should be used in a try catch block.
  Future<void> editSharedSubgroup({required User user, required Group group}) async {
    // * Create Group JSON.
    final Map<String, dynamic> json = group.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointSubgroups,
      action: ApiPaths.actionEdit,
      id: group.groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': group.rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> editSharedSubgroup()',
    );
  }

  /// This method can be used to delete a ```Group``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> deleteSharedGroup({required User user, required Group group}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionById,
      id: group.groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': group.rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> deleteSharedGroup()',
    );
  }

  /// This method can be used to delete a ```Subgroup``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> deleteSharedSubgroup({required User user, required Group group}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointSubgroups,
      action: ApiPaths.actionById,
      id: group.groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': group.rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> deleteSharedSubgroup()',
    );
  }

  /// This method can be used to fetch all ```Groups``` a user is in.
  /// * Should be used in a try catch block.
  Future<Groups> getSelfAllSharedTopLevelGroups({required User user}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionSelfAll,
    );

    // Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getAllSharedTopLevelGroups()',
    );

    final List<dynamic> decoded = data['groups'];

    // Convert from JSON.
    final Groups groups = Groups.fromCloudObject(decoded);

    return groups;
  }

  /// This method can be used to insert a ```Group``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> addCloudEntryToCloudGroup({required User user, required String groupId, required String accessKey, required String entryId}) async {
    // * Create body.
    final Map<String, dynamic> json = {'entry_id': entryId};

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionAddEntry,
      id: groupId,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Access-Key': accessKey,
      },
      body: jsonEncode(json),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> addCloudEntryToCloudGroup()',
    );

    // Decode response data.
    final bool _ = data['success'];
  }

  /// This method can be used to validate a group invite to a cloud group.
  /// * Should be used in a try catch block.
  Future<Group> validateSharedGroupInvite({required User user, required String groupId, required String accessPin}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionValidateInvite,
      id: groupId,
    );

    // Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Access-Pin': accessPin,
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> validateCloudGroupInvite()',
    );

    // Parse group.
    final Group group = Group.fromCloudObject(data['group']);

    return group;
  }

  /// This method can be used to join a shared group.
  /// * Should be used in a try catch block.
  Future<void> joinSharedGroup({required User user, required String groupId, required String accessPin}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionJoin,
      id: groupId,
    );

    // Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Access-Pin': accessPin,
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> joinCloudGroup()',
    );

    // Decode data.
    final bool _ = data['group_joined'];
  }

  /// This method can be used to leave a shared group.
  Future<void> leaveSharedGroup({required User user, required Group group}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionLeave,
      id: group.groupId,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> leaveSharedGroup()',
    );
  }

  /// This method can be used to get a ```Group``` from the cloud.
  /// * Should be used in a try catch block.
  Future<Group> getSharedGroupById({required User user, required String groupId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionById,
      id: groupId,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedGroupById()',
    );

    // Parse group.
    final Group group = Group.fromCloudObject(data['group']);

    return group;
  }

  /// This method can be used to get a shared ```Subgroup```.
  /// * Should be used in a try catch block.
  Future<Group> getSharedSubgroupById({required User user, required String rootGroupReference, required String subgroupId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointSubgroups,
      action: ApiPaths.actionById,
      id: subgroupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedSubgroupById()',
    );

    // Parse group.
    final Group group = Group.fromCloudObject(data['group']);

    return group;
  }

  /// This method can be used to access all subgroups of a group.
  /// * Should be used in a try catch block.
  Future<Groups> getSharedSubgroupsOfGroup({required User user, required String groupId, required String rootGroupReference}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointSubgroups,
      action: ApiPaths.actionAllOf,
      id: groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedSubgroups()',
    );

    final List<dynamic> decoded = data['subgroups'];

    // Convert from JSON.
    final Groups groups = Groups.fromCloudObject(decoded);

    return groups;
  }

  /// This method can be used to get group details by its alias.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getSharedGroupByAlias({required User user, required String alias}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionAlias,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'alias': alias,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedGroupByAlias()',
    );

    return data;
  }

  /// this method can be used to get the Entries count for a Group.
  /// * Should be used in a try catch block.
  Future<int> getCloudGroupEntriesCount({required User user, required String groupId, required String accessKey, required String accessPin}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionCountEntries,
      id: groupId,
    );

    // Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Access-Key': accessKey,
        'Reference-Access-Pin': accessPin,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getCloudGroupEntriesCount()',
    );

    // Parse data.
    final int entriesCount = data['entries_count'];

    return entriesCount;
  }

  /// This method can be used to ban a cloud user from a shared group.
  Future<void> banUserFromSharedGroup({required User user, required String bannedUserId, required String rootGroupReference, required String groupId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionBan,
      id: groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'referenced_user_id': bannedUserId,
      'root_group_reference': rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> banUserFromSharedGroup()',
    );
  }

  /// This method can be used to revoke a ban from a shared group.
  Future<void> revokeBanFromSharedGroup({required User user, required String bannedUserId, required String rootGroupReference, required String groupId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionRevokeBan,
      id: groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'referenced_user_id': bannedUserId,
      'root_group_reference': rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> revokeBanFromSharedGroup()',
    );
  }

  /// This method can be used to get an indication about whether or not a user is banned.
  /// * Should be used in a try catch block.
  Future<bool> getUserIsBanned({required User user, required String rootGroupReference, required String groupId, required String referencedUserId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionIsBanned,
      id: groupId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'referenced_user_id': referencedUserId,
      'root_group_reference': rootGroupReference,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getUserIsBanned()',
    );

    return data['is_banned'];
  }

  /// This method can be used to get an indication about how many exports a user has left this month.
  /// * Should be used in a try catch block.
  Future<int> getAvailableExports({required User user}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointAuth,
      action: ApiPaths.actionAvailableExports,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getAvailableExports()',
    );

    return data['exports'];
  }

  /// This method can be used to change the number of available exports.
  /// * Should be used in a try catch block.
  /// * Returns the currently available exports.
  Future<int> decrementAvailableSharedExports({required User user, required int amount}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointAuth,
      action: ApiPaths.actionDecrementAvailableExports,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'amount': amount.toString(),
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> decrementAvailableSharedExports()',
    );

    return data['exports'];
  }

  // ###########################################
  // # Shared Charts
  // ###########################################

  /// This method can be used to access initial charts data of a shared group.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getSharedGroupGetInitialChartsData({required User user, required Group group}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointCharts,
      action: ApiPaths.actionInitial,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': group.rootGroupReference,
      'group_id': group.groupId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedGroupGetInitialChartsData()',
    );

    // Decode model entries.
    final ModelEntries modelEntriesOfGroup = ModelEntries.fromCloudObject(data["model_entries"]);

    // Decode utilized field identifications.
    final FieldIdentifications fieldIdentifications = await modelEntriesOfGroup.getFieldIdentificationsBatch(
      fieldIds: List<String>.from(data["utilized_field_ids"]),
    );

    // Decode utilized measurements.
    final Map<String, Measurements> measurements = Measurements.parseMeasurementsByFieldId(
      data["measurements"],
    );

    // Decode total entries count.
    final int totalEntries = data["total_entries"];

    return {
      'model_entries': modelEntriesOfGroup,
      'field_identifications': fieldIdentifications,
      'measurements': measurements,
      'total_entries': totalEntries,
    };
  }

  /// This method can be used to access chart items of a shared chart.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getSharedChartItems({required User user, required Group group, required Chart chart, required String? descriptiveValueInstruction, required String requestId, required String lastEntryId}) async {
    // Convert chart to cloud object.
    final Map<String, dynamic> body = chart.toCloudObject(descriptiveValueInstruction: descriptiveValueInstruction);

    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointCharts,
      action: ApiPaths.actionItems,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': group.rootGroupReference,
      'group_id': group.groupId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
        'Request-ID': requestId,
        'Last-Entry-ID': lastEntryId,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedChartItems()',
    );

    return data;
  }

  /// This method can be used to access creditors debitors of a shared group.
  /// * Should be used in a try catch block.
  Future<dynamic> getPaymentDataCreditorsDebitors({required User user, required Group group, required String filterByFieldId, required DateTime? filterByYear, required bool showAllTransactions, required String requestId, required String lastEntryId}) async {
    // Convert chart to cloud object.
    final Map<String, dynamic> body = {
      'filter_by_year': filterByYear?.year.toString() ?? "",
      'filter_by_field_id': filterByFieldId,
      "show_all_transactions": showAllTransactions,
    };

    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointCharts,
      action: ApiPaths.actionCreditorsDebitors,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': group.rootGroupReference,
      'group_id': group.groupId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
        'Request-ID': requestId,
        'Last-Entry-ID': lastEntryId,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getPaymentDataCreditorsDebitors()',
    );

    return data;
  }

  // #####################################
  // Model Entry Prefs
  // #####################################

  /// This method can be used to put group prefs into cloud storage.
  /// * Should be used in a try catch block.
  Future<void> putSelfSharedGroupPrefs({required User user, required String groupId, required GroupPrefs groupPrefs}) async {
    // Create JSON.
    final Map<String, dynamic> body = groupPrefs.toCloudObject();

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointGroups,
      action: ApiPaths.actionPrefs,
      id: groupId,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> putSelfSharedGroupPrefs()',
    );
  }

  // #####################################
  // Participant
  // #####################################

  /// This method can be used to store ```Participant``` and associated ```Members``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> createSharedParticipantAndMembers({required User user, required Participant participant, required Members members}) async {
    // Create Participant JSON.
    final Map<String, dynamic> participantJSON = participant.toCloudObject();

    // Create Members JSON.
    final List<Map<String, dynamic>> membersJSON = members.toCloudObject();

    // Create body.
    final Map<String, dynamic> body = {
      'participant': participantJSON,
      'members': membersJSON,
    };

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointParticipants,
      action: ApiPaths.actionCreate,
      id: participant.participantId,
    );

    // * Create uri.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> createSharedParticipantAndMembers()',
    );
  }

  /// This method can be used to edit a
  /// * Should be used in a try catch block.
  Future<void> editSharedParticipantAndMembers({required User user, required String participantId, required Participant? editedParticipant, required Members removedMembers, required Members addedMembers, required Members editedMembers}) async {
    // Create Participant JSON.
    final Map<String, dynamic> participantJSON = editedParticipant?.toCloudObject() ?? {};

    // Create removed Members JSON.
    final List<Map<String, dynamic>> removedMembersJSON = removedMembers.toCloudObject();

    // Create added Members JSON.
    final List<Map<String, dynamic>> addedMembersJSON = addedMembers.toCloudObject();

    // Create edited Members JSON.
    final List<Map<String, dynamic>> editedMembersJSON = editedMembers.toCloudObject();

    // Create body.
    final Map<String, dynamic> body = {
      'participant': participantJSON,
      'removed_members': removedMembersJSON,
      'added_members': addedMembersJSON,
      'edited_members': editedMembersJSON,
    };

    // * Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointParticipants,
      action: ApiPaths.actionEdit,
      id: participantId,
    );

    // * Create uri.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> editSharedParticipantAndMembers()',
    );
  }

  /// This method can be used to access a  ```Participant``` referenced in provided location.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```participantId``` was not found.
  Future<Participant?> getSharedParticipantById({required User user, required String participantId, required String referenceType, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointParticipants,
      action: ApiPaths.actionById,
      id: participantId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedParticipantById()',
    );

    // Participant not found.
    if (data['participant'] == null) return null;

    // Access Participant.
    final Participant participant = Participant.fromCloudObject(data['participant']);

    return participant;
  }

  /// This method can be used to access ```Members``` of a specified ```Participant```.
  /// * Should be used in a try catch block.
  /// * Returns ```Members.initial()``` if ```Participant``` could not be found.
  Future<Members> getSharedMembersOfParticipant({required User user, required String participantId, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointParticipants,
      action: ApiPaths.actionMembers,
      id: participantId,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedMembersOfParticipant()',
    );

    // Access Members.
    final Members members = Members.fromCloudObject(data['members']);

    return members;
  }

  /// This method can be used to access all shared Participants of a self user.
  /// * Should be used in a try catch block.
  Future<Participants> getSelfSharedParticipants({required User user}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointParticipants,
      action: ApiPaths.actionSelfAll,
    );

    // Create url.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSelfSharedParticipants()',
    );

    final List<dynamic> decoded = data['participants'];

    // Convert from JSON.
    final Participants participants = Participants.fromCloudObject(decoded);

    return participants;
  }

  // #####################################
  // Members
  // #####################################

  /// This method can be used to access all shared members of self user.
  /// * Should be used in a try catch block.
  Future<Members> getSelfAllMembers({required User user}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointMembers,
      action: ApiPaths.actionSelfAll,
    );

    // Create baseUrl.
    final Uri url = Uri.parse(path);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSelfAllMembers()',
    );

    final List<dynamic> decoded = data['members'];

    // Convert from JSON.
    final Members members = Members.fromCloudObject(decoded);

    return members;
  }

  /// This method can be used to access all shared members of a shared reference of a self user.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```referenceId``` was not found.
  Future<Members?> getSelfMembersOfReference({required User user, required String referenceType, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointMembers,
      action: ApiPaths.actionSelfAllOf,
    );

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSelfMembersOfReference()',
    );

    // Reference not found.
    if (data['members'] == null) return null;

    // Access Members.
    final Members members = Members.fromCloudObject(data['members']);

    return members;
  }

  /// This method can be used to access specified batch of shared members.
  /// * Should be used in a try catch block.
  Future<Members> getSharedMembersBatch({required User user, required List<String> references, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // Get path.
    final String path = ApiPaths.buildEndpoint(
      baseEndpoint: ApiPaths.baseEndpointMembers,
      action: ApiPaths.actionGetBatch,
    );

    // Create body.
    final Map<String, dynamic> body = {
      'references': references,
    };

    // Create baseUrl.
    final Uri baseUrl = Uri.parse(path);

    // Define the query parameters as a map
    final Map<String, dynamic> queryParameters = {
      'root_group_reference': rootGroupReference,
      'reference_type': referenceType,
      'reference_id': referenceId,
    };

    // Create the complete URL with query parameters
    final Uri url = baseUrl.replace(queryParameters: queryParameters);

    // Conduct API call.
    final http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user.tokens.accessToken}',
        'Reference-Device-Identity': user.tokens.deviceIdentity,
      },
      body: jsonEncode(body),
    );

    // Parse response into map. Throws failure on error.
    final Map<String, dynamic> data = ApiHelpers.parseResponse(
      response: response,
      origin: 'ApiRepository --> getSharedMembersBatch()',
    );

    // Convert from JSON.
    final Members members = Members.fromCloudObject(data['members']);

    return members;
  }
}
