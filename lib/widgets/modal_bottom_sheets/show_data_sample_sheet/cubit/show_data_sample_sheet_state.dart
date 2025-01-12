part of 'show_data_sample_sheet_cubit.dart';

enum ShowDataSampleSheetStatus { pageIsLoading, pageHasError, loading, waiting, failure, close }

class ShowDataSampleSheetState extends Equatable {
  final List<List<dynamic>> csvTable;

  final Failure pageFailure;

  final Failure failure;
  final ShowDataSampleSheetStatus status;

  const ShowDataSampleSheetState({
    required this.csvTable,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [csvTable, pageFailure, failure, status];

  /// Initialize a new ```ShowDataSampleSheetState``` object.
  factory ShowDataSampleSheetState.initial() {
    return ShowDataSampleSheetState(
      csvTable: const [],
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: ShowDataSampleSheetStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  ShowDataSampleSheetState copyWith({
    List<List<dynamic>>? csvTable,
    Failure? pageFailure,
    Failure? failure,
    ShowDataSampleSheetStatus? status,
  }) {
    return ShowDataSampleSheetState(
      csvTable: csvTable ?? this.csvTable,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
