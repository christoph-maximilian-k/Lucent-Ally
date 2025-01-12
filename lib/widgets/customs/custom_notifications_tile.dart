import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_text_button.dart';

class CustomNotificationsTile extends StatelessWidget {
  final double? height;
  final String title;
  final List<PendingNotificationRequest> pendingNotifications;
  final bool pendingNotificationsLoading;
  final Function(PendingNotificationRequest, int)? onNotificationSelected;
  final Function(PendingNotificationRequest, int)? onDeleteNotification;

  const CustomNotificationsTile({
    super.key,
    this.height,
    required this.title,
    required this.pendingNotifications,
    this.pendingNotificationsLoading = false,
    this.onNotificationSelected,
    this.onDeleteNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Show loading indication.
        if (pendingNotificationsLoading) {
          return const Center(
            child: CustomLoadingSpinner(),
          );
        }

        // Specified as double.infinity.
        if (height == double.infinity) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              ...List<Widget>.generate(
                pendingNotifications.length,
                (final int index) {
                  // Access Notifications.
                  final PendingNotificationRequest request = pendingNotifications[index];

                  // Access title.
                  final String title = labels.customNotificationsTileNotificationTitle(title: request.title);

                  return Container(
                    height: 55.0,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: CustomTextButton(
                      label: title,
                      overflow: TextOverflow.ellipsis,
                      isOutlined: true,
                      onPressed: onNotificationSelected == null ? () {} : () => onNotificationSelected!(request, index),
                      icon: AppIcons.delete,
                      onIconButtonPressed: onDeleteNotification == null ? () {} : () => onDeleteNotification!(request, index),
                    ),
                  );
                },
              ),
            ],
          );
        }

        // Height was not specified.
        return Container(
          height: pendingNotifications.length == 1
              ? 115.0
              : pendingNotifications.length <= 2
                  ? 165.0
                  : 205.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: pendingNotifications.length,
            itemBuilder: (BuildContext context, int index) {
              final PendingNotificationRequest request = pendingNotifications[index];
              final String notificationTitle = labels.customNotificationsTileNotificationTitle(title: request.title);

              return Container(
                height: 65.0,
                padding: const EdgeInsets.only(top: 10.0,left: 10.0, right: 10.0, bottom: 10.0),
                child: CustomTextButton(
                  label: notificationTitle,
                  overflow: TextOverflow.ellipsis,
                  isOutlined: true,
                  onPressed: onNotificationSelected == null ? () {} : () => onNotificationSelected!(request, index),
                  icon: AppIcons.delete,
                  onIconButtonPressed: onDeleteNotification == null ? () {} : () => onDeleteNotification!(request, index),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
