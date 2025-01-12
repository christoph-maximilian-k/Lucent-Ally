part of 'group_invite_sheet_cubit.dart';

enum GroupInviteSheetStatus {
  pageIsLoading,
  pageHasError,
  loading,
  validate,
  waiting,
  failure,
  closeWithData,
  closeWithoutData,
}

class GroupInviteSheetState extends Equatable {
  final bool pinRequired;
  final String providedPin;

  final Group group;

  final Failure pageFailure;

  final Failure failure;
  final GroupInviteSheetStatus status;

  const GroupInviteSheetState({
    required this.pinRequired,
    required this.providedPin,
    required this.group,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [pinRequired, providedPin, group, pageFailure, failure, status];

  /// initialize a new ```GroupSelectedSheetState``` object.
  factory GroupInviteSheetState.initial() {
    return GroupInviteSheetState(
      pinRequired: true,
      providedPin: '',
      group: Group.initial(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: GroupInviteSheetStatus.pageIsLoading,
    );
  }

  GroupInviteSheetState copyWith({
    bool? pinRequired,
    String? providedPin,
    Group? group,
    Failure? pageFailure,
    Failure? failure,
    GroupInviteSheetStatus? status,
  }) {
    return GroupInviteSheetState(
      pinRequired: pinRequired ?? this.pinRequired,
      providedPin: providedPin ?? this.providedPin,
      group: group ?? this.group,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
