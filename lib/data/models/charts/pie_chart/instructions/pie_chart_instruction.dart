import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Models.
import 'pie_instruction.dart';

class PieChartInstruction extends Equatable {
  final String id;

  final PieInstruction pieInstruction;

  const PieChartInstruction({
    required this.id,
    required this.pieInstruction,
  });

  @override
  List<Object> get props => [
        id,
        pieInstruction,
      ];

  /// Initialize a new ```PieChartInstruction``` object.
  factory PieChartInstruction.initial() {
    return PieChartInstruction(
      id: const Uuid().v4(),
      pieInstruction: PieInstruction.initial(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load expenseDataMemberCostsOfOverallCosts.
  factory PieChartInstruction.expenseDataMemberCostsOfOverallCosts() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.expenseDataMemberCostsOfOverallCosts(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load expenseDataMemberCostSharesByTag.
  factory PieChartInstruction.expenseDataMemberCostSharesByTag() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.expenseDataMemberCostSharesByTag(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load expenseDataOverallCostSharesByTag.
  factory PieChartInstruction.expenseDataOverallCostSharesByTag() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.expenseDataOverallCostSharesByTag(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load booleanDataTrueFalseDistribution.
  factory PieChartInstruction.booleanDataTrueFalseDistribution() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.booleanDataTrueFalseDistribution(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load emailDataFrequencyShares.
  factory PieChartInstruction.emailDataFrequencyShares() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.emailDataFrequencyShares(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load emailDataProviderDistribution.
  factory PieChartInstruction.emailDataProviderDistribution() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.emailDataProviderDistribution(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load usernameDataUsernameDistribution.
  factory PieChartInstruction.usernameDataUsernameDistribution() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.usernameDataUsernameDistribution(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load avatarImageDataHasImageDistribution.
  factory PieChartInstruction.avatarImageDataHasImageDistribution() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.avatarImageDataHasImageDistribution(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load avatarImageDataHasTitleDistribution.
  factory PieChartInstruction.avatarImageDataHasTitleDistribution() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.avatarImageDataHasTitleDistribution(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load avatarImageDataHasTextDistribution.
  factory PieChartInstruction.avatarImageDataHasTextDistribution() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.avatarImageDataHasTextDistribution(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load birthdayDataSeasonalBirthdays.
  factory PieChartInstruction.birthdayDataSeasonalBirthdays() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.birthdayDataSeasonalBirthdays(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load moneyDataCurrencyDistribution.
  factory PieChartInstruction.moneyDataCurrencyDistribution() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.moneyDataCurrencyDistribution(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load moneyDataExpensesByCategory.
  factory PieChartInstruction.moneyDataExpensesByCategory() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.moneyDataExpensesByCategory(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load moneyDataIncomeByCategory.
  factory PieChartInstruction.moneyDataIncomeByCategory() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.moneyDataIncomeByCategory(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load tagsDataEntriesShareByTag.
  factory PieChartInstruction.tagsDataEntriesShareByTag() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.tagsDataEntriesShareByTag(),
    );
  }

  /// Initialize a ```PieChartInstruction``` to load emotionDataProportionPositiveAndNegativeEmotions.
  factory PieChartInstruction.emotionDataProportionPositiveAndNegativeEmotions() {
    return PieChartInstruction.initial().copyWith(
      pieInstruction: PieInstruction.emotionDataProportionPositiveAndNegativeEmotions(),
    );
  }

  PieChartInstruction copyWith({
    String? id,
    PieInstruction? pieInstruction,
  }) {
    return PieChartInstruction(
      id: id ?? this.id,
      pieInstruction: pieInstruction ?? this.pieInstruction,
    );
  }
}
