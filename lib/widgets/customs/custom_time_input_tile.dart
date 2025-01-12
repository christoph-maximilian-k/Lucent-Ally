import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_drop_down_button.dart';

class CustomTimeInputTile extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;
  final bool requiredField;

  // Date Data.
  final String buttonLabel;
  final Function() onChooseTime;

  // Trailing Icon.
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function()? onTrailingIconPressed;

  // Value Button.
  final String? valueButtonLabel;
  final Function()? onValueButtonPressed;

  // Info Message.
  final String infoMessage;

  const CustomTimeInputTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    this.requiredField = false,
    // Date Data.
    required this.buttonLabel,
    required this.onChooseTime,
    // Trailing Icon.
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    this.onTrailingIconPressed,
    // Value Button.
    this.valueButtonLabel,
    this.onValueButtonPressed,
    // Info Message.
    this.infoMessage = "",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: UniqueKey(),
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
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: trailingIcon != null
                ? IconButton(
                    icon: Icon(
                      trailingIcon,
                      color: trailingIconColor,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    onPressed: onTrailingIconPressed,
                    tooltip: trailingIconTooltip,
                  )
                : null,
          ),
          if (requiredField)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
                child: Text(
                  labels.basicLabelsAValueIsRequired(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: requiredField ? 0.0 : 5.0, bottom: 10.0),
            child: CustomDropDownButton(
              isOutlined: true,
              label: buttonLabel,
              onTap: onChooseTime,
            ),
          ),
          if (valueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: CustomDropDownButton(
                label: valueButtonLabel!,
                onTap: onValueButtonPressed!,
              ),
            ),
          const SizedBox(height: 10.0),
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
