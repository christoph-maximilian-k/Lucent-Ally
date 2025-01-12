import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/tags/tag.dart';
import '/data/models/tags/tags.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_loading_spinner.dart';

class CardDisplayTags extends StatefulWidget {
  // Indications.
  final IconData? icon;
  final String? title;
  final bool showIndications;
  final bool showCard;

  // OnTabTag.
  final Function(Tag)? onTabTag;

  // On tag deleted.
  final Function(Tag, int)? onDeleted;

  // Tags future.
  final Function() getTagsFuture;

  // Tags.
  final TagsData tagsData;

  const CardDisplayTags({
    super.key,
    // Indications.
    this.showIndications = true,
    this.icon,
    this.title,
    this.showCard = true,
    // Tags Future.
    required this.getTagsFuture,
    // OnTabTag.
    this.onTabTag,
    // On Tag deleted.
    this.onDeleted,
    // Tags.
    required this.tagsData,
  });

  @override
  State<CardDisplayTags> createState() => _CardDisplayTagsState();
}

class _CardDisplayTagsState extends State<CardDisplayTags> {
  late Future<Tags?> _tagsFuture;

  /// This function can be used to retrigger getting tags.
  void _retriggerGetTags() {
    // Update the future and trigger a rebuild.
    setState(() {
      _tagsFuture = widget.getTagsFuture();
    });
  }

  @override
  void initState() {
    super.initState();
    _tagsFuture = widget.getTagsFuture();
  }

  @override
  void didUpdateWidget(covariant CardDisplayTags oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool tagsChanged = widget.tagsData.tagReferences != oldWidget.tagsData.tagReferences;

    // Get Tags again.
    if (tagsChanged) {
      _tagsFuture = widget.getTagsFuture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.showCard ? null : 0.0,
      color: widget.showCard ? null : Colors.transparent,
      child: Column(
        children: [
          if (widget.showIndications)
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                widget.icon,
                color: Theme.of(context).primaryIconTheme.color,
                size: Theme.of(context).primaryIconTheme.size,
              ),
              title: Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          FutureBuilder<Tags?>(
            future: _tagsFuture,
            builder: (context, snapshot) {
              // Show loading indication.
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 75.0,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: const CustomLoadingSpinner(),
                );
              }

              // Convenience variables.
              final Tags? tags = snapshot.data;

              // Show failure.
              // * Also show failure on initial. This should not occur, but better save then sorry.
              final bool failure = tags == null;

              // Show failure.
              if (failure) {
                return Container(
                  height: 75.0,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        labels.failedToAccessTags(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      CustomElevatedButton(
                        margin: const EdgeInsets.all(10.0),
                        label: labels.basicLabelsTryAgain(),
                        onPressed: () => _retriggerGetTags(),
                      ),
                    ],
                  ),
                );
              }

              // * It can be that tags are empty even though tag references have ids set.
              // * This happens if a tags was deleted but the tag id is still there.
              if (tags.items.isEmpty) {
                // Output debug message.
                debugPrint('CardDisplayTags --> TagsFuture --> Tag references exist but no Tags were initialized (Tags.isEmpty). Display SizedBox.shrink().');
                return SizedBox.shrink();
              }

              // * Display tags.
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: List.generate(
                        tags.items.length,
                        (index) {
                          final Tag tag = tags.items[index];

                          return GestureDetector(
                            onTap: widget.onTabTag == null ? null : () => widget.onTabTag!(tag),
                            child: Chip(
                              key: UniqueKey(),
                              onDeleted: widget.onDeleted == null ? null : () => widget.onDeleted!(tag, index),
                              label: Text(
                                tag.label,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
