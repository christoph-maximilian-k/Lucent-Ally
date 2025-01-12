import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Import labels.
import '/main.dart';

// Schemas.
import '/data/models/members/schemas/db_member.dart';

class Member extends Equatable {
  final String memberId;
  final String memberType;

  final String creator;

  final String memberName;

  final DateTime createdAtInUtc;
  final DateTime editedAtInUtc;

  const Member({
    required this.memberId,
    required this.memberType,
    required this.creator,
    required this.memberName,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
  });

  @override
  List<Object?> get props => [memberId, memberType, creator, memberName, createdAtInUtc, editedAtInUtc];

  // #################################################
  // Reference type
  // #################################################

  /// Reference identification: member.
  /// ```dart
  /// static const String referenceType = 'member';
  /// ```
  static const String referenceType = 'member';

  // #################################################
  // Member types
  // #################################################

  /// Identification for member type: none.
  /// ```dart
  /// static const String memberTypeNone = 'none';
  /// ```
  static const String memberTypeNone = 'none';

  /// Initialize a new ```Member``` object.
  factory Member.initial() {
    // Init now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    return Member(
      memberId: const Uuid().v4(),
      memberType: memberTypeNone,
      creator: '',
      memberName: '',
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
    );
  }

  /// Initialize a unknownMember ```Member``` object.
  factory Member.unknownMember({required String memberId}) {
    return Member.initial().copyWith(
      memberId: memberId,
      memberName: labels.unknownMember(),
    );
  }

  /// Initialize a deletedMember ```Member``` object.
  factory Member.deletedMember({required Member oldMember}) {
    return oldMember.copyWith(
      memberName: labels.deletedMember(),
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```Member``` object to a ```DbMember``` object.
  DbMember toSchema() {
    return DbMember(
      memberId: memberId,
      memberType: memberType,
      creator: creator,
      memberName: memberName,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
    );
  }

  /// Convert a ```DbMember``` object to a ```Member``` object.
  static Member fromSchema({required DbMember schema}) {
    return Member(
      memberId: schema.memberId,
      memberType: schema.memberType,
      creator: schema.creator,
      memberName: schema.memberName,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode a ```Member``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'member_id': memberId,
      'member_type': memberType,
      'creator': creator,
      'member_name': memberName,
    };
  }

  /// Encode a ```Member``` object from JSON.
  static Member fromCloudObject(data) {
    return Member(
      memberId: data['member_id'],
      memberType: data['member_type'],
      creator: data['creator'],
      memberName: data['member_name'],
      createdAtInUtc: DateTime.parse(data['created_at_in_utc']),
      editedAtInUtc: DateTime.parse(data['edited_at_in_utc']),
    );
  }

  // #####################################
  // Copy With
  // #####################################

  Member copyWith({
    String? memberId,
    String? memberType,
    String? creator,
    String? memberName,
    DateTime? createdAtInUtc,
    DateTime? editedAtInUtc,
  }) {
    return Member(
      memberId: memberId ?? this.memberId,
      memberType: memberType ?? this.memberType,
      creator: creator ?? this.creator,
      memberName: memberName ?? this.memberName,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
    );
  }
}
