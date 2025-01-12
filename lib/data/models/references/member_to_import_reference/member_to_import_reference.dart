import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Schemas.
import 'schemas/db_member_to_import_reference.dart';

class MemberToImportReference extends Equatable {
  final String id;
  final String memberId;
  final String importReference;

  const MemberToImportReference({
    required this.id,
    required this.memberId,
    required this.importReference,
  });

  @override
  List<Object> get props => [id, memberId, importReference];

  /// Initialize a new ```MemberToImportReference``` object.
  factory MemberToImportReference.initial() {
    return MemberToImportReference(
      id: const Uuid().v4(),
      memberId: '',
      importReference: '',
    );
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```MemberToImportReference``` object to a ```DbMemberToImportReference``` object.
  DbMemberToImportReference toSchema() {
    return DbMemberToImportReference(
      id: id,
      memberId: memberId,
      importReference: importReference,
    );
  }

  /// Convert a ```DbMemberToImportReference``` object to a ```MemberToImportReference``` object.
  static MemberToImportReference fromSchema({required DbMemberToImportReference schema}) {
    return MemberToImportReference(
      id: schema.id!,
      memberId: schema.memberId!,
      importReference: schema.importReference!,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  MemberToImportReference copyWith({
    String? id,
    String? memberId,
    String? importReference,
  }) {
    return MemberToImportReference(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      importReference: importReference ?? this.importReference,
    );
  }
}
