import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatelessWidget {
  final String title;
  final bool value;
  final EdgeInsets padding;

  final String? infoMessage;

  final Function(bool)? onChanged;

  const CustomSwitchListTile({
    super.key,
    required this.title,
    required this.value,
    required this.padding,
    this.infoMessage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                CupertinoSwitch(
                  value: value,
                  onChanged: onChanged,
                ),
              ],
            ),
            if (infoMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                child: Text(
                  infoMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
