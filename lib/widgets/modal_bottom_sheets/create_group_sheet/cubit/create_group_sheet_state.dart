part of 'create_group_sheet_cubit.dart';

enum CreateGroupSheetStatus { pageIsLoading, pageHasError, loading, waiting, failure, close }

class CreateGroupSheetState extends Equatable {
  final bool isEdit;
  final bool isShared;

  final bool localPasswordExists;
  final bool showIsProtectedSwitch;
  final bool showIsEncryptedSwitch;

  final bool canChangeCurrency;

  final Group initialGroup;
  final Group group;

  final ModelEntries currentUserModelEntries;
  final PickerItems currentUserModelEntriesAsPickerItems;

  final ModelEntries commonModelEntries;

  final Participants currentUserParticipants;
  final Participant participant;

  final PickerItems editPolicies;
  final PickerItems deletePolicies;

  final PickerItems subgroupAddPolicies;

  final PickerItems entryAddPolicies;
  final PickerItems entryEditPolicies;
  final PickerItems entryDeletePolicies;

  final Failure failure;
  final CreateGroupSheetStatus status;

  const CreateGroupSheetState({
    required this.isEdit,
    required this.isShared,
    required this.localPasswordExists,
    required this.showIsProtectedSwitch,
    required this.showIsEncryptedSwitch,
    required this.initialGroup,
    required this.canChangeCurrency,
    required this.group,
    required this.currentUserModelEntries,
    required this.currentUserModelEntriesAsPickerItems,
    required this.commonModelEntries,
    required this.currentUserParticipants,
    required this.participant,
    required this.editPolicies,
    required this.deletePolicies,
    required this.subgroupAddPolicies,
    required this.entryAddPolicies,
    required this.entryEditPolicies,
    required this.entryDeletePolicies,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [
        isEdit,
        isShared,
        localPasswordExists,
        showIsProtectedSwitch,
        showIsEncryptedSwitch,
        initialGroup,
        canChangeCurrency,
        group,
        currentUserModelEntries,
        currentUserModelEntriesAsPickerItems,
        commonModelEntries,
        currentUserParticipants,
        participant,
        editPolicies,
        deletePolicies,
        subgroupAddPolicies,
        entryAddPolicies,
        entryEditPolicies,
        entryDeletePolicies,
        failure,
        status,
      ];

  /// Initialize a new ```AddGroupSheetState``` object.
  factory CreateGroupSheetState.initial() {
    // Init group for compare reasons.
    final Group initialGroup = Group.initial();

    return CreateGroupSheetState(
      isEdit: false,
      isShared: false,
      localPasswordExists: false,
      showIsProtectedSwitch: false,
      showIsEncryptedSwitch: false,
      canChangeCurrency: false,
      initialGroup: initialGroup,
      group: initialGroup,
      currentUserModelEntries: ModelEntries.initial(),
      currentUserModelEntriesAsPickerItems: PickerItems.initial(),
      commonModelEntries: ModelEntries.initial(),
      currentUserParticipants: Participants.initial(),
      participant: Participant.initial(),
      editPolicies: PickerItems.initial(),
      deletePolicies: PickerItems.initial(),
      subgroupAddPolicies: PickerItems.initial(),
      entryAddPolicies: PickerItems.initial(),
      entryEditPolicies: PickerItems.initial(),
      entryDeletePolicies: PickerItems.initial(),
      failure: Failure.initial(),
      status: CreateGroupSheetStatus.pageIsLoading,
    );
  }

  /// This getter can be used to check the participant edit state.
  bool get getIsParticipantEdit {
    if (isEdit) {
      if (participant.participantName.isEmpty) return false;
      return true;
    }

    if (participant.participantName.isEmpty) return false;
    return true;
  }

  CreateGroupSheetState copyWith({
    bool? isEdit,
    bool? isShared,
    bool? localPasswordExists,
    bool? showIsProtectedSwitch,
    bool? showIsEncryptedSwitch,
    bool? canChangeCurrency,
    Group? initialGroup,
    Group? group,
    ModelEntries? currentUserModelEntries,
    PickerItems? currentUserModelEntriesAsPickerItems,
    ModelEntries? commonModelEntries,
    Participants? currentUserParticipants,
    Participant? participant,
    PickerItems? editPolicies,
    PickerItems? deletePolicies,
    PickerItems? subgroupAddPolicies,
    PickerItems? entryAddPolicies,
    PickerItems? entryEditPolicies,
    PickerItems? entryDeletePolicies,
    Failure? failure,
    CreateGroupSheetStatus? status,
  }) {
    return CreateGroupSheetState(
      isEdit: isEdit ?? this.isEdit,
      isShared: isShared ?? this.isShared,
      localPasswordExists: localPasswordExists ?? this.localPasswordExists,
      showIsProtectedSwitch: showIsProtectedSwitch ?? this.showIsProtectedSwitch,
      showIsEncryptedSwitch: showIsEncryptedSwitch ?? this.showIsEncryptedSwitch,
      canChangeCurrency: canChangeCurrency ?? this.canChangeCurrency,
      initialGroup: initialGroup ?? this.initialGroup,
      group: group ?? this.group,
      currentUserModelEntries: currentUserModelEntries ?? this.currentUserModelEntries,
      currentUserModelEntriesAsPickerItems: currentUserModelEntriesAsPickerItems ?? this.currentUserModelEntriesAsPickerItems,
      commonModelEntries: commonModelEntries ?? this.commonModelEntries,
      currentUserParticipants: currentUserParticipants ?? this.currentUserParticipants,
      participant: participant ?? this.participant,
      editPolicies: editPolicies ?? this.editPolicies,
      deletePolicies: deletePolicies ?? this.deletePolicies,
      subgroupAddPolicies: subgroupAddPolicies ?? this.subgroupAddPolicies,
      entryAddPolicies: entryAddPolicies ?? this.entryAddPolicies,
      entryEditPolicies: entryEditPolicies ?? this.entryEditPolicies,
      entryDeletePolicies: entryDeletePolicies ?? this.entryDeletePolicies,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
