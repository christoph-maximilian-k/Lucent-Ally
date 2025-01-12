import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

class CustomDropDownButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  final bool isOutlined;

  final double? maxWidth;
  final double? minWidth;

  final double? fontSize;
  final Color? labelColor;

  final String? subLabel;

  const CustomDropDownButton({
    super.key,
    required this.label,
    required this.onTap,
    this.maxWidth,
    this.minWidth,
    this.fontSize = 12,
    this.isOutlined = false,
    this.labelColor,
    this.subLabel,
  });

  @override
  Widget build(BuildContext context) {
    // Access size of screen.
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: 35.0,
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: isOutlined
            ? Border.all(
                color: Theme.of(context).colorScheme.onSurface,
                width: 0.8,
              )
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 15.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth ?? width * 0.75,
                    minWidth: minWidth ?? 0.0,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: labelColor ?? Colors.blueGrey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (subLabel != null)
                  Text(
                    subLabel!,
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Theme.of(context).textTheme.labelSmall!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
            const SizedBox(width: 5.0),
            Icon(
              AppIcons.arrowDown,
              color: labelColor ?? Colors.blueGrey,
            ),
            const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
