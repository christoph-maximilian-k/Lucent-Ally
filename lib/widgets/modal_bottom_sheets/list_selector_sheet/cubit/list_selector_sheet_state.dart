part of 'list_selector_sheet_cubit.dart';

enum ListSelectorSheetStatus { pageIsLoading, pageHasError, loading, waiting, close }

class ListSelectorSheetState extends Equatable {
  final List items;
  final List matching;

  final bool isCurrencySelector;

  final String currentSearchCriteria;

  final Failure pageFailure;

  final Failure failure;
  final ListSelectorSheetStatus status;

  const ListSelectorSheetState({
    required this.items,
    required this.matching,
    required this.isCurrencySelector,
    required this.currentSearchCriteria,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [
        items,
        matching,
        isCurrencySelector,
        currentSearchCriteria,
        pageFailure,
        failure,
        status,
      ];

  /// Initialize a new [ListSelectorSheetState] object.
  factory ListSelectorSheetState.initial() {
    return ListSelectorSheetState(
      items: const [],
      matching: const [],
      isCurrencySelector: false,
      currentSearchCriteria: '',
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: ListSelectorSheetStatus.pageIsLoading,
    );
  }

  ListSelectorSheetState copyWith({
    List? items,
    List? matching,
    bool? isCurrencySelector,
    String? currentSearchCriteria,
    Failure? pageFailure,
    Failure? failure,
    ListSelectorSheetStatus? status,
  }) {
    return ListSelectorSheetState(
      items: items ?? this.items,
      matching: matching ?? this.matching,
      isCurrencySelector: isCurrencySelector ?? this.isCurrencySelector,
      currentSearchCriteria: currentSearchCriteria ?? this.currentSearchCriteria,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
