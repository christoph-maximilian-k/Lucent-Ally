part of 'entry_decision_sheet_cubit.dart';

enum EntryDecisionSheetStatus { pageIsLoading, updateScrollWeel, showCreateEntrySheet, waiting, failure }

class EntryDecisionSheetState extends Equatable {
  final bool isShared;
  final String topLevelGroupId;

  final Group fromGroup;

  final ModelEntries entryModels;
  final ModelEntry selectedEntryModel;

  final Failure failure;
  final EntryDecisionSheetStatus status;

  const EntryDecisionSheetState({
    required this.isShared,
    required this.topLevelGroupId,
    required this.fromGroup,
    required this.entryModels,
    required this.selectedEntryModel,
    required this.failure,
    required this.status,
  });

  /// Initialize a new [EntryDecisionSheetState] object.
  factory EntryDecisionSheetState.initial() {
    return EntryDecisionSheetState(
      isShared: false,
      topLevelGroupId: '',
      fromGroup: Group.initial(),
      entryModels: ModelEntries.initial(),
      selectedEntryModel: ModelEntry.initial(),
      failure: Failure.initial(),
      status: EntryDecisionSheetStatus.pageIsLoading,
    );
  }

  @override
  List<Object?> get props => [
        isShared,
        failure,
        topLevelGroupId,
        fromGroup,
        entryModels,
        selectedEntryModel,
        status,
      ];

  EntryDecisionSheetState copyWith({
    bool? isShared,
    String? topLevelGroupId,
    Group? fromGroup,
    ModelEntries? entryModels,
    ModelEntry? selectedEntryModel,
    Failure? failure,
    EntryDecisionSheetStatus? status,
  }) {
    return EntryDecisionSheetState(
      isShared: isShared ?? this.isShared,
      topLevelGroupId: topLevelGroupId ?? this.topLevelGroupId,
      fromGroup: fromGroup ?? this.fromGroup,
      entryModels: entryModels ?? this.entryModels,
      selectedEntryModel: selectedEntryModel ?? this.selectedEntryModel,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
