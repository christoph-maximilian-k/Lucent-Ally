import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Reference extends Equatable {
  final String referenceId;
  final String parentReference;
  final String childReference;

  const Reference({
    required this.referenceId,
    required this.parentReference,
    required this.childReference,
  });

  @override
  List<Object> get props => [referenceId, parentReference, childReference];

  /// Initialize a new ```Reference``` object.
  factory Reference.initial() {
    return Reference(
      referenceId: const Uuid().v4(),
      parentReference: '',
      childReference: '',
    );
  }

  Reference copyWith({
    String? referenceId,
    String? parentReference,
    String? childReference,
  }) {
    return Reference(
      referenceId: referenceId ?? this.referenceId,
      parentReference: parentReference ?? this.parentReference,
      childReference: childReference ?? this.childReference,
    );
  }
}
