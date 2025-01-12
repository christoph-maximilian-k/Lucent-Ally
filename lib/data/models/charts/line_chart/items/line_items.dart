import 'package:equatable/equatable.dart';

// Models.
import 'line_item.dart';
import 'line_dot.dart';

class LineItems extends Equatable {
  final List<LineItem> items;

  const LineItems({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```LineItems``` object.
  factory LineItems.initial() {
    return const LineItems(
      items: [],
    );
  }

  /// This getter can be used to check if all ```yAxisValues == 0.0```.
  bool get getAllYValuesAreZero {
    for (final LineItem item in items) {
      for (final LineDot element in item.lineDots.items) {
        if (element.yAxisValue != 0) return false;
      }
    }

    return true;
  }

  /// This method can be used to access a ```LineItem``` specified by ```id```.
  /// * returns ```null``` if ```id``` cannot be found.
  LineItem? getItemById({required String id}) {
    for (final LineItem item in items) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to add a ```LineItems``` to ```items```.
  LineItems add({required LineItem lineItem}) {
    return LineItems(
      items: [...items, lineItem],
    );
  }

  /// This method can be used to remove a ```LineItem```from ```items```.
  LineItems remove({required LineItem lineItem}) {
    // Init helper list.
    List<LineItem> lineItems = [];

    // Go through items and add relevant data.
    for (final LineItem item in items) {
      // * Exclude specified item.
      if (item.id == lineItem.id) continue;

      lineItems.add(item);
    }

    return LineItems(
      items: lineItems,
    );
  }

  /// This method can be used to update a ```LineItem``` in ```items```.
  LineItems update({required LineItem updatedLineItem}) {
    // Init helper list.
    List<LineItem> lineItems = [];

    // Go through items and add relevant data.
    for (final LineItem item in items) {
      // * insert specified item.
      if (item.id == updatedLineItem.id) {
        lineItems.add(updatedLineItem);
        continue;
      }

      lineItems.add(item);
    }

    return LineItems(
      items: lineItems,
    );
  }

  /// This method can be used to join a ```LineItems``` object with another ```LineItems``` object.
  LineItems join({required LineItems other}) {
    return LineItems(
      items: items + other.items,
    );
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode ```LineItems``` from request JSON.
  static LineItems fromCloudObject(data) {
    // Init helper.
    List<LineItem> items = [];

    // Go through returned objects and convert them to local objects.
    for (final dynamic lineItem in data) {
      // Create the object.
      final LineItem converted = LineItem.fromCloudObject(lineItem);

      items.add(converted);
    }

    return LineItems(
      items: items,
    );
  }

  LineItems copyWith({
    List<LineItem>? items,
  }) {
    return LineItems(
      items: items ?? this.items,
    );
  }
}
