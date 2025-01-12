import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lucent_ally/logic/helper_functions/helper_functions.dart';
import 'package:timezone/timezone.dart' as tz;

// Models.
import '/data/models/failure.dart';
import '/data/models/notification_payload/notification_payload.dart';

class LocalNotificationsRepository {
  /// Initialize notifications plugin.
  /// * Should be used in a try catch block.
  Future<FlutterLocalNotificationsPlugin> initPlugin() async {
    // Init Local Notifications Plugin.
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Set Local Notifications Icon.
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      'logo',
    );

    // Create initialization settings for IOS.
    // * The permissions are set to false in order to request them later.
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    // Create initialization settings for android and ios.
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize Local Notifications Plugin with its settings.
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    return flutterLocalNotificationsPlugin;
  }

  /// Set a scheduled notification.
  /// * should be used in a try catch block
  /// * distinguishes between platforms
  Future<void> scheduleNotification({required FlutterLocalNotificationsPlugin notificationsPlugin, required String channelId, required String channelName, required String channelDescription, required int notificationId, required String notificationTitle, required String notificationBody, required DateTime notificationDateTimeInLocal, required NotificationPayload notificationPayload, required DateTimeComponents? dateTimeComponents}) async {
    // Init android notification.
    if (Platform.isAndroid) {
      // Check if notifications are enabled.
      final bool notificationsEnabled = await _androidNotificationsEnabled(notificationsPlugin: notificationsPlugin);

      // Notifications are not enabled.
      if (notificationsEnabled == false) {
        // Request permissions.
        final bool granted = await _androidRequestNotificationsPermission(notificationsPlugin: notificationsPlugin);

        // Permissions denied.
        if (granted == false) throw Failure.notificationsDisabled();
      }

      // Schedule Android notification.
      final bool success = await _androidScheduleNotification(
        notificationsPlugin: notificationsPlugin,
        channelId: channelId,
        channelName: channelName,
        channelDescription: channelDescription,
        notificationId: notificationId,
        notificationTitle: notificationTitle,
        notificationBody: notificationBody,
        notificationDateTimeInLocal: notificationDateTimeInLocal,
        dateTimeComponents: dateTimeComponents,
        notificationPayload: notificationPayload,
      );

      // Scheduling notification succeeded.
      if (success) return;

      throw Failure.scheduleNotificationFailed();
    }

    // Init IOS notification.
    if (Platform.isIOS) {
      // Check if notifications are enabled.
      final bool notificationsEnabled = await _iosRequestNotificationPermission(notificationsPlugin: notificationsPlugin);

      // Notifications are not enabled.
      if (notificationsEnabled == false) throw Failure.notificationsDisabled();

      // Schedule Android notification.
      final bool success = await _iosScheduleNotification(
        notificationsPlugin: notificationsPlugin,
        channelId: channelId,
        channelName: channelName,
        channelDescription: channelDescription,
        notificationId: notificationId,
        notificationTitle: notificationTitle,
        notificationBody: notificationBody,
        notificationDateTimeInLocal: notificationDateTimeInLocal,
        dateTimeComponents: dateTimeComponents,
        notificationPayload: notificationPayload,
      );

      // Scheduling notification succeeded.
      if (success) return;

      throw Failure.scheduleNotificationFailed();
    }

    // Notifications have not been implemented for this platform.
    throw Failure.notificationsNotImplemented();
  }

  /// This method can be used to delete a request by id.
  /// * should be used in a try catch block
  Future<void> deleteNotification({required FlutterLocalNotificationsPlugin notificationsPlugin, required int id}) async {
    // Cancle the notification.
    await notificationsPlugin.cancel(id);
  }

  // * -------- Android notification functions --------

  /// This method can be used to check if android permissions are granted.
  Future<bool> _androidNotificationsEnabled({required FlutterLocalNotificationsPlugin notificationsPlugin}) async {
    // Init androidImplementation.
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation = notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    // Check if user granted notifications permissions.
    final bool enabled = await androidImplementation?.areNotificationsEnabled() ?? false;

    // Output debug message.
    debugPrint('LocalNotificationsRepository --> androidNotificationsEnabled() --> enabled: $enabled');

    return enabled;
  }

  /// This method can be used to request notifications permission on android.
  Future<bool> _androidRequestNotificationsPermission({required FlutterLocalNotificationsPlugin notificationsPlugin}) async {
    // Init androidImplementation.
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation = notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    // Request notification permission.
    final bool notificationGranted = await androidImplementation?.requestNotificationsPermission() ?? false;

    // Request exact permission.
    final bool exactGranted = await androidImplementation?.requestExactAlarmsPermission() ?? false;

    // Output debug message.
    debugPrint('LocalNotificationsRepository --> androidRequestNotificationsPermission() --> notificationGranted: $notificationGranted');

    // Output debug message.
    debugPrint('LocalNotificationsRepository --> androidRequestNotificationsPermission() --> exactGranted: $exactGranted');

    return (notificationGranted && exactGranted);
  }

  /// Schedule an android notification.
  /// * Should be used in a try catch block.
  Future<bool> _androidScheduleNotification({required FlutterLocalNotificationsPlugin notificationsPlugin, required String channelId, required String channelName, required String channelDescription, required int notificationId, required String notificationTitle, required String notificationBody, required DateTime notificationDateTimeInLocal, required NotificationPayload notificationPayload, required DateTimeComponents? dateTimeComponents}) async {
    // Create android channel specifics.
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      icon: 'logo',
      importance: Importance.max,
      styleInformation: const BigTextStyleInformation(''),
    );

    // Create Notification Details.
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Access timezone.
    final String? timezone = HelperFunctions.getCurrentTimezone();

    // Ensure that a timezone is available.
    if (timezone == null) throw Failure.timezoneRequired();

    // Get the stored timezone location (e.g., Europe/Berlin).
    final tz.Location location = tz.getLocation(timezone);

    // Create schedule dateTime.
    final tz.TZDateTime scheduled = tz.TZDateTime(
      location,
      notificationDateTimeInLocal.year,
      notificationDateTimeInLocal.month,
      notificationDateTimeInLocal.day,
      notificationDateTimeInLocal.hour,
      notificationDateTimeInLocal.minute,
    );

    // Set a zoned schedule.
    await notificationsPlugin.zonedSchedule(
      notificationId,
      notificationTitle,
      notificationBody.isEmpty ? null : notificationBody,
      scheduled,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: dateTimeComponents,
      payload: notificationPayload.toJson(),
    );

    return true;
  }

  // * -------- IOS notification functions --------

  /// This method can be used to request notifications permission for IOS.
  /// * Should be used in a try catch block.
  Future<bool> _iosRequestNotificationPermission({required FlutterLocalNotificationsPlugin notificationsPlugin}) async {
    // Init platform specific implementation.
    final IOSFlutterLocalNotificationsPlugin? iosImplementation = notificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

    // Check if user granted notifications permissions.
    final bool granted = await iosImplementation?.requestPermissions(alert: true, badge: true, sound: true) ?? false;

    // Output debug message.
    debugPrint('LocalNotificationsRepository --> iosNotificationsGranted() --> granted: $granted');

    return granted;
  }

  /// Schedule an android notification.
  /// * Should be used in a try catch block.
  Future<bool> _iosScheduleNotification({required FlutterLocalNotificationsPlugin notificationsPlugin, required String channelId, required String channelName, required String channelDescription, required int notificationId, required String notificationTitle, required String notificationBody, required DateTime notificationDateTimeInLocal, required NotificationPayload notificationPayload, required DateTimeComponents? dateTimeComponents}) async {
    // Create android channel specifics.
    const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    // Create Notification Details.
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
    );

    // Create schedule dateTime.
    final tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      notificationDateTimeInLocal.year,
      notificationDateTimeInLocal.month,
      notificationDateTimeInLocal.day,
      notificationDateTimeInLocal.hour,
      notificationDateTimeInLocal.minute,
    );

    // Set a zoned schedule.
    await notificationsPlugin.zonedSchedule(
      notificationId,
      notificationTitle,
      notificationBody.isEmpty ? null : notificationBody,
      scheduled,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: dateTimeComponents,
      payload: notificationPayload.toJson(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    return true;
  }
}
