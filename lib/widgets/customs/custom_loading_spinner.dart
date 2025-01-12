import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widgets.
import '/widgets/customs/custom_text_button.dart';

class CustomLoadingSpinner extends StatelessWidget {
  final bool onlySpinner;
  final String? loadingMessage;
  final double paddingTop;
  final double paddingBottom;
  final double paddingRight;
  final Color? color;
  final bool showButton;
  final String? buttonLabel;
  final Function()? onButtonPressed;

  const CustomLoadingSpinner({
    super.key,
    this.onlySpinner = false,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
    this.paddingRight = 0.0,
    this.loadingMessage,
    this.color,
    this.showButton = false,
    this.buttonLabel,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // * Only return the spinner. This is needed for refresh because otherwise a RenderFlex error occurrs because of the Column.
    if (onlySpinner) {
      return Padding(
        padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
          right: paddingRight,
        ),
        child: CupertinoActivityIndicator(color: color ?? Theme.of(context).colorScheme.onSurface),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: paddingTop,
              bottom: paddingBottom,
              right: paddingRight,
            ),
            child: CupertinoActivityIndicator(color: color ?? Theme.of(context).colorScheme.onSurface),
          ),
          if (loadingMessage != null && loadingMessage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: Text(
                loadingMessage ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          if (showButton)
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: CustomTextButton(
                label: buttonLabel!,
                onPressed: onButtonPressed,
              ),
            ),
        ],
      ),
    );
  }
}
