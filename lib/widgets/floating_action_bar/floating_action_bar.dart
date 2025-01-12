import 'package:flutter/material.dart';

// Custom Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/floating_action_bar/widgets/card_button.dart';

class FloatingActionBar extends StatelessWidget {
  // Visibility.
  final bool visible;

  // Button.
  final IconData? buttonIcon;
  final String buttonLabel;
  final bool disableButton;
  final Function() onLongPressed;
  final Function() onPressed;

  // Leading IconButton.
  final IconData? leadingIconButtonIcon;
  final Color? leadingIconButtonColor;
  final Function()? onLeadingIconButtonPressed;

  // First Trailing IconButton.
  final IconData? firstTrailingIconButtonIcon;
  final Color? firstTrailingIconButtonColor;
  final Function()? onFirstTrailingIconButtonPressed;

  // Trailing IconButton.
  final IconData? secondTrailingIconButtonIcon;
  final Color? secondTrailingIconButtonColor;
  final Function()? onSecondTrailingIconButtonPressed;

  // Loading.
  final bool showLoadingSpinner;
  final String loadingMessage;

  const FloatingActionBar({
    super.key,
    this.visible = true,
    this.buttonIcon,
    this.disableButton = false,
    required this.buttonLabel,
    required this.onPressed,
    required this.onLongPressed,
    this.leadingIconButtonIcon,
    this.leadingIconButtonColor,
    this.onLeadingIconButtonPressed,
    this.showLoadingSpinner = false,
    this.loadingMessage = '',
    this.firstTrailingIconButtonIcon,
    this.firstTrailingIconButtonColor,
    this.onFirstTrailingIconButtonPressed,
    this.secondTrailingIconButtonIcon,
    this.secondTrailingIconButtonColor,
    this.onSecondTrailingIconButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final double deviceWidth = MediaQuery.of(context).size.width;
    const double minHeightItems = 50.0;
    const double minWidth = 120.0;

    return Visibility(
      visible: visible,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: minHeightItems,
          minWidth: minWidth,
        ),
        child: showLoadingSpinner
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: minHeightItems,
                    minWidth: minWidth,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomLoadingSpinner(
                          loadingMessage: loadingMessage,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: deviceWidth * 0.9,
                child: Stack(
                  children: [
                    if (leadingIconButtonIcon != null)
                      CardButton(
                        alignment: Alignment.centerLeft,
                        minSize: minHeightItems,
                        icon: leadingIconButtonIcon!,
                        iconSize: 20.0,
                        iconColor: leadingIconButtonColor,
                        onPressed: onLeadingIconButtonPressed,
                      ),
                    if (disableButton == false && showLoadingSpinner == false)
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: minHeightItems,
                            minWidth: 120.0,
                            maxWidth: 155.0,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              onLongPress: showLoadingSpinner || disableButton ? () {} : () => onLongPressed(),
                              onTap: showLoadingSpinner || disableButton ? () {} : () => onPressed(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (buttonIcon != null)
                                        Container(
                                          margin: const EdgeInsets.only(right: 10.0),
                                          child: Icon(
                                            buttonIcon,
                                            color: Theme.of(context).colorScheme.secondary,
                                            size: 15.0,
                                          ),
                                        ),
                                      Text(
                                        buttonLabel,
                                        style: Theme.of(context).textTheme.headlineSmall,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (firstTrailingIconButtonIcon != null || secondTrailingIconButtonIcon != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (firstTrailingIconButtonIcon != null)
                                CardButton(
                                  alignment: Alignment.centerLeft,
                                  minSize: minHeightItems,
                                  icon: firstTrailingIconButtonIcon!,
                                  iconSize: 20.0,
                                  iconColor: firstTrailingIconButtonColor,
                                  onPressed: onFirstTrailingIconButtonPressed,
                                ),
                              if (secondTrailingIconButtonIcon != null)
                                CardButton(
                                  alignment: Alignment.centerRight,
                                  minSize: minHeightItems,
                                  icon: secondTrailingIconButtonIcon!,
                                  iconSize: 20.0,
                                  iconColor: secondTrailingIconButtonColor,
                                  onPressed: onSecondTrailingIconButtonPressed,
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
