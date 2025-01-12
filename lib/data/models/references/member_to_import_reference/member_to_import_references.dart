import 'package:equatable/equatable.dart';

// Schemas.
import 'schemas/db_member_to_import_reference.dart';

// Models.
import 'member_to_import_reference.dart';

class MemberToImportReferences extends Equatable {
  final List<MemberToImportReference> items;

  const MemberToImportReferences({
    required this.items,
  });

  /// Initialize a new ```MemberToImportReferences``` object.
  factory MemberToImportReferences.initial() {
    return const MemberToImportReferences(
      items: [],
    );
  }

  @override
  List<Object> get props => [items];

  /// This method can be used to access a ```MemberToImportReference``` in ```items``` by its id.
  /// * Returns ```null``` if ```id``` was not found.
  MemberToImportReference? getById({required String id}) {
    for (final MemberToImportReference item in items) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to access a ```MemberToImportReference``` in ```items``` by its ```memberId```.
  /// * Returns ```null``` if ```memberId``` was not found.
  MemberToImportReference? getByMemberId({required String memberId}) {
    for (final MemberToImportReference item in items) {
      if (item.memberId == memberId) return item;
    }

    return null;
  }

  /// This method can be used to access a ```MemberToImportReference``` in ```items``` by ```importReference```.
  /// * Returns ```null``` if ```importReference``` was not found.
  MemberToImportReference? getByImportReference({required String importReference}) {
    for (final MemberToImportReference item in items) {
      if (item.importReference == importReference) return item;
    }

    return null;
  }

  /// This method can be used to add a ```MemberToImportReference``` to ```items```.
  /// * This method does NOT check for duplicates.
  MemberToImportReferences add({required MemberToImportReference memberToImportReference}) {
    return MemberToImportReferences(
      items: [...items, memberToImportReference],
    );
  }

  /// This method can be used to update a ```MemberToImportReference``` in ```items```.
  MemberToImportReferences update({required MemberToImportReference updatedShareReference}) {
    // Init helper list.
    List<MemberToImportReference> helper = [];

    // Go through references and add relevant data.
    for (final MemberToImportReference item in items) {
      // Insert specified member.
      if (item.id == updatedShareReference.id) {
        helper.add(updatedShareReference);
        continue;
      }

      helper.add(item);
    }

    return MemberToImportReferences(
      items: helper,
    );
  }

  /// This method can be used to remove a ```MemberToImportReference``` from ```items```.
  MemberToImportReferences remove({required String id}) {
    // Init helper list.
    List<MemberToImportReference> helper = [];

    // Go through references and add relevant data.
    for (final MemberToImportReference item in items) {
      // * Exclude item.
      if (item.id == id) continue;

      helper.add(item);
    }

    return MemberToImportReferences(
      items: helper,
    );
  }

  /// This method can be used to set a ```MemberToImportReference``` to ```items```.
  /// * This method does NOT check for duplicates.
  MemberToImportReferences set({required String importReference, required String memberId}) {
    // Initialize a helper list to store updated items.
    List<MemberToImportReference> helper = [];
    bool isUpdated = false;

    // Loop through existing items and either update or retain.
    for (final MemberToImportReference item in items) {
      if (item.memberId == memberId) {
        // Create updated object.
        final MemberToImportReference updated = item.copyWith(
          importReference: importReference,
        );

        // If a match is found, update the importReference.
        helper.add(updated);

        // Update flag.
        isUpdated = true;

        // Continue with next item.
        continue;
      }

      // If no match, keep the existing item.
      helper.add(item);
    }

    // If no match was found, add a new reference.
    if (isUpdated == false) {
      // Create updated object.
      final MemberToImportReference created = MemberToImportReference.initial().copyWith(
        memberId: memberId,
        importReference: importReference,
      );

      // If a match is found, update the importReference.
      helper.add(created);
    }

    // Return the updated list wrapped in MemberToImportReferences.
    return MemberToImportReferences(
      items: helper,
    );
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```MemberToImportReferences``` object to a ```DbMemberToImportReferences``` object.
  List<DbMemberToImportReference> toSchema() {
    // Init helper.
    List<DbMemberToImportReference> helper = [];

    // Populate list with data.
    for (final MemberToImportReference item in items) {
      // Convert object.
      final DbMemberToImportReference dbObject = item.toSchema();

      // Add to helper.
      helper.add(dbObject);
    }

    return helper;
  }

  /// Convert a ```DbMemberToImportReferences``` object to a ```MemberToImportReferences``` object.
  /// * Returns ```null``` if ```schema == null```.
  static MemberToImportReferences? fromSchema({required List<DbMemberToImportReference>? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Initialize helper.
    List<MemberToImportReference> helper = [];

    // Add data to list.
    for (final DbMemberToImportReference item in schema) {
      // Convert object.
      final MemberToImportReference object = MemberToImportReference.fromSchema(schema: item);

      // Add to helper.
      helper.add(object);
    }

    return MemberToImportReferences(
      items: helper,
    );
  }

  MemberToImportReferences copyWith({
    List<MemberToImportReference>? items,
  }) {
    return MemberToImportReferences(
      items: items ?? this.items,
    );
  }
}
