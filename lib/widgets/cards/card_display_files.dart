import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/files/files.dart';
import '/data/models/files/file_item.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/tags/tag.dart';

// Widgets.
import '/widgets/customs/custom_file_avatar.dart';
import '/widgets/cards/card_display_tags.dart';
import '/widgets/customs/custom_image_avatar.dart';

class CardDisplayFiles extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;

  final bool isImages;

  // Files.
  final Files files;

  // Loading.
  final String loadingMessage;

  // File Futures.
  final Function(FileItem, int) fileItemFuture;
  final Function(FileItem, int) onTapFile;
  final Function(FileItem, int) onLongPressFile;

  // Trailing.
  final Function()? onMorePressed;

  // Tags.
  final TagsData tagsData;
  final Function() getTagsFuture;
  final Function(Tag) onTabTag;

  // Info Message.
  final String infoMessage;

  const CardDisplayFiles({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    required this.isImages,
    // Loading.
    required this.loadingMessage,
    // File Futures.
    required this.fileItemFuture,
    required this.onTapFile,
    required this.onLongPressFile,
    // Files.
    required this.files,
    // Trailing.
    this.onMorePressed,
    // Tags.
    required this.tagsData,
    required this.getTagsFuture,
    required this.onTabTag,
    // Info Message.
    this.infoMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final bool showTags = tagsData.tagReferences.isNotEmpty;

    return Card(
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
          Container(
            height: 160.0,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: files.items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // Access File item.
                final FileItem fileItem = files.items[index];

                if (isImages) {
                  return CustomImageAvatar(
                    fileItemFuture: () => fileItemFuture(fileItem, index),
                    fileItem: fileItem,
                    onImageTap: (final FileItem fileItem) => onTapFile(fileItem, index),
                    onLongPressImage: (final FileItem fileItem) => onLongPressFile(fileItem, index),
                    loadingMessage: loadingMessage,
                  );
                }

                return CustomFileAvatar(
                  fileItem: fileItem,
                  onFileTap: (final FileItem fileItem) => onTapFile(fileItem, index),
                  onLongPressFile: (final FileItem fileItem) => onLongPressFile(fileItem, index),
                );
              },
            ),
          ),
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
                  tagsData: tagsData,
                  getTagsFuture: getTagsFuture,
                  onTabTag: (final Tag tag) => onTabTag(tag),
                ),
              ],
            ),
          // * Info Message.
          Visibility(
            visible: infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
