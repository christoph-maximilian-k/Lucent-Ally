import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

class CustomTitleBar extends StatelessWidget {
  final String title;
  final Function()? onMoreOptionsPressed;

  const CustomTitleBar({
    super.key,
    required this.title,
    this.onMoreOptionsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          if (onMoreOptionsPressed != null)
            IconButton(
              icon: Icon(
                AppIcons.moreOptions,
                color: Theme.of(context).iconTheme.color,
                size: Theme.of(context).primaryIconTheme.size,
              ),
              onPressed: onMoreOptionsPressed,
            )
        ],
      ),
    );
  }
}
