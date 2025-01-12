import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// User with Settings and Labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/participants/participant.dart';
import '/data/models/members/member.dart';
import '/data/models/members/members.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/widgets/modal_bottom_sheets/create_group_sheet/cubit/create_group_sheet_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';

part 'create_participant_sheet_state.dart';

class CreateParticipantSheetCubit extends Cubit<CreateParticipantSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final CreateGroupSheetCubit _createGroupSheetCubit;

  CreateParticipantSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required CreateGroupSheetCubit createGroupSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _createGroupSheetCubit = createGroupSheetCubit,
        super(CreateParticipantSheetState.initial());

  // ################################
  // # Initialization
  // ################################

  /// Initialize local create.
  Future<void> initializeLocalCreate({required String topLevelGroupId}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access all current user Members.
      final Members currentUserMembers = await _localStorageCubit.getAllLocalMembers();

      // Create initial participant.
      final Participant initialParticipant = Participant.initial().copyWith(
        participantCreator: user.userId,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: false,
        isShared: false,
        topLevelGroupId: topLevelGroupId,
        currentUserMembers: currentUserMembers,
        initialParticipant: initialParticipant,
        participant: initialParticipant,
        status: CreateParticipantSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeLocalCreate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeLocalCreate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared create.
  Future<void> initializeSharedCreate({required String topLevelGroupId}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Create initial participant.
      final Participant initialParticipant = Participant.initial().copyWith(
        participantCreator: user.userId,
      );

      // Access all current shared user Members.
      final Members currentUserMembers = await _localStorageCubit.getSelfAllSharedMembers();

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: false,
        isShared: true,
        topLevelGroupId: topLevelGroupId,
        currentUserMembers: currentUserMembers,
        initialParticipant: initialParticipant,
        participant: initialParticipant,
        status: CreateParticipantSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeSharedCreate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeSharedCreate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize local edit.
  Future<void> initializeLocalEdit({required Participant initialParticipant, required String topLevelGroupId}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access all current user Members.
      final Members currentUserMembers = await _localStorageCubit.getAllLocalMembers();

      // Access members of this participant.
      final Members initialMembers = await _localStorageCubit.getLocalMembersOfParticipant(
        participantId: initialParticipant.participantId,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: true,
        isShared: false,
        topLevelGroupId: topLevelGroupId,
        currentUserMembers: currentUserMembers,
        initialParticipant: initialParticipant,
        participant: initialParticipant,
        initialParticipantMembers: initialMembers,
        participantMembers: initialMembers,
        status: CreateParticipantSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeLocalEdit() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeLocalEdit() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared edit.
  Future<void> initializeSharedEdit({required Participant initialParticipant, required String topLevelGroupId}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access all current shared user Members.
      final Members currentUserMembers = await _localStorageCubit.getSelfAllSharedMembers();

      // Access members of this participant.
      final Members? initialMembers = await _localStorageCubit.getSelfAllSharedMembersOfReference(
        referenceType: Participant.referenceType,
        referenceId: initialParticipant.participantId,
      );

      // Referenced Participant does not exist.
      if (initialMembers == null) throw Failure.participantNotFound();

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: true,
        isShared: true,
        topLevelGroupId: topLevelGroupId,
        currentUserMembers: currentUserMembers,
        initialParticipant: initialParticipant,
        participant: initialParticipant,
        initialParticipantMembers: initialMembers,
        participantMembers: initialMembers,
        status: CreateParticipantSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeSharedEdit() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> initializeSharedEdit() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateParticipantSheetStatus.pageHasError,
      ));
    }
  }

  // ################################
  // # State
  // ################################

  /// This method can be used to dismiss the failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == CreateParticipantSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateParticipantSheetStatus.waiting,
    ));
  }

  /// This method can be used to confirm close this sheet.
  Future<void> confirmCloseSheet({required BuildContext context}) async {
    // Check if a close event is allowed.
    if (state.status == CreateParticipantSheetStatus.loading || state.status == CreateParticipantSheetStatus.close) return;

    // Helper methods.
    final bool participantChanged = state.initialParticipant != state.participant;
    final bool membersChanged = state.initialParticipantMembers != state.participantMembers;

    // Check if user has unsaved data.
    final bool confirm = participantChanged || membersChanged
        ? await showModalBottomSheet(
              context: context,
              builder: (context) => ConfirmSheet(
                title: labels.createParticipantSheetCubitConfirmCloseMessage(isEdit: state.isEdit),
              ),
            ) ??
            false
        : true;

    // User cancled or cubit is closed.
    if (confirm == false || isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateParticipantSheetStatus.close,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateParticipantSheetStatus.close,
    ));
  }

  // ################################
  // # Participant
  // ################################

  /// This method gets triggered if user changes the participant name.
  void updateParticipantName({required String value, required TextEditingController controller}) {
    // Create updated participant.
    final Participant updatedParticipant = state.participant.copyWith(
      participantName: value.trim(),
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      participant: updatedParticipant,
    ));
  }

  /// This method gets triggerd if user wants to add a member.
  Future<void> showParticipantMenuChoices({required BuildContext context}) async {
    // Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        optionOne: labels.createParticipantSheetCubitRemoveParticipantFromGroup(),
        optionOneIcon: AppIcons.delete,
      ),
    );

    // * User cancelled.
    if (option == null) return;

    // * User wants to create a new member.
    if (option == 1) removeParticipantFromGroup();
  }

  /// This method can be used to remove this participant from this group.
  void removeParticipantFromGroup() {
    // Update dependent cubits.
    _createGroupSheetCubit.onRemoveParticipant();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateParticipantSheetStatus.close,
    ));
  }

  // ################################
  // # Members
  // ################################

  /// This method gets triggerd if user wants to add a member.
  Future<void> showAddMemberChoice({required BuildContext context, required FocusScopeNode node}) async {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    // Reset state.
    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateParticipantSheetStatus.waiting,
    ));

    // Unfocus textfields.
    node.unfocus();

    // Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        optionOne: labels.createParticipantSheetCubitCreateNewMember(),
        optionOneIcon: AppIcons.add,
        optionTwo: labels.createParticipantSheetCubitSelectExistingMember(),
        optionTwoIcon: AppIcons.add,
      ),
    );

    // * User cancelled.
    if (option == null) return;

    // * User wants to create a new member.
    if (option == 1) {
      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: CreateParticipantSheetStatus.newMember,
      ));

      return;
    }

    // * User wants to choose from existing members.
    if (option == 2) {
      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: CreateParticipantSheetStatus.existingMember,
      ));

      return;
    }
  }

  /// This method can be used to create a new member.
  Future<void> createNewMember({required BuildContext context}) async {
    try {
      // * Let user choose a name for this member.
      final String? memberName = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => TextFieldSheet(
          hint: labels.createParticipantSheetCubitMemberNameHint(),
        ),
      );

      // * User cancled, revert state.
      if (memberName == null || memberName.isEmpty) {
        // Only emit states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          status: CreateParticipantSheetStatus.waiting,
        ));

        return;
      }

      // Check if a member with this name is already in state.
      final bool stateMemberExists = state.participantMembers.nameExists(
        name: memberName,
      );

      // Let user know that this member name already exists.
      if (stateMemberExists) throw Failure.memberNameExists();

      // Check if a member with this name already exists.
      final bool nameExists = state.currentUserMembers.nameExists(name: memberName);

      // Let user know that this member name already exists.
      if (nameExists) throw Failure.memberNameExists();

      // * Create new member.
      final Member member = Member.initial().copyWith(
        memberName: memberName,
      );

      // Create updated participant members.
      final Members updatedMembers = state.participantMembers.addMember(
        member: member,
      );

      // Create updated current user members.
      final Members currentUserMembers = state.currentUserMembers.addMember(
        member: member,
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        currentUserMembers: currentUserMembers,
        participantMembers: updatedMembers,
        status: CreateParticipantSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> createNewMember() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateParticipantSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> createNewMember() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateParticipantSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to choose from existing members.
  Future<void> chooseFromExistingMembers({required BuildContext context}) async {
    try {
      // User has not created members yet.
      if (state.currentUserMembers.items.isEmpty) throw Failure.failureNoMembersCreated();

      // Access PickerItems.
      final PickerItems pickerItems = state.currentUserMembers.toPickerItems();

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          pickerItems: pickerItems,
        ),
      );

      // * User cancelled, revert state.
      if (pickedIndex == null) {
        // Only emit states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          failure: Failure.initial(),
          status: CreateParticipantSheetStatus.waiting,
        ));

        return;
      }

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickedIndex];

      // Access picked member.
      Member? member = state.currentUserMembers.getById(
        memberId: pickedItem.id,
      );

      // Member is unknown.
      member ??= Member.unknownMember(memberId: pickedItem.id);

      // * Make sure that members are unique.
      final bool memberExists = state.participantMembers.memberExists(
        member: member,
      );

      // Inform user.
      if (memberExists) throw Failure.failureMemberAlreadyPartOfParticipant();

      // Create updated members.
      final Members updatedMembers = state.participantMembers.addMember(
        member: member,
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        participantMembers: updatedMembers,
        status: CreateParticipantSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> chooseFromExistingMembers() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateParticipantSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> chooseFromExistingMembers() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateParticipantSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to remove a member from this participant.
  Future<void> removeMember({required BuildContext context, required Member member}) async {
    try {
      // It is not needed to check if member is referenced here because if a member gets removed from a
      // participant it can and will still be accessed in local storage because it still exists there.

      // * Show confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            // * This sheet returns either true or null.
            builder: (context) => ConfirmSheet(
              title: labels.createParticipantSheetConfirmRemoveMember(),
            ),
          ) ??
          false;

      // * User did not confirm.
      if (confirm == false) return;

      // Create updated members.
      final Members updatedMembers = state.participantMembers.removeMember(
        member: member,
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        participantMembers: updatedMembers,
      ));

      return;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> removeMember() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateParticipantSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> removeMember() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateParticipantSheetStatus.failure,
      ));
    }
  }

  // ################################
  // # Database
  // ################################

  /// This method can be used to trigger the participant and member create local process.
  Future<void> createLocal() async {
    try {
      // Make sure participant name is not empty.
      if (state.participant.participantName.trim().isEmpty) throw Failure.failureEmptyParticipantName();

      // Make sure members are assigned.
      if (state.participantMembers.items.isEmpty) throw Failure.failureEmptyParticipantMembers();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.pageIsLoading,
      ));

      // Create addedAt to ensure each participant to member ref has the same value.
      final DateTime addedAtInUtc = DateTime.now().toUtc();

      // Create the participant and members.
      await _localStorageCubit.state.database!.writeTxn(() async {
        final Participant participant = await _localStorageCubit.createLocalParticipant(
          participant: state.participant,
        );

        // Create/Update members and add references.
        for (final Member item in state.participantMembers.items) {
          // Check if this member already exists.
          Member? member = await _localStorageCubit.getLocalMemberById(
            memberId: item.memberId,
          );

          // Member needs to be created.
          member ??= await _localStorageCubit.createLocalMember(
            member: item,
          );

          // Always Create ParticipantToMember reference.
          await _localStorageCubit.createParticipantToMemberReference(
            participantId: participant.participantId,
            member: member,
            addedBy: user.userId,
            addedAtInUtc: addedAtInUtc,
          );
        }
      });

      // Update dependent cubits.
      _createGroupSheetCubit.onParticipantCreated(
        participant: state.participant,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> createLocal() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateParticipantSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> create() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateParticipantSheetStatus.failure,
      ));
    }
  }

  // This method can be used to trigger the participant and member create shared process.
  Future<void> createShared() async {
    try {
      // Make sure participant name is not empty.
      if (state.participant.participantName.trim().isEmpty) throw Failure.failureEmptyParticipantName();

      // Make sure members are assigned.
      if (state.participantMembers.items.isEmpty) throw Failure.failureEmptyParticipantMembers();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.pageIsLoading,
      ));

      // Create participant and associated members.
      await _localStorageCubit.createSharedParticipantAndMembers(
        participant: state.participant,
        members: state.participantMembers,
      );

      // Update dependent cubits.
      _createGroupSheetCubit.onParticipantCreated(
        participant: state.participant,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> createShared() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateParticipantSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> createShared() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateParticipantSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to trigger the participant and member edit local process.
  Future<void> editLocal() async {
    try {
      // Make sure participant name is not empty.
      if (state.participant.participantName.trim().isEmpty) throw Failure.failureEmptyParticipantName();

      // Make sure members are assigned.
      if (state.participantMembers.items.isEmpty) throw Failure.failureEmptyParticipantMembers();

      // Convenience variables.
      final bool participantEdited = state.initialParticipant != state.participant;
      final bool membersEdited = state.initialParticipantMembers != state.participantMembers;

      // Let user know that nothing was edited.
      if (participantEdited == false && membersEdited == false) throw Failure.nothingWasEdited();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.pageIsLoading,
      ));

      // Participant changed and should get updated.
      if (participantEdited) {
        // Update Participant.
        final Participant participant = await _localStorageCubit.state.database!.writeTxn(() async {
          final Participant participant = await _localStorageCubit.editLocalParticipant(
            updatedParticipant: state.participant,
          );

          return participant;
        });

        // Update dependent cubits.
        _createGroupSheetCubit.onParticipantEdited(
          editedParticipant: participant,
        );
      }

      // Create addedAt to ensure each participant to member ref has the same value.
      final DateTime addedAtInUtc = DateTime.now().toUtc();

      // Members changed and should get updated.
      if (membersEdited) {
        // Access removed members.
        final Members removedMembers = await state.initialParticipantMembers.getRemovedMembers(
          other: state.participantMembers,
        );

        // Access added members.
        final Members addedMembers = await state.initialParticipantMembers.getAddedMembers(
          other: state.participantMembers,
        );

        // Access edited members.
        final Members editedMembers = await state.initialParticipantMembers.getEditedMembers(
          other: state.participantMembers,
        );

        // * Check members.
        await _localStorageCubit.state.database!.writeTxn(() async {
          // Perform remove process.
          // * Do not delete the actual member here. Member only gets removed from this participant.
          for (final Member item in removedMembers.items) {
            // Delete participant to member reference.
            await _localStorageCubit.deleteParticipantToMemberReference(
              participant: state.participant,
              member: item,
            );
          }

          // Perform add process.
          for (final Member item in addedMembers.items) {
            // Check if this member already exists.
            Member? member = await _localStorageCubit.getLocalMemberById(
              memberId: item.memberId,
            );

            // Member needs to be created.
            member ??= await _localStorageCubit.createLocalMember(
              member: item,
            );

            // Add participant to member reference.
            await _localStorageCubit.createParticipantToMemberReference(
              participantId: state.participant.participantId,
              member: member,
              addedBy: user.userId,
              addedAtInUtc: addedAtInUtc,
            );
          }

          // Perform edit process.
          for (final Member item in editedMembers.items) {
            // Update member.
            await _localStorageCubit.editLocalMember(
              updatedMember: item,
            );
          }
        });
      }

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> editLocal() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateParticipantSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> editLocal() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateParticipantSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to trigger the participant and member edit shared process.
  Future<void> editShared() async {
    try {
      // Make sure participant name is not empty.
      if (state.participant.participantName.trim().isEmpty) throw Failure.failureEmptyParticipantName();

      // Make sure members are assigned.
      if (state.participantMembers.items.isEmpty) throw Failure.failureEmptyParticipantMembers();

      // Convenience variables.
      final bool participantEdited = state.initialParticipant != state.participant;
      final bool membersEdited = state.initialParticipantMembers != state.participantMembers;

      // Let user know that nothing was edited.
      if (participantEdited == false && membersEdited == false) throw Failure.nothingWasEdited();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.pageIsLoading,
      ));

      // Access removed members.
      final Members removedMembers = await state.initialParticipantMembers.getRemovedMembers(
        other: state.participantMembers,
      );

      // Access added members.
      final Members addedMembers = await state.initialParticipantMembers.getAddedMembers(
        other: state.participantMembers,
      );

      // Access edited members.
      final Members editedMembers = await state.initialParticipantMembers.getEditedMembers(
        other: state.participantMembers,
      );

      // Reflect changes online.
      await _localStorageCubit.editSharedParticipantAndMembers(
        participantId: state.participant.participantId,
        editedParticipant: participantEdited ? state.participant : null,
        removedMembers: removedMembers,
        addedMembers: addedMembers,
        editedMembers: editedMembers,
      );

      // Update dependent cubits.
      _createGroupSheetCubit.onParticipantEdited(
        editedParticipant: state.participant,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateParticipantSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> editShared() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateParticipantSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateParticipantSheetCubit --> editShared() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateParticipantSheetStatus.failure,
      ));
    }
  }
}
