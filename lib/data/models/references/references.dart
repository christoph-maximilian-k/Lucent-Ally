import 'package:equatable/equatable.dart';

// Models.
import 'reference.dart';

class References extends Equatable {
  final List<Reference> items;

  const References({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```References``` object.
  factory References.initial() {
    return const References(
      items: [],
    );
  }

  /// This method can be used to add a ```Reference``` to ```items```.
  References add({required Reference reference}) {
    return References(
      items: [...items, reference],
    );
  }

  /// This method can be used to remove a ```Reference``` from ```items```.
  References remove({required Reference reference}) {
    // Init helper list.
    List<Reference> list = [];

    // Go through items and add relevant data.
    for (final Reference item in items) {
      // * exclude specified item.
      if (item.referenceId == reference.referenceId) continue;

      list.add(item);
    }

    return References(
      items: list,
    );
  }

  /// This method can be used to update a ```Reference``` in ```items```.
  References update({required Reference updatedReference}) {
    // Init helper list.
    List<Reference> statistics = [];

    // Go through items and add relevant data.
    for (final Reference item in items) {
      // * insert specified item.
      if (item.referenceId == updatedReference.referenceId) {
        statistics.add(updatedReference);
        continue;
      }

      statistics.add(item);
    }

    return References(
      items: statistics,
    );
  }

  // --------------------------------------
  // ------------ CopyWith ----------------
  // --------------------------------------

  References copyWith({
    List<Reference>? items,
  }) {
    return References(
      items: items ?? this.items,
    );
  }
}
