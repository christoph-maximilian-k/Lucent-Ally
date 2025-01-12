import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Models.
import '/data/models/fields/field.dart';
import '../../../field_types/payment_data/payment_data.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';

class PieInstruction extends Equatable {
  final String id;

  final String fieldType;
  final String instructionType;

  const PieInstruction({
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

  /// Initialize a new ```PieInstruction``` object.
  factory PieInstruction.initial() {
    return PieInstruction(
      id: const Uuid().v4(),
      fieldType: '',
      instructionType: '',
    );
  }

  // #########################################################
  // Static Instruction
  // #########################################################

  /// This can be used to create instructions to show member costs of overall costs.
  factory PieInstruction.expenseDataMemberCostsOfOverallCosts() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.pieChartMemberCostsOfOverallCosts,
    );
  }

  /// This can be used to create instructions to show member cost shares by tag.
  factory PieInstruction.expenseDataMemberCostSharesByTag() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.pieChartMemberCostSharesByTag,
    );
  }

  /// This can be used to create instructions to show overall cost shares by tag.
  factory PieInstruction.expenseDataOverallCostSharesByTag() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypePayment,
      instructionType: PaymentData.pieChartOverallCostSharesByTag,
    );
  }

  /// This can be used to create instructions to show true false distribution.
  factory PieInstruction.booleanDataTrueFalseDistribution() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeBoolean,
      instructionType: BooleanData.pieChartTrueFalseDistribution,
    );
  }

  /// This can be used to create instructions to email frequency shares.
  factory PieInstruction.emailDataFrequencyShares() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeEmail,
      instructionType: EmailData.pieChartFrequencyShares,
    );
  }

  /// This can be used to create instructions to email frequency distribution.
  factory PieInstruction.emailDataProviderDistribution() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeEmail,
      instructionType: EmailData.pieChartProviderDistribution,
    );
  }

  /// This can be used to create instructions to username frequency distribution.
  factory PieInstruction.usernameDataUsernameDistribution() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeUsername,
      instructionType: UsernameData.pieChartUsernameDistribution,
    );
  }

  /// This can be used to create instructions to show which entries have an avatar image set.
  factory PieInstruction.avatarImageDataHasImageDistribution() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeAvatarImage,
      instructionType: AvatarImageData.pieChartHasImageDistribution,
    );
  }

  /// This can be used to create instructions to show which entries have an avatar title set.
  factory PieInstruction.avatarImageDataHasTitleDistribution() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeAvatarImage,
      instructionType: AvatarImageData.pieChartHasTitleDistribution,
    );
  }

  /// This can be used to create instructions to show which entries have an avatar text set.
  factory PieInstruction.avatarImageDataHasTextDistribution() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeAvatarImage,
      instructionType: AvatarImageData.pieChartHasTextDistribution,
    );
  }

  /// This can be used to create instructions to show seasonal distribution of birthdays.
  factory PieInstruction.birthdayDataSeasonalBirthdays() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeDateOfBirth,
      instructionType: DateOfBirthData.pieChartSeasonalBirthdayDistribution,
    );
  }

  /// This can be used to create instructions to show moneyDataCurrencyDistribution.
  factory PieInstruction.moneyDataCurrencyDistribution() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMoney,
      instructionType: MoneyData.pieChartCurrencyDistribution,
    );
  }

  /// This can be used to create instructions to show moneyDataExpensesByCategory.
  factory PieInstruction.moneyDataExpensesByCategory() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMoney,
      instructionType: MoneyData.pieChartExpensesByCategory,
    );
  }

  /// This can be used to create instructions to show moneyDataIncomeByCategory.
  factory PieInstruction.moneyDataIncomeByCategory() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeMoney,
      instructionType: MoneyData.pieChartIncomeByCategory,
    );
  }

  /// This can be used to create instructions to show tagsDataEntriesShareByTag.
  factory PieInstruction.tagsDataEntriesShareByTag() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeTags,
      instructionType: TagsData.pieChartEntriesShareByTag,
    );
  }

  /// This can be used to create instructions to show emotionDataProportionPositiveAndNegativeEmotions.
  factory PieInstruction.emotionDataProportionPositiveAndNegativeEmotions() {
    return PieInstruction.initial().copyWith(
      fieldType: Field.fieldTypeEmotion,
      instructionType: EmotionData.pieChartPositiveAndNegativeEmotionsProportion,
    );
  }

  PieInstruction copyWith({
    String? id,
    String? fieldType,
    String? instructionType,
  }) {
    return PieInstruction(
      id: id ?? this.id,
      fieldType: fieldType ?? this.fieldType,
      instructionType: instructionType ?? this.instructionType,
    );
  }
}
