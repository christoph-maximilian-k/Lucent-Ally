import 'package:equatable/equatable.dart';

class CompoundKeyGroupToEntry extends Equatable {
  final String groupId;
  final String entryId;

  const CompoundKeyGroupToEntry({
    required this.groupId,
    required this.entryId,
  });

  @override
  List<Object> get props => [groupId, entryId];

  /// Initialize a new ```CompoundKeyGroupToEntry``` object.
  factory CompoundKeyGroupToEntry.initial() {
    return const CompoundKeyGroupToEntry(
      groupId: '',
      entryId: '',
    );
  }

  /// This getter can be used to access the compound key.
  /// ```dart
  /// return '$groupId/$entryId';
  /// ```
  String get getCompoundKey => '$groupId/$entryId';

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```CompoundKeyGroupToEntry``` object to a ```DbCompoundKeyGroupToEntry``` object.
  /// ```dart
  /// return getCompoundKey;
  /// ```
  String toSchema() {
    return getCompoundKey;
  }

  /// Convert a ```DbCompoundKeyGroupToEntry``` object to a ```CompoundKeyGroupToEntry``` object.
  static CompoundKeyGroupToEntry fromSchema({required String schema}) {
    // Get list.
    final List<String> helper = schema.split('/');

    return CompoundKeyGroupToEntry(
      groupId: helper[0],
      entryId: helper[1],
    );
  }

  // --------------------------------------
  // ------------ CopyWith ----------------
  // --------------------------------------

  CompoundKeyGroupToEntry copyWith({
    String? groupId,
    String? entryId,
  }) {
    return CompoundKeyGroupToEntry(
      groupId: groupId ?? this.groupId,
      entryId: entryId ?? this.entryId,
    );
  }
}
