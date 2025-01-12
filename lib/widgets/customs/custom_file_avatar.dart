import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/files/file_item.dart';

class CustomFileAvatar extends StatelessWidget {
  // FileItem.
  final FileItem fileItem;

  // Remove file function.
  final Function()? onRemoveFile;

  // On file Tab.
  final Function(FileItem)? onFileTap;

  // On long press image.
  final Function(FileItem)? onLongPressFile;

  // File Details
  final bool showFileDetailsIndications;
  const CustomFileAvatar({
    super.key,
    required this.fileItem,
    this.onRemoveFile,
    this.onFileTap,
    this.onLongPressFile,
    this.showFileDetailsIndications = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (onRemoveFile != null)
          IconButton(
            icon: Icon(
              AppIcons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
            onPressed: onRemoveFile,
          ),
        GestureDetector(
          onTap: onFileTap == null ? () {} : () => onFileTap!(fileItem),
          onLongPress: onLongPressFile == null ? () {} : () => onLongPressFile!(fileItem),
          child: SizedBox(
            height: 120.0,
            width: 120.0,
            child: Card(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Builder(
                  builder: (context) {
                    // * Is in file mode.
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AppIcons.file,
                            size: 50.0,
                            color: Colors.black,
                          ),
                          const SizedBox(height: 5.0),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    fileItem.title.isEmpty ? fileItem.type : '${fileItem.type} ⋅',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    fileItem.title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        if (showFileDetailsIndications)
          Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (fileItem.title.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      AppIcons.names,
                      color: Theme.of(context).iconTheme.color,
                      size: Theme.of(context).iconTheme.size,
                    ),
                  ),
                if (fileItem.caption.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      AppIcons.edit,
                      color: Theme.of(context).iconTheme.color,
                      size: Theme.of(context).iconTheme.size,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
