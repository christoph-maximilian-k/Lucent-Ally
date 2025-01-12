import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_durations.dart';
import '/config/country_specification.dart';

// User and Settings.
import '/main.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/widgets/modal_bottom_sheets/list_selector_sheet/cubit/list_selector_sheet_cubit.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/settings/settings.dart';
import '/data/models/labels/labels.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/users/user.dart';
import '/data/models/secrets/secrets.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/list_selector_sheet/list_selector_sheet.dart';

part 'settings_sheet_state.dart';

class SettingsSheetCubit extends Cubit<SettingsSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;

  SettingsSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        super(SettingsSheetState.initial());

  // ########################
  // Initialization
  // ########################

  /// Initialize state.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Initialize state data.
      emit(state.copyWith(
        initialUser: user,
        user: user,
        status: SettingsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> initialize() --> failure --> ${failure.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        pageFailure: failure,
        status: SettingsSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> initialize() --> exception --> ${exception.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: SettingsSheetStatus.pageHasError,
      ));
    }
  }

  // ########################
  // State
  // ########################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open and not loading.
    if (isClosed || state.status == SettingsSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: SettingsSheetStatus.waiting,
    ));
  }

  /// This method can be used to close add images sheet with a confirm message.
  Future<void> confirmCloseSheet({required BuildContext context}) async {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == SettingsSheetStatus.loading) return;

    // Check if changes were made.
    final bool editsMade = state.initialUser != state.user;

    // * Check if user has unsaved data.
    final bool? confirm = editsMade
        ? await showModalBottomSheet(
            context: context,
            // * This sheet returns either true or null.
            builder: (context) => ConfirmSheet(
              title: labels.basicLabelsUnsavedChanges(),
            ),
          )
        : true;

    // Only emit new state if user confirmed, cubit is still open and cubit is not loading.
    if (confirm == null || isClosed) return;

    // In case something changed, revert to initial.
    // * This is needed because some methods update the whole app UI and if user
    // * in the end decides they dont want that it should be reverted to initial.
    if (editsMade) {
      // * Notify local storage cubit because it is responsible for rebuilding global UI.
      _localStorageCubit.emit(_localStorageCubit.state.copyWith(
        user: state.initialUser,
        calledFrom: 'SettingsSheetCubit --> revertSettings()',
      ));
    }

    emit(state.copyWith(
      failure: Failure.initial(),
      status: SettingsSheetStatus.close,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: SettingsSheetStatus.close,
    ));
  }

  // ########################
  // Settings
  // ########################

  /// This method can be used to update auto logout duration.
  Future<void> changeNotificationDuration({required BuildContext context}) async {
    try {
      // Access initialItem.
      int initialItem = Settings.notificationDurationsInSeconds.indexOf(
        state.user.settings.notificationDurationInSeconds,
      );

      // Access default value if index was not found.
      if (initialItem == -1) initialItem = Settings.initial().notificationDurationInSeconds;

      // Create PickerItems.
      final PickerItems pickerItems = Settings.notificationDurationsPickerItems(labels: labels);

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          initialItem: initialItem,
          pickerItems: pickerItems,
        ),
      );

      // User did not pick an item.
      if (pickedIndex == null) return;

      // Access chosen minutes.
      final int? notificationDurationInSeconds = int.tryParse(pickerItems.items[pickedIndex].id);

      // * In case of error, return. In theory this should never happen.
      if (notificationDurationInSeconds == null) throw Failure.failedToUpdateSettings();

      // Create updated Settings.
      final Settings updatedSettings = state.user.settings.copyWith(
        notificationDurationInSeconds: notificationDurationInSeconds,
      );

      // Update user.
      final User updatedUser = state.user.copyWith(
        settings: updatedSettings,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        user: updatedUser,
        failure: Failure.initial(),
        status: SettingsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeNotificationDuration() --> failure --> ${failure.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        failure: failure,
        status: SettingsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeNotificationDuration() --> exception --> ${exception.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SettingsSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to change default currency used in the app.
  Future<void> changeDefaultCurrency({required BuildContext context}) async {
    try {
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

      // User closed sheet.
      if (countrySpecification == null) return;

      // Create updated Settings.
      final Settings updatedSettings = state.user.settings.copyWith(
        defaultCurrency: countrySpecification.currencyCode,
      );

      // Update user.
      final User updatedUser = state.user.copyWith(
        settings: updatedSettings,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        user: updatedUser,
        failure: Failure.initial(),
        status: SettingsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeDefaultCurrency() --> failure --> ${failure.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        failure: failure,
        status: SettingsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeDefaultCurrency() --> exception --> ${exception.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SettingsSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to update max lines of text fields.
  Future<void> changeMaxLines({required BuildContext context}) async {
    try {
      // Access initialIndex.
      int initialIndex = Settings.maxLines.indexOf(
        state.user.settings.maxLinesForTextFields,
      );

      // Access default value if index was not found.
      if (initialIndex == -1) initialIndex = Settings.initial().maxLinesForTextFields;

      // Create PickerItems.
      final PickerItems pickerItems = Settings.maxLinesPickerItems(labels: labels);

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          initialItem: initialIndex,
          pickerItems: pickerItems,
        ),
      );

      // User did not pick an item.
      if (pickedIndex == null || pickedIndex == initialIndex) return;

      // Access chosen lines.
      final int? chosenLines = int.tryParse(pickerItems.items[pickedIndex].id);

      // * In case of error, return. In theory this should never happen.
      if (chosenLines == null) throw Failure.failedToUpdateSettings();

      // Create updated Settings.
      final Settings updatedSettings = state.user.settings.copyWith(
        maxLinesForTextFields: chosenLines,
      );

      // Update user.
      final User updatedUser = state.user.copyWith(
        settings: updatedSettings,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        user: updatedUser,
        failure: Failure.initial(),
        status: SettingsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeMaxLines() --> failure --> ${failure.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        failure: failure,
        status: SettingsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeMaxLines() --> exception --> ${exception.toString()}');

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit default.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SettingsSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to update the app language.
  Future<void> changeLanguage({required BuildContext context}) async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Access initialItem.
      int initialIndex = User.supportedLanguages.indexOf(
        state.user.languageLocale,
      );

      // Set to first item if language was not found.
      // * This only happens if a mistake is made, so never. :)
      if (initialIndex == -1) initialIndex = 0;

      // Create PickerItems.
      final PickerItems pickerItems = User.supportedLanguagesPickerItems(labels: labels);

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          initialItem: initialIndex,
          pickerItems: pickerItems,
        ),
      );

      // User did not pick an item.
      if (pickedIndex == null || pickedIndex == initialIndex) return;

      // Access chosen minutes.
      final String chosenLanguageLocale = pickerItems.items[pickedIndex].id;

      // Create updated user settings.
      final User updatedUser = state.user.copyWith(
        languageLocale: chosenLanguageLocale,
        labels: Labels(languageLocale: chosenLanguageLocale),
      );

      // * Notify local storage cubit because it is responsible for rebuilding global UI.
      _localStorageCubit.emit(_localStorageCubit.state.copyWith(
        user: updatedUser,
        calledFrom: 'SettingsSheetCubit --> changeLanguage()',
      ));

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        user: updatedUser,
        failure: Failure.initial(),
        status: SettingsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeLanguage() --> failure --> ${failure.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: SettingsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeLanguage() --> exception --> ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.failedToUpdateSettings(),
        status: SettingsSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to update auto logout duration.
  Future<void> changeAutoLogout({required BuildContext context}) async {
    try {
      // Access initialItem.
      int initialItem = User.autoLogoutsInMinutes.indexOf(
        state.user.autoLogoutInMinutes,
      );

      // Access default value if index was not found.
      if (initialItem == -1) initialItem = User.initial().autoLogoutInMinutes;

      // Create PickerItems.
      final PickerItems pickerItems = User.autoLogoutPickerItems(labels: labels);

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => PickerSheet(
          initialItem: initialItem,
          pickerItems: pickerItems,
        ),
      );

      // User did not pick an item.
      if (pickedIndex == null) return;

      // Access chosen minutes.
      final int? autoLogoutInMinutes = int.tryParse(pickerItems.items[pickedIndex].id);

      // * In case of error, return. In theory this should never happen.
      if (autoLogoutInMinutes == null) throw Failure.failedToUpdateSettings();

      // Create updated user settings.
      final User updatedUser = state.user.copyWith(
        autoLogoutInMinutes: autoLogoutInMinutes,
      );

      // * Notify local storage cubit because it is responsible for rebuilding global UI.
      _localStorageCubit.emit(_localStorageCubit.state.copyWith(
        user: updatedUser,
        calledFrom: 'SettingsSheetCubit --> changeAutoLogout()',
      ));

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        user: updatedUser,
        failure: Failure.initial(),
        status: SettingsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeAutoLogout() --> failure --> ${failure.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: SettingsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeAutoLogout() --> exception --> ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.failedToUpdateSettings(),
        status: SettingsSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to change the current theme.
  Future<void> changeTheme({required String theme}) async {
    try {
      // Do nothing if theme is already selected.
      if (theme == state.user.theme) return;

      // Create updated user settings.
      final User updatedUser = state.user.copyWith(
        theme: theme == User.themeDark ? User.themeDark : User.themeLight,
      );

      // * Notify local storage cubit because it is responsible for rebuilding global UI.
      _localStorageCubit.emit(_localStorageCubit.state.copyWith(
        user: updatedUser,
        calledFrom: 'SettingsSheetCubit --> changeTheme()',
      ));

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        user: updatedUser,
        failure: Failure.initial(),
        status: SettingsSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeTheme() --> failure --> ${failure.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: SettingsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> changeTheme() --> exception --> ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.failedToUpdateSettings(),
        status: SettingsSheetStatus.failure,
      ));
    }
  }

  // ########################
  // Database
  // ########################

  /// This method can be used to save settings.
  Future<void> saveSettings() async {
    try {
      // Only do database update if settings were edited.
      if (state.user == state.initialUser) throw Failure.nothingWasEdited();

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: SettingsSheetStatus.loading,
      ));

      // Check if SharedPrefs have to be updated.
      final bool languageChanged = state.initialUser.languageLocale != state.user.languageLocale;
      final bool themeChanged = state.initialUser.theme != state.user.theme;
      final bool autoLogoutChanged = state.initialUser.autoLogoutInMinutes != state.user.autoLogoutInMinutes;

      // Update language.
      if (languageChanged) await _localStorageCubit.putValueToSharedPreferences(key: Secrets.mapKeyLanguageLocale, value: state.user.languageLocale);

      // Update theme.
      if (themeChanged) await _localStorageCubit.putValueToSharedPreferences(key: Secrets.mapKeyAppTheme, value: state.user.theme);

      // Update auto logout.
      if (autoLogoutChanged) await _localStorageCubit.putValueToSharedPreferences(key: Secrets.mapKeyAutoLogoutInMinutes, value: state.user.autoLogoutInMinutes);

      // Put settings into store.
      await _localStorageCubit.state.database!.writeTxn(() async {
        await _localStorageCubit.updateLocalUser(
          updatedUser: state.user,
        );
      });

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: state.user.labels.basicLabelsSettingsSaved(),
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      // Emit close event.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: SettingsSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> saveSettings() --> failure --> ${failure.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: SettingsSheetStatus.failure,
      ));
    } catch (exception) {
      // Output error messages.
      debugPrint('SettingsSheetCubit --> saveSettings() --> exception --> ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.failedToUpdateSettings(),
        status: SettingsSheetStatus.failure,
      ));
    }
  }
}
