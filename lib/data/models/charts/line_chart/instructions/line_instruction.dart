import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Models.
import '/data/models/fields/field.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/money_data/money_data.dart';

class LineInstruction extends Equatable {
  final String id;

  final String fieldType;
  final String instructionType;

  const LineInstruction({
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

  /// Initialize a new ```LineInstruction``` object.
  factory LineInstruction.initial() {
    return LineInstruction(
      id: const Uuid().v4(),
      fieldType: '',
      instructionType: '',
    );
  }

  // #########################################################
  // Static Instructions
  // #########################################################

  /// This can be used to create instructions to show numerical progression of number data individual values.
  factory LineInstruction.numberDataNumericalProgressionIndividual() {
    return LineInstruction.initial().copyWith(
      fieldType: Field.fieldTypeNumber,
      instructionType: NumberData.chartInstructionNumericalProgressionIndividual,
    );
  }

  /// This can be used to create instructions to show numerical progression of number data accumualted values.
  factory LineInstruction.numberDataNumericalProgressionAccumulated() {
    return LineInstruction.initial().copyWith(
      fieldType: Field.fieldTypeNumber,
      instructionType: NumberData.chartInstructionNumericalProgressionAccumulated,
    );
  }

  /// This can be used to create instructions to show numerical progression of money data accumulated.
  factory LineInstruction.moneyDataValueOverTimeAccumulated() {
    return LineInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMoney,
      instructionType: MoneyData.chartInstructionMoneyProgressionAccumulated,
    );
  }

  LineInstruction copyWith({
    String? id,
    String? fieldType,
    String? instructionType,
  }) {
    return LineInstruction(
      id: id ?? this.id,
      fieldType: fieldType ?? this.fieldType,
      instructionType: instructionType ?? this.instructionType,
    );
  }
}
