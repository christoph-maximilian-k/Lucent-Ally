import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

class SelectOptionSheet extends StatelessWidget {
  final String? title;
  final String? infoMessage;

  final String? optionOne;
  final IconData? optionOneIcon;
  final Color? optionOneIconColor;
  final bool optionOneSuffix;

  final String? optionTwo;
  final IconData? optionTwoIcon;
  final Color? optionTwoIconColor;
  final bool optionTwoSuffix;

  final String? optionThree;
  final IconData? optionThreeIcon;
  final Color? optionThreeIconColor;
  final bool optionThreeSuffix;

  final String? optionFour;
  final IconData? optionFourIcon;
  final Color? optionFourIconColor;
  final bool optionFourSuffix;

  final String? optionFive;
  final IconData? optionFiveIcon;
  final Color? optionFiveIconColor;
  final bool optionFiveSuffix;

  final String? optionSix;
  final IconData? optionSixIcon;
  final Color? optionSixIconColor;
  final bool optionSixSuffix;

  final String? optionSeven;
  final IconData? optionSevenIcon;
  final Color? optionSevenIconColor;
  final bool optionSevenSuffix;

  final String? optionEight;
  final IconData? optionEightIcon;
  final Color? optionEightIconColor;
  final bool optionEightSuffix;

  final String? optionNine;
  final IconData? optionNineIcon;
  final Color? optionNineIconColor;
  final bool optionNineSuffix;

  const SelectOptionSheet({
    super.key,
    this.title,
    this.infoMessage,
    // Option One.
    this.optionOne,
    this.optionOneIcon,
    this.optionOneIconColor,
    this.optionOneSuffix = false,
    // Option Two.
    this.optionTwo,
    this.optionTwoIcon,
    this.optionTwoIconColor,
    this.optionTwoSuffix = false,
    // Option three.
    this.optionThree,
    this.optionThreeIcon,
    this.optionThreeIconColor,
    this.optionThreeSuffix = false,
    // Option Four.
    this.optionFour,
    this.optionFourIcon,
    this.optionFourIconColor,
    this.optionFourSuffix = false,
    // Option Five.
    this.optionFive,
    this.optionFiveIcon,
    this.optionFiveIconColor,
    this.optionFiveSuffix = false,
    // Option Six.
    this.optionSix,
    this.optionSixIcon,
    this.optionSixIconColor,
    this.optionSixSuffix = false,
    // Option Seven.
    this.optionSeven,
    this.optionSevenIcon,
    this.optionSevenIconColor,
    this.optionSevenSuffix = false,
    // Option Eight.
    this.optionEight,
    this.optionEightIcon,
    this.optionEightIconColor,
    this.optionEightSuffix = false,
    // Option Nine.
    this.optionNine,
    this.optionNineIcon,
    this.optionNineIconColor,
    this.optionNineSuffix = false,
  });

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20.0),
        if (title != null && title!.isNotEmpty)
          Column(
            children: [
              const SizedBox(height: 10.0),
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        if (optionOne != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(1),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionOneIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionOneIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionOneIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionOne!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionOneSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionTwo != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(2),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionTwoIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionTwoIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionTwoIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionTwo!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionTwoSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionThree != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(3),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionThreeIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionThreeIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionThreeIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionThree!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionThreeSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionFour != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(4),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionFourIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionFourIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionFourIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionFour!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionFourSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionFive != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(5),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionFiveIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionFiveIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionFourIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionFive!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionFiveSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionSix != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(6),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionSixIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionSixIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionFourIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionSix!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionSixSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionSeven != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(7),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionSevenIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionSevenIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionFourIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionSeven!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionSevenSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionEight != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(8),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionEightIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionEightIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionFourIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionEight!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionEightSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (optionNine != null)
          InkWell(
            onTap: () => Navigator.of(context).pop(9),
            child: Container(
              width: width,
              height: 45.0,
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    if (optionNineIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 15.0),
                        child: Icon(
                          optionNineIcon!,
                          size: Theme.of(context).primaryIconTheme.size,
                          color: optionFourIconColor ?? Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        optionNine!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    if (optionNineSuffix)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          AppIcons.forward,
                          size: Theme.of(context).iconTheme.size,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (infoMessage != null && infoMessage!.isNotEmpty)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                child: Text(
                  infoMessage!,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        const SizedBox(height: 60.0),
      ],
    );
  }
}
