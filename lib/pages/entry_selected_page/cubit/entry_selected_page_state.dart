part of 'entry_selected_page_cubit.dart';

enum EntrySelectedPageStatus {
  loadingMoreContent,
  loadingMoreContentFailure,
  waiting,
}

class EntrySelectedPageState extends Equatable {
  final Group fromGroup;
  final int currentPage;
  final bool isShared;
  final bool isFinished;

  final EntrySelectedPageStatus status;

  const EntrySelectedPageState({
    required this.fromGroup,
    required this.currentPage,
    required this.isFinished,
    required this.isShared,
    required this.status,
  });

  @override
  List<Object> get props => [fromGroup, isFinished, currentPage, status];

  /// Initialize a new `EntrySelectedPageState` object.
  factory EntrySelectedPageState.initial({required int initialPage, required Group fromGroup, required bool isShared}) {
    return EntrySelectedPageState(
      fromGroup: fromGroup,
      currentPage: initialPage,
      isFinished: false,
      isShared: isShared,
      status: EntrySelectedPageStatus.waiting,
    );
  }

  // ############################################
  // Copy With
  // ############################################

  EntrySelectedPageState copyWith({
    Group? fromGroup,
    int? currentPage,
    bool? isFinished,
    bool? isShared,
    EntrySelectedPageStatus? status,
  }) {
    return EntrySelectedPageState(
      fromGroup: fromGroup ?? this.fromGroup,
      currentPage: currentPage ?? this.currentPage,
      isShared: isShared ?? this.isShared,
      isFinished: isFinished ?? this.isFinished,
      status: status ?? this.status,
    );
  }
}
