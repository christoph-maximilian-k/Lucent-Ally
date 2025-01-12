import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// User with Settings and Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';
import '/config/app_durations.dart';
import '/config/country_specification.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/list_selector_sheet/cubit/list_selector_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/group_decision_sheet/cubit/group_decision_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/create_participant_sheet/cubit/create_participant_sheet_cubit.dart';

// Screens.
import '/screens/main/cubit/main_screen_cubit.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/participants/participant.dart';
import '/data/models/participants/participants.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/entries/entries.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/invite_specs/invite_specs.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/list_selector_sheet/list_selector_sheet.dart';
import '/widgets/modal_bottom_sheets/create_participant_sheet/create_participant_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/date_selector/date_selector.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';

part 'create_group_sheet_state.dart';

class CreateGroupSheetCubit extends Cubit<CreateGroupSheetState> with HelperFunctions {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final GroupDecisionSheetCubit? _groupDecisionSheetCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;

  CreateGroupSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    GroupDecisionSheetCubit? groupDecisionSheetCubit,
    LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        _groupDecisionSheetCubit = groupDecisionSheetCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        super(CreateGroupSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize local create.
  Future<void> initializeLocalCreate({required String groupType, required String rootGroupReference, required String parentGroupReference}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Initialize group.
      Group initialGroup = Group.initial();

      // Check if user set a app wide default currency. If that is not the case set the default currency code based on system settings.
      // * In case no meaningful assumption can be made, "USD" is used as a default.
      final String defaultCurrencyCode = user.settings.defaultCurrency.isNotEmpty ? user.settings.defaultCurrency : await _localStorageCubit.getAssumedDefaultCurrency();

      // Update initial group with specifications.
      initialGroup = initialGroup.copyWith(
        groupType: groupType,
        groupCreator: user.userId,
        // * This needs to be set even if this group is the root because it will get passed on to potential subgroups from here.
        rootGroupReference: rootGroupReference.isEmpty ? initialGroup.groupId : rootGroupReference,
        parentGroupReference: parentGroupReference,
        defaultCurrencyCode: defaultCurrencyCode,
      );

      // Access user Participants.
      final Participants currentUserParticipants = await _localStorageCubit.getLocalParticipants();

      // Access all user ModelEntries.
      final ModelEntries currentUserModelEntries = await _localStorageCubit.getAllLocalModelEntries(
        shouldAccessPrefs: true,
      );

      // Create PickerItems.
      final PickerItems modelEntriesPickerItems = currentUserModelEntries.toPickerItems();

      // * Only show the is protected switch if this is a top level group.
      final bool showIsProtectedSwitch = groupType == Group.groupTypeLocal;

      // * Show is encrypted switch because in a create group is empty.
      final bool showIsEncryptedSwitch = true;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: false,
        isShared: false,
        canChangeCurrency: true,
        localPasswordExists: user.localGroupsPasswordSet,
        showIsProtectedSwitch: showIsProtectedSwitch,
        showIsEncryptedSwitch: showIsEncryptedSwitch,
        initialGroup: initialGroup,
        group: initialGroup,
        currentUserModelEntries: currentUserModelEntries,
        currentUserModelEntriesAsPickerItems: modelEntriesPickerItems,
        currentUserParticipants: currentUserParticipants,
        status: CreateGroupSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeLocalCreate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeLocalCreate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize local edit.
  Future<void> initializeLocalEdit({required Group initialGroup}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Check if this group has entries present.
      // * Needs to be outside of ISAR transaction.
      final int total = await _localStorageCubit.getNumberOfLocalEntriesInLocalGroup(groupId: initialGroup.groupId);

      // * Only show the is protected switch if this is a top level group.
      final bool showIsProtectedSwitch = initialGroup.groupType == Group.groupTypeLocal;

      // * Only show is encrypted switch if group is empty because otherwise existing entries would have to be rewritten with
      // * encryption and that might not be feasable for large groups.
      final bool showIsEncryptedSwitch = total == 0;

      // Access all user ModelEntries.
      final ModelEntries currentUserModelEntries = await _localStorageCubit.getAllLocalModelEntries(
        shouldAccessPrefs: true,
      );

      // Create PickerItems.
      final PickerItems modelEntriesPickerItems = currentUserModelEntries.toPickerItems();

      // Access participant.
      final Participant? participant = await _localStorageCubit.getLocalParticipantById(
        participantId: initialGroup.participantReference,
      );

      // Access ModelEntriesRestrictions.
      // * Only self model entries are available.
      final ModelEntries commonModelEntries = await _mainScreenCubit.state.modelEntries.getReferencedModelEntries(
        references: initialGroup.commonModelEntries,
        includeDeleted: true,
      );

      // Access user Participants.
      final Participants currentUserParticipants = await _localStorageCubit.getLocalParticipants();

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: true,
        isShared: false,
        canChangeCurrency: true,
        localPasswordExists: user.localGroupsPasswordSet,
        showIsProtectedSwitch: showIsProtectedSwitch,
        showIsEncryptedSwitch: showIsEncryptedSwitch,
        initialGroup: initialGroup,
        group: initialGroup,
        currentUserModelEntries: currentUserModelEntries,
        currentUserModelEntriesAsPickerItems: modelEntriesPickerItems,
        commonModelEntries: commonModelEntries,
        currentUserParticipants: currentUserParticipants,
        participant: participant,
        status: CreateGroupSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeLocalEdit() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeLocalEdit() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared create.
  Future<void> initializeSharedCreate({required String groupType, required String rootGroupCreator, required String rootGroupReference, required String parentGroupReference}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Check if user set a app wide default currency. If that is not teh case set the default currency code based on system settings.
      // ! It is vital that initially the group default currency is set to empty if no app wide default was set.
      // ! The reason for this is that the default currency code in shared groups cannot be changed once set so it is
      // ! good user experience if users can choose what exchange rate to use themselves.
      final String defaultCurrencyCode = user.settings.defaultCurrency.isNotEmpty ? user.settings.defaultCurrency : '';

      // Is this user the root group creator.
      final bool userIsRootGroupCreator = rootGroupCreator == user.userId;

      // Initialize group.
      Group initialGroup = Group.initial();

      // Update initial group with specifications.
      initialGroup = initialGroup.copyWith(
        groupType: groupType,
        groupCreator: user.userId,
        rootGroupReference: rootGroupReference,
        parentGroupReference: parentGroupReference,
        defaultCurrencyCode: defaultCurrencyCode,
      );

      // Access user Participants.
      final Participants currentUserParticipants = await _localStorageCubit.getSelfSharedParticipants();

      // Access all user ModelEntries.
      final ModelEntries currentUserModelEntries = await _localStorageCubit.selfGetAllSharedModelEntries();

      // Create PickerItems.
      final PickerItems modelEntriesPickerItems = currentUserModelEntries.toPickerItems();

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: false,
        isShared: true,
        canChangeCurrency: true,
        localPasswordExists: user.localGroupsPasswordSet,
        showIsProtectedSwitch: false, // * Always hide because this is a SHARED create.
        showIsEncryptedSwitch: false, // * Always hide because this is a SHARED create.
        initialGroup: initialGroup,
        group: initialGroup,
        currentUserModelEntries: currentUserModelEntries,
        currentUserModelEntriesAsPickerItems: modelEntriesPickerItems,
        currentUserParticipants: currentUserParticipants,
        editPolicies: Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        deletePolicies: Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        subgroupAddPolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        entryAddPolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        entryEditPolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator),
        entryDeletePolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator),
        status: CreateGroupSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeSharedCreate() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeSharedCreate() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared edit.
  Future<void> initializeSharedEdit({required Group initialGroup, required String rootGroupCreator}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // User is root group creator.
      final bool userIsRootGroupCreator = rootGroupCreator == user.userId;

      // Access participant.
      final Participant? participant = await _localStorageCubit.getSharedParticipantById(
        participantId: initialGroup.participantReference,
        referenceType: Group.referenceTypeGroup,
        referenceId: initialGroup.rootGroupReference,
      );

      // Access all user ModelEntries.
      final ModelEntries currentUserModelEntries = await _localStorageCubit.selfGetAllSharedModelEntries();

      // Create PickerItems.
      final PickerItems modelEntriesPickerItems = currentUserModelEntries.toPickerItems();

      // Access CommonModelEntries.
      // * Only self model entries are available.
      final ModelEntries commonModelEntries = await _mainScreenCubit.state.modelEntries.getReferencedModelEntries(
        references: initialGroup.commonModelEntries,
        includeDeleted: true,
      );

      // Access user Participants.
      final Participants currentUserParticipants = await _localStorageCubit.getSelfSharedParticipants();

      // Check if this group is currently empty.
      final Entries entries = await _localStorageCubit.getSharedEntriesOfSharedGroup(
        rootGroupReference: initialGroup.rootGroupReference,
        referenceType: initialGroup.getReferenceType,
        referenceId: initialGroup.groupId,
        offset: 0,
        limit: 1,
      );

      // If group is empty, user can change currency.
      // * If default currency is empty user can change default currency because no fields that depend on it have been set yet.
      final bool canChangeCurrency = initialGroup.defaultCurrencyCode.isEmpty || entries.items.isEmpty;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: true,
        isShared: true,
        canChangeCurrency: canChangeCurrency,
        localPasswordExists: user.localGroupsPasswordSet,
        showIsProtectedSwitch: false, // * Always show because this is a SHARED edit.
        showIsEncryptedSwitch: false, // * Always hide because this is a SHARED edit.
        initialGroup: initialGroup,
        group: initialGroup,
        currentUserModelEntries: currentUserModelEntries,
        currentUserModelEntriesAsPickerItems: modelEntriesPickerItems,
        commonModelEntries: commonModelEntries,
        currentUserParticipants: currentUserParticipants,
        participant: participant,
        editPolicies: Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        deletePolicies: Group.permissionsAsPickerItems(includeNone: false, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        subgroupAddPolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        entryAddPolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: false, userIsRootGroupCreator: userIsRootGroupCreator),
        entryEditPolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator),
        entryDeletePolicies: Group.permissionsAsPickerItems(includeNone: true, includeEntryCreator: true, userIsRootGroupCreator: userIsRootGroupCreator),
        status: CreateGroupSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeSharedEdit() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> initializeSharedEdit() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method can be used to dismiss the failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == CreateGroupSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateGroupSheetStatus.waiting,
    ));
  }

  /// This method can be used to confirm close this sheet.
  Future<void> confirmCloseSheet({required BuildContext context}) async {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == CreateGroupSheetStatus.loading) return;

    // Check if user has unsaved data.
    final bool confirm = state.initialGroup != state.group
        ? await showModalBottomSheet(
              context: context,
              builder: (context) => ConfirmSheet(
                title: labels.addGroupSheetCubitConfirmCloseMessage(isEdit: state.isEdit),
              ),
            ) ??
            false
        : true;

    // User cancled or cubit is closed.
    if (confirm == false || isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateGroupSheetStatus.close,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateGroupSheetStatus.close,
    ));
  }

  // ############################################
  // # Participant
  // ############################################

  /// This method can be used to let user choose between creating a new or using an existing participant.
  Future<void> showParticipantChoices({required BuildContext context}) async {
    // Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        optionOne: labels.basicLabelsCreateNew(),
        optionOneIcon: AppIcons.add,
        optionTwo: labels.basicLabelsChooseExisting(),
        optionTwoIcon: AppIcons.add,
      ),
    );

    // * User cancelled.
    if (option == null) return;

    // Make sure used context is still mounted. Output debug message.
    if (!context.mounted) return contextNotMountedHelper(parent: 'CreateGroupSheetCubit', sourceMethod: 'showParticipantChoices()');

    // * User wants to create a new participant.
    if (option == 1) createNewParticipant(context: context);

    // * User wants to choose from existing participants.
    if (option == 2) await chooseFromExistingParticipants(context: context);
  }

  /// This method can be used to create a new participant.
  void createNewParticipant({required BuildContext context}) {
    // Initialize create shared participant.
    if (state.isShared) {
      // Show CreateParticipantSheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateParticipantSheetCubit>(
          create: (context) => CreateParticipantSheetCubit(
            localStorageCubit: _localStorageCubit,
            createGroupSheetCubit: this,
          )..initializeSharedCreate(
              topLevelGroupId: state.group.rootGroupReference,
            ),
          child: const CreateParticipantSheet(),
        ),
      );
    }

    // Initialize create local participant.
    if (state.isShared == false) {
      // Show CreateParticipantSheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateParticipantSheetCubit>(
          create: (context) => CreateParticipantSheetCubit(
            localStorageCubit: _localStorageCubit,
            createGroupSheetCubit: this,
          )..initializeLocalCreate(topLevelGroupId: state.group.rootGroupReference),
          child: const CreateParticipantSheet(),
        ),
      );
    }
  }

  /// This method can be used to let user choose from existing participants.
  Future<void> chooseFromExistingParticipants({required BuildContext context}) async {
    try {
      // User has not created participants yet.
      if (state.currentUserParticipants.items.isEmpty) throw Failure.noParticipantsCreated();

      // Access PickerItems.
      final PickerItems pickerItems = state.currentUserParticipants.toPickerItems();

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          pickerItems: pickerItems,
        ),
      );

      // * User cancelled, revert state.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickedIndex];

      // Access picked participant.
      final Participant? participant = await state.currentUserParticipants.byId(
        participantId: pickedItem.id,
      );

      // Participant not found, should never happen.
      if (participant == null) throw Failure.genericError();

      // Update group with participant reference.
      final Group updatedGroup = state.group.copyWith(
        participantReference: participant.participantId,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
        participant: participant,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> chooseFromExistingParticipants() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> chooseFromExistingParticipants() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to edit a participant.
  void editParticipant({required BuildContext context}) {
    // Initialize edit shared participant.
    if (state.isShared) {
      // Show CreateParticipantSheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateParticipantSheetCubit>(
          create: (context) => CreateParticipantSheetCubit(
            localStorageCubit: _localStorageCubit,
            createGroupSheetCubit: this,
          )..initializeSharedEdit(
              initialParticipant: state.participant,
              topLevelGroupId: state.group.rootGroupReference,
            ),
          child: const CreateParticipantSheet(),
        ),
      );
    }

    // Initialize edit local participant.
    if (state.isShared == false) {
      // Show CreateParticipantSheet.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateParticipantSheetCubit>(
          create: (context) => CreateParticipantSheetCubit(
            localStorageCubit: _localStorageCubit,
            createGroupSheetCubit: this,
          )..initializeLocalEdit(
              initialParticipant: state.participant,
              topLevelGroupId: state.group.rootGroupReference,
            ),
          child: const CreateParticipantSheet(),
        ),
      );
    }
  }

  // ############################################
  // Update cascade Participant
  // ############################################

  /// This method can be used to let state know that a participant got created.
  void onParticipantCreated({required Participant participant}) {
    // Update group with participant reference.
    final Group updatedGroup = state.group.copyWith(
      participantReference: participant.participantId,
    );

    // Update current user participants.
    final Participants updatedParticipants = state.currentUserParticipants.add(
      participant: participant,
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
      participant: participant,
      currentUserParticipants: updatedParticipants,
    ));
  }

  /// This method can be used to let state know that a participant got edied.
  void onParticipantEdited({required Participant editedParticipant}) {
    // Update current user participants.
    // * This object has to exist in state if it is an edit.
    final Participants updatedParticipants = state.currentUserParticipants.update(
      updatedParticipant: editedParticipant,
    )!;

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      participant: editedParticipant,
      currentUserParticipants: updatedParticipants,
    ));
  }

  /// This method gets triggered if user wants to remove this participant from this group.
  void onRemoveParticipant() {
    // Remove participant reverence.
    final Group updatedGroup = state.group.copyWith(
      participantReference: '',
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
      participant: Participant.initial(),
    ));
  }

  // ############################################
  // # Group
  // ############################################

  /// This method gets triggered if user changes the group name.
  void updateGroupName({required String value, required TextEditingController controller}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      groupName: value.trim(),
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method gets triggered if user changes the group description.
  void updateGroupDescription({required String value, required TextEditingController controller}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      groupDescription: value.trim(),
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method gets triggered if user changes the group type property.
  void groupTypeChanged({required String groupType}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      groupType: groupType,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method can be used to assign a default currency for this group.
  Future<void> onSelectCurrency({required BuildContext context}) async {
    try {
      // Ensure that user can change the currency.
      if (state.canChangeCurrency == false) throw Failure.cannotChangeDefaultCurrencyOfSharedGroup();

      // Show available countries.
      final CountrySpecification? countrySpecification = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => BlocProvider<ListSelectorSheetCubit>(
          create: (context) => ListSelectorSheetCubit()
            ..initialize(
              isCurrencySelector: true,
            ),
          child: const ListSelectorSheet(),
        ),
      );

      // User cancled.
      if (countrySpecification == null) return;

      // Create updated group.
      final Group updatedGroup = state.group.copyWith(
        defaultCurrencyCode: countrySpecification.currencyCode,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
        failure: Failure.initial(),
        status: CreateGroupSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateLocalGroupSheetCubit --> onSelectCurrency() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateLocalGroupSheetCubit --> onSelectCurrency() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user changes the isLocked value of a group.
  void isLockedChanged() {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      isLocked: !state.group.isLocked,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method gets triggered if user changes the isProtected value of a group.
  void isProtectedChanged() {
    try {
      // Make sure user has set a password.
      if (state.localPasswordExists == false) throw Failure.appPasswordrequired();

      // Create updated group.
      final Group updatedGroup = state.group.copyWith(
        isProtected: !state.group.isProtected,
        isEncrypted: false,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> isProtectedChanged() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> isProtectedChanged() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user changes the isEncrypted value of a group.
  void isEncryptedChanged() {
    try {
      // Make sure user has set a password.
      if (state.localPasswordExists == false) throw Failure.appPasswordrequired();

      // Create updated group.
      final Group updatedGroup = state.group.copyWith(
        isProtected: true,
        isEncrypted: !state.group.isEncrypted,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> isEncryptedChanged() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> isEncryptedChanged() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to add a model entry to restrictions.
  Future<void> addCommonModelEntries({required BuildContext context}) async {
    try {
      // Make sure current user has model entries available.
      final bool modelEntriesExist = state.currentUserModelEntries.items.isNotEmpty;

      // No model entries available.
      if (modelEntriesExist == false) throw Failure.noModelEntryCreatedYet();

      // Show picker sheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          title: labels.basicLabelsModelEntries(),
          pickerItems: state.currentUserModelEntriesAsPickerItems,
          initialItem: 0,
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = state.currentUserModelEntriesAsPickerItems.items[pickedIndex];

      // Make sure that this item is not already in restrictions.
      final bool alreadyExists = state.group.commonModelEntries.contains(pickedItem.id);

      // Do nothing.
      if (alreadyExists) return;

      // Access picked entry model.
      final ModelEntry modelEntry = state.currentUserModelEntries.getById(
        id: pickedItem.id,
      )!;

      // Create updated modelEntriesRestiction.
      final List<String> updated = [...state.group.commonModelEntries, modelEntry.modelEntryId];

      // Create updated group.
      final Group updatedGroup = state.group.copyWith(
        commonModelEntries: updated,
        // * In local groups ensure that if user sets a common model entry, group is restricted to them.
        // * In shared mode users have the choice themselves but in local a choice does not make sense.
        isRestrictedToCommon: state.isShared ? null : true,
      );

      // Create updated state modelEntriesRestriction.
      final ModelEntries updatedCommon = state.commonModelEntries.add(
        modelEntry: modelEntry,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        group: updatedGroup,
        commonModelEntries: updatedCommon,
        failure: Failure.initial(),
        status: CreateGroupSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> addCommonModelEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> addCommonModelEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to remove a model entry from restrictions.
  Future<void> removeFromCommonModelEntries({required BuildContext context, required ModelEntry modelEntry}) async {
    try {
      // * Show confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.createGroupSheetRemoveModelEntry(),
            ),
          ) ??
          false;

      // * User did not confirm.
      if (confirm == false) return;

      // Create helper.
      List<String> commonModelEntries = [];

      // Add remaining ids.
      for (final String element in state.group.commonModelEntries) {
        if (element != modelEntry.modelEntryId) commonModelEntries.add(element);
      }

      // Ensure that if the last model entry is removed, is restricted is set to false.
      final bool resetIsRestricted = commonModelEntries.isEmpty;

      // Create updated group.
      final Group updatedGroup = state.group.copyWith(
        commonModelEntries: commonModelEntries,
        isRestrictedToCommon: resetIsRestricted ? false : state.group.isRestrictedToCommon,
      );

      // Create updated modelEntries.
      final ModelEntries updatedModelEntries = state.commonModelEntries.remove(
        modelEntryId: modelEntry.modelEntryId,
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
        commonModelEntries: updatedModelEntries,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> removeFromCommonModelEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> removeFromCommonModelEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if user changes the is restricted to common value.
  void onIsRestrictedToCommonChanged() {
    try {
      // Make sure that this is only used in shared mode.
      // * This is just a precaution because switch is not rendered in local mode.
      if (state.isShared == false) return;

      // User needs to select common entries first.
      if (state.commonModelEntries.items.isEmpty) throw Failure.noCommonModelEntriesSelected();

      // Create updated group.
      final Group updatedGroup = state.group.copyWith(
        isRestrictedToCommon: !state.group.isRestrictedToCommon,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> onIsRestrictedToCommonChanged() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> onIsRestrictedToCommonChanged() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // Shared Group
  // ############################################

  /// This method will be triggerd if user changes the group edit permission.
  void groupEditPermissionChanged({required String policy}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      editPolicy: policy,
    );

    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method will be triggerd if user changes the group delete permission.
  void groupDeletePermissionChanged({required String policy}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      deletePolicy: policy,
    );

    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method will be triggerd if user changes the subgroup add permission.
  void subgroupAddPermissionChanged({required String policy}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      subgroupAddPolicy: policy,
    );

    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method will be triggerd if user changes the entry add permission.
  void entryAddPermissionChanged({required String policy}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      entryAddPolicy: policy,
    );

    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method will be triggerd if user changes the entry edit permission.
  void entryEditPermissionChanged({required String policy}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      entryEditPolicy: policy,
    );

    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method will be triggerd if user changes the entry delete permission.
  void entryDeletePermissionChanged({required String policy}) {
    // Create updated group.
    final Group updatedGroup = state.group.copyWith(
      entryDeletePolicy: policy,
    );

    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method will be triggerd if user types in the access pin text field.
  void accessPinChanged({required String value, required TextEditingController controller}) {
    // If user wants to clear data.
    if (value.isEmpty) controller.clear();

    // * Create updated group data.
    final Group updatedGroup = state.group.copyWith(
      accessPin: value,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
      failure: Failure.initial(),
      status: CreateGroupSheetStatus.waiting,
    ));
  }

  /// This method can be used to give the invite link a expiration date.
  Future<void> setExpirationDate({required BuildContext context}) async {
    try {
      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: state.group.createdAtInUtc.toLocal(),
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated specs.
      final InviteSpecs updated = state.group.inviteSpecs.copyWith(
        expirationDateInUtc: chosenLocalDate.toUtc(),
      );

      // Create updated group object.
      final Group updatedGroup = state.group.copyWith(
        inviteSpecs: updated,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateGroupSheetCubit --> setExpirationDate() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateGroupSheetCubit --> setExpirationDate() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to remove a expiration date from an invite link.
  Future<void> removeExpirationDate() async {
    // Create invite specs.
    final InviteSpecs edited = InviteSpecs.initial().copyWith(
      // * Keep usage limit.
      usageLimit: state.group.inviteSpecs.usageLimit,
    );

    // Create updated group object.
    final Group updatedGroup = state.group.copyWith(
      inviteSpecs: edited,
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  /// This method can be used to give the invite link usage limitations.
  Future<void> setUsageLimitation({required BuildContext context}) async {
    try {
      // * Let user authenticate.
      final String? usage = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => TextFieldSheet(
          title: labels.basicLabelsUsageLimits(),
          autocorrect: false,
          canObscure: false,
        ),
      );

      // * User cancled.
      if (usage == null || usage.isEmpty) return;

      // Check value.
      final bool isValidNumber = NumberData.numberValidator(input: usage);

      // Let user know that number is invalid.
      if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: '');

      // Parse value to int.
      final int limit = int.parse(usage);

      // Set some limit to size.
      if (limit > 100000000) throw Failure.genericError();

      // Update invite specs.
      final InviteSpecs edited = state.group.inviteSpecs.copyWith(
        usageLimit: limit,
      );

      // Create updated group object.
      final Group updatedGroup = state.group.copyWith(
        inviteSpecs: edited,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        group: updatedGroup,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateGroupSheetCubit --> setUsageLimitation() --> Failure: ${failure.toString()}');
      debugPrint(failure.toString());

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateGroupSheetCubit --> setUsageLimitation() --> Exception: ${exception.toString()}');
      debugPrint(exception.toString());

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to remove a expiration date from an invite link.
  Future<void> removeUsageLimits() async {
    // Create invite specs.
    final InviteSpecs edited = InviteSpecs.initial().copyWith(
      // * Keep expiration date.
      expirationDateInUtc: state.group.inviteSpecs.expirationDateInUtc,
    );

    // Create updated group object.
    final Group updatedGroup = state.group.copyWith(
      inviteSpecs: edited,
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      group: updatedGroup,
    ));
  }

  // ############################################
  // Database Local
  // ############################################

  /// This method gets triggered if user wants to create a local new group.
  Future<void> createLocalGroup() async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateGroupSheetStatus.loading,
      ));

      // * Always make sure a root group is present. This is a requirement for all groups, regardless if
      // * the group is local, shared, root or sub. It is acceptable to have twice the same id
      // * in a root group.
      if (state.group.rootGroupReference.isEmpty) throw Failure.rootGroupRequired();

      // Make sure group data is provided.
      if (state.initialGroup == state.group) throw Failure.noGroupData();

      // Make sure a group name was provided.
      if (state.group.groupName.isEmpty) throw Failure.noGroupName();

      // Check if this group name already exists.
      final Group? group = await _localStorageCubit.getLocalGroupByName(
        groupName: state.group.groupName,
        shouldAccessPrefs: false,
      );

      // Failure, group already exists.
      if (group != null) throw Failure.groupAlreadyExists();

      // Create group.
      final Group createdGroup = await _localStorageCubit.state.database!.writeTxn(() async {
        return await _localStorageCubit.createLocalGroup(
          group: state.group,
        );
      });

      // * A subgroup was created, inform cubits.
      if (createdGroup.getIsLocalSubgroupType) {
        await _localGroupSelectedSheetCubit!.subgroupCreated(subgroup: createdGroup);
      }

      // * A group was created during group decision sheet.
      // * This is always a top level group.
      if (_groupDecisionSheetCubit != null) {
        await _groupDecisionSheetCubit.onGroupCreated(group: createdGroup);
      }

      // * A top level group was created, alert main screen.
      if (createdGroup.getIsLocalGroupType) {
        await _mainScreenCubit.onGroupCreated(group: createdGroup);
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Revert state.
      emit(state.copyWith(
        status: CreateGroupSheetStatus.close,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.addGroupSheetCubitGroupCreatedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> createGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> createGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user wants to edit a local group.
  Future<void> editLocalGroup() async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateGroupSheetStatus.loading,
      ));

      // * Always make sure a root group is present. This is a requirement for all groups, regardless if
      // * the group is local, shared, root or sub. It is acceptable to have twice the same id
      // * in a root group.
      if (state.group.rootGroupReference.isEmpty) throw Failure.rootGroupRequired();

      // Make sure group was edited.
      if (state.initialGroup == state.group) throw Failure.groupWasNotEdited();

      // Make sure a group name was provided.
      if (state.group.groupName.isEmpty) throw Failure.noGroupName();

      // Make sure that this group name does not already exist.
      // * Only do this check if group name changed.
      if (state.initialGroup.groupName != state.group.groupName) {
        // Check if this group name already exists.
        final Group? group = await _localStorageCubit.getLocalGroupByName(
          groupName: state.group.groupName,
          shouldAccessPrefs: false,
        );

        // Failure, group already exists.
        if (group != null) throw Failure.groupAlreadyExists();
      }

      // * Perform transaction.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // * Create group.
        await _localStorageCubit.editLocalGroup(
          editedGroup: state.group,
          isEdit: true,
        );
      });

      // * Update dependent cubits.
      if (_localGroupSelectedSheetCubit != null) {
        await _localGroupSelectedSheetCubit.onGroupEdited(
          editedGroup: state.group,
          commonModelEntries: state.commonModelEntries,
        );
      }

      // * If a top level group was edited, alert main screen.
      if (state.group.getIsLocalGroupType) {
        _mainScreenCubit.onLocalGroupEdited(group: state.group);
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Revert state.
      emit(state.copyWith(
        status: CreateGroupSheetStatus.close,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.addGroupSheetCubitGroupEditedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> editGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> editGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // Database Cloud
  // ############################################

  /// This method can be used to create a shared group.
  Future<void> createSharedGroup() async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateGroupSheetStatus.loading,
      ));

      // Make sure a group name was provided.
      if (state.group.groupName.isEmpty) throw Failure.noGroupName();

      // * Make sure that chosen pin is valid.
      if (state.group.accessPin.isNotEmpty) {
        // * Pin is too long.
        if (state.group.accessPin.length > 25) throw Failure.accessPinTooLong();
      }

      // In case this permission was set to none, reset edit and delete permissions.
      final bool needsReset = state.group.entryAddPolicy == Group.permissionNone;

      // Create shared group.
      final String groupId = await _localStorageCubit.createSharedGroup(
        group: state.group.copyWith(
          entryEditPolicy: needsReset ? Group.permissionNone : state.group.entryEditPolicy,
          entryDeletePolicy: needsReset ? Group.permissionNone : state.group.entryDeletePolicy,
        ),
      );

      // Update group.
      final Group sharedGroup = state.group.copyWith(
        groupId: groupId,
        rootGroupReference: state.group.getIsSharedSubgroupType ? state.group.rootGroupReference : groupId,
      );

      // * A subgroup was created, inform cubits.
      if (sharedGroup.getIsSharedSubgroupType) {
        await _sharedGroupSelectedSheetCubit!.subgroupCreated(subgroup: sharedGroup);
      }

      // * A group was created during group decision sheet.
      // * This is always a top level group.
      if (_groupDecisionSheetCubit != null) {
        await _groupDecisionSheetCubit.onGroupCreated(group: sharedGroup);
      }

      // * A top level group was created, alert main screen.
      if (sharedGroup.getIsSharedGroupType) {
        await _mainScreenCubit.onGroupCreated(group: sharedGroup);
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateGroupSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> createSharedGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> createSharedGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to edit a shared group.
  Future<void> editSharedGroup() async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateGroupSheetStatus.loading,
      ));

      // * Always make sure a root group is present. This is a requirement for all groups, regardless if
      // * the group is local, shared, root or sub. It is acceptable to have twice the same id
      // * in a root group.
      if (state.group.rootGroupReference.isEmpty) throw Failure.rootGroupRequired();

      // Make sure group was edited.
      if (state.initialGroup == state.group) throw Failure.groupWasNotEdited();

      // Make sure a group name was provided.
      if (state.group.groupName.isEmpty) throw Failure.noGroupName();

      // In case this permission was set to none, reset edit and delete permissions.
      final bool needsReset = state.group.entryAddPolicy == Group.permissionNone;

      // Edit shared group.
      await _localStorageCubit.editSharedGroup(
        group: state.group.copyWith(
          entryEditPolicy: needsReset ? Group.permissionNone : state.group.entryEditPolicy,
          entryDeletePolicy: needsReset ? Group.permissionNone : state.group.entryDeletePolicy,
        ),
      );

      // Inform cubit that current group was edited.
      await _sharedGroupSelectedSheetCubit!.onGroupEdited(
        editedGroup: state.group,
        commonModelEntries: state.commonModelEntries,
      );

      // * A subgroup was edited, inform cubits.
      if (state.group.getIsSharedSubgroupType) {
        await _sharedGroupSelectedSheetCubit.subgroupEdited(subgroup: state.group);
      }

      // * A top level group was edited.
      if (state.group.getIsSharedGroupType) {
        await _mainScreenCubit.onSharedGroupEdited(group: state.group);
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Revert state.
      emit(state.copyWith(
        status: CreateGroupSheetStatus.close,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.addGroupSheetCubitGroupEditedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> editSharedGroup() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: CreateGroupSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('CreateGroupSheetCubit --> editSharedGroup() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateGroupSheetStatus.failure,
      ));
    }
  }
}
