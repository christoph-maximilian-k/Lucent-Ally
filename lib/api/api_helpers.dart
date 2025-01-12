import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Models.
import '/data/models/failure.dart';

/// This class holds methods to interact with backend.
class ApiHelpers {
  /// Method to parse a [http.Response] into data.
  /// - Returns ```jsonDecode(response.body)``` on success
  /// - Should be used in a try catch block
  static Map<String, dynamic> parseResponse({required http.Response response, required String origin}) {
    // Check for internal server error
    if (response.statusCode == 500) {
      // Output debug messages.
      debugPrint('$origin --> parseResponse --> internal server error.');

      // Show error to user.
      throw Failure.getApiFailureByCode(code: 'EAPI0001');
    }

    // Check that a response body was set.
    if (response.body.isEmpty) {
      // Output debug messages.
      debugPrint('$origin --> parseResponse --> response body is empty.');

      // Show error to user.
      throw Failure.getApiFailureByCode(code: 'EAPI0002');
    }

    // Parse response into map.
    final Map<String, dynamic> data = jsonDecode(response.body);

    // Check if request contains error type.
    if (data.containsKey('error_code')) {
      // Output debug messages.
      debugPrint('$origin --> parseResponse --> response has error_code ${data['error_code']} set.');

      // Output some more debug messages.
      debugPrint('$origin --> parseResponse --> response error details: ${data['errors']['details']}');

      // Check locally for translated failure.
      throw Failure.getApiFailureByCode(code: data['error_code']);
    }

    // If response indicates unauthorized, let user know.
    if (response.statusCode >= 400 && response.statusCode < 500) {
      // Show error to user.
      throw Failure.getApiFailureByCode(code: 'EAPI0006');
    }

    // If response indicates success, return data.
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    // Output debug messages.
    debugPrint('$origin --> parseResponse --> unknown status code: ${response.statusCode}');

    // Output some more debug messages.
    debugPrint('data of unknown response: ${data.toString()}');

    // An unexpected error occurred, display a default message if it does not find a corresponding error code.
    throw Failure.getApiFailureByCode(code: 'EAPI0003');
  }
}
