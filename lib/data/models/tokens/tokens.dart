import 'package:equatable/equatable.dart';

// Current user.
import '/main.dart';

class Tokens extends Equatable {
  final String userIdentity;
  final String deviceIdentity;
  final String userPermission;

  final String accessToken;
  final DateTime? accessTokenExpiresAtInUtc;

  final String refreshToken;
  final DateTime? refreshTokenExpiresAtInUtc;

  const Tokens({
    required this.userPermission,
    required this.userIdentity,
    required this.deviceIdentity,
    required this.accessToken,
    required this.accessTokenExpiresAtInUtc,
    required this.refreshToken,
    required this.refreshTokenExpiresAtInUtc,
  });

  @override
  List<Object?> get props => [
        userIdentity,
        deviceIdentity,
        userPermission,
        accessToken,
        accessTokenExpiresAtInUtc,
        refreshToken,
        refreshTokenExpiresAtInUtc,
      ];

  /// Initialize a new ```Tokens``` object.
  factory Tokens.initial() {
    return const Tokens(
      userIdentity: '',
      deviceIdentity: '',
      userPermission: '',
      accessToken: '',
      accessTokenExpiresAtInUtc: null,
      refreshToken: '',
      refreshTokenExpiresAtInUtc: null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```Tokens``` object to a JSON document.
  Map<String, dynamic> toCloudObject() {
    return {
      'user_identity': userIdentity,
      'device_identity': deviceIdentity,
      'user_permission': userPermission,
      'access_token': accessToken,
      if (accessTokenExpiresAtInUtc != null) 'access_token_expires_at': accessTokenExpiresAtInUtc!.toIso8601String(),
      'refresh_token': refreshToken,
      if (refreshTokenExpiresAtInUtc != null) 'refresh_token_expires_at': refreshTokenExpiresAtInUtc!.toIso8601String(),
    };
  }

  /// Decode a ```Tokens``` object from local storage.
  static Tokens fromCloudObject(document) {
    return Tokens(
      userPermission: document['user_permission'] ?? user.tokens.userPermission,
      userIdentity: document['user_identity'] ?? user.tokens.userIdentity,
      deviceIdentity: user.tokens.deviceIdentity,
      accessToken: document['access_token'] ?? user.tokens.accessToken,
      accessTokenExpiresAtInUtc: document['access_token_expires_at'] != null
          ? DateTime.parse(
              document['access_token_expires_at'],
            )
          : user.tokens.accessTokenExpiresAtInUtc,
      refreshToken: document['refresh_token'] ?? user.tokens.refreshToken,
      refreshTokenExpiresAtInUtc: document['refresh_token_expires_at'] != null
          ? DateTime.parse(
              document['refresh_token_expires_at'],
            )
          : user.tokens.refreshTokenExpiresAtInUtc,
    );
  }

  // #####################################
  // Copy With
  // #####################################

  Tokens copyWith({
    String? userIdentity,
    String? deviceIdentity,
    String? userPermission,
    String? accessToken,
    DateTime? accessTokenExpiresAtInUtc,
    String? refreshToken,
    DateTime? refreshTokenExpiresAtInUtc,
  }) {
    return Tokens(
      userIdentity: userIdentity ?? this.userIdentity,
      deviceIdentity: deviceIdentity ?? this.deviceIdentity,
      userPermission: userPermission ?? this.userPermission,
      accessToken: accessToken ?? this.accessToken,
      accessTokenExpiresAtInUtc: accessTokenExpiresAtInUtc ?? this.accessTokenExpiresAtInUtc,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenExpiresAtInUtc: refreshTokenExpiresAtInUtc ?? this.refreshTokenExpiresAtInUtc,
    );
  }
}
