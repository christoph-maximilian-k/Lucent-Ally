import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/notification_payload/notification_payload.dart';

class LocalNotificationDetailsSheet extends StatelessWidget {
  final PendingNotificationRequest notification;

  const LocalNotificationDetailsSheet({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    // Access Notification Payload.
    final NotificationPayload notificationPayload = NotificationPayload.fromJson(
      doc: notification.payload!,
    );

    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 80.0),
              width: double.infinity,
              child: Card(
                child: ListTile(
                  title: Text(
                    labels.localNotificationsDetailsSheetTitle(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SelectableText(
                      labels.localNotificationsDetailsSheetSubtitle(title: notification.title),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 80.0),
              width: double.infinity,
              child: Card(
                child: ListTile(
                  title: Text(
                    labels.localNotificationsDetailsSheetMessage(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SelectableText(
                      labels.localNotificationsDetailsSheetMessageSubtitle(message: notification.body),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 80.0),
              width: double.infinity,
              child: Card(
                child: ListTile(
                  title: Text(
                    labels.localNotificationsDetailsSheetNextNotification(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SelectableText(
                      notificationPayload.getNextNotificationAsString(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 80.0),
              width: double.infinity,
              child: Card(
                child: ListTile(
                  title: Text(
                    labels.localNotificationsDetailsSheetNotificationRepeats(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SelectableText(
                      notificationPayload.getRepeatLabel(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
            ),
            if (Platform.isIOS) const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
