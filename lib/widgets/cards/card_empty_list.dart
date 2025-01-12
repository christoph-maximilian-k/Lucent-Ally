import 'package:flutter/material.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';

class CardEmptyList extends StatelessWidget {
  final String message;
  final String? buttonLabel;
  final Function()? onPressed;

  const CardEmptyList({
    super.key,
    required this.message,
    this.buttonLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.2,
      width: double.infinity,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15.0),
            Text(
              message,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15.0),
            if (buttonLabel != null)
              CustomElevatedButton(
                margin: const EdgeInsets.all(25.0),
                label: buttonLabel!,
                onPressed: onPressed,
              ),
          ],
        ),
      ),
    );
  }
}
