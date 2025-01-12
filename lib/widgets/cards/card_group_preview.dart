import 'package:flutter/material.dart';

// Models.
import '/data/models/groups/group.dart';

class CardGroupPreview extends StatelessWidget {
  final Group group;

  final String subtitle;

  final Function(Group) onTap;

  const CardGroupPreview({
    super.key,
    required this.group,
    this.subtitle = '',
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
                Colors.lightBlue,
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
              padding: const EdgeInsets.all(4.0), // Internal padding for content.
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: InkWell(
                onTap: () => onTap(group),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // * Title.
                    Text(
                      group.groupName,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // * Subtitle.
                    if (subtitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.center,
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
