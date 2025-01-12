import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';

class CustomEntryReferenceSelectorTile extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;
  final String? subtitle;

  // Info Message.
  final String infoMessage;

  // Button.
  final String buttonLabel;
  final Function() onButtonPressed;

  // Delete Button.
  final bool showDeleteButton;
  final Function() onDeletePressed;

  const CustomEntryReferenceSelectorTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    this.subtitle,
    // Info Message.
    this.infoMessage = '',
    // Button.
    required this.buttonLabel,
    required this.onButtonPressed,
    // Delete Button.
    required this.showDeleteButton,
    required this.onDeletePressed,
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
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    margin: const EdgeInsets.all(5.0),
                    label: buttonLabel,
                    onPressed: onButtonPressed,
                  ),
                ),
                if (showDeleteButton)
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: IconButton(
                      onPressed: onDeletePressed,
                      icon: Icon(
                        AppIcons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Visibility(
            visible: infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
