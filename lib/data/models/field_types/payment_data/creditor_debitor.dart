import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Models.
import '/data/models/members/member.dart';

class CreditorDebitor extends Equatable {
  final String id;
  final Member creditor;
  final Member debitor;
  final double value;

  const CreditorDebitor({
    required this.id,
    required this.creditor,
    required this.debitor,
    required this.value,
  });

  @override
  List<Object> get props => [id, creditor, debitor, value];

  /// Initialize a new ```CreditorDebitor``` object.
  factory CreditorDebitor.initial() {
    return CreditorDebitor(
      id: const Uuid().v4(),
      creditor: Member.initial(),
      debitor: Member.initial(),
      value: 0.0,
    );
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode a ```CreditorDebitor``` from request JSON.
  static CreditorDebitor fromCloudObject(data) {
    return CreditorDebitor(
      id: data["id"],
      creditor: Member.fromCloudObject(data["creditor"]),
      debitor: Member.fromCloudObject(data["debitor"]),
      value: data["value"],
    );
  }

  CreditorDebitor copyWith({
    String? id,
    Member? creditor,
    Member? debitor,
    double? value,
  }) {
    return CreditorDebitor(
      id: id ?? this.id,
      creditor: creditor ?? this.creditor,
      debitor: debitor ?? this.debitor,
      value: value ?? this.value,
    );
  }
}
