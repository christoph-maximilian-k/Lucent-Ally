part of 'create_participant_sheet_cubit.dart';

enum CreateParticipantSheetStatus {
  pageIsLoading,
  pageHasError,
  loading,
  waiting,
  failure,
  newMember,
  existingMember,
  close,
}

class CreateParticipantSheetState extends Equatable {
  final bool isEdit;
  final bool isShared;

  final String topLevelGroupId;

  final Members currentUserMembers;

  final Participant initialParticipant;
  final Participant participant;

  final Members initialParticipantMembers;
  final Members participantMembers;

  final Failure pageFailure;

  final Failure failure;
  final CreateParticipantSheetStatus status;

  const CreateParticipantSheetState({
    required this.isEdit,
    required this.isShared,
    required this.topLevelGroupId,
    required this.currentUserMembers,
    required this.initialParticipant,
    required this.participant,
    required this.initialParticipantMembers,
    required this.participantMembers,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [
        isEdit,
        isShared,
        topLevelGroupId,
        currentUserMembers,
        initialParticipant,
        participant,
        initialParticipantMembers,
        participantMembers,
        pageFailure,
        failure,
        status,
      ];

  /// Initialize a new ```CreateParticipantSheetState``` object.
  factory CreateParticipantSheetState.initial() {
    // Convenience variables.
    final Participant initialParticipant = Participant.initial();
    final Members initialMembers = Members.initial();

    return CreateParticipantSheetState(
      isEdit: false,
      isShared: false,
      topLevelGroupId: '',
      currentUserMembers: Members.initial(),
      initialParticipant: initialParticipant,
      participant: initialParticipant,
      initialParticipantMembers: initialMembers,
      participantMembers: initialMembers,
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: CreateParticipantSheetStatus.pageIsLoading,
    );
  }

  CreateParticipantSheetState copyWith({
    bool? isEdit,
    bool? isShared,
    String? topLevelGroupId,
    Members? currentUserMembers,
    Participant? initialParticipant,
    Participant? participant,
    Members? initialParticipantMembers,
    Members? participantMembers,
    Failure? pageFailure,
    Failure? failure,
    CreateParticipantSheetStatus? status,
  }) {
    return CreateParticipantSheetState(
      isEdit: isEdit ?? this.isEdit,
      isShared: isShared ?? this.isShared,
      topLevelGroupId: topLevelGroupId ?? this.topLevelGroupId,
      currentUserMembers: currentUserMembers ?? this.currentUserMembers,
      initialParticipant: initialParticipant ?? this.initialParticipant,
      participant: participant ?? this.participant,
      initialParticipantMembers: initialParticipantMembers ?? this.initialParticipantMembers,
      participantMembers: participantMembers ?? this.participantMembers,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
