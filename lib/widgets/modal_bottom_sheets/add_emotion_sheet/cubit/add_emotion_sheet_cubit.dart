import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timezone/timezone.dart' as tz;

// Labels.
import '/main.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/field_types/emotion_data/emotion_item.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/picker_items/picker_items.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/picker_sheet/picker_sheet.dart';
import '/widgets/modal_bottom_sheets/date_selector/date_selector.dart';

// Cubit.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/helper_functions/helper_functions.dart';

part 'add_emotion_sheet_state.dart';

class AddEmotionSheetCubit extends Cubit<AddEmotionSheetState> {
  final LocalStorageCubit _localStorageCubit;

  AddEmotionSheetCubit({required LocalStorageCubit localStorageCubit})
      : _localStorageCubit = localStorageCubit,
        super(AddEmotionSheetState.initial());

  // #####################
  // Initialization
  // #####################

  /// Initialize state data.
  Future<void> initializeCreate() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Access current user timezone.
      final String currentTimeZone = HelperFunctions.getCurrentTimezone() ?? "UTC";

      // Update EmotionItem.
      final EmotionItem updated = state.emotionItem.copyWith(
        occurrenceInUtc: DateTime.now().toUtc(),
        occurrenceTimeZone: currentTimeZone,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        emotionItem: updated,
        status: AddEmotionSheetStatus.showEmotions,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeCreate() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: failure,
        status: AddEmotionSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('CreateModelCubit --> initializeCreate() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: AddEmotionSheetStatus.pageHasError,
      ));
    }
  }

  // #####################
  // State
  // #####################

  /// This method gets invoked if user wants to dismiss failure message.
  void onDismissFailure() {
    // Only emit new state if cubit is still open and not loading.
    if (isClosed || state.status == AddEmotionSheetStatus.loading) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AddEmotionSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  void closeSheet() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: AddEmotionSheetStatus.close,
    ));
  }

  // #####################
  // Emotion Data
  // #####################

  /// This method can be used to let user choose from emotions.
  Future<void> showEmotions({required BuildContext context}) async {
    try {
      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Reset state.
      emit(state.copyWith(
        status: AddEmotionSheetStatus.waiting,
      ));

      // Access language specific emotions.
      final PickerItems pickerItems = EmotionData.emotionsAsPickerItems();

      // Show PickerSheet.
      final int? pickerIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.emotionPickerSheetTitle(),
          pickerItems: pickerItems,
        ),
      );

      // * User did not pick an item.
      if (pickerIndex == null) return;

      // Access chosen item.
      final String pickedItemId = pickerItems.items[pickerIndex].id;

      // * User selected the same emotion, do nothing.
      if (pickedItemId == state.emotionItem.emotion) return;

      // Create updated emotion item.
      final EmotionItem updated = state.emotionItem.copyWith(
        emotion: pickedItemId,
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        emotionItem: updated,
        failure: Failure.initial(),
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddEmotionSheetCubit --> showEmotions() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: AddEmotionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddEmotionSheetCubit --> showEmotions() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AddEmotionSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to let user choose from a date picker.
  Future<void> onChooseOccurrance({required BuildContext context}) async {
    try {
      // Access initial DateTime.
      final tz.TZDateTime initialDateTime = HelperFunctions.convertToTimezone(
        dateTimeInUtc: state.emotionItem.occurrenceInUtc!,
        timezone: state.emotionItem.occurrenceTimeZone,
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

      // Create updated data.
      final EmotionItem updated = state.emotionItem.copyWith(
        occurrenceInUtc: changedInLocal.toUtc(),
      );

      // Only emit new state if cubit is still open.
      if (isClosed) return;

      // Emit changed state.
      emit(state.copyWith(
        emotionItem: updated,
        failure: Failure.initial(),
        status: AddEmotionSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddEmotionSheetCubit --> onChooseOccurrance() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: AddEmotionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddEmotionSheetCubit --> onChooseOccurrance() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AddEmotionSheetStatus.failure,
      ));
    }
  }

  /// This method can be used to let user choose a timezone.
  Future<void> chooseTimeZone({required BuildContext context}) async {
    try {
      // Access time zones as picker items.
      final PickerItems timezones = _localStorageCubit.state.timezones;

      // * Show PickerSheet.
      final int? pickedIndex = await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (_) => PickerSheet(
          title: labels.basicLabelsTimezones(),
          pickerItems: timezones,
        ),
      );

      // * User did not pick an item.
      if (pickedIndex == null) return;

      // Set helper.
      final String pickedZone = timezones.items[pickedIndex].id;

      // Change the timezone.
      final tz.TZDateTime changed = HelperFunctions.changeTimezone(
        dateTimeInUtc: state.emotionItem.occurrenceInUtc!,
        originalTimezone: state.emotionItem.occurrenceTimeZone,
        newTimezone: pickedZone,
      );

      // Update the state entry.
      final EmotionItem updatedItem = state.emotionItem.copyWith(
        occurrenceInUtc: changed.toUtc(),
        occurrenceTimeZone: pickedZone,
      );

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        emotionItem: updatedItem,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('AddEmotionSheetCubit --> chooseTimeZone() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: AddEmotionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('AddEmotionSheetCubit --> chooseTimeZone() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AddEmotionSheetStatus.failure,
      ));
    }
  }

  /// This method is invoked if user changes the intensity.
  Future<void> onIntensityChosen({required int value}) async {
    // Create updated emotion item.
    final EmotionItem updated = state.emotionItem.copyWith(
      intensity: value,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    // Emit changed state.
    emit(state.copyWith(
      emotionItem: updated,
      failure: Failure.initial(),
    ));
  }

  /// This method will be triggered if user wants to add chosen emotion.
  Future<void> onAddEmotionItem({required BuildContext context}) async {
    try {
      // Check if created item is valid.
      final bool invalidItem = state.emotionItem.emotion.isEmpty || state.emotionItem.occurrenceInUtc == null || state.emotionItem.occurrenceTimeZone.isEmpty || state.emotionItem.intensity == null;

      // Let user know that chosen emotion item is invalid.
      if (invalidItem) throw Failure.invalidEmotionItem();

      // Close sheet and return data.
      Navigator.of(context).pop(state.emotionItem);
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('onAddEmotionItem --> onAddEmotionItem() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: AddEmotionSheetStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('onAddEmotionItem --> onAddEmotionItem() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: AddEmotionSheetStatus.failure,
      ));
    }
  }
}
