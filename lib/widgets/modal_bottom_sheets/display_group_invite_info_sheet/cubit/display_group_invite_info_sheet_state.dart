part of 'display_group_invite_info_sheet_cubit.dart';

enum DisplayGroupInviteInfoSheetStatus { pageIsLoading, pageHasError, loading, waiting, close, failure }

class DisplayGroupInviteInfoSheetState extends Equatable {
  final Group group;

  final String inviteLink;

  final Failure failure;
  final Failure pageFailure;

  final DisplayGroupInviteInfoSheetStatus status;

  const DisplayGroupInviteInfoSheetState({
    required this.group,
    required this.inviteLink,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [
        group,
        inviteLink,
        failure,
        pageFailure,
        status,
      ];

  /// Initialize a new ```DisplayGroupInviteInfoSheetState``` object.
  factory DisplayGroupInviteInfoSheetState.initial() {
    return DisplayGroupInviteInfoSheetState(
      group: Group.initial(),
      inviteLink: '',
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: DisplayGroupInviteInfoSheetStatus.pageIsLoading,
    );
  }

  DisplayGroupInviteInfoSheetState copyWith({
    Group? group,
    String? inviteLink,
    Failure? failure,
    Failure? pageFailure,
    DisplayGroupInviteInfoSheetStatus? status,
  }) {
    return DisplayGroupInviteInfoSheetState(
      group: group ?? this.group,
      inviteLink: inviteLink ?? this.inviteLink,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
