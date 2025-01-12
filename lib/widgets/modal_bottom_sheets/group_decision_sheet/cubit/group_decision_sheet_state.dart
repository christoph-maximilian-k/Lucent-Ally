part of 'group_decision_sheet_cubit.dart';

enum GroupDecisionSheetStatus {
  pageIsLoading,
  pageHasError,
  updateScrollWeel,
  showEntryDecisionSheet,
  waiting,
  failure,
  close,
}

class GroupDecisionSheetState extends Equatable {
  final bool isShared;

  final Groups groups;
  final Group selectedGroup;

  final Failure pageFailure;

  final Failure failure;
  final GroupDecisionSheetStatus status;

  const GroupDecisionSheetState({
    required this.isShared,
    required this.groups,
    required this.selectedGroup,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  /// initialize a new ```GroupDecisionSheetState``` object.
  factory GroupDecisionSheetState.initial() {
    return GroupDecisionSheetState(
      isShared: false,
      groups: Groups.initial(),
      selectedGroup: Group.initial(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: GroupDecisionSheetStatus.pageIsLoading,
    );
  }

  @override
  List<Object> get props => [isShared, groups, selectedGroup, pageFailure, failure, status];

  GroupDecisionSheetState copyWith({
    bool? isShared,
    Groups? groups,
    Group? selectedGroup,
    Failure? pageFailure,
    Failure? failure,
    GroupDecisionSheetStatus? status,
  }) {
    return GroupDecisionSheetState(
      isShared: isShared ?? this.isShared,
      groups: groups ?? this.groups,
      selectedGroup: selectedGroup ?? this.selectedGroup,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
