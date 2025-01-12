import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// User, with labels and settings.
import '/main.dart';

// Logic.
import '/logic/helper_functions/helper_functions.dart';

// Models.
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/picker_items/color_item.dart';

class BarItem extends Equatable {
  final String id;

  final double barWidth;
  final Color barColor;

  final String topTitle;
  final String bottomTitle;
  final String rightTitle;

  final double yAxisValue;

  final String referenceType;
  final String referenceId;

  const BarItem({
    required this.id,
    required this.barWidth,
    required this.barColor,
    required this.topTitle,
    required this.bottomTitle,
    required this.rightTitle,
    required this.yAxisValue,
    required this.referenceType,
    required this.referenceId,
  });

  @override
  List<Object> get props => [
        id,
        barWidth,
        barColor,
        topTitle,
        bottomTitle,
        rightTitle,
        yAxisValue,
        referenceType,
        referenceId,
      ];

  /// Initialize a new ```BarItem``` object.
  factory BarItem.initial() {
    return BarItem(
      id: const Uuid().v4(),
      topTitle: '',
      barColor: Colors.amber,
      barWidth: 10.0,
      bottomTitle: '',
      rightTitle: '',
      yAxisValue: 0.0,
      referenceType: '',
      referenceId: '',
    );
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode a ```BarItem``` from request JSON.
  static BarItem fromCloudObject(data) {
    // Parse yAxisValue.
    final double yAxisValue = data['y_axis_value'].toDouble();

    // Access color by id.
    final ColorItem? barColor = HelperFunctions.getColorById(id: data['color']);

    // Access bottomTitle.
    String? bottomTitle = data['bottom_title'] ?? yAxisValue.toStringAsFixed(2);

    // Set bottomTitle to translated label.
    if (data["id"] == "untagged") bottomTitle = labels.basicLabelsNotTagged();

    // Set bottomTitle to translated label.
    if (data["id"] == "others") bottomTitle = labels.basicLabelsOthers();

    // Access emotion.
    final String? translatedEmotion = EmotionData.emotionsByTypeAndLanguage()[data["id"]];

    // If a emotion was found and bottom_title is set to the same emotion as the id, update bottom_title to translated emotion.
    // * The equal check is mainly done to avoid situations where a bottom_title is set to a string that conicides with an emotion but it should not get translated.
    if (translatedEmotion != null && bottomTitle == data["id"]) bottomTitle = translatedEmotion;

    return BarItem.initial().copyWith(
      bottomTitle: bottomTitle,
      rightTitle: data['right_title'] ?? '',
      topTitle: data['top_title'] ?? '',
      yAxisValue: yAxisValue,
      barColor: barColor!.color,
      referenceType: data['reference_id'],
      referenceId: data['reference_id'],
    );
  }

  BarItem copyWith({
    String? id,
    double? barWidth,
    Color? barColor,
    String? topTitle,
    String? bottomTitle,
    String? rightTitle,
    double? yAxisValue,
    String? referenceType,
    String? referenceId,
  }) {
    return BarItem(
      id: id ?? this.id,
      barWidth: barWidth ?? this.barWidth,
      barColor: barColor ?? this.barColor,
      topTitle: topTitle ?? this.topTitle,
      bottomTitle: bottomTitle ?? this.bottomTitle,
      rightTitle: rightTitle ?? this.rightTitle,
      yAxisValue: yAxisValue ?? this.yAxisValue,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
    );
  }
}
