part of 'shared_group_selected_sheet_cubit.dart';

enum SharedGroupSelectedSheetStatus {
  pageIsLoading,
  pageHasError,
  waiting,
  loading,
  failure,
  isFetchingEntries,
  isRefreshing,
  close,
}

class SharedGroupSelectedSheetState extends Equatable {
  final String topLevelGroupOwner;

  final Group group;

  final Groups subgroups;

  final ModelEntry? quickAddModelEntry;

  final ModelEntries commonModelEntries;
  final ModelEntries modelEntries;

  final int entriesOffset;
  final int entriesLimit;
  final Entries entries;

  /// Indicates if all entries are loaded.
  /// * This works because entries that get loaded on load more content are older. Meaning that at one point the first entry will appear and that means there are no more entries.
  final bool isFinished;

  final Failure pageFailure;

  final Failure failure;
  final SharedGroupSelectedSheetStatus status;

  const SharedGroupSelectedSheetState({
    required this.topLevelGroupOwner,
    required this.group,
    required this.subgroups,
    required this.commonModelEntries,
    required this.quickAddModelEntry,
    required this.modelEntries,
    required this.entries,
    required this.entriesOffset,
    required this.entriesLimit,
    required this.isFinished,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [
        topLevelGroupOwner,
        group,
        subgroups,
        pageFailure,
        commonModelEntries,
        quickAddModelEntry,
        modelEntries,
        entries,
        entriesOffset,
        entriesLimit,
        isFinished,
        failure,
        status,
      ];

  /// Initialize a new ```SharedGroupSelectedSheetState``` object.
  factory SharedGroupSelectedSheetState.initial() {
    return SharedGroupSelectedSheetState(
      topLevelGroupOwner: '',
      group: Group.initial(),
      subgroups: Groups.initial(),
      quickAddModelEntry: null,
      commonModelEntries: ModelEntries.initial(),
      modelEntries: ModelEntries.initial(),
      isFinished: false,
      entriesOffset: 0,
      entriesLimit: 25,
      entries: Entries.initial(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: SharedGroupSelectedSheetStatus.pageIsLoading,
    );
  }

  /// This getter can be used to determine if a group is empty or not.
  bool get getIsGroupEmpty {
    if (entries.items.isEmpty == true && subgroups.items.isEmpty == true) return true;

    return false;
  }

  SharedGroupSelectedSheetState copyWith({
    String? topLevelGroupOwner,
    Group? group,
    Groups? subgroups,
    ModelEntry? quickAddModelEntry,
    ModelEntries? commonModelEntries,
    ModelEntries? modelEntries,
    int? entriesOffset,
    int? entriesLimit,
    bool? isFinished,
    Entries? entries,
    Failure? pageFailure,
    Failure? failure,
    SharedGroupSelectedSheetStatus? status,
  }) {
    return SharedGroupSelectedSheetState(
      topLevelGroupOwner: topLevelGroupOwner ?? this.topLevelGroupOwner,
      group: group ?? this.group,
      subgroups: subgroups ?? this.subgroups,
      quickAddModelEntry: quickAddModelEntry ?? this.quickAddModelEntry,
      commonModelEntries: commonModelEntries ?? this.commonModelEntries,
      modelEntries: modelEntries ?? this.modelEntries,
      isFinished: isFinished ?? this.isFinished,
      entriesOffset: entriesOffset ?? this.entriesOffset,
      entriesLimit: entriesLimit ?? this.entriesLimit,
      entries: entries ?? this.entries,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
