import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final TextOverflow? overflow;

  final Function()? onPressed;
  final Function()? onLongPressed;

  final bool isOutlined;

  final EdgeInsets? margin;

  final IconData? icon;
  final Function()? onIconButtonPressed;

  const CustomTextButton({
    super.key,
    required this.label,
    this.overflow,
    required this.onPressed,
    this.onLongPressed,
    this.isOutlined = false,
    this.margin,
    this.icon,
    this.onIconButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.4,
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      decoration: isOutlined
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
                width: 0.8,
              ),
            )
          : null,
      height: 40.0,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          onLongPress: onLongPressed,
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            mainAxisAlignment: onIconButtonPressed != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: onIconButtonPressed != null ? const EdgeInsets.only(left: 15.0) : const EdgeInsets.all(4.0),
                  child: Text(
                    label,
                    overflow: overflow,
                    textAlign: onIconButtonPressed != null ? TextAlign.left : TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
              // * Icon Button.
              if (onIconButtonPressed != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: onIconButtonPressed!,
                    icon: Icon(
                      icon!,
                      color: Theme.of(context).colorScheme.error,
                      size: 20.0,
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
