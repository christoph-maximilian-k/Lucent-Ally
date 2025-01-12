import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class LicenceItem extends Equatable {
  final String id;
  final String packageName;
  final List<LicenseEntry> licences;

  const LicenceItem({
    required this.id,
    required this.packageName,
    required this.licences,
  });

  @override
  List<Object> get props => [id, packageName, licences];

  /// Initialize a new ```LicenceItem``` object.
  factory LicenceItem.initial() {
    return LicenceItem(
      id: const Uuid().v4(),
      packageName: '',
      licences: const [],
    );
  }

  /// This method can be used to insert a ```licenseEntry``` into ```licences```.
  LicenceItem add({required LicenseEntry licenseEntry}) {
    return copyWith(
      licences: [...licences, licenseEntry],
    );
  }

  LicenceItem copyWith({
    String? id,
    String? packageName,
    List<LicenseEntry>? licences,
  }) {
    return LicenceItem(
      id: id ?? this.id,
      packageName: packageName ?? this.packageName,
      licences: licences ?? this.licences,
    );
  }
}
