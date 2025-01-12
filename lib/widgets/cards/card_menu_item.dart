import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

class CardMenuItem extends StatelessWidget {
  final EdgeInsets? padding;
  final Function() onTap;
  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final TextStyle? textStyle;
  final String? infoMessage;

  final bool hideTrailingIcon;

  const CardMenuItem({
    super.key,
    this.padding,
    required this.onTap,
    required this.title,
    required this.leadingIcon,
    this.textStyle,
    this.trailingIcon = AppIcons.forward,
    this.infoMessage,
    this.hideTrailingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        children: [
          Card(
            child: ListTile(
              dense: true,
              onTap: onTap,
              leading: Icon(
                leadingIcon,
                color: Theme.of(context).primaryIconTheme.color,
                size: Theme.of(context).primaryIconTheme.size,
              ),
              title: Text(
                title,
                style: textStyle ?? Theme.of(context).textTheme.labelSmall,
              ),
              trailing: hideTrailingIcon ? null :Icon(
                trailingIcon,
                color: Theme.of(context).iconTheme.color,
                size: Theme.of(context).iconTheme.size,
              ),
            ),
          ),
          if (infoMessage != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                infoMessage!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
        ],
      ),
    );
  }
}
