part of 'expense_report_sheet_cubit.dart';

enum ExpenseReportSheetStatus { pageHasError, pageIsLoading, refreshLocalState, loading, waiting, failure, close }

enum LoadSettlementStatus { failure, triggerReload, loading, waiting }

class ExpenseReportSheetState extends Equatable {
  final bool isShared;

  final Charts cachedBarCharts;
  final Charts cachedPieCharts;
  final Charts cachedLineCharts;

  final CreditorsDebitors creditorsDebitors;
  final String creditorsDebitorsLoadingMessage;

  final Group fromGroup;
  final String filterByFieldId;
  final DateTime? filterByYear;

  final Members participantMembers;
  final FieldIdentifications utilizedFieldIdentifications;
  final Charts charts;

  final String pageLoadingMessage;
  final bool showAllTransactions;

  final Failure failure;
  final Failure pageFailure;
  final ExpenseReportSheetStatus status;

  final LoadSettlementStatus settlementStatus;

  const ExpenseReportSheetState({
    required this.isShared,
    required this.cachedBarCharts,
    required this.cachedPieCharts,
    required this.cachedLineCharts,
    required this.creditorsDebitors,
    required this.creditorsDebitorsLoadingMessage,
    required this.fromGroup,
    required this.pageLoadingMessage,
    required this.showAllTransactions,
    required this.utilizedFieldIdentifications,
    required this.participantMembers,
    required this.failure,
    required this.pageFailure,
    required this.status,
    required this.settlementStatus,
    required this.filterByFieldId,
    required this.filterByYear,
    required this.charts,
  });

  @override
  List<Object?> get props => [
        isShared,
        cachedBarCharts,
        cachedPieCharts,
        cachedLineCharts,
        creditorsDebitors,
        creditorsDebitorsLoadingMessage,
        fromGroup,
        participantMembers,
        charts,
        utilizedFieldIdentifications,
        showAllTransactions,
        pageLoadingMessage,
        filterByFieldId,
        filterByYear,
        failure,
        pageFailure,
        settlementStatus,
        status,
      ];

  /// Initialize a new ```ExpenseReportSheetState``` object.
  factory ExpenseReportSheetState.initial() {
    return ExpenseReportSheetState(
      isShared: false,
      cachedBarCharts: Charts.initial(),
      cachedPieCharts: Charts.initial(),
      cachedLineCharts: Charts.initial(),
      creditorsDebitors: CreditorsDebitors.initial(),
      creditorsDebitorsLoadingMessage: '',
      fromGroup: Group.initial(),
      pageLoadingMessage: labels.expenseReportSheetStateLoadingMessage(),
      showAllTransactions: false,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      utilizedFieldIdentifications: FieldIdentifications.initial(),
      status: ExpenseReportSheetStatus.pageIsLoading,
      settlementStatus: LoadSettlementStatus.loading,
      filterByFieldId: '',
      filterByYear: null,
      participantMembers: Members.initial(),
      charts: Charts.initial(),
    );
  }

  ExpenseReportSheetState copyWith({
    bool? isShared,
    Charts? cachedBarCharts,
    Charts? cachedPieCharts,
    Charts? cachedLineCharts,
    CreditorsDebitors? creditorsDebitors,
    String? creditorsDebitorsLoadingMessage,
    Group? fromGroup,
    String? filterByFieldId,
    DateTime? filterByYear,
    Members? participantMembers,
    FieldIdentifications? utilizedFieldIdentifications,
    Charts? charts,
    String? pageLoadingMessage,
    bool? showAllTransactions,
    Failure? failure,
    Failure? pageFailure,
    ExpenseReportSheetStatus? status,
    LoadSettlementStatus? settlementStatus,
  }) {
    return ExpenseReportSheetState(
      isShared: isShared ?? this.isShared,
      cachedBarCharts: cachedBarCharts ?? this.cachedBarCharts,
      cachedPieCharts: cachedPieCharts ?? this.cachedPieCharts,
      cachedLineCharts: cachedLineCharts ?? this.cachedLineCharts,
      creditorsDebitors: creditorsDebitors ?? this.creditorsDebitors,
      creditorsDebitorsLoadingMessage: creditorsDebitorsLoadingMessage ?? this.creditorsDebitorsLoadingMessage,
      fromGroup: fromGroup ?? this.fromGroup,
      filterByFieldId: filterByFieldId ?? this.filterByFieldId,
      filterByYear: filterByYear ?? this.filterByYear,
      participantMembers: participantMembers ?? this.participantMembers,
      utilizedFieldIdentifications: utilizedFieldIdentifications ?? this.utilizedFieldIdentifications,
      charts: charts ?? this.charts,
      pageLoadingMessage: pageLoadingMessage ?? this.pageLoadingMessage,
      showAllTransactions: showAllTransactions ?? this.showAllTransactions,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
      settlementStatus: settlementStatus ?? this.settlementStatus,
    );
  }
}
