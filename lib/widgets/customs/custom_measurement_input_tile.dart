import 'package:flutter/material.dart';
import 'package:lucent_ally/widgets/customs/custom_date_time_zone.dart.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_types/measurement_data/measurement_data.dart';

// Widgets.
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_text_field.dart';
import '/widgets/customs/custom_switch_list_tile.dart';

class CustomMeasurementInputTile extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool hideCard;
  final bool requiredField;

  // Data.
  final MeasurementData measurementData;

  // Date.
  final String dateButtonLabel;
  final Function() onChooseDate;

  // Time.
  final String timeButtonLabel;
  final Function() onChooseTime;

  // Timezone.
  final String timezoneButtonLabel;
  final Function() onChooseTimezone;

  // Match Date with datapoint button.
  final String? labelOnPressedChooseMeasurementDataDateDatapoint;
  final Function()? onPressedChooseMeasurementDataDateDatapoint;

  // Choose Category button.
  final String chooseCategoryButtonLabel;
  final Function() onChooseCategory;

  // Text Field.
  final Key? textFieldKey;
  final int? maxLines;
  final TextInputType textInputType;
  final bool shouldRequestFocus;
  final String initialData;
  final Function(String, TextEditingController)? onChanged;
  final Function(String value, TextEditingController controller)? onSubmitted;
  final String? hint;
  final double? textFieldHeight;

  // Unit picker.
  final String chooseUnitButtonLabel;
  final Function() onChooseUnit;

  // Trailing Icon.
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function()? onTrailingIconPressed;

  // Additional buttons.
  final String? firstValueButtonLabel;
  final Function()? onFirstValueButtonPressed;

  final String? secondValueButtonLabel;
  final Function()? onSecondValueButtonPressed;

  final String? thirdValueButtonLabel;
  final Function()? onThirdValueButtonPressed;

  // Can change paramters.
  final String? canChangeParametersLabel;
  final Function(bool)? onChangeCanChangeParameters;
  final bool? canChangeParametersValue;

  // Info Message.
  final String infoMessage;

  const CustomMeasurementInputTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    this.subtitle,
    this.hideCard = false,
    this.requiredField = false,
    // Date.
    required this.dateButtonLabel,
    required this.onChooseDate,
    // Time.
    required this.timeButtonLabel,
    required this.onChooseTime,
    // Timezone.
    required this.timezoneButtonLabel,
    required this.onChooseTimezone,
    // Match Date with datapoint button.
    this.labelOnPressedChooseMeasurementDataDateDatapoint,
    this.onPressedChooseMeasurementDataDateDatapoint,
    // Data.
    required this.measurementData,
    // Choose Category button.
    required this.chooseCategoryButtonLabel,
    required this.onChooseCategory,
    // Text Field.
    this.textFieldKey,
    this.maxLines,
    this.textInputType = TextInputType.text,
    this.shouldRequestFocus = false,
    this.initialData = '',
    this.onChanged,
    this.onSubmitted,
    this.hint,
    this.textFieldHeight,
    // Unit picker.
    required this.chooseUnitButtonLabel,
    required this.onChooseUnit,
    // Trailing Icon.
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    this.onTrailingIconPressed,
    // Additional buttons.
    this.firstValueButtonLabel,
    this.onFirstValueButtonPressed,
    this.secondValueButtonLabel,
    this.onSecondValueButtonPressed,
    this.thirdValueButtonLabel,
    this.onThirdValueButtonPressed,
    // Can change parameters.
    this.canChangeParametersLabel,
    this.onChangeCanChangeParameters,
    this.canChangeParametersValue,
    // Info Message.
    this.infoMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: hideCard ? 0.0 : null,
      color: hideCard ? Colors.transparent : null,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
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
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                : null,
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
          if (requiredField == false) const SizedBox(height: 10.0),
          // * Choose category button.
          CustomDropDownButton(
            isOutlined: true,
            label: chooseCategoryButtonLabel,
            onTap: onChooseCategory,
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: measurementData.category.isNotEmpty,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 200.0,
                  padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0),
                  child: CustomTextField(
                    key: textFieldKey,
                    textFieldHeight: textFieldHeight,
                    maxLines: maxLines,
                    shouldRequestFocus: shouldRequestFocus,
                    initialData: initialData,
                    hint: hint,
                    textInputType: textInputType,
                    onSubmitted: onSubmitted,
                    onChanged: onChanged,
                  ),
                ),
                // * Choose unit button.
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: CustomDropDownButton(
                    label: chooseUnitButtonLabel,
                    onTap: onChooseUnit,
                  ),
                ),
              ],
            ),
          ),
          if (firstValueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 15.0),
              child: CustomDropDownButton(
                label: firstValueButtonLabel!,
                onTap: onFirstValueButtonPressed!,
              ),
            ),
          if (secondValueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 15.0),
              child: CustomDropDownButton(
                label: secondValueButtonLabel!,
                onTap: onSecondValueButtonPressed!,
              ),
            ),
          if (thirdValueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 15.0),
              child: CustomDropDownButton(
                label: thirdValueButtonLabel!,
                onTap: onThirdValueButtonPressed!,
              ),
            ),
          const SizedBox(height: 10.0),
          Text(
            labels.basicLabelsDate(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20.0),
          // * Measurement date.
          CustomDateTimeZone(
            // Date.
            dateButtonLabel: dateButtonLabel,
            dateButtonSublabel: measurementData.createdAtInUtc == null || measurementData.createdAtTimezone.isEmpty ? null : labels.dateOnlyFormat(),
            onPressedDate: () => onChooseDate(),
            // Time.
            timeButtonLabel: timeButtonLabel,
            onPressedTime: onChooseTime,
            // Timezone.
            timezoneButtonLabel: timezoneButtonLabel,
            onPressedTimezone: () => onChooseTimezone(),
          ),
          // * User is in import match mode. Display connect payment date with datapoint button.
          if (labelOnPressedChooseMeasurementDataDateDatapoint != null)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomDropDownButton(
                label: labelOnPressedChooseMeasurementDataDateDatapoint!,
                onTap: () => onPressedChooseMeasurementDataDateDatapoint!(),
              ),
            ),
          const SizedBox(height: 20.0),
          if (canChangeParametersLabel != null)
            CustomSwitchListTile(
              padding: const EdgeInsets.only(left: 25.0, bottom: 10.0, right: 20.0),
              title: canChangeParametersLabel!,
              value: canChangeParametersValue!,
              onChanged: onChangeCanChangeParameters,
            ),
          // * Info Message.
          Visibility(
            visible: infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0, top: 10.0),
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
