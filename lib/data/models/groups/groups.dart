import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/groups/schemas/db_group.dart';

// Models.
import 'group.dart';
import '/data/models/chip_items/chip_item.dart';
import '/data/models/chip_items/chip_items.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class Groups extends Equatable {
  final List<Group> items;

  const Groups({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```Groups``` object.
  factory Groups.initial() {
    return const Groups(
      items: [],
    );
  }

  /// This getter can be used to access [Groups] sorted alphabetically.
  /// * names get compared in lower case
  Groups get sortAtoZ {
    // Dont compare an empty list.
    if (items.isEmpty) return this;

    // Copy current items.
    final Groups sorted = Groups(
      items: items,
    );

    // Sort groups.
    sorted.items.sort(
      (a, b) => a.groupName.toLowerCase().compareTo(b.groupName.toLowerCase()),
    );

    return sorted;
  }

  /// This getter can be used to access all ```group.name``` of [Groups].
  /// * sorts names from a to z.
  List<String> get getGroupNames {
    // Init helper list.
    List<String> groupNames = [];

    // Go thorugh groups and add names.
    for (final Group group in items) {
      groupNames.add(group.groupName);
    }

    // Sort names.
    groupNames.sort(
      (a, b) => a.toLowerCase().compareTo(b.toLowerCase()),
    );

    return groupNames;
  }

  

  /// This method can be used to get an indication about whether or not a specified ```groupName``` already exists.
  /// * names are converted to lower case
  bool groupNameExists({required String groupName}) {
    // Go through groups.
    for (final Group group in items) {
      if (group.groupName.toLowerCase() == groupName.toLowerCase()) return true;
    }

    return false;
  }

  /// This method can be used to get an indication about whether or not a specified ```group``` is in ```items```.
  bool groupExists({required Group group}) {
    // Go Through groups and test for equal ids.
    for (final Group item in items) {
      // Specified group is in items.
      if (group.groupId == item.groupId) return true;
    }

    // Specified group is not in items.
    return false;
  }

  /// This method can be used to access a group by its id.
  /// * returns ```null``` if ```groupId``` cannot be found
  Future<Group?> getById({required String groupId}) async {
    for (final Group group in items) {
      if (group.groupId == groupId) return group;
    }

    return null;
  }

  /// Convert a [Groups] object to a [ChipItems] object.
  /// * chips are sorted from a to z
  ChipItems toChipItems() {
    // Init helper list.
    List<ChipItem> chips = [];

    for (final Group group in items) {
      // Create ChipItem.
      final ChipItem chip = ChipItem(
        id: group.groupId,
        label: group.groupName,
        iconData: null,
        onPressed: null,
        isSelected: false,
      );

      // Add ChipItem to list.
      chips.add(chip);
    }

    // Create sorted ChipsItems object.
    final ChipItems chipItems = ChipItems(
      isLoading: false,
      items: chips,
    ).sortAtoZ;

    return chipItems;
  }

  /// Convert a [Groups] object to a [PickerItems] object.
  /// * items are sorted from a to z
  PickerItems toPickerItems() {
    // Init helper list.
    List<PickerItem> list = [];

    for (final Group group in items) {
      // Create ChipItem.
      final PickerItem pickerItem = PickerItem(
        id: group.groupId,
        label: group.groupName,
      );

      // Add ChipItem to list.
      list.add(pickerItem);
    }

    // Create sorted ChipsItems object.
    final PickerItems pickerItems = PickerItems(
      items: list,
    ).sortAtoZ;

    return pickerItems;
  }

  /// This method can be used to add a ```Group``` to ```items```.
  Groups add({required Group group}) {
    return Groups(
      items: [...items, group],
    );
  }

  /// This method can be used to update a ```Group``` in ```items```.
  /// * Returns ```null``` if ```groupId``` was not found in ```items```.
  Groups? update({required Group updatedGroup}) {
    // Init helpers.
    List<Group> helper = [];
    bool idFound = false;

    // Go through items and add relevant data.
    for (final Group item in items) {
      // * insert specified group.
      if (item.groupId == updatedGroup.groupId) {
        // Add updated object.
        helper.add(updatedGroup);

        // Notify flag.
        idFound = true;

        continue;
      }

      helper.add(item);
    }

    // Return error if update was conducted on an id that does not exist in items.
    if (idFound == false) return null;

    return Groups(items: helper);
  }

  /// This method can be used to remove a ```Group``` from ```items```.
  Groups remove({required String groupId}) {
    // Initialize helper.
    final List<Group> helper = [];

    // Copy list.
    for (final Group item in items) {
      // Exclude this ModelEntry.
      if (item.groupId == groupId) continue;

      helper.add(item);
    }

    return Groups(items: helper);
  }

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```DbGroups``` object to a ```Groups``` object.
  static Groups fromSchema({required List<DbGroup> schema}) {
    // Helper.
    List<Group> helper = [];

    for (final DbGroup dbGroup in schema) {
      final Group group = Group.fromSchema(schema: dbGroup);

      helper.add(group);
    }

    return Groups(items: helper);
  }

  // --------------------------------------
  // ------------ Cloud ------------------
  // --------------------------------------

  /// Decode a ```Groups``` object from JSON provided by cloud service.
  static Groups fromCloudObject(data) {
    // Init helper variable.
    List<Group> items = [];

    for (final dynamic item in data) {
      // Convert Object.
      final Group group = Group.fromCloudObject(item);

      // Add to list.
      items.add(group);
    }

    return Groups(items: items);
  }

  // --------------------------------------
  // ------------ CopyWith ----------------
  // --------------------------------------

  Groups copyWith({
    List<Group>? items,
  }) {
    return Groups(
      items: items ?? this.items,
    );
  }
}
