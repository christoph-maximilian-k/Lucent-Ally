import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Config.
import '/config/app_durations.dart';

// Repositiories.
import '/data/repositories/local_notifications/local_notifications_repository.dart';
import '/data/repositories/location/location_repository.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/entries/entry.dart';
import '/data/models/groups/group.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/entries/entries.dart';
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/fields/field.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/cubit/charts_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/cubit/entry_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_sheet/entry_sheet.dart';
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';

part 'provide_exchange_rates_sheet_state.dart';

class ProvideExchangeRatesSheetCubit extends Cubit<ProvideExchangeRatesSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;
  final ChartsSheetCubit _chartsSheetCubit;

  ProvideExchangeRatesSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    required LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    required SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
    required ChartsSheetCubit chartsSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        _chartsSheetCubit = chartsSheetCubit,
        super(ProvideExchangeRatesSheetState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize local state.
  Future<void> initializeLocal({required Group fromGroup}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access secrets.
      final Secrets? secrets = fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access first batch of invalid entries.
      final Map<String, dynamic> result = await _localStorageCubit.getLocalInvalidExchangeRatesBatch(
        fromGroup: fromGroup,
        limit: 50,
        offset: 0,
        secrets: secrets,
      );

      // Convenience variables.
      final Entries invalidEntries = result['invalid_entries'];
      final int elapsedEntries = result['elapsed_entries'];
      final bool isFinished = result['is_finished'];

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        fromGroup: fromGroup,
        invalidEntries: invalidEntries,
        currentOffset: elapsedEntries,
        isFinished: isFinished,
        failure: Failure.initial(),
        status: ProvideExchangeRatesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> initializeLocal() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: ProvideExchangeRatesSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> initializeLocal() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ProvideExchangeRatesSheetStatus.pageHasError,
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
      status: ProvideExchangeRatesSheetStatus.pageHasError,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ProvideExchangeRatesSheetStatus.close,
    ));
  }

  /// This method can be used to edit the desired exchange rate.
  Future<void> showEntrySheet({required BuildContext context, required Entry entry}) async {
    try {
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
          create: (context) {
            // * User is in shared mode.
            if (state.isShared) {
              return EntrySheetCubit(
                locationRepository: context.read<LocationRepository>(),
                localNotificationsCubit: localNotificationCubit,
                localStorageCubit: _localStorageCubit,
                appMessagesCubit: _appMessagesCubit,
                mainScreenCubit: _mainScreenCubit,
                sharedGroupSelectedSheetCubit: _sharedGroupSelectedSheetCubit,
                provideExchangeRatesSheetCubit: this,
              )..initializeSharedSetExchangeRate(
                  fromGroup: state.fromGroup,
                  entry: entry,
                );
            }

            // * User is in local mode.
            return EntrySheetCubit(
              locationRepository: context.read<LocationRepository>(),
              localNotificationsCubit: localNotificationCubit,
              localStorageCubit: _localStorageCubit,
              appMessagesCubit: _appMessagesCubit,
              mainScreenCubit: _mainScreenCubit,
              localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
              provideExchangeRatesSheetCubit: this,
            )..initializeLocalSetExchangeRate(
                fromGroup: state.fromGroup,
                entry: entry,
              );
          },
          child: const EntrySheet(),
        ),
      );

      // * Close the cubit after useing it.
      localNotificationCubit.close();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> showEntrySheet() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> showEntrySheet() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to load more entries with invalid exchange rates.
  Future<void> loadMoreEntriesWithInvalidExchangeRates() async {
    try {
      // Do not trigger this if all entries have already been searched.
      if (state.isFinished) return;

      // Ensure that this method does not get triggerd if it is currently loading.
      if (state.status == ProvideExchangeRatesSheetStatus.loading) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: ProvideExchangeRatesSheetStatus.loading,
      ));

      // * Let state update.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Access secrets.
      final Secrets? secrets = state.fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access first batch of invalid entries.
      final Map<String, dynamic> result = await _localStorageCubit.getLocalInvalidExchangeRatesBatch(
        fromGroup: state.fromGroup,
        limit: 50,
        offset: state.currentOffset,
        secrets: secrets,
      );

      // Convenience variables.
      final Entries invalidEntries = result['invalid_entries'];
      final int elapsedEntries = result['elapsed_entries'];
      final bool isFinished = result['is_finished'];

      // Calculate current offsett.
      final int currentOffset = state.currentOffset + elapsedEntries;

      // Add entries to current entries.
      final Entries updated = await state.invalidEntries.addUniqueEntries(
        entries: invalidEntries,
        append: true,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        invalidEntries: updated,
        currentOffset: currentOffset,
        isFinished: isFinished,
        failure: Failure.initial(),
        status: ProvideExchangeRatesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> loadMoreEntriesWithInvalidExchangeRates() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> loadMoreEntriesWithInvalidExchangeRates() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user provided all invalid values.
  Future<void> onFinish() async {
    try {
      // * Ensure that this can only be triggered if no invalid entries are left.
      // * Also ensure that all entries have been searched by checking "isFinished".
      if (state.invalidEntries.items.isNotEmpty || state.isFinished == false) throw Failure.genericError();

      // Let charts cubit know about how many issues have been fixed.
      await _chartsSheetCubit.updateNumberOfInvalidEntries(
        isFinished: state.isFinished,
      );

      // * Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        status: ProvideExchangeRatesSheetStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> onFinish() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> onFinish() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    }
  }

  // #############################
  // Update cascade from other cubits.
  // #############################

  /// This method will be triggered if user successfully fixed exchange rate issues of an entry.
  Future<void> onExchangeRatesFixed({required Entry entry}) async {
    try {
      // Init helpers.
      Entries helper = state.invalidEntries.update(updatedEntry: entry)!;

      // Go through entries and check if state contains entries that have now been fixed.
      for (final Entry item in helper.items) {
        // Init helper.
        bool remove = true;

        // Go through fields.
        for (final Field field in item.fields.items) {
          // Skip field if no exchange rate is required.
          if (field.getIsMoneyField == false && field.getIsPaymentField == false) continue;

          // * Validate MoneyField exchange rate.
          if (field.getIsMoneyField) {
            // Access exchange rate.
            final Map<String, dynamic> exchangeRateMap = await _localStorageCubit.getExchangeRate(
              customExchangeRates: field.moneyData!.customExchangeRates,
              exchangeRateDateInUtc: field.moneyData!.createdAtInUtc!,
              fromCurrencyCode: field.moneyData!.currencyCode,
              toCurrencyCode: state.fromGroup.defaultCurrencyCode,
              localOnly: true,
            );

            // Convenience variables.
            final String status = exchangeRateMap['status'];

            final bool isCustom = status == ExchangeRate.exchangeRateStatusCustom;
            final bool isSuccessLocal = status == ExchangeRate.exchangeRateStatusSuccessLocal;

            // If the entry is not invalid, continue with next field.
            if (isCustom || isSuccessLocal) continue;

            // If this is reached exchange rate is invalid and entry needs to be retained.
            remove = false;

            // Exit the fields loop for this entry, as it is invalid.
            break;
          }

          // * Validate PaymentField exchange rate.
          if (field.getIsPaymentField) {
            // Access exchange rate.
            final Map<String, dynamic> exchangeRateMap = await _localStorageCubit.getExchangeRate(
              customExchangeRates: field.paymentData!.customExchangeRates,
              exchangeRateDateInUtc: field.paymentData!.paymentDateInUtc!,
              fromCurrencyCode: field.paymentData!.currencyCode,
              toCurrencyCode: state.fromGroup.defaultCurrencyCode,
              localOnly: true,
            );

            // Convenience variables.
            final String status = exchangeRateMap['status'];

            final bool isCustom = status == ExchangeRate.exchangeRateStatusCustom;
            final bool isSuccessLocal = status == ExchangeRate.exchangeRateStatusSuccessLocal;

            // If the entry is not invalid, continue with next field.
            if (isCustom || isSuccessLocal) continue;

            // If this is reached exchange rate is invalid and entry needs to be retained.
            remove = false;

            // Exit the fields loop for this entry, as it is invalid.
            break;
          }
        }

        // Remove entry from helper and update number of removed entries.
        if (remove) helper = helper.remove(entryId: item.entryId);
      }

      // Check if new entries need to be loaded programatically.
      // * This for example gets triggered if all currently invalid entries are fixed in one go or if user does not scroll for more entries.
      final bool loadMoreEntries = helper.items.length < 5 && state.isFinished == false;

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        invalidEntries: helper,
        status: loadMoreEntries ? ProvideExchangeRatesSheetStatus.loadMoreEntries : null,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> onExchangeRatesFixed() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ProvideExchangeRatesSheetCubit --> onExchangeRatesFixed() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ProvideExchangeRatesSheetStatus.failure,
      ));
    }
  }
}
