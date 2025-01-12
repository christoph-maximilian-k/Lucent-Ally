import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class DescriptiveValueInstruction extends Equatable {
  final String id;

  final String fieldType;
  final String instructionType;

  const DescriptiveValueInstruction({
    required this.id,
    required this.fieldType,
    required this.instructionType,
  });

  @override
  List<Object> get props => [
        id,
        fieldType,
        instructionType,
      ];

  /// Initialize a new ```DescriptiveValueInstruction``` object.
  factory DescriptiveValueInstruction.initial() {
    return DescriptiveValueInstruction(
      id: const Uuid().v4(),
      fieldType: '',
      instructionType: '',
    );
  }

  // -------------------------------------
  /// Descriptive Instructions
  /// -------------------------------------

  /// Statistic identification to access the maximum.
  /// ```dart
  /// static const String descriptiveChartInstructionMaximum = 'maximum';
  /// ```
  static const String descriptiveChartInstructionMaximum = 'maximum';

  /// Statistic identification to access the minimum.
  /// ```dart
  /// static const String descriptiveChartInstructionMinimum = 'minimum';
  /// ```
  static const String descriptiveChartInstructionMinimum = 'minimum';

  /// Statistic identification to access the average.
  /// ```dart
  /// static const String descriptiveChartInstructionAverage = 'average';
  /// ```
  static const String descriptiveChartInstructionAverage = 'average';

  /// Statistic identification to access the sum.
  /// ```dart
  /// static const String descriptiveChartInstructionSum = 'sum';
  /// ```
  static const String descriptiveChartInstructionSum = 'sum';

  // #########################################################
  // Static Instruction
  // #########################################################

  /// This can be used to create instructions to show the maximum.
  factory DescriptiveValueInstruction.maximum({required String fieldType}) {
    return DescriptiveValueInstruction.initial().copyWith(
      fieldType: fieldType,
      instructionType: descriptiveChartInstructionMaximum,
    );
  }

  /// This can be used to create instructions to show the minimum.
  factory DescriptiveValueInstruction.minimum({required String fieldType}) {
    return DescriptiveValueInstruction.initial().copyWith(
      fieldType: fieldType,
      instructionType: descriptiveChartInstructionMinimum,
    );
  }

  /// This can be used to create instructions to show the average.
  factory DescriptiveValueInstruction.average({required String fieldType}) {
    return DescriptiveValueInstruction.initial().copyWith(
      fieldType: fieldType,
      instructionType: descriptiveChartInstructionAverage,
    );
  }

  /// This can be used to create instructions to show the sum.
  factory DescriptiveValueInstruction.sum({required String fieldType}) {
    return DescriptiveValueInstruction.initial().copyWith(
      fieldType: fieldType,
      instructionType: descriptiveChartInstructionSum,
    );
  }

  DescriptiveValueInstruction copyWith({
    String? id,
    String? fieldType,
    String? instructionType,
  }) {
    return DescriptiveValueInstruction(
      id: id ?? this.id,
      fieldType: fieldType ?? this.fieldType,
      instructionType: instructionType ?? this.instructionType,
    );
  }
}
