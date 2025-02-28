import 'dart:convert';

import 'package:equatable/equatable.dart';

// Labels.
import '/main.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';

class NotificationPayload extends Equatable {
  final String entryId;
  final String fieldId;
  final String groupId;
  final bool isAutoGenerated;

  /// Represents the exact date and time for the notification as an absolute point in time.
  /// This value is not tied to any specific time zone, ensuring it is treated consistently,
  /// regardless of the user's current location or time zone changes.
  /// For example, if a user sets a notification in Germany for 6 AM and then moves to Australia,
  /// the notification will still trigger at 6 AM local time in their new location.
  final DateTime notificationDateTimeAbsolute;

  final String repeatId;
  final String channelId;
  final String channelName;

  /// [NotificationPayload] constructor.
  const NotificationPayload({
    required this.entryId,
    required this.fieldId,
    required this.groupId,
    required this.isAutoGenerated,
    required this.notificationDateTimeAbsolute,
    required this.repeatId,
    required this.channelId,
    required this.channelName,
  });

  /// This getter can be used to access correct init date times.
  DateTime get getLocalDateTimeYMDHM {
    // Access now.
    final DateTime now = DateTime.now();

    // Create DateTime.
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  /// This getter can be used access given dateTime as String in a readable way.
  String _getDateAsString({required DateTime dateTime}) {
    return dateTime.toIso8601String().substring(0, 10);
  }

  /// This getter can be used access given DateTime as String in a readable way.
  String _getTimeAsString({required DateTime dateTime}) {
    return dateTime.toIso8601String().substring(11, 16);
  }

  /// This method can be used to add years to a given dateTime.
  DateTime _addYearsAndMonths({required DateTime dateTime, int years = 0, int months = 0}) {
    return DateTime(
      dateTime.year + years,
      dateTime.month + months,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );
  }

  /// This getter can be used to access [notificationDateTimeAbsolute] depending on current DateTime and if notification gets repeated.
  String getNextNotificationAsString() {
    // Check if notification is in the past.
    final bool inPast = notificationDateTimeAbsolute.isBefore(getLocalDateTimeYMDHM);

    // Check if notification is at same moment.
    final bool atSameMoment = notificationDateTimeAbsolute.isAtSameMomentAs(getLocalDateTimeYMDHM);

    // Display information.
    if ((inPast || atSameMoment) && repeatId == LocalNotificationState.repeatNever) {
      return labels.notificationPayloadNotificationInPast();
    }

    // If the notification repeats every year and first notification is in the past change label.
    if ((inPast || atSameMoment) && repeatId == LocalNotificationState.repeatEveryYear) {
      // Access new dateTime.
      final DateTime added = _addYearsAndMonths(dateTime: notificationDateTimeAbsolute, years: 1);

      return labels.notificationPayloadNotificationDateTime(
        date: _getDateAsString(dateTime: added),
        time: _getTimeAsString(dateTime: added),
      );
    }

    // If the notification repeats every month and first notification is in the past change label.
    if ((inPast || atSameMoment) && repeatId == LocalNotificationState.repeatEveryMonth) {
      // Access new dateTime.
      final DateTime added = _addYearsAndMonths(dateTime: notificationDateTimeAbsolute, months: 1);

      return labels.notificationPayloadNotificationDateTime(
        date: _getDateAsString(dateTime: added),
        time: _getTimeAsString(dateTime: added),
      );
    }

    // If the notification repeats every week and first notification is in the past change label.
    if ((inPast || atSameMoment) && repeatId == LocalNotificationState.repeatEveryWeek) {
      // Access new dateTime.
      final DateTime added = notificationDateTimeAbsolute.add(const Duration(days: 7));

      return labels.notificationPayloadNotificationDateTime(
        date: _getDateAsString(dateTime: added),
        time: _getTimeAsString(dateTime: added),
      );
    }

    // If the notification repeats every day and first notification is in the past change label.
    if ((inPast || atSameMoment) && repeatId == LocalNotificationState.repeatEveryDay) {
      // Access new dateTime.
      final DateTime added = notificationDateTimeAbsolute.add(const Duration(days: 1));

      return labels.notificationPayloadNotificationDateTime(
        date: _getDateAsString(dateTime: added),
        time: _getTimeAsString(dateTime: added),
      );
    }

    // Return current as default.
    return labels.notificationPayloadNotificationDateTime(
      date: _getDateAsString(dateTime: notificationDateTimeAbsolute),
      time: _getTimeAsString(dateTime: notificationDateTimeAbsolute),
    );
  }

  /// This method can be used to access the correct language labels for each [repeatId].
  String getRepeatLabel() {
    // Return label for repeats every year.
    if (repeatId == LocalNotificationState.repeatEveryYear) {
      return labels.notificationPayloadRepeatLabelEveryYear();
    }

    // Return label for repeats every month.
    if (repeatId == LocalNotificationState.repeatEveryMonth) {
      return labels.notificationPayloadRepeatLabelEveryMonth();
    }

    // Return label for repeats every week.
    if (repeatId == LocalNotificationState.repeatEveryWeek) {
      return labels.notificationPayloadRepeatLabelEveryWeek();
    }

    // Return label for repeats every day.
    if (repeatId == LocalNotificationState.repeatEveryDay) {
      return labels.notificationPayloadRepeatLabelEveryDay();
    }

    // * Default is never.
    return labels.notificationPayloadRepeatLabelNever();
  }

  /// Encode a [NotificationPayload] object to a document.
  Map<String, dynamic> toDocument() {
    return {
      'entry_id': entryId,
      'field_id': fieldId,
      'group_id': groupId,
      'is_auto_generated': isAutoGenerated,
      'first_scheduled_at_absolute': notificationDateTimeAbsolute.toIso8601String(),
      'repeat_id': repeatId,
      'channel_id': channelId,
      'channel_name': channelName,
    };
  }

  /// Decode a [NotificationPayload] object from a document.
  static NotificationPayload fromDocument({required Map<String, dynamic> map}) {
    return NotificationPayload(
      entryId: map['entry_id'],
      fieldId: map['field_id'],
      groupId: map['group_id'],
      isAutoGenerated: map['is_auto_generated'],
      notificationDateTimeAbsolute: DateTime.parse(map['first_scheduled_at_absolute']),
      repeatId: map['repeat_id'],
      channelId: map['channel_id'],
      channelName: map['channel_name'],
    );
  }

  /// Encode a [NotificationPayload] object to JSON.
  String toJson() {
    // Create Map.
    final Map<String, dynamic> payload = toDocument();

    // Create JSON.
    return jsonEncode(payload);
  }

  /// Decode a [NotificationPayload] object from JSON.
  static NotificationPayload fromJson({required String doc}) {
    // Decode JSON.
    final Map<String, dynamic> map = jsonDecode(doc);

    // Decode into payload.
    final NotificationPayload payload = fromDocument(map: map);

    return payload;
  }

  @override
  List<Object> get props => [entryId, fieldId];

  NotificationPayload copyWith({
    String? entryId,
    String? fieldId,
    String? groupId,
    bool? isAutoGenerated,
    DateTime? notificationDateTimeAbsolute,
    String? repeatId,
    String? channelId,
    String? channelName,
  }) {
    return NotificationPayload(
      entryId: entryId ?? this.entryId,
      fieldId: fieldId ?? this.fieldId,
      groupId: groupId ?? this.groupId,
      isAutoGenerated: isAutoGenerated ?? this.isAutoGenerated,
      notificationDateTimeAbsolute: notificationDateTimeAbsolute ?? this.notificationDateTimeAbsolute,
      repeatId: repeatId ?? this.repeatId,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
    );
  }
}
