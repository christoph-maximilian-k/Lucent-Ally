import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Repositories.
import '/data/repositories/local_notifications/local_notifications_repository.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/shared_group_selected_sheet/cubit/shared_group_selected_sheet_cubit.dart';

// Models.
import '/data/models/entries/entry.dart';
import '/data/models/failure.dart';
import '/data/models/groups/group.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/entry_selected_sheet/entry_selected_sheet.dart';

part 'entry_selected_page_state.dart';

class EntrySelectedPageCubit extends Cubit<EntrySelectedPageState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final SharedGroupSelectedSheetCubit? _sharedGroupSelectedSheetCubit;

  EntrySelectedPageCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    SharedGroupSelectedSheetCubit? sharedGroupSelectedSheetCubit,
    // * These needs to be supplied here to be available in EntrySelectedPageState.initial().
    // ! Attention! Leads to errors if supplied in initialize() because create page will be called before initialze() is called.
    required int initialPage,
    required Group fromGroup,
    required bool isShared,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _sharedGroupSelectedSheetCubit = sharedGroupSelectedSheetCubit,
        super(EntrySelectedPageState.initial(initialPage: initialPage, fromGroup: fromGroup, isShared: isShared));

  // ############################################
  // Getters
  // ############################################

  /// Get entries length.
  int get getEntriesLength {
    if (_sharedGroupSelectedSheetCubit != null) return _sharedGroupSelectedSheetCubit.state.entries.items.length;
    return _localGroupSelectedSheetCubit!.state.entries.items.length;
  }

  /// Get entries length.
  Entry getEntry({required int index}) {
    if (_sharedGroupSelectedSheetCubit != null) return _sharedGroupSelectedSheetCubit.state.entries.items[index];
    return _localGroupSelectedSheetCubit!.state.entries.items[index];
  }

  // ############################################
  // State
  // ############################################

  /// This method will be triggerd if page changes.
  Future<void> onPageChanged({required int index}) async {
    // Check if next batch of entries in groups cubit needs to be loaded.
    final bool shouldLoadNextbatch = getEntriesLength - index < 8;

    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      currentPage: index,
    ));

    // Load next batch in underlying cubit.
    // * Do not await so that state update goes through.
    // * Dont do this if state reports finished.
    if (state.isFinished == false && shouldLoadNextbatch && state.status != EntrySelectedPageStatus.loadingMoreContent) triggerLoadMoreEntriesEvent(fromOnTap: false);
  }

  /// This method can be used to trigger a load more entries event in underlying group cubits.
  Future<void> triggerLoadMoreEntriesEvent({required bool fromOnTap}) async {
    try {
      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySelectedPageStatus.loadingMoreContent,
      ));

      // Show a loading indication even though event could be finished quicker for smoother UI event.
      if (fromOnTap) await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Are all entries already loaded?
      bool isFinished = false;

      // Load local entries.
      if (_localGroupSelectedSheetCubit != null && isFinished == false) {
        // Load more entries.
        await _localGroupSelectedSheetCubit.loadMoreEntries(shouldRethrow: true);

        // Update flag.
        isFinished = _localGroupSelectedSheetCubit.state.isFinished;
      }

      // Load shared entries.
      if (_sharedGroupSelectedSheetCubit != null && isFinished == false) {
        // Load more entries.
        await _sharedGroupSelectedSheetCubit.loadMoreEntries(shouldRethrow: true);

        // Update flag.
        isFinished = _sharedGroupSelectedSheetCubit.state.isFinished;
      }

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        status: EntrySelectedPageStatus.waiting,
        isFinished: isFinished,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('EntrySelectedPageCubit --> triggerLoadMoreEntriesEvent() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: EntrySelectedPageStatus.loadingMoreContentFailure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('EntrySelectedPageCubit --> triggerLoadMoreEntriesEvent() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        status: EntrySelectedPageStatus.loadingMoreContentFailure,
      ));
    }
  }

  /// This method can be used to create a new EntrySelectedSheetCubit widget based on a provided entry.
  Widget createEntrySelectedSheetWidget({required BuildContext context, required Entry entry}) {
    if (state.isShared) {
      return BlocProvider<EntrySelectedSheetCubit>(
        lazy: false,
        create: (_) => EntrySelectedSheetCubit(
          localStorageCubit: _localStorageCubit,
          appMessagesCubit: _appMessagesCubit,
          localNotificationsRepository: context.read<LocalNotificationsRepository>(),
          sharedGroupSelectedSheetCubit: _sharedGroupSelectedSheetCubit,
          mainScreenCubit: _mainScreenCubit,
        )..initializeShared(
            entry: entry,
            fromGroup: state.fromGroup,
            fromViewEntriesSheet: false,
          ),
        child: EntrySelectedSheet(),
      );
    }

    return BlocProvider<EntrySelectedSheetCubit>(
      lazy: false,
      create: (_) => EntrySelectedSheetCubit(
        localStorageCubit: _localStorageCubit,
        appMessagesCubit: _appMessagesCubit,
        localNotificationsRepository: context.read<LocalNotificationsRepository>(),
        localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
        mainScreenCubit: _mainScreenCubit,
      )..initializeLocal(
          entry: entry,
          fromGroup: state.fromGroup,
          fromViewEntriesSheet: false,
        ),
      child: EntrySelectedSheet(),
    );
  }
}
