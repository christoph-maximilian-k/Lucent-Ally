import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';

class TimeSelector extends StatelessWidget {
  final int minutesInterval;
  final TimeOfDay? initialTime;

  const TimeSelector({
    super.key,
    required this.minutesInterval,
    this.initialTime,
  });

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    // Helper variable that holds hours selected.
    // * init with current hour.
    int selectedHour = initialTime == null ? DateTime.now().hour : initialTime!.hour;

    // Helper variable that holds minutes selected.
    int selectedMinute = initialTime == null ? DateTime.now().minute : initialTime!.minute;

    return SizedBox(
      height: deviceHeight * 0.4,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: deviceHeight / 4,
                width: deviceWidth * 0.45,
                child: CupertinoPicker(
                  itemExtent: 25,
                  looping: true,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedHour,
                  ),
                  onSelectedItemChanged: (int index) => selectedHour = index,
                  children: List.generate(
                    24,
                    (index) => Text(
                      index < 10 ? '0$index' : '$index',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ),
              Text(
                ':',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(
                height: deviceHeight / 4,
                width: deviceWidth * 0.45,
                child: CupertinoPicker(
                  itemExtent: 25,
                  looping: true,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedMinute == 0 ? selectedMinute : selectedMinute ~/ minutesInterval,
                  ),
                  onSelectedItemChanged: (int index) => selectedMinute = index * minutesInterval,
                  children: List.generate(
                    60 ~/ minutesInterval,
                    (index) => Text(
                      index * minutesInterval < 10 ? '0${index * minutesInterval}' : '${index * minutesInterval}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomElevatedButton(
            margin: const EdgeInsets.all(10.0),
            label: labels.basicLabelsReady(),
            onPressed: () => Navigator.of(context).pop(TimeOfDay(hour: selectedHour, minute: selectedMinute)),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
