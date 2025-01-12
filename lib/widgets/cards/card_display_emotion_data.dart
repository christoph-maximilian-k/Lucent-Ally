import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/chip_items/chip_items.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_notifications_tile.dart';

class CardDisplayEmotionData extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;

  // Trailing.
  final Function()? onMorePressed;

  // Subtitle.
  final String? subtitle;
  final bool isOneLine;

  // First Trailing Icon Button.
  final IconData? firstTrailingIcon;
  final String? firstTrailingIconTooltip;
  final Function()? firstTrailingOnPressed;

  // Second Trailing Icon Button.
  final IconData? secondTrailingIcon;
  final Function()? secondTrailingOnPressed;
  final String secondTrailingTooltip;

  // Chip Items.
  final ChipItems? chipItems;

  // Info Message.
  final String infoMessage;

  // Pending Notifications.
  final List<PendingNotificationRequest> pendingNotifications;
  final bool pendingNotificationsLoading;
  final Function(PendingNotificationRequest, int)? onNotificationSelected;
  final Function(PendingNotificationRequest, int)? onDeleteNotification;

  const CardDisplayEmotionData({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    // Trailing.
    this.onMorePressed,
    // Subtitle.
    this.subtitle,
    this.isOneLine = true,
    // First Trailing Icon Button.
    this.firstTrailingIcon,
    this.firstTrailingIconTooltip,
    this.firstTrailingOnPressed,
    // Second Trailing Icon Button.
    this.secondTrailingIcon,
    this.secondTrailingOnPressed,
    this.secondTrailingTooltip = '',
    // ChipItems.
    this.chipItems,
    // Info Message.
    this.infoMessage = '',
    // Pending Notifications.
    this.pendingNotifications = const [],
    this.pendingNotificationsLoading = false,
    this.onNotificationSelected,
    this.onDeleteNotification,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: 0.0,
            leading: Icon(
              icon,
              color: Theme.of(context).primaryIconTheme.color,
              size: Theme.of(context).primaryIconTheme.size,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: onMorePressed != null
                ? IconButton(
                    icon: Icon(
                      AppIcons.moreOptions,
                      color: Theme.of(context).iconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    onPressed: onMorePressed,
                  )
                : null,
          ),
          if (subtitle != null)
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: 15.0, bottom: isOneLine ? 0.0 : 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      subtitle!,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  if (firstTrailingIcon != null)
                    IconButton(
                      icon: Icon(
                        firstTrailingIcon,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: Theme.of(context).primaryIconTheme.size,
                      ),
                      tooltip: firstTrailingIconTooltip,
                      onPressed: firstTrailingOnPressed,
                    ),
                  const SizedBox(width: 5.0),
                  IconButton(
                    icon: Icon(
                      secondTrailingIcon,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    tooltip: secondTrailingTooltip,
                    onPressed: secondTrailingOnPressed,
                  ),
                ],
              ),
            ),
          if (chipItems != null && chipItems!.items.isNotEmpty)
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 40.0,
                    margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                    child: Row(
                      children: chipItems!.isLoading
                          ? [
                              const CustomLoadingSpinner(
                                paddingBottom: 5.0,
                              )
                            ]
                          : List<Widget>.generate(
                              chipItems!.items.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                child: GestureDetector(
                                  onTap: chipItems!.items[index].onPressed,
                                  child: Chip(
                                    label: Text(
                                      chipItems!.items[index].label,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          if (pendingNotifications.isNotEmpty)
            CustomNotificationsTile(
              title: labels.customNotificationsTileTitle(),
              pendingNotifications: pendingNotifications,
              pendingNotificationsLoading: pendingNotificationsLoading,
              onNotificationSelected: onNotificationSelected,
              onDeleteNotification: onDeleteNotification,
            ),
          Visibility(
            visible: infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 10.0),
              child: Text(
                infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
