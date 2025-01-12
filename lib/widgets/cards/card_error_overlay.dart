import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/failure.dart';

class CardErrorOverlay extends StatelessWidget {
  final Failure failure;
  final Function() onDismissFailure;

  const CardErrorOverlay({
    super.key,
    required this.failure,
    required this.onDismissFailure,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: failure != Failure.initial(),
      child: GestureDetector(
        onTap: onDismissFailure,
        child: Card(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: Container(
            constraints: const BoxConstraints(minHeight: 55.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                      child: Text(
                        failure.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Icon(
                      AppIcons.clear,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      size: Theme.of(context).iconTheme.size,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
