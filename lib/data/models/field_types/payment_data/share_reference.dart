import 'package:equatable/equatable.dart';

// Schemas.
import 'schemas/db_share_reference.dart';

class ShareReference extends Equatable {
  final String id;
  final String value;

  const ShareReference({
    required this.id,
    required this.value,
  });

  /// Initialize a new ```ShareReference``` object.
  factory ShareReference.initial() {
    return const ShareReference(
      id: '',
      value: '',
    );
  }

  @override
  List<Object> get props => [id, value];

  /// This getter can be used to parse ```value``` to a double.
  /// * This getter assumes that total is a valid double.
  double get valueAsDouble {
    return double.parse(value);
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```ShareReference``` object to a ```DbShareReference``` object.
  DbShareReference toSchema() {
    return DbShareReference(
      shareReferenceId: id,
      value: valueAsDouble,
    );
  }

  /// Convert a ```DbShareReference``` object to a ```ShareReference``` object.
  static ShareReference fromSchema({required DbShareReference schema}) {
    return ShareReference(
      id: schema.shareReferenceId!,
      value: schema.value.toString(),
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```ShareReference``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'id': id,
      'value': valueAsDouble,
    };
  }

  /// Encode a ```ShareReference``` object from JSON.
  static ShareReference fromCloudObject(document) {
    return ShareReference(
      id: document['id'],
      value: document['value'].toString(),
    );
  }

  // ######################################
  // Copy With
  // ######################################

  ShareReference copyWith({
    String? id,
    String? value,
  }) {
    return ShareReference(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }
}
