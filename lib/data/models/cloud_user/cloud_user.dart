import 'package:equatable/equatable.dart';

// User.
import '/main.dart';

class CloudUser extends Equatable {
  final String userId;

  final DateTime? createdAt;
  final DateTime? lastOnline;

  final String username;
  final String userEmail;
  final String phoneNumber;
  final bool hasVerifiedIdentity;
  final String avatarImageUrl;
  final String role;

  const CloudUser({
    required this.userId,
    required this.createdAt,
    required this.lastOnline,
    required this.username,
    required this.hasVerifiedIdentity,
    required this.userEmail,
    required this.phoneNumber,
    required this.avatarImageUrl,
    required this.role,
  });

  @override
  List<Object?> get props => [
        userId,
        createdAt,
        lastOnline,
        username,
        userEmail,
        hasVerifiedIdentity,
        phoneNumber,
        avatarImageUrl,
        role,
      ];

  /// Initialize a new ```CloudUser``` object.
  factory CloudUser.initial() {
    return CloudUser(
      avatarImageUrl: '',
      createdAt: null,
      hasVerifiedIdentity: false,
      lastOnline: null,
      phoneNumber: '',
      role: '',
      userEmail: '',
      userId: '',
      username: '',
    );
  }

  /// Initialize a new ```CloudUser``` object.
  factory CloudUser.self() {
    return CloudUser(
      avatarImageUrl: '',
      createdAt: null,
      hasVerifiedIdentity: false,
      lastOnline: null,
      phoneNumber: '',
      role: '',
      userEmail: user.userEmail,
      userId: user.userId,
      username: user.username,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Decode a ```User``` object from JSON.
  static CloudUser fromCloudObject(data) {
    return CloudUser(
      userId: data['user_id'] ?? '',
      createdAt: data['created_at'] != null ? DateTime.parse(data['created_at']) : null,
      lastOnline: data['last_online'] != null ? DateTime.parse(data['last_online']) : null,
      username: data['user_name'] ?? '',
      userEmail: data['user_email'] ?? '',
      avatarImageUrl: data['avatar_image_url'] ?? '',
      hasVerifiedIdentity: data['has_verified_identity'] ?? false,
      phoneNumber: data['phone_number'] ?? '',
      role: data['role'] ?? '',
    );
  }

  // ######################################
  // Copy With
  // ######################################

  CloudUser copyWith({
    String? userId,
    DateTime? createdAt,
    DateTime? lastOnline,
    String? username,
    String? userEmail,
    String? phoneNumber,
    bool? hasVerifiedIdentity,
    String? avatarImageUrl,
    String? role,
  }) {
    return CloudUser(
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      lastOnline: lastOnline ?? this.lastOnline,
      username: username ?? this.username,
      userEmail: userEmail ?? this.userEmail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      hasVerifiedIdentity: hasVerifiedIdentity ?? this.hasVerifiedIdentity,
      avatarImageUrl: avatarImageUrl ?? this.avatarImageUrl,
      role: role ?? this.role,
    );
  }
}
