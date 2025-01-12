import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Models.
import 'bar_item.dart';

import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class BarItems extends Equatable {
  final List<BarItem> items;

  const BarItems({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new [BarItems] object.
  factory BarItems.initial() {
    return const BarItems(
      items: [],
    );
  }

  /// Initialize an example [BarItems] object.
  /// * Shows 12 months.
  factory BarItems.example() {
    return BarItems(
      items: [
        BarItem.initial().copyWith(
          yAxisValue: 10.0,
          bottomTitle: labels.alphabetA(),
        ),
        BarItem.initial().copyWith(
          yAxisValue: 9.0,
          bottomTitle: labels.alphabetB(),
        ),
        BarItem.initial().copyWith(
          yAxisValue: 4.0,
          bottomTitle: labels.alphabetC(),
        ),
        BarItem.initial().copyWith(
          yAxisValue: 2.0,
          bottomTitle: labels.alphabetD(),
        ),
      ],
    );
  }

  /// Initialize yearly ```BarItems``` object.
  /// * Shows 10 years.
  factory BarItems.yearly({Color barColor = Colors.purple}) {
    // Get the current year
    final int currentYear = DateTime.now().year;

    // Calculate the start year. Subtract 9 years means 10 years are displayed.
    final int startYear = currentYear - 9;

    // Create a list to store the years as strings
    List<String> years = [];

    // Add the years to the list
    for (int year = startYear; year <= currentYear; year++) {
      years.add(year.toString());
    }

    // Reverse list.
    final List<String> reversed = years.reversed.toList();

    // * Be careful when changeing topTitle to anything other then an empty string because
    // * some methods use topTitle as a hack to store total values.
    // * For example: localStorageCubit --> localEmotionDataAverageWellbeing()

    return BarItems(
      items: List<BarItem>.generate(
        years.length,
        (index) => BarItem.initial().copyWith(
          id: reversed[index],
          bottomTitle: reversed[index],
          barColor: barColor,
        ),
      ),
    );
  }

  /// Initialize monthly a ```BarItems``` object.
  factory BarItems.monthly({Color barColor = Colors.purple}) {
    // * Be careful when changeing topTitle to anything other then an empty string because
    // * some methods use topTitle as a hack to store total values.
    // * For example: localStorageCubit --> localEmotionDataAverageWellbeing()

    return BarItems(
      items: [
        BarItem.initial().copyWith(
          id: 'january',
          bottomTitle: 'Jan',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'february',
          bottomTitle: 'Feb',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'march',
          bottomTitle: 'Mar',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'april',
          bottomTitle: 'Apr',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'may',
          bottomTitle: 'May',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'june',
          bottomTitle: 'Jun',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'july',
          bottomTitle: 'Jul',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'august',
          bottomTitle: 'Aug',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'september',
          bottomTitle: 'Sep',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'october',
          bottomTitle: 'Oct',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'november',
          bottomTitle: 'Nov',
          barColor: barColor,
        ),
        BarItem.initial().copyWith(
          id: 'december',
          bottomTitle: 'Dec',
          barColor: barColor,
        )
      ],
    );
  }

  /// This method can be used to access a ```BarItem``` specified by ```id```.
  /// * returns ```null``` if ```id``` cannot be found.
  BarItem? getItemById({required String id}) {
    for (final BarItem item in items) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to add a ```BarItem``` to ```items```.
  BarItems add({required BarItem barItem}) {
    return BarItems(
      items: [...items, barItem],
    );
  }

  /// This method can be used to remove a ```BarItem```from ```items```.
  BarItems remove({required BarItem barItem}) {
    // Init helper list.
    List<BarItem> barItems = [];

    // Go through items and add relevant data.
    for (final BarItem item in items) {
      // * Exclude specified item.
      if (item.id == barItem.id) continue;

      barItems.add(item);
    }

    return BarItems(
      items: barItems,
    );
  }

  /// This method can be used to update a ```BarItem``` in ```items```.
  BarItems update({required BarItem updatedBarItem}) {
    // Init helper list.
    List<BarItem> barItems = [];

    // Go through items and add relevant data.
    for (final BarItem item in items) {
      // * insert specified item.
      if (item.id == updatedBarItem.id) {
        barItems.add(updatedBarItem);
        continue;
      }

      barItems.add(item);
    }

    return BarItems(
      items: barItems,
    );
  }

  /// This method can be used to join a ```BarItems``` object with another ```BarItems``` object.
  BarItems join({required BarItems other}) {
    return BarItems(
      items: items + other.items,
    );
  }

  /// This method can be used to set a `BarItem` in `items`.
  BarItems set({required BarItem barItem}) {
    // Init helper list.
    List<BarItem> barItems = [];

    // Init flag.
    bool itemFound = false;

    // Go through items and update or add the item.
    for (final BarItem item in items) {
      if (item.id == barItem.id) {
        // If item with the same id is found, update it.
        barItems.add(barItem);

        // Update flag.
        itemFound = true;

        // Continue with next item.
        continue;
      }

      // Otherwise, keep the existing item.
      barItems.add(item);
    }

    // If the item was not found, add the new item to the list.
    if (itemFound == false) barItems.add(barItem);

    // Return Items.
    return BarItems(items: barItems);
  }

  /// This getter can be used to check if all ```yAxisValues == 0.0```.
  bool get getAllValuesAreZero {
    for (final BarItem item in items) {
      if (item.yAxisValue != 0) return false;
    }

    return true;
  }

  /// This getter can be used to get the sum of all yAxisValues in items.
  double get getYAxisValueSum {
    // Init helper;
    double sum = 0.0;

    for (final BarItem item in items) {
      sum = sum + item.yAxisValue;
    }

    return sum;
  }

  /// This can be used to access the highest absolute bar item.
  BarItem? get getHighestAbsolutBarItem {
    // No items present.
    if (items.isEmpty) return null;

    return items.reduce(
      (value, element) {
        if (value.yAxisValue.abs() > element.yAxisValue.abs()) return value;

        return element;
      },
    );
  }

  /// Convert ```BarItems``` to ```PickerItems```.
  /// * ```id = barItem.id```
  /// * ```label``` will be set to either ```barItem.topTitle```, ```barItem.bottomTitle``` or ```labels.itemAtPosition(index: i)``` depending on which is available
  PickerItems toPickerItems() {
    // Helper list.
    List<PickerItem> list = [];

    for (int i = 0; i < items.length; i++) {
      // Access BarItem.
      final BarItem barItem = items[i];

      // Create label.
      String label = barItem.topTitle;
      if (label.isEmpty) label = barItem.bottomTitle;
      if (label.isEmpty) label = labels.barItemsBarAtPosition(position: i + 1);

      // Create PickerItem.
      final PickerItem pickerItem = PickerItem(
        id: barItem.id,
        label: label,
      );

      // Add item to list.
      list.add(pickerItem);
    }

    return PickerItems(items: list);
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode ```BarItems``` from request JSON.
  static BarItems fromCloudObject(data) {
    // Init helper.
    List<BarItem> items = [];

    // Go through returned objects and convert them to local objects.
    for (final dynamic barItem in data) {
      // Create the entry.
      final BarItem converted = BarItem.fromCloudObject(barItem);

      items.add(converted);
    }

    return BarItems(
      items: items,
    );
  }

  BarItems copyWith({
    List<BarItem>? items,
  }) {
    return BarItems(
      items: items ?? this.items,
    );
  }
}
