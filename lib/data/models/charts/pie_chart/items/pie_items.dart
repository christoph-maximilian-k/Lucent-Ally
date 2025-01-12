import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Models.
import 'pie_item.dart';

class PieItems extends Equatable {
  final List<PieItem> items;

  const PieItems({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```PieItems``` object.
  factory PieItems.initial() {
    return const PieItems(
      items: [],
    );
  }

  /// Initialize seasonal a ```PieItems``` object.
  /// * Id for spring : ```spring```
  /// * Id for summer : ```summer```
  /// * Id for autumn : ```autumn```
  /// * Id for winter : ```winter```
  factory PieItems.seasonal() {
    return PieItems(
      items: [
        PieItem.initial().copyWith(
          id: 'spring',
          color: Colors.green,
          value: 0.0,
          legendLabel: labels.basicLabelsSpring(),
        ),
        PieItem.initial().copyWith(
          id: 'summer',
          color: Colors.blue,
          value: 0.0,
          legendLabel: labels.basicLabelsSummer(),
        ),
        PieItem.initial().copyWith(
          id: 'autumn',
          color: Colors.deepOrange,
          value: 0.0,
          legendLabel: labels.basicLabelsAutumn(),
        ),
        PieItem.initial().copyWith(
          id: 'winter',
          color: Colors.blueGrey,
          value: 0.0,
          legendLabel: labels.basicLabelsWinter(),
        ),
      ],
    );
  }

  /// This method can be used to access a ```PieItem``` specified by ```id```.
  /// * returns ```null``` if ```id``` cannot be found.
  PieItem? getItemById({required String id}) {
    for (final PieItem item in items) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to add a ```PieItems``` to ```items```.
  PieItems add({required PieItem pieItem}) {
    return PieItems(
      items: [...items, pieItem],
    );
  }

  /// This method can be used to remove a ```PieItem```from ```items```.
  PieItems remove({required PieItem pieItem}) {
    // Init helper list.
    List<PieItem> pieItems = [];

    // Go through items and add relevant data.
    for (final PieItem item in items) {
      // * Exclude specified item.
      if (item.id == pieItem.id) continue;

      pieItems.add(item);
    }

    return PieItems(
      items: pieItems,
    );
  }

  /// This method can be used to update a ```PieItem``` in ```items```.
  PieItems update({required PieItem updatedPieItem}) {
    // Init helper list.
    List<PieItem> pieItems = [];

    // Go through items and add relevant data.
    for (final PieItem item in items) {
      // * insert specified item.
      if (item.id == updatedPieItem.id) {
        pieItems.add(updatedPieItem);
        continue;
      }

      pieItems.add(item);
    }

    return PieItems(
      items: pieItems,
    );
  }

  /// This method can be used to set a `PieItem` in `items`.
  PieItems set({required PieItem pieItem}) {
    // Init helper list.
    List<PieItem> pieItems = [];

    // Init flag.
    bool itemFound = false;

    // Go through items and update or add the item.
    for (final PieItem item in items) {
      if (item.id == pieItem.id) {
        // If item with the same id is found, update it.
        pieItems.add(pieItem);

        // Update flag.
        itemFound = true;

        // Continue with next item.
        continue;
      }

      // Otherwise, keep the existing item.
      pieItems.add(item);
    }

    // If the item was not found, add the new item to the list.
    if (itemFound == false) pieItems.add(pieItem);

    // Return PieItems.
    return PieItems(items: pieItems);
  }

  /// This method can be used to join a ```PieItems``` object with another ```PieItems``` object.
  PieItems join({required PieItems other}) {
    return PieItems(
      items: items + other.items,
    );
  }

  /// This method can be used to access the sum of all pie item values.
  double pieItemsSum() {
    // Init helper.
    double sum = 0.0;

    for (final PieItem item in items) {
      sum = sum + item.value;
    }

    return sum;
  }

  /// This method can be used to access the sum of pie item
  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode ```PieItems``` from request JSON.
  static PieItems fromCloudObject(data) {
    // Init helper.
    List<PieItem> items = [];

    // Go through returned objects and convert them to local objects.
    for (final dynamic pieItem in data) {
      // Create the object.
      final PieItem converted = PieItem.fromCloudObject(pieItem);

      items.add(converted);
    }

    return PieItems(
      items: items,
    );
  }

  PieItems copyWith({
    List<PieItem>? items,
  }) {
    return PieItems(
      items: items ?? this.items,
    );
  }
}
