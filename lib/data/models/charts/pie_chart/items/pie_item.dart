import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// User with Settings and Labels.
import '/main.dart';

// Helper functions.
import '/logic/helper_functions/helper_functions.dart';

class PieItem extends Equatable {
  final String id;

  final Color color;

  final String title;

  final double value;

  final String legendLabel;
  final double legendValue;
  final String legendSuffix;

  final String referenceType;
  final String referenceId;

  const PieItem({
    required this.id,
    required this.color,
    required this.title,
    required this.value,
    required this.legendLabel,
    required this.legendValue,
    required this.legendSuffix,
    required this.referenceType,
    required this.referenceId,
  });

  @override
  List<Object> get props => [
        id,
        color,
        title,
        value,
        legendLabel,
        legendValue,
        legendSuffix,
        referenceType,
        referenceId,
      ];

  /// Initialize a new ```PieItem``` object.
  factory PieItem.initial() {
    return PieItem(
      id: const Uuid().v4(),
      color: Colors.amber,
      title: '',
      value: 0.0,
      legendLabel: '',
      legendValue: 0.0,
      legendSuffix: '',
      referenceType: '',
      referenceId: '',
    );
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode a ```PieItem``` from request JSON.
  static PieItem fromCloudObject(data) {
    // Convenience variables.
    String? title = data['title'];
    String legendLabel = data['legend_label'];

    final double value = data['value'];
    final bool isGreaterTen = value >= 10;

    if (title == null && isGreaterTen) title = "${value.toStringAsFixed(2)} %";

    // Set bottomTitle to translated label.
    if (data["id"] == "untagged") legendLabel = labels.basicLabelsNotTagged();

    // Set bottomTitle to translated label.
    if (data["id"] == "others") legendLabel = labels.basicLabelsOthers();

    // Set bottomTitle to translated label.
    if (data["id"] == "unspecified") legendLabel = labels.basicLabelsNotSpecified();

    // Set bottomTitle to translated label.
    if (data["id"] == "true") legendLabel = labels.basicLabelsTrue();

    // Set bottomTitle to translated label.
    if (data["id"] == "false") legendLabel = labels.basicLabelsFalse();

    // Set bottomTitle to translated label.
    if (data["id"] == "spring") legendLabel = labels.basicLabelsSpring();

    // Set bottomTitle to translated label.
    if (data["id"] == "summer") legendLabel = labels.basicLabelsSummer();

    // Set bottomTitle to translated label.
    if (data["id"] == "autumn") legendLabel = labels.basicLabelsAutumn();

    // Set bottomTitle to translated label.
    if (data["id"] == "winter") legendLabel = labels.basicLabelsWinter();

    // Set bottomTitle to translated label.
    if (data["id"] == "positive_emotion") legendLabel = labels.basicLabelsPositiveEmotion();

    // Set bottomTitle to translated label.
    if (data["id"] == "negative_emotion") legendLabel = labels.basicLabelsNegativeEmotion();

    // Access color by id.
    final Color pieColor = HelperFunctions.getColorById(id: data['color'] ?? "")?.color ?? HelperFunctions.getRandomColor();

    return PieItem.initial().copyWith(
      id: data['id'],
      value: value,
      title: title,
      color: pieColor,
      legendLabel: legendLabel,
      legendValue: data['legend_value'],
      legendSuffix: data['legend_suffix'],
      referenceType: data['reference_type'],
      referenceId: data['reference_id'],
    );
  }

  PieItem copyWith({
    String? id,
    Color? color,
    String? title,
    double? value,
    String? legendLabel,
    double? legendValue,
    String? legendSuffix,
    String? referenceType,
    String? referenceId,
  }) {
    return PieItem(
      id: id ?? this.id,
      color: color ?? this.color,
      title: title ?? this.title,
      value: value ?? this.value,
      legendLabel: legendLabel ?? this.legendLabel,
      legendValue: legendValue ?? this.legendValue,
      legendSuffix: legendSuffix ?? this.legendSuffix,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
    );
  }
}
