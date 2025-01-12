import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final double minSize;
  final Alignment alignment;

  final Color? borderColor;

  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final Function()? onPressed;

  const CardButton({
    super.key,
    required this.minSize,
    required this.alignment,
    this.borderColor,
    required this.icon,
    required this.iconSize,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minSize,
          minWidth: minSize,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(100.0),
            ),
            side: BorderSide(
              color: borderColor ?? Theme.of(context).colorScheme.surface,
            ),
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(100.0),
            ),
            onTap: onPressed,
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
