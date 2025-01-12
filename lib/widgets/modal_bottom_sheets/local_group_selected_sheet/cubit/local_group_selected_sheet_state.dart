part of 'local_group_selected_sheet_cubit.dart';

enum LocalGroupSelectedSheetStatus {
  pageIsLoading,
  pageHasError,
  waiting,
  isFetchingEntries,
  loading,
  failure,
  close,
}

class LocalGroupSelectedSheetState extends Equatable {
  final String topLevelGroupId;
  final String loadingMessageGroupDelete;

  final Group group;
  final Groups subgroups;

  final ModelEntries commonModelEntries;

  /// This variable should be populated with all local model entries.
  final ModelEntries modelEntries;
  final ModelEntry? quickAddModelEntry;

  final Entries entries;
  final int entriesOffset;
  final int entriesLimit;

  /// Indicates if all entries have been loaded.
  /// * This works because entries that get loaded on load more content are older. Meaning that at one point the first entry will appear and that means there are no more entries.
  final bool isFinished;

  final bool moreContentIsLoading;

  final List<EntrySelectedSheetState> entrySelectedStates;

  final Failure pageFailure;

  final Failure failure;
  final LocalGroupSelectedSheetStatus status;

  const LocalGroupSelectedSheetState({
    required this.topLevelGroupId,
    required this.group,
    required this.subgroups,
    required this.loadingMessageGroupDelete,
    required this.commonModelEntries,
    required this.modelEntries,
    required this.quickAddModelEntry,
    required this.entriesOffset,
    required this.entriesLimit,
    required this.moreContentIsLoading,
    required this.entries,
    required this.entrySelectedStates,
    required this.isFinished,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [
        topLevelGroupId,
        group,
        subgroups,
        loadingMessageGroupDelete,
        commonModelEntries,
        modelEntries,
        quickAddModelEntry,
        entriesOffset,
        entriesLimit,
        moreContentIsLoading,
        entrySelectedStates,
        entries,
        isFinished,
        pageFailure,
        failure,
        status,
      ];

  /// Initialize a new [LocalGroupSelectedSheetState] object.
  factory LocalGroupSelectedSheetState.initial() {
    return LocalGroupSelectedSheetState(
      topLevelGroupId: '',
      group: Group.initial(),
      subgroups: Groups.initial(),
      commonModelEntries: ModelEntries.initial(),
      loadingMessageGroupDelete: '',
      modelEntries: ModelEntries.initial(),
      quickAddModelEntry: null,
      entriesOffset: 0,
      entriesLimit: 25,
      moreContentIsLoading: false,
      entrySelectedStates: const [],
      isFinished: false,
      entries: Entries.initial(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: LocalGroupSelectedSheetStatus.pageIsLoading,
    );
  }

  /// This getter can be used to determine if a group is empty or not.
  bool get getIsGroupEmpty {
    if (entries.items.isEmpty == true && subgroups.items.isEmpty == true) return true;

    return false;
  }

  LocalGroupSelectedSheetState copyWith({
    String? topLevelGroupId,
    String? loadingMessageGroupDelete,
    Group? group,
    Groups? subgroups,
    ModelEntries? commonModelEntries,
    ModelEntries? modelEntries,
    ModelEntry? quickAddModelEntry,
    Entries? entries,
    int? entriesOffset,
    int? entriesLimit,
    bool? isFinished,
    bool? moreContentIsLoading,
    List<EntrySelectedSheetState>? entrySelectedStates,
    Failure? pageFailure,
    Failure? failure,
    LocalGroupSelectedSheetStatus? status,
  }) {
    return LocalGroupSelectedSheetState(
      topLevelGroupId: topLevelGroupId ?? this.topLevelGroupId,
      loadingMessageGroupDelete: loadingMessageGroupDelete ?? this.loadingMessageGroupDelete,
      group: group ?? this.group,
      subgroups: subgroups ?? this.subgroups,
      commonModelEntries: commonModelEntries ?? this.commonModelEntries,
      modelEntries: modelEntries ?? this.modelEntries,
      quickAddModelEntry: quickAddModelEntry ?? this.quickAddModelEntry,
      entries: entries ?? this.entries,
      isFinished: isFinished ?? this.isFinished,
      entriesOffset: entriesOffset ?? this.entriesOffset,
      entriesLimit: entriesLimit ?? this.entriesLimit,
      moreContentIsLoading: moreContentIsLoading ?? this.moreContentIsLoading,
      entrySelectedStates: entrySelectedStates ?? this.entrySelectedStates,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
