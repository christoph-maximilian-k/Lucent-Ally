import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/entries/entry.dart';
import '/data/models/entries/entries.dart';
import '/data/models/secrets/secrets.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';

part 'search_sheet_state.dart';

class SearchSheetCubit extends Cubit<SearchSheetState> {
  final LocalStorageCubit? _localStorageCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;

  SearchSheetCubit({
    LocalStorageCubit? localStorageCubit,
    LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        super(SearchSheetState.initial());

  /// Initialize state data.
  Future<void> initialize({required bool isShared}) async {
    // * Necessary to avoid UI delay.
    await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

    // Access secrets.
    final Secrets secrets = await _localStorageCubit!.getSecretsFromSecureStorage();

    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      isShared: isShared,
      secrets: secrets,
      status: SearchSheetStatus.initial,
    ));
  }

  /// This function gets triggered if user searches in search field.
  Future<void> onSearched({required String value}) async {
    try {
      // Set state to initial if value is empty.
      if (value.isEmpty) {
        // Only emit states if cubit is open.
        if (isClosed) return;

        // Emit initial state.
        emit(state.copyWith(
          currentSearchCriteria: value,
          matchingEntries: Entries.initial(),
          failure: Failure.initial(),
          status: SearchSheetStatus.initial,
        ));

        return;
      }

      // Only emit states if cubit is open.
      if (isClosed) return;

      // Emit loading state.
      emit(state.copyWith(
        currentSearchCriteria: value,
        failure: Failure.initial(),
        status: SearchSheetStatus.loading,
      ));

      // Init entries.
      Entries entries = Entries.initial();

      // * Search entries of cubit, depending on which cubit got supplied.
      if (_localGroupSelectedSheetCubit != null) {
        entries = await _localStorageCubit!.searchLocalGroupEntriesByName(
          searchCriteria: value,
          groupId: _localGroupSelectedSheetCubit.state.group.groupId,
          secrets: state.secrets!,
        );
      }

      // * Search entries of cubit, depending on which cubit got supplied.
      if (_sharedGroupSelectedSheetCubit != null) {
        entries = await _localStorageCubit!.searchSharedEntriesOfSharedGroupByName(
          searchCriteria: value,
          rootGroupReference: _sharedGroupSelectedSheetCubit.state.group.rootGroupReference,
          groupId: _sharedGroupSelectedSheetCubit.state.group.groupId,
        );
      }

      // * Search entries of cubit, depending on which cubit got supplied.
      if (_localStorageCubit != null && (_localGroupSelectedSheetCubit == null && _sharedGroupSelectedSheetCubit == null)) {
        // * User is in local mode.
        if (state.isShared == false) {
          entries = await _localStorageCubit.searchAllLocalEntriesByName(
            searchCriteria: value,
            secrets: state.secrets!,
          );
        }
      }

      // Only emit states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        matchingEntries: entries,
        status: SearchSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('SearchSheetCubit --> onSearched() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: failure,
        status: SearchSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('SearchSheetCubit --> onSearched() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: SearchSheetStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: SearchSheetStatus.waiting,
    ));
  }

  /// This method will be triggered if user picks an entry.
  void entryPicked({required BuildContext context, required Entry entry}) {
    Navigator.of(context).pop(entry);
  }

  /// This method can be used to close the sheet.
  void closeSheet({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
