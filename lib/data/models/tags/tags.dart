import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/tags/schemas/db_tag.dart';

// Models.
import '/data/models/tags/tag.dart';
import '/data/models/chip_items/chip_item.dart';
import '/data/models/chip_items/chip_items.dart';

class Tags extends Equatable {
  final List<Tag> items;

  const Tags({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```Tags``` object.
  factory Tags.initial() {
    return const Tags(
      items: [],
    );
  }

  /// This getter can be used to access references from current tags.
  List<String> get getReferences {
    // Init helper list.
    List<String> helper = [];

    for (final Tag tag in items) {
      helper.add(tag.tagId);
    }

    return helper;
  }

  /// This getter can be used to access labels from current tags.
  List<String> get getLabels {
    // Init helper list.
    List<String> helper = [];

    for (final Tag tag in items) {
      helper.add(tag.label);
    }

    return helper;
  }

  /// This getter can be used to sort tags from a to z.
  Tags get sortAtoZ {
    // * It seems like this is needed because otherwise sort function tries to modify an unmodifiable list.
    if (items.isEmpty) return this;

    // Copy current items.
    final Tags sorted = Tags(items: items);

    // Sort items.
    sorted.items.sort(
      (a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()),
    );

    return sorted;
  }

  /// This method can be used to get a ```Tag``` by its ```recordKey```.
  /// * returns ```null``` if ```recordKey``` was not found
  Tag? byId({required String tagId}) {
    for (final Tag item in items) {
      if (item.tagId == tagId) return item;
    }

    return null;
  }

  /// This method can be used to find a ```Tag``` by its ```label```.
  /// * returns ```null``` if ```label``` was not found
  Future<Tag?> getTagByLabel({required String tagLabel}) async {
    for (final Tag item in items) {
      if (item.label == tagLabel) return item;
    }

    return null;
  }

  /// This method can be used to find a suggested ```Tags``` depending on ```value```.
  Future<Tags> getTagSuggestions({required String value}) async {
    // Init helper list.
    List<Tag> helper = [];

    for (final Tag item in items) {
      if (item.label.contains(value)) helper.add(item);
    }

    return Tags(
      items: helper,
    );
  }

  /// This method can be used to add a ```Tag``` to ```items```.
  Tags add({required Tag tag}) {
    return Tags(
      items: [...items, tag],
    );
  }

  /// This method can be used to join two `Tags` objects.
  /// * This method only retains unique items.
  Tags joinUnique({required Tags other}) {
    // Use a Set to store unique items
    final Set<Tag> uniqueItems = {...items, ...other.items};

    // Convert back to a List and create a new Tags object
    return Tags(items: uniqueItems.toList());
  }

  /// Convert a ```Tags``` object to a ```ChipItems``` object.
  /// * tag recordKey is used as id
  /// * chips are sorted from a to z
  ChipItems toChipItems() {
    // Init helper list.
    List<ChipItem> chips = [];

    for (final Tag tag in items) {
      // Create ChipItem.
      final ChipItem chip = ChipItem(
        id: tag.tagId,
        label: tag.label,
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

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```DbTags``` object to a ```Tags``` object.
  static Tags fromSchema({required List<DbTag> schema}) {
    // Helper.
    List<Tag> helper = [];

    for (final DbTag dbTag in schema) {
      final Tag tag = Tag.fromSchema(schema: dbTag);

      helper.add(tag);
    }

    return Tags(items: helper);
  }

  // --------------------------------------
  // ------------ Cloud -------------------
  // --------------------------------------

  /// This method can be used to decode ```Tags``` from request JSON.
  static Tags fromCloudObject(data) {
    // Init helper.
    List<Tag> tags = [];

    // Go through returned entries and convert them to local objects.
    for (final dynamic item in data) {
      // Create the entry.
      final Tag tag = Tag.fromCloudObject(item);

      tags.add(tag);
    }

    return Tags(
      items: tags,
    );
  }

  // --------------------------------------
  // ------------ Copy With ---------------
  // --------------------------------------

  Tags copyWith({
    List<Tag>? items,
  }) {
    return Tags(
      items: items ?? this.items,
    );
  }
}
