import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// User, with settings and labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';

// Repositories.
import '/data/repositories/local_notifications/local_notifications_repository.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/entries/entries.dart';
import '/data/models/groups/group.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/tags/tag.dart';
import '/data/models/entries/entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/fields/field.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/charts/chart.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/local_group_selected_sheet/cubit/local_group_selected_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/cubit/charts_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/expense_report_sheet/cubit/expense_report_sheet_cubit.dart';

// Screens.
import '/screens/main/cubit/main_screen_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/entry_selected_sheet/entry_selected_sheet.dart';

part 'view_entries_sheet_state.dart';

class ViewEntriesSheetCubit extends Cubit<ViewEntriesSheetState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;
  final MainScreenCubit _mainScreenCubit;
  final EntrySelectedSheetCubit? _entrySelectedSheetCubit;
  final LocalGroupSelectedSheetCubit? _localGroupSelectedSheetCubit;
  final ChartsSheetCubit? _chartsSheetCubit;
  final ExpenseReportSheetCubit? _expenseReportSheetCubit;

  ViewEntriesSheetCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
    required MainScreenCubit mainScreenCubit,
    required LocalGroupSelectedSheetCubit? localGroupSelectedSheetCubit,
    EntrySelectedSheetCubit? entrySelectedSheetCubit,
    ChartsSheetCubit? chartsSheetCubit,
    ExpenseReportSheetCubit? expenseReportSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        _mainScreenCubit = mainScreenCubit,
        _entrySelectedSheetCubit = entrySelectedSheetCubit,
        _localGroupSelectedSheetCubit = localGroupSelectedSheetCubit,
        _chartsSheetCubit = chartsSheetCubit,
        _expenseReportSheetCubit = expenseReportSheetCubit,
        super(ViewEntriesSheetState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize state data.
  Future<void> initializeLocal({required Group fromGroup, required String referenceType, required String referenceId, required Chart? chart}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init helpers.
      String title = labels.basicLabelsEntries();
      Map<String, dynamic> result = {};
      Tag? tag;
      String filter = chart?.getOnLegendTapFilterType ?? "";

      // Access secrets.
      final Secrets? secrets = fromGroup.isEncrypted ? await _localStorageCubit.getSecretsFromSecureStorage() : null;

      // Access ModelEntries.
      final ModelEntries modelEntries = await _localStorageCubit.getAllLocalModelEntries(
        shouldAccessPrefs: true,
      );

      // * User requested mode untagged by field id.
      if (referenceType == 'untagged_by_field_id') {
        // Set title.
        title = labels.basicLabelsNotTagged();

        // Access entries.
        result = await _localStorageCubit.getLocalEntriesUntaggedByFieldId(
          group: fromGroup,
          fieldId: referenceId,
          secrets: secrets,
          limit: 50,
          offset: 0,
          filter: filter,
        );
      }

      // * User requested mode untagged by field type.
      if (referenceType == 'untagged_by_field_type') {
        // Set title.
        title = labels.basicLabelsNotTagged();

        // Access entries.
        result = await _localStorageCubit.getLocalEntriesUntaggedByFieldType(
          group: fromGroup,
          fieldType: referenceId,
          secrets: secrets,
          limit: 50,
          offset: 0,
          filter: filter,
        );
      }

      // * User requested mode tag.
      if (referenceType == 'tag') {
        // Access tag by its id.
        tag = await _localStorageCubit.getLocalTagById(tagId: referenceId);

        // Tag not found, let user know.
        if (tag == null) throw Failure.genericError();

        // Set title.
        title = labels.basicLabelsEntriesTaggedWith(tagLabel: tag.label);

        // Access entries.
        result = await _localStorageCubit.getLocalEntriesByTags(
          group: fromGroup,
          tagId: tag.tagId,
          filter: filter,
          secrets: secrets,
          limit: 50,
          offset: 0,
        );
      }

      // No entries found.
      if (result.isEmpty) throw Failure.genericError();

      // Convenience variables.
      final Entries entries = result['entries'];
      final int elapsedEntries = result['elapsed_entries'];
      final bool isFinished = result['is_finished'];

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        isShared: false,
        title: title,
        secrets: secrets,
        fromGroup: fromGroup,
        tag: tag,
        entries: entries,
        modelEntries: modelEntries,
        offset: elapsedEntries,
        isFinished: isFinished,
        referenceId: referenceId,
        referenceType: referenceType,
        filter: filter,
        failure: Failure.initial(),
        status: ViewEntriesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewEntriesSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: ViewEntriesSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewEntriesSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: ViewEntriesSheetStatus.pageHasError,
      ));
    }
  }

  // #############################
  // State
  // #############################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ViewEntriesSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == ViewEntriesSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: ViewEntriesSheetStatus.close,
    ));
  }

  /// This method can be used to copy a value to clipboard.
  Future<void> copyToClipboard({required BuildContext context, required Entry entry, required ModelEntry entryModel}) async {
    try {
      // Check if copyableFieldId has been set.
      if (entryModel.modelEntryPrefs.copyFieldId.isEmpty) throw Failure.copyFieldNotSet();

      // Access index of copy field.
      final int index = entry.fields.items.indexWhere(
        (element) => element.fieldId == entryModel.modelEntryPrefs.copyFieldId,
      );

      // * In this case field which has been set as copy field was deleted.
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

      // Perform write transaction.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Update recent items.
        await _localStorageCubit.putLocalRecentEntry(
          entryId: entry.entryId,
          rootGroupReference: state.fromGroup.rootGroupReference,
          groupReference: state.fromGroup.groupId,
        );
      });

      // Let main screen know.
      _mainScreenCubit.onEntryInteracted(
        entry: entry,
        modelEntry: entryModel,
        fromGroup: state.fromGroup,
      );

      // Display anotification.
      _appMessagesCubit.showNotification(
        message: labels.groupSelectedSheetCubitCopyField(label: fieldIdentification.label),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewEntriesSheetCubit --> copyToClipboard() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ViewEntriesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewEntriesSheetCubit --> copyToClipboard() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ViewEntriesSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to trigger a refresh in charts sheet.
  /// * This method only executes if `_chartsSheetCubit != null`.
  void refreshChartsSheet() {
    // No charts sheet supplied.
    if (_chartsSheetCubit == null || state.groupContentChanged == false) return;

    // Trigger refresh.
    _chartsSheetCubit.triggerLocalStateRefresh();
  }

  /// This method can be used to trigger a refresh in charts sheet.
  /// * This method only executes if `_expenseReportSheetCubit != null`.
  void refreshExpenseReportSheet() {
    // No charts sheet supplied.
    if (_expenseReportSheetCubit == null || state.groupContentChanged == false) return;

    // Trigger refresh.
    _expenseReportSheetCubit.triggerLocalStateRefresh();
  }

  // ############################################
  // # Entries
  // ############################################

  /// This method can be used to show an EntrySelectedSheet.
  void showEntrySelectedSheet({required BuildContext context, required Entry entry}) {
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
          localGroupSelectedSheetCubit: _localGroupSelectedSheetCubit,
          mainScreenCubit: _mainScreenCubit,
          viewEntriesSheetCubit: this,
        )..initializeLocal(
            entry: entry,
            fromGroup: state.fromGroup,
            fromViewEntriesSheet: true,
          ),
        child: const EntrySelectedSheet(),
      ),
    );
  }

  /// This method can be used to load more entries.
  Future<void> loadMoreEntries({required}) async {
    try {
      // Do not trigger this if all entries have already been searched.
      if (state.isFinished) return;

      // Ensure that this method does not get triggerd if it is currently loading.
      if (state.status == ViewEntriesSheetStatus.loading) return;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: ViewEntriesSheetStatus.loading,
      ));

      // * Let state update.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      // Access local tags.
      Map<String, dynamic> result = {};

      // Access entries based on tag.
      if (state.referenceType == 'tag') {
        result = await _localStorageCubit.getLocalEntriesByTags(
          group: state.fromGroup,
          tagId: state.tag!.tagId,
          filter: state.filter,
          secrets: state.secrets,
          limit: 50,
          offset: state.offset,
        );
      }

      // Access entries which are not tagged.
      if (state.referenceType == 'untagged_by_field_id') {
        result = await _localStorageCubit.getLocalEntriesUntaggedByFieldId(
          group: state.fromGroup,
          fieldId: state.referenceId,
          filter: state.filter,
          secrets: state.secrets,
          limit: 50,
          offset: state.offset,
        );
      }

      // Access entries which are not tagged.
      if (state.referenceType == 'untagged_by_field_type') {
        result = await _localStorageCubit.getLocalEntriesUntaggedByFieldType(
          group: state.fromGroup,
          fieldType: state.referenceId,
          filter: state.filter,
          secrets: state.secrets,
          limit: 50,
          offset: state.offset,
        );
      }

      // No entries found.
      if (result.isEmpty) throw Failure.genericError();

      // Convenience variables.
      final Entries entries = result['entries'];
      final int elapsedEntries = result['elapsed_entries'];
      final bool isFinished = result['is_finished'];

      // Calculate current offsett.
      final int currentOffset = state.offset + elapsedEntries;

      // Add entries to current entries.
      final Entries updatedEntries = await state.entries.addUniqueEntries(
        entries: entries,
        append: true,
      );

      // Only emit state if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        entries: updatedEntries,
        offset: currentOffset,
        isFinished: isFinished,
        failure: Failure.initial(),
        status: ViewEntriesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('ViewEntriesSheetCubit --> loadMoreEntries() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: ViewEntriesSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('ViewEntriesSheetCubit --> loadMoreEntries() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: ViewEntriesSheetStatus.failure,
      ));
    }
  }

  // ##########################################################
  // Used from other cubits.
  // ##########################################################

  /// This method gets triggered if user edited an entry.
  /// * Updates entry in ```state.entries``` and rebuilds list
  Future<void> onEntryEdited({required Entry editedEntry}) async {
    // If subgroup ModelEntry changed, report to parent.
    if (_entrySelectedSheetCubit != null) {
      await _entrySelectedSheetCubit.onEntryEdited(editedEntry: editedEntry);
    }

    // Check if entry is still tagged with tag.
    if (state.tag != null) {
      final bool isTagged = editedEntry.isTaggedWith(tag: state.tag!);

      // Remove from state if tag was removed.
      if (isTagged == false) {
        // Remove entry from state.
        final Entries entriesOfGroup = state.entries.remove(
          entryId: editedEntry.entryId,
        );

        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state entries.
        emit(state.copyWith(
          entries: entriesOfGroup.sortByRecentlyCreated,
        ));

        return;
      }
    }

    // Create updated entries.
    final Entries? entries = state.entries.update(
      updatedEntry: editedEntry,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Update state entries.
    emit(state.copyWith(
      groupContentChanged: true,
      entries: entries?.sortByRecentlyCreated,
    ));
  }

  /// This method gets triggered if user deleted an entry from local storage.
  /// * removes entry from ```state.entries``` and rebuilds list.
  /// * shows notification
  Future<void> onEntryDeleted({required Entry entry}) async {
    // Remove entry from state.
    final Entries entriesOfGroup = state.entries.remove(
      entryId: entry.entryId,
    );

    // Check if entry below needs to be deleted.
    if (_entrySelectedSheetCubit != null && _entrySelectedSheetCubit.state.entry.entryId == entry.entryId) {
      // Only emit state if cubit is open.
      if (isClosed) return;

      // Remove entry from state.
      emit(state.copyWith(
        status: ViewEntriesSheetStatus.closeBelow,
      ));
    }

    // Only emit state if cubit is open.
    if (isClosed) return;

    // Remove entry from state.
    emit(state.copyWith(
      groupContentChanged: true,
      entries: entriesOfGroup,
      status: ViewEntriesSheetStatus.waiting,
    ));
  }

  /// This method can be used to edit a ModelEntry of this state.
  Future<void> onModelEntryEdited({required ModelEntry modelEntry}) async {
    // If subgroup ModelEntry changed, report to parent.
    if (_entrySelectedSheetCubit != null) {
      await _entrySelectedSheetCubit.onModelEntryEdited(modelEntry: modelEntry);
    }
    // Put model entry into state.
    final ModelEntries updatedModelEntries = state.modelEntries.put(
      modelEntry: modelEntry,
    );

    // Make sure cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      groupContentChanged: true,
      modelEntries: updatedModelEntries,
    ));
  }
}
