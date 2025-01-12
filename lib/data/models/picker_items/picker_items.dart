import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

// Labels.
import '/main.dart';

// Models.
import 'picker_item.dart';
import 'color_item.dart';

class PickerItems extends Equatable {
  final List<PickerItem> items;

  const PickerItems({
    required this.items,
  });

  /// This list can be used to init a color picker.
  static List<ColorItem> availableColors = [
    ColorItem(
      id: 'amber',
      label: labels.pickerItemsColorAmber(),
      color: Colors.amber,
    ),
    ColorItem(
      id: 'green',
      label: labels.pickerItemsColorGreen(),
      color: Colors.green,
    ),
    ColorItem(
      id: 'red',
      label: labels.pickerItemsColorRed(),
      color: Colors.red,
    ),
    ColorItem(
      id: 'purple',
      label: labels.pickerItemsColorPurple(),
      color: Colors.purple,
    ),
    ColorItem(
      id: 'deep_purple',
      label: labels.pickerItemsColorDeepPurple(),
      color: Colors.deepPurple,
    ),
    ColorItem(
      id: 'orange',
      label: labels.pickerItemsColorOrange(),
      color: Colors.orange,
    ),
    ColorItem(
      id: 'deep_orange',
      label: labels.pickerItemsColorDeepOrange(),
      color: Colors.deepOrange,
    ),
    ColorItem(
      id: 'black',
      label: labels.pickerItemsColorBlack(),
      color: Colors.black,
    ),
    ColorItem(
      id: 'white',
      label: labels.pickerItemsColorWhite(),
      color: Colors.white,
    ),
    ColorItem(
      id: 'blue',
      label: labels.pickerItemsColorBlue(),
      color: const Color.fromARGB(255, 18, 99, 165),
    ),
    ColorItem(
      id: 'pink',
      label: labels.pickerItemsColorPink(),
      color: Colors.pink,
    ),
  ];

  @override
  List<Object> get props => [items];

  /// Initialize a new [PickerItems] object.
  factory PickerItems.initial() {
    return const PickerItems(
      items: [],
    );
  }

  /// Initialize a [PickerItems] object which lets user select colors.
  factory PickerItems.colors() {
    return PickerItems(
      items: List<PickerItem>.generate(
        availableColors.length,
        (index) => PickerItem(id: availableColors[index].id, label: availableColors[index].label),
      ),
    );
  }

  /// Initialize a [PickerItems] object which lets user select years.
  factory PickerItems.years() {
    // Get the current year
    final int currentYear = DateTime.now().year;

    // Calculate the start year
    final int startYear = currentYear - 1000 + 1;

    // Create a list to store the years as strings
    List<String> years = [];

    // Add the years to the list
    for (int year = startYear; year <= currentYear; year++) {
      years.add(year.toString());
    }

    // Reverse list to have current year first.
    final List<String> reversedYears = years.reversed.toList();

    // Create years picker items.
    final PickerItems yearsPickerItems = PickerItems(
      items: List<PickerItem>.generate(
        reversedYears.length,
        (index) => PickerItem(id: reversedYears[index], label: reversedYears[index]),
      ),
    );

    // Add PickerItem all.
    final PickerItems pickerItems = PickerItems(
      items: [
        PickerItem.allYears(),
        ...yearsPickerItems.items,
      ],
    );

    return pickerItems;
  }

  /// Initialize a ```PickerItems``` object which lets user select time intervals.
  factory PickerItems.timeIntervals() {
    return PickerItems(
      items: [
        PickerItem.yearly(),
        PickerItem.monthly(),
        PickerItem.daily(),
      ],
    );
  }

  /// Convert the header of a csv table to picker items.
  static Future<PickerItems> pickerItemsFromCSV({required List<List<dynamic>> csvTable}) async {
    // Init helper.
    List<PickerItem> helper = [];

    // Go through first line of csv.
    for (final dynamic item in csvTable.first) {
      // Create PickerItem.
      final PickerItem pickerItem = PickerItem(
        id: item.toString(),
        label: item.toString(),
      );

      // Add to list.
      helper.add(pickerItem);
    }

    return PickerItems(items: helper);
  }

  /// This getter can be used to sort PickerItems alphabetically by its label.
  /// * converts labels to lower case before compareing
  PickerItems get sortAtoZ {
    // Copy current items.
    final PickerItems sorted = this;

    // Sort groups.
    sorted.items.sort(
      (a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()),
    );

    return sorted;
  }

  /// This method can be used to access a pickerItem by its id.
  /// * Returns ```null``` if id was not found.
  /// * Set ```caseSensitive``` to ```false``` to convert everything to lowerCase before checking for equality.
  PickerItem? getById({required String id, bool caseSensitive = true}) {
    for (final PickerItem item in items) {
      if (caseSensitive && item.id == id) return item;
      if (caseSensitive == false && item.id.toLowerCase() == id.toLowerCase()) return item;
    }

    return null;
  }

  /// This method can be used to add a pickerItem to items.
  PickerItems add({required PickerItem pickerItem}) {
    return PickerItems(
      items: [pickerItem, ...items],
    );
  }

  /// This method can be used to access a color by id.
  /// * returns ```null``` if ```id``` is not found.
  Color? getColorById({required String id}) {
    for (final ColorItem colorItem in availableColors) {
      if (colorItem.id == id) return colorItem.color;
    }

    return null;
  }

  /// This method can be used to join two [PickerItems] objects.
  /// * ```items``` of ```other``` will be added to the end of the list
  PickerItems join({required PickerItems other}) {
    return PickerItems(
      items: <PickerItem>{...items, ...other.items}.toList(),
    );
  }

  /// This method can be used to access the index of provided id.
  /// * Returns ```null``` if provided ```id``` could not be found.
  int? getIndexOfId({required String id}) {
    for (int i = 0; i < items.length; i++) {
      // Access Picker item.
      final PickerItem item = items[i];

      if (item.id == id) return i;
    }

    return null;
  }

  PickerItems copyWith({
    List<PickerItem>? items,
  }) {
    return PickerItems(
      items: items ?? this.items,
    );
  }
}
