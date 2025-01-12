import 'package:flutter/material.dart';

// Models.
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/files/file_item.dart';

// Widgets.
import '/widgets/customs/custom_image_avatar.dart';

// Widgets.

class CardDisplayAvatarImage extends StatelessWidget {
  // Indications.
  final String title;

  // Loading Message.
  final String loadingMessage;

  // File Future.
  final Function() fileItemFuture;

  // Image.
  final Function(FileItem, int)? onTabFile;
  final Function(FileItem, int)? onLongPressFile;

  // Data.
  final AvatarImageData avatarImageData;

  const CardDisplayAvatarImage({
    super.key,
    // Indications.
    required this.title,
    // Loading Message.
    required this.loadingMessage,
    // File Future.
    required this.fileItemFuture,
    // Image.
    this.onTabFile,
    this.onLongPressFile,
    // Data.
    required this.avatarImageData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImageAvatar(
          isCircular: true,
          loadingMessage: loadingMessage,
          fileItem: avatarImageData.image,
          onImageTap: (final FileItem fileItem) => onTabFile == null ? {} : onTabFile!(fileItem, 0),
          onLongPressImage: (final FileItem fileItem) => onLongPressFile == null ? {} : onLongPressFile!(fileItem, 0),
          fileItemFuture: fileItemFuture,
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
