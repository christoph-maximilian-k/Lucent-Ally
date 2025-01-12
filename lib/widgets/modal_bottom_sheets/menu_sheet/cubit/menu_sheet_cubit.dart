import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Repositories.
import '/data/repositories/api/api_repository.dart';
import '/data/repositories/local_notifications/local_notifications_repository.dart';
import '/data/repositories/location/location_repository.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/settings_sheet/cubit/settings_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/password_generator_sheet/cubit/password_generator_cubit.dart';
import '/widgets/modal_bottom_sheets/create_model_sheet/cubit/create_model_cubit.dart';
import '/widgets/modal_bottom_sheets/privacy_policy_sheet/cubit/privacy_policy_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/user_agreement_sheet/cubit/user_agreement_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/licences_sheet/cubit/licences_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/contact_support_sheet/cubit/contact_support_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/cubit/entry_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/widgets/modal_bottom_sheets/create_custom_password_sheet/cubit/create_custom_password_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/export_data_sheet/cubit/export_data_sheet_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/create_model_sheet/create_model_sheet.dart';
import '/widgets/modal_bottom_sheets/password_generator_sheet/password_generator_sheet.dart';
import '/widgets/modal_bottom_sheets/settings_sheet/settings_sheet.dart';
import '/widgets/modal_bottom_sheets/privacy_policy_sheet/privacy_policy_sheet.dart';
import '/widgets/modal_bottom_sheets/user_agreement_sheet/user_agreement_sheet.dart';
import '/widgets/modal_bottom_sheets/licences_sheet/licences_sheet.dart';
import '/widgets/modal_bottom_sheets/contact_support_sheet/contact_support_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/entry_sheet.dart';
import '/widgets/modal_bottom_sheets/create_custom_password_sheet/create_custom_password_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/import_data_sheet/cubit/import_data_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/import_data_sheet/import_data_sheet.dart';
import '/widgets/modal_bottom_sheets/export_data_sheet/export_data_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/model_entry_prefs/model_entry_prefs.dart';
import '/data/models/groups/groups.dart';
import '/data/models/groups/group.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

part 'menu_sheet_state.dart';

class MenuSheetCubit extends Cubit<MenuSheetState> with HelperFunctions {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;

  MenuSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        super(MenuSheetState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize local state data.
  Future<void> initializeLocal() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Get ModelEntries.
      final ModelEntries modelEntries = await _localStorageCubit.getAllLocalModelEntries(
        shouldAccessPrefs: true,
      );

      // Access local groups.
      final Groups localGroups = await _localStorageCubit.getAllLocalTopLevelGroups();

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        localGroups: localGroups.sortAtoZ,
        entryModels: modelEntries.sortAtoZ,
        status: MenuSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> initializeLocal() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: MenuSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> initializeLocal() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: MenuSheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared state data.
  Future<void> initializeShared() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Get ModelEntries.
      final ModelEntries modelEntries = await _localStorageCubit.selfGetAllSharedModelEntries();

      // Check if user name can change.
      final bool usernameCanChange = await _localStorageCubit.getSelfUsernameCanChange();

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        usernameCanChange: usernameCanChange,
        entryModels: modelEntries.sortAtoZ,
        status: MenuSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> initializeShared() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: MenuSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> initializeShared() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: MenuSheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open and not loading.
    if (isClosed || state.status == MenuSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: MenuSheetStatus.waiting,
    ));
  }

  /// This method gets trigered if user selects a model entry.
  Future<void> showModelEntryChoices({required BuildContext context, required ModelEntry modelEntry}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Edit model entry.
          optionOne: labels.basicLabelsEdit(),
          optionOneIcon: AppIcons.edit,
          optionOneSuffix: true,
          // * Delete model entry.
          optionTwo: labels.basicLabelsDelete(),
          optionTwoIcon: AppIcons.delete,
          optionTwoSuffix: true,
          // * Set default entry.
          optionThree: labels.basicLabelsEntryDefaults(),
          optionThreeIcon: AppIcons.defaultEntry,
          optionThreeSuffix: true,
          // * Remove thirdline.
          optionFour: labels.entrySelectedRemoveThirdline(),
          optionFourIcon: AppIcons.thirdline,
          // * Remove subtitle.
          optionFive: labels.entrySelectedRemoveSubtitle(),
          optionFiveIcon: AppIcons.subtitle,
        ),
      );

      // * User cancelled.
      if (option == null) return;

      // * User wants to edit a model entry.
      if (option == 1) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          selectedModelEntry: modelEntry,
          status: MenuSheetStatus.editModelEntry,
        ));
      }

      // * User wants to delete a model entry.
      if (option == 2) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          selectedModelEntry: modelEntry,
          status: MenuSheetStatus.deleteModelEntry,
        ));
      }

      // * User wants to add or edit entry defaults
      if (option == 3) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          selectedModelEntry: modelEntry,

          // * If user is in local mode only self default is relevant.
          status: state.isShared == false ? MenuSheetStatus.createDefaultEntrySelf : MenuSheetStatus.showDefaultChoice,
        ));
      }

      // * User selected remove thirdline.
      if (option == 4) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          selectedModelEntry: modelEntry,
          status: MenuSheetStatus.removeThirdline,
        ));
      }

      // * User selected remove subtitle.
      if (option == 5) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          selectedModelEntry: modelEntry,
          status: MenuSheetStatus.removeSubtitle,
        ));
      }

      // Await micro service to make sure that state has correct data.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // * Reset state!
      emit(state.copyWith(
        failure: Failure.initial(),
        status: MenuSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('MenuSheetCubit --> showModelEntryChoices() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('MenuSheetCubit --> showModelEntryChoices() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to set a default entry.
  Future<void> showDefaultChoice({required BuildContext context}) async {
    try {
      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Title.
          title: labels.setDefaultTitle(),
          // * Info message.
          infoMessage: labels.setDefaultInfoMessage(),
          // * Set default for self.
          optionOne: labels.setDefaultSelf(),
          optionOneIcon: AppIcons.profile,
          optionOneSuffix: true,
          // * Set default for everyone.
          optionTwo: labels.setDefaultEveryone(),
          optionTwoIcon: AppIcons.defaultEntry,
          optionTwoSuffix: true,
        ),
      );

      // * User cancelled.
      if (option == null) return;

      // * User wants to set defaults for themselves in shared mode.
      if (option == 1) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          failure: Failure.initial(),
          status: MenuSheetStatus.createDefaultEntrySelf,
        ));
      }

      // * User wants to setdefaults for everyone in shared mode.
      if (option == 2) {
        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          failure: Failure.initial(),
          status: MenuSheetStatus.createDefaultEntryEveryone,
        ));
      }
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('MenuSheetCubit --> showDefaultChoice() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('MenuSheetCubit --> showDefaultChoice() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == MenuSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: MenuSheetStatus.close,
    ));
  }

  // ############################################
  // # Model Entries Shared and Local
  // ############################################

  /// This method gets triggerd if user wants to not display selected thirdline anymore.
  Future<void> removeThirdline({required BuildContext context}) async {
    try {
      // Create edited modelEntryPrefs.
      final ModelEntryPrefs prefs = state.selectedModelEntry!.modelEntryPrefs.copyWith(
        thirdLineFieldId: "",
      );

      // Create edited ModelEntry.
      final ModelEntry editedEntryModel = state.selectedModelEntry!.copyWith(
        modelEntryPrefs: prefs,
      );

      // Update local ModelEntry.
      if (state.isShared == false) {
        await _localStorageCubit.state.database!.writeTxn(() async {
          await _localStorageCubit.putLocalModelEntryPrefs(
            modelEntryId: state.selectedModelEntry!.modelEntryId,
            modelEntryPrefs: prefs,
          );
        });
      }

      // Update shared ModelEntry.
      if (state.isShared) {
        await _localStorageCubit.putSelfSharedModelEntryPrefs(
          modelEntryId: state.selectedModelEntry!.modelEntryId,
          modelEntryPrefs: prefs,
          isSelfDefault: null,
        );
      }

      // Update dependent cubit.
      _mainScreenCubit.onModelEntryEdited(modelEntry: editedEntryModel);

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.entrySelectedRemoveThirdlineNotification(),
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: MenuSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> removeThirdline() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> removeThirdline() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to not display selected subtitle anymore.
  Future<void> removeSubtitle({required BuildContext context}) async {
    try {
      // Create edited modelEntryPrefs.
      final ModelEntryPrefs prefs = state.selectedModelEntry!.modelEntryPrefs.copyWith(
        subtitleFieldId: "",
      );

      // Create edited ModelEntry.
      final ModelEntry editedEntryModel = state.selectedModelEntry!.copyWith(
        modelEntryPrefs: prefs,
      );

      // Update local ModelEntry.
      if (state.isShared == false) {
        await _localStorageCubit.state.database!.writeTxn(() async {
          await _localStorageCubit.putLocalModelEntryPrefs(
            modelEntryId: state.selectedModelEntry!.modelEntryId,
            modelEntryPrefs: prefs,
          );
        });
      }

      // Update shared ModelEntry.
      if (state.isShared) {
        await _localStorageCubit.putSelfSharedModelEntryPrefs(
          modelEntryId: state.selectedModelEntry!.modelEntryId,
          modelEntryPrefs: prefs,
          isSelfDefault: null,
        );
      }

      // Update dependent cubit.
      _mainScreenCubit.onModelEntryEdited(modelEntry: editedEntryModel);

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.entrySelectedRemoveSubtitleNotification(),
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: MenuSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> removeSubtitle() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> removeSubtitle() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to create a default entry.
  Future<void> createDefaultEntry({required BuildContext context, required bool isSelfDefault}) async {
    try {
      // Get indication if defaults exist.
      final bool isEditDefault = isSelfDefault ? state.selectedModelEntry!.hasDefaultSelf : state.selectedModelEntry!.hasDefaultEveryone;

      // Init LocalNotificationsCubit.
      final LocalNotificationCubit localNotificationCubit = LocalNotificationCubit(
        localNotificationsRepository: context.read<LocalNotificationsRepository>(),
        appMessagesCubit: _appMessagesCubit,
      );

      // Show create entry sheet.
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
            mainScreenCubit: _mainScreenCubit,
            menuSheetCubit: this,
          )..initializeSetDefault(
              modelEntry: state.selectedModelEntry!,
              isEdit: isEditDefault,
              isSelfDefault: isSelfDefault,
              isShared: state.isShared,
            ),
          child: const EntrySheet(),
        ),
      );

      // * Close the cubit after useing it.
      localNotificationCubit.close();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> createDefaultEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        selectedModelEntry: null,
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> createDefaultEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        selectedModelEntry: null,
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Model Entries Local
  // ############################################

  /// This method can be used to show a CreateModelSheet in local mode.
  void showCreateLocalModelSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<CreateModelCubit>(
        create: (context) => CreateModelCubit(
          localStorageCubit: _localStorageCubit,
          mainScreenCubit: _mainScreenCubit,
          menuSheetCubit: this,
        )..initializeLocalCreate(),
        child: const CreateModelSheet(),
      ),
    );
  }

  /// This method can be used to edit a local model entry.
  Future<void> editLocalModelEntry({required BuildContext context}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<CreateModelCubit>(
        create: (context) => CreateModelCubit(
          localStorageCubit: _localStorageCubit,
          mainScreenCubit: _mainScreenCubit,
          menuSheetCubit: this,
        )..initializeLocalEdit(modelEntry: state.selectedModelEntry!),
        child: const CreateModelSheet(),
      ),
    );
  }

  /// This method can be used to delete a local model entry.
  Future<void> deleteLocalModelEntry({required BuildContext context}) async {
    try {
      // * Prompt user with confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.entryModelSelectedSheetCubitConfirmTitle(),
              subtitle: labels.entryModelSelectedSheetCubitConfirmSubtitle(),
            ),
          ) ??
          false;

      // * User dismissed.
      if (confirm == false) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: MenuSheetStatus.loading,
      ));

      // Make sure that model entry is not referenced.
      final bool modelEntryIsReferenced = await _localStorageCubit.localModelEntryIsReferenced(
        modelEntry: state.selectedModelEntry!,
      );

      // Inform user.
      if (modelEntryIsReferenced) throw Failure.entryModelIsReferenced();

      // Delete model entry and model entry prefs.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Delete entry model from local storage.
        await _localStorageCubit.deleteLocalModelEntry(
          modelEntry: state.selectedModelEntry!,
        );

        // Delete model entry prefs.
        await _localStorageCubit.deleteLocalModelEntryPrefs(
          modelEntryPrefs: state.selectedModelEntry!.modelEntryPrefs,
        );

        // Create updated model entries.
        final ModelEntries modelEntries = state.entryModels.remove(
          modelEntryId: state.selectedModelEntry!.modelEntryId,
        );

        // Notify dependent cubits.
        _mainScreenCubit.onModelEntryDeleted(
          modelEntryId: state.selectedModelEntry!.modelEntryId,
        );

        // Only emit state if cubit is open.
        if (isClosed) return;

        // Emit deleted state.
        emit(state.copyWith(
          selectedModelEntry: null,
          entryModels: modelEntries.sortAtoZ,
          status: MenuSheetStatus.waiting,
        ));

        // Display anotification.
        _appMessagesCubit.showNotification(
          message: labels.menuSheetCubitEntryModelDeletedNotification(),
        );
      });
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> deleteLocalModelEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        selectedModelEntry: null,
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> deleteLocalModelEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        selectedModelEntry: null,
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Model Entries Shared
  // ############################################

  /// This method can be used to show a CreateModelSheet in shared mode.
  void showCreateSharedModelSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<CreateModelCubit>(
        create: (context) => CreateModelCubit(
          localStorageCubit: _localStorageCubit,
          mainScreenCubit: _mainScreenCubit,
          menuSheetCubit: this,
        )..initializeSharedCreate(),
        child: const CreateModelSheet(),
      ),
    );
  }

  /// This method can be used to edit a shared model entry.
  Future<void> editSharedModelEntry({required BuildContext context}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<CreateModelCubit>(
        create: (context) => CreateModelCubit(
          localStorageCubit: _localStorageCubit,
          mainScreenCubit: _mainScreenCubit,
          menuSheetCubit: this,
        )..initializeSharedEdit(modelEntry: state.selectedModelEntry!),
        child: const CreateModelSheet(),
      ),
    );
  }

  /// This method can be used to delete a shared model entry.
  Future<void> deleteSharedModelEntry({required BuildContext context}) async {
    try {
      // * Prompt user with confirm sheet.
      final bool confirm = await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: labels.entryModelSelectedSheetCubitConfirmTitle(),
              subtitle: labels.entryModelSelectedSheetCubitConfirmSubtitle(),
            ),
          ) ??
          false;

      // * User dismissed.
      if (confirm == false) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: MenuSheetStatus.loading,
      ));

      // Delete entry model from cloud storage.
      await _localStorageCubit.deleteSharedModelEntry(
        modelEntry: state.selectedModelEntry!,
      );

      // Create updated model entries.
      final ModelEntries modelEntries = state.entryModels.remove(
        modelEntryId: state.selectedModelEntry!.modelEntryId,
      );

      // Notify dependent cubits.
      _mainScreenCubit.onModelEntryDeleted(
        modelEntryId: state.selectedModelEntry!.modelEntryId,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit deleted state.
      emit(state.copyWith(
        selectedModelEntry: null,
        entryModels: modelEntries.sortAtoZ,
        status: MenuSheetStatus.waiting,
      ));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.menuSheetCubitEntryModelDeletedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> deleteSharedModelEntry() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> deleteSharedModelEntry() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Import local data.
  // ############################################

  /// This method can be used to show import data sheet.
  Future<void> showLocalImportSheet({required BuildContext context}) async {
    try {
      // Make sure groups exist.
      if (state.localGroups.items.isEmpty) throw Failure.noGroupCreatedYet();

      // Convert to picker items.
      final PickerItems pickerItems = state.localGroups.toPickerItems();

      // Let user pick group to import to.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          title: labels.basicLabelsLocalGroups(),
          staticInfoMessage: labels.importToGroupInfoMessage(),
          pickerItems: pickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Access picked object.
      final PickerItem pickedItem = pickerItems.items[pickedIndex];

      // Access picked group.
      final Group? pickedGroup = await state.localGroups.getById(
        groupId: pickedItem.id,
      );

      // * Group not found.
      if (pickedGroup == null) throw Failure.genericError();

      // Make sure used context is still mounted.
      if (!context.mounted) {
        // Output debug message.
        contextNotMountedHelper(parent: 'MenuSheetCubit', sourceMethod: 'showLocalImportSheet()');

        throw Failure.genericError();
      }

      // * Show ImportDataSheet.
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (_) => BlocProvider<ImportDataSheetCubit>(
          create: (context) => ImportDataSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: _mainScreenCubit,
            menuSheetCubit: this,
          )..initializeLocal(
              group: pickedGroup,
              localModelEntries: state.entryModels,
            ),
          child: const ImportDataSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> showLocalImportSheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> showLocalImportSheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Export data.
  // ############################################

  /// This method can be used to show export local data sheet.
  Future<void> showLocalExportSheet({required BuildContext context}) async {
    try {
      // Hide failure.
      dismissFailure();

      // Make sure groups exist.
      if (state.localGroups.items.isEmpty) throw Failure.noGroupCreatedYet();

      // Check if there are encrypted groups.
      // * If there are no encrypted groups, let user search without authentification.
      // * If auth is fresh, let user search without reauthentification.
      if (_mainScreenCubit.state.protectedGroupIds.isNotEmpty && _localStorageCubit.state.authIsFresh == false) {
        // * Let user authenticate.
        final String? password = await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (context) => TextFieldSheet(
            title: labels.basicLabelsAuthenticate(),
            hint: labels.basicLabelsPasswordHint(),
            autocorrect: false,
            canObscure: true,
          ),
        );

        // * User cancled.
        if (password == null || password.isEmpty) return;

        // * Check if provided password is correct.
        // * This method throws failures.
        await _localStorageCubit.validateAppPassword(password: password);
      }

      // Make sure used context is still mounted.
      if (!context.mounted) {
        // Output debug message.
        contextNotMountedHelper(parent: 'MenuSheetCubit', sourceMethod: 'showLocalExportSheet()');

        throw Failure.genericError();
      }

      // * Show ExportDataSheet.
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (_) => BlocProvider<ExportDataSheetCubit>(
          create: (context) => ExportDataSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
          )..initializeLocal(),
          child: const ExportDataSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> showLocalExportSheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> showLocalExportSheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to show export shared data sheet.
  Future<void> showSharedExportSheet({required BuildContext context}) async {
    try {
      // * Show ExportDataSheet.
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (_) => BlocProvider<ExportDataSheetCubit>(
          create: (context) => ExportDataSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
          )..initializeShared(),
          child: const ExportDataSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> showSharedExportSheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> showSharedExportSheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Shared User Profile
  // ############################################

  /// This method can be used to change the current username.
  Future<void> changeUsername({required BuildContext context}) async {
    try {
      // * Let user choose a username.
      final String? username = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => TextFieldSheet(
          title: labels.menuSheetChangeUsername(),
          infoMessage: labels.changeUsernameInfoMessage(currentUsername: user.username),
        ),
      );

      // * User cancled, revert state.
      if (username == null || username.isEmpty || username == user.username) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: MenuSheetStatus.loading,
      ));

      // Change username.
      await _localStorageCubit.selfChangeUsername(
        username: username,
      );

      // Display a notification.
      _appMessagesCubit.showNotification(
        message: labels.basicLabelsSuccess(),
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        usernameCanChange: false,
        status: MenuSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> changeUsername() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> changeUsername() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  // ############################################
  // # Local User Profile
  // ############################################

  /// This method can be used to show a create password sheet.
  Future<void> showCreateCustomPasswordSheet({required BuildContext context}) async {
    // * Show Create custom password sheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<CreateCustomPasswordSheetCubit>(
        create: (context) => CreateCustomPasswordSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
        )..initialize(),
        child: const CreateCustomPasswordSheet(),
      ),
    );
  }

  // ############################################
  // # Password Generator
  // ############################################

  /// This method can be used to show a PasswordGeneratorSheet.
  void showPasswordGeneratorSheet({required BuildContext context}) {
    // * Show PasswordGeneratorSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<PasswordGeneratorCubit>(
        create: (context) => PasswordGeneratorCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
        )..initialize(),
        child: const PasswordGeneratorSheet(),
      ),
    );
  }

  /// This method can be used to show a SettingsSheet.
  void showSettingsSheet({required BuildContext context}) {
    // * Show SettingsSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<SettingsSheetCubit>(
        create: (context) => SettingsSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
        )..initialize(),
        child: const SettingsSheet(),
      ),
    );
  }

  /// This method can be used to show a privacy policy sheet.
  void showPrivacyPolicySheet({required BuildContext context}) {
    // * Show PrivacyPolicySheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<PrivacyPolicySheetCubit>(
        create: (context) => PrivacyPolicySheetCubit(
          apiRepository: context.read<ApiRepository>(),
        )..initialize(),
        child: const PrivacyPolicySheet(),
      ),
    );
  }

  /// This method can be used to show a user agreement sheet.
  void showUserAgreementSheet({required BuildContext context}) {
    // * Show UserAgreementSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<UserAgreementSheetCubit>(
        create: (context) => UserAgreementSheetCubit(
          apiRepository: context.read<ApiRepository>(),
        )..initialize(),
        child: const UserAgreementSheet(),
      ),
    );
  }

  /// This method can be used to show licences sheet.
  void showLicencesSheet({required BuildContext context}) {
    // * Show LicencesSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<LicencesSheetCubit>(
        create: (context) => LicencesSheetCubit()..initialize(),
        child: const LicencesSheet(),
      ),
    );
  }

  /// This method can be used to show a contact support sheet.
  void showContactSupportSheet({required BuildContext context}) {
    // * Show LicencesSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<ContactSupportSheetCubit>(
        create: (context) => ContactSupportSheetCubit(
          apiRepository: context.read<ApiRepository>(),
          appMessagesCubit: _appMessagesCubit,
        )..initialize(),
        child: const ContactSupportSheet(),
      ),
    );
  }

  // ############################################
  // # Logout
  // ############################################

  /// This method will be triggerd if user taps the logout button.
  Future<void> performLogout() async {
    try {
      // Perform logout in local storage state.
      await _localStorageCubit.triggerLogoutEvent();

      // Let user know that this succeeded.
      _appMessagesCubit.showNotification(message: labels.basicLabelsSuccess());
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> performLogout() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: MenuSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MenuSheetCubit --> performLogout() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MenuSheetStatus.failure,
      ));
    }
  }

  /// ############################################
  /// * Below methods are called from other cubits.
  /// ############################################

  /// This method can be used to add an entry model to state.
  /// * Shows notification.
  Future<void> onEntryModelCreated({required ModelEntry entryModel}) async {
    // Add new entry model.
    final ModelEntries modelEntries = state.entryModels.add(
      modelEntry: entryModel,
    );

    // Notify dependent cubits.
    _mainScreenCubit.onModelEntryCreated(modelEntry: entryModel);

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Add entry model from state.
    emit(state.copyWith(
      entryModels: modelEntries.sortAtoZ,
      status: MenuSheetStatus.waiting,
    ));

    // Display anotification.
    _appMessagesCubit.showNotification(
      message: labels.menuSheetCubitEntryModelCreatedNotification(),
    );
  }

  /// This method will be triggered if user edited an entry model.
  /// * Does not show notification.
  Future<void> onEntryModelEdited({required ModelEntry editedEntryModel}) async {
    // Update with specified ModelEntry.
    final ModelEntries? modelEntires = state.entryModels.update(
      modelEntry: editedEntryModel,
    );

    // Notify dependent cubits.
    _mainScreenCubit.onModelEntryEdited(modelEntry: editedEntryModel);

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      entryModels: modelEntires!.sortAtoZ,
      status: MenuSheetStatus.waiting,
    ));
  }
}
