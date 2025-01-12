import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

// Models.
import '/data/models/licences/licence_item.dart';

class Licences extends Equatable {
  final List<LicenceItem> items;

  const Licences({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```Licences``` object.
  factory Licences.initial() {
    return const Licences(
      items: [],
    );
  }

  /// This getter can be used to sort ```Licenses``` alphabetically.
  Licences get sortAtoZ {
    // Copy current items.
    final Licences sorted = Licences(items: items);

    // Sort items.
    sorted.items.sort(
      (a, b) => a.packageName.toLowerCase().compareTo(b.packageName.toLowerCase()),
    );

    return sorted;
  }

  /// This method can be used to check if a package name already exists.
  /// * returns null if package name was not found
  LicenceItem? getPackageByName({required String packageName}) {
    for (final LicenceItem licenceItem in items) {
      if (licenceItem.packageName.toLowerCase() == packageName.toLowerCase()) return licenceItem;
    }

    return null;
  }

  /// This method can be used to add a license to Licences.
  Licences addLicenceToPackage({required String id, required LicenseEntry licenseEntry}) {
    // Init helper.
    List<LicenceItem> helper = [];

    for (final LicenceItem licenceItem in items) {
      if (licenceItem.id == id) {
        // * Add item.
        final LicenceItem updatedItem = licenceItem.add(
          licenseEntry: licenseEntry,
        );

        // * Add updated item.
        helper.add(updatedItem);
        continue;
      }

      // * Add unchanged item.
      helper.add(licenceItem);
    }

    return Licences(items: helper);
  }

  /// This method can be used to add a ```LicenseItem``` to ```Licenses```.
  Licences add({required LicenceItem licenceItem}) {
    return Licences(
      items: [...items, licenceItem],
    );
  }

  Licences copyWith({
    List<LicenceItem>? items,
  }) {
    return Licences(
      items: items ?? this.items,
    );
  }
}
