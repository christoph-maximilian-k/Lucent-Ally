import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Models.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';

class DateSelector extends StatelessWidget {
  final DateTime initialDateTime;

  const DateSelector({
    super.key,
    required this.initialDateTime,
  });

  @override
  Widget build(BuildContext context) {
    DateTime chosenDate = initialDateTime;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              child: CupertinoDatePicker(
                initialDateTime: initialDateTime,
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                onDateTimeChanged: (value) => chosenDate = DateTime(
                  value.year,
                  value.month,
                  value.day,
                  initialDateTime.hour,
                  initialDateTime.minute,
                  initialDateTime.second,
                  initialDateTime.millisecond,
                  initialDateTime.microsecond,
                ),
              ),
            ),
          ),
          CustomElevatedButton(
            margin: const EdgeInsets.all(10.0),
            label: labels.dateSelectorButtonLabel(),
            onPressed: () => Navigator.of(context).pop(chosenDate),
          ),
          if (Platform.isIOS) const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
