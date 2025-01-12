import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_durations.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/fields/field.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/fields/fields.dart';
import '/data/models/import_specifications/import_specifications.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';
import '/screens/main/cubit/main_screen_cubit.dart';
import '/widgets/modal_bottom_sheets/menu_sheet/cubit/menu_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_decision_sheet/cubit/entry_decision_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/import_data_sheet/cubit/import_data_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/show_data_sample_sheet/cubit/show_data_sample_sheet_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/show_data_sample_sheet/show_data_sample_sheet.dart';

part 'create_model_state.dart';

class CreateModelCubit extends Cubit<CreateModelState> with HelperFunctions {
  final LocalStorageCubit _localStorageCubit;
  final MainScreenCubit _mainScreenCubit;
  final MenuSheetCubit? _menuSheetCubit;
  final EntryDecisionSheetCubit? _entryDecisionSheetCubit;
  final ImportDataSheetCubit? _importDataSheetCubit;

  CreateModelCubit({
    required LocalStorageCubit localStorageCubit,
    required MainScreenCubit mainScreenCubit,
    MenuSheetCubit? menuSheetCubit,
    EntryDecisionSheetCubit? entryDecisionSheetCubit,
    ImportDataSheetCubit? importDataSheetCubit,
  })  : _localStorageCubit = localStorageCubit,
        _mainScreenCubit = mainScreenCubit,
        _menuSheetCubit = menuSheetCubit,
        _entryDecisionSheetCubit = entryDecisionSheetCubit,
        _importDataSheetCubit = importDataSheetCubit,
        super(CreateModelState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize local create.
  Future<void> initializeLocalCreate() async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Create initial ModelEntry.
      final ModelEntry initialModelEntry = ModelEntry.initial().copyWith(
        modelEntryCreator: user.userId,
      );

      // Access language specific fields and field types.
      final PickerItems pickerItems = await Field.fieldsAsPickerItems(isShared: false, isImport: false);

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: false,
        isShared: false,
        initialEntryModel: initialModelEntry,
        entryModel: initialModelEntry,
        pickerItemsFields: pickerItems,
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalCreate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: CreateModelStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalCreate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateModelStatus.pageHasError,
      ));
    }
  }

  /// Initialize shared create.
  Future<void> initializeSharedCreate() async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Create initial ModelEntry.
      final ModelEntry initialModelEntry = ModelEntry.initial().copyWith(
        modelEntryCreator: user.userId,
      );

      // Access language specific fields and field types.
      final PickerItems pickerItems = await Field.fieldsAsPickerItems(isShared: true, isImport: false);

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: false,
        isShared: true,
        initialEntryModel: initialModelEntry,
        entryModel: initialModelEntry,
        pickerItemsFields: pickerItems,
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeSharedCreate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: CreateModelStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeSharedCreate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateModelStatus.pageHasError,
      ));
    }
  }

  /// Initialize edit.
  Future<void> initializeLocalEdit({required ModelEntry modelEntry}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Reset indications about which items should animate.
      final List<bool> initShouldAnimate = _initialShouldAnimate(
        fieldIdentifications: modelEntry.fieldIdentifications,
      );

      // Access language specific fields and field types.
      final PickerItems pickerItems = await Field.fieldsAsPickerItems(isShared: false, isImport: false);

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: true,
        isShared: false,
        initialEntryModel: modelEntry,
        entryModel: modelEntry,
        shouldAnimate: initShouldAnimate,
        pickerItemsFields: pickerItems,
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalEdit() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: CreateModelStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalEdit() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateModelStatus.pageHasError,
      ));
    }
  }

  /// Initialize edit.
  Future<void> initializeSharedEdit({required ModelEntry modelEntry}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Reset indications about which items should animate.
      final List<bool> initShouldAnimate = _initialShouldAnimate(
        fieldIdentifications: modelEntry.fieldIdentifications,
      );

      // Access language specific fields and field types.
      final PickerItems pickerItems = await Field.fieldsAsPickerItems(isShared: true, isImport: false);

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isEdit: true,
        isShared: true,
        initialEntryModel: modelEntry,
        entryModel: modelEntry,
        shouldAnimate: initShouldAnimate,
        pickerItemsFields: pickerItems,
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeSharedEdit() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: CreateModelStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeSharedEdit() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateModelStatus.pageHasError,
      ));
    }
  }

  /// Initialize a local import match create.
  Future<void> initializeLocalImportMatchCreate({required List<List<dynamic>> csvTable}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Create initial ModelEntry.
      final ModelEntry initialModelEntry = ModelEntry.initial().copyWith(
        modelEntryCreator: user.userId,
      );

      // Access language specific fields and field types.
      final PickerItems pickerItems = await Field.fieldsAsPickerItems(isShared: false, isImport: true);

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isImportMatch: true,
        isEdit: false,
        isShared: false,
        csvTable: csvTable,
        initialEntryModel: initialModelEntry,
        entryModel: initialModelEntry,
        pickerItemsFields: pickerItems,
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalImportMatchCreate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: CreateModelStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalImportMatchCreate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateModelStatus.pageHasError,
      ));
    }
  }

  /// Initialize a local import match edit.
  Future<void> initializeLocalImportMatchEdit({required List<List<dynamic>> csvTable, required ModelEntry modelEntry}) async {
    try {
      // Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access language specific fields and field types.
      final PickerItems pickerItems = await Field.fieldsAsPickerItems(isShared: false, isImport: true);

      // Reset indications about which items should animate.
      final List<bool> initShouldAnimate = _initialShouldAnimate(
        fieldIdentifications: modelEntry.fieldIdentifications,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isImportMatch: true,
        isEdit: true,
        isShared: false,
        csvTable: csvTable,
        initialEntryModel: modelEntry,
        entryModel: modelEntry,
        pickerItemsFields: pickerItems,
        shouldAnimate: initShouldAnimate,
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalImportMatchEdit() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: CreateModelStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeLocalImportMatchEdit() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: CreateModelStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == CreateModelStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateModelStatus.waiting,
    ));
  }

  /// This method can be used to confirm closing create model sheet.
  Future<void> confirmCloseSheet({required BuildContext context}) async {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == CreateModelStatus.loading) return;

    // * Check if user has unsaved data.
    final bool? confirm = state.initialEntryModel != state.entryModel
        ? await showModalBottomSheet(
            context: context,
            // * This sheet returns either true or null.
            builder: (context) => ConfirmSheet(
              title: state.isEdit ? labels.createModelSheetCubitEditConfirmClose() : labels.createModelSheetCubitCreateConfirmClose(),
            ),
          )
        : true;

    // Only emit new state if user confirmed, cubit is still open and cubit is not loading.
    if (confirm == null || isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateModelStatus.close,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: CreateModelStatus.close,
    ));
  }

  // ############################################
  // # Model Entry
  // ############################################

  /// This method gets invoked if user changes model name.
  void modelNameChanged({required String value, required TextEditingController controller}) {
    // Only trigger if state is not loading.
    if (state.status == CreateModelStatus.loading) return;

    // ModelEntry name.
    final String modelEntryName = value.trim();

    // User wants to delete name.
    if (modelEntryName.isEmpty) controller.clear();

    // Create updated ModelEntry.
    final ModelEntry modelEntry = state.entryModel.copyWith(
      modelEntryName: modelEntryName,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Update state name with value.
    emit(state.copyWith(
      entryModel: modelEntry,
      failure: Failure.initial(),
      status: CreateModelStatus.waiting,
    ));
  }

  /// This method gets invoked if user changs the is editable switch for the create at field.
  void onCreatedAtIsEditableChanged() {
    // Create updated ModelEntry.
    final ModelEntry modelEntry = state.entryModel.copyWith(
      entryCreatedAtIsEditable: !state.entryModel.entryCreatedAtIsEditable,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Update state name with value.
    emit(state.copyWith(
      entryModel: modelEntry,
      failure: Failure.initial(),
      status: CreateModelStatus.waiting,
    ));
  }

  /// This method gets invoked if user chooses a model field to add.
  Future<void> addFieldToModel({required BuildContext context}) async {
    try {
      // Only emit new state if cubit is still open and not already loading.
      if (isClosed || state.status == CreateModelStatus.loading) return;

      // * Show PickerSheet.
      final int? pickerIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.basicLabelsFields(),
          pickerItems: state.pickerItemsFields,
          // * Show a second button that lets users view a preview provided data.
          showSecondButton: state.isImportMatch ? true : false,
          secondButtonLabel: labels.showDataSample(),
          secondButtonCallback: (secondContext) {
            showModalBottomSheet(
              context: secondContext,
              isScrollControlled: true,
              showDragHandle: true,
              builder: (_) => BlocProvider<ShowDataSampleSheetCubit>(
                create: (context) => ShowDataSampleSheetCubit()
                  ..initialize(
                    csvTable: state.csvTable,
                  ),
                child: const ShowDataSampleSheet(),
              ),
            );
          },
        ),
      );

      // * User did not pick an item.
      if (pickerIndex == null) return;

      // Access chosen fieldType.
      final String fieldType = state.pickerItemsFields.items[pickerIndex].id;

      // Add field to model.
      final FieldIdentifications fieldIdentifications = state.entryModel.fieldIdentifications.copyWith(
        items: state.entryModel.fieldIdentifications.copyItemsWith(
          fieldIdentification: FieldIdentification.initial(
            fieldType: fieldType,
            entryModelId: state.entryModel.modelEntryId,
          ),
        ),
      );

      // Update list of which items should animate because an additional item was created.
      final List<bool> updatedShouldAnimate = _initialShouldAnimate(
        fieldIdentifications: fieldIdentifications,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Add field to model.
      emit(state.copyWith(
        entryModel: state.entryModel.copyWith(fieldIdentifications: fieldIdentifications),
        shouldAnimate: updatedShouldAnimate,
        focusedField: state.entryModel.fieldIdentifications.items.length,
        failure: Failure.initial(),
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> addFieldToModel() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateModelStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> addFieldToModel() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateModelStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user wants to remove a field from model.
  Future<void> removeFieldFromModel({required String fieldId, required int index}) async {
    // Only emit new state if cubit is still open and not already loading.
    if (isClosed || state.status == CreateModelStatus.loading) return;

    // Emit loading state.
    // * set delete animation duration to 400 milliseconds. This ensures that UI looks less janky.
    emit(state.copyWith(
      failure: Failure.initial(),
      animationDurationInMilliSeconds: 400,
      status: CreateModelStatus.loading,
    ));

    // Accesss animation indications.
    final List<bool> shouldAnimate = _updatedShouldAnimate(index: index);

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Animate UI.
    emit(state.copyWith(
      shouldAnimate: shouldAnimate,
    ));

    // * Wait until animation has finished before state update.
    // * Otherwise Animation is interrupted.
    // * Plus 5 milliseconds makes UI feel less janky.
    await Future.delayed(Duration(milliseconds: state.animationDurationInMilliSeconds + 5));

    // Remove field from list.
    final FieldIdentifications fieldIdentifications = state.entryModel.fieldIdentifications.remove(
      fieldId: fieldId,
    );

    // Remove field identifications from import specifications if it is set.
    final Fields? importSpecificationsFields = state.entryModel.importSpecifications?.fields.remove(
      fieldId: fieldId,
    );

    // Update import sepcifications.
    final ImportSpecifications? importSpecifications = state.entryModel.importSpecifications?.copyWith(
      fields: importSpecificationsFields,
    );

    // Create updated ModelEntry.
    final ModelEntry modelEntry = state.entryModel.copyWith(
      fieldIdentifications: fieldIdentifications,
      importSpecifications: importSpecifications,
    );

    // Reset indications about which items should animate.
    final List<bool> resetShouldAnimate = _initialShouldAnimate(
      fieldIdentifications: fieldIdentifications,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Remove field from model.
    emit(state.copyWith(
      entryModel: modelEntry,
      animationDurationInMilliSeconds: 1,
      shouldAnimate: resetShouldAnimate,
      failure: Failure.initial(),
      status: CreateModelStatus.waiting,
    ));
  }

  /// This method gets invoked if user wants to reorder a field item in list.
  /// * the flutter framework has two bugs in this widget as of 2022.10.22
  /// * BUG 1: reorder is triggered even if there is only one item in list with oldIndex = 0 and newIndex = 1
  /// * BUG 2: when moving an item down in list it yields incorrect newIndex
  void onReorder({required int oldIndex, required int newIndex}) {
    try {
      // Only trigger if state is not loading.
      if (state.status == CreateModelStatus.loading) return;

      // * Do nothing if only one item is in list.
      // * This is needed because of a bug in the framework widget.
      if (state.entryModel.fieldIdentifications.items.length == 1) return;

      // Item moved down in list, correct newIndex.
      // * This is needed because of a bug in the framework widget.
      if (oldIndex < newIndex) newIndex -= 1;

      // * Do nothing if indexes are equal because item did not actually move.
      if (oldIndex == newIndex) return;

      // Reorder field identifications.
      final FieldIdentifications fieldIdentifications = state.entryModel.fieldIdentifications.reorder(
        oldIndex: oldIndex,
        newIndex: newIndex,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Update field position in list.
      emit(state.copyWith(
        entryModel: state.entryModel.copyWith(fieldIdentifications: fieldIdentifications),
        // * After reorder no textField should be focused.
        focusedField: -1,
        failure: Failure.initial(),
        status: CreateModelStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> onReorder() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateModelStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> onReorder() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateModelStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user changes the label of a field.
  void fieldLabelChanged({required int index, required String value, required TextEditingController controller}) {
    // Only trigger if state is not loading.
    if (state.status == CreateModelStatus.loading) return;

    // User wants to delete entry.
    if (value.isEmpty) controller.clear();

    // Update label of FieldIdentification.
    final FieldIdentification updatedFieldIdentification = state.entryModel.fieldIdentifications.items[index].copyWith(
      label: value,
    );

    // Update FieldIdentifications.
    final FieldIdentifications fieldIdentifications = state.entryModel.fieldIdentifications.copyWith(
      items: state.entryModel.fieldIdentifications.copyItemsWith(
        fieldIdentification: updatedFieldIdentification,
        index: index,
      ),
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Update field label.
    emit(state.copyWith(
      entryModel: state.entryModel.copyWith(fieldIdentifications: fieldIdentifications),
      failure: Failure.initial(),
      status: CreateModelStatus.waiting,
    ));
  }

  /// This method gets invoked if user changes required switch of a field.
  void requiredChanged({required int index, required bool value}) {
    // Only trigger if state is not loading.
    if (state.status == CreateModelStatus.loading) return;

    // Update label of FieldIdentification.
    final FieldIdentification updatedFieldIdentification = state.entryModel.fieldIdentifications.items[index].copyWith(
      required: value,
    );

    // Update FieldIdentifications.
    final FieldIdentifications fieldIdentifications = state.entryModel.fieldIdentifications.copyWith(
      items: state.entryModel.fieldIdentifications.copyItemsWith(
        fieldIdentification: updatedFieldIdentification,
        index: index,
      ),
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // Update field required value.
    emit(state.copyWith(
      entryModel: state.entryModel.copyWith(fieldIdentifications: fieldIdentifications),
      failure: Failure.initial(),
      status: CreateModelStatus.waiting,
    ));
  }

  // ############################################
  // # Database Local
  // ############################################

  /// This method will be triggered if user wants to create a new local ```ModelEntry```.
  Future<void> createLocalModelEntry({required BuildContext context}) async {
    try {
      // Only emit new states if cubit is still open and not already loading.
      if (isClosed || state.status == CreateModelStatus.loading) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateModelStatus.loading,
      ));

      // Display failure if nothing has changed.
      if (state.initialEntryModel == state.entryModel) throw Failure.noEntryModelDataProvided();

      // Display failure if model name is empty.
      if (state.entryModel.modelEntryName.isEmpty) throw Failure.emptyModelName();

      // Convenience variables.
      final List<FieldIdentification> items = state.entryModel.fieldIdentifications.items;

      // Check if entry model has at least one field.
      if (items.isEmpty) throw Failure.noEntryModelFieldsCreated();

      // * Make sure all fields have labels.
      // * Make sure selector items are set if present.
      for (final FieldIdentification item in items) {
        // Display failure if field label is empty.
        if (item.label.isEmpty) throw Failure.emptyLabel();
      }

      // Conduct database operation.
      final ModelEntry created = await _localStorageCubit.state.database!.writeTxn(() async {
        // Add entry model to local storage.
        final ModelEntry createdEntryModel = await _localStorageCubit.createLocalModelEntry(
          modelEntry: state.entryModel,
        );

        return createdEntryModel;
      });

      // * Update dependent cubits.
      if (_menuSheetCubit != null) {
        _menuSheetCubit.onEntryModelCreated(entryModel: created);
      }

      // * Update dependent cubits.
      if (_entryDecisionSheetCubit != null) {
        _entryDecisionSheetCubit.onEntryModelCreated(entryModel: created);
      }

      // * Update dependent cubits.
      if (_importDataSheetCubit != null) {
        _importDataSheetCubit.onModelEntryCreated(modelEntry: created);
      }

      // * Update dependent cubits.
      _mainScreenCubit.onModelEntryCreated(modelEntry: created);

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Emit close state.
      emit(state.copyWith(
        status: CreateModelStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> createLocalModelEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateModelStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> createLocalModelEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateModelStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to edit an existing local ```ModelEntry```.
  Future<void> editLocalModelEntry({required BuildContext context}) async {
    try {
      // Only emit new state if cubit is still open and not already loading.
      if (isClosed || state.status == CreateModelStatus.loading) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateModelStatus.loading,
      ));

      // Display failure if nothing has changed.
      if (state.initialEntryModel == state.entryModel) throw Failure.nothingWasEdited();

      // Display failure if model name is empty.
      if (state.entryModel.modelEntryName.isEmpty) throw Failure.emptyModelName();

      // Convenience variables.
      final List<FieldIdentification> items = state.entryModel.fieldIdentifications.items;

      // Check if entry model has at least one field.
      if (items.isEmpty) throw Failure.noEntryModelFieldsCreated();

      // * Make sure all fields have labels.
      for (final FieldIdentification item in items) {
        // Display failure if field label is empty.
        if (item.label.isEmpty) throw Failure.emptyLabel();
      }

      // Conduct update.
      await _localStorageCubit.state.database!.writeTxn(() async {
        // Add entry model to local storage.
        await _localStorageCubit.editLocalModelEntry(
          updatedModelEntry: state.entryModel,
        );
      });

      // * Update dependent cubits.
      if (_menuSheetCubit != null) {
        _menuSheetCubit.onEntryModelEdited(editedEntryModel: state.entryModel);
      }

      // * Update dependent cubits.
      if (_importDataSheetCubit != null) {
        _importDataSheetCubit.onModelEntryCreated(modelEntry: state.entryModel);
      }

      // * Update dependent cubits.
      _mainScreenCubit.onModelEntryEdited(modelEntry: state.entryModel);

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Emit close state.
      emit(state.copyWith(
        status: CreateModelStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> editLocalModelEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateModelStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> editLocalModelEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateModelStatus.failure,
      ));
    }
  }

  // ############################################
  // # Database Cloud
  // ############################################

  /// This method will be triggered if user wants to create a new shared ```ModelEntry```.
  Future<void> createSharedModelEntry({required BuildContext context}) async {
    // * ############ ReadMe ############
    //   The name of a ModelEntry is required (cannot be an empty String) but not unique.
    //   Meaning ModelEntries with the same name can be created. This is mostly due to the fact that if
    //   user downloads a ModelEntry it could be that a ModelEntry with the same name is downloaded.
    //   It is up to the user to not get confused.

    try {
      // Only emit new states if cubit is still open and not already loading.
      if (isClosed || state.status == CreateModelStatus.loading) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateModelStatus.loading,
      ));

      // Display failure if nothing has changed.
      if (state.initialEntryModel == state.entryModel) throw Failure.noEntryModelDataProvided();

      // Display failure if model name is empty.
      if (state.entryModel.modelEntryName.isEmpty) throw Failure.emptyModelName();

      // Convenience variables.
      final List<FieldIdentification> items = state.entryModel.fieldIdentifications.items;

      // Check if entry model has at least one field.
      if (items.isEmpty) throw Failure.noEntryModelFieldsCreated();

      // * Make sure all fields have labels.
      for (final FieldIdentification item in items) {
        if (item.label.isEmpty) throw Failure.emptyLabel();
      }

      // Add entry model to cloud.
      final ModelEntry modelEntry = await _localStorageCubit.createSharedModelEntry(
        modelEntry: state.entryModel,
      );

      // * Update dependent cubits.
      if (_menuSheetCubit != null) {
        _menuSheetCubit.onEntryModelCreated(entryModel: modelEntry);
      }

      // * Update dependent cubits.
      if (_entryDecisionSheetCubit != null) {
        _entryDecisionSheetCubit.onEntryModelCreated(entryModel: modelEntry);
      }

      // * Update dependent cubits.
      _mainScreenCubit.onModelEntryCreated(modelEntry: modelEntry);

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Emit close state.
      emit(state.copyWith(
        status: CreateModelStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> createSharedModelEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateModelStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> createSharedModelEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateModelStatus.failure,
      ));
    }
  }

  /// This method will be triggered if user wants to edit an existing shared ```ModelEntry```.
  Future<void> editSharedModelEntry({required BuildContext context}) async {
    try {
      // Only emit new state if cubit is still open and not already loading.
      if (isClosed || state.status == CreateModelStatus.loading) return;

      // Emit loading state.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: CreateModelStatus.loading,
      ));

      // Display failure if nothing has changed.
      if (state.initialEntryModel == state.entryModel) throw Failure.nothingWasEdited();

      // Display failure if model name is empty.
      if (state.entryModel.modelEntryName.isEmpty) throw Failure.emptyModelName();

      // Convenience variables.
      final List<FieldIdentification> items = state.entryModel.fieldIdentifications.items;

      // Check if entry model has at least one field.
      if (items.isEmpty) throw Failure.noEntryModelFieldsCreated();

      // * Make sure all fields have labels.
      for (final FieldIdentification item in items) {
        // Display failure if field label is empty.
        if (item.label.isEmpty) throw Failure.emptyLabel();
      }

      // Edit ModelEntry in the cloud.
      await _localStorageCubit.editSharedModelEntry(
        modelEntry: state.entryModel,
      );

      // * Update dependent cubits.
      if (_menuSheetCubit != null) {
        _menuSheetCubit.onEntryModelEdited(editedEntryModel: state.entryModel);
      }

      // * Update dependent cubits.
      _mainScreenCubit.onModelEntryEdited(modelEntry: state.entryModel);

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Emit close state.
      emit(state.copyWith(
        status: CreateModelStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> editSharedModelEntry() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: CreateModelStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> editSharedModelEntry() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: CreateModelStatus.failure,
      ));
    }
  }

  // ############################################
  // # Private
  // ############################################

  /// This method returns initial set of indications about which AnimatedOpacity should animate.
  /// * initially none should animate
  List<bool> _initialShouldAnimate({required FieldIdentifications fieldIdentifications}) {
    return List.generate(
      fieldIdentifications.items.length,
      (index) => false,
    );
  }

  /// This method can be used to update indication about which AnimatedOpacity should animate.
  List<bool> _updatedShouldAnimate({required int index}) {
    // Init helper list.
    List<bool> newList = [];

    for (var i = 0; i < state.shouldAnimate.length; i++) {
      if (i == index) {
        newList.add(true);
        continue;
      }

      newList.add(false);
    }

    return newList;
  }
}
