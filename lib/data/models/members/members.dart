import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/members/schemas/db_member.dart';

// Models.
import '/data/models/members/member.dart';

import '/data/models/field_types/payment_data/share_references.dart';
import '/data/models/field_types/payment_data/share_reference.dart';

import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class Members extends Equatable {
  final List<Member> items;

  const Members({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new [Members] object.
  factory Members.initial() {
    return const Members(
      items: [],
    );
  }

  /// This method can be used to get an indication about whether or not a specified ```member``` exists in ```items```.
  bool memberExists({required Member member}) {
    // Go through members.
    for (final Member item in items) {
      if (item.memberId == member.memberId) return true;
    }

    return false;
  }

  /// This method can be used to get an indication about whether or not a specified ```member.name``` already exists in ```items```
  /// * Compare is conducted in lower case.
  bool nameExists({required String name}) {
    // Go through members.
    for (final Member item in items) {
      if (item.memberName.toLowerCase() == name.toLowerCase()) return true;
    }

    return false;
  }

  /// This method can be used to add a member to ```items```.
  Members addMember({required Member member}) {
    // Init helper list.
    List<Member> members = [];

    // Go through members and add relevant data.
    for (final Member item in items) {
      members.add(item);
    }

    // Add specified member.
    members.add(member);

    return Members(
      items: members,
    );
  }

  /// This method can be used to remove a Member from ```items```.
  Members removeMember({required Member member}) {
    // Init helper list.
    List<Member> members = [];

    // Go through references and add relevant data.
    for (final Member item in items) {
      // * exclude specified member.
      if (item.memberId == member.memberId) continue;

      members.add(item);
    }

    return Members(
      items: members,
    );
  }

  /// This method can be used to update a Member in ```items```.
  Members updateMember({required Member updatedMember}) {
    // Init helper list.
    List<Member> members = [];

    // Go through references and add relevant data.
    for (final Member item in items) {
      // * insert specified member.
      if (item.memberId == updatedMember.memberId) {
        members.add(updatedMember);
        continue;
      }

      members.add(item);
    }

    return Members(
      items: members,
    );
  }

  /// This method can be used to convert [Members] into a [ShareReferences] object.
  ShareReferences toShareReferences({required double amount}) {
    // Init helper list.
    List<ShareReference> references = [];

    // Go throug items and add relevant data.
    for (final Member item in items) {
      // Init ShareReference.
      final ShareReference shareReference = ShareReference(
        id: item.memberId,
        value: amount.toString(),
      );

      references.add(shareReference);
    }

    return ShareReferences(
      items: references,
    );
  }

  /// This method can be used to access a member by its id.
  /// * Returns ```null``` if id cannot be found.
  Member? getById({required String memberId}) {
    for (final Member item in items) {
      if (item.memberId == memberId) return item;
    }

    return null;
  }

  /// This method can be used to add ```Members``` to ```items```.
  /// * ```Member``` will only be added if it does not already exist ensuring a unique list.
  Future<Members> addUniqueMembers({required Members members}) async {
    // Init helper.
    Members addedMembers = Members(
      items: [...items],
    );

    for (final Member member in members.items) {
      // Check if member already exists.
      final Member? accessedMember = addedMembers.getById(
        memberId: member.memberId,
      );

      // Member not found, add to list.
      if (accessedMember == null) addedMembers = addedMembers.addMember(member: member);
    }

    return addedMembers;
  }

  /// This method can be used to compare two ```Members``` and select those removed from the initial object.
  Future<Members> getRemovedMembers({required Members other}) async {
    // Init helper.
    List<Member> helper = [];

    for (final Member item in items) {
      // Check if intial item still exists in other.
      final bool exists = other.items.any(
        (element) => element.memberId == item.memberId,
      );

      // Add removed member to helper.
      if (exists == false) helper.add(item);
    }

    return Members(items: helper);
  }

  /// This method can be used to compare two ```Members``` and select those added to the other object.
  Future<Members> getAddedMembers({required Members other}) async {
    // Init helper.
    List<Member> helper = [];

    for (final Member item in other.items) {
      // Check if item exists in initial.
      final bool existsInInitial = items.any(
        (element) => element.memberId == item.memberId,
      );

      // Add added member to helper.
      if (existsInInitial == false) helper.add(item);
    }

    return Members(items: helper);
  }

  /// This method can be used to compare two ```Members``` and select those edited.
  Future<Members> getEditedMembers({required Members other}) async {
    // Init helper.
    List<Member> helper = [];

    for (final Member item in other.items) {
      // Check if intial item still exists in initial.
      final bool existsInInitial = items.any(
        (element) => element.memberId == item.memberId,
      );

      // Member does not exist in initial. Continue with next item.
      if (existsInInitial == false) continue;

      // Access the initial Member.
      Member? initial = getById(
        memberId: item.memberId,
      );

      // Member is unknown.
      initial ??= Member.unknownMember(memberId: item.memberId);

      // Compare members.
      if (initial != item) helper.add(item);
    }

    return Members(items: helper);
  }

  /// Convert [Members] to [PickerItems].
  /// * ```id = member.id```
  /// * ```label = member.name```
  PickerItems toPickerItems() {
    // Helper list.
    List<PickerItem> list = [];

    for (final Member member in items) {
      // Create PickerItem.
      final PickerItem pickerItem = PickerItem(
        id: member.memberId,
        label: member.memberName,
      );

      // Add item to list.
      list.add(pickerItem);
    }

    return PickerItems(items: list);
  }

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```Members``` object to a ```DbMembers``` object.
  List<DbMember> toSchema() {
    // Init helper.
    List<DbMember> helper = [];

    for (final Member item in items) {
      // Convert to schema.
      final DbMember dbMember = item.toSchema();

      // Add to helper.
      helper.add(dbMember);
    }

    return helper;
  }

  /// Convert a ```DbMembers``` object to a ```Members``` object.
  static Members fromSchema({required List<DbMember> schema}) {
    // Init helper.
    List<Member> helper = [];

    for (final DbMember dbMember in schema) {
      // Convert from schema.
      final Member member = Member.fromSchema(schema: dbMember);

      // Add to helper.
      helper.add(member);
    }

    return Members(
      items: helper,
    );
  }

  // --------------------------------------
  // ------------ Cloud -------------------
  // --------------------------------------

  /// Convert a ```Members``` object to JSON.
  List<Map<String, dynamic>> toCloudObject() {
    // Initialize list.
    List<Map<String, dynamic>> list = [];

    // Populate list with data.
    for (final Member item in items) {
      list.add(item.toCloudObject());
    }

    return list;
  }

  /// Convert a ```Members``` object from JSON.
  static Members fromCloudObject(documents) {
    // Initialize members list.
    List<Member> members = [];

    // Add data to list.
    for (final dynamic document in documents) {
      // Add member.
      members.add(Member.fromCloudObject(document));
    }

    return Members(
      items: members,
    );
  }

  Members copyWith({
    List<Member>? items,
  }) {
    return Members(
      items: items ?? this.items,
    );
  }
}
