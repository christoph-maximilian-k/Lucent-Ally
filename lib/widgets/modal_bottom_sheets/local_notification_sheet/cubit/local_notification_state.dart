part of 'local_notification_cubit.dart';

enum LocalNotificationStatus { pageIsLoading, pageHasError, loading, waiting, failure, close }

class LocalNotificationState extends Equatable {
  // * --- Notification Setup.

  final FlutterLocalNotificationsPlugin? notificationsPlugin;

  /// These are the notifications which will be shown at some point in the future.
  final List<PendingNotificationRequest> pendingNotifications;

  // * --- Notification Data.

  final bool isDelete;

  final Entry? entry;
  final Field? field;
  final Group? group;

  final PickerItems repeatPickerItems;
  final int selectedRepeatItem;

  final Key datePickerKey;
  final DateTime minimumDateTimeInLocal;

  final DateTime notificationDateTimeInLocal;

  final String notificationTitle;
  final String notificationMessage;

  final Failure pageFailure;

  final Failure failure;
  final LocalNotificationStatus status;

  const LocalNotificationState({
    // * Notification Setup.
    required this.notificationsPlugin,
    required this.pendingNotifications,
    // * Notification Data.
    required this.isDelete,
    required this.entry,
    required this.field,
    required this.group,
    required this.repeatPickerItems,
    required this.selectedRepeatItem,
    required this.datePickerKey,
    required this.minimumDateTimeInLocal,
    required this.notificationDateTimeInLocal,
    required this.notificationTitle,
    required this.notificationMessage,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object?> get props => [
        notificationsPlugin,
        pendingNotifications,
        isDelete,
        entry,
        field,
        group,
        repeatPickerItems,
        datePickerKey,
        selectedRepeatItem,
        minimumDateTimeInLocal,
        notificationDateTimeInLocal,
        notificationTitle,
        notificationMessage,
        pageFailure,
        failure,
        status,
      ];

  // ---------------------------------------------------
  // ---------- notification channel ids ---------------
  // ---------------------------------------------------

  /// Channel identification for reminders.
  /// ```dart
  /// static const String channelIdReminders = 'reminders';
  /// ```
  static const String channelIdReminders = 'reminders';

  // ---------------------------------------------------
  // ---------- picker items repeat identifications ----
  // ---------------------------------------------------

  /// PickerItems identification for repeat never notification.
  /// ```dart
  /// static const String repeatNever = 'never';
  /// ```
  static const String repeatNever = 'never';

  /// PickerItems identification for repeat every year notification.
  /// ```dart
  /// static const String repeatEveryYear = 'every_year';
  /// ```
  static const String repeatEveryYear = 'every_year';

  /// PickerItems identification for repeat every month notification.
  /// ```dart
  /// static const String repeatEveryMonth = 'every_month';
  /// ```
  static const String repeatEveryMonth = 'every_month';

  /// PickerItems identification for repeat every week notification.
  /// ```dart
  /// static const String repeatEveryWeek = 'every_week';
  /// ```
  static const String repeatEveryWeek = 'every_week';

  /// PickerItems identification for repeat every day notification.
  /// ```dart
  /// static const String repeatEveryDay = 'every_day';
  /// ```
  static const String repeatEveryDay = 'every_day';

  /// Initialize a new [LocalNotificationState] object.
  factory LocalNotificationState.initial() {
    return LocalNotificationState(
      // * Notification Setup.
      notificationsPlugin: null,
      pendingNotifications: const [],
      // * Notification Data.
      isDelete: false,
      entry: null,
      field: null,
      group: null,
      repeatPickerItems: PickerItems.initial(),
      selectedRepeatItem: 0,
      datePickerKey: ValueKey(DateTime.now().toString()),
      minimumDateTimeInLocal: DateTime.now(),
      notificationDateTimeInLocal: DateTime.now(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: LocalNotificationStatus.pageIsLoading,
      notificationTitle: '',
      notificationMessage: '',
    );
  }

  /// This getter can be used to access PendingNotifications of a group.
  List<PendingNotificationRequest> get getGroupNotifications {
    // Init helper.
    List<PendingNotificationRequest> helper = [];

    // Go through pending notifications and select those that are of group.
    for (final PendingNotificationRequest element in pendingNotifications) {
      // Access payload.
      final NotificationPayload payload = NotificationPayload.fromJson(doc: element.payload!);

      // Group payload found.
      if (payload.entryId.isEmpty && payload.fieldId.isEmpty && payload.groupId == group?.groupId) helper.add(element);
    }

    return helper;
  }

  /// This getter can be used to access PendingNotifications of group entries.
  List<PendingNotificationRequest> get getEntryNotifications {
    // Init helper.
    List<PendingNotificationRequest> helper = [];

    // Go through pending notifications and select those that are of group.
    for (final PendingNotificationRequest element in pendingNotifications) {
      // Access payload.
      final NotificationPayload payload = NotificationPayload.fromJson(doc: element.payload!);

      // Entry payload found.
      if (payload.entryId.isNotEmpty && payload.fieldId.isNotEmpty && payload.groupId == group?.groupId) helper.add(element);
    }

    return helper;
  }

  /// This getter can be used to get all notifications of group.
  List<PendingNotificationRequest> get getAllNotificationsOfGroup {
    return [...getGroupNotifications, ...getEntryNotifications];
  }

  // This getter can be used to check if notifications can be set.
  // * This is mainly due to the fact that IOS does not allow for more then 64 local notifications.
  bool get getCanSetNotifications {
    // * In case the platform is IOS, check number of already set notifications.
    // * 64 are allowed (last checked: 2024-08-01), but allow (currently 60 are allowed) less to plan for the future. Maybe some are needed by the app.
    if (Platform.isIOS) return pendingNotifications.length <= 59 ? true : false;

    return true;
  }

  /// This getter can be used to access correct init date times.
  DateTime get getLocalDateTimeYMDHM {
    // Access now.
    final DateTime now = DateTime.now();

    // Create DateTime.
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  /// This getter can be used access date as String in a readable way.
  String get getDateAsString {
    return notificationDateTimeInLocal.toIso8601String().substring(0, 10);
  }

  /// This getter can be used access date as String in a readable way.
  String get getTimeAsString {
    return notificationDateTimeInLocal.toIso8601String().substring(11, 16);
  }

  /// These components determine if a notification will be repeated or not.
  DateTimeComponents? get getSelectedDateTimeComponents {
    // * Notification should repeat every year.
    if (repeatPickerItems.items[selectedRepeatItem].id == repeatEveryYear) {
      return DateTimeComponents.dateAndTime;
    }

    // * Notification should repeat every month.
    if (repeatPickerItems.items[selectedRepeatItem].id == repeatEveryMonth) {
      return DateTimeComponents.dayOfMonthAndTime;
    }

    // * Notification should repeat every week.
    if (repeatPickerItems.items[selectedRepeatItem].id == repeatEveryWeek) {
      return DateTimeComponents.dayOfWeekAndTime;
    }

    // * Notification should repeat every day.
    if (repeatPickerItems.items[selectedRepeatItem].id == repeatEveryDay) {
      return DateTimeComponents.time;
    }

    // * Notification should not repeat.
    return null;
  }

  /// These components determine if a notification will be repeated or not.
  DateTimeComponents? getDateTimeComponentsById({required String repeatId}) {
    // * Notification should repeat every year.
    if (repeatId == repeatEveryYear) {
      return DateTimeComponents.dateAndTime;
    }

    // * Notification should repeat every month.
    if (repeatId == repeatEveryMonth) {
      return DateTimeComponents.dayOfMonthAndTime;
    }

    // * Notification should repeat every week.
    if (repeatId == repeatEveryWeek) {
      return DateTimeComponents.dayOfWeekAndTime;
    }

    // * Notification should repeat every day.
    if (repeatId == repeatEveryDay) {
      return DateTimeComponents.time;
    }

    // * Notification should not repeat.
    return null;
  }

  /// This method can be used to check if a provided notificationId is already in use.
  bool getNotificationIdIsUnique({required int notificationId}) {
    // Go through pending notifications.
    for (final PendingNotificationRequest request in pendingNotifications) {
      // Check for id equality.
      if (request.id == notificationId) return false;
    }

    return true;
  }

  /// This method can be used to check if a field already has notifications set.
  /// * If ```payload == null```, ```payload["field_id"] == null``` or ```payload["entry_id"] == null``` ```false``` is assumed.
  Future<bool> fieldHasPendingNotifications({required String entryId, required String fieldId}) async {
    // Go through pending notifications.
    for (final PendingNotificationRequest request in pendingNotifications) {
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
      if (payload.entryId == entryId && payload.fieldId == fieldId) return true;
    }

    return false;
  }

  /// This method can be used to access picker items for repeat picker.
  PickerItems getRepeatPickerItems() {
    // Picker items.
    PickerItems pickerItems = PickerItems(
      items: [
        PickerItem(
          id: repeatNever,
          label: labels.setNotificationStatePickerRepeatNeverLabel(),
        ),
        PickerItem(
          id: repeatEveryYear,
          label: labels.setNotificationStatePickerRepeatEveryYearLabel(),
        ),
        PickerItem(
          id: repeatEveryMonth,
          label: labels.setNotificationStatePickerRepeatEveryMonthLabel(),
        ),
        PickerItem(
          id: repeatEveryWeek,
          label: labels.setNotificationStatePickerRepeatEveryWeekLabel(),
        ),
        PickerItem(
          id: repeatEveryDay,
          label: labels.setNotificationStatePickerRepeatEveryDayLabel(),
        ),
      ],
    );

    return pickerItems;
  }

  /// This method can be used to remove a notification from state list.
  List<PendingNotificationRequest> removeNotification({required int id}) {
    // Init helper list.
    List<PendingNotificationRequest> list = [];

    // Go through notifications and select relevant data.
    for (final PendingNotificationRequest request in pendingNotifications) {
      if (request.id != id) list.add(request);
    }

    return list;
  }

  // #############################
  // Copy with
  // #############################

  LocalNotificationState copyWith({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
    List<PendingNotificationRequest>? pendingNotifications,
    bool? isDelete,
    Entry? entry,
    Field? field,
    Group? group,
    PickerItems? repeatPickerItems,
    int? selectedRepeatItem,
    Key? datePickerKey,
    DateTime? minimumDateTimeInLocal,
    DateTime? notificationDateTimeInLocal,
    String? notificationTitle,
    String? notificationMessage,
    Failure? pageFailure,
    Failure? failure,
    LocalNotificationStatus? status,
  }) {
    return LocalNotificationState(
      notificationsPlugin: notificationsPlugin ?? this.notificationsPlugin,
      pendingNotifications: pendingNotifications ?? this.pendingNotifications,
      isDelete: isDelete ?? this.isDelete,
      entry: entry ?? this.entry,
      field: field ?? this.field,
      group: group ?? this.group,
      repeatPickerItems: repeatPickerItems ?? this.repeatPickerItems,
      selectedRepeatItem: selectedRepeatItem ?? this.selectedRepeatItem,
      datePickerKey: datePickerKey ?? this.datePickerKey,
      minimumDateTimeInLocal: minimumDateTimeInLocal ?? this.minimumDateTimeInLocal,
      notificationDateTimeInLocal: notificationDateTimeInLocal ?? this.notificationDateTimeInLocal,
      notificationTitle: notificationTitle ?? this.notificationTitle,
      notificationMessage: notificationMessage ?? this.notificationMessage,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
