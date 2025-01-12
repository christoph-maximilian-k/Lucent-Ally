import 'package:flutter/material.dart';

// Widgets.
import '/widgets/customs/custom_drop_down_button.dart';

class CustomDateTimeZone extends StatelessWidget {
  final String dateButtonLabel;
  final String? dateButtonSublabel;
  final Function() onPressedDate;

  final String? timeButtonLabel;
  final String? timeButtonSublabel;
  final Function()? onPressedTime;

  final String? timezoneButtonLabel;
  final Function()? onPressedTimezone;

  const CustomDateTimeZone({
    super.key,
    // Date.
    required this.dateButtonLabel,
    required this.onPressedDate,
    this.dateButtonSublabel,
    // Time.
    this.timeButtonLabel,
    this.timeButtonSublabel,
    this.onPressedTime,
    // Timezone.
    this.timezoneButtonLabel,
    this.onPressedTimezone,
  });

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final bool displayTime = timeButtonLabel != null;
    final bool displayTimezone = timezoneButtonLabel != null;

    final bool displayAll = displayTime && displayTimezone;
    final bool displayDateAndTime = displayTime && displayTimezone == false;

    return Builder(
      builder: (context) {
        // * Display Date, Time and Timezone.
        if (displayAll) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // * Date.
                  CustomDropDownButton(
                    isOutlined: true,
                    label: dateButtonLabel,
                    subLabel: dateButtonSublabel,
                    onTap: onPressedDate,
                  ),
                  const SizedBox(width: 10.0),
                  // * Time.
                  CustomDropDownButton(
                    // Time button.
                    label: timeButtonLabel!,
                    subLabel: timeButtonSublabel,
                    onTap: onPressedTime!,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // * Timezone.
              CustomDropDownButton(
                // Time zone button.
                label: timezoneButtonLabel!,
                onTap: onPressedTimezone!,
              ),
              const SizedBox(height: 10.0),
            ],
          );
        }

        // * Display Date and Time.
        // ! For example for Birthday field a timezone picker should not be shown.
        if (displayDateAndTime) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // * Date.
                CustomDropDownButton(
                  isOutlined: true,
                  label: dateButtonLabel,
                  subLabel: dateButtonSublabel,
                  onTap: onPressedDate,
                ),
                const SizedBox(width: 10.0),
                // * Time.
                CustomDropDownButton(
                  // Time button.
                  label: timeButtonLabel!,
                  subLabel: timeButtonSublabel,
                  onTap: onPressedTime!,
                ),
              ],
            ),
          );
        }

        // * Display Date and Timezone.
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0),
              // * Date.
              CustomDropDownButton(
                isOutlined: true,
                label: dateButtonLabel,
                subLabel: dateButtonSublabel,
                onTap: onPressedDate,
              ),
              const SizedBox(height: 20.0),
              // * Time.
              CustomDropDownButton(
                // Time zone button.
                label: timezoneButtonLabel!,
                onTap: onPressedTimezone!,
              ),
              const SizedBox(height: 20.0),
            ],
          
        );
      },
    );
  }
}
