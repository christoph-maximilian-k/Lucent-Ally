import 'package:equatable/equatable.dart';

import 'package:uuid/uuid.dart';

// Models.
import '/data/models/fields/field.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/money_data/money_data.dart';

class BarInstruction extends Equatable {
  final String id;

  final String fieldType;
  final String instructionType;

  const BarInstruction({
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

  /// Initialize a new ```BarInstruction``` object.
  factory BarInstruction.initial() {
    return BarInstruction(
      id: const Uuid().v4(),
      fieldType: '',
      instructionType: '',
    );
  }

  // #########################################################
  // Static Instruction
  // #########################################################

  /// This can be used to create instructions to show debt balances of all members.
  factory BarInstruction.expenseDataDebtBalancesAllMembers() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionMembersDebtBalances,
    );
  }

  /// This can be used to create instructions to show total costs of all members.
  factory BarInstruction.expenseDataTotalCostsAllMembers() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionMembersTotalCosts,
    );
  }

  /// This can be used to create instructions to show total costs of a member over time.
  factory BarInstruction.expenseDataCostsByMemberOverTime() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionCostsByMemberOverTime,
    );
  }

  /// This can be used to create instructions to show total costs of a member by tag.
  factory BarInstruction.expenseDataMemberCostsByTag() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionMemberCostsByTag,
    );
  }

  /// This can be used to create instructions to show the absolut expenses of a member over time.
  factory BarInstruction.expenseDataAbsolutExpensesByMemberOverTime() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionMemberAbsolutExpensesOverTime,
    );
  }

  /// This can be used to create instructions to show the absolut income of a member over time.
  factory BarInstruction.expenseDataAbsolutIncomeByMemberOverTime() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionMemberAbsolutIncomeOverTime,
    );
  }

  /// This can be used to create instructions to show the absolut profits and losses over time for a member.
  factory BarInstruction.expenseDataAbsolutProfitsAndLossesOverTime() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionMemberAbsolutProfitsAndLosses,
    );
  }

  /// This can be used to create instructions to show the overall costs by tag.
  factory BarInstruction.expenseDataOverallCostsByTag() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.chartInstructionOverallCostsByTag,
    );
  }

  /// This can be used to create instructions to show numerical order of number data.
  factory BarInstruction.numberDataNumericalOrder() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeNumber,
      instructionType: NumberData.chartInstructionNumericalOrder,
    );
  }

  /// This can be used to create instructions to show true false history.
  factory BarInstruction.booleanDataTrueFalseHistory() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeBoolean,
      instructionType: BooleanData.barChartTrueFalseHistory,
    );
  }

  /// This can be used to create instructions to show true false history.
  factory BarInstruction.emailDataFrequencyDistribution() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeEmail,
      instructionType: EmailData.barChartFrequencyDistribution,
    );
  }

  /// This can be used to create instructions to show birthdays per month.
  factory BarInstruction.birthdayDataBirthdaysPerMonth() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeDateOfBirth,
      instructionType: DateOfBirthData.barChartBirthdaysPerMonth,
    );
  }

  /// This can be used to create instructions to number of entries in category.
  factory BarInstruction.tagsDataEntriesByTag() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeTags,
      instructionType: TagsData.barChartEntriesByTag,
    );
  }

  /// This can be used to create a chart that shows the average intensity by emotion.
  factory BarInstruction.emotionDataAverageIntensityByEmotion() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeEmotion,
      instructionType: EmotionData.barChartAverageIntensityByEmotion,
    );
  }

  /// This can be used to create a chart that shows the average wellbeing over time.
  factory BarInstruction.averageWellbeingOverTime() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeEmotion,
      instructionType: EmotionData.barChartAverageWellbeing,
    );
  }

  /// This can be used to create a chart that shows the progression of a measurement value.
  factory BarInstruction.measurementDataProgressionOfValue() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMeasurement,
      instructionType: MeasurementData.barChartProgressionOfValue,
    );
  }

  /// This can be used to create instructions to show income over time.
  factory BarInstruction.moneyDataIncomeOverTime() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMoney,
      instructionType: MoneyData.chartInstructionIncomeOverTime,
    );
  }

  /// This can be used to create instructions to show income over time.
  factory BarInstruction.moneyDataExpensesOverTime() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMoney,
      instructionType: MoneyData.chartInstructionExpensesOverTime,
    );
  }

  /// This can be used to create instructions to show income over time.
  factory BarInstruction.moneyDataValuesByEntry() {
    return BarInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMoney,
      instructionType: MoneyData.chartInstructionValuesByEntry,
    );
  }

  BarInstruction copyWith({
    String? id,
    String? fieldType,
    String? instructionType,
  }) {
    return BarInstruction(
      id: id ?? this.id,
      fieldType: fieldType ?? this.fieldType,
      instructionType: instructionType ?? this.instructionType,
    );
  }
}
