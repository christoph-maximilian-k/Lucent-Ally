import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// User with Settings and Labels.
import '/main.dart';

// Models.
import 'line_dots.dart';

// Helper functions.
import '/logic/helper_functions/helper_functions.dart';

/// A ```LineItem``` represents one line in the chart.
/// I.e. if multiple lines are needed, specify multiple ```LineItems```.
class LineItem extends Equatable {
  final String id;

  final Color color;
  final double lineWidth;
  final bool showDots;
  final bool enableBelowLine;

  final String legendLabel;
  final double? legendValue;
  final String referenceType;
  final String referenceId;

  final LineDots lineDots;

  const LineItem({
    required this.id,
    required this.color,
    required this.lineWidth,
    required this.showDots,
    required this.enableBelowLine,
    required this.lineDots,
    required this.legendLabel,
    required this.legendValue,
    required this.referenceType,
    required this.referenceId,
  });

  @override
  List<Object?> get props => [
        id,
        color,
        lineWidth,
        showDots,
        enableBelowLine,
        lineDots,
        legendLabel,
        legendValue,
        referenceType,
        referenceId,
      ];

  /// Initialize a new ```LineItem``` object.
  factory LineItem.initial() {
    return LineItem(
      id: const Uuid().v4(),
      color: Colors.amber,
      lineWidth: 2.0,
      showDots: false,
      enableBelowLine: false,
      lineDots: LineDots.initial(),
      legendLabel: '',
      legendValue: null,
      referenceType: '',
      referenceId: '',
    );
  }

  // #####################################
  // # Cloud
  // #####################################

  /// This method can be used to decode a ```LineItem``` from request JSON.
  static LineItem fromCloudObject(data) {
    // Convenience variables.
    String legendLabel = data['legend_label'];

    // Set bottomTitle to translated label.
    if (data["id"] == "accumulated") legendLabel = labels.basicLabelsAccumulated();

    // Set bottomTitle to translated label.
    if (data["id"] == "individual") legendLabel = labels.basicLabelsIndividualValues();

    // Access color by id.
    final Color lineColor = HelperFunctions.getColorById(id: data['color'] ?? "")?.color ?? HelperFunctions.getRandomColor();

    return LineItem.initial().copyWith(
      showDots: data['show_dots'],
      enableBelowLine: data['enable_below_line'],
      color: lineColor,
      legendLabel: legendLabel,
      legendValue: data['legend_value'],
      referenceId: data['reference_id'],
      referenceType: data['reference_type'],
      lineDots: LineDots.fromCloudObject(data['line_dots']),
    );
  }

  LineItem copyWith({
    String? id,
    Color? color,
    double? lineWidth,
    bool? showDots,
    bool? enableBelowLine,
    String? legendLabel,
    double? legendValue,
    String? referenceType,
    String? referenceId,
    LineDots? lineDots,
  }) {
    return LineItem(
      id: id ?? this.id,
      color: color ?? this.color,
      lineWidth: lineWidth ?? this.lineWidth,
      showDots: showDots ?? this.showDots,
      enableBelowLine: enableBelowLine ?? this.enableBelowLine,
      legendLabel: legendLabel ?? this.legendLabel,
      legendValue: legendValue ?? this.legendValue,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      lineDots: lineDots ?? this.lineDots,
    );
  }
}
