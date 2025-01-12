part of 'charts_sheet_cubit.dart';

enum ChartsSheetStatus { pageIsLoading, pageHasError, waiting, refreshLocalState, refreshValues, loading, failure, close }

enum ExchangeRatesStatus { initial, waiting, loading, actionRequired, failure }

class ChartsSheetState extends Equatable {
  final bool isShared;

  final int totalEntries;

  final Members participantMembers;
  final Group fromGroup;

  final String contentLoadingMessage;

  final ModelEntries modelEntriesOfGroup;

  final FieldIdentifications utilizedFieldIdentifications;

  /// Holds categories and units found in entries of this group.
  /// * The keys of this map is the ```fieldId``` of the field where the data was found.
  final Map<String, Measurements> utilizedCategoriesAndUnits;

  final PickerItems fieldTypes;
  final PickerItem selectedFieldType;

  final Charts charts;

  final Charts cachedValueCharts;
  final Charts cachedBarCharts;
  final Charts cachedPieCharts;
  final Charts cachedLineCharts;

  final Failure pageFailure;

  final Failure failure;
  final ChartsSheetStatus status;

  final Failure exchangeRatesFailure;
  final ExchangeRatesStatus exchangeRatesStatus;

  const ChartsSheetState({
    required this.isShared,
    required this.totalEntries,
    required this.participantMembers,
    required this.fromGroup,
    required this.modelEntriesOfGroup,
    required this.contentLoadingMessage,
    required this.utilizedFieldIdentifications,
    required this.utilizedCategoriesAndUnits,
    required this.fieldTypes,
    required this.selectedFieldType,
    required this.charts,
    required this.cachedValueCharts,
    required this.cachedBarCharts,
    required this.cachedPieCharts,
    required this.cachedLineCharts,
    required this.failure,
    required this.status,
    required this.pageFailure,
    required this.exchangeRatesFailure,
    required this.exchangeRatesStatus,
  });

  @override
  List<Object?> get props => [
        isShared,
        totalEntries,
        fromGroup,
        modelEntriesOfGroup,
        utilizedFieldIdentifications,
        contentLoadingMessage,
        fieldTypes,
        selectedFieldType,
        charts,
        pageFailure,
        cachedValueCharts,
        cachedBarCharts,
        cachedPieCharts,
        cachedLineCharts,
        participantMembers,
        failure,
        status,
        exchangeRatesFailure,
        exchangeRatesStatus,
      ];

  /// Initialize a new ```LocalChartsSheetState``` object.
  factory ChartsSheetState.initial() {
    return ChartsSheetState(
      isShared: false,
      totalEntries: 0,
      participantMembers: Members.initial(),
      fromGroup: Group.initial(),
      modelEntriesOfGroup: ModelEntries.initial(),
      utilizedFieldIdentifications: FieldIdentifications.initial(),
      utilizedCategoriesAndUnits: const {},
      contentLoadingMessage: '',
      fieldTypes: PickerItems.initial(),
      selectedFieldType: PickerItem.initial(),
      charts: Charts.initial(),
      cachedValueCharts: Charts.initial(),
      cachedBarCharts: Charts.initial(),
      cachedPieCharts: Charts.initial(),
      cachedLineCharts: Charts.initial(),
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: ChartsSheetStatus.pageIsLoading,
      exchangeRatesFailure: Failure.initial(),
      // * This is waiting initially because it should not get triggerd on state creation if user is in shared mode.
      exchangeRatesStatus: ExchangeRatesStatus.waiting,
    );
  }

  /// This method can be used to access charts depending on selected field type.
  /// * Returns ```Charts.initial()``` if ```fieldType``` is unknown or not provided.
  Charts getCharts({
    required Member? selectedMember,
    required FieldIdentifications utilizedFieldIdentifications,
    required bool showDebtBalances,
    required PickerItem? selectedFieldType,
    required Map<String, Measurements> utilizedCategoriesAndUnits,
  }) {
    // No field type available.
    if (selectedFieldType == null) return Charts.initial();

    // Check if charts are availble for this field type.
    // * This check is mainly made to indicate to the developer if updateing this list is required.
    if (Field.chartsAvailable.contains(selectedFieldType.id) == false) {
      // Output debug message.
      debugPrint('ChartsSheetState --> getCharts() --> Field.chartsAvailable does not contain provided field type: ${selectedFieldType.id}');
      return Charts.initial();
    }

    // Show expense charts.
    if (selectedFieldType.id == Field.fieldTypePayment) {
      return getAvailableExpenseDataCharts(
        selectedMember: selectedMember,
        showDebtBalances: showDebtBalances,
      );
    }

    // Show number data charts.
    if (selectedFieldType.id == Field.fieldTypeNumber) {
      // Access first field of this type.
      final String filterByFieldId = utilizedFieldIdentifications.getFirstFieldIdOfType(
        fieldType: selectedFieldType.id,
      );

      return getAvailableNumberDataCharts(
        filterByFieldId: filterByFieldId,
      );
    }

    // Show boolean data charts.
    if (selectedFieldType.id == Field.fieldTypeBoolean) {
      // Access first field of this type.
      final String filterByFieldId = utilizedFieldIdentifications.getFirstFieldIdOfType(
        fieldType: selectedFieldType.id,
      );

      return getAvailableBooleanDataCharts(
        filterByFieldId: filterByFieldId,
      );
    }

    // Show email data charts.
    if (selectedFieldType.id == Field.fieldTypeEmail) {
      return getAvailableEmailDataCharts();
    }

    // Show username data charts.
    if (selectedFieldType.id == Field.fieldTypeUsername) {
      return getAvailableUsernameDataCharts();
    }

    // Show avatar data charts.
    if (selectedFieldType.id == Field.fieldTypeAvatarImage) {
      // Access first field of this type.
      final String filterByFieldId = utilizedFieldIdentifications.getFirstFieldIdOfType(
        fieldType: selectedFieldType.id,
      );

      return getAvailableAvatarImageDataCharts(filterByFieldId: filterByFieldId);
    }

    // Show date of birth data charts.
    if (selectedFieldType.id == Field.fieldTypeDateOfBirth) {
      return getAvailableDateOfBirthDataCharts();
    }

    // Show money data charts.
    if (selectedFieldType.id == Field.fieldTypeMoney) {
      // Access first field of this type.
      final String filterByFieldId = utilizedFieldIdentifications.getFirstFieldIdOfType(
        fieldType: selectedFieldType.id,
      );

      return getAvailableMoneyDataCharts(filterByFieldId: filterByFieldId);
    }

    // Show money data charts.
    if (selectedFieldType.id == Field.fieldTypeTags) {
      // Access first field of this type.
      final String filterByFieldId = utilizedFieldIdentifications.getFirstFieldIdOfType(
        fieldType: selectedFieldType.id,
      );

      return getAvailableTagsDataCharts(filterByFieldId: filterByFieldId);
    }

    // Show money data charts.
    if (selectedFieldType.id == Field.fieldTypeEmotion) {
      // Access first field of this type.
      final String filterByFieldId = utilizedFieldIdentifications.getFirstFieldIdOfType(
        fieldType: selectedFieldType.id,
      );

      return getAvailableEmotionDataCharts(filterByFieldId: filterByFieldId);
    }

    // Show measurement data charts.
    if (selectedFieldType.id == Field.fieldTypeMeasurement) {
      // Access first field of this type.
      final String filterByFieldId = utilizedFieldIdentifications.getFirstFieldIdOfType(
        fieldType: selectedFieldType.id,
      );

      // Access initial categories and units.
      final Measurements? initialMeasurements = utilizedCategoriesAndUnits[filterByFieldId];

      return getAvailableMeasurementDataCharts(
        filterByFieldId: filterByFieldId,
        initialMeasurements: initialMeasurements,
      );
    }

    // * Unknown field type, return empty charts.
    return Charts.initial();
  }

  /// This method can be used to load available expense data charts.
  Charts getAvailableExpenseDataCharts({required Member? selectedMember, required bool showDebtBalances}) {
    return Charts(
      items: [
        // * Debt balances of all members.
        if (showDebtBalances) Chart.expenseDataDebtBalancesAllMembers(),
        // * Costs of a member over time.
        Chart.expenseDataCostsByMemberOverTime(
          filterByMember: selectedMember,
        ),
        // * Costs by tag.
        Chart.expenseDataMemberCostsByTag(
          filterByMember: selectedMember,
        ),
        // * Costs shares by Tag.
        Chart.expenseDataMemberCostSharesByTag(
          filterByMember: selectedMember,
        ),
        // * Total spent over time.
        Chart.expenseDataAbsolutExpensesByMemberOverTime(
          filterByMember: selectedMember,
        ),
        // * Total income over time.
        Chart.expenseDataAbsolutIncomeByMemberOverTime(
          filterByMember: selectedMember,
        ),
        // * Profits and Losses chart.
        Chart.expenseDataAbsolutProfitsAndLossesOverTime(
          filterByMember: selectedMember,
        ),
      ],
    );
  }

  /// This method can be used to load available number data charts.
  Charts getAvailableNumberDataCharts({required String filterByFieldId}) {
    return Charts(
      items: [
        // * Numerical progression of entries individual.
        Chart.numberDataNumericalProgressionIndividual(
          filterByFieldId: filterByFieldId,
        ),
        // * Numerical progression of entries accumulated.
        Chart.numberDataNumericalProgressionAccumulated(
          filterByFieldId: filterByFieldId,
        ),
        // * Numerical distribution.
        Chart.numberDataNumericalOrder(
          filterByFieldId: filterByFieldId,
        ),
      ],
    );
  }

  /// This method can be used to load available boolean data charts.
  Charts getAvailableBooleanDataCharts({required String filterByFieldId}) {
    return Charts(
      items: [
        // * Distribution of true and false in percent.
        Chart.booleanDataTrueFalseDistribution(
          filterByFieldId: filterByFieldId,
        ),
        // * True false history by entry.
        Chart.booleanDataTrueFalseHistory(
          filterByFieldId: filterByFieldId,
        ),
      ],
    );
  }

  /// This method can be used to load available email data charts.
  Charts getAvailableEmailDataCharts() {
    return Charts(
      items: [
        // * N Distribution of emails in percent.
        Chart.emailDataFrequencyShares(),
        // * N Distribution of emails.
        Chart.emailDataFrequencyDistribution(),
        // * Distribution of email providers in percent.
        Chart.emailDataProviderDistribution(),
      ],
    );
  }

  /// This method can be used to load available username data charts.
  Charts getAvailableUsernameDataCharts() {
    return Charts(
      items: [
        // * Distribution of usernames.
        Chart.usernameDataUsernameDistribution(),
      ],
    );
  }

  /// This method can be used to load available avatar image data charts.
  Charts getAvailableAvatarImageDataCharts({required String filterByFieldId}) {
    return Charts(
      items: [
        // * Distribution of image exists.
        Chart.avatarImageDataHasImageDistribution(),
        // * Distribution of has title.
        Chart.avatarImageDataHasTitleDistribution(filterByFieldId: filterByFieldId),
        // * Distribution of has text.
        Chart.avatarImageDataHasTextDistribution(filterByFieldId: filterByFieldId),
      ],
    );
  }

  /// This method can be used to load available birthday data charts.
  Charts getAvailableDateOfBirthDataCharts() {
    return Charts(
      items: [
        // * Distribution of birthdays per season.
        Chart.birthdayDataSeasonalBirthdays(),
        // * Distribution of birthdays per month.
        Chart.birthdayDataBirthdaysPerMonth(),
      ],
    );
  }

  /// This method can be used to load available money data charts.
  Charts getAvailableMoneyDataCharts({required String filterByFieldId}) {
    return Charts(
      items: [
        // * Value over time accumulated.
        Chart.moneyDataValueOverTimeAccumulated(filterByFieldId: filterByFieldId),
        // * Income over time.
        Chart.moneyDataIncomeOverTime(filterByFieldId: filterByFieldId),
        // * Distribution income by category.
        Chart.moneyDataIncomeByCategory(filterByFieldId: filterByFieldId),
        // * Expenses over time.
        Chart.moneyDataExpensesOverTime(filterByFieldId: filterByFieldId),
        // * Distribution expenses by category.
        Chart.moneyDataExpensesByCategory(filterByFieldId: filterByFieldId),
        // * Values by entry.
        Chart.moneyDataValuesByEntry(filterByFieldId: filterByFieldId),
        // * Distribution of currencies used.
        Chart.moneyDataCurrencyDistribution(),
      ],
    );
  }

  /// This method can be used to load available tags data charts.
  Charts getAvailableTagsDataCharts({required String filterByFieldId}) {
    return Charts(
      items: [
        // * Number of entries in a category.
        Chart.tagsDataEntriesByTag(),
        // * Entries share by category.
        Chart.tagsDataEntriesShareByTag(),
      ],
    );
  }

  /// This method can be used to load available emotion data charts.
  Charts getAvailableEmotionDataCharts({required String filterByFieldId}) {
    return Charts(
      items: [
        // * Proportion of positive and negative emotions.
        Chart.emotionDataProportionPositiveAndNegativeEmotions(),
        // * Average intensity by emotion.
        Chart.emotionDataAverageIntensityByEmotion(),
        // * Average wellbeing over time.
        Chart.averageWellbeingOverTime(),
      ],
    );
  }

  /// This method can be used to load available measurement data charts.
  Charts getAvailableMeasurementDataCharts({required String filterByFieldId, required Measurements? initialMeasurements}) {
    // Get the category unit pair with the heighest count.
    // * If there are equal counts, choose the first one that is found.
    // * If it is null, let user choose.
    final MeasurementData? inital = initialMeasurements?.getMostUtilized;

    return Charts(
      items: [
        // * Shows descriptive values chart.
        Chart.descriptiveValuesChart(
          fieldType: Field.fieldTypeMeasurement,
          filterByFieldId: filterByFieldId,
          filterByMeasurementCategory: inital?.category ?? '',
          filterByMeasurementUnit: inital?.unit ?? '',
        ),
        // * Shows the progression of value.
        Chart.measurementDataProgressionOfValue(
          filterByFieldId: filterByFieldId,
          filterByMeasurementCategory: inital?.category ?? '',
          filterByMeasurementUnit: inital?.unit ?? '',
        ),
      ],
    );
  }

  ChartsSheetState copyWith({
    bool? isShared,
    int? totalEntries,
    Members? participantMembers,
    Group? fromGroup,
    String? contentLoadingMessage,
    ModelEntries? modelEntriesOfGroup,
    FieldIdentifications? utilizedFieldIdentifications,
    Map<String, Measurements>? utilizedCategoriesAndUnits,
    PickerItems? fieldTypes,
    PickerItem? selectedFieldType,
    Charts? charts,
    Charts? cachedValueCharts,
    Charts? cachedBarCharts,
    Charts? cachedPieCharts,
    Charts? cachedLineCharts,
    Failure? pageFailure,
    Failure? failure,
    ChartsSheetStatus? status,
    Failure? exchangeRatesFailure,
    ExchangeRatesStatus? exchangeRatesStatus,
  }) {
    return ChartsSheetState(
      isShared: isShared ?? this.isShared,
      totalEntries: totalEntries ?? this.totalEntries,
      participantMembers: participantMembers ?? this.participantMembers,
      fromGroup: fromGroup ?? this.fromGroup,
      contentLoadingMessage: contentLoadingMessage ?? this.contentLoadingMessage,
      modelEntriesOfGroup: modelEntriesOfGroup ?? this.modelEntriesOfGroup,
      utilizedFieldIdentifications: utilizedFieldIdentifications ?? this.utilizedFieldIdentifications,
      utilizedCategoriesAndUnits: utilizedCategoriesAndUnits ?? this.utilizedCategoriesAndUnits,
      fieldTypes: fieldTypes ?? this.fieldTypes,
      selectedFieldType: selectedFieldType ?? this.selectedFieldType,
      charts: charts ?? this.charts,
      cachedValueCharts: cachedValueCharts ?? this.cachedValueCharts,
      cachedBarCharts: cachedBarCharts ?? this.cachedBarCharts,
      cachedPieCharts: cachedPieCharts ?? this.cachedPieCharts,
      cachedLineCharts: cachedLineCharts ?? this.cachedLineCharts,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      exchangeRatesFailure: exchangeRatesFailure ?? this.exchangeRatesFailure,
      exchangeRatesStatus: exchangeRatesStatus ?? this.exchangeRatesStatus,
    );
  }
}
