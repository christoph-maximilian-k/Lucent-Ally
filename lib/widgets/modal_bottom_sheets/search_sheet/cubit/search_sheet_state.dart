part of 'search_sheet_cubit.dart';

enum SearchSheetStatus { pageIsLoading, pageHasError, initial, loading, waiting, failure }

class SearchSheetState extends Equatable {
  final bool isShared;

  final Entries matchingEntries;
  final String currentSearchCriteria;

  final Secrets? secrets;

  final Failure failure;
  final SearchSheetStatus status;

  const SearchSheetState({
    required this.isShared,
    required this.matchingEntries,
    required this.secrets,
    required this.currentSearchCriteria,
    required this.failure,
    required this.status,
  });

  /// Initialize a new [SearchSheetState] object.
  factory SearchSheetState.initial() {
    return SearchSheetState(
      isShared: false,
      matchingEntries: Entries.initial(),
      secrets:null,
      currentSearchCriteria: '',
      failure: Failure.initial(),
      status: SearchSheetStatus.pageIsLoading,
    );
  }

  @override
  List<Object?> get props => [isShared, matchingEntries, secrets,currentSearchCriteria, failure, status];

  SearchSheetState copyWith({
    bool? isShared,
    bool? isPickerMode,
    Entries? matchingEntries,
    Secrets? secrets,
    String? currentSearchCriteria,
    Failure? failure,
    SearchSheetStatus? status,
  }) {
    return SearchSheetState(
      isShared: isShared ?? this.isShared,
      matchingEntries: matchingEntries ?? this.matchingEntries,
      currentSearchCriteria: currentSearchCriteria ?? this.currentSearchCriteria,
      secrets: secrets ?? this.secrets,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
