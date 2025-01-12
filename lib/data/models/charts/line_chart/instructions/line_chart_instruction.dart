import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Models.
import 'line_instruction.dart';

class LineChartInstruction extends Equatable {
  final String id;

  // * Grid in the background.
  final bool showHorizontalGridLine;
  final bool showVerticalGridLine;

  // * Top Axis Data.
  final bool showTopBorder;

  // * Bottom Axis Data.
  final bool showBottomBorder;
  final String bottomAxisName;

  // * Left Axis Data.
  final bool showLeftBorder;

  // * Right Axis Data.
  final bool showRightBorder;

  final LineInstruction lineInstruction;

  const LineChartInstruction({
    required this.id,
    required this.showHorizontalGridLine,
    required this.showVerticalGridLine,
    required this.showTopBorder,
    required this.showBottomBorder,
    required this.bottomAxisName,
    required this.showLeftBorder,
    required this.showRightBorder,
    required this.lineInstruction,
  });

  @override
  List<Object> get props => [
        id,
        showHorizontalGridLine,
        showVerticalGridLine,
        showTopBorder,
        showBottomBorder,
        bottomAxisName,
        showLeftBorder,
        showRightBorder,
        lineInstruction,
      ];

  /// Initialize a new ```LineChartInstruction``` object.
  factory LineChartInstruction.initial() {
    return LineChartInstruction(
      id: const Uuid().v4(),
      showHorizontalGridLine: true,
      showVerticalGridLine: false,
      showTopBorder: false,
      showBottomBorder: true,
      bottomAxisName: '',
      showLeftBorder: true,
      showRightBorder: false,
      lineInstruction: LineInstruction.initial(),
    );
  }

  /// Initialize a ```LineChartInstruction``` to load numberDataNumericalProgressionIndividual.
  factory LineChartInstruction.numberDataNumericalProgressionIndividual() {
    return LineChartInstruction.initial().copyWith(
      lineInstruction: LineInstruction.numberDataNumericalProgressionIndividual(),
    );
  }

  /// Initialize a ```LineChartInstruction``` to load numberDataNumericalProgressionAccumulated.
  factory LineChartInstruction.numberDataNumericalProgressionAccumulated() {
    return LineChartInstruction.initial().copyWith(
      lineInstruction: LineInstruction.numberDataNumericalProgressionAccumulated(),
    );
  }

  /// Initialize a ```LineChartInstruction``` to load moneyDataValueOverTimeAccumulated.
  factory LineChartInstruction.moneyDataValueOverTimeAccumulated() {
    return LineChartInstruction.initial().copyWith(
      lineInstruction: LineInstruction.moneyDataValueOverTimeAccumulated(),
    );
  }

  LineChartInstruction copyWith({
    String? id,
    bool? showHorizontalGridLine,
    bool? showVerticalGridLine,
    bool? showTopBorder,
    bool? showBottomBorder,
    String? bottomAxisName,
    bool? showLeftBorder,
    bool? showRightBorder,
    LineInstruction? lineInstruction,
  }) {
    return LineChartInstruction(
      id: id ?? this.id,
      showHorizontalGridLine: showHorizontalGridLine ?? this.showHorizontalGridLine,
      showVerticalGridLine: showVerticalGridLine ?? this.showVerticalGridLine,
      showTopBorder: showTopBorder ?? this.showTopBorder,
      showBottomBorder: showBottomBorder ?? this.showBottomBorder,
      bottomAxisName: bottomAxisName ?? this.bottomAxisName,
      showLeftBorder: showLeftBorder ?? this.showLeftBorder,
      showRightBorder: showRightBorder ?? this.showRightBorder,
      lineInstruction: lineInstruction ?? this.lineInstruction,
    );
  }
}
