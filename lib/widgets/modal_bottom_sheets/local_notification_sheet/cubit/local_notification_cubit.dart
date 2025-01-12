import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Config.
import '/config/app_durations.dart';

// Labels.
import '/main.dart';

// Repositories.
import '/data/repositories/local_notifications/local_notifications_repository.dart';

// Cubits.
import '/logic/app_messages_cubit/app_messages_cubit.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/confirm_sheet/confirm_sheet.dart';
import '/widgets/modal_bottom_sheets/local_notification_details_sheet/local_notification_details_sheet.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/entries/entry.dart';
import '/data/models/fields/field.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/notification_payload/notification_payload.dart';
import '/data/models/groups/group.dart';

part 'local_notification_state.dart';

class LocalNotificationCubit extends Cubit<LocalNotificationState> {
  final LocalNotificationsRepository _localNotificationsRepository;
  final AppMessagesCubit _appMessagesCubit;

  LocalNotificationCubit({
    required LocalNotificationsRepository localNotificationsRepository,
    required AppMessagesCubit appMessagesCubit,
  })  : _localNotificationsRepository = localNotificationsRepository,
        _appMessagesCubit = appMessagesCubit,
        super(LocalNotificationState.initial());

  // ############################################
  // # Initialization
  // ############################################

  /// Initialize state data with an entry.
  Future<void> initializeWithEntry({required Group group, required Entry entry, required Field field}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init Local Notifications.
      final FlutterLocalNotificationsPlugin plugin = await _localNotificationsRepository.initPlugin();

      // Init a DateTime variable.
      final DateTime now = state.getLocalDateTimeYMDHM;

      // Access currently pending notifications and store them into state.
      final List<PendingNotificationRequest> pendingNotifications = await plugin.pendingNotificationRequests();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        notificationsPlugin: plugin,
        pendingNotifications: pendingNotifications,
        entry: entry,
        field: field,
        group: group,
        minimumDateTimeInLocal: now,
        notificationDateTimeInLocal: now,
        repeatPickerItems: state.getRepeatPickerItems(),
        notificationTitle: entry.entryName,
        notificationMessage: '',
        status: LocalNotificationStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> initializeWithEntry() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: failure,
        status: LocalNotificationStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalNotificationCubit --> initializeWithEntry --> exception: ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: Failure.failedToInitNotificationPlugin(),
        status: LocalNotificationStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data with an entry.
  Future<void> initializeWithGroup({required Group group}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init Local Notifications.
      final FlutterLocalNotificationsPlugin plugin = await _localNotificationsRepository.initPlugin();

      // Init a DateTime variable.
      final DateTime now = state.getLocalDateTimeYMDHM;

      // Access currently pending notifications and store them into state.
      final List<PendingNotificationRequest> pendingNotifications = await plugin.pendingNotificationRequests();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        notificationsPlugin: plugin,
        pendingNotifications: pendingNotifications,
        group: group,
        minimumDateTimeInLocal: now,
        notificationDateTimeInLocal: now,
        repeatPickerItems: state.getRepeatPickerItems(),
        notificationTitle: group.groupName,
        notificationMessage: '',
        status: LocalNotificationStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> initializeWithGroup() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: failure,
        status: LocalNotificationStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalNotificationCubit --> initializeWithGroup --> exception: ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: Failure.failedToInitNotificationPlugin(),
        status: LocalNotificationStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data in delete mode.
  Future<void> initializeDelete({required Group group}) async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init Local Notifications.
      final FlutterLocalNotificationsPlugin plugin = await _localNotificationsRepository.initPlugin();

      // Access currently pending notifications and store them into state.
      final List<PendingNotificationRequest> pendingNotifications = await plugin.pendingNotificationRequests();

      // Init a DateTime variable.
      final DateTime now = state.getLocalDateTimeYMDHM;

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        isDelete: true,
        notificationsPlugin: plugin,
        pendingNotifications: pendingNotifications,
        group: group,
        minimumDateTimeInLocal: now,
        notificationDateTimeInLocal: now,
        repeatPickerItems: state.getRepeatPickerItems(),
        status: LocalNotificationStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> initializeDelete() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: failure,
        status: LocalNotificationStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalNotificationCubit --> initializeDelete --> exception: ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: Failure.failedToInitNotificationPlugin(),
        status: LocalNotificationStatus.pageHasError,
      ));
    }
  }

  /// Initialize state data without an entry.
  Future<void> initializeWithoutInitialData() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Init Local Notifications.
      final FlutterLocalNotificationsPlugin plugin = await _localNotificationsRepository.initPlugin();

      // Init a DateTime variable.
      final DateTime now = state.getLocalDateTimeYMDHM;

      // Access currently pending notifications and store them into state.
      final List<PendingNotificationRequest> pendingNotifications = await plugin.pendingNotificationRequests();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        notificationsPlugin: plugin,
        pendingNotifications: pendingNotifications,
        minimumDateTimeInLocal: now,
        notificationDateTimeInLocal: now,
        repeatPickerItems: state.getRepeatPickerItems(),
        status: LocalNotificationStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> initializeWithoutInitialData() --> failure: ${failure.toString()}');

      // Make sure cubit is still open.
      if (isClosed) return;

      // Emit failure state.
      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: failure,
        status: LocalNotificationStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalNotificationCubit --> initializeWithoutInitialData --> exception: ${exception.toString()}');

      // Only emit new states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        notificationsPlugin: null,
        pageFailure: Failure.failedToInitNotificationPlugin(),
        status: LocalNotificationStatus.pageHasError,
      ));
    }
  }

  // ############################################
  // # State
  // ############################################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: LocalNotificationStatus.waiting,
    ));
  }

  /// This function can be used to update time.
  void updateTime() {
    // Access now.
    final DateTime now = state.getLocalDateTimeYMDHM;

    // Update if needed.
    if (now.isAfter(state.notificationDateTimeInLocal)) {
      // Update notification date time.
      final DateTime notificationDateTime = DateTime(
        state.notificationDateTimeInLocal.year,
        state.notificationDateTimeInLocal.month,
        state.notificationDateTimeInLocal.day,
        now.hour,
        now.minute,
      );

      // Only emit states if cubit is still open.
      if (isClosed) return;

      emit(state.copyWith(
        datePickerKey: ValueKey(DateTime.now().toString()),
        minimumDateTimeInLocal: now,
        notificationDateTimeInLocal: notificationDateTime,
      ));
    }
  }

  /// This method gets invoked if user changes the repeat selection.
  void updateSelectRepeatItem({required int index}) {
    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      selectedRepeatItem: index,
    ));
  }

  /// This method is triggered if user changes notification date time selection.
  void onNotificationDateTimeChanged({required DateTime dateTime}) {
    // Update notification date time.
    final DateTime notificationDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );

    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      notificationDateTimeInLocal: notificationDateTime,
    ));
  }

  /// This method will be triggered if notification title changes.
  void notificationTitleChanged({required String value, required TextEditingController controller}) {
    // If user wants to clear data.
    if (value.isEmpty) controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      notificationTitle: value,
    ));
  }

  /// This method will be triggered if notification body changes.
  void notificationBodyChanged({required String value, required TextEditingController controller}) {
    // If user wants to clear data.
    if (value.isEmpty) controller.clear();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      notificationMessage: value,
    ));
  }

  /// This method gets invoked if user wants to close local notification sheet.
  /// * Should be used in a try catch block.
  void closeSheet({required BuildContext context, required bool notificationSet}) => Navigator.of(context).pop(notificationSet);

  /// This method gets invoked if user wants to delete a local notification.
  Future<void> onDeleteNotification({required BuildContext context, required PendingNotificationRequest request, required int index}) async {
    try {
      // Do not do anything if status is loading or cubit is closed.
      if (state.status == LocalNotificationStatus.loading || isClosed) return;

      // Show a confirm dialog if context is present.

      // * Show a confirm indication.
      final bool? confirm = await showModalBottomSheet(
        context: context,
        builder: (context) => ConfirmSheet(
          title: labels.entrySelectedSheetConfirmDeleteNotification(),
        ),
      );

      // * User canceled.
      if (confirm != true) return;

      // * Emit a loading status sheet wide.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: LocalNotificationStatus.loading,
      ));

      // Make sure plugin was initialized.
      if (state.notificationsPlugin == null) throw Failure.failedToInitNotificationPlugin();

      // Delete the notification.
      await _localNotificationsRepository.deleteNotification(
        notificationsPlugin: state.notificationsPlugin!,
        id: request.id,
      );

      // Remove notification from state.
      final List<PendingNotificationRequest> removedRequests = state.removeNotification(
        id: request.id,
      );

      // * Reset state.
      emit(state.copyWith(
        pendingNotifications: removedRequests,
        status: LocalNotificationStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> deleteNotification() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: LocalNotificationStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> deleteNotification() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalNotificationStatus.failure,
      ));
    }
  }

  /// This method gets invoked if user wants to select a local notification.
  Future<void> onNotificationSelected({required BuildContext context, required PendingNotificationRequest request, required int index}) async {
    try {
      // Do not do anything if status is loading or cubit is closed.
      if (state.status == LocalNotificationStatus.loading || isClosed) return;

      // Emit failure if payload is not accessible.
      if (request.payload == null || request.payload!.isEmpty) throw Failure.notificationPayloadIsInvalid();

      // * Show EntrySelectedSheet.
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isDismissible: true,
        builder: (context) => LocalNotificationDetailsSheet(
          notification: request,
        ),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> onNotificationSelected() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: LocalNotificationStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalNotificationCubit --> onNotificationSelected() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalNotificationStatus.failure,
      ));
    }
  }

  // ############################################
  // # Local Notifications methods
  // ############################################

  /// This method gets invoked if user taps on the floating action button.
  Future<void> setNotification({required BuildContext context}) async {
    try {
      // Check if settings notifications is possible.
      if (state.getCanSetNotifications == false) throw Failure.tooManyNotifications();

      // Only emit states if cubit is still open.
      if (isClosed) return;

      // Display loading.
      emit(state.copyWith(
        failure: Failure.initial(),
        status: LocalNotificationStatus.loading,
      ));

      // Notification cannot be in the past.
      if (state.notificationDateTimeInLocal.isBefore(state.getLocalDateTimeYMDHM)) {
        throw Failure.notificationCannotBeInPast();
      }

      // Notification cannot be at the same time as current time.
      if (state.notificationDateTimeInLocal.isAtSameMomentAs(state.getLocalDateTimeYMDHM)) {
        throw Failure.notificationCannotBeInPast();
      }

      // Notifications require a title.
      if (state.notificationTitle.isEmpty) {
        throw Failure.notificationTitleCannotBeEmpty();
      }

      // Make sure that plugin is not null.
      if (state.notificationsPlugin == null) {
        throw Failure.failedToInitNotificationPlugin();
      }

      // Get a unique notification id.
      final int notificationId = UniqueKey().hashCode;

      // Is notification Id really unique?
      // * I just dont trust possibilities...
      final bool isUnique = state.getNotificationIdIsUnique(notificationId: notificationId);

      // Notification Id is not unique.
      if (isUnique == false) throw Failure.notificationIdIsNotUnique();

      // Create the notification.
      await createNotification(
        entryId: state.entry?.entryId ?? '',
        fieldId: state.field?.fieldId ?? '',
        groupId: state.group!.groupId,
        isAutoGenerated: false,
        firstScheduledAtInLocal: state.notificationDateTimeInLocal,
        repeatId: state.repeatPickerItems.items[state.selectedRepeatItem].id,
        channelId: LocalNotificationState.channelIdReminders,
        channelName: LocalNotificationState.channelIdReminders,
        notificationId: notificationId,
        notificationTitle: state.notificationTitle,
        notificationMessage: state.notificationMessage,
        notificationDateTimeInLocal: state.notificationDateTimeInLocal,
        dateTimeComponents: state.getSelectedDateTimeComponents,
        notificationsPlugin: state.notificationsPlugin!,
      );

      // Only emit new states if cubit is open.
      if (isClosed) return;

      // Close the sheet.
      emit(state.copyWith(
        status: LocalNotificationStatus.close,
      ));

      // * Show notification.
      _appMessagesCubit.showNotification(
        message: labels.setNotificationSheetNotificationScheduled(),
      );
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalNotificationCubit --> setNotification() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: LocalNotificationStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalNotificationCubit --> setNotification() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: LocalNotificationStatus.failure,
      ));
    }
  }

  /// This method can be used to delete pending notifications.
  Future<void> deletePendingEntryNotifications({required String entryId, required String fieldId}) async {
    // Helper.
    List<int> removedNotifications = [];

    // Go through pending notifications.
    for (final PendingNotificationRequest request in state.pendingNotifications) {
      // Test for null or invalid data.
      if (request.payload == null || request.payload!.isEmpty) continue;

      // Access payload.
      final NotificationPayload payload = NotificationPayload.fromJson(doc: request.payload!);

      // Payload not found.
      if (payload.entryId.isEmpty) continue;
      if (payload.fieldId.isEmpty) continue;

      // Check for id equality.
      // * It is necessary to check for both entryId and fieldId because fieldId is used in many entries
      // * and therefore might exist in another entry.
      if (payload.entryId == entryId && payload.fieldId == fieldId) {
        await _localNotificationsRepository.deleteNotification(
          notificationsPlugin: state.notificationsPlugin!,
          id: request.id,
        );

        // Remove notification from state.
        removedNotifications.add(request.id);
      }
    }

    // Helper.
    List<PendingNotificationRequest> updatedNotifications = [];

    // Create updated pending requests.
    for (final PendingNotificationRequest request in state.pendingNotifications) {
      if (removedNotifications.contains(request.id)) continue;

      updatedNotifications.add(request);
    }

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      pendingNotifications: updatedNotifications,
    ));
  }

  /// This method can be used to update auto notifications.
  Future<void> updatePendingEntryNotifications({required String groupId, required String entryId, required String fieldId, required bool onlyAutoNotifications, required DateTime firstScheduledAtInLocal, required String notificationMessage, required String notificationTitle}) async {
    // Go through pending notifications.
    for (final PendingNotificationRequest request in state.pendingNotifications) {
      // Test for null or invalid data.
      if (request.payload == null || request.payload!.isEmpty) continue;

      // Access payload.
      final NotificationPayload payload = NotificationPayload.fromJson(doc: request.payload!);

      // Required data not found.
      if (payload.entryId.isEmpty) continue;
      if (payload.fieldId.isEmpty) continue;
      if (onlyAutoNotifications && payload.isAutoGenerated == false) continue;

      // Check for id equality.
      // * It is necessary to check for both entryId and fieldId because fieldId is used in many entries
      // * and therefore might exist in another entry.
      if (payload.entryId == entryId && payload.fieldId == fieldId) {
        await _localNotificationsRepository.deleteNotification(
          notificationsPlugin: state.notificationsPlugin!,
          id: request.id,
        );

        // Create the notification.
        await createNotification(
          entryId: entryId,
          fieldId: fieldId,
          groupId: groupId,
          isAutoGenerated: payload.isAutoGenerated,
          firstScheduledAtInLocal: firstScheduledAtInLocal,
          repeatId: payload.repeatId,
          channelId: payload.channelId,
          channelName: payload.channelName,
          notificationId: request.id,
          notificationTitle: notificationTitle,
          notificationMessage: notificationMessage,
          notificationDateTimeInLocal: firstScheduledAtInLocal,
          dateTimeComponents: state.getDateTimeComponentsById(repeatId: payload.repeatId),
          notificationsPlugin: state.notificationsPlugin!,
        );
      }
    }
  }

  /// This method can be used to sanitize notifications of an entry.
  Future<void> sanitizeEntryNotifications({required String groupId, required Entry initialEntry, required Entry entry}) async {
    // Go through fields and sanitize notifications.
    for (final Field field in entry.fields.items) {
      // Check if field will be excluded because in that case field should not have any notifications set.
      final bool exclude = field.getExcludeField(isDefault: false, isImport: false);

      // * Field will be excluded, remove notifications.
      if (exclude) {
        // Delete notifications.
        await deletePendingEntryNotifications(entryId: entry.entryId, fieldId: field.fieldId);

        continue;
      }

      // In case date of DoB changes, update local notification.
      if (field.fieldType == Field.fieldTypeDateOfBirth) {
        // Access initial field.
        final Field? initialField = initialEntry.fields.getById(fieldId: field.fieldId);

        // Initial field not found, which means there should not be any notifications for this field set.
        if (initialField == null || initialField.dateOfBirthData == null) continue;

        // Value did not change, a update is not needed.
        if (initialField.dateOfBirthData!.value == field.dateOfBirthData!.value) continue;

        // Create now.
        final DateTime now = DateTime.now();

        // Create a DateTime for the next occurrence of the birthday in the current year.
        DateTime nextBirthday = DateTime(now.year, field.dateOfBirthData!.value!.month, field.dateOfBirthData!.value!.day);

        // If the next birthday is in the past, use the next year.
        if (nextBirthday.isBefore(now)) {
          nextBirthday = DateTime(now.year + 1, field.dateOfBirthData!.value!.month, field.dateOfBirthData!.value!.day, 13);
        }

        // * Value changed, update auto generated notification.
        await updatePendingEntryNotifications(
          entryId: entry.entryId,
          fieldId: field.fieldId,
          groupId: groupId,
          onlyAutoNotifications: true,
          notificationTitle: field.dateOfBirthData!.notificationTitle.isNotEmpty
              ? field.dateOfBirthData!.notificationTitle
              : labels.dateOfBirthNotificationTitle(
                  entryName: entry.entryName,
                ),
          // ! Why is this empty? The problem is that this is static. Meaning that if it is set to
          // ! for example dateOfBirthData.getAgeAsLabel the same age will always be shown regardless
          // ! of how many birthdays have already passed.
          notificationMessage: '',
          firstScheduledAtInLocal: nextBirthday,
        );
      }
    }

    // Access currently pending notifications and store them into state.
    final List<PendingNotificationRequest> pendingNotifications = await state.notificationsPlugin!.pendingNotificationRequests();

    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      pendingNotifications: pendingNotifications,
    ));
  }

  /// This helper method can be used to set a entry notification.
  Future<void> createNotification({required String entryId, required String fieldId, required String groupId, required bool isAutoGenerated, required String channelId, required String channelName, required DateTime firstScheduledAtInLocal, required DateTime notificationDateTimeInLocal, required String repeatId, required String notificationTitle, required String notificationMessage, required int notificationId, required DateTimeComponents? dateTimeComponents, required FlutterLocalNotificationsPlugin notificationsPlugin}) async {
    // Create notification payload.
    final NotificationPayload notificationPayload = NotificationPayload(
      entryId: entryId,
      fieldId: fieldId,
      groupId: groupId,
      isAutoGenerated: isAutoGenerated,
      notificationDateTimeAbsolute: firstScheduledAtInLocal,
      repeatId: repeatId,
      channelId: channelId,
      channelName: channelName,
    );

    // Schedule a notification.
    await _localNotificationsRepository.scheduleNotification(
      channelId: channelId,
      channelName: channelName,
      channelDescription: labels.allNotificationsAreGroupedInOneChannel(),
      notificationId: notificationId,
      notificationTitle: notificationTitle,
      notificationBody: notificationMessage,
      notificationDateTimeInLocal: notificationDateTimeInLocal,
      notificationPayload: notificationPayload,
      dateTimeComponents: dateTimeComponents,
      notificationsPlugin: notificationsPlugin,
    );
  }
}
