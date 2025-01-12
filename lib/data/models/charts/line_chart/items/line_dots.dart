import 'package:equatable/equatable.dart';

// Models.
import 'line_dot.dart';

class LineDots extends Equatable {
  final List<LineDot> items;

  const LineDots({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```LineDots``` object.
  factory LineDots.initial() {
    return const LineDots(
      items: [],
    );
  }

  // This getter can be used to access the min X LineDot.
  // * Returns ```LineDot.initial()``` if ```items.isEmpty```.
  LineDot get getMinXLineDot {
    if (items.isEmpty) return LineDot.initial();

    // Init value.
    LineDot minX = items[0];

    for (final LineDot dot in items) {
      if (dot.xAxisValue < minX.xAxisValue) minX = dot;
    }

    return minX;
  }

  // This getter can be used to access the min Y LineDot.
  // * Returns ```LineDot.initial()``` if ```items.isEmpty```.
  LineDot get getMinYLineDot {
    if (items.isEmpty) return LineDot.initial();

    // Init value.
    LineDot minY = items[0];

    for (final LineDot dot in items) {
      if (dot.yAxisValue < minY.yAxisValue) minY = dot;
    }

    return minY;
  }

  // This getter can be used to access the max X LineDot.
  // * Returns ```LineDot.initial()``` if ```items.isEmpty```.
  LineDot get getMaxXLineDot {
    if (items.isEmpty) return LineDot.initial();

    // Init value.
    LineDot maxX = items[0];

    for (final LineDot dot in items) {
      if (dot.xAxisValue > maxX.xAxisValue) maxX = dot;
    }

    return maxX;
  }

  // This getter can be used to access the max Y LineDot.
  // * Returns ```LineDot.initial()``` if ```items.isEmpty```.
  LineDot get getMaxYLineDot {
    if (items.isEmpty) return LineDot.initial();

    // Init value.
    LineDot maxY = items[0];

    for (final LineDot dot in items) {
      if (dot.yAxisValue > maxY.yAxisValue) maxY = dot;
    }

    return maxY;
  }

  /// This method can be used to access a ```LineDot``` specified by ```id```.
  /// * returns ```null``` if ```id``` cannot be found.
  LineDot? getItemById({required String id}) {
    for (final LineDot item in items) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to add a ```LineDots``` to ```items```.
  LineDots add({required LineDot lineDot}) {
    return LineDots(
      items: [...items, lineDot],
    );
  }

  /// This method can be used to remove a ```LineDot```from ```items```.
  LineDots remove({required LineDot lineDot}) {
    // Init helper list.
    List<LineDot> lineDots = [];

    // Go through items and add relevant data.
    for (final LineDot item in items) {
      // * Exclude specified item.
      if (item.id == lineDot.id) continue;

      lineDots.add(item);
    }

    return LineDots(
      items: lineDots,
    );
  }

  /// This method can be used to update a ```LineDot``` in ```items```.
  LineDots update({required LineDot updatedLineDot}) {
    // Init helper list.
    List<LineDot> lineDots = [];

    // Go through items and add relevant data.
    for (final LineDot item in items) {
      // * insert specified item.
      if (item.id == updatedLineDot.id) {
        lineDots.add(updatedLineDot);
        continue;
      }

      lineDots.add(item);
    }

    return LineDots(
      items: lineDots,
    );
  }

  // --------------------------------------
  // ------------ Cloud -------------------
  // --------------------------------------

  /// This method can be used to decode ```LineDots``` from request JSON.
  static LineDots fromCloudObject(data) {
    // Init helper.
    List<LineDot> items = [];

    // Go through returned objects and convert them to local objects.
    for (final dynamic lineDot in data) {
      // Create the object.
      final LineDot converted = LineDot.fromCloudObject(lineDot);

      items.add(converted);
    }

    return LineDots(
      items: items,
    );
  }

  /// This method can be used to join a ```LineDots``` object with another ```LineDots``` object.
  LineDots join({required LineDots other}) {
    return LineDots(
      items: items + other.items,
    );
  }

  LineDots copyWith({
    List<LineDot>? items,
  }) {
    return LineDots(
      items: items ?? this.items,
    );
  }
}
