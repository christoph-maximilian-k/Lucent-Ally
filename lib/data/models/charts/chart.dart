import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// Labels.
import '/main.dart';

// Models.
import 'descriptive_chart/descriptive_value_instruction.dart';
import 'bar_chart/instructions/bar_chart_instruction.dart';
import 'pie_chart/instructions/pie_chart_instruction.dart';
import 'line_chart/instructions/line_chart_instruction.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/members/member.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/charts/pie_chart/items/pie_items.dart';
import '/data/models/charts/line_chart/items/line_items.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/fields/field.dart';

import '/data/models/failure.dart';

class Chart extends Equatable {
  final String chartId;
  final String chartType;

  final DateTime createdAt;
  final DateTime editedAt;

  // * Descriptive value cache.
  final List<DescriptiveValueInstruction>? descriptiveValueInstructions;

  final DescriptiveValueInstruction? cachedDescriptiveValueInstruction;
  final double? cachedDescriptiveValue;

  // * Bar Chart Instructions.
  final BarChartInstruction? barChartInstruction;
  final BarItems? cachedBarItems;

  // * Pie Chart Instructions.
  final PieChartInstruction? pieChartInstruction;
  final PieItems? cachedPieItems;

  // * Line Chart Instructions.
  final LineChartInstruction? lineChartInstruction;
  final LineItems? cachedLineItems;

  // * State variables.
  final bool showFilterByTimeInterval;
  final bool showFilterByMember;
  final bool showFilterByYear;
  final bool showFilterByField;

  final bool allowFilterForAllFields;

  final Member? filterByMember;
  final String? filterByTimeInterval;
  final DateTime? filterByYear;
  final String filterByFieldId;
  final String filterByMeasurementCategory;
  final String filterByMeasurementUnit;

  final bool showActionButton;

  final String loadingMessage;

  const Chart({
    required this.chartId,
    required this.chartType,
    required this.createdAt,
    required this.editedAt,
    // * Instructions and cache.
    this.descriptiveValueInstructions,
    this.cachedDescriptiveValueInstruction,
    this.cachedDescriptiveValue,
    this.barChartInstruction,
    this.cachedBarItems,
    this.pieChartInstruction,
    this.cachedPieItems,
    this.lineChartInstruction,
    this.cachedLineItems,
    // * State variables.
    required this.showFilterByTimeInterval,
    required this.showFilterByField,
    required this.showFilterByMember,
    required this.showFilterByYear,
    this.filterByMember,
    this.filterByTimeInterval,
    this.filterByYear,
    this.filterByFieldId = '',
    this.allowFilterForAllFields = true,
    this.showActionButton = false,
    this.filterByMeasurementCategory = '',
    this.filterByMeasurementUnit = '',
    this.loadingMessage = '',
  });

  @override
  List<Object?> get props => [
        chartId,
        chartType,
        createdAt,
        editedAt,
        // * Descriptive value.
        descriptiveValueInstructions,
        cachedDescriptiveValueInstruction,
        cachedDescriptiveValue,
        // * Bar Chart.
        barChartInstruction,
        cachedBarItems,
        // * Pie Chart.
        pieChartInstruction,
        cachedPieItems,
        // * Line Chart.
        lineChartInstruction,
        cachedLineItems,
        // * State Variables.
        showFilterByTimeInterval,
        showFilterByField,
        showFilterByMember,
        showFilterByYear,
        filterByMember,
        filterByTimeInterval,
        filterByYear,
        filterByFieldId,
        filterByMeasurementCategory,
        filterByMeasurementUnit,
        showActionButton,
        allowFilterForAllFields,
        loadingMessage,
      ];

  /// Chart identification for a bar chart.
  /// ```dart
  /// static const String chartTypeBarChart = 'bar_chart';
  /// ```
  static const String chartTypeBarChart = 'bar_chart';

  /// Chart identification for a pie chart.
  /// ```dart
  /// static const String chartTypePieChart = 'pie_chart';
  /// ```
  static const String chartTypePieChart = 'pie_chart';

  /// Chart identification for a line chart.
  /// ```dart
  /// static const String chartTypeLineChart = 'line_chart';
  /// ```
  static const String chartTypeLineChart = 'line_chart';

  /// Chart identification for a descriptive chart.
  /// ```dart
  /// static const String chartTypeDescriptiveChart = 'descriptive_chart';
  /// ```
  static const String chartTypeDescriptiveChart = 'descriptive_chart';

  /// Initialize a new ```Chart``` object.
  factory Chart.initial() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: '',
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      showFilterByTimeInterval: false,
      showFilterByField: false,
      showFilterByMember: false,
      showFilterByYear: false,
    );
  }

  /// Convert to a cached chart variant.
  Chart toCachedBarChart({required BarItems barItems}) {
    return copyWith(
      chartId: const Uuid().v4(),
      cachedBarItems: barItems,
      loadingMessage: '',
    );
  }

  /// Convert to a cached chart variant.
  Chart toCachedPieChart({required PieItems pieItems}) {
    return copyWith(
      chartId: const Uuid().v4(),
      cachedPieItems: pieItems,
    );
  }

  /// Convert to a cached chart variant.
  Chart toCachedLineChart({required LineItems lineItems}) {
    return copyWith(
      chartId: const Uuid().v4(),
      cachedLineItems: lineItems,
    );
  }

  // #########################################################
  // Static Descriptive Value Charts
  // #########################################################

  /// This can be used to create a Chart that shows maximum, minimum, average and sum of selected field type.
  factory Chart.descriptiveValuesChart({required String fieldType, required String filterByFieldId, required String filterByMeasurementCategory, required String filterByMeasurementUnit}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeDescriptiveChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      // * Instructions.
      descriptiveValueInstructions: [
        DescriptiveValueInstruction.maximum(fieldType: fieldType),
        DescriptiveValueInstruction.minimum(fieldType: fieldType),
        DescriptiveValueInstruction.average(fieldType: fieldType),
        DescriptiveValueInstruction.sum(fieldType: fieldType),
      ],
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: true,
      filterByMeasurementCategory: filterByMeasurementCategory,
      filterByMeasurementUnit: filterByMeasurementUnit,
    );
  }

  // #########################################################
  // Static Payment Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows debt balances of all members of expense data field.
  factory Chart.expenseDataDebtBalancesAllMembers() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataDebtBalancesAllMembers(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
      showActionButton: true,
    );
  }

  /// This can be used to create a Chart that shows the total costs of all members of expense data field.
  factory Chart.expenseDataTotalCostsAllMembers() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataTotalCostsAllMembers(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Chart that shows costs of a member over time.
  factory Chart.expenseDataCostsByMemberOverTime({required Member? filterByMember}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataCostsByMemberOverTime(),
      // * State variables.
      showFilterByTimeInterval: true,
      showFilterByField: true,
      showFilterByMember: true,
      showFilterByYear: true,
      filterByMember: filterByMember,
      filterByYear: DateTime.now(),
      filterByTimeInterval: PickerItem.intervalMonthly,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Chart that shows member specific costs by Tag.
  factory Chart.expenseDataMemberCostsByTag({required Member? filterByMember}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataMemberCostsByTag(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: true,
      showFilterByYear: true,
      filterByMember: filterByMember,
      filterByYear: DateTime.now(),
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Chart that shows absolut expenses of a member over time.
  factory Chart.expenseDataAbsolutExpensesByMemberOverTime({required Member? filterByMember}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataAbsolutExpensesByMemberOverTime(),
      // * State variables.
      showFilterByTimeInterval: true,
      showFilterByField: true,
      showFilterByMember: true,
      showFilterByYear: true,
      filterByMember: filterByMember,
      filterByYear: DateTime.now(),
      filterByTimeInterval: PickerItem.intervalMonthly,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Chart that shows absolut income of a member over time.
  factory Chart.expenseDataAbsolutIncomeByMemberOverTime({required Member? filterByMember}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataAbsolutIncomeByMemberOverTime(),
      // * State variables.
      showFilterByTimeInterval: true,
      showFilterByField: true,
      showFilterByMember: true,
      showFilterByYear: true,
      filterByMember: filterByMember,
      filterByYear: DateTime.now(),
      filterByTimeInterval: PickerItem.intervalMonthly,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Chart that shows the absolut profits and losses over time.
  factory Chart.expenseDataAbsolutProfitsAndLossesOverTime({required Member? filterByMember}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataAbsolutProfitsAndLossesOverTime(),
      // * State variables.
      showFilterByTimeInterval: true,
      showFilterByField: true,
      showFilterByMember: true,
      showFilterByYear: true,
      filterByMember: filterByMember,
      filterByYear: DateTime.now(),
      filterByTimeInterval: PickerItem.intervalMonthly,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Chart that shows the overall costs by tag.
  factory Chart.expenseDataOverallCostsByTag() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.expenseDataOverallCostsByTag(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      filterByYear: DateTime.now(),
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Payment Pie Charts
  // #########################################################

  /// This can be used to create a Pie Chart that shows member percentage of overall costs.
  factory Chart.expenseDataMemberCostsOfOverallCosts({required Member? filterByMember}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.expenseDataMemberCostsOfOverallCosts(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: true,
      filterByMember: filterByMember,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Pie Chart that shows member cost shares by tag.
  factory Chart.expenseDataMemberCostSharesByTag({required Member? filterByMember}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.expenseDataMemberCostSharesByTag(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: true,
      filterByMember: filterByMember,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Pie Chart that shows total costs shares by tag.
  factory Chart.expenseDataOverallCostSharesByTag() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.expenseDataOverallCostSharesByTag(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: false,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Number Data Line Charts
  // #########################################################

  /// This can be used to create a Line Chart that shows numerical progression of individual values.
  factory Chart.numberDataNumericalProgressionIndividual({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeLineChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      lineChartInstruction: LineChartInstruction.numberDataNumericalProgressionIndividual(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all number fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  /// This can be used to create a Line Chart that shows numerical progression of accumulated values.
  factory Chart.numberDataNumericalProgressionAccumulated({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeLineChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      lineChartInstruction: LineChartInstruction.numberDataNumericalProgressionAccumulated(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all number fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  // #########################################################
  // Static Number Data Bar Charts
  // #########################################################

  /// This can be used to create a Bar Chart that shows numerical order.
  factory Chart.numberDataNumericalOrder({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.numberDataNumericalOrder(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all number fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: true,
    );
  }

  // #########################################################
  // Static Boolean Data Pie Charts
  // #########################################################

  /// This can be used to create a Pie Chart that shows true/false distribution.
  factory Chart.booleanDataTrueFalseDistribution({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.booleanDataTrueFalseDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all boolean fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  // #########################################################
  // Static Boolean Data Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows the historic distribution of true and false by entry.
  factory Chart.booleanDataTrueFalseHistory({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.booleanDataTrueFalseHistory(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  // #########################################################
  // Static Email Data Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows the frequency distribution of emails.
  factory Chart.emailDataFrequencyDistribution() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.emailDataFrequencyDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all email fields.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Email Data Pie Charts
  // #########################################################

  /// This can be used to create a Pie Chart that shows frequency shares.
  factory Chart.emailDataFrequencyShares() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.emailDataFrequencyShares(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all boolean fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Pie Chart that shows provider distribution.
  factory Chart.emailDataProviderDistribution() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.emailDataProviderDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all boolean fields.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Username Data Pie Charts
  // #########################################################

  /// This can be used to create a Pie Chart that shows frequency shares.
  factory Chart.usernameDataUsernameDistribution() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.usernameDataUsernameDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all boolean fields.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Avatar Image Data Pie Charts
  // #########################################################

  /// This can be used to create a Pie Chart that shows shares of which entries have an image set.
  factory Chart.avatarImageDataHasImageDistribution() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.avatarImageDataHasImageDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: false,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: '',
      allowFilterForAllFields: false,
    );
  }

  /// This can be used to create a Pie Chart that shows shares of which entries have an avatar image title set.
  factory Chart.avatarImageDataHasTitleDistribution({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.avatarImageDataHasTitleDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all boolean fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  /// This can be used to create a Pie Chart that shows shares of which entries have an avatar image text set.
  factory Chart.avatarImageDataHasTextDistribution({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.avatarImageDataHasTextDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all boolean fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  // #########################################################
  // Static Birthday Data Pie Charts
  // #########################################################

  /// This can be used to create a Pie Chart that shows seasonal distribution of birthdays.
  factory Chart.birthdayDataSeasonalBirthdays() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.birthdayDataSeasonalBirthdays(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Birthday Data Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows the number of birthdays per month.
  factory Chart.birthdayDataBirthdaysPerMonth() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.birthdayDataBirthdaysPerMonth(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all email fields.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Birthday Data Pie Charts
  // #########################################################

  /// This can be used to create a Pie Chart that shows currency distribution.
  factory Chart.moneyDataCurrencyDistribution() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.moneyDataCurrencyDistribution(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Pie Chart that expenses by category.
  factory Chart.moneyDataExpensesByCategory({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.moneyDataExpensesByCategory(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: filterByFieldId,
    );
  }

  /// This can be used to create a Pie Chart that income by category.
  factory Chart.moneyDataIncomeByCategory({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.moneyDataIncomeByCategory(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: filterByFieldId,
    );
  }

  // #########################################################
  // Static Money Data Line Charts
  // #########################################################

  /// This can be used to create a Line Chart that shows numerical progression accumulated.
  factory Chart.moneyDataValueOverTimeAccumulated({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeLineChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      lineChartInstruction: LineChartInstruction.moneyDataValueOverTimeAccumulated(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all number fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  // #########################################################
  // Static Money Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows income over time.
  factory Chart.moneyDataIncomeOverTime({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.moneyDataIncomeOverTime(),
      // * State variables.
      showFilterByTimeInterval: true,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      filterByTimeInterval: PickerItem.intervalDaily,
      // * Setting filterByFieldId to an empty String will result in considering all money fields.
      filterByFieldId: filterByFieldId,
    );
  }

  /// This can be used to create a Chart that shows expenses over time.
  factory Chart.moneyDataExpensesOverTime({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.moneyDataExpensesOverTime(),
      // * State variables.
      showFilterByTimeInterval: true,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      filterByTimeInterval: PickerItem.intervalDaily,
      // * Setting filterByFieldId to an empty String will result in considering all money fields.
      filterByFieldId: filterByFieldId,
    );
  }

  /// This can be used to create a Line Chart that shows values by entry.
  factory Chart.moneyDataValuesByEntry({required String filterByFieldId}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.moneyDataValuesByEntry(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Setting filterByFieldId to an empty String will result in considering all money fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
    );
  }

  // #########################################################
  // Static Tags Data Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows number of entries in a category.
  factory Chart.tagsDataEntriesByTag() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.tagsDataEntriesByTag(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all tags fields.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Tags Data Pie Charts
  // #########################################################

  /// This can be used to create a Chart that shows number of entries in a category.
  factory Chart.tagsDataEntriesShareByTag() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.tagsDataEntriesShareByTag(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Emotion Data Pie Charts
  // #########################################################

  /// This can be used to create a Chart that shows proportion of positive and negative emotions.
  factory Chart.emotionDataProportionPositiveAndNegativeEmotions() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypePieChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      pieChartInstruction: PieChartInstruction.emotionDataProportionPositiveAndNegativeEmotions(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all fields of type.
      filterByFieldId: '',
    );
  }

  // #########################################################
  // Static Emotion Data Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows average intensity by emotion.
  factory Chart.emotionDataAverageIntensityByEmotion() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.emotionDataAverageIntensityByEmotion(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all tags fields.
      filterByFieldId: '',
    );
  }

  /// This can be used to create a Chart that shows average wellbeing over time.
  factory Chart.averageWellbeingOverTime() {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.averageWellbeingOverTime(),
      // * State variables.
      showFilterByTimeInterval: true,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: false,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all emotion fields.
      filterByFieldId: '',
      filterByTimeInterval: PickerItem.intervalDaily,
    );
  }

  // #########################################################
  // Static Measurement Data Bar Charts
  // #########################################################

  /// This can be used to create a Chart that shows progression of measurement value.
  factory Chart.measurementDataProgressionOfValue({required String filterByFieldId, required String filterByMeasurementCategory, required String filterByMeasurementUnit}) {
    return Chart(
      chartId: const Uuid().v4(),
      chartType: chartTypeBarChart,
      createdAt: DateTime.now(),
      editedAt: DateTime.now(),
      barChartInstruction: BarChartInstruction.measurementDataProgressionOfValue(),
      // * State variables.
      showFilterByTimeInterval: false,
      showFilterByField: true,
      showFilterByMember: false,
      showFilterByYear: true,
      // * Set to null to include all years.
      filterByYear: null,
      // * Setting filterByFieldId to an empty String will result in considering all expense fields.
      filterByFieldId: filterByFieldId,
      allowFilterForAllFields: false,
      filterByMeasurementCategory: filterByMeasurementCategory,
      filterByMeasurementUnit: filterByMeasurementUnit,
    );
  }

  // #########################################################
  // Getters and Getter methods
  // #########################################################

  /// This getter can be used to access ```selectedDate``` in readable format.
  /// * Returns an empty String if filterByDate == null.
  String get getSelectedDateYear {
    if (filterByYear == null) return labels.basicLabelsOverall();
    return DateFormat("yyyy").format(filterByYear!);
  }

  /// This getter can be used to check if filter by year should be displayed.
  bool get getShowFilterByYear {
    // Make sure if filter by year should be generally be displayed.
    if (showFilterByYear == false) return false;

    // #### Filter by year should be generally displayed but that might depend still ####

    // * Filter by yearly should only be available if intervalMOnthly or intervalDaily is selected.
    if (filterByTimeInterval == PickerItem.intervalYearly) return false;

    return true;
  }

  /// This getter can be used to determine if chart menu should be shown or not.
  bool get getShowMenu {
    if (showFilterByTimeInterval) return true;
    if (showFilterByField) return true;

    return false;
  }

  /// This getter can be used to access utilized field type based on chart type.
  String get getFieldType {
    // * Bar chart.
    if (chartType == Chart.chartTypeBarChart) return barChartInstruction!.barInstruction.fieldType;

    // * Pie chart.
    if (chartType == Chart.chartTypePieChart) return pieChartInstruction!.pieInstruction.fieldType;

    // * Line chart.
    if (chartType == Chart.chartTypeLineChart) return lineChartInstruction!.lineInstruction.fieldType;

    // * Descriptive value chart.
    return descriptiveValueInstructions!.first.fieldType;
  }

  /// This getter can be used to access utilized instruction type based on chart type.
  String get getInstructionType {
    // * Bar chart.
    if (chartType == Chart.chartTypeBarChart) return barChartInstruction!.barInstruction.instructionType;

    // * Pie chart.
    if (chartType == Chart.chartTypePieChart) return pieChartInstruction!.pieInstruction.instructionType;

    // * Line chart.
    if (chartType == Chart.chartTypeLineChart) return lineChartInstruction!.lineInstruction.instructionType;

    // * Descriptive value chart.
    throw Failure.genericError();
  }

  /// This getter can be used to check if displayed entries, wehn tapping on chart legend, should be filtered based on instruction type.
  /// * Returns `""` if no filter should be applied.
  String get getOnLegendTapFilterType {
    // * MoneyData filters.
    if (getInstructionType == MoneyData.pieChartIncomeByCategory) return 'income';
    if (getInstructionType == MoneyData.pieChartExpensesByCategory) return 'expenses';

    return "";
  }

  // #############################
  // Static chart replacement message.
  // #############################

  /// This getter can be used to determine if a chart replacement message should be shown before chart even starts loading.
  String getStaticChartReplacementMessage({required String defaultCurrencyCode, required String fieldType}) {
    // * Check static descriptive values chart replacement message.
    if (chartType == Chart.chartTypeDescriptiveChart) {
      if (fieldType == Field.fieldTypeMeasurement) {
        // No category was selected.
        if (filterByMeasurementCategory.isEmpty) return labels.categoryAndUnitRequired();

        // No unit was selected.
        if (filterByMeasurementUnit.isEmpty) return labels.categoryAndUnitRequired();
      }
    }

    // * Check static bar chart replacement message.
    if (chartType == Chart.chartTypeBarChart) {
      // Access instruction type.
      final String instructionType = barChartInstruction!.barInstruction.instructionType;

      // Show replacement message depending on instruction type.
      if (instructionType == PaymentData.chartInstructionCostsByMemberOverTime) {
        // No member was selected.
        if (filterByMember == null) return labels.failureNoMemberSelected();
      }

      // Show replacement message depending on instruction type.
      if (instructionType == PaymentData.chartInstructionMemberCostsByTag) {
        // No member was selected.
        if (filterByMember == null) return labels.failureNoMemberSelected();
      }

      // Show replacement message depending on this instruction type.
      if (instructionType == PaymentData.chartInstructionMemberAbsolutExpensesOverTime) {
        // No member was selected.
        if (filterByMember == null) return labels.failureNoMemberSelected();
      }

      // Show replacement message depending on this instruction type.
      if (instructionType == PaymentData.chartInstructionMemberAbsolutIncomeOverTime) {
        // No member was selected.
        if (filterByMember == null) return labels.failureNoMemberSelected();
      }

      // Show replacement message depending on this instruction type.
      if (instructionType == PaymentData.chartInstructionMemberAbsolutProfitsAndLosses) {
        // No member was selected.
        if (filterByMember == null) return labels.failureNoMemberSelected();
      }

      // Show replacement message depending on this instruction type.
      if (instructionType == MeasurementData.barChartProgressionOfValue) {
        // No category was selected.
        if (filterByMeasurementCategory.isEmpty) return labels.categoryAndUnitRequired();

        // No unit was selected.
        if (filterByMeasurementUnit.isEmpty) return labels.categoryAndUnitRequired();
      }
    }

    // * Check static pie chart replacement message.
    if (chartType == Chart.chartTypePieChart) {
      // Access instruction type.
      final String instructionType = pieChartInstruction!.pieInstruction.instructionType;

      // Show no data message depending on instruction type.
      if (instructionType == PaymentData.pieChartMemberCostsOfOverallCosts) {
        // No member was selected.
        if (filterByMember == null) return labels.failureNoMemberSelected();
      }

      // Show no data message depending on instruction type.
      if (instructionType == PaymentData.pieChartMemberCostSharesByTag) {
        // No member was selected.
        if (filterByMember == null) return labels.failureNoMemberSelected();
      }
    }

    // * Check static line chart replacement message.
    if (chartType == Chart.chartTypeLineChart) {
      // Access instruction type.
      final String _ = lineChartInstruction!.lineInstruction.instructionType;

      // * Currently there are no line charts with a static replacement message.
    }

    // If an empty string is returned, message is not shown.
    return '';
  }

  // #############################
  // Bar Chart.
  // #############################

  /// This getter method can be used to access the title of a bar chart.
  String getBarChartTitle({String? defaultCurrencyCode, required bool isShared}) {
    // Access instruction type.
    final String instructionType = barChartInstruction!.barInstruction.instructionType;

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMembersDebtBalances) {
      return labels.titleExpenseDataMembersDebtBalances(defaultCurrencyCode: defaultCurrencyCode!);
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMembersTotalCosts) {
      return labels.titleExpenseDataMembersTotalCosts(defaultCurrencyCode: defaultCurrencyCode!);
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionCostsByMemberOverTime) {
      return labels.titleExpenseDataCostsByMemberOverTime(
        defaultCurrencyCode: defaultCurrencyCode!,
        timeInterval: filterByTimeInterval!,
      );
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMemberCostsByTag) {
      return labels.titleExpenseDataCostsByTag(
        defaultCurrencyCode: defaultCurrencyCode!,
      );
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutExpensesOverTime) {
      return labels.titleExpenseDataAbsolutExpensesByMemberOverTime(
        defaultCurrencyCode: defaultCurrencyCode!,
        timeInterval: filterByTimeInterval!,
      );
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutIncomeOverTime) {
      return labels.titleExpenseDataAbsolutIncomeByMemberOverTime(
        defaultCurrencyCode: defaultCurrencyCode!,
        timeInterval: filterByTimeInterval!,
      );
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutProfitsAndLosses) {
      return labels.titleExpenseDataAbsolutProfitsOrLossesOverTime(
        defaultCurrencyCode: defaultCurrencyCode!,
        timeInterval: filterByTimeInterval!,
      );
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionOverallCostsByTag) {
      return labels.titleExpenseDataOverallCostsByTag(
        defaultCurrencyCode: defaultCurrencyCode!,
      );
    }

    // Show title depending on instruction type.
    if (instructionType == NumberData.chartInstructionNumericalOrder) {
      return labels.titleNumberDataNumericalOrder();
    }

    // Show title depending on instruction type.
    if (instructionType == BooleanData.barChartTrueFalseHistory) {
      return labels.titleBooleanDataTrueFalseHistory();
    }

    // Show title depending on instruction type.
    if (instructionType == EmailData.barChartFrequencyDistribution) {
      return labels.titleEmailDataFrequencyDistribution();
    }

    // Show title depending on instruction type.
    if (instructionType == DateOfBirthData.barChartBirthdaysPerMonth) {
      return labels.titleDateOfBirthDataBirthdaysPerMonth();
    }

    // Show title depending on instruction type.
    if (instructionType == TagsData.barChartEntriesByTag) {
      return labels.titleTagsDataEntriesByTag();
    }

    // Show title depending on instruction type.
    if (instructionType == EmotionData.barChartAverageIntensityByEmotion) {
      return labels.titleEmotionDataAverageIntensityByEmotion();
    }

    // Show title depending on instruction type.
    if (instructionType == EmotionData.barChartAverageWellbeing) {
      return labels.titleEmotionDataAverageWellbeing();
    }

    // Show title depending on instruction type.
    if (instructionType == MeasurementData.barChartProgressionOfValue) {
      return  labels.titleMeasurementDataProgressionOfValue(isShared:isShared);
    }

    // Show title depending on instruction type.
    if (instructionType == MoneyData.chartInstructionIncomeOverTime) {
      return labels.titleMoneyDataIncomeOverTime(currencyCode: defaultCurrencyCode!);
    }

    // Show title depending on instruction type.
    if (instructionType == MoneyData.chartInstructionExpensesOverTime) {
      return labels.titleMoneyDataExpensesOverTime(currencyCode: defaultCurrencyCode!);
    }

    // Show title depending on instruction type.
    if (instructionType == MoneyData.chartInstructionValuesByEntry) {
      return labels.titleMoneyDataNumericalProgression(currencyCode: defaultCurrencyCode!);
    }

    // In case instruction type is unknown, return empty String.
    return '';
  }

  /// This getter method can be used to access the infoLine of a bar chart.
  String getBarChartInfoLine({required FieldIdentifications fieldIdentifications}) {
    // Access instruction type.
    final String instructionType = barChartInstruction!.barInstruction.instructionType;

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMembersDebtBalances) {
      return labels.infoLineExpenseDataDebtBalancesAllMembers();
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMembersTotalCosts) {
      return labels.infoLineExpenseDataMembersTotalCosts();
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionCostsByMemberOverTime) {
      return labels.infoLineExpenseDataCostsByMemberOverTime();
    }

    // Show title depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMemberCostsByTag) {
      return labels.infoLineExpenseDataCostsByTag();
    }

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutExpensesOverTime) {
      return labels.infoLineExpenseDataAbsolutExpensesByMemberOverTime();
    }

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutIncomeOverTime) {
      return labels.infoLineExpenseDataAbsolutIncomeByMemberOverTime();
    }

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutProfitsAndLosses) {
      return '';
    }

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionOverallCostsByTag) {
      return labels.infoLineExpenseDataOverallCostsByTag();
    }

    // Show info line depending on instruction type.
    if (instructionType == NumberData.chartInstructionNumericalOrder) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == BooleanData.barChartTrueFalseHistory) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == EmailData.barChartFrequencyDistribution) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == DateOfBirthData.barChartBirthdaysPerMonth) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == TagsData.barChartEntriesByTag) {
      return labels.infoLineTagsDataEntriesByTag(
        filterByFieldId: filterByFieldId,
      );
    }

    // Show info line depending on instruction type.
    if (instructionType == EmotionData.barChartAverageIntensityByEmotion) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == EmotionData.barChartAverageWellbeing) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == MeasurementData.barChartProgressionOfValue) {
      return labels.infoLineMeasurementDataProgressionOfValue();
    }

    // Show info line depending on instruction type.
    if (instructionType == MoneyData.chartInstructionIncomeOverTime) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == MoneyData.chartInstructionExpensesOverTime) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == MoneyData.chartInstructionValuesByEntry) {
      return '';
    }

    // In case instruction type is unknown, return empty String.
    return '';
  }

  /// This getter method can be used to access the no data message of a bar chart.
  /// * Returns ```labels.basicLabelNoDataAvailable()``` if there are more then one instructions present because in that case it cannot be known which message to present.
  String getBarChartReplacementMessage({required BarItems barItems}) {
    // Access instruction type.
    final String instructionType = barChartInstruction!.barInstruction.instructionType;

    // Calculate the total.
    final bool allValuesAreZero = barItems.getAllValuesAreZero;

    // Show replacement message depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMembersDebtBalances) {
      // Accounts are leveled.
      if (barItems.items.isEmpty) return labels.expenseDataMembersDebtBalancesNoDataAvailableMessage();

      // Accounts are leveled.
      if (allValuesAreZero) return labels.expenseDataMembersDebtBalancesNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMembersTotalCosts) {
      // No costs found.
      if (barItems.items.isEmpty) return labels.expenseDataMembersTotalCostsNoDataAvailableMessage();

      // No costs found.
      if (allValuesAreZero) return labels.expenseDataMembersTotalCostsNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on instruction type.
    if (instructionType == PaymentData.chartInstructionCostsByMemberOverTime) {
      // No costs found.
      if (barItems.items.isEmpty) return labels.expenseDataCostsByMemberOverTimeNoDataAvailableMessage();

      // No costs found.
      if (allValuesAreZero) return labels.expenseDataCostsByMemberOverTimeNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on instruction type.
    if (instructionType == PaymentData.chartInstructionMemberCostsByTag) {
      // No costs found.
      if (barItems.items.isEmpty) return labels.expenseDataCostsByTagNoDataAvailableMessage();

      // No costs found.
      if (allValuesAreZero) return labels.expenseDataCostsByTagNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutExpensesOverTime) {
      // No expenses found.
      if (barItems.items.isEmpty) return labels.expenseDataAbsolutExpensesByMemberOverTimeNoDataAvailableMessage();

      // No expenses found.
      if (allValuesAreZero) return labels.expenseDataAbsolutExpensesByMemberOverTimeNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutIncomeOverTime) {
      // No income found.
      if (barItems.items.isEmpty) return labels.expenseDataAbsolutIncomeByMemberOverTimeNoDataAvailableMessage();

      // No income found.
      if (allValuesAreZero) return labels.expenseDataAbsolutIncomeByMemberOverTimeNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionMemberAbsolutProfitsAndLosses) {
      // No profit/losses found.
      if (barItems.items.isEmpty) return labels.expenseDataMemberAbsoluteProfitsAndLossesNoDataAvailableMessage();

      // No profit/losses found.
      if (allValuesAreZero) return labels.expenseDataMemberAbsoluteProfitsAndLossesNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == PaymentData.chartInstructionOverallCostsByTag) {
      // No costs found.
      if (barItems.items.isEmpty) return labels.expenseDataOverallCostsByTagNoDataAvailableMessage();

      // No costs found.
      if (allValuesAreZero) return labels.expenseDataOverallCostsByTagNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == NumberData.chartInstructionNumericalOrder) {
      // No data found.
      if (barItems.items.isEmpty) return labels.numberDataNumericalOrderNoDataAvailableMessage();

      // No data found.
      if (allValuesAreZero) return labels.numberDataNumericalOrderNoDataAvailableMessageAllZero();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == BooleanData.barChartTrueFalseHistory) {
      // No data found.
      if (barItems.items.isEmpty) return labels.booleanDataTrueFalseHistoryNoDataAvailableMessage();

      // No data found.
      if (allValuesAreZero) return labels.booleanDataTrueFalseHistoryNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == EmailData.barChartFrequencyDistribution) {
      // No data found.
      if (barItems.items.isEmpty) return labels.emailDataFrequencyDistributionNoDataAvailableMessage();

      // No data found.
      if (allValuesAreZero) return labels.emailDataFrequencyDistributionNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == DateOfBirthData.barChartBirthdaysPerMonth) {
      // No data found.
      if (barItems.items.isEmpty) return labels.dateOfBirthDataBirthdaysPerMonthNoDataAvailableMessage();

      // No data found.
      if (allValuesAreZero) return labels.dateOfBirthDataBirthdaysPerMonthNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == TagsData.barChartEntriesByTag) {
      // No data found.
      if (barItems.items.isEmpty) return labels.tagsDataEntriesByTagNoDataAvailableMessage();

      // No data found.
      if (allValuesAreZero) return labels.tagsDataEntriesByTagNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == EmotionData.barChartAverageIntensityByEmotion) {
      // No data found.
      if (barItems.items.isEmpty) return labels.emotionDataAverageIntensityByEmotionNoDataAvailableMessage();

      // No data found.
      if (allValuesAreZero) return labels.emotionDataAverageIntensityByEmotionNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == EmotionData.barChartAverageWellbeing) {
      // No data found.
      if (barItems.items.isEmpty) return labels.emotionDataAverageWellbeingNoDataAvailableMessage();

      // No data found.
      if (allValuesAreZero) return labels.emotionDataAverageWellbeingNoDataAvailableMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == MeasurementData.barChartProgressionOfValue) {
      // No data found.
      if (barItems.items.isEmpty) return labels.basicLabelsNoDataAvailable();

      // No data found.
      if (allValuesAreZero) return labels.basicLabelsNoDataAvailable();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == MoneyData.chartInstructionIncomeOverTime) {
      // No data found.
      if (barItems.items.isEmpty) return labels.basicLabelsNoDataAvailable();

      // No data found.
      if (allValuesAreZero) return labels.basicLabelsNoDataAvailable();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == MoneyData.chartInstructionExpensesOverTime) {
      // No data found.
      if (barItems.items.isEmpty) return labels.basicLabelsNoDataAvailable();

      // No data found.
      if (allValuesAreZero) return labels.basicLabelsNoDataAvailable();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == MoneyData.chartInstructionValuesByEntry) {
      // No data found.
      if (barItems.items.isEmpty) return labels.basicLabelsNoDataAvailable();

      // No data found.
      if (allValuesAreZero) return labels.basicLabelsNoDataAvailable();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // In case instruction type is unknown, return failure message.
    return Failure.unknownChartInstruction().message;
  }

  // #############################
  // Pie Chart.
  // #############################

  /// This getter method can be used to access the title of a pie chart.
  /// * Returns an empty String if there are more then one instructions present because in that case it cannot be known which title to present.
  String getPieChartTitle({String? defaultCurrencyCode}) {
    // Access instruction type.
    final String instructionType = pieChartInstruction!.pieInstruction.instructionType;

    // Show title depending on this instruction type.
    if (instructionType == PaymentData.pieChartMemberCostsOfOverallCosts) {
      return labels.titleExpenseDataMemberCostsOfOverallCosts(defaultCurrencyCode: defaultCurrencyCode!);
    }

    // Show title depending on this instruction type.
    if (instructionType == PaymentData.pieChartMemberCostSharesByTag) {
      return labels.titleExpenseDataMemberCostSharesByTag();
    }

    // Show title depending on this instruction type.
    if (instructionType == PaymentData.pieChartOverallCostSharesByTag) {
      return labels.titleExpenseDataOverallCostSharesByTag();
    }

    // Show title depending on this instruction type.
    if (instructionType == BooleanData.pieChartTrueFalseDistribution) {
      return labels.titleBooleanDataTrueFalseDistribution();
    }

    // Show title depending on this instruction type.
    if (instructionType == EmailData.pieChartFrequencyShares) {
      return labels.titleEmailDataFrequencyShares();
    }

    // Show title depending on this instruction type.
    if (instructionType == EmailData.pieChartProviderDistribution) {
      return labels.titleEmailDataProviderShares();
    }

    // Show title depending on this instruction type.
    if (instructionType == UsernameData.pieChartUsernameDistribution) {
      return labels.titleUsernameDataUsernameDistribution();
    }

    // Show title depending on this instruction type.
    if (instructionType == AvatarImageData.pieChartHasImageDistribution) {
      return labels.titleAvatarImageDataHasImageDistribution();
    }

    // Show title depending on this instruction type.
    if (instructionType == AvatarImageData.pieChartHasTitleDistribution) {
      return labels.titleAvatarImageDataHasTitleDistribution();
    }

    // Show title depending on this instruction type.
    if (instructionType == AvatarImageData.pieChartHasTextDistribution) {
      return labels.titleAvatarImageDataHasTextDistribution();
    }

    // Show title depending on this instruction type.
    if (instructionType == DateOfBirthData.pieChartSeasonalBirthdayDistribution) {
      return labels.titleDateOfBirthDataSeasonalDistribution();
    }

    // Show title depending on this instruction type.
    if (instructionType == MoneyData.pieChartCurrencyDistribution) {
      return labels.titleMoneyDataCurrencyDistribution();
    }

    // Show title depending on this instruction type.
    if (instructionType == MoneyData.pieChartExpensesByCategory) {
      return labels.titleMoneyDataExpensesByCategory();
    }

    // Show title depending on this instruction type.
    if (instructionType == MoneyData.pieChartIncomeByCategory) {
      return labels.titleMoneyDataIncomeByCategory();
    }

    // Show title depending on this instruction type.
    if (instructionType == TagsData.pieChartEntriesShareByTag) {
      return labels.titleTagsDataEntriesShareByTag();
    }

    // Show title depending on this instruction type.
    if (instructionType == EmotionData.pieChartPositiveAndNegativeEmotionsProportion) {
      return labels.titleEmotionDataPositiveNegativeProportion();
    }

    // In case instruction type is unknown, return empty String.
    return '';
  }

  /// This getter method can be used to access the title of a pie chart.
  String getPieChartInfoLine({required FieldIdentifications fieldIdentifications}) {
    // Access instruction type.
    final String instructionType = pieChartInstruction!.pieInstruction.instructionType;

    // Access the relevant field identification. This should be null if no filterByFieldId was supplied.
    final FieldIdentification? fieldIdentification = fieldIdentifications.getById(fieldId: filterByFieldId);

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.pieChartMemberCostsOfOverallCosts) {
      return labels.infoLineExpenseDataMemberCostsOfOverallCosts();
    }

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.pieChartMemberCostSharesByTag) {
      return labels.infoLineExpenseDataMemberCostSharesByTag(
        filterByFieldId: filterByFieldId,
        fieldName: fieldIdentification?.label ?? '',
      );
    }

    // Show info line depending on this instruction type.
    if (instructionType == PaymentData.pieChartOverallCostSharesByTag) {
      return labels.infoLineExpenseDataOverallCostSharesByTag(
        filterByFieldId: filterByFieldId,
        fieldName: fieldIdentification?.label ?? '',
      );
    }

    // Show info line depending on this instruction type.
    if (instructionType == BooleanData.pieChartTrueFalseDistribution) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == EmailData.pieChartFrequencyShares) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == EmailData.pieChartProviderDistribution) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == UsernameData.pieChartUsernameDistribution) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == AvatarImageData.pieChartHasImageDistribution) {
      return labels.infoLineAvatarImageDataHasImageDistribution();
    }

    // Show info line depending on instruction type.
    if (instructionType == AvatarImageData.pieChartHasTitleDistribution) {
      return labels.infoLineAvatarImageDataHasTitleDistribution();
    }

    // Show info line depending on instruction type.
    if (instructionType == AvatarImageData.pieChartHasTextDistribution) {
      return labels.infoLineAvatarImageDataHasTextDistribution();
    }

    // Show info line depending on instruction type.
    if (instructionType == DateOfBirthData.pieChartSeasonalBirthdayDistribution) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == MoneyData.pieChartCurrencyDistribution) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == TagsData.pieChartEntriesShareByTag) {
      return labels.infoLineTagsDataEntriesShareByTag(
        filterByFieldId: filterByFieldId,
      );
    }

    // Show info line depending on instruction type.
    if (instructionType == EmotionData.pieChartPositiveAndNegativeEmotionsProportion) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == MoneyData.pieChartExpensesByCategory) {
      return '';
    }

    // Show info line depending on instruction type.
    if (instructionType == MoneyData.pieChartIncomeByCategory) {
      return '';
    }

    // In case instruction type is unknown, return empty String.
    return '';
  }

  /// This getter method can be used to access the title of a pie chart.
  String getPieChartReplacementMessage({required PieItems pieItems}) {
    // Access instruction type.
    final String instructionType = pieChartInstruction!.pieInstruction.instructionType;

    // Show no data message depending on instruction type.
    if (instructionType == PaymentData.pieChartMemberCostsOfOverallCosts) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.expenseDataMemberCostsOfOverallCostsNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == PaymentData.pieChartMemberCostSharesByTag) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.expenseDataMemberCostSharesByTagNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == PaymentData.pieChartOverallCostSharesByTag) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.expenseDataOverallCostSharesByTagNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == BooleanData.pieChartTrueFalseDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.booleanDataTrueFalseDistributionNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == EmailData.pieChartFrequencyShares) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.emailDataFrequencySharesNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == EmailData.pieChartProviderDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.emailDataProviderSharesNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == UsernameData.pieChartUsernameDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.usernameDataUsernameDistributionNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == AvatarImageData.pieChartHasImageDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.avatarImageDataHasImageDistributionNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == AvatarImageData.pieChartHasTitleDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.avatarImageDataHasTitleDistributionNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == AvatarImageData.pieChartHasTextDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.avatarImageDataHasTextDistributionNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == DateOfBirthData.pieChartSeasonalBirthdayDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.dateOfBirthDataSeasonalDistributionNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == MoneyData.pieChartCurrencyDistribution) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.basicLabelsNoDataFoundForFilters();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message expenses by category
    if (instructionType == MoneyData.pieChartExpensesByCategory) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.basicLabelsNoDataFoundForFilters();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message income by category
    if (instructionType == MoneyData.pieChartIncomeByCategory) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.basicLabelsNoDataFoundForFilters();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == TagsData.pieChartEntriesShareByTag) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.tagsDataEntriesShareByTagNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show no data message depending on instruction type.
    if (instructionType == EmotionData.pieChartPositiveAndNegativeEmotionsProportion) {
      // No data to display.
      if (pieItems.items.isEmpty) return labels.emotionDataPositiveNegativeProportionNoDataMessage();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // In case instruction type is unknown, return failure message.
    return Failure.unknownChartInstruction().message;
  }

  // #############################
  // Line Chart.
  // #############################

  /// This getter method can be used to access the title of a line chart.
  String getLineChartTitle({required String currencyCode}) {
    // Access instruction type.
    final String instructionType = lineChartInstruction!.lineInstruction.instructionType;

    // Show title depending on instruction type.
    if (instructionType == NumberData.chartInstructionNumericalProgressionIndividual) {
      return labels.titleNumberDataNumericalProgression();
    }

    // Show title depending on instruction type.
    if (instructionType == NumberData.chartInstructionNumericalProgressionAccumulated) {
      return labels.titleNumberDataNumericalProgressionAccumulated();
    }

    // Show title depending on instruction type.
    if (instructionType == MoneyData.chartInstructionMoneyProgressionAccumulated) {
      return labels.titleMoneyDataNumericalProgressionAccumulated(currencyCode: currencyCode);
    }

    // In case instruction type is unknown, return empty String.
    return '';
  }

  /// This getter method can be used to access the title of a line chart.
  String getLineChartInfoLine({required FieldIdentifications fieldIdentifications}) {
    // Access instruction type.
    final String instructionType = lineChartInstruction!.lineInstruction.instructionType;

    // Show title depending on instruction type.
    if (instructionType == NumberData.chartInstructionNumericalProgressionIndividual) {
      return '';
    }

    // Show title depending on instruction type.
    if (instructionType == NumberData.chartInstructionNumericalProgressionAccumulated) {
      return '';
    }

    // Show title depending on instruction type.
    if (instructionType == MoneyData.chartInstructionMoneyProgressionAccumulated) {
      return '';
    }

    // In case instruction type is unknown, return empty String.
    return '';
  }

  /// This getter method can be used to access the title of a line chart.
  String getLineChartReplacementMessage({required LineItems lineItems, required String defaultCurrencyCode}) {
    // Access instruction type.
    final String instructionType = lineChartInstruction!.lineInstruction.instructionType;

    // Calculate the total.
    final bool allYValuesAreZero = lineItems.getAllYValuesAreZero;

    // Show replacement message depending on this instruction type.
    if (instructionType == NumberData.chartInstructionNumericalProgressionIndividual) {
      // No data found.
      if (lineItems.items.isEmpty) return labels.numberDataNumericalProgressionNoDataAvailableMessage();

      // No data found.
      if (allYValuesAreZero) return labels.numberDataNumericalProgressionAllValuesAreZero();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == NumberData.chartInstructionNumericalProgressionAccumulated) {
      // No data found.
      if (lineItems.items.isEmpty) return labels.numberDataNumericalProgressionNoDataAvailableMessage();

      // No data found.
      if (allYValuesAreZero) return labels.numberDataNumericalProgressionAllValuesAreZero();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // Show replacement message depending on this instruction type.
    if (instructionType == MoneyData.chartInstructionMoneyProgressionAccumulated) {
      // No data found.
      if (lineItems.items.isEmpty) return labels.moneyDataNumericalProgressionNoDataAvailableMessage();

      // No data found.
      if (allYValuesAreZero) return labels.moneyDataNumericalProgressionAllValuesAreZero();

      // If an empty string is returned, message is not shown.
      return '';
    }

    // In case instruction type is unknown, return failure message.
    return Failure.unknownChartInstruction().message;
  }

  // #############################
  // Cloud
  // #############################

  /// Encode an ```Chart``` object to JSON suitable for cloud operations.
  Map<String, dynamic> toCloudObject({required String? descriptiveValueInstruction}) {
    // Access field type.
    final String fieldType = getFieldType;
    final String instructionType = descriptiveValueInstruction ?? getInstructionType;

    return {
      'chart_type': chartType,
      'field_type': fieldType,
      'instruction_type': instructionType,
      'filter_by_member': filterByMember?.toCloudObject() ?? {},
      // * The correct filter date will be constructed server side.
      'filter_by_year': filterByYear?.year.toString() ?? "",
      'filter_by_field_id': filterByFieldId,
      'filter_by_measurement_category': filterByMeasurementCategory,
      'filter_by_measurement_unit': filterByMeasurementUnit,
      'filter_by_time_interval': filterByTimeInterval ?? "",
    };
  }

  // #############################
  // Copy With
  // #############################

  Chart copyWith({
    String? chartId,
    String? chartType,
    DateTime? createdAt,
    DateTime? editedAt,
    List<DescriptiveValueInstruction>? descriptiveValueInstructions,
    DescriptiveValueInstruction? cachedDescriptiveValueInstruction,
    double? cachedDescriptiveValue,
    BarChartInstruction? barChartInstruction,
    BarItems? cachedBarItems,
    PieChartInstruction? pieChartInstruction,
    PieItems? cachedPieItems,
    LineChartInstruction? lineChartInstruction,
    LineItems? cachedLineItems,
    bool? showFilterByTimeInterval,
    bool? showFilterByMember,
    bool? showFilterByYear,
    bool? showFilterByField,
    bool? allowFilterForAllFields,
    Member? filterByMember,
    String? filterByTimeInterval,
    DateTime? filterByYear,
    String? filterByFieldId,
    String? filterByMeasurementCategory,
    String? filterByMeasurementUnit,
    bool? showActionButton,
    bool explicitlySetFilterByYear = false,
    String? loadingMessage,
  }) {
    return Chart(
      chartId: chartId ?? this.chartId,
      chartType: chartType ?? this.chartType,
      createdAt: createdAt ?? this.createdAt,
      editedAt: editedAt ?? this.editedAt,
      descriptiveValueInstructions: descriptiveValueInstructions ?? this.descriptiveValueInstructions,
      cachedDescriptiveValueInstruction: cachedDescriptiveValueInstruction ?? this.cachedDescriptiveValueInstruction,
      cachedDescriptiveValue: cachedDescriptiveValue ?? this.cachedDescriptiveValue,
      barChartInstruction: barChartInstruction ?? this.barChartInstruction,
      cachedBarItems: cachedBarItems ?? this.cachedBarItems,
      pieChartInstruction: pieChartInstruction ?? this.pieChartInstruction,
      cachedPieItems: cachedPieItems ?? this.cachedPieItems,
      lineChartInstruction: lineChartInstruction ?? this.lineChartInstruction,
      cachedLineItems: cachedLineItems ?? this.cachedLineItems,
      showFilterByTimeInterval: showFilterByTimeInterval ?? this.showFilterByTimeInterval,
      showFilterByMember: showFilterByMember ?? this.showFilterByMember,
      showFilterByYear: showFilterByYear ?? this.showFilterByYear,
      showFilterByField: showFilterByField ?? this.showFilterByField,
      allowFilterForAllFields: allowFilterForAllFields ?? this.allowFilterForAllFields,
      filterByMember: filterByMember ?? this.filterByMember,
      filterByTimeInterval: filterByTimeInterval ?? this.filterByTimeInterval,
      filterByYear: explicitlySetFilterByYear ? filterByYear : filterByYear ?? this.filterByYear,
      filterByFieldId: filterByFieldId ?? this.filterByFieldId,
      filterByMeasurementCategory: filterByMeasurementCategory ?? this.filterByMeasurementCategory,
      filterByMeasurementUnit: filterByMeasurementUnit ?? this.filterByMeasurementUnit,
      showActionButton: showActionButton ?? this.showActionButton,
      loadingMessage: loadingMessage ?? this.loadingMessage,
    );
  }
}
