part of 'menu_sheet_cubit.dart';

enum MenuSheetStatus {
  pageIsLoading,
  pageHasError,
  editModelEntry,
  deleteModelEntry,
  removeThirdline,
  removeSubtitle,
  createDefaultEntrySelf,
  createDefaultEntryEveryone,
  showDefaultChoice,
  waiting,
  loading,
  failure,
  close,
}

class MenuSheetState extends Equatable {
  final bool isShared;

  final bool usernameCanChange;
  final FileItem? avatar;

  final ModelEntries entryModels;
  final Failure modelEntriesFailure;

  final Groups localGroups;

  final ModelEntry? selectedModelEntry;

  final Failure failure;
  final MenuSheetStatus status;

  final Failure pageFailure;

  const MenuSheetState({
    required this.isShared,
    required this.usernameCanChange,
    required this.avatar,
    required this.entryModels,
    required this.modelEntriesFailure,
    required this.selectedModelEntry,
    required this.localGroups,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [
        isShared,
        usernameCanChange,
        avatar,
        entryModels,
        localGroups,
        pageFailure,
        modelEntriesFailure,
        selectedModelEntry,
        failure,
        status,
      ];

  /// Initialize a new [MenuSheetState] object.
  factory MenuSheetState.initial() {
    return MenuSheetState(
      isShared: false,
      usernameCanChange: false,
      avatar: null,
      entryModels: ModelEntries.initial(),
      modelEntriesFailure: Failure.initial(),
      localGroups: Groups.initial(),
      selectedModelEntry: null,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: MenuSheetStatus.pageIsLoading,
    );
  }

  MenuSheetState copyWith({
    bool? isShared,
    bool? usernameCanChange,
    FileItem? avatar,
    ModelEntries? entryModels,
    Failure? modelEntriesFailure,
    Groups? localGroups,
    ModelEntry? selectedModelEntry,
    Failure? failure,
    MenuSheetStatus? status,
    Failure? pageFailure,
  }) {
    return MenuSheetState(
      isShared: isShared ?? this.isShared,
      usernameCanChange: usernameCanChange ?? this.usernameCanChange,
      avatar: avatar ?? this.avatar,
      entryModels: entryModels ?? this.entryModels,
      modelEntriesFailure: modelEntriesFailure ?? this.modelEntriesFailure,
      localGroups: localGroups ?? this.localGroups,
      selectedModelEntry: selectedModelEntry ?? this.selectedModelEntry,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      pageFailure: pageFailure ?? this.pageFailure,
    );
  }
}
