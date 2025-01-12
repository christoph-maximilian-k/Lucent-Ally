import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/failure.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';

class CardError extends StatelessWidget {
  final bool showCard;
  final Failure failure;
  final EdgeInsets? padding;
  final String buttonLabel;
  final Function() onButtonPressed;

  const CardError({
    super.key,
    this.showCard = true,
    required this.failure,
    this.padding,
    required this.buttonLabel,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: padding,
        child: showCard
            ? Card(
                child: _contentBuilder(
                  context: context,
                  failure: failure,
                  onButtonPressed: onButtonPressed,
                  buttonLabel: buttonLabel,
                ),
              )
            : _contentBuilder(
                context: context,
                failure: failure,
                onButtonPressed: onButtonPressed,
                buttonLabel: buttonLabel,
              ),
      ),
    );
  }
}

// Builder function to create content.
Widget _contentBuilder({required BuildContext context, required Failure failure, required String buttonLabel, required Function() onButtonPressed}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        AppIcons.error,
        color: Theme.of(context).colorScheme.error,
        size: 20.0,
      ),
      const SizedBox(height: 20.0),
      Text(
        failure.message,
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 30.0),
      CustomElevatedButton(
        label: buttonLabel,
        onPressed: onButtonPressed,
      ),
    ],
  );
}
