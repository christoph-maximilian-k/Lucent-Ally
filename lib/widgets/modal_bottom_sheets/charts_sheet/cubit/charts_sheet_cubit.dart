import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// User with settings and labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Helper functions.
import '/logic/helper_functions/helper_functions.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/expense_report_sheet/cubit/expense_report_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/provide_exchange_rates_sheet/cubit/provide_exchange_rates_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/view_entries_sheet/cubit/view_entries_sheet_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/expense_report_sheet/expense_report_sheet.dart';
import '/widgets/modal_bottom_sheets/provide_exchange_rates_sheet/provide_exchange_rates_sheet.dart';
import '/widgets/modal_bottom_sheets/view_entries_sheet/view_entries_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/members/member.dart';
import '/data/models/members/members.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/fields/field.dart';
import '/data/models/charts/charts.dart';
import '/data/models/charts/bar_chart/instructions/bar_instruction.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/charts/pie_chart/items/pie_items.dart';
import '/data/models/charts/chart.dart';
import '/data/models/charts/pie_chart/instructions/pie_instruction.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/charts/line_chart/items/line_items.dart';
import '/data/models/charts/line_chart/instructions/line_instruction.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/references/field_to_entry/field_to_entry.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/measurement_data/measurements.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/charts/descriptive_chart/descriptive_value_instruction.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/charts/pie_chart/items/pie_item.dart';

part 'charts_sheet_state.dart';

class ChartsSheetCubit extends Cubit<ChartsSheetState> with HelperFunctions {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;

  ChartsSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    required LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    required SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        super(ChartsSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize local state data.
  Future<void> initializeLocal({required Group group}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access all model entries used in this group.
      final ModelEntries modelEntriesOfGroup = await _localStorageCubit.getUtilizedModelEntriesOfLocalGroup(
        groupId: group.groupId,
      );

      // Access secrets.
      final Secrets? secrets = group.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access chart init data.
      final Map<String, dynamic> chartInitData = await _localStorageCubit.getInitialChartsDataOfLocalGroup(
        groupId: group.groupId,
        modelEntriesOfGroup: modelEntriesOfGroup,
        secrets: secrets,
      );

      // Convenience variables.
      final FieldIdentifications utilizedFieldIdentifications = chartInitData["utilized_field_identifications"];
      final Map<String, Measurements> utilizedCategoriesAndUnits = chartInitData["utilized_measurements"];
      final int totalEntries = chartInitData["total_entries"];

      // Convert to picker items.
      final PickerItems fieldTypesAsPickerItems = utilizedFieldIdentifications.fieldTypesToPickerItems(
        preferedTypes: Field.chartsAvailable,
      );

      // Init selected field type.
      final PickerItem? selectedFieldType = fieldTypesAsPickerItems.items.isEmpty ? null : fieldTypesAsPickerItems.items.first;

      // Access participant members.
      final Members participantMembers = await _localStorageCubit.getLocalMembersOfParticipant(
        participantId: group.participantReference,
      );

      // Select first member initially.
      final Member? selectedMember = participantMembers.items.isEmpty ? null : participantMembers.items.first;

      // Check if debt balances should be shown.
      final bool showDebtBalances = participantMembers.items.length > 1;

      // Access selected charts.
      final Charts charts = state.getCharts(
        selectedMember: selectedMember,
        utilizedFieldIdentifications: utilizedFieldIdentifications,
        showDebtBalances: showDebtBalances,
        selectedFieldType: selectedFieldType,
        utilizedCategoriesAndUnits: utilizedCategoriesAndUnits,
      );

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        totalEntries: totalEntries,
        participantMembers: participantMembers,
        fromGroup: group,
        charts: charts,
        modelEntriesOfGroup: modelEntriesOfGroup,
        utilizedFieldIdentifications: utilizedFieldIdentifications,
        utilizedCategoriesAndUnits: utilizedCategoriesAndUnits,
        fieldTypes: fieldTypesAsPickerItems,
        selectedFieldType: selectedFieldType,
        status: ChartsSheetStatus.waiting,
        // * In local mode validate exchange rates.
        exchangeRatesStatus: ExchangeRatesStatus.initial,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheet --> initializeLocal() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: ChartsSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheet --> initializeLocal() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ChartsSheetStatus.pageHasError,
      ));
    }
  }

  /// Refresh local state.
  Future<void> refreshLocal() async {
    try {
      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        cachedBarCharts: Charts.initial(),
        cachedPieCharts: Charts.initial(),
        cachedLineCharts: Charts.initial(),
        cachedValueCharts: Charts.initial(),
        failure: Failure.initial(),
        pageFailure: Failure.initial(),
        status: ChartsSheetStatus.pageIsLoading,
      ));

      // Access all model entries used in this group.
      final ModelEntries modelEntriesOfGroup = await _localStorageCubit.getUtilizedModelEntriesOfLocalGroup(
        groupId: state.fromGroup.groupId,
      );

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access chart init data.
      final Map<String, dynamic> chartInitData = await _localStorageCubit.getInitialChartsDataOfLocalGroup(
        groupId: state.fromGroup.groupId,
        modelEntriesOfGroup: modelEntriesOfGroup,
        secrets: secrets,
      );

      // Convenience variables.
      final FieldIdentifications utilizedFieldIdentifications = chartInitData["utilized_field_identifications"];
      final Map<String, Measurements> utilizedCategoriesAndUnits = chartInitData["utilized_measurements"];
      final int totalEntries = chartInitData["total_entries"];

      // Convert to picker items.
      final PickerItems fieldTypesAsPickerItems = utilizedFieldIdentifications.fieldTypesToPickerItems(
        preferedTypes: Field.chartsAvailable,
      );

      // Try and access current selected field type.
      final PickerItem? current = fieldTypesAsPickerItems.getById(id: state.selectedFieldType.id);

      // Init selected field type.
      final PickerItem? selectedFieldType = current ?? (fieldTypesAsPickerItems.items.isEmpty ? null : fieldTypesAsPickerItems.items.first);

      // Access participant members.
      final Members participantMembers = await _localStorageCubit.getLocalMembersOfParticipant(
        participantId: state.fromGroup.participantReference,
      );

      // Select first member initially.
      final Member? selectedMember = participantMembers.items.isEmpty ? null : participantMembers.items.first;

      // Check if debt balances should be shown.
      final bool showDebtBalances = participantMembers.items.length > 1;

      // Access selected charts.
      final Charts charts = state.getCharts(
        selectedMember: selectedMember,
        utilizedFieldIdentifications: utilizedFieldIdentifications,
        showDebtBalances: showDebtBalances,
        selectedFieldType: selectedFieldType,
        utilizedCategoriesAndUnits: utilizedCategoriesAndUnits,
      );

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        totalEntries: totalEntries,
        participantMembers: participantMembers,
        fromGroup: state.fromGroup,
        charts: charts,
        modelEntriesOfGroup: modelEntriesOfGroup,
        utilizedFieldIdentifications: utilizedFieldIdentifications,
        utilizedCategoriesAndUnits: utilizedCategoriesAndUnits,
        fieldTypes: fieldTypesAsPickerItems,
        selectedFieldType: selectedFieldType,
        status: ChartsSheetStatus.waiting,
        // * In local mode validate exchange rates.
        exchangeRatesStatus: ExchangeRatesStatus.initial,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheet --> refreshLocal() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: ChartsSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheet --> refreshLocal() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ChartsSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared state data.
  Future<void> initializeShared({required Group group, required bool isRefresh}) async {
    try {
      // * Necessary to avoid UI delay.
      // * Not needed if this is a refresh.
      if (isRefresh == false) await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access group if this is a refresh.
      if (isRefresh) group = await _localStorageCubit.getSharedGroupById(groupId: group.groupId);

      // Access chart init data.
      final Map<String, dynamic> chartInitData = await _localStorageCubit.getInitialChartsDataOfSharedGroup(
        group: group,
      );

      // Access data.
      final ModelEntries modelEntriesOfGroup = chartInitData['model_entries'];
      final FieldIdentifications utilizedFieldIdentifications = chartInitData['field_identifications'];
      final Map<String, Measurements> utilizedCategoriesAndUnits = chartInitData['measurements'];
      final int totalEntries = chartInitData['total_entries'];

      // Make sure user can only use this page if there are entries and fields present.
      if (totalEntries == 0 || utilizedFieldIdentifications.items.isEmpty) throw Failure.genericError();

      // Convert to picker items.
      final PickerItems fieldTypesAsPickerItems = utilizedFieldIdentifications.fieldTypesToPickerItems(
        preferedTypes: Field.chartsAvailable,
      );

      // Init selected field type.
      final PickerItem? selectedFieldType = isRefresh
          ? state.selectedFieldType
          : fieldTypesAsPickerItems.items.isEmpty
              ? null
              : fieldTypesAsPickerItems.items.first;

      // Access participant members.
      final Members participantMembers = await _localStorageCubit.getSharedMembersOfParticipant(
        participantId: group.participantReference,
        rootGroupReference: group.rootGroupReference,
        referenceType: group.getReferenceType,
        referenceId: group.groupId,
      );

      // Select first member initially.
      final Member? selectedMember = participantMembers.items.isEmpty ? null : participantMembers.items.first;

      // Check if debt balances should be shown.
      final bool showDebtBalances = participantMembers.items.length > 1;

      // Reset cached charts.
      if (isRefresh) {
        // Only emit new state if cubit is still active.
        if (isClosed) return;

        emit(state.copyWith(
          cachedBarCharts: Charts.initial(),
          cachedPieCharts: Charts.initial(),
          cachedLineCharts: Charts.initial(),
          cachedValueCharts: Charts.initial(),
          totalEntries: totalEntries,
          fromGroup: group,
          status: ChartsSheetStatus.refreshValues,
        ));

        // Await state update.
        await Future.delayed(const Duration(milliseconds: 250));
      }

      // Access selected charts.
      final Charts charts = state.getCharts(
        selectedMember: selectedMember,
        utilizedFieldIdentifications: utilizedFieldIdentifications,
        showDebtBalances: showDebtBalances,
        selectedFieldType: selectedFieldType,
        utilizedCategoriesAndUnits: utilizedCategoriesAndUnits,
      );

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        totalEntries: totalEntries,
        participantMembers: participantMembers,
        fromGroup: group,
        charts: charts,
        modelEntriesOfGroup: modelEntriesOfGroup,
        utilizedFieldIdentifications: utilizedFieldIdentifications,
        utilizedCategoriesAndUnits: utilizedCategoriesAndUnits,
        fieldTypes: fieldTypesAsPickerItems,
        selectedFieldType: selectedFieldType,
        status: ChartsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheet --> initializeShared() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: ChartsSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheet --> initializeShared() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ChartsSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ChartsSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ChartsSheetStatus.close,
    ));
  }

  /// This method gets invoked if user presses on the action button of a chart.
  Future<void> onActionButtonPressed({required BuildContext context, required Chart chart}) async {
    try {
      // Push Expense Report Sheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<ExpenseReportSheetCubit>(
          create: (context) => ExpenseReportSheetCubit(
            mainScreenCubit: _mainScreenCubit,
            appMessagesCubit: _appMessagesCubit,
            localStorageCubit: _localStorageCubit,
            chartsSheetCubit: this,
            localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
          )..initialize(
              isShared: state.isShared,
              isRefresh: false,
              group: state.fromGroup,
              filterByFieldId: chart.filterByFieldId,
              filterByYear: chart.filterByYear,
              utilizedFieldIdentifications: state.utilizedFieldIdentifications,
              participantMembers: state.participantMembers,
            ),
          child: const ExpenseReportSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onActionButtonPressed() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onActionButtonPressed() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user presses on menu dots in a chart.
  Future<void> onChartMoreOptions({required BuildContext context, required bool showTimeIntervalOption, required bool showFieldOption, required Chart chart}) async {
    try {
      // If a failure is displayed, remove it.
      if (state.status == ChartsSheetStatus.failure) {
        if (isClosed) return;

        emit(state.copyWith(
          failure: Failure.initial(),
          status: ChartsSheetStatus.waiting,
        ));
      }

      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Let user choose a time interval.
          optionOne: showTimeIntervalOption ? labels.basicLabelChooseTimeInterval() : null,
          optionOneIcon: AppIcons.interval,
          optionOneSuffix: true,
          // * Let user choose a specific field.
          optionTwo: showFieldOption ? labels.basicLabelsLimitToField() : null,
          optionTwoIcon: AppIcons.fields,
          optionTwoSuffix: true,
        ),
      );

      // * User cancled.
      if (option == null) return;

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'ChartsSheetCubit', sourceMethod: 'onChartMoreOptions()');

      // * User wants to choose a time interval.
      if (option == 1) {
        await chooseTimeInterval(context: context, chart: chart);
        return;
      }

      // * User wants to choose a specific field.
      if (option == 2) {
        await chooseSpecificField(context: context, chart: chart);
        return;
      }
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onChartMoreOptions() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onChartMoreOptions() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This function can be used to return chart title depending on chart type.
  /// * Returns empty String if chartType is unknown.
  String getChartTitle({required Chart chart}) {
    // Bar chart title.
    if (chart.chartType == Chart.chartTypeBarChart) {
      return chart.getBarChartTitle(defaultCurrencyCode: state.fromGroup.defaultCurrencyCode, isShared: state.isShared);
    }

    // Pie chart title.
    if (chart.chartType == Chart.chartTypePieChart) {
      return chart.getPieChartTitle(defaultCurrencyCode: state.fromGroup.defaultCurrencyCode);
    }

    // Line chart title.
    if (chart.chartType == Chart.chartTypeLineChart) {
      return chart.getLineChartTitle(currencyCode: state.fromGroup.defaultCurrencyCode);
    }

    // * Unknown chart type, output debug message and return empty String.
    debugPrint('LocalChartSheetCubit --> getChartTitle() --> Unknown chart type.');

    return '';
  }

  /// This function can be used to return chart info line depending on chart type.
  /// * Returns empty String if chartType is unknown.
  String getChartInfoLine({required Chart chart}) {
    // Bar chart info line.
    if (chart.chartType == Chart.chartTypeBarChart) {
      return chart.getBarChartInfoLine(fieldIdentifications: state.utilizedFieldIdentifications);
    }

    // Pie chart info line.
    if (chart.chartType == Chart.chartTypePieChart) {
      return chart.getPieChartInfoLine(fieldIdentifications: state.utilizedFieldIdentifications);
    }

    // Line chart title.
    if (chart.chartType == Chart.chartTypeLineChart) {
      return chart.getLineChartInfoLine(fieldIdentifications: state.utilizedFieldIdentifications);
    }

    // * Unknown chart type, output debug message and return empty String.
    debugPrint('LocalChartSheetCubit --> getInfoLine() --> Unknown chart type.');

    return '';
  }

  /// This method can be used to trigger a local state refresh.
  void triggerLocalStateRefresh() {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      status: ChartsSheetStatus.refreshLocalState,
    ));
  }

  // ############################################
  // # Exchange Rates
  // ############################################

  /// This method can be used to access required exchange rates.
  Future<void> accessRequiredExchangeRatesOfLocalGroup() async {
    try {
      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        exchangeRatesFailure: Failure.initial(),
        exchangeRatesStatus: ExchangeRatesStatus.loading,
      ));

      // Ensure that this will only be retriggerd if
      // Let user see loading spinner in the beginning no matter what.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Access number of invalid exchange rates.
      final int numberOfInvalidExchangeRates = await _localStorageCubit.accessRequiredExchangeRatesOfLocalGroup(
        fromGroup: state.fromGroup,
      );

      // Exchange rate actions are required before showing charts.
      if (numberOfInvalidExchangeRates != 0) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          exchangeRatesStatus: ExchangeRatesStatus.actionRequired,
        ));

        return;
      }

      // Check if debt balances should be shown.
      final bool showDebtBalances = state.participantMembers.items.length > 1;

      // Select first member initially.
      final Member? selectedMember = state.participantMembers.items.isEmpty ? null : state.participantMembers.items.first;

      // Access selected charts.
      final Charts charts = state.getCharts(
        selectedMember: selectedMember,
        showDebtBalances: showDebtBalances,
        utilizedFieldIdentifications: state.utilizedFieldIdentifications,
        utilizedCategoriesAndUnits: state.utilizedCategoriesAndUnits,
        selectedFieldType: state.selectedFieldType,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        charts: charts,
        status: ChartsSheetStatus.waiting,
        exchangeRatesStatus: ExchangeRatesStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheet --> accessRequiredExchangeRates() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        exchangeRatesFailure: failure,
        exchangeRatesStatus: ExchangeRatesStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheet --> accessRequiredExchangeRates() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        exchangeRatesFailure: Failure.genericError(),
        exchangeRatesStatus: ExchangeRatesStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to provide exchange rates.
  Future<void> onProvideExchangeRatesPressed({required BuildContext context}) async {
    // * Display ProvideExchangeRateSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<ProvideExchangeRatesSheetCubit>(
        create: (context) => ProvideExchangeRatesSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          mainScreenCubit: _mainScreenCubit,
          localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
          sharedGroupSelectedSheetCubit: _sharedGroupSelectedSheetCubit,
          chartsSheetCubit: this,
        )..initializeLocal(
            fromGroup: state.fromGroup,
          ),
        child: const ProvideExchangeRatesSheet(),
      ),
    );
  }

  // ############################################
  // # Filter
  // ############################################

  /// This method gets invoked if user wants to choose a field identification to change which charts to display.
  Future<void> onPickFieldIdentification({required BuildContext context}) async {
    try {
      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          title: labels.basicLabelsFields(),
          pickerItems: state.fieldTypes,
        ),
      );

      // * User cancelled, revert state.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = state.fieldTypes.items[pickedIndex];

      // If user picked the same identification again, do nothing.
      if (pickedItem.id == state.selectedFieldType.id) return;

      // Check if debt balances should be shown.
      final bool showDebtBalances = state.participantMembers.items.length > 1;

      // Select first member initially.
      final Member? selectedMember = state.participantMembers.items.isEmpty ? null : state.participantMembers.items.first;

      // Access selected charts.
      final Charts charts = state.getCharts(
        selectedMember: selectedMember,
        showDebtBalances: showDebtBalances,
        utilizedFieldIdentifications: state.utilizedFieldIdentifications,
        utilizedCategoriesAndUnits: state.utilizedCategoriesAndUnits,
        selectedFieldType: pickedItem,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        selectedFieldType: pickedItem,
        charts: charts,
        status: ChartsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onPickFieldIdentification() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onPickFieldIdentification() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user wants to select a measurement category.
  Future<void> onPickMeasurementCategory({required BuildContext context, required Chart chart}) async {
    try {
      // Access language specific categories.
      final PickerItems pickerItems = MeasurementData.getRelevantCategories(
        filterByFieldId: chart.filterByFieldId,
        utilizedCategoriesAndUnits: state.utilizedCategoriesAndUnits,
      );

      // Show PickerSheet.
      final int? pickerIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.measureCategoryPickerSheetTitle(),
          pickerItems: pickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickerIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickerIndex];

      // * User selected the same category, do nothing.
      if (pickedItem.id == chart.filterByMeasurementCategory) return;

      // Access category units.
      final PickerItems? units = MeasurementData.unitsAsPickerItems(category: pickedItem.id);

      // Category not found.
      if (units == null) throw Failure.unknownMeasureCategory();

      // Indicator about whether or not there is only one unit available for this category.
      final bool onlyOneUnit = units.items.length == 1;

      // Access most used unit for chosen category.
      final String mostUsedUnit = MeasurementData.getMostRelevantUnit(
        category: pickedItem.id,
        utilizedCategoriesAndUnits: state.utilizedCategoriesAndUnits,
      );

      // Create updated chart.
      final Chart updatedChart = chart.copyWith(
        filterByMeasurementCategory: pickedItem.id,
        // * Reset unit whenever a new category is chosen.
        filterByMeasurementUnit: onlyOneUnit ? units.items.first.id : mostUsedUnit,
      );

      // Create updated expense bar charts.
      final Charts updatedCharts = state.charts.update(updatedChart: updatedChart)!;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        charts: updatedCharts,
        status: ChartsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onPickMeasurementCategory() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onPickMeasurementCategory() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user wants to select a measurement unit.
  Future<void> onPickMeasurementUnit({required BuildContext context, required Chart chart}) async {
    try {
      // Let user know to first choose a measurement category.
      if (chart.filterByMeasurementCategory.isEmpty) throw Failure.measurementCategoryIsRequired();

      // Access specific units.
      final PickerItems? pickerItems = MeasurementData.unitsAsPickerItems(
        category: chart.filterByMeasurementCategory,
      );

      // Category not found.
      if (pickerItems == null) throw Failure.unknownMeasureCategory();

      // Show PickerSheet.
      final int? pickerIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.measureUnitPickerSheetTitle(),
          pickerItems: pickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickerIndex == null) return;

      // Access chosen item.
      final String pickedItemId = pickerItems.items[pickerIndex].id;

      // User selected the same unit, do nothing.
      if (pickedItemId == chart.filterByMeasurementUnit) return;

      // Create updated chart.
      final Chart updatedChart = chart.copyWith(
        filterByMeasurementUnit: pickedItemId,
      );

      // Create updated expense bar charts.
      final Charts updatedCharts = state.charts.update(updatedChart: updatedChart)!;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        charts: updatedCharts,
        status: ChartsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onPickMeasurementUnit() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> onPickMeasurementUnit() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This function can be used to choose a member.
  Future<void> chooseMember({required BuildContext context, required Chart chart}) async {
    try {
      // Access PickerItems.
      final PickerItems pickerItems = state.participantMembers.toPickerItems();

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          pickerItems: pickerItems,
        ),
      );

      // * User cancelled, revert state.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickedIndex];

      // Access picked member.
      Member? member = state.participantMembers.getById(
        memberId: pickedItem.id,
      );

      // Member is unknown.
      member ??= Member.unknownMember(memberId: pickedItem.id);

      // Create updated chart.
      final Chart updatedChart = chart.copyWith(
        filterByMember: member,
      );

      // Create updated expense bar charts.
      final Charts updatedCharts = state.charts.update(
        updatedChart: updatedChart,
      )!;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        charts: updatedCharts,
        status: ChartsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseMember() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseMember() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This function can be used to choose a date.
  Future<void> chooseYear({required BuildContext context, required Chart chart}) async {
    try {
      // Access PickerItems.
      final PickerItems pickerItems = PickerItems.years();

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          pickerItems: pickerItems,
        ),
      );

      // * User cancelled, revert state.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickedIndex];

      // Turn picked year into DateTime object.
      final DateTime? date = pickedItem.id == PickerItem.identificationAllYears ? null : DateTime(int.parse(pickedItem.id));

      // Create updated chart.
      final Chart updatedChart = chart.copyWith(
        // This is needed because copyWith cannot update a value with null.
        explicitlySetFilterByYear: true,
        filterByYear: date,
      );

      // Create updated expense bar charts.
      final Charts updatedCharts = state.charts.update(updatedChart: updatedChart)!;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        charts: updatedCharts,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseYear() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseYear() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This function can be used to choose a time interval.
  Future<void> chooseTimeInterval({required BuildContext context, required Chart chart}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Show yearly option.
          optionOne: PickerItem.yearly().label,
          optionOneIcon: AppIcons.first,
          // * Show monthly option.
          optionTwo: PickerItem.monthly().label,
          optionTwoIcon: AppIcons.second,
          // * Show daily option.
          optionThree: PickerItem.daily().label,
          optionThreeIcon: AppIcons.third,
        ),
      );

      // * User cancled.
      if (option == null) return;

      // Init picked item.
      final PickerItem pickedItem = option == 1
          ? PickerItem.yearly()
          : option == 2
              ? PickerItem.monthly()
              : PickerItem.daily();

      // Create updated chart.
      final Chart updatedChart = chart.copyWith(
        filterByTimeInterval: pickedItem.id,
        // * This ensures that filterByYear will be explicitly set if option yearly is selected.
        explicitlySetFilterByYear: option == 1,
        // * If time interval yearly is selected filterByYear needs to be set to all years.
        // * Otherwise explicitlySetFilterByYear is not utilized and null will result in not changeing this value.
        filterByYear: null,
      );

      // Create updated expense bar charts.
      final Charts updatedCharts = state.charts.update(updatedChart: updatedChart)!;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        charts: updatedCharts,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseTimeInterval() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseTimeInterval() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  /// This function can be used to choose a specific field.
  Future<void> chooseSpecificField({required BuildContext context, required Chart chart}) async {
    try {
      // Access PickerItems.
      final PickerItems pickerItems = state.utilizedFieldIdentifications.toPickerItems(
        onlyFieldType: state.selectedFieldType.id,
        displayAllFieldsOfTypeOption: chart.allowFilterForAllFields,
      );

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          pickerItems: pickerItems,
        ),
      );

      // * User cancelled, revert state.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickedIndex];

      // Check if selected field type is measurement.
      final bool isMeasurementField = state.selectedFieldType.id == Field.fieldTypeMeasurement;

      // Check if all fields of type were selected.
      final bool isAllFieldsOfType = pickedItem.id == PickerItem.identificationAllFieldsOfType;

      // Access initial categories and units.
      final Measurements? initialMeasurements = isAllFieldsOfType ? null : state.utilizedCategoriesAndUnits[pickedItem.id];

      // Get the category unit pair with the heighest count.
      // * If there are equal counts, choose the first one that is found.
      // * If it is null, let user choose.
      final MeasurementData? initial = initialMeasurements?.getMostUtilized;

      // Create updated chart.
      final Chart updatedChart = chart.copyWith(
        filterByMeasurementCategory: isMeasurementField ? initial?.category : null,
        filterByMeasurementUnit: isMeasurementField ? initial?.unit : null,
        filterByFieldId: isAllFieldsOfType ? '' : pickedItem.id,
      );

      // Create updated expense bar charts.
      final Charts updatedCharts = state.charts.update(updatedChart: updatedChart)!;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        charts: updatedCharts,
        status: ChartsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseSpecificField() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> chooseSpecificField() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Group info values.
  // ############################################

  /// This function can be used to load number of entries of a group.
  Future<int?> loadNumberOfEntries() async {
    try {
      // Access total entries.
      final int? count = await Future.value(state.totalEntries);

      return count;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadNumberOfEntries() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadNumberOfEntries() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This function can be used to load number of unique model entries of a group.
  Future<int?> loadNumberOfUniqueModelEntries() async {
    try {
      final int? count = await Future.value(state.modelEntriesOfGroup.items.length);

      return count;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadNumberOfUniqueModelEntries() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadNumberOfUniqueModelEntries() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This function can be used to load group created at as a future.
  Future<String?> loadGroupCreatedAt() async {
    final String createdAt = await Future.value(state.fromGroup.getCreatedAt);

    return createdAt;
  }

  /// This function can be used to load group edited at as a future.
  Future<String?> loadGroupEditedAt() async {
    final String editedAt = await Future.value(state.fromGroup.getEditedAt);

    return editedAt;
  }

  // ############################################
  // # Descriptive values.
  // ############################################

  /// This method can be used to load local descriptive values.
  Future<String?> loadLocalDescriptiveValue({required Chart chart, required int futurePosition}) async {
    // * Is not used in a try catch block because the widget this method is used in will take care of that.

    // Do not show futures if no instructions were supplied.
    if (chart.descriptiveValueInstructions == null) return null;

    // Convenience variables.
    final int instructionPosition = futurePosition - 1;
    final int numberOfInstructions = chart.descriptiveValueInstructions!.length;

    // Instruction position should never be greater then supplied instructions.
    if (instructionPosition > numberOfInstructions) return null;

    // Access instruction.
    final DescriptiveValueInstruction instruction = chart.descriptiveValueInstructions![instructionPosition];

    // Check if this chart exists in cache.
    double? value = await state.cachedValueCharts.getCachedDescriptiveValue(
      chart: chart,
      instruction: instruction,
    );

    // In value was found in cache, do not perform query again.
    if (value != null) {
      // Output debug message.
      debugPrint('ChartSheetCubit --> loadlocalDescriptiveValue() --> local cache used.');
      return value.toStringAsFixed(2);
    }

    // Output debug message.
    debugPrint('ChartSheetCubit --> loadlocalDescriptiveValue() --> perform chart query.');

    // Access secrets.
    final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

    // Load the maximum.
    if (instruction.instructionType == DescriptiveValueInstruction.descriptiveChartInstructionMaximum) {
      // Load measurement maximum.
      if (instruction.fieldType == Field.fieldTypeMeasurement) {
        value = await _localStorageCubit.localMeasurementDataMaximum(
          groupId: state.fromGroup.groupId,
          filterByFieldId: chart.filterByFieldId,
          filterByYear: chart.filterByYear,
          measurementCategory: chart.filterByMeasurementCategory,
          measurementUnit: chart.filterByMeasurementUnit,
          secrets: secrets,
        );
      }
    }

    // Load the minimum.
    if (instruction.instructionType == DescriptiveValueInstruction.descriptiveChartInstructionMinimum) {
      // Load measurement maximum.
      if (instruction.fieldType == Field.fieldTypeMeasurement) {
        value = await _localStorageCubit.localMeasurementDataMinimum(
          groupId: state.fromGroup.groupId,
          filterByFieldId: chart.filterByFieldId,
          filterByYear: chart.filterByYear,
          measurementCategory: chart.filterByMeasurementCategory,
          measurementUnit: chart.filterByMeasurementUnit,
          secrets: secrets,
        );
      }
    }

    // Load the average.
    if (instruction.instructionType == DescriptiveValueInstruction.descriptiveChartInstructionAverage) {
      // Load measurement maximum.
      if (instruction.fieldType == Field.fieldTypeMeasurement) {
        value = await _localStorageCubit.localMeasurementDataAverage(
          groupId: state.fromGroup.groupId,
          filterByFieldId: chart.filterByFieldId,
          filterByYear: chart.filterByYear,
          measurementCategory: chart.filterByMeasurementCategory,
          measurementUnit: chart.filterByMeasurementUnit,
          secrets: secrets,
        );
      }
    }

    // Load the sum.
    if (instruction.instructionType == DescriptiveValueInstruction.descriptiveChartInstructionSum) {
      // Load measurement sum.
      if (instruction.fieldType == Field.fieldTypeMeasurement) {
        value = await _localStorageCubit.localMeasurementDataSum(
          groupId: state.fromGroup.groupId,
          filterByFieldId: chart.filterByFieldId,
          filterByYear: chart.filterByYear,
          measurementCategory: chart.filterByMeasurementCategory,
          measurementUnit: chart.filterByMeasurementUnit,
          secrets: secrets,
        );
      }
    }

    // No value found.
    if (value == null) return labels.basicLabelsNoValueFound();

    // Create cached chart.
    final Chart cachedChart = chart.copyWith(
      // * Remove descriptiveValueInstructions for cached chart.
      descriptiveValueInstructions: const [],
      cachedDescriptiveValueInstruction: instruction,
      cachedDescriptiveValue: value,
    );

    // Create updated charts.
    final Charts updatedCache = state.cachedValueCharts.add(chart: cachedChart);

    // Only update state if cubit is still open.
    if (isClosed) return value.toStringAsFixed(2);

    // Update cache.
    emit(state.copyWith(
      cachedValueCharts: updatedCache,
    ));

    return value.toStringAsFixed(2);
  }

  /// This method can be used to load shared descriptive values.
  Future<String?> loadSharedDescriptiveValue({required Chart chart, required int futurePosition}) async {
    // * Is not used in a try catch block because the widget this method is used in will take care of that.

    // Do not show futures if no instructions were supplied.
    if (chart.descriptiveValueInstructions == null) return null;

    // Convenience variables.
    final int instructionPosition = futurePosition - 1;
    final int numberOfInstructions = chart.descriptiveValueInstructions!.length;

    // Instruction position should never be greater then supplied instructions.
    if (instructionPosition > numberOfInstructions) return null;

    // Access instruction.
    final DescriptiveValueInstruction instruction = chart.descriptiveValueInstructions![instructionPosition];

    // Check if this chart exists in cache.
    double? value = await state.cachedValueCharts.getCachedDescriptiveValue(
      chart: chart,
      instruction: instruction,
    );

    // In value was found in cache, do not perform query again.
    if (value != null) {
      // Output debug message.
      debugPrint('ChartSheetCubit --> loadlocalDescriptiveValue() --> local cache used.');
      return value.toStringAsFixed(2);
    }

    // Output debug message.
    debugPrint('ChartSheetCubit --> loadlocalDescriptiveValue() --> perform chart query.');

    // Access shared chart.
    value = await _localStorageCubit.getSharedChartItems(
      group: state.fromGroup,
      chart: chart,
      descriptiveValueInstruction: instruction.instructionType,
      chartsSheetCubit: this,
      expenseReportSheetCubit: null,
    ) as double?;

    // No value found.
    if (value == null) return labels.basicLabelsNoValueFound();

    // Create cached chart.
    final Chart cachedChart = chart.copyWith(
      // * Remove descriptiveValueInstructions for cached chart.
      descriptiveValueInstructions: const [],
      cachedDescriptiveValueInstruction: instruction,
      cachedDescriptiveValue: value,
    );

    // Create updated charts.
    final Charts updatedCache = state.cachedValueCharts.add(chart: cachedChart);

    // Only update state if cubit is still open.
    if (isClosed) return value.toStringAsFixed(2);

    // Update cache.
    emit(state.copyWith(
      cachedValueCharts: updatedCache,
    ));

    return value.toStringAsFixed(2);
  }

  // ############################################
  // # Next Birthday Entry.
  // ############################################

  /// This method can be used to access the entry with the next birthday.
  Future<List<FieldToEntry>> loadNextBirthdayEntries() async {
    // * There is no try catch in here because it is used in a FutureBuilder and errors will be displayed in widget.

    // Throw error if state is in shared mode, because next birthdays is not implemented in this mode.
    if (state.isShared) throw Failure.unimplemented();

    // Access secrets.
    final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

    // Access entry.
    final List<FieldToEntry> nextBirthdayEntries = await _localStorageCubit.getLocalNextBirthdayEntries(
      groupId: state.fromGroup.groupId,
      secrets: secrets,
    );

    return nextBirthdayEntries;
  }

  // ############################################
  // # Bar Charts.
  // ############################################

  /// This method can be used to load local Bar charts depending on chart instruction.
  Future<BarItems?> loadLocalBarChart({required Chart chart}) async {
    try {
      // Check if this chart exists in cache.
      BarItems? barItems = await state.cachedBarCharts.getCachedBarItems(
        chart: chart,
        selectedFieldType: state.selectedFieldType.id,
      );

      // In case bar items were found in cache, do not perform query again.
      if (barItems != null) {
        // Output debug message.
        debugPrint('ChartSheetCubit --> loadBarChart() --> local cache used.');
        return barItems;
      }

      // Output debug message.
      debugPrint('ChartSheetCubit --> loadBarChart() --> perform chart query.');

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Convenience variables.
      final BarInstruction barInstruction = chart.barChartInstruction!.barInstruction;
      final String instructionType = barInstruction.instructionType;

      // * User wants to calculate the debt balances for all members.
      if (instructionType == PaymentData.chartInstructionMembersDebtBalances) {
        // Calculate shares.
        barItems = await _localStorageCubit.localPaymentDataDebtBalancesAllMembers(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate the costs of a member.
      if (instructionType == PaymentData.chartInstructionCostsByMemberOverTime) {
        // Calculate values.
        barItems = await _localStorageCubit.localPaymentDataCostsByMemberOverTime(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          timeInterval: chart.filterByTimeInterval!,
          member: chart.filterByMember!,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Calculate costs by tags.
      if (instructionType == PaymentData.chartInstructionMemberCostsByTag) {
        // Calculate values.
        barItems = await _localStorageCubit.localPaymentDataMemberCostsByTag(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          member: chart.filterByMember!,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate spendings of a member over time
      if (instructionType == PaymentData.chartInstructionMemberAbsolutExpensesOverTime) {
        // Calculate shares.
        barItems = await _localStorageCubit.localPaymentDataAbsolutExpensesByMemberOverTime(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          timeInterval: chart.filterByTimeInterval!,
          member: chart.filterByMember!,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate income of a member over time
      if (instructionType == PaymentData.chartInstructionMemberAbsolutIncomeOverTime) {
        // Calculate shares.
        barItems = await _localStorageCubit.localPaymentDataAbsolutIncomeByMemberOverTime(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          timeInterval: chart.filterByTimeInterval!,
          member: chart.filterByMember!,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate profits and losses over time.
      if (instructionType == PaymentData.chartInstructionMemberAbsolutProfitsAndLosses) {
        // Calculate Profit or Loss.
        barItems = await _localStorageCubit.localPaymentDataAbsolutProfitOrLossByMemberOverTime(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          timeInterval: chart.filterByTimeInterval!,
          member: chart.filterByMember!,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Load income over time
      if (instructionType == MoneyData.chartInstructionIncomeOverTime) {
        // Perform calculation.
        barItems = await _localStorageCubit.localMoneyDataIncomeOverTime(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          timeInterval: chart.filterByTimeInterval!,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Load expenses over time
      if (instructionType == MoneyData.chartInstructionExpensesOverTime) {
        // Perform calculation.
        barItems = await _localStorageCubit.localMoneyDataExpensesOverTime(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          timeInterval: chart.filterByTimeInterval!,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Load values by entry.
      if (instructionType == MoneyData.chartInstructionValuesByEntry) {
        // Perform calculation.
        barItems = await _localStorageCubit.localMoneyDataValuesByEntry(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display numerical order or number data.
      if (instructionType == NumberData.chartInstructionNumericalOrder) {
        // Calculate bar items.
        barItems = await _localStorageCubit.localNumberDataGetNumericalOrder(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display true false history.
      if (instructionType == BooleanData.barChartTrueFalseHistory) {
        // Calculate shares.
        barItems = await _localStorageCubit.localBooleanDataTrueFalseHistory(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          maxHistoryLength: 50,
          secrets: secrets,
        );
      }

      // * Display email frequency.
      if (instructionType == EmailData.barChartFrequencyDistribution) {
        // Calculate frequencies.
        barItems = await _localStorageCubit.localEmailDataFrequencyDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display birthdays per month.
      if (instructionType == DateOfBirthData.barChartBirthdaysPerMonth) {
        // Calculate frequencies.
        barItems = await _localStorageCubit.localDateOfBirthDataBirthdaysPerMonth(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display entries by category.
      if (instructionType == TagsData.barChartEntriesByTag) {
        // Calculate frequencies.
        barItems = await _localStorageCubit.localTagsDataEntriesByTag(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display average intensity by emotion.
      if (instructionType == EmotionData.barChartAverageIntensityByEmotion) {
        // Calculate frequencies.
        barItems = await _localStorageCubit.localEmotionDataAverageIntensityByEmotion(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display average wellbeing.
      if (instructionType == EmotionData.barChartAverageWellbeing) {
        // Calculate wellbeing.
        barItems = await _localStorageCubit.localEmotionDataAverageWellbeing(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          timeInterval: chart.filterByTimeInterval!,
          secrets: secrets,
        );
      }

      // * Display latest measurement.
      if (instructionType == MeasurementData.barChartProgressionOfValue) {
        // Calculate measurement progression of value.
        barItems = await _localStorageCubit.localMeasurementDataProgressionOfValue(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          measurementCategory: chart.filterByMeasurementCategory,
          measurementUnit: chart.filterByMeasurementUnit,
          secrets: secrets,
        );
      }

      // In case bar items are available, update cache and return bar items.
      if (barItems != null) {
        // Create cached chart.
        final Chart cachedChart = chart.copyWith(
          cachedBarItems: barItems,
        );

        // Create updated charts.
        final Charts updatedCache = state.cachedBarCharts.add(chart: cachedChart);

        // Only update state if cubit is still open.
        if (isClosed) return barItems;

        // Update cache.
        emit(state.copyWith(
          cachedBarCharts: updatedCache,
        ));

        return barItems;
      }

      // * If bar items are null, bar instruction used is not omplemented. Throw Failure Unknown instruction.
      throw Failure.unknownChartInstruction();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadBarChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadBarChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  /// This method can be used to load shared Bar charts depending on chart instruction.
  Future<BarItems?> loadSharedBarChart({required Chart chart, required bool bypassCache}) async {
    try {
      // Check if this chart exists in cache.
      BarItems? barItems = bypassCache
          ? null
          : await state.cachedBarCharts.getCachedBarItems(
              chart: chart,
              selectedFieldType: state.selectedFieldType.id,
            );

      // In case bar items were found in cache, do not perform query again.
      if (barItems != null) {
        // Output debug message.
        debugPrint('ChartSheetCubit --> loadSharedBarChart() --> local cache used.');
        return barItems;
      }

      // Output debug message.
      debugPrint('ChartSheetCubit --> loadSharedBarChart() --> perform chart query.');

      // Access shared chart.
      barItems = await _localStorageCubit.getSharedChartItems(
        group: state.fromGroup,
        chart: chart,
        chartsSheetCubit: this,
        descriptiveValueInstruction: null,
        expenseReportSheetCubit: null,
      ) as BarItems;

      // Create cached chart.
      final Chart cachedChart = chart.toCachedBarChart(
        barItems: barItems,
      );

      // In case this was a bypass, remove old chart.
      if (bypassCache) state.cachedBarCharts.remove(chart: chart);

      // Create updated charts.
      final Charts updatedCache = state.cachedBarCharts.add(
        chart: cachedChart,
      );

      // Only update state if cubit is still open.
      if (isClosed) return barItems;

      // Update cache.
      emit(state.copyWith(
        cachedBarCharts: updatedCache,
      ));

      return barItems;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadSharedBarChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadSharedBarChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  // ############################################
  // # Pie Charts.
  // ############################################

  /// This method can be used to load Pie charts depending on chart instruction.
  Future<PieItems?> loadLocalPieChart({required Chart chart}) async {
    try {
      // Check if this chart exists in cache.
      PieItems? pieItems = await state.cachedPieCharts.getCachedPieItems(
        chart: chart,
        selectedFieldType: state.selectedFieldType.id,
      );

      // In case pie items were found in cache, do not perform query again.
      if (pieItems != null) {
        // Output debug message.
        debugPrint('ChartSheetCubit --> loadPieChart() --> local cache used.');
        return pieItems;
      }

      // Output debug message.
      debugPrint('ChartSheetCubit --> loadPieChart() --> perform chart query.');

      // Convenience variables.
      final PieInstruction pieInstruction = chart.pieChartInstruction!.pieInstruction;
      final String instructionType = pieInstruction.instructionType;

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // * User wants to calculate the debt balances for all members.
      if (instructionType == PaymentData.pieChartMemberCostSharesByTag) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localPaymentDataMemberCostSharesByTag(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          filterByMember: chart.filterByMember!,
          secrets: secrets,
        );
      }

      // * User wants to calculate the true false distribution.
      if (instructionType == BooleanData.pieChartTrueFalseDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localBooleanDataTrueFalseDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate the frequency distribution of emails in percent.
      if (instructionType == EmailData.pieChartFrequencyShares) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localEmailDataFrequencyShares(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate the frequency distribution of email providers.
      if (instructionType == EmailData.pieChartProviderDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localEmailDataProviderShares(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate the frequency distribution of usernames.
      if (instructionType == UsernameData.pieChartUsernameDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localUsernameDataUsernameDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about distribution of entries with and without avatar image.
      if (instructionType == AvatarImageData.pieChartHasImageDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localAvatarImageDataHasImageDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about distribution of entries with and without avatar image title.
      if (instructionType == AvatarImageData.pieChartHasTitleDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localAvatarImageDataHasTitleDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about distribution of entries with and without avatar image text.
      if (instructionType == AvatarImageData.pieChartHasTextDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localAvatarImageDataHasTextDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about seasonal distribution of birthdays.
      if (instructionType == DateOfBirthData.pieChartSeasonalBirthdayDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localDateOfBirthDataSeasonalDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about currency distribution.
      if (instructionType == MoneyData.pieChartCurrencyDistribution) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localMoneyDataCurrencyDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about expenses by category.
      if (instructionType == MoneyData.pieChartExpensesByCategory) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localMoneyDataExpensesByCategory(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about income by category.
      if (instructionType == MoneyData.pieChartIncomeByCategory) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localMoneyDataIncomeByCategory(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about entries shares by category.
      if (instructionType == TagsData.pieChartEntriesShareByTag) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localTagsDataEntrySharesByTag(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Show chart about positive and negative emotions distribution.
      if (instructionType == EmotionData.pieChartPositiveAndNegativeEmotionsProportion) {
        // Calculate shares.
        pieItems = await _localStorageCubit.localEmotionDataPositiveAndNegativeDistribution(
          groupId: state.fromGroup.groupId,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // In case pie items are available, update cache and return pie items.
      if (pieItems != null) {
        // Create cached chart.
        final Chart cachedChart = chart.copyWith(
          cachedPieItems: pieItems,
        );

        // Create updated charts.
        final Charts updatedCache = state.cachedPieCharts.add(chart: cachedChart);

        // Only update state if cubit is still open.
        if (isClosed) return pieItems;

        // Update cache.
        emit(state.copyWith(
          cachedPieCharts: updatedCache,
        ));

        return pieItems;
      }

      // * Unknown instruction.
      throw Failure.unknownChartInstruction();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadPieChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadPieChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  /// This method can be used to load shared Pie charts depending on chart instruction.
  Future<PieItems?> loadSharedPieChart({required Chart chart, required bool bypassCache}) async {
    try {
      // Check if this chart exists in cache.
      PieItems? pieItems = bypassCache
          ? null
          : await state.cachedPieCharts.getCachedPieItems(
              chart: chart,
              selectedFieldType: state.selectedFieldType.id,
            );

      // In case pie items were found in cache, do not perform query again.
      if (pieItems != null) {
        // Output debug message.
        debugPrint('ChartSheetCubit --> loadSharedPieChart() --> local cache used.');
        return pieItems;
      }

      // Output debug message.
      debugPrint('ChartSheetCubit --> loadSharedPieChart() --> perform chart query.');

      // Access shared chart.
      pieItems = await _localStorageCubit.getSharedChartItems(
        group: state.fromGroup,
        chart: chart,
        descriptiveValueInstruction: null,
        chartsSheetCubit: this,
        expenseReportSheetCubit: null,
      ) as PieItems;

      // Create cached chart.
      final Chart cachedChart = chart.toCachedPieChart(
        pieItems: pieItems,
      );

      // In case this was a bypass, remove old chart.
      if (bypassCache) state.cachedPieCharts.remove(chart: chart);

      // Create updated charts.
      final Charts updatedCache = state.cachedPieCharts.add(
        chart: cachedChart,
      );

      // Only update state if cubit is still open.
      if (isClosed) return pieItems;

      // Update cache.
      emit(state.copyWith(
        cachedPieCharts: updatedCache,
      ));

      return pieItems;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadSharedPieChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadSharedPieChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  /// This method will be triggerd if user taps on a pie chart legend item.
  Future<void> onPieItemLegendTap({required PieItem pieItem, required int legendItemIndex, required Chart chart, required BuildContext context}) async {
    try {
      // Let user know that this is not available yet in shared mode.
      if (state.isShared) throw Failure.unimplemented();

      // * Supplied reference id is connected to a Tag.
      if (pieItem.referenceType == 'tag') {
        // Show a view entries sheet based on tag.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<ViewEntriesSheetCubit>(
            create: (context) => ViewEntriesSheetCubit(
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
              chartsSheetCubit: this,
            )..initializeLocal(
                fromGroup: state.fromGroup,
                referenceType: pieItem.referenceType,
                referenceId: pieItem.referenceId,
                chart: chart,
              ),
            child: const ViewEntriesSheet(),
          ),
        );

        return;
      }

      // * Supplied reference id indicates to access entries that miss a tag.
      if (pieItem.referenceType == 'untagged_by_field_id') {
        // Show a view entries sheet based on tag.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<ViewEntriesSheetCubit>(
            create: (context) => ViewEntriesSheetCubit(
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
              chartsSheetCubit: this,
            )..initializeLocal(
                fromGroup: state.fromGroup,
                referenceType: pieItem.referenceType,
                referenceId: pieItem.referenceId,
                chart: chart,
              ),
            child: const ViewEntriesSheet(),
          ),
        );

        return;
      }

      // * Supplied reference id indicates to access entries that miss a tag.
      if (pieItem.referenceType == 'untagged_by_field_type') {
        // Show a view entries sheet based on tag.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<ViewEntriesSheetCubit>(
            create: (context) => ViewEntriesSheetCubit(
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
              chartsSheetCubit: this,
            )..initializeLocal(
                fromGroup: state.fromGroup,
                referenceType: pieItem.referenceType,
                referenceId: pieItem.referenceId,
                chart: chart,
              ),
            child: const ViewEntriesSheet(),
          ),
        );

        return;
      }
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheet --> onPieItemLegendTap() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: ChartsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheet --> onPieItemLegendTap() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ChartsSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Line Charts.
  // ############################################

  /// This method can be used to load Line charts depending on chart instruction.
  Future<LineItems?> loadLocalLineChart({required Chart chart}) async {
    try {
      // Check if this chart exists in cache.
      LineItems? lineItems = await state.cachedLineCharts.getCachedLineItems(
        chart: chart,
        selectedFieldType: state.selectedFieldType.id,
      );

      // In case line items were found in cache, do not perform query again.
      if (lineItems != null) {
        // Output debug message.
        debugPrint('ChartSheetCubit --> loadLineChart() --> local cache used.');
        return lineItems;
      }

      // Output debug message.
      debugPrint('ChartSheetCubit --> loadLineChart() --> perform chart query.');

      // Convenience variables.
      final LineInstruction lineInstruction = chart.lineChartInstruction!.lineInstruction;
      final String instructionType = lineInstruction.instructionType;

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // * Display numerical progression for number data individual values.
      if (instructionType == NumberData.chartInstructionNumericalProgressionIndividual) {
        // Access Data.
        lineItems = await _localStorageCubit.localNumberDataGetNumericalProgressionIndividual(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display numerical progression for number data accumulated values.
      if (instructionType == NumberData.chartInstructionNumericalProgressionAccumulated) {
        // Access Data.
        lineItems = await _localStorageCubit.localNumberDataGetNumericalProgressionAccumulated(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * Display numerical progression for money data.
      if (instructionType == MoneyData.chartInstructionMoneyProgressionAccumulated) {
        // Access Data.
        lineItems = await _localStorageCubit.localMoneyDataGetNumericalProgressionAccumulated(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // In case line items are available, update cache and return pie items.
      if (lineItems != null) {
        // Create cached chart.
        final Chart cachedChart = chart.copyWith(
          cachedLineItems: lineItems,
        );

        // Create updated charts.
        final Charts updatedCache = state.cachedLineCharts.add(chart: cachedChart);

        // Only update state if cubit is still open.
        if (isClosed) return lineItems;

        // Update cache.
        emit(state.copyWith(
          cachedLineCharts: updatedCache,
        ));

        return lineItems;
      }

      // * Unknown instruction.
      throw Failure.unknownChartInstruction();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadLineChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadLineChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  /// This method can be used to load shared Line charts depending on chart instruction.
  Future<LineItems?> loadSharedLineChart({required Chart chart, required bool bypassCache}) async {
    try {
      // Check if this chart exists in cache.
      LineItems? lineItems = bypassCache
          ? null
          : await state.cachedLineCharts.getCachedLineItems(
              chart: chart,
              selectedFieldType: state.selectedFieldType.id,
            );

      // In case line items were found in cache, do not perform query again.
      if (lineItems != null) {
        // Output debug message.
        debugPrint('ChartSheetCubit --> loadSharedLineChart() --> local cache used.');
        return lineItems;
      }

      // Output debug message.
      debugPrint('ChartSheetCubit --> loadSharedLineChart() --> perform chart query.');

      // Access shared chart.
      lineItems = await _localStorageCubit.getSharedChartItems(
        group: state.fromGroup,
        chart: chart,
        descriptiveValueInstruction: null,
        chartsSheetCubit: this,
        expenseReportSheetCubit: null,
      ) as LineItems;

      // Create cached chart.
      final Chart cachedChart = chart.toCachedLineChart(
        lineItems: lineItems,
      );

      // In case this was a bypass, remove old chart.
      if (bypassCache) state.cachedLineCharts.remove(chart: chart);

      // Create updated charts.
      final Charts updatedCache = state.cachedLineCharts.add(
        chart: cachedChart,
      );

      // Only update state if cubit is still open.
      if (isClosed) return lineItems;

      // Update cache.
      emit(state.copyWith(
        cachedLineCharts: updatedCache,
      ));

      return lineItems;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadSharedLineChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> loadSharedLineChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  // ############################################
  // # Update cascade methods.
  // ############################################

  /// This method can be used to update a ```chart``` in ```state.charts```.
  void updateCharts({required Chart chart}) {
    // Updated charts.
    final Charts? updatedCharts = state.charts.update(updatedChart: chart);

    // If chart was not found in charts, do nothing.
    if (updatedCharts == null) {
      // Output debug message.
      debugPrint('ChartsSheetCubit --> updateCharts() --> chart not found, state update not performed.');
    }

    // Only perform update if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      charts: updatedCharts!,
    ));
  }

  /// This method can be used to update the "numberOfInvalidEntries" in state.
  Future<void> updateNumberOfInvalidEntries({required bool isFinished}) async {
    // * There are still issues left.
    if (isFinished == false) return;

    // Check if debt balances should be shown.
    final bool showDebtBalances = state.participantMembers.items.length > 1;

    // Select first member initially.
    final Member? selectedMember = state.participantMembers.items.isEmpty ? null : state.participantMembers.items.first;

    // Access selected charts.
    final Charts charts = state.getCharts(
      selectedMember: selectedMember,
      showDebtBalances: showDebtBalances,
      utilizedFieldIdentifications: state.utilizedFieldIdentifications,
      utilizedCategoriesAndUnits: state.utilizedCategoriesAndUnits,
      selectedFieldType: state.selectedFieldType,
    );

    // Only perform update if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      charts: charts,
      exchangeRatesStatus: ExchangeRatesStatus.waiting,
    ));
  }
}
