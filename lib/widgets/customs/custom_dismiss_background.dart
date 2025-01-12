import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

class CustomDismissBackground extends StatelessWidget {
  final double? paddingTop;

  const CustomDismissBackground({
    super.key,
    this.paddingTop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.error,
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: paddingTop ?? 0.0),
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 25.0),
        child: Icon(
          AppIcons.delete,
          color: Theme.of(context).colorScheme.onError,
          size: Theme.of(context).primaryIconTheme.size,
        ),
      ),
    );
  }
}
