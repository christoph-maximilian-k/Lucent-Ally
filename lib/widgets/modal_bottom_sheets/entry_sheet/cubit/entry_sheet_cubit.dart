import 'dart:async';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

// Config.
import '/config/app_durations.dart';
import '/config/app_icons.dart';
import '/config/country_specification.dart';

// Labels.
import '/main.dart';

// Repositories.
import '/data/repositories/location/location_repository.dart';
import '/data/repositories/files/file_repository.dart';

// Widgets.
import '/widgets/modal_bottom_sheets/date_selector/date_selector.dart';

// Logic.
import '/logic/helper_functions/helper_functions.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/widgets/modal_bottom_sheets/list_selector_sheet/cubit/list_selector_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/password_generator_sheet/cubit/password_generator_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/add_files_sheet/cubit/add_files_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/add_file_details_sheet/cubit/add_file_details_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/add_emotion_sheet/cubit/add_emotion_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/menu_sheet/cubit/menu_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/widgets/modal_bottom_sheets/import_data_sheet/cubit/import_data_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/provide_exchange_rates_sheet/cubit/provide_exchange_rates_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/view_entries_sheet/cubit/view_entries_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/create_default_exchange_rate_sheet/cubit/create_default_exchange_rate_cubit.dart';

// Models.
import '/data/models/field_types/date_data/date_data.dart';
import '/data/models/field_types/date_and_time_data/date_and_time_data.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/time_data/time_data.dart';
import '/data/models/field_types/payment_data/share_reference.dart';
import '/data/models/field_types/payment_data/share_references.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';
import '/data/models/entries/entry.dart';
import '/data/models/fields/fields.dart';
import '/data/models/fields/field.dart';
import '/data/models/files/file_item.dart';
import '/data/models/field_types/image_data/image_data.dart';
import '/data/models/files/files.dart';
import '/data/models/tags/tag.dart';
import '/data/models/tags/tags.dart';
import '/data/models/members/member.dart';
import '/data/models/members/members.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/emotion_data/emotion_item.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/model_entry_prefs/model_entry_prefs.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/phone_data/phone_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/password_data/password_data.dart';
import '/data/models/field_types/text_data/text_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/field_types/website_data/website_data.dart';
import '/data/models/import_specifications/import_specifications.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/exchange_rates/exchange_rates.dart';
import '/data/models/field_types/file_data/file_data.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/list_selector_sheet/list_selector_sheet.dart';
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/password_generator_sheet/password_generator_sheet.dart';
import '/widgets/modal_bottom_sheets/add_files_sheet/add_files_sheet.dart';
import '/widgets/modal_bottom_sheets/add_file_details_sheet/add_file_details_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/add_emotion_sheet/add_emotion_sheet.dart';
import '/widgets/modal_bottom_sheets/select_option_sheet/select_option_sheet.dart';
import '/widgets/modal_bottom_sheets/text_field_sheet/text_field_sheet.dart';
import '/widgets/modal_bottom_sheets/create_default_exchange_rate_sheet/create_default_exchange_rate_sheet.dart';
import '/widgets/modal_bottom_sheets/time_selector/time_selector.dart';

// Screens.
import '/screens/main/cubit/main_screen_cubit.dart';

part 'entry_sheet_state.dart';

class EntrySheetCubit extends Cubit<EntrySheetState> with HelperFunctions {
  final LocationRepository _locationRepository;
  final LocalNotificationCubit _localNotificationsCubit;
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final MenuSheetCubit? _menuSheetCubit;
  final EntrySelectedSheetCubit? _entrySelectedSheetCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final ViewEntriesSheetCubit? _viewEntriesSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;
  final ImportDataSheetCubit? _importDataSheetCubit;
  final ProvideExchangeRatesSheetCubit? _provideExchangeRatesSheetCubit;

  EntrySheetCubit({
    required LocationRepository locationRepository,
    required LocalNotificationCubit localNotificationsCubit,
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    MenuSheetCubit? menuSheetCubit,
    EntrySelectedSheetCubit? entrySelectedSheetCubit,
    LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    ViewEntriesSheetCubit? viewEntriesSheetCubit,
    SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
    ImportDataSheetCubit? importDataSheetCubit,
    ProvideExchangeRatesSheetCubit? provideExchangeRatesSheetCubit,
  })  : _locationRepository = locationRepository,
        _localNotificationsCubit = localNotificationsCubit,
        _localStorageCubit = localStorageCubit,
        _mainScreenCubit = mainScreenCubit,
        _appMessagesCubit = appMessagesCubit,
        _menuSheetCubit = menuSheetCubit,
        _entrySelectedSheetCubit = entrySelectedSheetCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _viewEntriesSheetCubit = viewEntriesSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        _importDataSheetCubit = importDataSheetCubit,
        _provideExchangeRatesSheetCubit = provideExchangeRatesSheetCubit,
        super(EntrySheetState.initial());

  // ############################################
  // # Initialization entry mode
  // ############################################

  /// Initialize state data for creating a local new entry.
  Future<void> initializeLocalCreate({required ModelEntry modelEntry, required Group fromGroup}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init local notifications cubit.
      await _localNotificationsCubit.initializeWithoutInitialData();

      // Access the most likely country code.
      // * "" is returned if no meaningful assumption can be made.
      final String isoCountryCode = await _localStorageCubit.getAssumedDefaultIsoCountryCode();

      // Access current user timezone.
      final String currentTimeZone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Create initial entry.
      final Entry entry = modelEntry.initEntryModeEntry(
        isShared: false,
        isoCountryCode: isoCountryCode,
        participantReference: fromGroup.participantReference,
        defaultCurrencyCode: fromGroup.defaultCurrencyCode,
        currentTimezone: currentTimeZone,
        entryCreator: user.userId,
        existingEntry: null,
      );

      // * Initialize members where it is required.
      final Entry initializedEntry = await initializePaymentMembers(
        entry: entry,
        isShared: false,
        fromGroup: fromGroup,
        isImportMatch: false,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        initialEntry: initializedEntry,
        entry: initializedEntry,
        entryModel: modelEntry,
        isEdit: false,
        fromGroup: fromGroup,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeLocalCreate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeLocalCreate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data for creating a shared new entry.
  Future<void> initializeSharedCreate({required ModelEntry modelEntry, required Group fromGroup}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init local notifications cubit.
      await _localNotificationsCubit.initializeWithoutInitialData();

      // Access the most likely country code.
      // * "" is returned if no meaningful assumption can be made.
      final String isoCountryCode = await _localStorageCubit.getAssumedDefaultIsoCountryCode();

      // Access current user timezone.
      final String currentTimeZone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Create initial entry.
      final Entry entry = modelEntry.initEntryModeEntry(
        isShared: true,
        isoCountryCode: isoCountryCode,
        participantReference: fromGroup.participantReference,
        defaultCurrencyCode: fromGroup.defaultCurrencyCode,
        currentTimezone: currentTimeZone,
        entryCreator: user.userId,
        existingEntry: null,
      );

      // * Initialize members where it is required.
      final Entry initializedEntry = await initializePaymentMembers(
        entry: entry,
        isShared: true,
        fromGroup: fromGroup,
        isImportMatch: false,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        initialEntry: initializedEntry,
        entry: initializedEntry,
        entryModel: modelEntry,
        isEdit: false,
        fromGroup: fromGroup,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSharedCreate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSharedCreate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data for editing a local entry.
  Future<void> initializeLocalEdit({required ModelEntry modelEntry, required Group fromGroup}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init local notifications cubit.
      await _localNotificationsCubit.initializeWithoutInitialData();

      // Access entry.
      final Entry entry = _entrySelectedSheetCubit!.state.entry;

      // Access the most likely country code.
      // * "" is returned if no meaningful assumption can be made.
      final String isoCountryCode = await _localStorageCubit.getAssumedDefaultIsoCountryCode();

      // Access current user timezone.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Create state entry.
      final Entry stateEntry = modelEntry.initEntryModeEntry(
        isShared: false,
        isoCountryCode: isoCountryCode,
        participantReference: fromGroup.participantReference,
        defaultCurrencyCode: fromGroup.defaultCurrencyCode,
        currentTimezone: currentTimezone,
        entryCreator: null,
        existingEntry: entry,
      );

      // * Initialize members where it is required.
      final Entry initializedEntry = await initializePaymentMembers(
        entry: stateEntry,
        isShared: false,
        fromGroup: fromGroup,
        isImportMatch: false,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        initialEntry: initializedEntry,
        entry: initializedEntry,
        entryModel: modelEntry,
        isEdit: true,
        fromGroup: fromGroup,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeEdit() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeEdit() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data for editing a shared entry.
  Future<void> initializeSharedEdit({required ModelEntry modelEntry, required Group fromGroup}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init local notifications cubit.
      await _localNotificationsCubit.initializeWithoutInitialData();

      // Access entry.
      final Entry entry = _entrySelectedSheetCubit!.state.entry;

      // Access the most likely country code.
      // * "" is returned if no meaningful assumption can be made.
      final String isoCountryCode = await _localStorageCubit.getAssumedDefaultIsoCountryCode();

      // Access current user timezone.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Create state entry.
      final Entry stateEntry = modelEntry.initEntryModeEntry(
        isShared: true,
        isoCountryCode: isoCountryCode,
        participantReference: fromGroup.participantReference,
        defaultCurrencyCode: fromGroup.defaultCurrencyCode,
        currentTimezone: currentTimezone,
        entryCreator: null,
        existingEntry: entry,
      );

      // * Initialize members where it is required.
      final Entry initializedEntry = await initializePaymentMembers(
        entry: stateEntry,
        isShared: true,
        fromGroup: fromGroup,
        isImportMatch: false,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: true,
        isEdit: true,
        initialEntry: initializedEntry,
        entry: initializedEntry,
        entryModel: modelEntry,
        fromGroup: fromGroup,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSharedEdit() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSharedEdit() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # Initialization set exchange rate mode
  // ############################################

  /// Initialize state data for editing invalid exchange rates in local mode.
  Future<void> initializeLocalSetExchangeRate({required Group fromGroup, required Entry entry}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access model entry of entry.
      final ModelEntry? modelEntry = await _localStorageCubit.getLocalModelEntryById(
        modelEntryId: entry.modelEntryReference,
        shouldAccessPrefs: true,
      );

      // In case model entry was not found, throw failure.
      if (modelEntry == null) throw Failure.modelEntryNotFound();

      // Init local notifications cubit.
      await _localNotificationsCubit.initializeWithoutInitialData();

      // Access the most likely country code.
      // * "" is returned if no meaningful assumption can be made.
      final String isoCountryCode = await _localStorageCubit.getAssumedDefaultIsoCountryCode();

      // Access current user timezone.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Create state entry.
      final Entry stateEntry = modelEntry.initEntryModeEntry(
        isShared: false,
        isoCountryCode: isoCountryCode,
        participantReference: fromGroup.participantReference,
        defaultCurrencyCode: fromGroup.defaultCurrencyCode,
        currentTimezone: currentTimezone,
        entryCreator: null,
        existingEntry: entry,
      );

      // * Initialize members where it is required.
      final Entry initializedEntry = await initializePaymentMembers(
        entry: stateEntry,
        isShared: false,
        fromGroup: fromGroup,
        isImportMatch: false,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: true,
        isSetExchangeRate: true,
        initialEntry: initializedEntry,
        entry: initializedEntry,
        entryModel: modelEntry,
        fromGroup: fromGroup,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeLocalSetExchangeRate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeLocalSetExchangeRate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data for editing invalid exchange rates in local mode.
  Future<void> initializeSharedSetExchangeRate({required Group fromGroup, required Entry entry}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSharedSetExchangeRate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSharedSetExchangeRate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # Initialization set default mode
  // ############################################

  /// Initialize state data for setting a default entry.
  Future<void> initializeSetDefault({required ModelEntry modelEntry, required bool isShared, required bool isEdit, required bool isSelfDefault}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Create initial entry.
      final Entry initialEntry = modelEntry.initDefaultModeEntry(
        defaultCurrencyCode: '',
        participantReference: '',
        isSelfDefault: isSelfDefault,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isDefault: true,
        isShared: isShared,
        isEdit: isEdit,
        isSelfDefault: isSelfDefault,
        initialEntry: initialEntry,
        entry: initialEntry,
        entryModel: modelEntry,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeCreateDefault() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeCreateDefault() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # Initialization set import mode
  // ############################################

  /// Initialize state data for setting a import match entry.
  Future<void> initializeSetImportMatch({required ModelEntry modelEntry, required bool isEdit, required Group fromGroup, required List<List<dynamic>> csvTable}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init local notifications cubit.
      await _localNotificationsCubit.initializeWithoutInitialData();

      // Initialize import specifications.
      final ModelEntry updatedModelEntry = modelEntry.copyWith(
        importSpecifications: modelEntry.importSpecifications ?? ImportSpecifications.initial(),
      );

      // Access current user timezone.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Create initial entry.
      final Entry entry = updatedModelEntry.initImportMatchModeEntry(
        participantReference: fromGroup.participantReference,
        currentTimezone: currentTimezone,
      );

      // * Initialize members where it is required.
      final Entry initializedEntry = await initializePaymentMembers(
        entry: entry,
        isShared: false,
        fromGroup: fromGroup,
        isImportMatch: true,
      );

      // Access csv header as picker items.
      final PickerItems pickerItemsCsvHeaders = await PickerItems.pickerItemsFromCSV(csvTable: csvTable);

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        isEdit: isEdit,
        isImportMatch: true,
        initialEntry: initializedEntry,
        entry: initializedEntry,
        entryModel: updatedModelEntry,
        fromGroup: fromGroup,
        csvTable: csvTable,
        pickerItemsCsvHeaders: pickerItemsCsvHeaders,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSetImportMatch() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: EntrySheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> initializeSetImportMatch() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: EntrySheetStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method can be used to load images from file system.
  Future<FileItem?> loadFileItem({required FileItem? fileItem}) async {
    return await _localStorageCubit.loadLocalFileItem(fromGroup: state.fromGroup, fileItem: fileItem);
  }

  /// This method can be used to load tags into state.
  Future<Tags?> loadReferencedTags({required TagsData tagsData, required Field field}) async {
    // * User is in shared mode, return shared tags.
    if (state.isShared) {
      return await _localStorageCubit.loadReferencedSharedTags(
        field: field,
        tagsData: tagsData,
      );
    }

    // * User is in local mode return local tags.
    return await _localStorageCubit.loadReferencedLocalTags(
      field: field,
      tagsData: tagsData,
    );
  }

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to confirm close sheet.
  Future<void> confirmCloseSheet({required BuildContext context}) async {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == EntrySheetStatus.loading) return;

    // * Sanitize fields of entry.
    final Fields entryFields = state.entry.fields.sanitizeFields(isDefault: state.isDefault, isImport: state.isImportMatch);

    // Create compareable entry.
    final Entry finalEntry = state.entry.copyWith(
      fields: entryFields,
    );

    // * Check if user has unsaved data.
    final bool? confirm = finalEntry.isEqualTo(entry: state.initialEntry, isDefault: state.isDefault, isImport: state.isImportMatch) == false
        ? await showModalBottomSheet(
            context: context,
            builder: (context) => ConfirmSheet(
              title: state.isEdit ? labels.entrySheetCubitConfirmCloseEdit() : labels.entrySheetCubitConfirmClose(),
            ),
          )
        : true;

    // Only emit new state if user confirmed, cubit is still open and cubit is not loading.
    if (confirm == null || isClosed || state.status == EntrySheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntrySheetStatus.close,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == EntrySheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntrySheetStatus.close,
    ));
  }

  /// This method can be used to let user choose a timezone.
  Future<void> chooseTimeZone({required BuildContext context, required String initialTimezone, required Field? field}) async {
    try {
      // Access time zones as picker items.
      final PickerItems timezones = _localStorageCubit.state.timezones;

      // Access initial item.
      final int initialItem = timezones.items.indexWhere(
        (element) => element.id == initialTimezone,
      );

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.basicLabelsTimezones(),
          pickerItems: timezones,
          initialItem: initialItem == -1 ? 0 : initialItem,
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Set helper.
      final String pickedZone = timezones.items[pickedIndex].id;

      // * Method was triggerd in conext of entry created at.
      if (field == null) {
        // Change the timezone.
        final tz.TZDateTime changed = HelperFunctions.changeTimezone(
          dateTimeInUtc: state.entry.createdAtInUtc,
          originalTimezone: state.entry.createdAtTimeZone,
          newTimezone: pickedZone,
        );

        // Update the state entry.
        final Entry updatedEntry = state.entry.copyWith(
          createdAtInUtc: changed.toUtc(),
          createdAtTimeZone: pickedZone,
        );

        // Only emit new states if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          entry: updatedEntry,
        ));

        return;
      }

      // Init field.
      late Field updatedField;

      // Update measurement data.
      if (field.getIsMeasurementField) {
        // If no dateTime was set, let user simply change the timezone.
        if (field.measurementData!.createdAtInUtc == null) {
          // Create updated date data.
          final MeasurementData updatedData = field.measurementData!.copyWith(
            createdAtTimezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            measurementData: updatedData,
          );

          // A dateTime was found, convert value.
        } else {
          // Change the timezone.
          final tz.TZDateTime changed = HelperFunctions.changeTimezone(
            dateTimeInUtc: field.measurementData!.createdAtInUtc!,
            originalTimezone: field.measurementData!.createdAtTimezone,
            newTimezone: pickedZone,
          );

          // Create updated measurement data.
          final MeasurementData updatedMeasurementData = field.measurementData!.copyWith(
            createdAtInUtc: changed.toUtc(),
            createdAtTimezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            measurementData: updatedMeasurementData,
          );
        }
      }

      // Update location data.
      if (field.getIsLocationField) {
        // If no dateTime was set, let user simply change the timezone.
        if (field.locationData!.createdAtInUtc == null) {
          // Create updated date data.
          final LocationData updatedData = field.locationData!.copyWith(
            createdAtTimezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            locationData: updatedData,
          );

          // A dateTime was found, convert value.
        } else {
          // Change the timezone.
          final tz.TZDateTime changed = HelperFunctions.changeTimezone(
            dateTimeInUtc: field.locationData!.createdAtInUtc!,
            originalTimezone: field.locationData!.createdAtTimezone,
            newTimezone: pickedZone,
          );

          // Create updated measurement data.
          final LocationData updatedData = field.locationData!.copyWith(
            createdAtInUtc: changed.toUtc(),
            createdAtTimezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            locationData: updatedData,
          );
        }
      }

      // Update money data.
      if (field.getIsMoneyField) {
        // If no dateTime was set, let user simply change the timezone.
        if (field.moneyData!.createdAtInUtc == null) {
          // Create updated date data.
          final MoneyData updatedData = field.moneyData!.copyWith(
            timezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            moneyData: updatedData,
          );

          // A dateTime was found, convert value.
        } else {
          // Change the timezone.
          final tz.TZDateTime changed = HelperFunctions.changeTimezone(
            dateTimeInUtc: field.moneyData!.createdAtInUtc!,
            originalTimezone: field.moneyData!.timezone,
            newTimezone: pickedZone,
          );

          // Create updated money data.
          final MoneyData updatedMoneyData = field.moneyData!.copyWith(
            createdAtInUtc: changed.toUtc(),
            timezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            moneyData: updatedMoneyData,
          );
        }
      }

      // Update payment data.
      if (field.getIsPaymentField) {
        // If no dateTime was set, let user simply change the timezone.
        if (field.paymentData!.paymentDateInUtc == null) {
          // Create updated date data.
          final PaymentData updatedData = field.paymentData!.copyWith(
            paymentDateTimezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            paymentData: updatedData,
          );

          // A dateTime was found, convert value.
        } else {
          // Change the timezone.
          final tz.TZDateTime changed = HelperFunctions.changeTimezone(
            dateTimeInUtc: field.paymentData!.paymentDateInUtc!,
            originalTimezone: field.paymentData!.paymentDateTimezone,
            newTimezone: pickedZone,
          );

          // Create updated payment data.
          final PaymentData updatedPaymentData = field.paymentData!.copyWith(
            paymentDateInUtc: changed.toUtc(),
            paymentDateTimezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            paymentData: updatedPaymentData,
          );
        }
      }

      // Update date data.
      if (field.getIsDateField) {
        // If no dateTime was set, let user simply change the timezone.
        if (field.dateData!.valueInUtc == null) {
          // Create updated date data.
          final DateData updatedDateData = field.dateData!.copyWith(
            timezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            dateData: updatedDateData,
          );

          // A dateTime was found, convert value.
        } else {
          // Change the timezone.
          final tz.TZDateTime changed = HelperFunctions.changeTimezone(
            dateTimeInUtc: field.dateData!.valueInUtc!,
            originalTimezone: field.dateData!.timezone,
            newTimezone: pickedZone,
          );

          // Create updated date data.
          final DateData updatedDateData = field.dateData!.copyWith(
            valueInUtc: changed.toUtc(),
            timezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            dateData: updatedDateData,
          );
        }
      }

      // Update DateAndTime data.
      if (field.getIsDateAndTimeField) {
        // If no dateTime was set, let user simply change the timezone.
        if (field.dateAndTimeData!.valueInUtc == null) {
          // Create updated date data.
          final DateAndTimeData updatedData = field.dateAndTimeData!.copyWith(
            timezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            dateAndTimeData: updatedData,
          );

          // A dateTime was found, convert value.
        } else {
          // Change the timezone.
          final tz.TZDateTime changed = HelperFunctions.changeTimezone(
            dateTimeInUtc: field.dateAndTimeData!.valueInUtc!,
            originalTimezone: field.dateAndTimeData!.timezone,
            newTimezone: pickedZone,
          );

          // Create updated date data.
          final DateAndTimeData updatedData = field.dateAndTimeData!.copyWith(
            valueInUtc: changed.toUtc(),
            timezone: pickedZone,
          );

          // Update field.
          updatedField = field.copyWith(
            dateAndTimeData: updatedData,
          );
        }
      }

      // Update fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update the state entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Add field to model.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> chooseTimeZone() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> chooseTimeZone() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user wants to set a default date of a field.
  Future<void> onChooseDateDefault({required BuildContext context, required String? initialDate, required Field field}) async {
    try {
      // Try and access initial date.
      final DateTime? initialDateTime = HelperFunctions.parseDate(value: initialDate);

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: initialDateTime ?? DateTime.now(),
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Chosen date as String.
      final String asString = DateFormat('yyyy-MM-dd').format(chosenLocalDate);

      // Create updated data.
      final MeasurementData? updatedMeasurementData = field.measurementData?.copyWith(
        createdAtDefaultDate: asString,
      );

      // Create updated data.
      final MoneyData? updatedMoneyData = field.moneyData?.copyWith(
        defaultDate: asString,
      );

      // Create updated data.
      final PaymentData? updatedPaymentData = field.paymentData?.copyWith(
        paymentDateDefaultDate: asString,
      );

      // Create updated data.
      final DateData? updatedDateData = field.dateData?.copyWith(
        valueDefaultDate: asString,
      );

      // Create updated data.
      final DateAndTimeData? updatedDateAndTimeData = field.dateAndTimeData?.copyWith(
        valueDefaultDate: asString,
      );

      // Create updated data.
      final LocationData? updatedLocationData = field.locationData?.copyWith(
        defaultDate: asString,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        measurementData: updatedMeasurementData,
        moneyData: updatedMoneyData,
        paymentData: updatedPaymentData,
        dateData: updatedDateData,
        dateAndTimeData: updatedDateAndTimeData,
        locationData: updatedLocationData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseDateDefault() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseDateDefault() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to set a default time of a field.
  Future<void> onChooseTimeDefault({required BuildContext context, required String? initialTime, required Field field}) async {
    try {
      // Create initial.
      final TimeOfDay? initialTimeOfDay = HelperFunctions.parseTimeOfDay(value: initialTime);

      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTimeOfDay,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Format chosen time as String in 24 hour format.
      final String formattedTime = HelperFunctions.formatTimeOfDayTo24Hour(timeOfDay: chosenTime);

      // Create updated data.
      final MeasurementData? updatedMeasurementData = field.measurementData?.copyWith(
        createdAtDefaultTime: formattedTime,
      );

      // Create updated data.
      final MoneyData? updatedMoneyData = field.moneyData?.copyWith(
        defaultTime: formattedTime,
      );

      // Create updated data.
      final PaymentData? updatedPaymentData = field.paymentData?.copyWith(
        paymentDateDefaultTime: formattedTime,
      );

      // Create updated data.
      final DateAndTimeData? updateDateAndTimeData = field.dateAndTimeData?.copyWith(
        valueDefaultTime: formattedTime,
      );

      // Create updated data.
      final LocationData? updateLocationData = field.locationData?.copyWith(
        defaultTime: formattedTime,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        measurementData: updatedMeasurementData,
        moneyData: updatedMoneyData,
        paymentData: updatedPaymentData,
        dateAndTimeData: updateDateAndTimeData,
        locationData: updateLocationData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseTimeDefault() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseTimeDefault() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Import match
  // ####################################

  /// This method gets invoked if user wants to match a datapoint with a field.
  Future<void> matchDatapointToField({required Field field, required String objectReference, required String? memberId, required BuildContext context}) async {
    try {
      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.basicLabelsDatapoints(),
          pickerItems: state.pickerItemsCsvHeaders,
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Set datapoint helper.
      final String pickedHeader = state.pickerItemsCsvHeaders.items[pickedIndex].id;

      // Update TextData.
      final Field? updatedField = field.updateImportReference(
        importReference: pickedHeader,
        objectReferenceType: objectReference,
        memberId: memberId,
      );

      // Unknown fieldType!
      if (updatedField == null) throw Failure.genericError();

      // Update fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update the state entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Add field to model.
      emit(state.copyWith(
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> matchDatapointToField() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> matchDatapointToField() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method gets triggerd if user wants to match a datapoint to the entry name.
  Future<void> matchDatapointToEntryName({required BuildContext context}) async {
    // * Show PickerSheet.
    final int? pickedIndex = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => PickerSheet(
        title: labels.basicLabelsDatapoints(),
        pickerItems: state.pickerItemsCsvHeaders,
      ),
    );

    // * User did not pick an item.
    if (pickedIndex == null) return;

    // Access chosen fieldType.
    final String pickedHeader = state.pickerItemsCsvHeaders.items[pickedIndex].id;

    // Update ImportSpecifications.
    final ImportSpecifications updatedSpecifications = state.entryModel.importSpecifications!.copyWith(
      entryNameInstruction: pickedHeader,
    );

    // Update ModelEntry.
    final ModelEntry updatedModel = state.entryModel.copyWith(
      importSpecifications: updatedSpecifications,
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entryModel: updatedModel,
    ));
  }

  /// This method gets triggerd if user wants to match a datapoint to created at.
  Future<void> matchDatapointToCreatedAt({required BuildContext context}) async {
    // * Show PickerSheet.
    final int? pickedIndex = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => PickerSheet(
        title: labels.basicLabelsDatapoints(),
        pickerItems: state.pickerItemsCsvHeaders,
      ),
    );

    // * User did not pick an item.
    if (pickedIndex == null) return;

    // Access chosen fieldType.
    final String pickedHeader = state.pickerItemsCsvHeaders.items[pickedIndex].id;

    // Update ImportSpecifications.
    final ImportSpecifications updatedSpecifications = state.entryModel.importSpecifications!.copyWith(
      createdAtInstruction: pickedHeader,
    );

    // Update ModelEntry.
    final ModelEntry updatedModel = state.entryModel.copyWith(
      importSpecifications: updatedSpecifications,
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entryModel: updatedModel,
    ));
  }

  /// This method can be used to add a member to a participant in import mode.
  Future<void> addMember({required BuildContext context, required Field field}) async {
    try {
      // Ensure that a participant is available.
      if (state.fromGroup.participantReference.isEmpty) throw Failure.participantNotFound();

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

      // Make sure used context is still mounted. Output debug message.
      if (!context.mounted) {
        contextNotMountedHelper(parent: 'EntrySheetCubit', sourceMethod: 'addMember()');

        throw Failure.genericError();
      }

      // Access PaymentField.
      final PaymentData paymentData = field.paymentData!;

      // * User wants to create a new member.
      if (option == 1) {
        // * Let user choose a name for this member.
        final String? memberName = await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (context) => TextFieldSheet(
            hint: labels.createParticipantSheetCubitMemberNameHint(),
          ),
        );

        // * User cancled.
        if (memberName == null || memberName.isEmpty) return;

        // Check if a member with this name is already in state.
        final bool stateMemberExists = paymentData.members.nameExists(
          name: memberName,
        );

        // Let user know that this member name already exists.
        if (stateMemberExists) throw Failure.failureMemberAlreadyPartOfParticipant();

        // Check if a member with this name already exists.
        final Member? nameExists = await _localStorageCubit.getLocalMemberByName(memberName: memberName);

        // Let user know that this member name already exists.
        if (nameExists != null) throw Failure.memberNameExists();

        // * Create new member.
        final Member member = Member.initial().copyWith(
          memberName: memberName,
        );

        // Create updated Members.
        final Members updatedMembers = paymentData.members.addMember(member: member);

        // Create updated paymentData.
        final PaymentData updatedPaymentData = paymentData.copyWith(
          members: updatedMembers,
        );

        // Updated field.
        final Field updatedField = field.copyWith(
          paymentData: updatedPaymentData,
        );

        // Create updated fields.
        final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

        // Create updated entry.
        final Entry updatedEntry = state.entry.copyWith(
          fields: updatedFields,
        );

        // Perform local storage update.
        await _localStorageCubit.state.database!.writeTxn(() async {
          // Create Member.
          await _localStorageCubit.createLocalMember(
            member: member,
          );

          // Add participant to member reference.
          await _localStorageCubit.createParticipantToMemberReference(
            participantId: state.fromGroup.participantReference,
            member: member,
            addedBy: user.userId,
            addedAtInUtc: DateTime.now().toUtc(),
          );
        });

        // Only emit states if cubit is still open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          entry: updatedEntry,
          status: EntrySheetStatus.waiting,
        ));

        return;
      }

      // * User wants to choose from existing members.
      if (option == 2) {
        // Access local members.
        final Members currentUserMembers = await _localStorageCubit.getAllLocalMembers();

        // User has not created members yet.
        if (currentUserMembers.items.isEmpty) throw Failure.failureNoMembersCreated();

        // Access PickerItems.
        final PickerItems pickerItems = currentUserMembers.toPickerItems();

        // Make sure used context is still mounted. Output debug message.
        if (!context.mounted) {
          contextNotMountedHelper(parent: 'EntrySheetCubit', sourceMethod: 'addMember()');

          throw Failure.genericError();
        }

        // * Show PickerSheet.
        final int? pickedIndex = await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (context) => PickerSheet(
            pickerItems: pickerItems,
          ),
        );

        // * User cancelled.
        if (pickedIndex == null) return;

        // Access picked object.
        final PickerItem pickedItem = pickerItems.items[pickedIndex];

        // Access picked member.
        Member member = currentUserMembers.getById(memberId: pickedItem.id)!;

        // Check if a member with this name is already in state.
        final bool stateMemberExists = paymentData.members.nameExists(
          name: member.memberName,
        );

        // Let user know that this member name already exists.
        if (stateMemberExists) throw Failure.failureMemberAlreadyPartOfParticipant();

        // Create updated Members.
        final Members updatedMembers = paymentData.members.addMember(member: member);

        // Create updated paymentData.
        final PaymentData updatedPaymentData = paymentData.copyWith(
          members: updatedMembers,
        );

        // Updated field.
        final Field updatedField = field.copyWith(
          paymentData: updatedPaymentData,
        );

        // Create updated fields.
        final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

        // Create updated entry.
        final Entry updatedEntry = state.entry.copyWith(
          fields: updatedFields,
        );

        // Perform local storage update.
        await _localStorageCubit.state.database!.writeTxn(() async {
          // Add participant to member reference.
          await _localStorageCubit.createParticipantToMemberReference(
            participantId: state.fromGroup.participantReference,
            member: member,
            addedBy: user.userId,
            addedAtInUtc: DateTime.now().toUtc(),
          );
        });

        // Only emit states if cubit is still open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          entry: updatedEntry,
          status: EntrySheetStatus.waiting,
        ));

        return;
      }
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> addMember() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> addMember() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method is invoked if user changes the force member value switch.
  Future<void> onChangeForceMissingMemberValueImport({required Field field}) async {
    // Updated payment data.
    final PaymentData updatedPaymentData = field.paymentData!.copyWith(
      importReferenceForceMemberValueImport: !field.paymentData!.importReferenceForceMemberValueImport,
    );

    // Update field.
    final Field updatedField = field.copyWith(
      paymentData: updatedPaymentData,
    );

    // Update fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update the state entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Add field to model.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  // ####################################
  // # Entry name Widget
  // ####################################

  /// This method can be used to change the entry name.
  void entryNameChanged({required String value, required TextEditingController controller}) {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Update value.
    emit(state.copyWith(
      entry: state.entry.copyWith(
        entryName: value,
      ),
    ));
  }

  /// This method can be used to delete the contents of the entry name field.
  void deleteEntryName({required TextEditingController textEditingController}) {
    // Clear the controller.
    textEditingController.clear();

    // Update entry.
    final Entry updatedEntry = state.entry.copyWith(
      entryName: '',
    );

    // * Also remove import instruction.

    // Create updated ImportSpecifications.
    final ImportSpecifications? updatedSpecs = state.entryModel.importSpecifications?.copyWith(
      entryNameDefault: '',
      entryNameInstruction: '',
    );

    // Create updated ModelEntry.
    final ModelEntry updatedModelEntry = state.entryModel.copyWith(
      importSpecifications: updatedSpecs,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Update value.
    emit(state.copyWith(
      entry: updatedEntry,
      entryModel: updatedModelEntry,
    ));
  }

  // ####################################
  // # Created at Widget
  // ####################################

  /// This method can be used to change the entry created at value.
  Future<void> onCreatedAtEdited({required BuildContext context, required FocusScopeNode node}) async {
    try {
      // Unfocus current focus.
      node.unfocus();

      // Access initial DateTime.
      final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
        dateTimeInUtc: state.entry.createdAtInUtc,
        timezone: state.entry.createdAtTimeZone,
        preserveUtc: true,
      );

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: initialDateTime,
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeDate(
        localDate: chosenLocalDate,
        originalTimezoneLocation: initialDateTime.location,
      );

      // Update entry.
      final Entry updatedEntry = state.entry.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Add date.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onCreatedAtEdited() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onCreatedAtEdited() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to change the time of entry created at.
  Future<void> onChooseCreatedAtTime({required BuildContext context, required FocusScopeNode node}) async {
    try {
      // Unfocus current focus.
      node.unfocus();

      // Convert value.
      final tz.TZDateTime converted = HelperFunctions.convertToTimezone(
        dateTimeInUtc: state.entry.createdAtInUtc,
        timezone: state.entry.createdAtTimeZone,
        preserveUtc: true,
      );

      // Create initial.
      final TimeOfDay initialTime = TimeOfDay(
        hour: converted.hour,
        minute: converted.minute,
      );

      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeTime(
        localDate: converted,
        timeOfDay: chosenTime,
        originalTimezoneLocation: converted.location,
      );

      // Update entry.
      final Entry updatedEntry = state.entry.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Add date.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onCreatedAtEdited() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onCreatedAtEdited() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to disconnect created at from a datapoint.
  void disconnectImportDatapointFromCreatedAt() {
    // Create updated ImportSpecifications.
    final ImportSpecifications? updatedSpecs = state.entryModel.importSpecifications?.copyWith(
      createdAtInstruction: '',
    );

    // Create updated ModelEntry.
    final ModelEntry updatedModelEntry = state.entryModel.copyWith(
      importSpecifications: updatedSpecs,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Update value.
    emit(state.copyWith(
      entryModel: updatedModelEntry,
    ));
  }

  // ####################################
  // # Location Widget
  // ####################################

  /// This method can be used to clear current location so user can set manual location points.
  void resetLocationField({required Field field, required TextEditingController latitudeController, required TextEditingController longitudeController}) {
    try {
      // Access current user timezone.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Access now.
      final DateTime now = DateTime.now();
      final TimeOfDay nowTime = TimeOfDay.now();

      // Access defaults as String.
      final String nowDateAsString = DateFormat('yyyy-MM-dd').format(now);
      final String nowTimeString = HelperFunctions.formatTimeOfDayTo24Hour(timeOfDay: nowTime);

      // Create updated data.
      final LocationData updatedData = LocationData.initial().copyWith(
        createdAtInUtc: state.isDefault || state.isImportMatch ? null : now.toUtc(),
        createdAtTimezone: state.isDefault ? null : currentTimezone,
        defaultDate: state.isImportMatch ? nowDateAsString : null,
        defaultTime: state.isImportMatch ? nowTimeString : null,
      );

      // Create updated Field.
      final Field updatedField = field.copyWith(
        locationData: updatedData,
      );

      // Create updated fields.
      final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

      // Create updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Always clear controllers on delete.
      latitudeController.clear();
      longitudeController.clear();

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        isCurrentLocation: false,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> resetLocationField() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> resetLocationField() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user wants to change the date of a location field.
  Future<void> onChooseLocationDate({required BuildContext context, required Field field}) async {
    try {
      // Access data.
      final LocationData data = field.locationData!;

      // Access initial DateTime.
      final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
        dateTimeInUtc: data.createdAtInUtc!,
        timezone: data.createdAtTimezone,
        preserveUtc: true,
      );

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: initialDateTime,
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeDate(
        localDate: chosenLocalDate,
        originalTimezoneLocation: initialDateTime.location,
      );

      // Create updated money data.
      final LocationData updatedData = data.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        locationData: updatedData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseLocationDate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseLocationDate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to choose location time.
  Future<void> onChooseLocationTime({required BuildContext context, required Field field}) async {
    try {
      // Convert value.
      final tz.TZDateTime converted = HelperFunctions.convertToTimezone(
        dateTimeInUtc: field.locationData!.createdAtInUtc!,
        timezone: field.locationData!.createdAtTimezone,
        preserveUtc: true,
      );

      // Create initial.
      final TimeOfDay initialTime = TimeOfDay(
        hour: converted.hour,
        minute: converted.minute,
      );

      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeTime(
        localDate: converted,
        timeOfDay: chosenTime,
        originalTimezoneLocation: converted.location,
      );

      // Create updated data.
      final LocationData updatedData = field.locationData!.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        locationData: updatedData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseLocationTime() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseLocationTime() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to change the latitude value of a location object.
  void latitudeValueChanged({required Field field, required String? value, required TextEditingController controller}) {
    // Create updated location data.
    final LocationData updatedLocationData = field.locationData!.copyWith(
      longitude: field.locationData!.longitude,
      latitude: value ?? '',
      type: field.locationData!.type,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      locationData: updatedLocationData,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used clear the latitude.
  void clearLatitude({required Field field, required TextEditingController controller}) {
    // Create updated LocationData.
    final LocationData updatedLocationData = field.locationData!.copyWith(
      latitude: '',
      longitude: field.locationData!.longitude,
      type: field.locationData!.type,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      locationData: updatedLocationData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear controller.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used to change the longitude value of a location object.
  void longitudeValueChanged({required Field field, required String? value, required TextEditingController controller}) {
    // Create updated location data.
    final LocationData updatedLocationData = field.locationData!.copyWith(
      longitude: value ?? '',
      latitude: field.locationData!.latitude,
      type: field.locationData!.type,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      locationData: updatedLocationData,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used clear the longitude.
  void clearLongitude({required Field field, required TextEditingController controller}) {
    // Create updated LocationData.
    final LocationData updatedLocationData = field.locationData!.copyWith(
      latitude: field.locationData!.latitude,
      longitude: '',
      type: field.locationData!.type,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      locationData: updatedLocationData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear controller.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used to access current location and use those values in a location field.
  Future<void> getCurrentLocation({required Field field}) async {
    try {
      // Only emit states if cubit is still open and sate is not already loading.
      if (state.status == EntrySheetStatus.loading || isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: EntrySheetStatus.loading,
      ));

      // Check if user gave permission.
      // * On invalid permission, a Failure is thrown
      await _locationRepository.requestLocationPermissions();

      // Access current location.
      final Map<String, dynamic> currentLocation = await _locationRepository.getCurrentUserLocation();

      // Create updated LocationData.
      final LocationData updatedLocationData = field.locationData!.copyWith(
        latitude: currentLocation['lat'],
        longitude: currentLocation['lng'],
        type: currentLocation['type'],
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        locationData: updatedLocationData,
      );

      // Create updated fields.
      final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

      // Create updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        isCurrentLocation: true,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> getCurrentLocation() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> getCurrentLocation() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Password Widget
  // ####################################

  /// This method can be used to delete the contents of a password field.
  void resetPasswordData({required Field field, required TextEditingController textEditingController}) {
    // Create new password data object.
    final PasswordData passwordData = PasswordData.initial().copyWith(
      obscure: field.passwordData!.obscure,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      passwordData: passwordData,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear the controller.
    textEditingController.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a passwordData object.
  void passwordValueChanged({required Field field, required String value}) {
    // Create updated password data.
    final PasswordData updatedPassword = field.passwordData!.copyWith(
      value: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      passwordData: updatedPassword,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the obscure value of a password object.
  void obscuredChanged({required Field field}) {
    // Create updated password data.
    final PasswordData updatedPassword = field.passwordData!.copyWith(
      obscure: !field.passwordData!.obscure,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      passwordData: updatedPassword,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to show a PasswordGenerator.
  Future<void> showPasswordGeneratorSheet({required BuildContext context}) async {
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

  /// This method can be used to generate a password and set it to state.
  Future<void> generatePassword({required BuildContext context, required Field field, required TextEditingController controller, required String notification, required FocusScopeNode node}) async {
    try {
      // Unfocus.
      node.unfocus();

      final PasswordGeneratorCubit passwordGeneratorCubit = PasswordGeneratorCubit(
        localStorageCubit: _localStorageCubit,
        appMessagesCubit: _appMessagesCubit,
      );

      // Init cubit.
      await passwordGeneratorCubit.initialize();

      // Generate a password.
      final String generatedPassword = passwordGeneratorCubit.createPassword();

      // Create updated password data.
      final PasswordData updatedPassword = field.passwordData!.copyWith(
        value: generatedPassword,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        passwordData: updatedPassword,
      );

      // Updated fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Set value to controller.
      controller.text = generatedPassword;

      // Close cubit after using it.
      passwordGeneratorCubit.close();

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> generatePassword() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> generatePassword() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Text Widget
  // ####################################

  /// This method can be used to delete the contents of a text field.
  void resetTextData({required Field field, required TextEditingController textEditingController}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      textData: TextData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear the controller.
    textEditingController.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a textData object.
  void textValueChanged({required Field field, required String value}) {
    // Create updated text data.
    final TextData updatedTextData = field.textData!.copyWith(
      value: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      textData: updatedTextData,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  // ####################################
  // # Phone Widget
  // ####################################

  /// This method can be used to delete the contents of a phone field.
  void resetPhoneData({required Field field, required TextEditingController textEditingController}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      phoneData: PhoneData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear the controller.
    textEditingController.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used clear the latitude.
  void clearPhoneValue({required Field field, required TextEditingController controller}) {
    // Create updated PhoneData.
    final PhoneData updatedPhoneData = field.phoneData!.copyWith(
      value: '',
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      phoneData: updatedPhoneData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear the controller.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method gets triggered if user wants to change international prefix of a phone number.
  Future<void> onFlagPressed({required BuildContext context, required Field field, required TextEditingController controller}) async {
    // Show available countries.
    final CountrySpecification? countrySpecification = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => BlocProvider<ListSelectorSheetCubit>(
        create: (context) => ListSelectorSheetCubit()
          ..initialize(
            isCurrencySelector: false,
          ),
        child: const ListSelectorSheet(),
      ),
    );

    // User closed sheet.
    if (countrySpecification == null) return;

    // Create updated PhoneData.
    final PhoneData updatedPhoneData = field.phoneData!.copyWith(
      internationalPrefix: countrySpecification.internationalPhonePrefix,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      phoneData: updatedPhoneData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used to change the value of a phoneData object.
  Future<void> phoneValueChanged({required Field field, required String value}) async {
    // Create updated PhoneData.
    final PhoneData updatedPhoneData = field.phoneData!.copyWith(
      value: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      phoneData: updatedPhoneData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));

    // * Currently this is only available locally.

    // Init suggestions.
    final List<PhoneData> suggestions = state.isShared == false
        ? await _localStorageCubit.getLocalPhoneSuggestions(
            value: value,
          )
        : const [];

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      phoneSuggestions: suggestions,
    ));
  }

  /// This method gets triggerd if user taps on a phone suggestion.
  Future<void> phoneSuggestionSelected({required BuildContext context, required Field field, required int index, required String value, required TextEditingController controller}) async {
    try {
      // Do nothing if selected value is empty.
      // * This should never happen anyways.
      if (value.isEmpty) return;

      // * Index does not know that list is displayed reversed.
      final List<PhoneData> reversed = state.phoneSuggestions.reversed.toList();

      // Create updated PhoneData.
      final PhoneData updatedPhoneData = reversed[index];

      // Updated field.
      final Field updatedField = field.copyWith(
        phoneData: updatedPhoneData,
      );

      // Create updated fields.
      final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

      // Create updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Set the value to the controller.
      // * Exclude international prefix.
      controller.text = updatedPhoneData.value;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        phoneSuggestions: const [],
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> phoneSuggestionSelected() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        phoneSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> phoneSuggestionSelected() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        phoneSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Date of Birth Widget
  // ####################################

  /// This method can be used to clear a dateOfBirth object.
  void resetDateOfBirthData({required Field field}) {
    // Reset data.
    final DateOfBirthData updatedDoB = DateOfBirthData.initial().copyWith(
      showAutoNotificationChoice: state.isEdit ? false : null,
      autoNotification: state.isEdit ? false : null,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      dateOfBirthData: updatedDoB,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a dateOfBirth object.
  Future<void> onDateOfBirthChosen({required Field field, required BuildContext context}) async {
    try {
      // Access data.
      final DateOfBirthData data = field.dateOfBirthData!;

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: data.value ?? DateUtils.dateOnly(DateTime.now()),
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated birthday data.
      final DateOfBirthData updatedDoB = field.dateOfBirthData!.copyWith(
        value: chosenLocalDate,
        explicitlySetValue: true,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        dateOfBirthData: updatedDoB,
      );

      // Updated fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateOfBirthChosen() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateOfBirthChosen() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to set a time to a date of birth.
  Future<void> onChooseDateOfBirthTime({required DateTime? initialDate, required Field field, required BuildContext context}) async {
    try {
      // Ensure that user selected a date first.
      if (initialDate == null) throw Failure.dateIsRequired();

      // Get initial time.
      final TimeOfDay initialTime = TimeOfDay(hour: initialDate.hour, minute: initialDate.minute);

      // Let user choose a date.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Update date with time.
      final DateTime updatedDate = DateTime(
        field.dateOfBirthData!.value!.year,
        field.dateOfBirthData!.value!.month,
        field.dateOfBirthData!.value!.day,
        chosenTime.hour,
        chosenTime.minute,
      );

      // Create updated birthday data.
      final DateOfBirthData updatedDoB = field.dateOfBirthData!.copyWith(
        value: updatedDate,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        dateOfBirthData: updatedDoB,
      );

      // Updated fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateOfBirthTimeChosen() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateOfBirthTimeChosen() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if user changes the title of a birthday notification.
  void onBirthdayNotificationTitleChanged({required Field field, required String value, required TextEditingController controller}) {
    // Create updated birthday data.
    final DateOfBirthData updatedDoB = field.dateOfBirthData!.copyWith(
      notificationTitle: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      dateOfBirthData: updatedDoB,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user changes the auto notification switch.
  void onAutoNotificationChanged({required Field field}) {
    // Convenience variable.
    final bool autoNotify = !field.dateOfBirthData!.autoNotification;

    // Create updated birthday data.
    final DateOfBirthData updatedDoB = field.dateOfBirthData!.copyWith(
      autoNotification: autoNotify,
      notificationTitle: autoNotify ? field.dateOfBirthData!.notificationTitle : '',
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      dateOfBirthData: updatedDoB,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  // ####################################
  // # Date Widget
  // ####################################

  /// This method can be used to delete date data of a field.
  void resetDateData({required Field field}) {
    // Create updated data data.
    final DateData updatedDateData = DateData.initial();

    // Updated field.
    final Field updatedField = field.copyWith(
      dateData: updatedDateData,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a dateDate object.
  Future<void> onDateChosen({required Field field, required BuildContext context}) async {
    try {
      // Access data.
      final DateData data = field.dateData!;

      // Access initial timezone if no timezone is available.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Access initial DateTime.
      final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
        dateTimeInUtc: data.valueInUtc,
        timezone: data.timezone.isEmpty ? currentTimezone : data.timezone,
        preserveUtc: true,
      );

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: initialDateTime,
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeDate(
        localDate: DateUtils.dateOnly(chosenLocalDate), // * Only store date for this field.
        originalTimezoneLocation: initialDateTime.location,
      );

      // Create updated data data.
      final DateData updatedDateData = data.copyWith(
        valueInUtc: changedInLocal.toUtc(),
        timezone: data.timezone.isEmpty ? currentTimezone : data.timezone,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        dateData: updatedDateData,
      );

      // Updated fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateChosen() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateChosen() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Date and Time Widget
  // ####################################

  /// This method can be used to delete date data of a field.
  void resetDateAndTimeData({required Field field}) {
    // Create updated data data.
    final DateAndTimeData updatedDateData = DateAndTimeData.initial();

    // Updated field.
    final Field updatedField = field.copyWith(
      dateAndTimeData: updatedDateData,
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a dateAndTime object.
  Future<void> onDateAndTimeDateChosen({required Field field, required BuildContext context}) async {
    try {
      // Access data.
      final DateAndTimeData data = field.dateAndTimeData!;

      // Access initial timezone if no timezone is available.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Access initial DateTime.
      final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
        dateTimeInUtc: data.valueInUtc,
        timezone: data.timezone.isEmpty ? currentTimezone : data.timezone,
        preserveUtc: true,
      );

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: initialDateTime,
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeDate(
        localDate: chosenLocalDate,
        originalTimezoneLocation: initialDateTime.location,
      );

      // Create updated data data.
      final DateAndTimeData updatedDateData = data.copyWith(
        valueInUtc: changedInLocal.toUtc(),
        timezone: data.timezone.isEmpty ? currentTimezone : data.timezone,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        dateAndTimeData: updatedDateData,
      );

      // Updated fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateAndTimeChosen() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateAndTimeChosen() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to choose dateAndTime time.
  Future<void> onDateAndTimeTimeChosen({required BuildContext context, required Field field}) async {
    try {
      // Make sure a Date has been selected first.
      if (field.dateAndTimeData!.valueInUtc == null) throw Failure.dateIsRequired();

      // Convert value.
      final tz.TZDateTime converted = HelperFunctions.convertToTimezone(
        dateTimeInUtc: field.dateAndTimeData!.valueInUtc!,
        timezone: field.dateAndTimeData!.timezone,
        preserveUtc: true,
      );

      // Create initial.
      final TimeOfDay initialTime = TimeOfDay(
        hour: converted.hour,
        minute: converted.minute,
      );

      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeTime(
        localDate: converted,
        timeOfDay: chosenTime,
        originalTimezoneLocation: converted.location,
      );

      // Create updated money data.
      final DateAndTimeData updatedData = field.dateAndTimeData!.copyWith(
        valueInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        dateAndTimeData: updatedData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateAndTimeTimeChosen() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDateAndTimeTimeChosen() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Time Widget
  // ####################################

  /// This method can be used to delete time data of a field.
  void resetTimeData({required Field field}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      timeData: TimeData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a timeData object.
  Future<void> onTimeChosen({required BuildContext context, required Field field, required TimeOfDay? initialTime}) async {
    try {
      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Create Field.
      final TimeData updatedTimeData = field.timeData!.copyWith(
        value: chosenTime,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        timeData: updatedTimeData,
      );

      // Updated fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onTimeChosen() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onTimeChosen() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Number Widget
  // ####################################

  /// This method can be used to clear the value of a number field.
  void resetNumberData({required Field field, required TextEditingController controller}) {
    // Update field.
    final Field updatedField = field.copyWith(
      numberData: NumberData.initial(),
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear controller.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a numberData object.
  void numberValueChanged({required Field field, required String? value, required TextEditingController controller}) {
    // Update Field.
    final Field updatedField = field.copyWith(
      numberData: field.numberData!.copyWith(
        value: value ?? '',
      ),
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  // ####################################
  // # Money Widget
  // ####################################

  /// This method can be used to clear the value of a money field.
  void resetMoneyField({required Field field, required TextEditingController controller}) {
    try {
      // Access data of field.
      final MoneyData data = field.moneyData!;

      // Access current user timezone.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Access now.
      final DateTime now = DateTime.now();
      final TimeOfDay nowTime = TimeOfDay.now();

      // Access defaults as String.
      final String nowDateAsString = DateFormat('yyyy-MM-dd').format(now);
      final String nowTimeString = HelperFunctions.formatTimeOfDayTo24Hour(timeOfDay: nowTime);

      // Create updated data.
      final MoneyData updatedData = MoneyData.initial().copyWith(
        currencyCode: state.isDefault || state.isImportMatch ? '' : data.currencyCode,
        createdAtInUtc: state.isDefault || state.isImportMatch ? null : now.toUtc(),
        timezone: state.isDefault ? null : currentTimezone,
        defaultDate: state.isImportMatch ? nowDateAsString : null,
        defaultTime: state.isImportMatch ? nowTimeString : null,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        // * If user is in set default mode, reset value otherwise retain it.
        canChangeParameters: state.isDefault ? true : null,
        moneyData: updatedData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Clear the controller.
      controller.clear();

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> resetMoneyField() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> resetMoneyField() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to change the value of a moneyData object.
  void moneyValueChanged({required Field field, required String? value, required TextEditingController controller}) {
    // Update Field.
    final Field updatedField = field.copyWith(
      moneyData: field.moneyData!.copyWith(
        value: value ?? '',
      ),
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to set a currency for a moneyData object.
  Future<void> setMoneyDataCurrency({required BuildContext context, required Field field}) async {
    try {
      // Let user know, that parameters cannot be changed.
      if (field.canChangeParameters == false && state.isDefault == false) throw Failure.cannotChangeParameters();

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

      // User closed sheet or selected the same currency again.
      if (countrySpecification == null || countrySpecification.currencyCode == field.moneyData!.currencyCode) return;

      // Create updated money data.
      final MoneyData updatedMoneyData = field.moneyData!.copyWith(
        currencyCode: countrySpecification.currencyCode,
      );

      // Access the field.
      final Field updatedField = field.copyWith(
        moneyData: updatedMoneyData,
      );

      // Update Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: fields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setMoneyDataCurrency() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setMoneyDataCurrency() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user wants to change the date of a money field.
  Future<void> onChooseMoneyDate({required BuildContext context, required Field field}) async {
    try {
      // Access data.
      final MoneyData data = field.moneyData!;

      // Access initial DateTime.
      final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
        dateTimeInUtc: data.createdAtInUtc!,
        timezone: data.timezone,
        preserveUtc: true,
      );

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: initialDateTime,
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeDate(
        localDate: chosenLocalDate,
        originalTimezoneLocation: initialDateTime.location,
      );

      // Create updated money data.
      final MoneyData updatedMoneyData = field.moneyData!.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        moneyData: updatedMoneyData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMoneyDate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMoneyDate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to set the time of a money field.
  Future<void> onChooseMoneyTime({required BuildContext context, required Field field}) async {
    try {
      // Convert value.
      final tz.TZDateTime converted = HelperFunctions.convertToTimezone(
        dateTimeInUtc: field.moneyData!.createdAtInUtc!,
        timezone: field.moneyData!.timezone,
        preserveUtc: true,
      );

      // Create initial.
      final TimeOfDay initialTime = TimeOfDay(
        hour: converted.hour,
        minute: converted.minute,
      );

      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeTime(
        localDate: converted,
        timeOfDay: chosenTime,
        originalTimezoneLocation: converted.location,
      );

      // Create updated money data.
      final MoneyData updatedData = field.moneyData!.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        moneyData: updatedData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMoneyTime() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMoneyTime() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Custom Exchange Rate
  // ####################################

  /// This method can be used to clear the custom exchange rate of a money field.
  void deleteCustomExchangeRate({required Field field, required String fromCurrencyCode, required String toCurrencyCode, required ExchangeRates customExchangeRates}) {
    // Find relevant exchange rate.
    final ExchangeRate? exchangeRate = customExchangeRates.findMatchingExchangeRate(
      fromCurrencyCode: fromCurrencyCode,
      toCurrencyCode: toCurrencyCode,
    );

    // Remove relevant exchange rate.
    final ExchangeRates removed = customExchangeRates.remove(
      exchangeRate: exchangeRate,
    );

    // Create updated MoneyData.
    // * Keep values except custom exchange rate.
    // * Reset exhangeRateStatus so that getting exchange rate is retried.
    final MoneyData? updatedMoneyData = field.moneyData?.copyWith(
      customExchangeRates: removed,
    );

    // Create updated PaymentData.
    // * Keep values except custom exchange rate.
    // * Reset exhangeRateStatus so that getting exchange rate is retried.
    final PaymentData? updatedPaymentData = field.paymentData?.copyWith(
      customExchangeRates: removed,
    );

    // Update field.
    final Field updatedField = field.copyWith(
      moneyData: field.getIsMoneyField ? updatedMoneyData : null,
      paymentData: field.getIsPaymentField ? updatedPaymentData : null,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to set a custom exchange rate of a money field.
  Future<void> setCustomExchangeRate({required Field field, required String fromCurrencyCode, required String toCurrencyCode, required ExchangeRates? customExchangeRates, required BuildContext context}) async {
    try {
      // Get initial exchange rate.
      final ExchangeRate? initial = customExchangeRates?.findMatchingExchangeRate(
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
      );

      // Show text sheet.
      // * Let user authenticate.
      final String? customExchangeRateValue = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => TextFieldSheet(
          textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
          title: labels.basicLabelsExchangeRate(),
          initialValue: initial?.exchangeRate.toString() ?? '',
          autocorrect: false,
        ),
      );

      // * User cancled.
      if (customExchangeRateValue == null || customExchangeRateValue.isEmpty) return;

      // Try and parse to default number data.
      final String converted = NumberData.convertToDefaultNumberFormat(value: customExchangeRateValue);

      // Check value.
      final bool isValidNumber = NumberData.numberValidator(input: converted);

      // * Invalid number discovered.
      if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: '');

      // Ensure that value is not to big.
      final bool tooManyChars = NumberData.tooManyNumberCharacters(input: converted);

      // Raise error.
      if (tooManyChars) throw Failure.numberHasTooManyCharacters();

      // Convert to double.
      final double asDouble = double.parse(converted);

      // * Must be greater zero.
      if (asDouble <= 0) throw Failure.customExchangeRateMustBeGreaterZero();

      // Create updated CustomExchangeRate.
      final ExchangeRate customExchangeRateObject = ExchangeRate.initial().copyWith(
        exchangeRateDateInUtc: DateTime.now().toUtc(),
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
        exchangeRate: asDouble,
      );

      // Set ExchangeRates object.
      final ExchangeRates? setExchangeRatesMoneyData = field.moneyData?.customExchangeRates.set(
        exchangeRate: customExchangeRateObject,
      );

      // Create updated money data.
      final MoneyData? updatedMoneyData = field.moneyData?.copyWith(
        customExchangeRates: setExchangeRatesMoneyData,
      );

      // Set ExchangeRates object.
      final ExchangeRates? setExchangeRatesPaymentData = field.paymentData?.customExchangeRates.set(
        exchangeRate: customExchangeRateObject,
      );

      // Create updated payment data.
      final PaymentData? updatedPaymentData = field.paymentData?.copyWith(
        customExchangeRates: setExchangeRatesPaymentData,
      );

      // Access the field.
      final Field updatedField = field.copyWith(
        moneyData: field.getIsMoneyField ? updatedMoneyData : null,
        paymentData: field.getIsPaymentField ? updatedPaymentData : null,
      );

      // Update Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: fields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setCustomExchangeRate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setCustomExchangeRate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Default exchange rates
  // ####################################

  /// This method can be used to set default exchange rates.
  Future<void> setDefaultExchangeRates({required BuildContext context, required Field field}) async {
    try {
      // Show CreateDefaultExchangeRateSheet.
      final ExchangeRate? defaultExchangeRate = await showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        showDragHandle: true,
        builder: (_) => BlocProvider<CreateDefaultExchangeRateCubit>(
          create: (context) => CreateDefaultExchangeRateCubit()..initialize(),
          child: const CreateDefaultExchangeRateSheet(),
        ),
      );

      // User cancled.
      if (defaultExchangeRate == null) return;

      // Create updated custom exchange rates.
      final ExchangeRates defaultExchangeRates = field.moneyData!.customExchangeRates.addUniqueWithReciprocalCheck(
        exchangeRate: defaultExchangeRate,
        ignoreDate: true,
      );

      // If exchange rate was already found, let user know.
      if (defaultExchangeRates == field.moneyData!.customExchangeRates) throw Failure.exchangeRateAlreadyExists();

      // Create updated money data.
      final MoneyData? updatedMoneyData = field.moneyData?.copyWith(
        customExchangeRates: defaultExchangeRates,
      );

      // Access the field.
      final Field updatedField = field.copyWith(
        moneyData: updatedMoneyData,
      );

      // Update Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: fields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setDefaultExchangeRates() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setDefaultExchangeRates() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to remove a default exchange rate.
  Future<void> removeDefaultExchangeRate({required BuildContext context, required ExchangeRate exchangeRate, required Field field}) async {
    try {
      // Remove exchange rate.
      final ExchangeRates removed = field.moneyData!.customExchangeRates.remove(exchangeRate: exchangeRate);

      // Create updated money data.
      final MoneyData? updatedMoneyData = field.moneyData?.copyWith(
        customExchangeRates: removed,
      );

      // Access the field.
      final Field updatedField = field.copyWith(
        moneyData: updatedMoneyData,
      );

      // Update Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: fields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> removeDefaultExchangeRate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> removeDefaultExchangeRate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Email Widget
  // ####################################

  /// This method can be used to delete the contents of a email field.
  void resetEmailData({required Field field, required TextEditingController textEditingController}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      emailData: EmailData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear the controller.
    textEditingController.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a emailData object.
  Future<void> emailValueChanged({required Field field, required String value, required TextEditingController controller}) async {
    // Access provider.
    // * Returns an empty String if no provider is found.
    final String provider = EmailData.accessProvider(value: value);

    // Create updated PhoneData.
    final EmailData updatedEmailData = field.emailData!.copyWith(
      value: value,
      provider: provider,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      emailData: updatedEmailData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));

    // * Currently this is only available locally.

    // Init suggestions.
    final List<String> suggestions = state.isShared == false
        ? await _localStorageCubit.getLocalEmailSuggestions(
            value: value,
          )
        : const [];

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      textSuggestions: suggestions,
    ));
  }

  /// This method gets triggerd if user taps on a email suggestion.
  Future<void> emailSuggestionSelected({required BuildContext context, required Field field, required String value, required TextEditingController controller}) async {
    try {
      // Do nothing if selected value is empty.
      // * This should never happen anyways.
      if (value.isEmpty) return;

      // Init helper var.
      String provider = '';

      // check if email contains a topLevelDomain.
      if (value.contains("@")) {
        // Get last index of "@";
        // * Deals with cases where multiple "@" were supplied.
        final int index = value.lastIndexOf("@");

        // Only get provider.
        // * This is by far not perfect.
        provider = value.substring(index).replaceAll('@', '');
      }

      // Create updated PhoneData.
      final EmailData updatedEmailData = field.emailData!.copyWith(
        value: value,
        provider: provider,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        emailData: updatedEmailData,
      );

      // Create updated fields.
      final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

      // Create updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Set the value to the controller.
      controller.text = value;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        textSuggestions: const [],
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> emailSuggestionSelected() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        textSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> emailSuggestionSelected() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        textSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Website Widget
  // ####################################

  /// This method can be used to delete the contents of a website field.
  void resetWebsiteData({required Field field, required TextEditingController textEditingController}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      websiteData: WebsiteData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear the controller.
    textEditingController.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a websiteData object.
  Future<void> websiteValueChanged({required Field field, required String value, required TextEditingController controller}) async {
    // Create updated WebsiteData.
    final WebsiteData updatedWebsiteData = field.websiteData!.copyWith(
      value: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      websiteData: updatedWebsiteData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));

    // * Currently this is only available locally.

    // Init suggestions.
    final List<String> suggestions = state.isShared == false
        ? await _localStorageCubit.getLocalWebsiteSuggestions(
            value: value,
          )
        : const [];

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      textSuggestions: suggestions,
    ));
  }

  /// This method gets triggerd if user taps on a username suggestion.
  Future<void> websiteSuggestionSelected({required BuildContext context, required Field field, required String value, required TextEditingController controller}) async {
    try {
      // Do nothing if selected value is empty.
      // * This should never happen.
      if (value.isEmpty) return;

      // Create updated WebsiteData.
      final WebsiteData updatedWebsiteData = field.websiteData!.copyWith(
        value: value,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        websiteData: updatedWebsiteData,
      );

      // Create updated fields.
      final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

      // Create updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Set the value to the controller.
      controller.text = value;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        textSuggestions: const [],
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> websiteSuggestionSelected() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        textSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> websiteSuggestionSelected() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        textSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Username Widget
  // ####################################

  /// This method can be used to delete the contents of a username field.
  void resetUsernameData({required Field field, required TextEditingController textEditingController, required TextEditingController optionalTextEditingController}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      usernameData: UsernameData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear controllers.
    textEditingController.clear();
    optionalTextEditingController.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a usernameData object.
  Future<void> usernameValueChanged({required Field field, required String value, required TextEditingController controller}) async {
    // Create updated WebsiteData.
    final UsernameData updatedUsernameData = field.usernameData!.copyWith(
      value: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      usernameData: updatedUsernameData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));

    // * Currently this is only available locally.

    // Init suggestions.
    final List<String> suggestions = state.isShared == false
        ? await _localStorageCubit.getLocalUsernameSuggestions(
            value: value,
          )
        : const [];

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      textSuggestions: suggestions,
    ));
  }

  /// This method can be used clear the value of a username field.
  void clearUsernameValue({required Field field, required TextEditingController controller}) {
    // Create updated WebsiteData.
    final UsernameData updatedUsernameData = field.usernameData!.copyWith(
      value: '',
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      usernameData: updatedUsernameData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // If user wants to clear data.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used clear the value of a username field.
  void clearUsernameService({required Field field, required TextEditingController controller}) {
    // Create updated WebsiteData.
    final UsernameData updatedUsernameData = field.usernameData!.copyWith(
      service: '',
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      usernameData: updatedUsernameData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // If user wants to clear data.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used to change the optional value of a usernameData object.
  void usernameServiceChanged({required Field field, required String value, required TextEditingController controller}) {
    // Create updated WebsiteData.
    final UsernameData updatedUsernameData = field.usernameData!.copyWith(
      service: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      usernameData: updatedUsernameData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method gets triggerd if user taps on a username suggestion.
  Future<void> usernameSuggestionSelected({required BuildContext context, required Field field, required String value, required TextEditingController controller}) async {
    try {
      // Do nothing if selected value is empty.
      // * This should never happen anyways.
      if (value.isEmpty) return;

      // Create updated WebsiteData.
      final UsernameData updatedUsernameData = field.usernameData!.copyWith(
        value: value,
      );

      // Updated field.
      final Field updatedField = field.copyWith(
        usernameData: updatedUsernameData,
      );

      // Create updated fields.
      final Fields updatedFields = state.entry.fields.updateField(updatedField: updatedField);

      // Create updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Set the value to the controller.
      controller.text = value;

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        textSuggestions: const [],
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> usernameSuggestionSelected() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        textSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> usernameSuggestionSelected() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        textSuggestions: const [],
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Images Widget
  // ####################################

  /// This method can be used to show a AddFilesSheet.
  Future<void> showAddFilesSheet({required BuildContext context, required Field initialField}) async {
    try {
      // Access initial files.
      Files initialFiles = Files.initial();

      // Images mode.
      if (initialField.getIsImagesField) initialFiles = initialField.imageData!.images;

      // Avatar image mode.
      if (initialField.getIsAvatarImageField) initialFiles = initialField.avatarImageData!.toFiles();

      // Avatar image mode.
      if (initialField.getIsFilesField) initialFiles = initialField.fileData!.files;

      // * Show AddFilesSheet.
      final Files? files = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => BlocProvider<AddFilesSheetCubit>(
          create: (context) => AddFilesSheetCubit(
            fileRepository: context.read<FileRepository>(),
            localStorageCubit: _localStorageCubit,
          )..initialize(
              fromGroup: state.fromGroup,
              initialFiles: initialFiles,
              entry: state.entry,
              fieldId: initialField.fieldId,
              isImages: initialField.getIsImagesField,
              isAvatarImage: initialField.getIsAvatarImageField,
              isFiles: initialField.getIsFilesField,
            ),
          child: const AddFilesSheet(),
        ),
      );

      // * User did not change selection.
      if (files == null || files == initialFiles) return;

      // Create updated AvatarImageData.
      final AvatarImageData? updatedAvatarImageData = files.items.isEmpty
          ? AvatarImageData.initial()
          : initialField.avatarImageData?.copyWith(
              image: files.items.first,
            );

      // Create updated imageData.
      final ImageData? updatedImageData = initialField.imageData?.copyWith(
        images: files,
      );

      // Create updated fileData.
      final FileData? updatedFileData = initialField.fileData?.copyWith(
        files: files,
      );

      // Create Field.
      final Field updatedField = initialField.copyWith(
        avatarImageData: initialField.getIsAvatarImageField ? updatedAvatarImageData : null,
        imageData: initialField.getIsImagesField ? updatedImageData : null,
        fileData: initialField.getIsFilesField ? updatedFileData : null,
      );

      // Create Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Create Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: fields,
      );

      // * Access removed files of currently selected file field.
      final Files currentRemoved = initialFiles.notIn(other: files);

      // * Access all files of entry.
      final Files allEntryFiles = state.initialEntry.getAllFilesOfEntry(onlyImages: false);

      // * Access files which are saved in local storage and therefore should be deleted.
      final Files dueForDelete = currentRemoved.isIn(other: allEntryFiles);

      // * Combine data. This is needed because there might be more then one files type in entry.
      final Files deletedFiles = state.deletedFiles.join(other: dueForDelete);

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        deletedFiles: deletedFiles,
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> showAddFilesSheet() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> showAddFilesSheet() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user tabs on a file.
  Future<void> onFileTab({required BuildContext context, required Field initialField, required FileItem fileItem}) async {
    try {
      // * Show AddFileDetailsSheet.
      final FileItem? updatedFileItem = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BlocProvider<AddFileDetailsSheetCubit>(
          create: (context) => AddFileDetailsSheetCubit()
            ..initialize(
              initialFileItem: fileItem,
              isAvatarImage: initialField.getIsAvatarImageField,
              isImages: initialField.getIsImagesField,
              isFiles: initialField.getIsFilesField,
            ),
          child: const AddFileDetailsSheet(),
        ),
      );

      // User did not change anything.
      if (updatedFileItem == null || updatedFileItem == fileItem) return;

      // Convenience variables.
      AvatarImageData? updatedAvatarImageData;
      ImageData? updatedImageData;
      FileData? updatedFileData;

      // Update avatar image.
      if (initialField.getIsAvatarImageField) {
        // Perform update.
        updatedAvatarImageData = initialField.avatarImageData!.copyWith(
          image: updatedFileItem,
        );
      }

      // Update imageData.
      if (initialField.getIsImagesField) {
        // Create updated images.
        final Files updatedImages = initialField.imageData!.images.update(
          updatedFileItem: updatedFileItem,
        );

        // Update image data.
        updatedImageData = initialField.imageData!.copyWith(
          images: updatedImages,
        );
      }

      // Update filesData.
      if (initialField.getIsFilesField) {
        // Create updated images.
        final Files updatedFiles = initialField.fileData!.files.update(
          updatedFileItem: updatedFileItem,
        );

        // Update image data.
        updatedFileData = initialField.fileData!.copyWith(
          files: updatedFiles,
        );
      }

      // Updated Field.
      final Field updatedField = initialField.copyWith(
        avatarImageData: initialField.getIsAvatarImageField ? updatedAvatarImageData : null,
        imageData: initialField.getIsImagesField ? updatedImageData : null,
        fileData: initialField.getIsFilesField ? updatedFileData : null,
      );

      // Create Fields.
      final Fields fields = state.entry.fields.updateField(updatedField: updatedField);

      // Create Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: fields,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onFileTab() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onFileTab() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ###################################
  // Boolean Data
  // ###################################

  /// This method can be used to delete the contents of a boolean field.
  void resetBooleanData({required Field field}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      booleanData: BooleanData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method can be used to change the value of a BooleanData object.
  Future<void> onChangeBooleanData({required Field field, required BuildContext context}) async {
    // * Show selector sheet and await choice.
    final int? option = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SelectOptionSheet(
        optionOne: labels.basicLabelsTrue(),
        optionOneIcon: AppIcons.selected,
        optionTwo: labels.basicLabelsFalse(),
        optionTwoIcon: AppIcons.unselected,
      ),
    );

    // * User cancelled.
    if (option == null) return;

    // Init value.
    bool? value;

    // * User wants to set this field to true.
    if (option == 1) value = true;

    // * User wants to set this field to false.
    if (option == 2) value = false;

    // Value did not change, do nothing.
    if (value == field.booleanData!.value || value == null) return;

    // Copy field.
    final BooleanData updatedData = field.booleanData!.copyWith(
      value: value,
    );

    // Updated field.
    final Field updatedField = field.copyWith(
      booleanData: updatedData,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  // ###################################
  // Tags
  // ###################################

  /// This method can be used to delete the contents of a tags field.
  void resetTagsData({required Field field, required TextEditingController controller}) {
    // Updated field.
    final Field updatedField = field.copyWith(
      tagsData: TagsData.initial(),
    );

    // Updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear controller.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method will be triggered if user types in the tags field.
  Future<void> tagValueChanged({required Field field, required String value, required TextEditingController controller}) async {
    try {
      // Modify the string to accomodate creating a tag.
      // This replaces consecutive whitespaces with one whitespace.
      final String modified = value.replaceAll(RegExp(r'\s+'), ' ');

      // Set the modified value back to the text field
      if (modified != value) {
        controller.value = TextEditingValue(
          text: modified,
          selection: TextSelection.collapsed(offset: modified.length),
        );
      }

      // Convert value to lower case.
      // * If null --> tag is invalid.
      final String? cleanedTag = TagsData.validateTag(value: value);

      // * Invalid tag, reset state.
      if (cleanedTag == null) {
        // Only emit new states if cubit is open.
        if (isClosed) return;

        emit(state.copyWith(
          tagsSuggestions: Tags.initial(),
          failure: Failure.initial(),
          status: EntrySheetStatus.waiting,
        ));

        return;
      }

      // Init tag suggestions.
      final Tags? suggestedTags = state.isShared == false
          ? await _localStorageCubit.getLocalTagSuggestions(
              value: cleanedTag,
            )
          : await _localStorageCubit.getSharedTagSuggestions(
              value: cleanedTag,
            );

      // Failed to fetch suggestions, alert user.
      if (suggestedTags == null) throw Failure.failureToFetchSuggestions();

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        tagsSuggestions: suggestedTags,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> tagValueChanged() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> tagValueChanged() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if user chooses a tag.
  Future<void> tagSelected({required BuildContext context, required Field field, required String value, required TextEditingController controller}) async {
    try {
      // Reset state if an empty tag was provided.
      if (value.isEmpty) {
        // Only emit new state if cubit is still open.
        if (isClosed) return;

        emit(state.copyWith(
          tagsSuggestions: Tags.initial(),
          failure: Failure.initial(),
          status: EntrySheetStatus.waiting,
        ));

        return;
      }

      // Convert value to lower case.
      // * If null --> tag is invalid.
      final String? cleanedTagLabel = TagsData.validateTag(value: value);

      // * Invalid tag, let user know.
      if (cleanedTagLabel == null) throw Failure.invalidTag();

      // Init helpers.
      TagsData tagsData = TagsData.initial();

      // * Init correct TagsData.
      if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;
      if (field.getIsMoneyField) tagsData = field.moneyData!.tagsData;
      if (field.getIsLocationField) tagsData = field.locationData!.tagsData;
      if (field.getIsTagsField) tagsData = field.tagsData!;
      if (field.getIsImagesField) tagsData = field.imageData!.tagsData;
      if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

      // Check if this is a new or an existing Tag.
      Tag? tag = state.isShared == false
          ? await _localStorageCubit.getLocalTagByLabel(
              tagLabel: cleanedTagLabel,
            )
          : await _localStorageCubit.getSharedTagByLabel(
              tagLabel: cleanedTagLabel,
            );

      // If Tag exist, check if it is already utilized in current object.
      if (tag != null) {
        // Perform check.
        final bool alreadyTagged = tagsData.tagReferences.contains(tag.tagId);

        // * Reset state, already tagged with this tag.
        if (alreadyTagged) {
          // * Clear the text field.
          controller.clear();

          // Only emit new state if cubit is still open.
          if (isClosed) return;

          emit(state.copyWith(
            tagsSuggestions: Tags.initial(),
            failure: Failure.initial(),
            status: EntrySheetStatus.waiting,
          ));

          return;
        }
      }

      // * New Tag, trigger create.
      if (tag == null) {
        // Create a new Tag.
        tag = Tag.initial().copyWith(
          label: cleanedTagLabel,
          creator: user.userId,
        );

        // Create new tag.
        tag = await _localStorageCubit.state.database!.writeTxn(() async {
          final Tag createdTag = state.isShared == false
              ? await _localStorageCubit.createLocalTag(
                  tag: tag!,
                )
              : await _localStorageCubit.createSharedTag(
                  tag: tag!,
                );

          return createdTag;
        });
      }

      // Create updated Tags object.
      final TagsData updatedTagsData = tagsData.add(
        tagId: tag.tagId,
      );

      // Prepare Payment data.
      final PaymentData? upatedPaymentData = field.paymentData?.copyWith(
        tagsData: updatedTagsData,
      );

      // Prepare Money data.
      final MoneyData? upatedMoneyData = field.moneyData?.copyWith(
        tagsData: updatedTagsData,
      );

      // Prepare location data.
      final LocationData? upatedLocationData = field.locationData?.copyWith(
        tagsData: updatedTagsData,
      );

      // Prepare images data.
      final ImageData? updatedImageData = field.imageData?.copyWith(
        tagsData: updatedTagsData,
      );

      // Prepare files data.
      final FileData? updatedFileData = field.fileData?.copyWith(
        tagsData: updatedTagsData,
      );

      // Create updated Field.
      final Field updatedField = field.copyWith(
        tagsData: field.getIsTagsField ? updatedTagsData : tagsData,
        paymentData: upatedPaymentData,
        moneyData: upatedMoneyData,
        imageData: updatedImageData,
        fileData: updatedFileData,
        locationData: upatedLocationData,
      );

      // Create updated fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Create updated entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // * Clear the text field.
      controller.clear();

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        entry: updatedEntry,
        tagsSuggestions: Tags.initial(),
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> tagSelected() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> tagSelected() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to remove a tag.
  void removeTag({required BuildContext context, required Field field, required Tag tag}) {
    // Init helpers.
    TagsData tagsData = TagsData.initial();

    // * Init correct TagsData.
    if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;
    if (field.getIsMoneyField) tagsData = field.moneyData!.tagsData;
    if (field.getIsLocationField) tagsData = field.locationData!.tagsData;
    if (field.getIsTagsField) tagsData = field.tagsData!;
    if (field.getIsImagesField) tagsData = field.imageData!.tagsData;
    if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

    // Create updated Tags object.
    final TagsData updatedTagsData = tagsData.remove(
      tagId: tag.tagId,
    );

    // Prepare Payment data.
    final PaymentData? upatedPaymentData = field.paymentData?.copyWith(
      tagsData: updatedTagsData,
    );

    // Prepare Money data.
    final MoneyData? upatedMoneyData = field.moneyData?.copyWith(
      tagsData: updatedTagsData,
    );

    // Prepare location data.
    final LocationData? updatedLocationData = field.locationData?.copyWith(
      tagsData: updatedTagsData,
    );

    // Prepare images data.
    final ImageData? updatedImageData = field.imageData?.copyWith(
      tagsData: updatedTagsData,
    );

    // Prepare files data.
    final FileData? updatedFileData = field.fileData?.copyWith(
      tagsData: updatedTagsData,
    );

    // Create updated Field.
    final Field updatedField = field.copyWith(
      tagsData: field.getIsTagsField ? updatedTagsData : tagsData,
      paymentData: upatedPaymentData,
      moneyData: upatedMoneyData,
      imageData: updatedImageData,
      fileData: updatedFileData,
      locationData: updatedLocationData,
    );

    // Create updated fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Create updated entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  // ####################################
  // # Measurement Widget
  // ####################################

  /// This method can be used to clear measurement value, category and unit.
  void resetMeasurementField({required Field field}) {
    try {
      // Access expense data of field.
      final MeasurementData measurementData = field.measurementData!;

      // Access current user timezone.
      final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Access now.
      final DateTime now = DateTime.now();
      final TimeOfDay nowTime = TimeOfDay.now();

      // Access defaults as String.
      final String nowDateAsString = DateFormat('yyyy-MM-dd').format(now);
      final String nowTimeString = HelperFunctions.formatTimeOfDayTo24Hour(timeOfDay: nowTime);

      // Create updated data.
      final MeasurementData updatedMeasurementData = MeasurementData.initial().copyWith(
        category: field.canChangeParameters || state.isDefault || state.isImportMatch ? '' : measurementData.category,
        unit: field.canChangeParameters || state.isDefault || state.isImportMatch ? '' : measurementData.unit,
        createdAtInUtc: state.isDefault || state.isImportMatch ? null : now.toUtc(),
        createdAtTimezone: state.isDefault ? null : currentTimezone,
        createdAtDefaultDate: state.isImportMatch ? nowDateAsString : null,
        createdAtDefaultTime: state.isImportMatch ? nowTimeString : null,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        // * If user is in set default mode, reset value otherwise retain it.
        canChangeParameters: state.isDefault ? true : null,
        measurementData: updatedMeasurementData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> resetMeasurementField() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> resetMeasurementField() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to let user choose from measurement categories.
  Future<void> chooseMeasurementCategory({required BuildContext context, required Field field}) async {
    try {
      // Let user know, that parameters cannot be changed.
      if (field.canChangeParameters == false && state.isDefault == false) throw Failure.cannotChangeParameters();

      // Access language specific categories.
      final PickerItems pickerItems = MeasurementData.categoriesAsPickerItems();

      // Show PickerSheet.
      final int? pickerIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.measureCategoryPickerSheetTitle(),
          pickerItems: pickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickerIndex == null) return;

      // Access chosen item.
      final String pickedItemId = pickerItems.items[pickerIndex].id;

      // Access expense data of field.
      final MeasurementData measurementData = field.measurementData!;

      // * User selected the same category, do nothing.
      if (pickedItemId == measurementData.category) return;

      // Access category units.
      final PickerItems? units = MeasurementData.unitsAsPickerItems(category: pickedItemId);

      // Category not found.
      if (units == null) throw Failure.unknownMeasureCategory();

      // Indicator about whether or not there is only one unit available for this category.
      final bool onlyOneUnit = units.items.length == 1;

      // Create updated data.
      final MeasurementData updatedMeasurementData = measurementData.copyWith(
        category: pickedItemId,
        unit: onlyOneUnit ? units.items.first.id : '', // * Reset unit whenever a new category is chosen.
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        measurementData: updatedMeasurementData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> chooseMeasurementCategory() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> chooseMeasurementCategory() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to let user choose from measurement units.
  Future<void> chooseMeasurementUnit({required BuildContext context, required Field field}) async {
    try {
      // Let user know, that parameters cannot be changed.
      if (field.canChangeParameters == false && state.isDefault == false) throw Failure.cannotChangeParameters();

      // Access expense data of field.
      final MeasurementData measurementData = field.measurementData!;

      // Access specific units.
      final PickerItems? pickerItems = MeasurementData.unitsAsPickerItems(
        category: measurementData.category,
      );

      // Category not found.
      if (pickerItems == null) throw Failure.unknownMeasureCategory();

      // Show PickerSheet.
      final int? pickerIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.measureUnitPickerSheetTitle(),
          pickerItems: pickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickerIndex == null) return;

      // Access chosen item.
      final String pickedItemId = pickerItems.items[pickerIndex].id;

      // Create updated data.
      final MeasurementData updatedMeasurementData = measurementData.copyWith(
        unit: pickedItemId,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        measurementData: updatedMeasurementData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> chooseMeasurementUnit() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> chooseMeasurementUnit() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user types in the measurement text field.
  Future<void> onMeasureValueChanged({required Field field, required String? value, required TextEditingController controller}) async {
    // Update Field.
    final Field updatedField = field.copyWith(
      measurementData: field.measurementData!.copyWith(
        value: value ?? '',
      ),
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method gets triggered if user wants to change the date of a measurement field.
  Future<void> onChooseMeasurementDate({required BuildContext context, required Field field}) async {
    try {
      // Access data.
      final MeasurementData data = field.measurementData!;

      // Access initial DateTime.
      final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
        dateTimeInUtc: data.createdAtInUtc,
        timezone: data.createdAtTimezone,
        preserveUtc: true,
      );

      // Let user choose a date.
      final DateTime? chosenLocalDate = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => DateSelector(
          initialDateTime: initialDateTime,
        ),
      );

      // User did not choose a date.
      if (chosenLocalDate == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeDate(
        localDate: chosenLocalDate,
        originalTimezoneLocation: initialDateTime.location,
      );

      // Create updated money data.
      final MeasurementData updatedMeasurementData = field.measurementData!.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        measurementData: updatedMeasurementData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMeasurementDate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMeasurementDate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to choose measurement time.
  Future<void> onChooseMeasurementTime({required BuildContext context, required Field field}) async {
    try {
      // Convert value.
      final tz.TZDateTime converted = HelperFunctions.convertToTimezone(
        dateTimeInUtc: field.measurementData!.createdAtInUtc!,
        timezone: field.measurementData!.createdAtTimezone,
        preserveUtc: true,
      );

      // Create initial.
      final TimeOfDay initialTime = TimeOfDay(
        hour: converted.hour,
        minute: converted.minute,
      );

      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeTime(
        localDate: converted,
        timeOfDay: chosenTime,
        originalTimezoneLocation: converted.location,
      );

      // Create updated money data.
      final MeasurementData updatedMeasurementData = field.measurementData!.copyWith(
        createdAtInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        measurementData: updatedMeasurementData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMeasurementTime() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChooseMeasurementTime() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Emotion Widget
  // ####################################

  /// This method can be used to show a add emotion sheet.
  Future<void> onAddEmotion({required BuildContext context, required Field field}) async {
    try {
      // Show Emotion Sheet
      final EmotionItem? emotionItem = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => BlocProvider<AddEmotionSheetCubit>(
          create: (context) => AddEmotionSheetCubit(
            localStorageCubit: _localStorageCubit,
          )..initializeCreate(),
          child: const AddEmotionSheet(),
        ),
      );

      // User cancled.
      if (emotionItem == null) return;

      // Access expense data of field.
      final EmotionData emotionData = field.emotionData!;

      // Create updated data.
      final EmotionData updated = emotionData.copyWith(
        emotions: [...emotionData.emotions, emotionItem],
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        emotionData: updated,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onAddEmotion() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onAddEmotion() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to clear an emotion field.
  void clearEmotionData({required Field field}) {
    // Create updated field.
    final Field updatedField = field.copyWith(
      emotionData: EmotionData.initial(),
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used to remove an EmotionItem from entry.
  Future<void> onRemoveEmotion({required EmotionItem emotionItem, required Field field}) async {
    // Access expense data of field.
    final EmotionData emotionData = field.emotionData!;

    // Create updated emotion data.
    final EmotionData updated = emotionData.removeById(id: emotionItem.id);

    // Create updated field.
    final Field updatedField = field.copyWith(
      emotionData: updated,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  // ####################################
  // # Payment Widget
  // ####################################

  /// This method can be used to delete payment data of a field.
  void resetPaymentData({required Field field, required TextEditingController controller}) {
    // Convenience variable.
    final PaymentData paymentData = field.paymentData!;

    // Access current user timezone.
    final String currentTimezone = HelperFunctions.getCurrentTimezone() ?? "UTC";

    // Access now.
    final DateTime now = DateTime.now();
    final TimeOfDay nowTime = TimeOfDay.now();

    // Access defaults as String.
    final String nowDateAsString = DateFormat('yyyy-MM-dd').format(now);
    final String nowTimeString = HelperFunctions.formatTimeOfDayTo24Hour(timeOfDay: nowTime);

    // Create updated payment data.
    final PaymentData updatedPaymentData = PaymentData.initial().copyWith(
      currencyCode: state.isImportMatch ? "" : paymentData.currencyCode,
      paymentDateInUtc: state.isImportMatch ? null : now.toUtc(),
      paymentDateTimezone: currentTimezone,
      paymentDateDefaultDate: state.isImportMatch ? nowDateAsString : null,
      paymentDateDefaultTime: state.isImportMatch ? nowTimeString : null,
      members: paymentData.members,
      participantReference: paymentData.participantReference,
    );

    // Create updated field.
    final Field updatedField = field.copyWith(
      paymentData: updatedPaymentData,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Clear controller.
    controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used to access members of a referenced participant.
  /// * Updates state expense members variable.
  Future<Entry> initializePaymentMembers({required Entry entry, required bool isImportMatch, required bool isShared, required Group fromGroup}) async {
    // Create a copy of the original object.
    Entry stateEntry = entry;

    // Go through fields and init members if needed.
    for (final Field field in entry.fields.items) {
      // Skip non expense fields.
      if (field.fieldType != Field.fieldTypePayment) continue;

      // Access members of participant.
      final Members participantMembers = isShared
          ? await _localStorageCubit.getSharedMembersOfParticipant(
              participantId: fromGroup.participantReference,
              rootGroupReference: fromGroup.rootGroupReference,
              referenceType: fromGroup.getReferenceType,
              referenceId: fromGroup.groupId,
            )
          : await _localStorageCubit.getLocalMembersOfParticipant(
              participantId: fromGroup.participantReference,
            );

      // * In case this is a import match, do not initialize payment members because
      // * only participant members should be shown.
      if (isImportMatch) {
        // Init paid by in case this is in create mode and only one member is available.
        final bool shouldInitPaidBy = state.isEdit == false && participantMembers.items.length == 1;

        // Create updated expense data.
        final PaymentData updatedExpenseData = field.paymentData!.copyWith(
          members: participantMembers,
          paidById: shouldInitPaidBy ? participantMembers.items.first.memberId : field.paymentData!.paidById,
        );

        // Create updated field.
        final Field updatedField = field.copyWith(
          paymentData: updatedExpenseData,
        );

        // Update Fields.
        final Fields updatedFields = stateEntry.fields.updateField(
          updatedField: updatedField,
        );

        // Update Entry.
        stateEntry = stateEntry.copyWith(
          fields: updatedFields,
        );

        continue;
      }

      // Access involved members of this expense data. This is needed because it could be that a
      // referenced member gets removed from a participant. In that case member will still
      // be available in storage and should still be displayed.
      List<String> involvedMembers = field.paymentData!.involvedMemberIds;

      // Compare involved Member ids to participantMembers and remove those that are already available.
      for (final Member member in participantMembers.items) {
        if (involvedMembers.contains(member.memberId)) involvedMembers.remove(member.memberId);
      }

      // Access references that are not in state yet.
      // * In case this is a import match, do not initialize payment members because
      // * only participant members should be shown.
      final Members referencedMembers = isShared
          ? await _localStorageCubit.getSharedReferencedMembers(
              references: involvedMembers,
              rootGroupReference: fromGroup.rootGroupReference,
              referenceType: fromGroup.getReferenceType,
              referenceId: fromGroup.groupId,
            )
          : await _localStorageCubit.getReferencedLocalMembers(
              references: involvedMembers,
            );

      // Join members.
      final Members members = await participantMembers.addUniqueMembers(
        members: referencedMembers,
      );

      // Init paid by in case this is in create mode and only one member is available.
      final bool shouldInitPaidBy = state.isEdit == false && members.items.length == 1;

      // Create updated expense data.
      final PaymentData updatedExpenseData = field.paymentData!.copyWith(
        members: members,
        paidById: shouldInitPaidBy ? members.items.first.memberId : field.paymentData!.paidById,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        paymentData: updatedExpenseData,
      );

      // Update Fields.
      final Fields updatedFields = stateEntry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      stateEntry = stateEntry.copyWith(
        fields: updatedFields,
      );
    }

    return stateEntry;
  }

  /// This method gets triggered if user wants to change the payment date of an expense.
  Future<void> onChoosePaymentDate({required BuildContext context, required Field field}) async {
    // Access data.
    final PaymentData data = field.paymentData!;

    // Access initial DateTime.
    final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
      dateTimeInUtc: data.paymentDateInUtc!,
      timezone: data.paymentDateTimezone,
      preserveUtc: true,
    );

    // Let user choose a date.
    final DateTime? chosenLocalDate = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) => DateSelector(
        initialDateTime: initialDateTime,
      ),
    );

    // User did not choose a date.
    if (chosenLocalDate == null) return;

    // Create updated object.
    final tz.TZDateTime changedInLocal = HelperFunctions.changeDate(
      localDate: chosenLocalDate,
      originalTimezoneLocation: initialDateTime.location,
    );

    // Create updated expense data.
    final PaymentData updatedExpenseData = field.paymentData!.copyWith(
      paymentDateInUtc: changedInLocal.toUtc(),
    );

    // Create updated field.
    final Field updatedField = field.copyWith(
      paymentData: updatedExpenseData,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method can be used to set the time of a payment field.
  Future<void> onChoosePaymentTime({required BuildContext context, required Field field}) async {
    try {
      // Convert value.
      final tz.TZDateTime converted = HelperFunctions.convertToTimezone(
        dateTimeInUtc: field.paymentData!.paymentDateInUtc!,
        timezone: field.paymentData!.paymentDateTimezone,
        preserveUtc: true,
      );

      // Create initial.
      final TimeOfDay initialTime = TimeOfDay(
        hour: converted.hour,
        minute: converted.minute,
      );

      // Let user choose a time.
      final TimeOfDay? chosenTime = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        showDragHandle: true,
        builder: (context) => TimeSelector(
          minutesInterval: 1,
          initialTime: initialTime,
        ),
      );

      // User did not choose a time.
      if (chosenTime == null) return;

      // Create updated object.
      final tz.TZDateTime changedInLocal = HelperFunctions.changeTime(
        localDate: converted,
        timeOfDay: chosenTime,
        originalTimezoneLocation: converted.location,
      );

      // Create updated payment data.
      final PaymentData updatedData = field.paymentData!.copyWith(
        paymentDateInUtc: changedInLocal.toUtc(),
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        paymentData: updatedData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChoosePaymentTime() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onChoosePaymentTime() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user changes the total amount of a expense.
  void onTotalAmountChanged({required Field field, required String? value, required TextEditingController controller, required String fieldName}) {
    try {
      // Access expense data of field.
      final PaymentData expenseData = field.paymentData!;

      // Turn value into default number format.
      final String converted = NumberData.convertToDefaultNumberFormat(value: value ?? '', absoluteValue: true);

      // Access number of members.
      int numberOfMembers = expenseData.members.items.length;

      // Create updated expense data.
      PaymentData updatedExpenseData = expenseData.copyWith(
        total: converted,
      );

      // Set controller text.
      controller.text = converted;

      // In case user selected distribute equally update share references.
      if (expenseData.distributeEqually) {
        // Is valid total.
        final bool isValidNumber = NumberData.numberValidator(input: converted);

        // Ensure that value is not to long.
        final bool tooManyChars = NumberData.tooManyNumberCharacters(input: converted);

        // Access value.
        final double? number = double.tryParse(converted);

        // Should calculate shares.
        final bool shouldCalc = isValidNumber && tooManyChars == false && number != null && number > 0;

        // * Update share reference depending on distribution.
        final ShareReferences shareReferences = shouldCalc
            ? expenseData.shareReferences.equalShareDistribution(
                amount: number / numberOfMembers,
              )
            : expenseData.shareReferences.equalShareDistribution(
                amount: 0.0,
              );

        // Create updated expense data.
        updatedExpenseData = updatedExpenseData.copyWith(
          shareReferences: shareReferences,
        );
      }

      // Create updated field.
      final Field updatedField = field.copyWith(
        paymentData: updatedExpenseData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onTotalAmountChanged() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onTotalAmountChanged() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user changes the currency of a expense.
  Future<void> onSelectExpenseCurrency({required BuildContext context, required Field field}) async {
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

    // Access expense data of field.
    final PaymentData expenseData = field.paymentData!;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));

    // Create updated expense data.
    final PaymentData updatedExpenseData = expenseData.copyWith(
      currencyCode: countrySpecification.currencyCode,
    );

    // Create updated field.
    final Field updatedField = field.copyWith(
      paymentData: updatedExpenseData,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method gets triggered if user changes who payed for a expense.
  Future<void> onSelectPaidBy({required BuildContext context, required int paidByIndex, required Members members, required Field field}) async {
    // Access language specific group types.
    final PickerItems pickerItems = members.toPickerItems();

    // Show PickerSheet.
    final int? pickerIndex = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => PickerSheet(
        pickerItems: pickerItems,
        initialItem: paidByIndex == -1 ? 0 : paidByIndex,
      ),
    );

    // * User did not pick an item.
    if (pickerIndex == null) return;

    // Access chosen item.
    final String pickedMemberId = pickerItems.items[pickerIndex].id;

    // Access expense data of field.
    final PaymentData expenseData = field.paymentData!;

    // Create updated expense data.
    final PaymentData updatedExpenseData = expenseData.copyWith(
      paidById: pickedMemberId,
    );

    // Create updated field.
    final Field updatedField = field.copyWith(
      paymentData: updatedExpenseData,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));

    return;
  }

  /// This method gets triggered if user changes is compensated switch.
  void onIsCompensatedChanged({required BuildContext context, required bool value, required Field field}) {
    // Access expense data of field.
    final PaymentData expenseData = field.paymentData!;

    // Create updated expense data.
    final PaymentData updatedExpenseData = expenseData.copyWith(
      isCompensated: value,
    );

    // Create updated field.
    final Field updatedField = field.copyWith(
      paymentData: updatedExpenseData,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method gets triggered if user changes distribute equally switch.
  void onDistributeEquallyChanged({required BuildContext context, required bool value, required Field field, required String fieldName}) {
    try {
      // Access expense data of field.
      final PaymentData expenseData = field.paymentData!;

      // Access number of members.
      final int numberOfMembers = expenseData.shareReferences.items.length;

      // Turn value into default number format.
      final String converted = NumberData.convertToDefaultNumberFormat(value: field.paymentData!.total, absoluteValue: true);

      // Is valid total.
      final bool isValidNumber = NumberData.numberValidator(input: converted);

      // Ensure that value is not to long.
      final bool tooManyChars = NumberData.tooManyNumberCharacters(input: converted);

      // Access value.
      final double? number = double.tryParse(converted);

      // Should calculate shares.
      final bool shouldCalc = isValidNumber && tooManyChars == false && number != null && number > 0;

      // Calculate the shared amount.
      final double sharedAmount = shouldCalc ? number / numberOfMembers : 0.0;

      // Create updated expense data.
      final PaymentData updatedExpenseData = expenseData.copyWith(
        distributeEqually: value,
        // * Copy share reference depending on distribute qually.
        shareReferences: value ? expenseData.shareReferences.equalShareDistribution(amount: sharedAmount) : null,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        paymentData: updatedExpenseData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDistributeEquallyChanged() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onDistributeEquallyChanged() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method gets triggered if user selects a member in a expense.
  void onMemberSelected({required bool? isSelected, required String memberId, required Field field}) {
    // * It could be that checkbox returns null as a value. In this case do nothing.
    if (isSelected == null) return;

    // Access expense data of field.
    PaymentData expenseData = field.paymentData!;

    // * User decided to include this member in expense.
    if (isSelected) {
      // Init ref.
      final ShareReference shareReference = ShareReference(
        id: memberId,
        value: "",
      );

      // * Create updated share references that has added value added.
      ShareReferences updatedShareReferences = expenseData.shareReferences.addShareReference(
        shareReference: shareReference,
      );

      // Update expense Data.
      expenseData = expenseData.copyWith(
        shareReferences: updatedShareReferences,
      );
    }

    // * User decided to exclude this member in expense.
    if (isSelected == false) {
      // * Create updated share references that has added value added.
      ShareReferences updatedShareReferences = expenseData.shareReferences.remove(
        id: memberId,
      );

      // Update expense Data.
      expenseData = expenseData.copyWith(
        shareReferences: updatedShareReferences,
      );
    }

    // Check if total is a valid number.
    // * This returns false if the value is empty.
    final bool validNumber = NumberData.numberValidator(input: expenseData.total);

    // Ensure that value is not to big.
    final bool tooManyChars = NumberData.tooManyNumberCharacters(input: expenseData.total);

    // In case value is valid, check if shareReferences should get updated.
    if (validNumber && tooManyChars == false && expenseData.totalAsDouble > 0) {
      // Access number of currently selected members.
      final int numberOfCurrentlySelectedMembers = expenseData.shareReferences.items.length;

      // In case user wants to distribute equally among members, calculate equal shares.
      if (expenseData.distributeEqually) {
        // Calculate the shared amount.
        final double sharedAmount = expenseData.totalAsDouble / numberOfCurrentlySelectedMembers;

        // Create updated references.
        final ShareReferences equalReferences = expenseData.shareReferences.equalShareDistribution(
          amount: sharedAmount,
        );

        // Create updated expense data.
        expenseData = expenseData.copyWith(
          shareReferences: equalReferences,
        );
      }
    }

    // Create updated field.
    final Field updatedField = field.copyWith(
      paymentData: expenseData,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
    ));
  }

  /// This method gets triggered if user assigns a value to a member in a expense.
  void onMemberValueChanged({required Field field, required String? value, required TextEditingController controller, required String memberId}) {
    try {
      // Access expense data of field.
      final PaymentData expenseData = field.paymentData!;

      // Access currently relevant share reference.
      final ShareReference currentShareReference = expenseData.shareReferences.getById(id: memberId)!;

      // Convert value to default number format.
      final String converted = NumberData.convertToDefaultNumberFormat(value: value ?? '', absoluteValue: true);

      // Update controller.
      controller.text = converted;

      // Update the share reference.
      final ShareReference updatedShareReference = currentShareReference.copyWith(
        value: converted,
      );

      // * Update share reference depending on distribution.
      final ShareReferences shareReferences = expenseData.shareReferences.updateShareReference(
        updatedShareReference: updatedShareReference,
      );

      // Update expense data.
      final PaymentData updatedExpenseData = expenseData.copyWith(
        shareReferences: shareReferences,
      );

      // Create updated field.
      final Field updatedField = field.copyWith(
        paymentData: updatedExpenseData,
      );

      // Update Fields.
      final Fields updatedFields = state.entry.fields.updateField(
        updatedField: updatedField,
      );

      // Update Entry.
      final Entry updatedEntry = state.entry.copyWith(
        fields: updatedFields,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        entry: updatedEntry,
        failure: Failure.initial(),
        status: EntrySheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onMemberValueChanged() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> onMemberValueChanged() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Defaults
  // ####################################

  /// This method can be used to change the canChangeParamters value.
  void onChangeCanChangeParameters({required Field field}) {
    // Create updated field.
    final Field updatedField = field.copyWith(
      canChangeParameters: !field.canChangeParameters,
    );

    // Update Fields.
    final Fields updatedFields = state.entry.fields.updateField(
      updatedField: updatedField,
    );

    // Update Entry.
    final Entry updatedEntry = state.entry.copyWith(
      fields: updatedFields,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      entry: updatedEntry,
      failure: Failure.initial(),
      status: EntrySheetStatus.waiting,
    ));
  }

  /// This method will be triggerd if user wants to set a default for themselves for a local model entry.
  /// * Sets default values in relevant model entry prefs of current user.
  Future<void> setLocalDefaultForSelf() async {
    try {
      // Display failure if nothing has changed.
      if (state.initialEntry == state.entry) {
        if (state.isEdit) throw Failure.nothingWasEdited();
        throw Failure.noEntryDataProvided();
      }

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateDefault(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: state.isDefault, isImport: state.isImportMatch);

      // Can be used to validate fields.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: true,
        isImport: false,
      );

      // Copy entry with sanitized and validated fields.
      final Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Set default fields in model entry prefs.
      final ModelEntryPrefs updatedPrefs = await state.entryModel.setDefaultFields(
        entry: entry,
        isSelfDefault: true,
      );

      // Update model entry with new prefs.
      final ModelEntry updatedModelEntry = state.entryModel.copyWith(
        modelEntryPrefs: updatedPrefs,
      );

      await _localStorageCubit.state.database!.writeTxn(() async {
        // Update shared model entry.
        await _localStorageCubit.putLocalModelEntryPrefs(
          modelEntryId: state.entryModel.modelEntryId,
          modelEntryPrefs: updatedPrefs,
        );

        // * Update dependent cubits.
        if (_menuSheetCubit != null) {
          _menuSheetCubit.onEntryModelEdited(editedEntryModel: updatedModelEntry);
        }

        // * Update dependent cubits.
        await _mainScreenCubit.onModelEntryEdited(modelEntry: updatedModelEntry);

        // Show notification.
        _appMessagesCubit.showNotification(
          message: labels.basicLabelsDefaultCreated(),
        );

        // Only emit new states if cubit is open.
        if (isClosed) return;

        emit(state.copyWith(
          status: EntrySheetStatus.close,
        ));
      });
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setLocalDefaultForSelf() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setLocalDefaultForSelf() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if user wants to set a default for themselves for a shared model entry.
  /// * Sets default values in relevant model entry prefs of current user.
  Future<void> setSharedDefaultForSelf() async {
    try {
      // Display failure if nothing has changed.
      if (state.initialEntry == state.entry) throw Failure.noEntryDataProvided();

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateDefault(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: state.isDefault, isImport: state.isImportMatch);

      // Can be used to validate fields.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: true,
        isImport: false,
      );

      // Create final entry, which is ready for storage insert.
      final Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Set default fields in model entry prefs.
      final ModelEntryPrefs updatedPrefs = await state.entryModel.setDefaultFields(
        entry: entry,
        isSelfDefault: true,
      );

      // Update model entry with new prefs.
      final ModelEntry updatedModelEntry = state.entryModel.copyWith(
        modelEntryPrefs: updatedPrefs,
      );

      // Update shared model entry.
      await _localStorageCubit.putSelfSharedModelEntryPrefs(
        modelEntryId: state.entryModel.modelEntryId,
        modelEntryPrefs: updatedPrefs,
        isSelfDefault: true,
      );

      // * Update dependent cubits.
      if (_menuSheetCubit != null) {
        _menuSheetCubit.onEntryModelEdited(editedEntryModel: updatedModelEntry);
      }

      // * Update dependent cubits.
      await _mainScreenCubit.onModelEntryEdited(modelEntry: updatedModelEntry);

      // Show notification.
      _appMessagesCubit.showNotification(
        message: labels.basicLabelsDefaultCreated(),
      );

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setSharedDefaultForSelf() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setSharedDefaultForSelf() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggerd if user wants to set a default for everyone.
  /// * Sets default values directly in the relevant model entry.
  Future<void> setSharedDefaultForEveryone() async {
    try {
      // Display failure if nothing has changed.
      if (state.initialEntry == state.entry) throw Failure.noEntryDataProvided();

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateDefault(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: state.isDefault, isImport: state.isImportMatch);

      // Can be used to validate fields.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: true,
        isImport: false,
      );

      // Create final entry, which is ready for storage insert.
      final Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Set default fields in model entry prefs.
      final ModelEntryPrefs updatedPrefs = await state.entryModel.setDefaultFields(
        entry: entry,
        isSelfDefault: false,
      );

      // Update model entry with new prefs.
      final ModelEntry updatedModelEntry = state.entryModel.copyWith(
        modelEntryPrefs: updatedPrefs,
      );

      // Update shared model entry.
      await _localStorageCubit.putSelfSharedModelEntryPrefs(
        modelEntryId: state.entryModel.modelEntryId,
        modelEntryPrefs: updatedPrefs,
        isSelfDefault: false,
      );

      // * Update dependent cubits.
      if (_menuSheetCubit != null) {
        _menuSheetCubit.onEntryModelEdited(editedEntryModel: updatedModelEntry);
      }

      // * Update dependent cubits.
      await _mainScreenCubit.onModelEntryEdited(modelEntry: updatedModelEntry);

      // Show notification.
      _appMessagesCubit.showNotification(
        message: labels.basicLabelsDefaultCreated(),
      );

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setSharedDefaultForEveryone() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setSharedDefaultForEveryone() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Database Local
  // ####################################

  /// This method will be triggered if user wants to create a new local entry.
  Future<void> createLocalEntry({required BuildContext context, required String notification}) async {
    try {
      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateEntry(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * This is here for better UX.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // An entry name is required.
      if (state.entry.entryName.trim().isEmpty) throw Failure.failureEntryNameRequired();

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: false, isImport: state.isImportMatch);

      // Can be used to validate fields.
      // * This also checks if required fields are set.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: false,
        isImport: false,
      );

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Create final entry, which is ready for storage insert.
      Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Get all files of entry.
      final Files entryFiles = state.entry.getAllFilesOfEntry(onlyImages: false);

      // Access number of files.
      final int numberOfFiles = entryFiles.items.length;

      // Save files.
      for (int i = 0; i < numberOfFiles; i++) {
        // Access imageItem.
        final FileItem fileItem = entryFiles.items[i];

        // Make sure bytes are not null.
        if (fileItem.bytes == null) continue;

        // Emit loading message.
        if (isClosed == false) {
          emit(state.copyWith(
            pageLoadingMessage: labels.entrySheetCubitSaveImages(
              currentImage: i,
              totalImages: numberOfFiles,
              wantEncryption: state.fromGroup.isEncrypted,
            ),
          ));
        }

        // Access file path of image.
        final String filePath = await _localStorageCubit.createLocalFilePath(
          groupId: state.fromGroup.groupId,
          relativePath: fileItem.relativePath,
        );

        // Access the correct MimeType.
        final String? mimeType = FileItem.getMimeType(extension: fileItem.type);

        // This should never happen.
        if (mimeType == null) {
          // Output debug message.
          debugPrint('EntrySheetCubit --> createLocalEntry() --> Unknown mimeType for fileItem. Skip file creation.');
          continue;
        }

        // Perform image creation.
        // * Files with the same path will be overwritten.
        await _localStorageCubit.putLocalFile(
          filePath: filePath,
          bytes: fileItem.bytes!,
          mimeType: mimeType,
          secrets: secrets,
          encrypt: state.fromGroup.isEncrypted,
        );
      }

      // Create local entry.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Add reference.
        await _localStorageCubit.createLocalGroupToEntryReference(
          group: state.fromGroup,
          entry: entry,
          addedBy: user.userId,
        );

        // Add entry to local storage.
        entry = await _localStorageCubit.createLocalEntry(
          entry: entry,
          encrypt: state.fromGroup.isEncrypted,
          secrets: secrets,
        );

        // Create recent item.
        await _localStorageCubit.putLocalRecentEntry(
          entryId: state.entry.entryId,
          rootGroupReference: state.fromGroup.rootGroupReference,
          groupReference: state.fromGroup.groupId,
        );

        // * Update dependent cubits.
        if (_localGroupSelectedSheetCubit != null) {
          await _localGroupSelectedSheetCubit.onEntryAddedToGroup(entry: entry);
        }

        // * Update dependent cubits.
        await _mainScreenCubit.onEntryCreated(
          entry: entry,
          modelEntry: state.entryModel,
          fromGroup: state.fromGroup,
        );
      });

      // Go through fields and set local notification for birthdays.
      // * This should be done after entry creation.
      // * Ignore errors, because users can manually set afterwards if it does not work.
      if (_localNotificationsCubit.state.getCanSetNotifications) {
        await entry.fields.setAutoNotifications(
          groupId: state.fromGroup.groupId,
          localNotificationsCubit: _localNotificationsCubit,
          entrySelectedSheetCubit: _entrySelectedSheetCubit,
          entryId: entry.entryId,
          entryName: entry.entryName,
        );
      }

      // Show notification.
      _appMessagesCubit.showNotification(
        message: notification,
      );

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> createLocalEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> createLocalEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to update an existing entry.
  Future<void> editLocalEntry({required BuildContext context}) async {
    try {
      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateEntry(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * This is here for better UX.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // An entry name is required.
      if (state.entry.entryName.trim().isEmpty) throw Failure.failureEntryNameRequired();

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: false, isImport: false);

      // Can be used to validate fields.
      // * This also checks if required fields are set.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: false,
        isImport: false,
      );

      // Create final entry, which is ready for storage insert.
      Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Check if entry differs from initial.
      if (entry.isEqualTo(entry: state.initialEntry, isDefault: false, isImport: false)) throw Failure.nothingWasEdited();

      // Sanitize notifications.
      // * This will remove notifications of deleted fields.
      await _localNotificationsCubit.sanitizeEntryNotifications(
        groupId: state.fromGroup.groupId,
        initialEntry: state.initialEntry,
        entry: state.entry,
      );

      // Get all files of initial entry.
      final Files allInitialFiles = state.initialEntry.getAllFilesOfEntry(onlyImages: false);

      // Get all files of entry.
      final Files allFiles = state.entry.getAllFilesOfEntry(onlyImages: false);

      // Get created images which are not in initial files.
      final Files newFiles = allFiles.notIn(other: allInitialFiles);

      // Access number of new files.
      final int numberOfNewFiles = newFiles.items.length;

      // Create new images.
      for (int i = 0; i < numberOfNewFiles; i++) {
        // Access imageItem.
        final FileItem fileItem = newFiles.items[i];

        // Emit loading message.
        if (isClosed == false) {
          emit(state.copyWith(
            pageLoadingMessage: labels.entrySheetCubitSaveImages(
              currentImage: i,
              totalImages: numberOfNewFiles,
              wantEncryption: state.fromGroup.isEncrypted,
            ),
          ));
        }

        // Make sure bytes are not null.
        // * In theory this should never happen.
        if (fileItem.bytes == null) continue;

        // Access the fieldId of image up for creation.
        final String? fieldId = state.entry.fields.getFieldIdOfFile(fileItem: fileItem);

        // This should never happen.
        if (fieldId == null) {
          // Output debug message.
          debugPrint('EntrySheetCubit --> editLocalEntry() --> field id not found for fileItem. Skip file creation.');
          continue;
        }

        // Access file path of image.
        final String filePath = await _localStorageCubit.createLocalFilePath(
          groupId: state.fromGroup.groupId,
          relativePath: fileItem.relativePath,
        );

        // Access the correct MimeType.
        final String? mimeType = FileItem.getMimeType(extension: fileItem.type);

        // This should never happen.
        if (mimeType == null) {
          // Output debug message.
          debugPrint('EntrySheetCubit --> editLocalEntry() --> Unknown mimeType for fileItem. Skip file creation.');
          continue;
        }

        // Perform image creation.
        // * Files with the same path will be overwritten.
        await _localStorageCubit.putLocalFile(
          filePath: filePath,
          bytes: fileItem.bytes!,
          mimeType: mimeType,
          secrets: secrets,
          encrypt: state.fromGroup.isEncrypted,
        );
      }

      // Update entry in local storage.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Create edited entry.
        entry = await _localStorageCubit.editLocalEntry(
          editedEntry: entry,
          isEdit: true,
          secrets: secrets,
        ) as Entry;

        // Update group to entry reference if entry created at changed.
        if (state.initialEntry.createdAtInUtc != state.entry.createdAtInUtc) {
          await _localStorageCubit.updateEntryCreatedAtOfLocalGroupToEntryReferences(entry: entry);
        }

        // Create recent item.
        await _localStorageCubit.putLocalRecentEntry(
          entryId: entry.entryId,
          rootGroupReference: state.fromGroup.rootGroupReference,
          groupReference: state.fromGroup.groupId,
        );
      });

      // Go through fields and set local notification for birthdays.
      // * This should be done after entry creation.
      // * Ignore errors, because users can manually set afterwards if it does not work.
      if (_localNotificationsCubit.state.getCanSetNotifications) {
        await entry.fields.setAutoNotifications(
          groupId: state.fromGroup.groupId,
          localNotificationsCubit: _localNotificationsCubit,
          entrySelectedSheetCubit: _entrySelectedSheetCubit,
          entryId: entry.entryId,
          entryName: entry.entryName,
        );
      }

      // Delete files from local storage.
      // * Failure should not interrupt process. This might result in some orphan files but that is irrelevant.
      for (final FileItem fileItem in state.deletedFiles.items) {
        // Access the fieldId of file up for deletion.
        // * It is curcial that initialEntry is used here because state.entry does not hold this file anymore.
        final String? fieldId = state.initialEntry.fields.getFieldIdOfFile(fileItem: fileItem);

        // File was not found in fields. In theory this should never happen.
        if (fieldId == null) {
          // Output debug message.
          debugPrint('EntrySheetCubit --> editLocalEntry() --> fieldId was not found for delete files.');

          continue;
        }

        // Access file path of file.
        final String filePath = await _localStorageCubit.createLocalFilePath(
          groupId: state.fromGroup.groupId,
          relativePath: fileItem.relativePath,
        );

        // Perform file delete.
        // * Failure is irrelevant.
        await _localStorageCubit.deleteLocalFile(filePath: filePath);
      }

      // * Update dependent cubits.
      if (_localGroupSelectedSheetCubit != null) {
        await _localGroupSelectedSheetCubit.onEntryEdited(editedEntry: entry);
      }

      // * Update dependent cubits.
      if (_viewEntriesSheetCubit != null) {
        await _viewEntriesSheetCubit.onEntryEdited(editedEntry: entry);
      }

      // * Update dependent cubits.
      if (_entrySelectedSheetCubit != null) {
        await _entrySelectedSheetCubit.onEntryEdited(editedEntry: entry);
      }

      // * Let main screen know.
      await _mainScreenCubit.onEntryInteracted(
        entry: entry,
        modelEntry: state.entryModel,
        fromGroup: state.fromGroup,
      );

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.entrySelectedSheetEntryEditedNotification(),
      );

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> editLocalEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> editLocalEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to set a local import template.
  Future<void> setLocalImportTemplate() async {
    try {
      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateEntry(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * Microservice for UI update.
      await Future.delayed(const Duration(milliseconds: 100));

      // An entry name is required.
      if (state.entry.entryName.trim().isEmpty) throw Failure.failureEntryNameDefaultRequired();

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: false, isImport: true);

      // Can be used to validate fields.
      // * This also checks if required fields are set.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: false,
        isImport: true,
      );

      // Update ImportSpecifications.
      final ImportSpecifications updatedSpecs = state.entryModel.importSpecifications!.copyWith(
        entryNameDefault: state.entry.entryName,
        fields: fields,
      );

      // Update ModelEntry with import template fields.
      final ModelEntry updated = state.entryModel.copyWith(
        importSpecifications: updatedSpecs,
      );

      // Update local storage.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Add entry model to local storage.
        await _localStorageCubit.editLocalModelEntry(
          updatedModelEntry: updated,
        );
      });

      // * Update dependent cubits.
      if (_menuSheetCubit != null) {
        _menuSheetCubit.onEntryModelEdited(editedEntryModel: updated);
      }

      // Update dependent cubits.
      if (_importDataSheetCubit != null) {
        _importDataSheetCubit.onTemplateCreated(modelEntry: updated);
      }

      // * Update dependent cubits.
      _mainScreenCubit.onModelEntryEdited(modelEntry: updated);

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setLocalImportTemplate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> setLocalImportTemplate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to fix exchange rate issues.
  Future<void> validateExchangeRateFix() async {
    try {
      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateEntry(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * This is here for better UX.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // An entry name is required.
      if (state.entry.entryName.trim().isEmpty) throw Failure.failureEntryNameRequired();

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: false, isImport: false);

      // Can be used to validate fields.
      // * This also checks if required fields are set.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: false,
        isImport: false,
      );

      // Create final entry, which is ready for storage insert.
      Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Check if entry differs from initial.
      if (entry.isEqualTo(entry: state.initialEntry, isDefault: false, isImport: false)) throw Failure.nothingWasEdited();

      // * Ensure that exchange rates are now valid!
      await _localStorageCubit.validateExchangeRatesOfEntry(
        entry: entry,
        fieldIdentifications: state.entryModel.fieldIdentifications,
        defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
      );

      // Sanitize notifications.
      // * This will remove notifications of deleted fields.
      await _localNotificationsCubit.sanitizeEntryNotifications(
        groupId: state.fromGroup.groupId,
        initialEntry: state.initialEntry,
        entry: state.entry,
      );

      // Update entry in local storage.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Create edited entry.
        entry = await _localStorageCubit.editLocalEntry(
          editedEntry: entry,
          isEdit: true,
          secrets: secrets,
        ) as Entry;

        // Update group to entry reference if entry created at changed.
        if (state.initialEntry.createdAtInUtc != state.entry.createdAtInUtc) {
          await _localStorageCubit.updateEntryCreatedAtOfLocalGroupToEntryReferences(entry: entry);
        }
      });

      // * Update dependent cubits.
      if (_localGroupSelectedSheetCubit != null) {
        await _localGroupSelectedSheetCubit.onEntryEdited(editedEntry: entry);
      }

      // * Update dependent cubits.
      if (_viewEntriesSheetCubit != null) {
        await _viewEntriesSheetCubit.onEntryEdited(editedEntry: entry);
      }

      // * Update dependent cubits.
      await _mainScreenCubit.onEntryEdited(editedEntry: entry);

      // * Update dependet cubits.
      await _provideExchangeRatesSheetCubit!.onExchangeRatesFixed(entry: entry);

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> validateExchangeRateFix() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> validateExchangeRateFix() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  // ####################################
  // # Database Cloud
  // ####################################

  /// This method will be triggered if user wants to create a new shared entry.
  Future<void> createSharedEntry({required BuildContext context, required String notification}) async {
    try {
      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateEntry(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // * Microservice for UI update.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // An entry name is required.
      if (state.entry.entryName.trim().isEmpty) throw Failure.failureEntryNameRequired();

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: false, isImport: false);

      // Can be used to validate fields.
      // * This also checks if required fields are set.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: false,
        isImport: false,
      );

      // Create final entry, which is ready for storage insert.
      Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Check if this entry contains fields which are not cloud eligible.
      entry.isCloudEligible();

      // Validate and access exchange rates.
      await _localStorageCubit.validateExchangeRatesOfEntry(
        entry: entry,
        defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
        fieldIdentifications: state.entryModel.fieldIdentifications,
      );

      // Create entry in the cloud.
      final Entry createdEntry = await _localStorageCubit.createSharedEntry(
        entry: entry,
        rootGroupReference: state.fromGroup.rootGroupReference,
        referenceType: state.fromGroup.getReferenceType,
        referenceId: state.fromGroup.groupId,
      );

      // * Update dependent cubits.
      if (_sharedGroupSelectedSheetCubit != null) {
        await _sharedGroupSelectedSheetCubit.onEntryAddedToGroup(entry: createdEntry, modelEntry: state.entryModel);
      }

      // * Update dependent cubits.
      await _mainScreenCubit.onEntryCreated(
        entry: createdEntry,
        modelEntry: state.entryModel,
        fromGroup: state.fromGroup,
      );

      // Update recent items. Do not await for smoother UI ex.
      _localStorageCubit.putSharedRecentEntry(
        entryId: createdEntry.entryId,
        groupReference: state.fromGroup.groupId,
      );

      // Show notification.
      _appMessagesCubit.showNotification(
        message: notification,
      );

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> createSharedEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> createSharedEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }

  /// This method can be used to edit a shared entry.
  Future<void> editSharedEntry({required BuildContext context}) async {
    try {
      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Update state with loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        pageLoadingMessage: labels.entrySheetCubitValidateEntry(),
        status: EntrySheetStatus.pageIsLoading,
      ));

      // An entry name is required.
      if (state.entry.entryName.trim().isEmpty) throw Failure.failureEntryNameRequired();

      // * Sanitize fields.
      final Fields fields = state.entry.fields.sanitizeFields(isDefault: false, isImport: false);

      // Can be used to validate fields.
      // * This also checks if required fields are set.
      await fields.validateFields(
        fieldIdentifications: state.entryModel.fieldIdentifications,
        isDefault: false,
        isImport: false,
      );

      // Create final entry, which is ready for storage insert.
      Entry entry = state.entry.copyWith(
        fields: fields,
      );

      // Check if entry differs from initial.
      if (entry.isEqualTo(entry: state.initialEntry, isDefault: false, isImport: false)) throw Failure.nothingWasEdited();

      // Make sure entry is still cloud eligble.
      entry.isCloudEligible();

      // Validate and access exchange rates.
      await _localStorageCubit.validateExchangeRatesOfEntry(
        entry: entry,
        defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
        fieldIdentifications: state.entryModel.fieldIdentifications,
      );

      // Sanitize notifications.
      // * This will remove notifications of deleted fields.
      await _localNotificationsCubit.sanitizeEntryNotifications(
        groupId: state.fromGroup.groupId,
        initialEntry: state.initialEntry,
        entry: state.entry,
      );

      // Edit shared entry.
      entry = await _localStorageCubit.editSharedEntry(
        entry: entry,
        rootGroupReference: state.fromGroup.rootGroupReference,
        referenceType: state.fromGroup.getReferenceType,
        referenceId: state.fromGroup.groupId,
      );

      // Update recent items. Do not await for smoother UI ex.
      _localStorageCubit.putSharedRecentEntry(
        entryId: entry.entryId,
        groupReference: state.fromGroup.groupId,
      );

      // * Update dependent cubits.
      if (_sharedGroupSelectedSheetCubit != null) {
        await _sharedGroupSelectedSheetCubit.onEntryEdited(editedEntry: entry);
      }

      // * Update dependent cubits.
      if (_entrySelectedSheetCubit != null) {
        await _entrySelectedSheetCubit.onEntryEdited(editedEntry: entry);
      }

      // * Let main screen know.
      await _mainScreenCubit.onEntryInteracted(
        entry: entry,
        modelEntry: state.entryModel,
        fromGroup: state.fromGroup,
      );

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.entrySelectedSheetEntryEditedNotification(),
      );

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> editSharedEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('EntrySheetCubit --> editSharedEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        pageLoadingMessage: '',
        status: EntrySheetStatus.failure,
      ));
    }
  }
}
