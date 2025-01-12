import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';

// Repositories.
import '/data/repositories/local_notifications/local_notifications_repository.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/entries/entry.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/groups/groups.dart';
import '/data/models/groups/group.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/fields/field.dart';
import '/data/models/entries/entries.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/cloud_user/cloud_user.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/menu_sheet/menu_sheet.dart';
import '/widgets/modal_bottom_sheets/search_sheet/search_sheet.dart';
import '/widgets/modal_bottom_sheets/group_decision_sheet/group_decision_sheet.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/entry_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/local_group_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/shared_group_selected_sheet.dart';
import '/widgets/modal_bottom_sheets/group_invite_sheet/group_invite_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';
import '/widgets/modal_bottom_sheets/accept_cookies_sheet/accept_cookies_sheet.dart';

// Screens.
import '/screens/main/main_screen.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';
import '/widgets/modal_bottom_sheets/accept_cookies_sheet/cubit/accept_cookies_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/menu_sheet/cubit/menu_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/search_sheet/cubit/search_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/group_decision_sheet/cubit/group_decision_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/group_invite_sheet/cubit/group_invite_sheet_cubit.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> with HelperFunctions {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;

  MainScreenCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        super(MainScreenState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize local state.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Emit loading state if this is a retry.
      if (state.status != MainScreenStatus.pageIsLoading) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          pageFailure: Failure.initial(),
          status: MainScreenStatus.pageIsLoading,
          calledFrom: 'initializeLocal()',
        ));
      }

      // Access local groups.
      final Groups topLevelGroups = await _localStorageCubit.getAllLocalTopLevelGroups();

      // Access protected group ids.
      final List<String> protectedGroupIds = await _localStorageCubit.getLocalProtectedGroupIds();

      // Access show protected entries indication.
      final bool showProtectedEntries = _localStorageCubit.state.showProtectedEntries;

      // Access secrets.
      final Secrets? secrets = showProtectedEntries ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access recent entries.
      final Entries recentEntries = await _localStorageCubit.getLocalRecentEntries(
        offset: 0,
        limit: state.recentEntriesLimit,
        showProtectedRecentEntries: showProtectedEntries,
        protectedGroupIds: protectedGroupIds,
        secrets: secrets,
      );

      // Access local model entries.
      final ModelEntries modelEntries = await _localStorageCubit.getAllLocalModelEntries(
        shouldAccessPrefs: true,
      );

      // Check if app was booted with a deep link.
      final bool bootedWithDeepLink = _localStorageCubit.state.lastDeepLinkArgs.isNotEmpty;

      // Get indication if all available recent entries have been accessed.
      final bool isFinished = recentEntries.items.length < state.recentEntriesLimit;

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        groups: topLevelGroups.sortAtoZ,
        protectedGroupIds: protectedGroupIds,
        modelEntries: modelEntries,
        recentEntriesOffset: recentEntries.items.length,
        recentEntries: recentEntries,
        isFinished: isFinished,
        failure: Failure.initial(),
        status: bootedWithDeepLink ? MainScreenStatus.deepLink : MainScreenStatus.waiting,
        calledFrom: 'initializeLocal()',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> initializeLocal() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: MainScreenStatus.pageHasError,
        calledFrom: 'initializeLocal()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> initializeLocal() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: MainScreenStatus.pageHasError,
        calledFrom: 'initializeLocal()',
      ));
    }
  }

  // #############################
  // State
  // #############################

  /// This method gets invoked if user wants to dismiss a failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: MainScreenStatus.waiting,
      calledFrom: 'MainScreenCubit --> dismissFailure()',
    ));
  }

  /// This method can be used to cancle the execution of a request/function.
  Future<void> cancleRequest() async {
    // Cancle the requst.
    // * This conducts a local storage state update.
    await _localStorageCubit.cancleRequestLocally();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      showCancleButton: false,
      status: MainScreenStatus.waiting,
      calledFrom: 'cancleRequest()',
    ));
  }

  /// This method can be used to copy a value to clipboard.
  Future<void> copyToClipboard({required BuildContext context, required Entry entry, required ModelEntry entryModel}) async {
    try {
      // Hide failure.
      dismissFailure();

      // Check if copyableFieldId has been set.
      if (entryModel.modelEntryPrefs.copyFieldId.isEmpty) throw Failure.copyFieldNotSet();

      // Access index of copy field.
      final int index = entry.fields.items.indexWhere(
        (element) => element.fieldId == entryModel.modelEntryPrefs.copyFieldId,
      );

      // * In this case field which has been set as copy field was deleted or does not exist.
      if (index == -1) throw Failure.failureCopyFieldDoesNotExist();

      // Access copy field.
      final Field field = entry.fields.items[index];

      // Access field identification.
      final FieldIdentification fieldIdentification = entryModel.fieldIdentifications.items.firstWhere(
        (element) => element.fieldId == entryModel.modelEntryPrefs.copyFieldId,
        orElse: () => throw Failure.failureCopyFieldDoesNotExist(),
      );

      // Access copy value of field.
      final String? copyValue = field.getCopyValue;

      // * In this case field might have been deleted or set to empty.
      if (copyValue == null) throw Failure.copyValueEmpty();

      // Set data to clipboard.
      await Clipboard.setData(ClipboardData(text: copyValue));

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.mainScreenCubitCopyToClipboardNotification(label: fieldIdentification.label),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> copyToClipboard() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> copyToClipboard()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> copyToClipboard() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> copyToClipboard()',
      ));
    }
  }

  /// This method can be used to show a SearchSheet.
  Future<void> showSearchSheet({required BuildContext context}) async {
    try {
      // Hide failure.
      dismissFailure();

      // Check if there are encrypted groups.
      // * If there are no encrypted groups, let user search without authentification.
      // * If auth is fresh, let user search without reauthentification.
      if (state.protectedGroupIds.isNotEmpty && _localStorageCubit.state.authIsFresh == false) {
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
        contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'showSearchSheet()');

        throw Failure.genericError();
      }

      // * Show SearchSheet.
      final Entry? entry = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<SearchSheetCubit>(
          create: (context) => SearchSheetCubit(
            localStorageCubit: _localStorageCubit,
          )..initialize(
              isShared: state.isShared,
            ),
          child: const SearchSheet(),
        ),
      );

      // User closed the search sheet.
      if (entry == null || isClosed) return;

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'showSearchSheet()');

      // * User is in local mode.
      if (state.isShared == false) showLocalEntrySelectedSheet(context: context, entry: entry);

      // * User is in shared mode.
      if (state.isShared) showSharedEntrySelectedSheet(context: context, entry: entry);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> showSearchSheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        showCancleButton: false,
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> showSearchSheet()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> showSearchSheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        showCancleButton: false,
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> showSearchSheet()',
      ));
    }
  }

  /// This method can be used to show a GroupDecisionSheet.
  void showGroupDecisionSheet({required BuildContext context}) {
    // Hide failure.
    dismissFailure();

    if (state.isShared == false) {
      // * Show GroupDecisionSheetCubit.
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => BlocProvider<GroupDecisionSheetCubit>(
          create: (context) => GroupDecisionSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: this,
          )..initializeLocal(),
          child: const GroupDecisionSheet(),
        ),
      );
    }

    if (state.isShared) {
      // * Show GroupDecisionSheetCubit.
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => BlocProvider<GroupDecisionSheetCubit>(
          create: (context) => GroupDecisionSheetCubit(
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: this,
          )..initializeShared(),
          child: const GroupDecisionSheet(),
        ),
      );
    }
  }

  /// This method can be used to select what type of groups should be shown.
  Future<void> groupsDropDownPressed({required BuildContext context}) async {
    // Helper to have request id available in try catch block.
    String requestId = '';

    // Perform function.
    try {
      // Hide failure.
      dismissFailure();

      // Access language specific group types.
      final PickerItems pickerItems = Group.groupTypesAsPickerItems();

      // Init initial item.
      final int initialItem = state.isShared ? 1 : 0;

      // Show PickerSheet.
      final int? pickerIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          initialItem: initialItem,
          title: labels.groupDecisionSheetChooseGroupType(),
          pickerItems: pickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickerIndex == null) return;

      // Access chosen groupType.
      final String groupType = pickerItems.items[pickerIndex].id;

      // Indicator if user selected local mode.
      final bool isLocalMode = groupType == Group.groupTypeLocal;

      // * User selected the same as before.
      if (state.isShared == false && isLocalMode) return;
      if (state.isShared && isLocalMode == false) return;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit new state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: MainScreenStatus.pageIsLoading,
        showCancleButton: true,
        calledFrom: 'groupsDropDownPressed()',
      ));

      // Get a request id to enable cancle request functionality.
      requestId = await _localStorageCubit.getRequestId();

      // * If user selected local mode, init local.
      if (isLocalMode) {
        // Access local groups.
        final Groups topLevelGroups = await _localStorageCubit.getAllLocalTopLevelGroups();

        // Access protected group ids.
        final List<String> protectedGroupIds = await _localStorageCubit.getLocalProtectedGroupIds();

        // Access show protected entries indication.
        final bool showProtectedEntries = _localStorageCubit.state.showProtectedEntries;

        // Access secrets.
        final Secrets? secrets = showProtectedEntries ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

        // Access recent entries.
        final Entries localRecentEntries = await _localStorageCubit.getLocalRecentEntries(
          offset: 0,
          limit: state.recentEntriesLimit,
          showProtectedRecentEntries: showProtectedEntries,
          protectedGroupIds: protectedGroupIds,
          secrets: secrets,
        );

        // Access local model entries.
        final ModelEntries modelEntries = await _localStorageCubit.getAllLocalModelEntries(
          shouldAccessPrefs: true,
        );

        // Get indication if all available recent entries have been accessed.
        final bool isFinished = localRecentEntries.items.length < state.recentEntriesLimit;

        // Check if request was cancled.
        final bool requestGotCancled = await _localStorageCubit.getWasRequestCancled(requestId: requestId);

        // Stop function if request was cancled.
        if (requestGotCancled) return;

        // Only emit state if cubit is open.
        if (isClosed) return;

        emit(state.copyWith(
          isShared: false,
          groups: topLevelGroups.sortAtoZ,
          protectedGroupIds: protectedGroupIds,
          modelEntries: modelEntries,
          recentEntriesOffset: localRecentEntries.items.length,
          recentEntries: localRecentEntries,
          showCancleButton: false,
          isFinished: isFinished,
          failure: Failure.initial(),
          status: MainScreenStatus.waiting,
          calledFrom: 'groupsDropDownPressed()',
        ));

        return;
      }

      // * Otherwise user selected shared mode.

      // Check if user has to update the app.
      await _localStorageCubit.meetsApiRequirements();

      // Make sure used context is still mounted.
      if (!context.mounted) {
        // Output debug message.
        contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'groupsDropDownPressed()');

        throw Failure.genericError();
      }

      // * Ensure that user has accepted terms and conditions before proceeding to shared groups.
      if (user.settings.acceptedTermsAndConditions == false) {
        // Show terms and condition sheet.
        final bool accepted = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (_) => BlocProvider<AcceptCookiesSheetCubit>(
                create: (context) => AcceptCookiesSheetCubit(
                  localStorageCubit: _localStorageCubit,
                )..initialize(),
                child: const AcceptCookiesSheet(),
              ),
            ) ??
            false;

        // User did not accept terms and conditions.
        if (accepted == false) throw Failure.termsAndConditionsNotAccepted();
      }

      // Create an anon cloud user if it does not already exist.
      await _localStorageCubit.createCloudUser();

      // * Uncomment this to create a test model entry in the cloud.
      // final ModelEntry testModelEntry = ModelEntry.test(isShared: true);
      // await _localStorageCubit.createSharedModelEntry(modelEntry: testModelEntry);

      // Access shared groups.
      final Groups topLevelGroups = await _localStorageCubit.getSelfAllSharedTopLevelGroups();

      // Access self shared model entries.
      final ModelEntries selfSharedModelEntries = await _localStorageCubit.selfGetAllSharedModelEntries();

      // Access shared recent entries.
      final Map<String, dynamic> entriesAndModelEntries = await _localStorageCubit.getSelfSharedRecentEntries(
        offset: 0,
        limit: state.recentEntriesLimit,
      );

      // Access Data.
      final Entries sharedRecentEntries = entriesAndModelEntries['entries'];
      final ModelEntries modelEntries = entriesAndModelEntries['model_entries'];

      // Join self and others.
      final ModelEntries joined = await selfSharedModelEntries.addUniqueModelEntries(
        modelEntries: modelEntries,
      );

      // Get indication if all available recent entries have been accessed.
      final bool isFinished = sharedRecentEntries.items.length < state.recentEntriesLimit;

      // Check if request was cancled.
      final bool requestGotCancled = await _localStorageCubit.getWasRequestCancled(requestId: requestId);

      // Stop function if request was cancled.
      if (requestGotCancled) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        groups: topLevelGroups.sortAtoZ,
        modelEntries: joined,
        recentEntriesOffset: sharedRecentEntries.items.length,
        recentEntries: sharedRecentEntries,
        isFinished: isFinished,
        showCancleButton: false,
        failure: Failure.initial(),
        status: MainScreenStatus.waiting,
        calledFrom: 'groupsDropDownPressed()',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> groupsDropDownPressed() --> failure: ${failure.toString()}');

      // Check if request was cancled.
      final bool requestGotCancled = await _localStorageCubit.getWasRequestCancled(requestId: requestId);

      // Do not display failure if request was cancled.
      if (requestGotCancled) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        showCancleButton: false,
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> groupsDropDownPressed()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> groupsDropDownPressed() --> exception: ${exception.toString()}');

      // Check if request was cancled.
      final bool requestGotCancled = await _localStorageCubit.getWasRequestCancled(requestId: requestId);

      // Do not display failure if request was cancled.
      if (requestGotCancled) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        showCancleButton: false,
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> groupsDropDownPressed()',
      ));
    }
  }

  /// This method can be used to show recent entries options.
  Future<void> showRecentEntriesOptions({required BuildContext context}) async {
    try {
      // * For now make sure in that if user is in shared mode and somehow can access this a failure is thrown.
      if (state.isShared) throw Failure.unimplemented();

      // Access helpers.
      final bool showProtectedEntries = _localStorageCubit.state.showProtectedEntries;
      final bool isFresh = _localStorageCubit.state.authIsFresh;

      // * Show selector sheet and await choice.
      final int? option = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => SelectOptionSheet(
          // * Show encrypted recent entries.
          // ! Only visible if they are currently hidden.
          optionOne: showProtectedEntries ? null : labels.basicLabelsShowProtectedRecentEntries(),
          optionOneIcon: AppIcons.visible,
          optionOneSuffix: isFresh == false,
          // * Hide encrypted recent entries.
          // ! Only visible if they are currently visible.
          optionTwo: showProtectedEntries == false ? null : labels.basicLabelsHideProtectedRecentEntries(),
          optionTwoIcon: AppIcons.hidden,
        ),
      );

      // * User cancelled.
      if (option == null) return;

      // Make sure used context is still mounted.
      if (!context.mounted) {
        // Output debug message.
        contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'showSharedGroupsOptions()');

        throw Failure.genericError();
      }

      // * User wants to see protected recent entries.
      if (option == 1) {
        // ! User only has to provide password if auth is not fresh.
        if (isFresh == false) {
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

        // * Set local state indicator in order to enable auto hide of protected entries after a while.
        await _localStorageCubit.updateShowProtectedRecentEntries(visible: true);
      }

      // * User wants to hide protected recent entries.
      if (option == 2) {
        // * Set local state indicator in order to enable auto hide of protected entries after a while.
        await _localStorageCubit.updateShowProtectedRecentEntries(visible: false);
      }
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('MenuSheetCubit --> showRecentEntriesOptions() --> Failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> showRecentEntriesOptions()',
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('MenuSheetCubit --> showRecentEntriesOptions() --> Exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> showRecentEntriesOptions()',
      ));
    }
  }

  /// This method can be used to handle show/hide protected entries events.
  void onShowProtectedEntriesChanged() {
    // Only emit new states if cubit is still open.
    // ! Currently do nothing in shared mode.
    if (state.isShared || isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: MainScreenStatus.reloadRecentEntries,
      calledFrom: 'MainScreenCubit --> onShowProtectedEntriesChanged()',
    ));
  }

  // #############################
  // Local Mode.
  // #############################

  /// This method can be used to show a group selected sheet.
  Future<void> showLocalGroupSelectedSheet({required BuildContext context, required Group group}) async {
    // Hide failure.
    dismissFailure();

    // * Display GroupSelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<LocalGroupSelectedSheetCubit>(
        create: (context) => LocalGroupSelectedSheetCubit(
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          mainScreenCubit: this,
          // * TopLevel group gets selected here, which means that there is no ancestor groupSelectedSheetCubit to pass on.
          ancestorLocalGroupSelectedSheetCubit: null,
        )..initialize(
            context: context,
            group: group,
            topLevelGroupId: group.groupId,
          ),
        child: const LocalGroupSelectedSheet(),
      ),
    );
  }

  /// This method can be used to show a MenuSheet in local mode.
  void showLocalMenuSheet({required BuildContext context}) {
    // Hide failure.
    dismissFailure();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<MenuSheetCubit>(
        create: (context) => MenuSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          mainScreenCubit: this,
        )..initializeLocal(),
        child: const MenuSheet(),
      ),
    );
  }

  // #############################
  // Shared Mode.
  // #############################

  /// This method can be used to access a cloud user.
  Future<CloudUser?> getCloudUser({required String entryCreator}) async {
    try {
      // * Do not trigger this if user is in local mode.
      if (state.isShared == false) return null;

      // * Check for self user.
      if (entryCreator == user.userId) return CloudUser.self();

      // * Ensure that loading spinner is shown.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      return await _localStorageCubit.getCloudUserById(userId: entryCreator);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> getCloudUser() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> getCloudUser() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This method can be used to show a MenuSheet.
  void showSharedMenuSheet({required BuildContext context}) {
    // Hide failure.
    dismissFailure();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<MenuSheetCubit>(
        create: (context) => MenuSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          mainScreenCubit: this,
        )..initializeShared(),
        child: const MenuSheet(),
      ),
    );
  }

  /// This method can be used to refresh shared mode.
  Future<void> refreshSharedMode() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access shared groups.
      final Groups topLevelGroups = await _localStorageCubit.getSelfAllSharedTopLevelGroups();

      // Access self shared model entries.
      final ModelEntries selfSharedModelEntries = await _localStorageCubit.selfGetAllSharedModelEntries();

      // Access shared recent entries.
      final Map<String, dynamic> entriesAndModelEntries = await _localStorageCubit.getSelfSharedRecentEntries(
        offset: 0,
        limit: state.recentEntriesLimit,
      );

      // Access Data.
      final Entries recentEntries = entriesAndModelEntries['entries'];
      final ModelEntries modelEntries = entriesAndModelEntries['model_entries'];

      // Join self and others.
      final ModelEntries joined = await selfSharedModelEntries.addUniqueModelEntries(
        modelEntries: modelEntries,
      );

      // Get indication if all available recent entries have been accessed.
      final bool isFinished = recentEntries.items.length < state.recentEntriesLimit;

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        groups: topLevelGroups.sortAtoZ,
        modelEntries: joined,
        recentEntriesOffset: recentEntries.items.length,
        recentEntries: recentEntries,
        isFinished: isFinished,
        failure: Failure.initial(),
        status: MainScreenStatus.waiting,
        calledFrom: 'refreshSharedMode()',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> refreshSharedMode() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // * Do not use pageError here, because users could get stuck there.

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: MainScreenStatus.failure,
        calledFrom: 'refreshSharedMode()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> refreshSharedMode() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // * Do not use pageError here, because users could get stuck there.

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MainScreenStatus.failure,
        calledFrom: 'refreshSharedMode()',
      ));
    }
  }

  /// This method can be used to show a shared group selected sheet.
  Future<void> showSharedGroupSelectedSheet({required BuildContext context, required Group group}) async {
    // Hide failure.
    dismissFailure();

    // * Display SharedGroupSelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => BlocProvider<SharedGroupSelectedSheetCubit>(
        create: (context) => SharedGroupSelectedSheetCubit(
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          mainScreenCubit: this,
          // * TopLevel group gets selected here, which means that there is no ancestor groupSelectedSheetCubit to pass on.
          sharedGroupSelectedSheetCubit: null,
        )..initializeGroup(initialGroup: group),
        child: const SharedGroupSelectedSheet(),
      ),
    );
  }

  /// This method is invoked if user wants to see options for shared groups.
  Future<void> showSharedGroupsOptions({required BuildContext context}) async {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // Get rid of Failure if shown.
    emit(state.copyWith(
      failure: Failure.initial(),
      status: MainScreenStatus.waiting,
      calledFrom: 'showSharedGroupsOptions()',
    ));

    // * Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        // * Join a group.
        optionOne: labels.joinGroup(),
        optionOneIcon: AppIcons.add,
        optionOneSuffix: true,
      ),
    );

    // * User cancled.
    if (option == null) return;

    // Make sure used context is still mounted. Output debug message.
    if (!context.mounted) return contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'showSharedGroupsOptions()');

    // * User wants to join a group.
    if (option == 1) await showGroupLinkSheet(context: context);
  }

  /// This method can be used to show text input sheet to let user type in the group link.
  Future<void> showGroupLinkSheet({required BuildContext context}) async {
    try {
      // Hide failure.
      dismissFailure();

      // * Let user provide group alias.
      final String? groupAlias = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => TextFieldSheet(
          title: labels.joinGroup(),
          infoMessage: labels.groupInviteLinkExample(),
        ),
      );

      // * User cancled or context is not mounted.
      if (groupAlias == null || groupAlias.isEmpty || !context.mounted) return;

      // Handle the group invite.
      await handleGroupInvite(context: context, groupAlias: groupAlias);
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> showGroupLinkSheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: MainScreenStatus.failure,
        calledFrom: 'showGroupLinkSheet()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> showGroupLinkSheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: MainScreenStatus.failure,
        calledFrom: 'showGroupLinkSheet()',
      ));
    }
  }

  /// This method can be used to handle a group invite.
  Future<void> handleGroupInvite({required BuildContext context, required String? groupAlias}) async {
    // Helper to have request id available in try catch block.
    String requestId = '';

    try {
      // Make sure that deep link is valid and contains required variables.
      if (groupAlias == null || groupAlias.isEmpty) throw Failure.genericError();

      // Pop all screens above main screen. This ensures that user does not end up with two groups opened.
      Navigator.popUntil(context, (route) {
        return route.settings.name == MainScreen.routeName;
      });

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit new state.
      emit(state.copyWith(
        failure: Failure.initial(),
        showCancleButton: true,
        status: MainScreenStatus.pageIsLoading,
        calledFrom: 'handleGroupInvite()',
      ));

      // Get a request id to enable cancle request functionality.
      requestId = await _localStorageCubit.getRequestId();

      // Create an anon cloud user if it does not already exist.
      // * This is needed here because a shared user might not have been created yet.
      await _localStorageCubit.createCloudUser();

      // User was in local mode, load shared mode.
      if (state.isShared == false) {
        // Access shared groups.
        final Groups topLevelGroups = await _localStorageCubit.getSelfAllSharedTopLevelGroups();

        // Access shared recent entries.
        final Map<String, dynamic> entriesAndModelEntries = await _localStorageCubit.getSelfSharedRecentEntries(
          offset: 0,
          limit: state.recentEntriesLimit,
        );

        // Access Data.
        final Entries recentEntries = entriesAndModelEntries['entries'];
        final ModelEntries modelEntries = entriesAndModelEntries['model_entries'];

        // Get indication if all available recent entries have been accessed.
        final bool isFinished = recentEntries.items.length < state.recentEntriesLimit;

        // Check if request was cancled.
        final bool requestGotCancled = await _localStorageCubit.getWasRequestCancled(requestId: requestId);

        // Stop function if request was cancled.
        if (requestGotCancled) return;

        // Only emit state if cubit is open.
        if (isClosed) return;

        emit(state.copyWith(
          isShared: true,
          groups: topLevelGroups.sortAtoZ,
          modelEntries: modelEntries,
          recentEntriesOffset: recentEntries.items.length,
          recentEntries: recentEntries,
          isFinished: isFinished,
          calledFrom: 'handleGroupInvite()',
        ));

        // Microservice to aknownledge state change.
        await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));
      }

      // Get group details from alias.
      final Map<String, dynamic> details = await _localStorageCubit.getSharedGroupByAlias(
        alias: groupAlias,
      );

      // Access details.
      final String groupId = details['group_id']!;
      final bool pinRequired = details['pin_required']!;

      // Check if user is already in this group.
      final Group? stateGroup = await state.groups.getById(groupId: groupId);

      // Group is in state, which means user already has access to this group.
      if (stateGroup != null) {
        // Make sure this group is a top level shared group. This is just a safety precaution.
        final bool validGroup = stateGroup.getIsSharedGroupType;

        if (validGroup == false) throw Failure.failureInvalidGroupType();

        // Make sure used context is still mounted. Output debug message.
        if (!context.mounted) return contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'handleGroupInvite() --> group found locally');

        // * Display SharedGroupSelectedSheet with accessed group.
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (_) => BlocProvider<SharedGroupSelectedSheetCubit>(
            create: (context) => SharedGroupSelectedSheetCubit(
              localNotificationsRepository: context.read<LocalNotificationsRepository>(),
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: this,
              sharedGroupSelectedSheetCubit: null,
            )..initializeGroup(
                initialGroup: stateGroup,
              ),
            child: const SharedGroupSelectedSheet(),
          ),
        );

        // Only emit new states if cubit is still open.
        if (isClosed) return;

        // Revert state.
        emit(state.copyWith(
          showCancleButton: false,
          failure: Failure.initial(),
          status: MainScreenStatus.waiting,
          calledFrom: 'handleGroupInvite()',
        ));

        return;
      }

      // * This group was not found locally.

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // Revert state to not show page is loading anymore.
      emit(state.copyWith(
        showCancleButton: false,
        failure: Failure.initial(),
        status: MainScreenStatus.waiting,
        calledFrom: 'handleGroupInvite()',
      ));

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'handleGroupInvite() --> group not found locally');

      // Display GroupInviteSheet.
      final Group? joinedGroup = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<GroupInviteSheetCubit>(
          create: (context) => GroupInviteSheetCubit(
            mainScreenCubit: this,
            localStorageCubit: _localStorageCubit,
          )..initialize(
              groupId: groupId,
              pinRequired: pinRequired,
            ),
          child: const GroupInviteSheet(),
        ),
      );

      // * User cancled.
      if (joinedGroup == null) return;

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) return contextNotMountedHelper(parent: 'MainScreenCubit', sourceMethod: 'handleGroupInvite() --> display accessed group');

      // * Display GroupSelectedSheet with accessed group.
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<SharedGroupSelectedSheetCubit>(
          create: (context) => SharedGroupSelectedSheetCubit(
            localNotificationsRepository: context.read<LocalNotificationsRepository>(),
            localStorageCubit: _localStorageCubit,
            appMessagesCubit: _appMessagesCubit,
            mainScreenCubit: this,
            sharedGroupSelectedSheetCubit: null,
          )..initializeGroup(
              initialGroup: joinedGroup,
            ),
          child: const SharedGroupSelectedSheet(),
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> handleGroupInvite() --> failure: ${failure.toString()}');

      // Check if request was cancled.
      final bool requestGotCancled = await _localStorageCubit.getWasRequestCancled(requestId: requestId);

      // Stop function if request was cancled.
      if (requestGotCancled) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        showCancleButton: false,
        failure: failure,
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> handleGroupInvite()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> handleGroupInvite() --> exception: ${exception.toString()}');

      // Check if request was cancled.
      final bool requestGotCancled = await _localStorageCubit.getWasRequestCancled(requestId: requestId);

      // Stop function if request was cancled.
      if (requestGotCancled) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        showCancleButton: false,
        failure: Failure.genericError(),
        status: MainScreenStatus.failure,
        calledFrom: 'MainScreenCubit --> handleGroupInvite()',
      ));
    }
  }

  // #############################
  // Local Entries
  // #############################

  /// This method can be used to show an EntrySelectedSheet in local mode.
  void showLocalEntrySelectedSheet({required BuildContext context, required Entry entry}) {
    // Hide failure.
    dismissFailure();

    // * Show EntrySelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<EntrySelectedSheetCubit>(
        create: (context) => EntrySelectedSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          mainScreenCubit: this,
        )..initializeLocal(
            entry: entry,
            fromGroup: null,
            fromViewEntriesSheet: false,
          ),
        child: const EntrySelectedSheet(),
      ),
    );
  }

  /// This method can be used to access more local recent entries.
  Future<void> loadMoreLocalRecentEntries() async {
    try {
      // Only emit state if cubit is open.
      // * Do not trigger method if all recent entries have been loaded.
      if (isClosed || state.isFinished) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: true,
        failure: Failure.initial(),
        calledFrom: 'loadMoreLocalRecentEntries()',
      ));

      // Access show protected entries indication.
      final bool showProtectedEntries = _localStorageCubit.state.showProtectedEntries;

      // Access secrets.
      final Secrets? secrets = showProtectedEntries ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access recent entries.
      final Entries recentEntries = await _localStorageCubit.getLocalRecentEntries(
        offset: state.recentEntriesOffset,
        limit: state.recentEntriesLimit,
        showProtectedRecentEntries: showProtectedEntries,
        protectedGroupIds: state.protectedGroupIds,
        secrets: secrets,
      );

      // Join entries.
      final Entries joined = await state.recentEntries.addUniqueEntries(
        entries: recentEntries,
        append: true,
      );

      // Calculate offset depending on returned entries.
      // * This if is required. Do not do "joined.items.length" here because that will result in skipping
      // * items that should be accessed.
      final int offset = recentEntries.items.isEmpty ? state.recentEntriesOffset : state.recentEntriesOffset + state.recentEntriesLimit;

      // Get indication if all available recent entries have been accessed.
      final bool isFinished = recentEntries.items.length < state.recentEntriesLimit;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        recentEntriesOffset: offset,
        recentEntries: joined,
        isFinished: isFinished,
        calledFrom: 'loadMoreLocalRecentEntries()',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> loadMoreLocalRecentEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        failure: failure,
        status: MainScreenStatus.failure,
        calledFrom: 'loadMoreLocalRecentEntries()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> loadMoreLocalRecentEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        failure: Failure.failureToLoadEntries(),
        status: MainScreenStatus.failure,
        calledFrom: 'loadMoreLocalRecentEntries()',
      ));
    }
  }

  /// This method can be used to reset local recent entries.
  Future<void> reloadLocalRecentEntries() async {
    try {
      // Access show protected entries indication.
      final bool showProtectedEntries = _localStorageCubit.state.showProtectedEntries;

      // Access secrets.
      final Secrets? secrets = showProtectedEntries ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access protected group ids.
      final List<String> protectedGroupIds = await _localStorageCubit.getLocalProtectedGroupIds();

      // Access recent entries.
      final Entries recentEntries = await _localStorageCubit.getLocalRecentEntries(
        offset: 0,
        limit: state.recentEntriesLimit,
        showProtectedRecentEntries: showProtectedEntries,
        protectedGroupIds: protectedGroupIds,
        secrets: secrets,
      );

      // Get indication if all available recent entries have been accessed.
      final bool isFinished = recentEntries.items.length < state.recentEntriesLimit;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit done state.
      emit(state.copyWith(
        recentEntriesOffset: recentEntries.items.length,
        recentEntries: recentEntries,
        protectedGroupIds: protectedGroupIds,
        isFinished: isFinished,
        status: MainScreenStatus.waiting,
        calledFrom: 'reloadLocalRecentEntries()',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> reloadLocalRecentEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        recentEntriesOffset: 0,
        status: MainScreenStatus.failure,
        calledFrom: 'reloadLocalRecentEntries()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> reloadLocalRecentEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.failureToLoadEntries(),
        recentEntriesOffset: 0,
        status: MainScreenStatus.failure,
        calledFrom: 'reloadLocalRecentEntries()',
      ));
    }
  }

  // #############################
  // Shared Entries
  // #############################

  /// This method can be used to show an EntrySelectedSheet in shared mode.
  void showSharedEntrySelectedSheet({required BuildContext context, required Entry entry}) {
    // Hide failure.
    dismissFailure();

    // * Show EntrySelectedSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<EntrySelectedSheetCubit>(
        create: (context) => EntrySelectedSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          mainScreenCubit: this,
        )..initializeShared(
            entry: entry,
            fromGroup: null,
            fromViewEntriesSheet: false,
          ),
        child: const EntrySelectedSheet(),
      ),
    );
  }

  /// This method can be used to access more shared recent entries.
  Future<void> loadMoreSharedRecentEntries() async {
    try {
      // Only emit state if cubit is open.
      // * Do not trigger method if all recent entries have been loaded.
      if (isClosed || state.isFinished) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: true,
        failure: Failure.initial(),
        calledFrom: 'loadMoreSharedRecentEntries()',
      ));

      // Access shared recent entries.
      final Map<String, dynamic> entriesAndModelEntries = await _localStorageCubit.getSelfSharedRecentEntries(
        offset: state.recentEntriesOffset,
        limit: state.recentEntriesLimit,
      );

      // Access Data.
      final Entries recentEntries = entriesAndModelEntries['entries'];
      final ModelEntries modelEntries = entriesAndModelEntries['model_entries'];

      // Join entries.
      final Entries joined = await state.recentEntries.addUniqueEntries(
        entries: recentEntries,
        append: true,
      );

      // Joined ModelEntries.
      final ModelEntries joinedModelEntries = await state.modelEntries.addUniqueModelEntries(
        modelEntries: modelEntries,
      );

      // Get indication if all available recent entries have been accessed.
      final bool isFinished = recentEntries.items.length < state.recentEntriesLimit;

      // Calculate offset depending on returned entries.
      // * This if is required. Do not do "joined.items.length" here because that will result in skipping
      // * items that should be accessed.
      final int offset = recentEntries.items.isEmpty ? state.recentEntriesOffset : state.recentEntriesOffset + state.recentEntriesLimit;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        recentEntriesOffset: offset,
        recentEntries: joined,
        modelEntries: joinedModelEntries,
        isFinished: isFinished,
        calledFrom: 'loadMoreSharedRecentEntries()',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> loadMoreSharedRecentEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        failure: failure,
        status: MainScreenStatus.failure,
        calledFrom: 'loadMoreSharedRecentEntries()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> loadMoreSharedRecentEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        moreContentIsLoading: false,
        failure: Failure.failureToLoadEntries(),
        status: MainScreenStatus.failure,
        calledFrom: 'loadMoreSharedRecentEntries()',
      ));
    }
  }

  /// This method can be used to reset shared recent entries.
  Future<void> reloadSharedRecentEntries() async {
    try {
      // Retrigger getting recent entries.
      final Map<String, dynamic> entriesAndModelEntries = await _localStorageCubit.getSelfSharedRecentEntries(
        offset: 0,
        limit: state.recentEntriesLimit,
      );

      // Access Data.
      final Entries recentEntries = entriesAndModelEntries['entries'];
      final ModelEntries modelEntries = entriesAndModelEntries['model_entries'];

      // Joined ModelEntries.
      final ModelEntries joinedModelEntries = await state.modelEntries.addUniqueModelEntries(
        modelEntries: modelEntries,
      );

      // Get indication if all available recent entries have been accessed.
      final bool isFinished = recentEntries.items.length < state.recentEntriesLimit;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit done state.
      emit(state.copyWith(
        recentEntriesOffset: recentEntries.items.length,
        recentEntries: recentEntries,
        modelEntries: joinedModelEntries,
        isFinished: isFinished,
        status: MainScreenStatus.waiting,
        calledFrom: 'reloadSharedRecentEntries()',
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('MainScreenCubit --> reloadSharedRecentEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        recentEntriesOffset: 0,
        status: MainScreenStatus.failure,
        calledFrom: 'reloadSharedRecentEntries()',
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('MainScreenCubit --> reloadSharedRecentEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.failureToLoadEntries(),
        recentEntriesOffset: 0,
        status: MainScreenStatus.failure,
        calledFrom: 'reloadSharedRecentEntries()',
      ));
    }
  }

  // #############################
  // ModelEntry update cascade
  // #############################

  /// This method gets triggerd if user created a ModelEntry.
  Future<void> onModelEntryCreated({required ModelEntry modelEntry}) async {
    // Create updated modelEntries.
    final ModelEntries modelEntries = state.modelEntries.put(modelEntry: modelEntry);

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      modelEntries: modelEntries,
      calledFrom: 'onModelEntryCreated()',
    ));
  }

  /// This method gets triggerd if user edited a ModelEntry.
  Future<void> onModelEntryEdited({required ModelEntry modelEntry}) async {
    // Create updated modelEntries.
    final ModelEntries modelEntries = state.modelEntries.put(modelEntry: modelEntry);

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      modelEntries: modelEntries,
      calledFrom: 'onModelEntryEdited()',
    ));
  }

  /// This method gets triggered if user deleted an entry from local storage.
  Future<void> onModelEntryDeleted({required String modelEntryId}) async {
    // Remove entry from state.
    final ModelEntries modelEntries = state.modelEntries.remove(
      modelEntryId: modelEntryId,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove entry from state.
    emit(state.copyWith(
      modelEntries: modelEntries,
      calledFrom: 'onModelEntryDeleted()',
    ));
  }

  // #############################
  // Entry update cascade
  // #############################

  /// This method gets triggered if user created an entry.
  Future<void> onEntryCreated({required Entry entry, required ModelEntry modelEntry, required Group fromGroup}) async {
    // Helper indications.
    final bool excludeEntry = _localStorageCubit.state.showProtectedEntries == false;

    // In case protected entries should NOT be displayed and created entry is in a protected group, exclude it from state.
    if (excludeEntry && fromGroup.isProtected) return;

    // Create updated entries.
    final Entries recentEntries = Entries(
      items: [entry, ...state.recentEntries.items],
    );

    // Create updated modelEntries.
    final ModelEntries modelEntries = state.modelEntries.put(modelEntry: modelEntry);

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      recentEntries: recentEntries,
      modelEntries: modelEntries,
      calledFrom: 'onEntryCreated()',
    ));
  }

  /// This method gets triggered if user edited an entry.
  Future<void> onEntryEdited({required Entry editedEntry}) async {
    // Create updated entries.
    final Entries? recentEntries = state.recentEntries.update(
      updatedEntry: editedEntry,
    );

    // Only emit state if cubit is open.
    if (isClosed || recentEntries == null) return;

    // Update state entries.
    emit(state.copyWith(
      recentEntries: recentEntries,
      calledFrom: 'onEntryEdited()',
    ));
  }

  /// This method gets triggered if user deleted an entry from local storage.
  Future<void> onEntryDeleted({required String entryId}) async {
    // Remove entry from state.
    final Entries recentEntries = state.recentEntries.remove(
      entryId: entryId,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove entry from state.
    emit(state.copyWith(
      recentEntries: recentEntries,
      calledFrom: 'onEntryDeleted()',
    ));
  }

  /// This method gets triggered if user interacted with an entry.
  /// * The entry will be added to main screen recent entries without checking the ```isProtected``` property if ```fromGroup``` is set to ```null```.
  Future<void> onEntryInteracted({required Entry entry, required ModelEntry modelEntry, required Group? fromGroup}) async {
    // Helper indications.
    final bool excludeEntry = _localStorageCubit.state.showProtectedEntries == false;

    // In case protected entries should NOT be displayed and interacted entry is in a protected group, exclude
    // it from state.
    // * Only check this if a fromGroup is supplied.
    if (fromGroup != null) {
      if (excludeEntry && fromGroup.isProtected) return;
    }

    // Init Object.
    Entries recentEntries = Entries.initial();

    // Check if this entry exists in state.
    final Entry? exists = await state.recentEntries.getEntryById(entryId: entry.entryId);

    // Entry does not exist.
    if (exists == null) recentEntries = Entries(items: [entry, ...state.recentEntries.items]);

    // Entry exists.
    if (exists != null) {
      // Create removed entries.
      final Entries removed = state.recentEntries.remove(entryId: entry.entryId);

      // Add updated entries.
      recentEntries = Entries(items: [entry, ...removed.items]);
    }

    // Update model entries.
    final ModelEntries modelEntries = state.modelEntries.put(modelEntry: modelEntry);

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Revert state.
    emit(state.copyWith(
      modelEntries: modelEntries,
      recentEntries: recentEntries,
      calledFrom: 'onEntryInteracted()',
    ));
  }

  // #############################
  // Local Group update cascade
  // #############################

  /// This method gets triggered if user created a top level group.
  Future<void> onGroupCreated({required Group group}) async {
    // Create updated entries.
    final Groups groups = state.groups.add(
      group: group,
    );

    // * Add protected group id to state if a protected group got created.
    final List<String> protectedGroupIds = group.isProtected ? [group.groupId, ...state.protectedGroupIds] : state.protectedGroupIds;

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      groups: groups.sortAtoZ,
      protectedGroupIds: protectedGroupIds,
      calledFrom: 'onGroupCreated()',
    ));
  }

  /// This method gets triggerd if user edited a local group.
  Future<void> onLocalGroupEdited({required Group group}) async {
    // Create updated groups.
    final Groups? groups = state.groups.update(
      updatedGroup: group,
    );

    // *  Check if id is already in state to avoid duplicates.
    final bool isDuplicate = state.protectedGroupIds.contains(group.groupId);

    // * Add protected group id to state if a protected group got created and is not a duplicate.
    final List<String> protectedGroupIds = group.isProtected && isDuplicate == false ? [group.groupId, ...state.protectedGroupIds] : state.protectedGroupIds;

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      groups: groups?.sortAtoZ,
      protectedGroupIds: protectedGroupIds,
      calledFrom: 'onLocalGroupEdited()',
    ));
  }

  /// This method gets triggered if user deleted a group from local storage.
  Future<void> onLocalGroupDeleted({required Group group}) async {
    // Remove entry from state.
    final Groups groups = state.groups.remove(
      groupId: group.groupId,
    );

    // Clone the list to avoid modifying the original list.
    final List<String> protectedGroupIds = List.from(state.protectedGroupIds);

    // Remove the specific groupId.
    protectedGroupIds.remove(group.groupId);

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove entry from state.
    emit(state.copyWith(
      groups: groups.sortAtoZ,
      protectedGroupIds: protectedGroupIds,
      calledFrom: 'onGroupDeleted()',
    ));
  }

  // #############################
  // Shared Group update cascade
  // #############################

  /// This method gets triggerd if a user deleted a shared group.
  Future<void> onSharedGroupDeleted({required Group group}) async {
    // Remove entry from state.
    final Groups groups = state.groups.remove(
      groupId: group.groupId,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove group from state.
    emit(state.copyWith(
      groups: groups.sortAtoZ,
      recentEntries: Entries.initial(),
      failure: Failure.initial(),
      status: MainScreenStatus.reloadRecentEntries,
      calledFrom: 'onSharedGroupDeleted',
    ));
  }

  /// This method gets triggerd if a user deleted a shared subgroup.
  Future<void> onSharedSubgroupDeleted({required Group subgroup}) async {
    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove group from state.
    emit(state.copyWith(
      recentEntries: Entries.initial(),
      failure: Failure.initial(),
      status: MainScreenStatus.reloadRecentEntries,
      calledFrom: 'onSharedSubgroupDeleted',
    ));
  }

  /// This method gets triggered if user edited a shared top level group.
  Future<void> onSharedGroupEdited({required Group group}) async {
    // Create updated groups.
    final Groups? groups = state.groups.update(
      updatedGroup: group,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      groups: groups?.sortAtoZ,
      calledFrom: 'onSharedGroupEdited()',
    ));
  }

  /// This method gets triggerd if a user leaves a shared group
  Future<void> onLeftSharedGroup({required Group group}) async {
    // Remove entry from state.
    final Groups groups = state.groups.remove(
      groupId: group.groupId,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove group from state.
    emit(state.copyWith(
      groups: groups.sortAtoZ,
      recentEntries: Entries.initial(),
      failure: Failure.initial(),
      status: MainScreenStatus.reloadRecentEntries,
      calledFrom: 'onLeftSharedGroup',
    ));
  }
}
