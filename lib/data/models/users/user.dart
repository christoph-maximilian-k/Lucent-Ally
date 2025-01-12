import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Current user.
import '/main.dart';

// Schemas.
import '/data/models/users/schemas/db_user.dart';

// Models.
import '/data/models/labels/labels.dart';
import '/data/models/tokens/tokens.dart';
import '/data/models/settings/settings.dart';
import '/data/models/password_generator/password_generator.dart';
import '/data/models/themes/themes.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class User extends Equatable {
  // ###########################
  // Shared Prefs variables
  // ###########################

  final String theme;
  final String languageLocale;
  final int autoLogoutInMinutes;

  // ###########################
  // Secure storage variables
  // ###########################

  final String userId;

  final bool isCloudUser;

  final DateTime createdAtInUtc;

  final int databaseVersion;

  final String username;
  final String userEmail;

  final bool localGroupsPasswordSet;
  final Tokens tokens;

  // ###########################
  // Isar database variables
  // ###########################

  final DateTime editedAtInUtc;
  final DateTime interactedAtInUtc;

  final Settings settings;
  final PasswordGenerator passwordGenerator;

  // ###########################
  // State variables
  // ###########################

  final Labels labels;

  const User({
    required this.theme,
    required this.languageLocale,
    required this.autoLogoutInMinutes,
    required this.userId,
    required this.isCloudUser,
    required this.databaseVersion,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.interactedAtInUtc,
    required this.username,
    required this.userEmail,
    required this.tokens,
    required this.settings,
    required this.localGroupsPasswordSet,
    required this.passwordGenerator,
    required this.labels,
  });

  @override
  List<Object> get props => [
        theme,
        languageLocale,
        autoLogoutInMinutes,
        userId,
        isCloudUser,
        databaseVersion,
        createdAtInUtc,
        editedAtInUtc,
        interactedAtInUtc,
        username,
        userEmail,
        tokens,
        settings,
        localGroupsPasswordSet,
        passwordGenerator,
        labels,
      ];

  /// Theme identification for dark theme.
  /// ```dart
  /// static const String themeDark = 'dark';
  /// ```
  static const String themeDark = 'dark';

  /// Theme identification for light theme.
  /// ```dart
  /// static const String themeLight = 'light';
  /// ```
  static const String themeLight = 'light';

  /// This list represents supported languages.
  /// ```dart
  /// static const List<String> supportedLanguages = ['en', 'de'];
  /// ```
  static const List<String> supportedLanguages = ['en', 'de'];

  /// This list represents available auto logout values in minutes.
  /// ```dart
  /// static const List<int> autoLogoutsInMinutes = [2, 5, 10, 15, 20, 30, 60];
  /// ```
  static const List<int> autoLogoutsInMinutes = [2, 5, 10, 15, 20, 30, 60];

  /// Initialize a new ```User``` object.
  factory User.initial() {
    // Init now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    return User(
      theme: themeDark,
      languageLocale: 'en',
      autoLogoutInMinutes: 10,
      userId: '',
      isCloudUser: false,
      databaseVersion: 1,
      username: '',
      userEmail: '',
      tokens: Tokens.initial(),
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      interactedAtInUtc: nowInUtc,
      settings: Settings.initial(),
      localGroupsPasswordSet: false,
      passwordGenerator: PasswordGenerator.initial(),
      labels: Labels(languageLocale: 'en'),
    );
  }

  /// This getter can be used to indicate which theme is currently active.
  bool get isLightTheme {
    if (theme == themeLight) return true;
    return false;
  }

  /// This method can be used to access currently selected theme.
  ThemeData getTheme({required Size screenSize}) {
    if (theme == themeDark) return Themes.darkTheme(screenSize: screenSize).getTheme;

    return Themes.lightTheme(screenSize: screenSize).getTheme;
  }

  /// This method can be used to access currently selected SystemOverlayStyle.
  SystemUiOverlayStyle getSystemUiOverlayStyle({required Size screenSize}) {
    if (theme == themeDark) return Themes.darkTheme(screenSize: screenSize).getSystemUiOverlayStyle(isDark: true);

    return Themes.lightTheme(screenSize: screenSize).getSystemUiOverlayStyle(isDark: false);
  }

  /// This method can be used access [supportedLanguages] as [PickerItems]
  static PickerItems supportedLanguagesPickerItems({required Labels labels}) {
    // Create helper list.
    List<PickerItem> list = [];

    for (final String languageLocale in supportedLanguages) {
      // Create PickerItem.
      final PickerItem pickerItem = PickerItem.initial().copyWith(
        id: languageLocale,
        label: labels.settingsSheetLanguagePickerLabel(locale: languageLocale),
      );

      // Add to list.
      list.add(pickerItem);
    }

    return PickerItems(items: list);
  }

  /// This method can be used access [autoLogoutsInMinutes] as [PickerItems]
  static PickerItems autoLogoutPickerItems({required Labels labels}) {
    // Create helper list.
    List<PickerItem> list = [];

    for (final int minute in autoLogoutsInMinutes) {
      // Create PickerItem.
      final PickerItem pickerItem = PickerItem.initial().copyWith(
        id: minute.toString(),
        label: labels.settingsSheetAutoLogoutPickerLabel(autoLogoutInMinutes: minute),
      );

      // Add to list.
      list.add(pickerItem);
    }

    return PickerItems(items: list);
  }

  // ######################################
  // Native Secure Storage.
  // ######################################

  /// This method returns a map which contains values that should be stored in native secure storage.
  Map<String, dynamic> toSecureStorage() {
    return {
      'user_id': userId,
      'is_cloud_user': isCloudUser,
      'user_identity': tokens.userIdentity,
      'device_identity': tokens.deviceIdentity,
      'user_permission': tokens.userPermission,
      'created_at': createdAtInUtc.toIso8601String(),
      'database_version': databaseVersion,
      'access_token': tokens.accessToken,
      'access_token_expires_at': tokens.accessTokenExpiresAtInUtc?.toIso8601String() ?? '',
      'refresh_token': tokens.refreshToken,
      'refresh_token_expires_at': tokens.refreshTokenExpiresAtInUtc?.toIso8601String() ?? '',
      'user_name': username,
      'user_email': userEmail,
      'local_groups_password_set': localGroupsPasswordSet,
    };
  }

  /// This method can be used to create a user based on the data returned from native key store.
  static User fromSecureStorage({required Map<String, dynamic> secureStorageData}) {
    return User(
      // * These values are retrieved from SharedPreferences.
      theme: '',
      languageLocale: '',
      autoLogoutInMinutes: 0,
      // * These values are retrieved from secure native storage.
      userId: secureStorageData['user_id'],
      isCloudUser: secureStorageData['is_cloud_user'],
      databaseVersion: secureStorageData['database_version'],
      createdAtInUtc: DateTime.parse(secureStorageData['created_at']),
      editedAtInUtc: DateTime.now().toUtc(), // * This value will be overwritten later.
      interactedAtInUtc: DateTime.now().toUtc(), // * This value will be overwritten later.
      username: secureStorageData['user_name'],
      userEmail: secureStorageData['user_email'],
      localGroupsPasswordSet: secureStorageData['local_groups_password_set'],
      tokens: Tokens(
        userPermission: secureStorageData['user_permission'],
        userIdentity: secureStorageData['user_identity'],
        deviceIdentity: secureStorageData['device_identity'],
        accessToken: secureStorageData['access_token'],
        accessTokenExpiresAtInUtc: DateTime.tryParse(secureStorageData['access_token_expires_at']),
        refreshToken: secureStorageData['refresh_token'],
        refreshTokenExpiresAtInUtc: DateTime.tryParse(secureStorageData['refresh_token_expires_at']),
      ),
      // * These values are retrieved from local storage.
      settings: Settings.initial(),
      passwordGenerator: PasswordGenerator.initial(),
      // * These variables are state variables.
      labels: Labels(languageLocale: 'en'),
    );
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```User``` object to a ```DbUser``` object.
  DbUser toSchema() {
    return DbUser(
      userId: userId,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
      interactedAtInUtc: interactedAtInUtc.millisecondsSinceEpoch,
      settings: settings.toSchema(),
      passwordGenerator: passwordGenerator.toSchema(),
    );
  }

  /// Convert a ```DbUser``` object to a ```User``` object.
  static User fromSchema({required User fromNativeKeystore, required DbUser schema}) {
    return fromNativeKeystore.copyWith(
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
      interactedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.interactedAtInUtc, isUtc: true),
      settings: Settings.fromSchema(schema: schema.settings),
      passwordGenerator: PasswordGenerator.fromSchema(schema: schema.passwordGenerator),
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```User``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'user_id': userId,
      'user_identity': tokens.userIdentity,
      'device_identity': tokens.deviceIdentity,
      'local_created_at_in_utc': createdAtInUtc.toIso8601String(),
    };
  }

  /// Decode a ```User``` object from JSON.
  static User fromCloudObject(data) {
    return user.copyWith(
      userId: data['user']['identification']['id'] ?? user.userId,
      username: data['user']['identification']['username'] ?? user.username,
      userEmail: data['user']['identification']['user_email'] ?? user.userEmail,
      tokens: Tokens.fromCloudObject(data['user']['tokens']),
    );
  }

  // ######################################
  // Copy With
  // ######################################

  User copyWith({
    String? theme,
    String? languageLocale,
    int? autoLogoutInMinutes,
    String? userId,
    bool? isCloudUser,
    DateTime? createdAtInUtc,
    int? databaseVersion,
    String? username,
    String? userEmail,
    bool? localGroupsPasswordSet,
    Tokens? tokens,
    DateTime? editedAtInUtc,
    DateTime? interactedAtInUtc,
    Settings? settings,
    PasswordGenerator? passwordGenerator,
    Labels? labels,
  }) {
    return User(
      theme: theme ?? this.theme,
      languageLocale: languageLocale ?? this.languageLocale,
      autoLogoutInMinutes: autoLogoutInMinutes ?? this.autoLogoutInMinutes,
      userId: userId ?? this.userId,
      isCloudUser: isCloudUser ?? this.isCloudUser,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      databaseVersion: databaseVersion ?? this.databaseVersion,
      username: username ?? this.username,
      userEmail: userEmail ?? this.userEmail,
      localGroupsPasswordSet: localGroupsPasswordSet ?? this.localGroupsPasswordSet,
      tokens: tokens ?? this.tokens,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
      interactedAtInUtc: interactedAtInUtc ?? this.interactedAtInUtc,
      settings: settings ?? this.settings,
      passwordGenerator: passwordGenerator ?? this.passwordGenerator,
      labels: labels ?? this.labels,
    );
  }
}
