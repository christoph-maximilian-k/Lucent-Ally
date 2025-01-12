import 'package:flutter/material.dart';
import 'package:lucent_ally/widgets/customs/custom_date_time_zone.dart.dart';

// Labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_text_field.dart';

class CustomDateInputTile extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;
  final bool requiredField;

  // Date Data.
  final String buttonLabel;
  final Function() onChooseDate;

  // Time Data.
  final String? timeButtonLabel;
  final Function()? onChooseTime;

  // Time Zone button.
  final String? timeZoneButtonLabel;
  final Function()? onTimeZoneButtonPressed;

  // Trailing Icon.
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function()? onTrailingIconPressed;

  // Switch.
  final Function(bool)? onSwitchChanged;
  final bool? switchValue;
  final String? switchTitle;

  // InputField.
  final Key? textFieldKey;
  final Function(String, TextEditingController)? onInputChanged;
  final String? initialInputData;
  final String? inputHint;

  // Value Button.
  final String? valueButtonLabel;
  final Function()? onValueButtonPressed;

  // Time Zone button.
  final String? timeZoneImportButtonLabel;
  final Function()? onTimeZoneImportButtonPressed;

  // Info Message.
  final TextStyle? infoMessageTextStyle;
  final String infoMessage;

  const CustomDateInputTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    this.requiredField = false,
    // Date Data.
    required this.buttonLabel,
    required this.onChooseDate,
    // Time Data.
    this.timeButtonLabel,
    this.onChooseTime,
    // Trailing Icon.
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    this.onTrailingIconPressed,
    // Switch.
    this.onSwitchChanged,
    this.switchValue,
    this.switchTitle,
    // Input.
    this.textFieldKey,
    this.onInputChanged,
    this.initialInputData,
    this.inputHint,
    // Value button.
    this.valueButtonLabel,
    this.onValueButtonPressed,
    // Time Zone button.
    this.timeZoneButtonLabel,
    this.onTimeZoneButtonPressed,
    // Time zone value button.
    this.timeZoneImportButtonLabel,
    this.onTimeZoneImportButtonPressed,
    // Info Message.
    this.infoMessageTextStyle,
    this.infoMessage = "",
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
          CustomDateTimeZone(
            // Date.
            dateButtonLabel: buttonLabel,
            onPressedDate: onChooseDate,
            // Time.
            timeButtonLabel: timeButtonLabel,
            onPressedTime: onChooseTime,
            // Timezone.
            timezoneButtonLabel: timeZoneButtonLabel,
            onPressedTimezone: onTimeZoneButtonPressed,
          ),
          if (onSwitchChanged != null)
            Column(
              children: [
                CustomSwitchListTile(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  onChanged: (final bool value) => onSwitchChanged!(value),
                  value: switchValue!,
                  title: switchTitle!,
                ),
                const SizedBox(height: 20.0),
                if (onInputChanged != null && switchValue!)
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 25.0),
                    child: CustomTextField(
                      key: textFieldKey,
                      initialData: initialInputData ?? '',
                      maxLines: 1,
                      hint: inputHint,
                      onChanged: (final String value, final TextEditingController controller) => onInputChanged!(value, controller),
                    ),
                  ),
              ],
            ),
          if (valueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: CustomDropDownButton(
                label: valueButtonLabel!,
                onTap: onValueButtonPressed!,
              ),
            ),
          if (timeZoneImportButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: CustomDropDownButton(
                label: timeZoneImportButtonLabel!,
                onTap: onTimeZoneImportButtonPressed!,
              ),
            ),
          Visibility(
            visible: infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                infoMessage,
                textAlign: TextAlign.center,
                style: infoMessageTextStyle ?? Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
