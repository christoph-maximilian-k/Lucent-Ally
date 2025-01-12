import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/chip_items/chip_items.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_notifications_tile.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_drop_down_button.dart';

class CardDisplayText extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;

  // Trailing.
  final Function()? onMorePressed;

  // Date.
  final String? dateLabel;

  // Subtitle.
  final String? subtitle;

  // Thirdline.
  final String? thirdline;
  final String? thirdlineTitle;

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

  // Switch.
  final String switchLabel;
  final bool valueSwitch;
  final Function(bool)? onSwitchChanged;

  // Drop down button.
  final String? dropDownLabel;
  final Function()? onDropDownPressed;

  // Info Message.
  final String infoMessage;

  // Pending Notifications.
  final List<PendingNotificationRequest> pendingNotifications;
  final bool pendingNotificationsLoading;
  final Function(PendingNotificationRequest, int)? onNotificationSelected;
  final Function(PendingNotificationRequest, int)? onDeleteNotification;

  const CardDisplayText({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    // Trailing.
    this.onMorePressed,
    // Date label.
    this.dateLabel,
    // Subtitle.
    this.subtitle,
    // Thirdline.
    this.thirdline,
    this.thirdlineTitle,
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
    // Switch.
    this.infoMessage = '',
    // Drop down button.
    this.dropDownLabel,
    this.onDropDownPressed,
    // Info Message.
    this.switchLabel = '',
    this.valueSwitch = false,
    this.onSwitchChanged,
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
            contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0),
            horizontalTitleGap: 5.0,
            leading: Icon(
              icon,
              color: Theme.of(context).primaryIconTheme.color,
              size: Theme.of(context).primaryIconTheme.size,
            ),
            title: SelectableText(
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
              padding: const EdgeInsets.only(left: 18.0, right: 4.0, bottom: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SelectableText(
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
          if (thirdline != null && thirdline!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 4.0, bottom: 10.0),
              child: Column(
                children: [
                  Text(
                    thirdlineTitle!,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      SelectableText(
                        thirdline!,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          if (dateLabel != null && dateLabel!.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 10.0),
                Text(
                  labels.basicLabelsDate(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20.0),
                SelectableText(
                  dateLabel!,
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          if (chipItems != null && chipItems!.items.isNotEmpty)
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
          if (pendingNotifications.isNotEmpty)
            CustomNotificationsTile(
              title: labels.customNotificationsTileTitle(),
              pendingNotifications: pendingNotifications,
              pendingNotificationsLoading: pendingNotificationsLoading,
              onNotificationSelected: onNotificationSelected,
              onDeleteNotification: onDeleteNotification,
            ),
          if (dropDownLabel != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: CustomDropDownButton(
                label: dropDownLabel!,
                onTap: onDropDownPressed!,
                maxWidth: 200.0,
              ),
            ),
          if (switchLabel.isNotEmpty)
            CustomSwitchListTile(
              padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 20.0),
              key: UniqueKey(),
              title: switchLabel,
              value: valueSwitch,
              onChanged: onSwitchChanged,
            ),
          Visibility(
            visible: infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
              child: Text(
                infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
