import 'package:equatable/equatable.dart';

// Models.
import '/data/models/fields/field.dart';

class FieldToEntry extends Equatable {
  final String entryId;
  final String entryName;

  final Field? field;

  const FieldToEntry({
    required this.entryId,
    required this.entryName,
    required this.field,
  });

  @override
  List<Object?> get props => [entryId, entryName, field];

  /// Initialize a new ```FieldToEntry``` object.
  factory FieldToEntry.initial() {
    return const FieldToEntry(
      entryId: '',
      entryName: '',
      field: null,
    );
  }

  FieldToEntry copyWith({
    String? entryId,
    String? entryName,
    Field? field,
  }) {
    return FieldToEntry(
      entryId: entryId ?? this.entryId,
      entryName: entryName ?? this.entryName,
      field: field ?? this.field,
    );
  }
}
