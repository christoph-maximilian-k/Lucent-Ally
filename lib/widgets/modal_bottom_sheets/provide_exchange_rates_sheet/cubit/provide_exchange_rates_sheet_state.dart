part of 'provide_exchange_rates_sheet_cubit.dart';

enum ProvideExchangeRatesSheetStatus { pageIsLoading, pageHasError, loadMoreEntries, loading, failure, waiting, close }

class ProvideExchangeRatesSheetState extends Equatable {
  final bool isShared;

  final Group fromGroup;

  final int currentOffset;
  final bool isFinished;
  final Entries invalidEntries;

  final Failure failure;
  final Failure pageFailure;

  final ProvideExchangeRatesSheetStatus status;

  const ProvideExchangeRatesSheetState({
    required this.isShared,
    required this.currentOffset,
    required this.isFinished,
    required this.invalidEntries,
    required this.fromGroup,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [isShared, currentOffset, isFinished, invalidEntries, fromGroup, failure, pageFailure, status];

  /// Initialize a new ```ProvideExchangeRatesSheetState``` object.
  factory ProvideExchangeRatesSheetState.initial() {
    return ProvideExchangeRatesSheetState(
      isShared: false,
      isFinished: false,
      currentOffset: 0,
      invalidEntries: Entries.initial(),
      fromGroup: Group.initial(),
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: ProvideExchangeRatesSheetStatus.pageIsLoading,
    );
  }

  // ############################################
  // # Copy With
  // ############################################

  ProvideExchangeRatesSheetState copyWith({
    bool? isShared,
    Group? fromGroup,
    int? currentOffset,
    bool? isFinished,
    Entries? invalidEntries,
    Failure? failure,
    Failure? pageFailure,
    ProvideExchangeRatesSheetStatus? status,
  }) {
    return ProvideExchangeRatesSheetState(
      isShared: isShared ?? this.isShared,
      fromGroup: fromGroup ?? this.fromGroup,
      currentOffset: currentOffset ?? this.currentOffset,
      isFinished: isFinished ?? this.isFinished,
      invalidEntries: invalidEntries ?? this.invalidEntries,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
