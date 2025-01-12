import 'package:equatable/equatable.dart';

// Models.
import 'chip_item.dart';

class ChipItems extends Equatable {
  final bool isLoading;
  final List<ChipItem> items;

  /// [ChipItems] constructor.
  const ChipItems({
    required this.isLoading,
    required this.items,
  });

  /// Initialize a new [ChipItems] object.
  /// ```dart
  /// return const ChipItems(
  ///  isLoading: false,
  ///  items: [],
  /// );
  /// ```
  factory ChipItems.initial() {
    return const ChipItems(
      isLoading: false,
      items: [],
    );
  }

  @override
  List<Object> get props => [isLoading, items];

  /// This getter can be used to sort ChipItems alphabetically by its label.
  /// * converts labels to lower case before compareing
  ChipItems get sortAtoZ {
    // Copy current items.
    final ChipItems sorted = this;

    // Sort groups.
    sorted.items.sort(
      (a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()),
    );

    return sorted;
  }

  /// This method can be used to update the [isSelected] property of indicated item.
  ChipItems updateIsSelected({required String id}) {
    // Init helper items.
    List<ChipItem> chipItems = [];

    for (final ChipItem item in items) {
      if (item.id == id) {
        final ChipItem newItem = item.copyWith(isSelected: true);

        chipItems.add(newItem);

        continue;
      }

      chipItems.add(item.copyWith(isSelected: false));
    }

    return ChipItems(
      isLoading: isLoading,
      items: chipItems,
    );
  }

  ChipItems copyWith({
    bool? isLoading,
    List<ChipItem>? items,
  }) {
    return ChipItems(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }
}
