import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Config.
import '/config/app_durations.dart';

// Labels.
import '/main.dart';

// Repositories.
import '/data/repositories/location/location_repository.dart';
import '/data/repositories/local_notifications/local_notifications_repository.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/create_model_sheet/create_model_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/entry_sheet.dart';

// Screens.
import '/screens/main/cubit/main_screen_cubit.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/widgets/modal_bottom_sheets/create_model_sheet/cubit/create_model_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/cubit/entry_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';

part 'entry_decision_sheet_state.dart';

class EntryDecisionSheetCubit extends Cubit<EntryDecisionSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;
  final MainScreenCubit _mainScreenCubit;

  EntryDecisionSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        super(EntryDecisionSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize local state data.
  Future<void> initializeLocal({required Group fromGroup}) async {
    // * Necessary to avoid UI delay.
    await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

    // Access relevant objects.
    final ModelEntries allModelEntries = await _localStorageCubit.getAllLocalModelEntries(
      shouldAccessPrefs: true,
    );

    // Restricted.
    final ModelEntries commonModelEntries = await allModelEntries.getReferencedModelEntries(
      references: fromGroup.commonModelEntries,
      includeDeleted: false,
    );

    // State modelEntries.
    // * Locally if common model entries exist, they are also restricted because having common model entries and then showing all of
    // * them anyways does not make sense.
    final ModelEntries stateModelEntries = fromGroup.isRestrictedToCommon ? commonModelEntries.sortAtoZ : allModelEntries.sortAtoZ;

    final ModelEntry modelEntry = stateModelEntries.items.isEmpty ? ModelEntry.initial() : stateModelEntries.items.first;

    // Check if create entry sheet should be shown immdediately.
    final bool showCreateEntrySheet = fromGroup.isRestrictedToCommon && stateModelEntries.items.length == 1;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      isShared: false,
      fromGroup: fromGroup,
      entryModels: stateModelEntries,
      selectedEntryModel: modelEntry,
    ));

    // Emit micro service to ensure state update.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    // Emit state to show create entry sheet.
    if (showCreateEntrySheet) {
      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntryDecisionSheetStatus.showCreateEntrySheet,
      ));

      // * Waiting state will be called in showEntry methods.
      return;
    }

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      status: EntryDecisionSheetStatus.waiting,
    ));
  }

  /// Initialize shared state data.
  Future<void> initializeShared({required Group fromGroup}) async {
    // * Necessary to avoid UI delay.
    await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

    // Access relevant objects.
    final ModelEntries allModelEntries = await _mainScreenCubit.state.modelEntries.getCreatedByCurrentUser;

    // Restricted.
    final ModelEntries commonModelEntries = await _localStorageCubit.getSharedCommonModelEntries(
      rootGroupReference: fromGroup.rootGroupReference,
      references: fromGroup.commonModelEntries,
      referenceId: fromGroup.groupId,
    );

    // Init state ModelEntries.
    late ModelEntries stateModelEntries;

    // Check if this group is restricted to common.
    if (fromGroup.isRestrictedToCommon) {
      // Init state only with common model entries.
      stateModelEntries = commonModelEntries;
    }

    // Group is not restricted to common.
    // * This means user should be able to add those in common and their own ModelEntries.
    if (fromGroup.isRestrictedToCommon == false) {
      // Init state only with common model entries.
      stateModelEntries = await commonModelEntries.addUniqueModelEntries(modelEntries: allModelEntries);
    }

    // Sort state model entries.
    stateModelEntries = stateModelEntries.sortAtoZ;

    final ModelEntry modelEntry = stateModelEntries.items.isEmpty ? ModelEntry.initial() : stateModelEntries.items.first;

    // Check if create entry sheet should be shown immdediately.
    final bool showCreateEntrySheet = fromGroup.isRestrictedToCommon && stateModelEntries.items.length == 1;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      isShared: true,
      fromGroup: fromGroup,
      entryModels: stateModelEntries,
      selectedEntryModel: modelEntry,
    ));

    // Emit micro service to ensure state update.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    // Emit state to show create entry sheet.
    if (showCreateEntrySheet) {
      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntryDecisionSheetStatus.showCreateEntrySheet,
      ));

      // * Waiting state will be called in showEntry methods.
      return;
    }

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      status: EntryDecisionSheetStatus.waiting,
    ));
  }

  // ############################################
  // # State
  // ############################################

  /// This method can be used to jump to a specific item in ScrollWheel.
  /// * jumpls to first item in list if EntryModel was not found
  Future<void> jumpToScrollWeelItem({required FixedExtentScrollController fixedExtentScrollController}) async {
    try {
      // Access currently selected model.
      final int currentlySelectedIndex = state.entryModels.items.indexOf(state.selectedEntryModel);

      // Select created entry model in picker.
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => fixedExtentScrollController.jumpToItem(
          currentlySelectedIndex < 0 ? 0 : currentlySelectedIndex,
        ),
      );

      // Let crate entry sheet push over decision sheet before next state update.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.initial(),
        status: EntryDecisionSheetStatus.showCreateEntrySheet,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntryDecisionSheetCubit --> jumpToScrollWeelItem() --> exception: ${exception.toString()}');
    }
  }

  /// Triggered when user scrolls through picker.
  /// * Updates state variable with currently selected entryModel
  void updateSelectedModelEntry({required int index}) {
    // Access relevant data.
    final ModelEntry entryModel = state.entryModels.items[index];

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      selectedEntryModel: entryModel,
    ));
  }

  // ############################################
  // # Local mode
  // ############################################

  /// This method can be used to create a local model entry.
  void showCreateLocalModelEntrySheet({required BuildContext context}) {
    try {
      // * This ensures that user cannot create a new model entry from this path if model entries are restricted.
      // * It should never be reached because the button wont get rendered in that mode.
      if (state.fromGroup.isRestrictedToCommon) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateModelCubit>(
          create: (context) => CreateModelCubit(
            localStorageCubit: _localStorageCubit,
            mainScreenCubit: _mainScreenCubit,
            entryDecisionSheetCubit: this,
          )..initializeLocalCreate(),
          child: const CreateModelSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntryDecisionSheetCubit --> showCreateLocalModelEntrySheet() --> Failure: ${failure.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntryDecisionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntryDecisionSheetCubit --> showCreateLocalModelEntrySheet() --> Exception: ${exception.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntryDecisionSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to create a local entry.
  Future<void> showCreateLocalEntrySheet({required BuildContext context}) async {
    // Init LocalNotificationsCubit.
    final LocalNotificationCubit localNotificationCubit = LocalNotificationCubit(
      localNotificationsRepository: context.read<LocalNotificationsRepository>(),
      appMessagesCubit: _appMessagesCubit,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<EntrySheetCubit>(
        create: (context) => EntrySheetCubit(
          locationRepository: context.read<LocationRepository>(),
          localNotificationsCubit: localNotificationCubit,
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
          mainScreenCubit: _mainScreenCubit,
        )..initializeLocalCreate(
            fromGroup: state.fromGroup,
            modelEntry: state.selectedEntryModel,
          ),
        child: const EntrySheet(),
      ),
    );

    // * Close cubit after useing it.
    localNotificationCubit.close();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // Reset state.
    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntryDecisionSheetStatus.waiting,
    ));
  }

  // ############################################
  // # Shared mode
  // ############################################

  /// This method can be used to create a shared model entry.
  void showCreateSharedModelEntrySheet({required BuildContext context}) {
    try {
      // * This ensures that user cannot create a new model entry from this path if model entries are restricted.
      // * It should never be reached because the button wont get rendered in that mode.
      if (state.fromGroup.isRestrictedToCommon) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateModelCubit>(
          create: (context) => CreateModelCubit(
            localStorageCubit: _localStorageCubit,
            mainScreenCubit: _mainScreenCubit,
            entryDecisionSheetCubit: this,
          )..initializeSharedCreate(),
          child: const CreateModelSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntryDecisionSheetCubit --> showCreateSharedModelEntrySheet() --> Failure: ${failure.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntryDecisionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntryDecisionSheetCubit --> showCreateSharedModelEntrySheet() --> Exception: ${exception.toString()}.');

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntryDecisionSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to create a local entry.
  Future<void> showCreateSharedEntrySheet({required BuildContext context}) async {
    // Init LocalNotificationsCubit.
    final LocalNotificationCubit localNotificationCubit = LocalNotificationCubit(
      localNotificationsRepository: context.read<LocalNotificationsRepository>(),
      appMessagesCubit: _appMessagesCubit,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<EntrySheetCubit>(
        create: (context) => EntrySheetCubit(
          locationRepository: context.read<LocationRepository>(),
          localNotificationsCubit: localNotificationCubit,
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          sharedGroupSelectedSheetCubit: _sharedGroupSelectedSheetCubit,
          mainScreenCubit: _mainScreenCubit,
        )..initializeSharedCreate(
            fromGroup: state.fromGroup,
            modelEntry: state.selectedEntryModel,
          ),
        child: const EntrySheet(),
      ),
    );

    // * Close cubit after useing it.
    localNotificationCubit.close();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // Reset state.
    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntryDecisionSheetStatus.waiting,
    ));
  }

  // ------------------------------------------------------------------
  // * Below methods are called from other cubits
  // ------------------------------------------------------------------

  /// This method will be triggered if user created a new entry model.
  Future<void> onEntryModelCreated({required ModelEntry entryModel}) async {
    // Create updated state models.
    final ModelEntries updatedModels = state.entryModels.add(modelEntry: entryModel).sortAtoZ;

    // Update dependent cubits.
    if (_localGroupSelectedSheetCubit != null) {
      _localGroupSelectedSheetCubit.onModelEntryCreated(modelEntry: entryModel);
    }

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entryModels: updatedModels,
      selectedEntryModel: entryModel,
      status: EntryDecisionSheetStatus.updateScrollWeel,
    ));

    // Display notification.
    _appMessagesCubit.showNotification(
      message: labels.entryDecisionSheetCubitModelCreatedNotification(),
    );
  }
}
