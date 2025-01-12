import 'package:equatable/equatable.dart';

// User with settings and labels.
import '/main.dart';

// Models.
import 'bar_instruction.dart';

class BarChartInstruction extends Equatable {
  // * Grid in the background.
  final bool showHorizontalGridLine;
  final bool showVerticalGridLine;

  // * Top Axis Data.
  final String topAxisName;
  final bool showTopTitles;
  final bool showTopBorder;

  // * Bottom Axis Data.
  final String bottomAxisName;
  final bool showBottomTitles;
  final bool showBottomBorder;

  // * Left Axis Data.
  final String leftAxisName;
  final bool showLeftTitles;
  final bool showLeftBorder;
  final List<String> staticLeftTitles;

  // * Right Axis Data.
  final String rightAxisName;
  final bool showRightTitles;
  final bool showRightBorder;

  // * Bar width.
  final double barWidth;

  // * Instructions.
  final BarInstruction barInstruction;

  const BarChartInstruction({
    // * Grid in the background.
    required this.showHorizontalGridLine,
    required this.showVerticalGridLine,
    // * Top Axis Data.
    required this.topAxisName,
    required this.showTopTitles,
    required this.showTopBorder,
    // * Bottom Axis Data.
    required this.bottomAxisName,
    required this.showBottomTitles,
    required this.showBottomBorder,
    // * Left Axis Data.
    required this.leftAxisName,
    required this.showLeftTitles,
    required this.showLeftBorder,
    required this.staticLeftTitles,
    // * Right Axis Data.
    required this.rightAxisName,
    required this.showRightTitles,
    required this.showRightBorder,
    // * Bar Width.
    required this.barWidth,
    // * Bar Instruction.
    required this.barInstruction,
  });

  @override
  List<Object> get props => [
        // * Grid in the background.
        showHorizontalGridLine,
        showVerticalGridLine,
        // * Top Axis Data.
        topAxisName,
        showTopTitles,
        showTopBorder,
        // * Bottom Axis Data.
        bottomAxisName,
        showBottomTitles,
        showBottomBorder,
        // * Left Axis Data.
        leftAxisName,
        showLeftTitles,
        showLeftBorder,
        staticLeftTitles,
        // * Right Axis Data.
        rightAxisName,
        showRightTitles,
        showRightBorder,
        // * Bar width.
        barWidth,
        // * Bar Instruction.
        barInstruction,
      ];

  /// Initialize a new ```BarChartInstruction``` object.
  factory BarChartInstruction.initial() {
    return BarChartInstruction(
      showHorizontalGridLine: false,
      showVerticalGridLine: false,
      topAxisName: '',
      showTopTitles: true,
      showTopBorder: false,
      bottomAxisName: '',
      showBottomTitles: true,
      showBottomBorder: true,
      leftAxisName: '',
      showLeftTitles: true,
      showLeftBorder: true,
      staticLeftTitles: const [],
      rightAxisName: '',
      showRightTitles: false,
      showRightBorder: false,
      barWidth: 10.0,
      barInstruction: BarInstruction.initial(),
    );
  }

  /// This getter can be used to return static left titles depending on position provided.
  /// * Returns ```null``` if for provided position there was no title specified.
  String? getTitleByPosition({required int position}) {
    if (position >= 0 && position < staticLeftTitles.length) {
      return staticLeftTitles[position];
    }

    return null;
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataDebtBalancesAllMembers.
  factory BarChartInstruction.expenseDataDebtBalancesAllMembers() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.expenseDataDebtBalancesAllMembers(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataTotalCostsAllMembers.
  factory BarChartInstruction.expenseDataTotalCostsAllMembers() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: false,
      barInstruction: BarInstruction.expenseDataTotalCostsAllMembers(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataCostsByMemberOverTime.
  factory BarChartInstruction.expenseDataCostsByMemberOverTime() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.expenseDataCostsByMemberOverTime(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataMemberCostsByTag.
  factory BarChartInstruction.expenseDataMemberCostsByTag() {
    return BarChartInstruction.initial().copyWith(
      barInstruction: BarInstruction.expenseDataMemberCostsByTag(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataAbsolutExpensesByMemberOverTime.
  factory BarChartInstruction.expenseDataAbsolutExpensesByMemberOverTime() {
    return BarChartInstruction.initial().copyWith(
      barInstruction: BarInstruction.expenseDataAbsolutExpensesByMemberOverTime(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataAbsolutIncomeByMemberOverTime.
  factory BarChartInstruction.expenseDataAbsolutIncomeByMemberOverTime() {
    return BarChartInstruction.initial().copyWith(
      barInstruction: BarInstruction.expenseDataAbsolutIncomeByMemberOverTime(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataAbsolutProfitsAndLossesOverTime.
  factory BarChartInstruction.expenseDataAbsolutProfitsAndLossesOverTime() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.expenseDataAbsolutProfitsAndLossesOverTime(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load expenseDataOverallCostsByTag.
  factory BarChartInstruction.expenseDataOverallCostsByTag() {
    return BarChartInstruction.initial().copyWith(
      barInstruction: BarInstruction.expenseDataOverallCostsByTag(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load numberDataNumericalOrder.
  factory BarChartInstruction.numberDataNumericalOrder() {
    return BarChartInstruction.initial().copyWith(
      barInstruction: BarInstruction.numberDataNumericalOrder(),
      showHorizontalGridLine: true,
    );
  }

  /// Initialize a ```BarChartInstruction``` to load booleanDataTrueFalseHistory.
  factory BarChartInstruction.booleanDataTrueFalseHistory() {
    return BarChartInstruction.initial().copyWith(
      // * The first item in this variable is set to an empty String to ensure that the origin value is set to an empty box.
      staticLeftTitles: ['', labels.basicLabelsFalse(), labels.basicLabelsTrue()],
      barInstruction: BarInstruction.booleanDataTrueFalseHistory(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load emailDataFrequencyDistribution.
  factory BarChartInstruction.emailDataFrequencyDistribution() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.emailDataFrequencyDistribution(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load birthdayDataBirthdaysPerMonth.
  factory BarChartInstruction.birthdayDataBirthdaysPerMonth() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.birthdayDataBirthdaysPerMonth(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load tagsDataEntriesByTag.
  factory BarChartInstruction.tagsDataEntriesByTag() {
    return BarChartInstruction.initial().copyWith(
      barInstruction: BarInstruction.tagsDataEntriesByTag(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load emotionDataAverageIntensityByEmotion.
  factory BarChartInstruction.emotionDataAverageIntensityByEmotion() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.emotionDataAverageIntensityByEmotion(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load averageWellbeingOverTime.
  factory BarChartInstruction.averageWellbeingOverTime() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.averageWellbeingOverTime(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load measurementDataProgressionOfValue.
  factory BarChartInstruction.measurementDataProgressionOfValue() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.measurementDataProgressionOfValue(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load moneyDataIncomeOverTime.
  factory BarChartInstruction.moneyDataIncomeOverTime() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.moneyDataIncomeOverTime(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load moneyDataExpensesOverTime.
  factory BarChartInstruction.moneyDataExpensesOverTime() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.moneyDataExpensesOverTime(),
    );
  }

  /// Initialize a ```BarChartInstruction``` to load moneyDataExpensesOverTime.
  factory BarChartInstruction.moneyDataValuesByEntry() {
    return BarChartInstruction.initial().copyWith(
      showHorizontalGridLine: true,
      barInstruction: BarInstruction.moneyDataValuesByEntry(),
    );
  }

  BarChartInstruction copyWith({
    bool? showHorizontalGridLine,
    bool? showVerticalGridLine,
    String? topAxisName,
    bool? showTopTitles,
    bool? showTopBorder,
    String? bottomAxisName,
    bool? showBottomTitles,
    bool? showBottomBorder,
    String? leftAxisName,
    bool? showLeftTitles,
    bool? showLeftBorder,
    List<String>? staticLeftTitles,
    String? rightAxisName,
    bool? showRightTitles,
    bool? showRightBorder,
    double? barWidth,
    BarInstruction? barInstruction,
  }) {
    return BarChartInstruction(
      showHorizontalGridLine: showHorizontalGridLine ?? this.showHorizontalGridLine,
      showVerticalGridLine: showVerticalGridLine ?? this.showVerticalGridLine,
      topAxisName: topAxisName ?? this.topAxisName,
      showTopTitles: showTopTitles ?? this.showTopTitles,
      showTopBorder: showTopBorder ?? this.showTopBorder,
      bottomAxisName: bottomAxisName ?? this.bottomAxisName,
      showBottomTitles: showBottomTitles ?? this.showBottomTitles,
      showBottomBorder: showBottomBorder ?? this.showBottomBorder,
      leftAxisName: leftAxisName ?? this.leftAxisName,
      showLeftTitles: showLeftTitles ?? this.showLeftTitles,
      showLeftBorder: showLeftBorder ?? this.showLeftBorder,
      staticLeftTitles: staticLeftTitles ?? this.staticLeftTitles,
      rightAxisName: rightAxisName ?? this.rightAxisName,
      showRightTitles: showRightTitles ?? this.showRightTitles,
      showRightBorder: showRightBorder ?? this.showRightBorder,
      barWidth: barWidth ?? this.barWidth,
      barInstruction: barInstruction ?? this.barInstruction,
    );
  }
}
