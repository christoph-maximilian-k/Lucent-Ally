import 'dart:convert';

import 'package:equatable/equatable.dart';

class Secrets extends Equatable {
  final String localGroupsEncryptionKey;

  const Secrets({
    required this.localGroupsEncryptionKey,
  });

  @override
  List<Object> get props => [localGroupsEncryptionKey];

  /// This constant stores the native storage key for first app launch indication.
  static const String mapKeyFirstAppLaunch = 'first_app_launch';

  /// This constant stores the native storage key for `localGroupsEncryptionKey`.
  static const String mapKeyLocalGroupsEncryptionKey = 'local_groups_encryption_key';

  /// This constant stores the native storage key for app password.
  /// * This value should never be in state. Instead always access it directly and compare it without saveing it into a variable.
  static const String mapKeyAppPassword = 'app_password';

  /// This constant stores the native storage key for the number of failed attempts.
  static const String mapKeyFailedAttempts = 'failed_attempts';

  /// This constant stores the native storage key for the lockout time if to many invalid password attempts were made.
  static const String mapKeyLockoutTime = 'lockout_time';

  /// This constant stores the native storage key for the language locale
  static const String mapKeyLanguageLocale = 'language_locale';

  /// This constant stores the native storage key for the app theme.
  static const String mapKeyAppTheme = 'theme';

  /// This constant stores the native storage key for the auto logout time in minutes.
  static const String mapKeyAutoLogoutInMinutes = 'auto_logout_in_minutes';

  /// This constant stores the native storage key for the user object.
  static const String mapKeyUser = 'user';

  /// Initialize a new ```Tokens``` object.
  factory Secrets.initial() {
    return const Secrets(
      localGroupsEncryptionKey: '',
    );
  }

  /// This getter can be used to check if secrets are valid.
  bool get getSecretsAreValid {
    if (base64.decode(localGroupsEncryptionKey).length != 32) return false;

    return true;
  }

  Secrets copyWith({
    String? localGroupsEncryptionKey,
  }) {
    return Secrets(
      localGroupsEncryptionKey: localGroupsEncryptionKey ?? this.localGroupsEncryptionKey,
    );
  }
}
