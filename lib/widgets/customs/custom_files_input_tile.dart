import 'package:flutter/material.dart';

// User with settings and labels.
import '/main.dart';

// Models.
import '/data/models/files/files.dart';
import '/data/models/files/file_item.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/tags/tag.dart';

// Widgets.
import 'custom_file_avatar.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_horizontal_divider.dart';
import '/widgets/customs/custom_tags_input_tile.dart';
import '/widgets/customs/custom_image_avatar.dart';

class CustomFilesInputTile extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;
  final String topInfoMessage;
  final bool requiredField;
  final bool isImages;
  final bool isFiles;
  final bool isAvatarImage;

  // State.
  final bool isDefault;
  final String isDefaultInfoMessage;

  // Trailing Icon.
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function()? onTrailingIconPressed;

  // Files.
  final Files files;
  final Function(FileItem, int) onFileTap;
  final Function(FileItem, int) fileItemFuture;
  final bool showFileDetailsIndications;

  // Tags.
  final TagsData? tagsData;
  final Function()? getTagsFuture;
  final Function(Tag, int)? onTagRemoved;
  final Function(String, TextEditingController)? onTagChanged;
  final Function(String, TextEditingController)? onTagSubmitted;
  final List<String>? tagsSuggestions;
  final Function(TextEditingController, String, int)? onSuggestionTap;

  // Info Message.
  final String infoMessage;

  // No file available message.
  final String noFileAvailableMessage;

  // Button.
  final String buttonLabel;
  final Function() onButtonPressed;

  const CustomFilesInputTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    this.topInfoMessage = '',
    this.requiredField = false,
    required this.isImages,
    required this.isFiles,
    required this.isAvatarImage,
    // State.
    required this.isDefault,
    required this.isDefaultInfoMessage,
    // Trailing Icon.
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    this.onTrailingIconPressed,
    // Files.
    required this.files,
    required this.onFileTap,
    required this.fileItemFuture,
    required this.showFileDetailsIndications,
    // Tags.
    this.tagsData,
    this.getTagsFuture,
    this.onTagRemoved,
    this.onTagChanged,
    this.onTagSubmitted,
    this.tagsSuggestions,
    this.onSuggestionTap,
    // Info Message.
    this.infoMessage = '',
    // Button.
    required this.buttonLabel,
    required this.onButtonPressed,
    // No file available message.
    required this.noFileAvailableMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
            horizontalTitleGap: 5.0,
            leading: Icon(
              icon,
              color: Theme.of(context).primaryIconTheme.color,
              size: Theme.of(context).primaryIconTheme.size,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: trailingIcon != null
                ? IconButton(
                    icon: Icon(
                      trailingIcon,
                      color: trailingIconColor,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    onPressed: onTrailingIconPressed,
                    tooltip: trailingIconTooltip,
                  )
                : null,
          ),
          if (requiredField)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
                child: Text(
                  labels.basicLabelsAValueIsRequired(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          if (isDefault)
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0, top: 10.0),
              child: Text(
                isDefaultInfoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          if (isDefault == false)
            Column(
              children: [
                Visibility(
                  visible: topInfoMessage.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0, top: 10.0),
                    child: Text(
                      topInfoMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    // No files available.
                    if (files.items.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          noFileAvailableMessage,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      );
                    }

                    // Multiple files are available.
                    return Container(
                      height: 160.0,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: files.items.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // Access File item.
                          final FileItem fileItem = files.items[index];

                          if (isImages || isAvatarImage) {
                            return CustomImageAvatar(
                              fileItemFuture: () => fileItemFuture(fileItem, index),
                              fileItem: fileItem,
                              onImageTap: (final FileItem fileItem) => onFileTap(fileItem, index),
                              showImageDetailsIndications: showFileDetailsIndications,
                            );
                          }

                          return CustomFileAvatar(
                            fileItem: fileItem,
                            onFileTap: (final FileItem fileItem) => onFileTap(fileItem, index),
                            showFileDetailsIndications: showFileDetailsIndications,
                          );
                        },
                      ),
                    );
                  },
                ),
                CustomDropDownButton(
                  label: buttonLabel,
                  onTap: onButtonPressed,
                ),
                const SizedBox(height: 15.0),
                // * Show tags.
                if (tagsData != null && files.getFirstItemHasBytes)
                  Column(
                    children: [
                      const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 10.0, marginBottom: 20.0),
                      Text(
                        labels.basicLabelsTags(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomTagsInputTile(
                          hideIndications: true,
                          hideCard: true,
                          tagsData: tagsData!,
                          tagsSuggestions: tagsSuggestions!,
                          onTagChanged: (value, controller) => onTagChanged!(value, controller),
                          onTagSubmitted: (value, controller) => onTagSubmitted!(value, controller),
                          onSuggestionTap: (controller, value, index) => onSuggestionTap!(controller, value, index),
                          onTagRemoved: (tag, index) => onTagRemoved!(tag, index),
                          getTagsFuture: getTagsFuture,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                Visibility(
                  visible: infoMessage.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Text(
                      infoMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
