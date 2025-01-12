import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/cubit/charts_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/view_entries_sheet/cubit/view_entries_sheet_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/view_entries_sheet/view_entries_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/field_types/payment_data/creditors_debitors.dart';
import '/data/models/charts/bar_chart/instructions/bar_instruction.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/charts/line_chart/items/line_items.dart';
import '/data/models/charts/line_chart/instructions/line_instruction.dart';
import '/data/models/charts/chart.dart';
import '/data/models/charts/charts.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/fields/field.dart';
import '/data/models/charts/pie_chart/items/pie_items.dart';
import '/data/models/members/member.dart';
import '/data/models/members/members.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/charts/pie_chart/items/pie_item.dart';
import '/data/models/secrets/secrets.dart';

part 'expense_report_sheet_state.dart';

class ExpenseReportSheetCubit extends Cubit<ExpenseReportSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final MainScreenCubit _mainScreenCubit;
  final AppMessagesCubit _appMessagesCubit;
  final ChartsSheetCubit _chartsSheetCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;

  ExpenseReportSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required MainScreenCubit mainScreenCubit,
    required AppMessagesCubit appMessagesCubit,
    required ChartsSheetCubit chartsSheetCubit,
    LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _mainScreenCubit = mainScreenCubit,
        _appMessagesCubit = appMessagesCubit,
        _chartsSheetCubit = chartsSheetCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        super(ExpenseReportSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize state data.
  Future<void> initialize({required bool isShared, required bool isRefresh, required Group group, required String filterByFieldId, required Members participantMembers, required DateTime? filterByYear, required FieldIdentifications utilizedFieldIdentifications}) async {
    try {
      // * Necessary to avoid UI delay.
      // * Not needed if this is a refresh.
      if (isRefresh == false) await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      if (isRefresh) {
        // Only emit new state if cubit is still active.
        if (isClosed) return;

        emit(state.copyWith(
          cachedBarCharts: Charts.initial(),
          cachedPieCharts: Charts.initial(),
          cachedLineCharts: Charts.initial(),
        ));

        // Await state update.
        await Future.delayed(const Duration(milliseconds: AppDurations.microService));
      }

      // If this is a refresh init values have to be accessed again from server.
      if (isShared && isRefresh) {
        // Access group.
        group = await _localStorageCubit.getSharedGroupById(groupId: group.groupId);

        // Access participant.
        participantMembers = await _localStorageCubit.getSharedMembersOfParticipant(
          participantId: group.participantReference,
          rootGroupReference: group.rootGroupReference,
          referenceType: group.getReferenceType,
          referenceId: group.groupId,
        );

        // Access chart init data.
        final Map<String, dynamic> chartInitData = await _localStorageCubit.getInitialChartsDataOfSharedGroup(
          group: group,
        );

        // Access data.
        utilizedFieldIdentifications = chartInitData['field_identifications'];
        final int totalEntries = chartInitData['total_entries'];

        // Make sure user can only use this page if there are entries and fields present.
        if (totalEntries == 0 || utilizedFieldIdentifications.items.isEmpty) throw Failure.genericError();

        // Only emit new state if cubit is still active.
        if (isClosed) return;

        emit(state.copyWith(
          fromGroup: group,
        ));

        // Await state update.
        await Future.delayed(const Duration(milliseconds: AppDurations.microService));
      }

      // Access first Member of partcipant members.
      final Member? selectedMember = participantMembers.items.isEmpty ? null : participantMembers.items.first;

      // Init charts.
      final Charts charts = Charts(
        items: [
          // * Costs of all members.
          Chart.expenseDataTotalCostsAllMembers().copyWith(
            filterByFieldId: filterByFieldId,
            filterByYear: filterByYear,
          ),
          // * Cost percentage of overall costs.
          Chart.expenseDataMemberCostsOfOverallCosts(
            filterByMember: selectedMember,
          ).copyWith(
            filterByFieldId: filterByFieldId,
            filterByYear: filterByYear,
          ),
          // * Total costs by tag.
          Chart.expenseDataOverallCostsByTag().copyWith(
            filterByFieldId: filterByFieldId,
            filterByYear: filterByYear,
          ),
          // * Total cost shares by tag.
          Chart.expenseDataOverallCostSharesByTag().copyWith(
            filterByFieldId: filterByFieldId,
            filterByYear: filterByYear,
          ),
        ],
      );

      // Only emit new state if cubit is still active.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: isShared,
        fromGroup: group,
        filterByFieldId: filterByFieldId,
        filterByYear: filterByYear,
        utilizedFieldIdentifications: utilizedFieldIdentifications,
        charts: charts,
        participantMembers: participantMembers,
        status: ExpenseReportSheetStatus.waiting,
      ));

      // * Microservice to wait for state update.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      loadSettlement();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: failure,
        status: ExpenseReportSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ExpenseReportSheetStatus.pageHasError,
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
      status: ExpenseReportSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  /// This method can be used to let user choose between showing optimized transactions or all transactions.
  Future<void> onShowOptimizeOptions({required BuildContext context}) async {
    try {
      // * If state is already loading, do nothing.
      if (state.settlementStatus == LoadSettlementStatus.loading) throw Failure.isAlreadyLoading();

      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Show all transactions
          optionOne: labels.basicLabelsShowAll(),
          optionOneIcon: AppIcons.sort,
          // * Show optimized transactions.
          optionTwo: labels.basicLabelsShowOptimized(),
          optionTwoIcon: AppIcons.sort,
        ),
      );

      // * User cancelled.
      if (option == null) return;

      // * User selected the same option.
      if (state.showAllTransactions && option == 1) return;

      // * User selected the same option.
      if (state.showAllTransactions == false && option == 2) return;

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // * Rest state!
      emit(state.copyWith(
        showAllTransactions: option == 1,
        settlementStatus: LoadSettlementStatus.triggerReload,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('ExpensereportSheetCubit --> onShowOptimizeOptions() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: ExpenseReportSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('ExpensereportSheetCubit --> onShowOptimizeOptions() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExpenseReportSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to recalculate the current selected settlement option.
  void reloadSettlement() {
    // * If state is already loading, do nothing.
    if (state.settlementStatus == LoadSettlementStatus.loading) return;

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // * Rest state!
    emit(state.copyWith(
      settlementStatus: LoadSettlementStatus.triggerReload,
    ));
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
        status: ExpenseReportSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> chooseMember() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ExpenseReportSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> chooseMember() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExpenseReportSheetStatus.failure,
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
      debugPrint('ExpenseReportSheetCubit --> chooseDate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ExpenseReportSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> chooseDate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExpenseReportSheetStatus.failure,
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

    // * Unknown chart type, output debug message and return empty String.
    debugPrint('ExpenseReportSheetCubit --> getChartTitle() --> Unknown chart type.');

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

    // * Unknown chart type, output debug message and return empty String.
    debugPrint('ExpenseReportSheetCubit --> getInfoLine() --> Unknown chart type.');

    return '';
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
              expenseReportSheetCubit: this,
              chartsSheetCubit: _chartsSheetCubit,
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
              expenseReportSheetCubit: this,
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
              expenseReportSheetCubit: this,
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
      debugPrint('ExpenseReportSheetCubit --> onPieItemLegendTap() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: ExpenseReportSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> onPieItemLegendTap() --> exception: ${exception.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ExpenseReportSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to trigger a local state refresh.
  void triggerLocalStateRefresh() {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      status: ExpenseReportSheetStatus.refreshLocalState,
    ));
  }

  // ############################################
  // # Bar Charts.
  // ############################################

  /// This method can be used to load local Bar charts depending on chart instruction.
  Future<BarItems?> loadlocalBarChart({required Chart chart}) async {
    try {
      // Check if this chart exists in cache.
      BarItems? barItems = await state.cachedBarCharts.getCachedBarItems(
        chart: chart,
        selectedFieldType: Field.fieldTypePayment,
      );

      // In case bar items were found in cache, do not perform query again.
      if (barItems != null) {
        // Output debug message.
        debugPrint('ExpenseReportSheetCubit --> loadlocalBarChart() --> local cache used.');
        return barItems;
      }

      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadlocalBarChart() --> perform chart query.');

      // Convenience variables.
      final BarInstruction barInstruction = chart.barChartInstruction!.barInstruction;
      final String instructionType = barInstruction.instructionType;

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // * User wants to calculate the costs for all members.
      if (instructionType == PaymentData.chartInstructionMembersTotalCosts) {
        // Calculate shares.
        barItems = await _localStorageCubit.localPaymentDataTotalCostsAllMembers(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );
      }

      // * User wants to calculate the overall costs by tag.
      if (instructionType == PaymentData.chartInstructionOverallCostsByTag) {
        // Calculate Profit or Loss.
        barItems = await _localStorageCubit.localPaymentDataOverallCostsByTag(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
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
      debugPrint('ExpenseReportSheetCubit --> loadlocalBarChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadlocalBarChart() --> exception: ${exception.toString()}');

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
              selectedFieldType: Field.fieldTypePayment,
            );

      // In case bar items were found in cache, do not perform query again.
      if (barItems != null) {
        // Output debug message.
        debugPrint('ExpenseReportSheetCubit --> loadSharedBarChart() --> local cache used.');
        return barItems;
      }

      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadSharedBarChart() --> perform chart query.');

      // Access shared chart.
      barItems = await _localStorageCubit.getSharedChartItems(
        group: state.fromGroup,
        chart: chart,
        descriptiveValueInstruction: null,
        chartsSheetCubit: null,
        expenseReportSheetCubit: this,
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
      debugPrint('ExpenseReportSheetCubit --> loadSharedBarChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadSharedBarChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  // ############################################
  // # Load Pie Charts.
  // ############################################

  /// This method can be used to load Pie charts depending on chart instruction.
  Future<PieItems?> loadlocalPieChart({required Chart chart}) async {
    try {
      // Access instruction type.
      final String instructionType = chart.pieChartInstruction!.pieInstruction.instructionType;

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // * User wants to calculate the member percentage of the overall spent.
      if (instructionType == PaymentData.pieChartMemberCostsOfOverallCosts) {
        // Calculate percentage.
        final PieItems pieItems = await _localStorageCubit.localPaymentDataMemberCostsOfOverallCosts(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByMember: chart.filterByMember!,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );

        return pieItems;
      }

      // * User wants to calculate the overall cost shares by tag.
      if (instructionType == PaymentData.pieChartOverallCostSharesByTag) {
        // Calculate percentage.
        final PieItems pieItems = await _localStorageCubit.localPaymentDataOverallCostsSharesByTag(
          groupId: state.fromGroup.groupId,
          defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
          filterByYear: chart.filterByYear,
          filterByFieldId: chart.filterByFieldId,
          secrets: secrets,
        );

        return pieItems;
      }

      // * Unknown instruction.
      throw Failure.unknownChartInstruction();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadPieChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadPieChart() --> exception: ${exception.toString()}');

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
              selectedFieldType: Field.fieldTypePayment,
            );

      // In case pie items were found in cache, do not perform query again.
      if (pieItems != null) {
        // Output debug message.
        debugPrint('ExpenseReportSheetCubit --> loadSharedPieChart() --> local cache used.');
        return pieItems;
      }

      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadSharedPieChart() --> perform chart query.');

      // Access shared chart.
      pieItems = await _localStorageCubit.getSharedChartItems(
        group: state.fromGroup,
        chart: chart,
        descriptiveValueInstruction: null,
        chartsSheetCubit: null,
        expenseReportSheetCubit: this,
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
      debugPrint('ExpenseReportSheetCubit --> loadSharedPieChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadSharedPieChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  // ############################################
  // # Load Line Charts.
  // ############################################

  /// This method can be used to load Line charts depending on chart instruction.
  Future<LineItems?> loadLocalLineChart({required Chart chart}) async {
    try {
      // Check if this chart exists in cache.
      LineItems? lineItems = await state.cachedLineCharts.getCachedLineItems(
        chart: chart,
        selectedFieldType: Field.fieldTypePayment,
      );

      // In case line items were found in cache, do not perform query again.
      if (lineItems != null) {
        // Output debug message.
        debugPrint('ExpenseReportSheetCubit --> loadLocalLineChart() --> local cache used.');
        return lineItems;
      }

      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadLocalLineChart() --> perform chart query.');

      // Convenience variables.
      final LineInstruction lineInstruction = chart.lineChartInstruction!.lineInstruction;
      final String _ = lineInstruction.instructionType;

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
      debugPrint('ExpenseReportSheetCubit --> loadLocalLineChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadLocalLineChart() --> exception: ${exception.toString()}');

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
          : await state.cachedPieCharts.getCachedLineItems(
              chart: chart,
              selectedFieldType: Field.fieldTypePayment,
            );

      // In case line items were found in cache, do not perform query again.
      if (lineItems != null) {
        // Output debug message.
        debugPrint('ExpenseReportSheetCubit --> loadSharedLineChart() --> local cache used.');
        return lineItems;
      }

      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadSharedLineChart() --> perform chart query.');

      // Access shared chart.
      lineItems = await _localStorageCubit.getSharedChartItems(
        group: state.fromGroup,
        chart: chart,
        descriptiveValueInstruction: null,
        chartsSheetCubit: null,
        expenseReportSheetCubit: this,
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
      debugPrint('ExpenseReportSheetCubit --> loadSharedLineChart() --> failure: ${failure.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('ExpenseReportSheetCubit --> loadSharedLineChart() --> exception: ${exception.toString()}');

      // * Do not update state because chart failure is managed internally by the CustomChart Widget.

      return null;
    }
  }

  // ############################################
  // # Load Settlement
  // ############################################

  /// This method can be used to load settlement.
  Future<void> loadSettlement() async {
    try {
      // Emit loading state if needed.
      if (state.settlementStatus != LoadSettlementStatus.loading) {
        // Only emit new state if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          failure: Failure.initial(),
          creditorsDebitors: CreditorsDebitors.initial(),
          settlementStatus: LoadSettlementStatus.loading,
        ));
      }

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // * Calculate creditors and debitors.
      final CreditorsDebitors creditorsDebitors = state.isShared
          ? await _localStorageCubit.sharedPaymentDataCreditorsDebitors(
              group: state.fromGroup,
              filterByFieldId: state.filterByFieldId,
              filterByYear: state.filterByYear,
              showAllTransactions: state.showAllTransactions,
              expenseReportSheetCubit: this,
            )
          : await _localStorageCubit.localPaymentDataCreditorsDebitors(
              group: state.fromGroup,
              filterByFieldId: state.filterByFieldId,
              filterByYear: state.filterByYear,
              showAllTransactions: state.showAllTransactions,
              secrets: secrets,
            );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        creditorsDebitors: creditorsDebitors,
        settlementStatus: LoadSettlementStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('ExpensereportSheetCubit --> loadSettlement() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // * Do not use state failure to display failure because the failure overlay shows up
      // * over the try again button and the UI experience is impaired. A static failure message is shown in the widget.
      emit(state.copyWith(
        settlementStatus: LoadSettlementStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('ExpensereportSheetCubit --> loadSettlement() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // * Do not use state failure to display failure because the failure overlay shows up
      // * over the try again button and the UI experience is impaired. A static failure message is shown in the widget.
      emit(state.copyWith(
        settlementStatus: LoadSettlementStatus.failure,
      ));
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
      debugPrint('ExpenseReportSheetCubit --> updateCharts() --> chart not found, state update not performed.');
    }

    // Only perform update if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      charts: updatedCharts!,
    ));
  }

  /// This method can be used to update ```updateCreditorsDebitorsLoadingMessage```.
  void updateCreditorsDebitorsLoadingMessage({required String loadingMessage}) {
    // Only perform update if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      creditorsDebitorsLoadingMessage: loadingMessage,
    ));
  }
}
