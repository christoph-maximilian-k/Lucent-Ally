import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/files/file_item.dart';

// Widgets.
import '/widgets/customs/custom_file_avatar.dart';

class FileView extends StatelessWidget {
  final FileItem fileItem;
  final bool overlayVisible;

  const FileView({
    super.key,
    required this.overlayVisible,
    required this.fileItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SelectableText(
            fileItem.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomFileAvatar(
            fileItem: fileItem,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
          child: SelectableText(
            fileItem.caption.isEmpty ? labels.basicLabelsNoCaption() : fileItem.caption,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
