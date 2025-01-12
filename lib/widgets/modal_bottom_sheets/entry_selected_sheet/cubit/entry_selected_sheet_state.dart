part of 'entry_selected_sheet_cubit.dart';

enum EntrySelectedSheetStatus {
  pageIsLoading,
  pageHasError,
  loading,
  waiting,
  failure,
  chipsLoading,
  setNotification,
  reloadNotifications,
  close,
}

enum LoadNotificationsStatus { reloadPendingNotifications, loading, failure, waiting }

class EntrySelectedSheetState extends Equatable {
  final bool isShared;
  final bool fromRecentEntry;
  final bool fromViewEntriesSheet;
  // * --- Notification Setup.

  final FlutterLocalNotificationsPlugin? notificationsPlugin;

  /// These are the notifications which will be shown at some point in the future.
  final List<PendingNotificationRequest> pendingNotifications;

  final Failure loadNotificationsFailure;
  final LoadNotificationsStatus loadNotificationsStatus;

  final Field? notificationField;

  // * --- State Setup.

  final String loadingMessage;

  final Group topLevelGroup;

  final bool entryCreatorIsBanned;

  final Entry entry;
  final ModelEntry entryModel;

  final Group fromGroup;
  final Groups groups;

  final int currentLoadingChipsIndex;

  final List<String> currentlyLoadingExchangeRates;

  final Failure failure;
  final EntrySelectedSheetStatus status;

  final Failure pageFailure;

  const EntrySelectedSheetState({
    required this.isShared,
    required this.fromRecentEntry,
    required this.fromViewEntriesSheet,
    required this.notificationsPlugin,
    required this.pendingNotifications,
    required this.loadNotificationsFailure,
    required this.loadNotificationsStatus,
    required this.notificationField,
    required this.topLevelGroup,
    required this.entryCreatorIsBanned,
    required this.entry,
    required this.loadingMessage,
    required this.entryModel,
    required this.fromGroup,
    required this.groups,
    required this.currentLoadingChipsIndex,
    required this.currentlyLoadingExchangeRates,
    required this.failure,
    required this.status,
    required this.pageFailure,
  });

  @override
  List<Object?> get props => [
        isShared,
        fromRecentEntry,
        fromViewEntriesSheet,
        notificationsPlugin,
        pendingNotifications,
        loadNotificationsFailure,
        loadNotificationsStatus,
        notificationField,
        topLevelGroup,
        entryCreatorIsBanned,
        entry,
        entryModel,
        fromGroup,
        groups,
        currentLoadingChipsIndex,
        currentlyLoadingExchangeRates,
        failure,
        status,
        loadingMessage,
        pageFailure,
      ];

  /// Initialize a new ```EntrySelectedSheetState``` object.
  factory EntrySelectedSheetState.initial() {
    return EntrySelectedSheetState(
      isShared: false,
      fromRecentEntry: false,
      fromViewEntriesSheet: false,
      notificationsPlugin: null,
      pendingNotifications: const [],
      loadNotificationsFailure: Failure.initial(),
      loadNotificationsStatus: LoadNotificationsStatus.waiting,
      notificationField: null,
      entryCreatorIsBanned: false,
      topLevelGroup: Group.initial(),
      entry: Entry.initial(),
      entryModel: ModelEntry.initial(),
      fromGroup: Group.initial(),
      groups: Groups.initial(),
      currentLoadingChipsIndex: 0,
      failure: Failure.initial(),
      loadingMessage: '',
      status: EntrySelectedSheetStatus.pageIsLoading,
      currentlyLoadingExchangeRates: const [],
      pageFailure: Failure.initial(),
    );
  }

  /// This method can be used to access pending notifications for an individual field.
  List<PendingNotificationRequest> getPendingNotificationsOfField({required String fieldId}) {
    // Create helper List.
    List<PendingNotificationRequest> list = [];

    // Go through notifications and select relevant data.
    for (final PendingNotificationRequest request in pendingNotifications) {
      // Test for null or invalid data.
      if (request.payload == null || request.payload!.isEmpty) continue;

      // Access payload.
      final NotificationPayload payload = NotificationPayload.fromJson(doc: request.payload!);

      // If payload indicates that this notification is part of current field, add to list.
      if (payload.entryId == entry.entryId && payload.fieldId == fieldId) list.add(request);
    }

    return list;
  }

  /// This method can be used to access all pending notifications for an entry.
  List<PendingNotificationRequest> getPendingNotificationsOfEntry({required String entryId}) {
    // Create helper List.
    List<PendingNotificationRequest> list = [];

    // Go through notifications and select relevant data.
    for (final PendingNotificationRequest request in pendingNotifications) {
      // Test for null or invalid data.
      if (request.payload == null || request.payload!.isEmpty) continue;

      // Access payload.
      final NotificationPayload payload = NotificationPayload.fromJson(doc: request.payload!);

      // If payload indicates that this notification is part of current field, add to list.
      if (payload.entryId == entry.entryId) list.add(request);
    }

    return list;
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

  EntrySelectedSheetState copyWith({
    bool? isShared,
    bool? fromRecentEntry,
    bool? fromViewEntriesSheet,
    FlutterLocalNotificationsPlugin? notificationsPlugin,
    List<PendingNotificationRequest>? pendingNotifications,
    Failure? loadNotificationsFailure,
    LoadNotificationsStatus? loadNotificationsStatus,
    Field? notificationField,
    Group? topLevelGroup,
    bool? entryCreatorIsBanned,
    Entry? entry,
    ModelEntry? entryModel,
    Group? fromGroup,
    Groups? groups,
    int? currentLoadingChipsIndex,
    Failure? failure,
    String? loadingMessage,
    EntrySelectedSheetStatus? status,
    List<String>? currentlyLoadingExchangeRates,
    Failure? pageFailure,
  }) {
    return EntrySelectedSheetState(
      isShared: isShared ?? this.isShared,
      fromViewEntriesSheet: fromViewEntriesSheet ?? this.fromViewEntriesSheet,
      pageFailure: pageFailure ?? this.pageFailure,
      fromRecentEntry: fromRecentEntry ?? this.fromRecentEntry,
      notificationsPlugin: notificationsPlugin ?? this.notificationsPlugin,
      pendingNotifications: pendingNotifications ?? this.pendingNotifications,
      loadNotificationsFailure: loadNotificationsFailure ?? this.loadNotificationsFailure,
      loadNotificationsStatus: loadNotificationsStatus ?? this.loadNotificationsStatus,
      notificationField: notificationField ?? this.notificationField,
      topLevelGroup: topLevelGroup ?? this.topLevelGroup,
      entryCreatorIsBanned: entryCreatorIsBanned ?? this.entryCreatorIsBanned,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      entry: entry ?? this.entry,
      entryModel: entryModel ?? this.entryModel,
      fromGroup: fromGroup ?? this.fromGroup,
      groups: groups ?? this.groups,
      currentLoadingChipsIndex: currentLoadingChipsIndex ?? this.currentLoadingChipsIndex,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      currentlyLoadingExchangeRates: currentlyLoadingExchangeRates ?? this.currentlyLoadingExchangeRates,
    );
  }
}
