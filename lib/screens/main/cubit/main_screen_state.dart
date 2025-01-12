part of 'main_screen_cubit.dart';

enum MainScreenStatus {
  pageIsLoading,
  pageHasError,
  loading,
  reloadRecentEntries,
  deepLink,
  failure,
  waiting,
}

class MainScreenState extends Equatable {
  final bool isShared;

  final Groups groups;
  final List<String> protectedGroupIds;

  final ModelEntries modelEntries;
  final Entries recentEntries;

  final int recentEntriesOffset;
  final int recentEntriesLimit;

  final bool moreContentIsLoading;
  final bool showCancleButton;

  /// This indicates if user has accessed all available recent entries.
  final bool isFinished;

  final Failure failure;
  final Failure pageFailure;

  final MainScreenStatus status;

  const MainScreenState({
    required this.isShared,
    required this.groups,
    required this.protectedGroupIds,
    required this.modelEntries,
    required this.recentEntriesOffset,
    required this.recentEntriesLimit,
    required this.moreContentIsLoading,
    required this.showCancleButton,
    required this.recentEntries,
    required this.failure,
    required this.isFinished,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object?> get props => [
        isShared,
        groups,
        protectedGroupIds,
        modelEntries,
        moreContentIsLoading,
        showCancleButton,
        recentEntriesOffset,
        recentEntriesLimit,
        recentEntries,
        failure,
        pageFailure,
        status,
      ];

  /// Initialize a new ```MainScreenState``` object.
  factory MainScreenState.initial() {
    return MainScreenState(
      isShared: false,
      groups: Groups.initial(),
      protectedGroupIds: const [],
      modelEntries: ModelEntries.initial(),
      recentEntriesOffset: 0,
      recentEntriesLimit: 25,
      isFinished: false,
      moreContentIsLoading: false,
      showCancleButton: false,
      recentEntries: Entries.initial(),
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: MainScreenStatus.pageIsLoading,
    );
  }

  MainScreenState copyWith({
    bool? isShared,
    Groups? groups,
    List<String>? protectedGroupIds,
    ModelEntries? modelEntries,
    int? recentEntriesOffset,
    int? recentEntriesLimit,
    bool? moreContentIsLoading,
    bool? isFinished,
    bool? showCancleButton,
    Entries? recentEntries,
    Failure? failure,
    Failure? pageFailure,
    MainScreenStatus? status,
    required String calledFrom,
  }) {
    // Output debug message.
    debugPrint('MainScreenState --> copyWith() --> called from: $calledFrom --> status: $status');

    return MainScreenState(
      isShared: isShared ?? this.isShared,
      groups: groups ?? this.groups,
      protectedGroupIds: protectedGroupIds ?? this.protectedGroupIds,
      modelEntries: modelEntries ?? this.modelEntries,
      isFinished: isFinished ?? this.isFinished,
      recentEntriesOffset: recentEntriesOffset ?? this.recentEntriesOffset,
      recentEntriesLimit: recentEntriesLimit ?? this.recentEntriesLimit,
      moreContentIsLoading: moreContentIsLoading ?? this.moreContentIsLoading,
      showCancleButton: showCancleButton ?? this.showCancleButton,
      recentEntries: recentEntries ?? this.recentEntries,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
