import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

class CardModelEntryPreview extends StatelessWidget {
  // Data
  final String title;
  final String subtitle;
  final bool isProtected;

  // Card.
  final Function() onTap;

  const CardModelEntryPreview({
    super.key,
    // Data.
    required this.title,
    required this.subtitle,
    this.isProtected = false,
    // Card.
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pink,
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0), // Border thickness.
            child: Container(
              padding: const EdgeInsets.all(8.0), // Internal padding for content.
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    // * Title.
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    // * Subtitle.
                    if (subtitle.isNotEmpty && isProtected == false)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          subtitle,
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (isProtected)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Icon(
                          AppIcons.lock,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
