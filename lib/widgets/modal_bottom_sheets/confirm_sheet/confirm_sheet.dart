import 'dart:io' show Platform;

import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

class ConfirmSheet extends StatelessWidget {
  final String title;
  final String subtitle;

  /// This sheet returns ```true``` if user confirmed otherwise ```null```.
  const ConfirmSheet({
    super.key,
    required this.title,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    onTap: () => Navigator.of(context).pop(null),
                    child: Container(
                      height: 45.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          labels.confirmSheetDismissButtonLabel(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    onTap: () => Navigator.of(context).pop(true),
                    child: Container(
                      height: 45.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          labels.confirmSheetConfirmButtonLabel(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (Platform.isIOS) const SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
