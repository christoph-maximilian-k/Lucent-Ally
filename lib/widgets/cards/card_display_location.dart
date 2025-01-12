import 'package:flutter/material.dart';

// User with Settings and labels.
import '/main.dart';

// Models.
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/tags/tag.dart';

// Widgets.
import '/widgets/cards/card_display_tags.dart';

// Config.
import '/config/app_icons.dart';

class CardDisplayLocation extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;

  // Data.
  final LocationData locationData;

  // Trailing.
  final Function()? onMorePressed;

  // Latitude line.
  final String latitudeLabel;
  final String latitude;

  // Latitude Icon.
  final IconData? latitudeIcon;
  final Function()? onLatitudeIconPressed;

  // Longitude line.
  final String longitudeLabel;
  final String longitude;

  // Longitude Icon.
  final IconData? longitudeIcon;
  final Function()? onLongitudeIconPressed;

  // Tags.
  final Function() getTagsFuture;
  final Function(Tag) onTabTag;

  // Info Message.
  final String? infoMessage;

  const CardDisplayLocation({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    // Trailing.
    this.onMorePressed,
    required this.locationData,
    // Latitude line.
    required this.latitudeLabel,
    required this.latitude,
    // Latitude Icon.
    this.latitudeIcon,
    this.onLatitudeIconPressed,

    // Latitude line.
    required this.longitudeLabel,
    required this.longitude,
    // Latitude Icon.
    this.longitudeIcon,
    this.onLongitudeIconPressed,
    // Tags.
    required this.getTagsFuture,
    required this.onTabTag,
    // InfoMessage.
    this.infoMessage,
  });

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final bool showTags = locationData.tagsData.tagReferences.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
              dense: true,
              horizontalTitleGap: 0.0,
              leading: Icon(
                icon,
                color: Theme.of(context).primaryIconTheme.color,
                size: Theme.of(context).primaryIconTheme.size,
              ),
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: onMorePressed != null
                  ? IconButton(
                      icon: Icon(
                        AppIcons.moreOptions,
                        color: Theme.of(context).iconTheme.color,
                        size: Theme.of(context).primaryIconTheme.size,
                      ),
                      onPressed: onMorePressed,
                    )
                  : null,
            ),
            // * Latitude line.
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      latitudeLabel,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      latitude,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  if (latitudeIcon != null)
                    IconButton(
                      icon: Icon(
                        latitudeIcon,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: Theme.of(context).primaryIconTheme.size,
                      ),
                      onPressed: onLatitudeIconPressed,
                    ),
                ],
              ),
            ),
            // * Longitude line.
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 15.0, bottom: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      longitudeLabel,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      longitude,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  if (latitudeIcon != null)
                    IconButton(
                      icon: Icon(
                        longitudeIcon,
                        color: Theme.of(context).primaryIconTheme.color,
                        size: Theme.of(context).primaryIconTheme.size,
                      ),
                      onPressed: onLongitudeIconPressed,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              labels.basicLabelsDate(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20.0),
            Text(
              locationData.createdAtInUtc == null
                  ? ''
                  : labels.basicLabelsDateTimeAndTimezone(
                      date: locationData.getCreatedAt(preserveUtc: true, date: true, time: true),
                      timezone: locationData.getCreatedAtTimezone(preserveUtc: true),
                    ),
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            // * Tags.
            if (showTags)
              Column(
                children: [
                  Center(
                    child: Text(
                      labels.basicLabelsTags(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  CardDisplayTags(
                    icon: icon,
                    title: title,
                    showCard: false,
                    showIndications: false,
                    tagsData: locationData.tagsData,
                    getTagsFuture: getTagsFuture,
                    onTabTag: (final Tag tag) => onTabTag(tag),
                  ),
                ],
              ),
            if (infoMessage != null)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  infoMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
