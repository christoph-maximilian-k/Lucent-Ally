import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class InviteSpecs extends Equatable {
  final int? usageLimit;
  final DateTime? expirationDateInUtc;

  const InviteSpecs({
    required this.usageLimit,
    required this.expirationDateInUtc,
  });

  @override
  List<Object?> get props => [usageLimit, expirationDateInUtc];

  /// Initialize a new `InviteSpecs` object.
  factory InviteSpecs.initial() {
    return InviteSpecs(
      usageLimit: null,
      expirationDateInUtc: null,
    );
  }

  // #################################################
  // Getters
  // #################################################

  /// This getter can be used to access date expirationDateInUtc as string.
  /// * assumes ```expirationDateInUtc != null```
  /// ```dart
  /// return DateFormat('yyyy-MM-dd HH:mm').format(expirationDateInUtc!.toLocal());
  /// ```
  String get getFormattedDate {
    return DateFormat('yyyy-MM-dd HH:mm').format(expirationDateInUtc!.toLocal());
  }

  // #################################################
  // Cloud
  // #################################################

  /// Encode a `Member` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'limit': usageLimit,
      'expires_at_in_utc': expirationDateInUtc?.toIso8601String(),
    };
  }

  /// Encode a `InviteSpecs` object from JSON.
  static InviteSpecs fromCloudObject(data) {
    return InviteSpecs(
      usageLimit: data['limit'],
      expirationDateInUtc: data['expires_at_in_utc'] == null ? null : DateTime.parse(data['expires_at_in_utc']),
    );
  }

  // #################################################
  // Copy With
  // #################################################

  InviteSpecs copyWith({
    int? usageLimit,
    DateTime? expirationDateInUtc,
  }) {
    return InviteSpecs(
      usageLimit: usageLimit ?? this.usageLimit,
      expirationDateInUtc: expirationDateInUtc ?? this.expirationDateInUtc,
    );
  }
}
