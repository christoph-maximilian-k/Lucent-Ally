import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/files/file_item.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';

class CustomImageAvatar extends StatefulWidget {
  // Indications.
  final String loadingMessage;

  final bool shouldReload;

  // Dimensions.
  final bool isCircular;

  // FileItem.
  final FileItem? fileItem;

  // File Future.
  final Function() fileItemFuture;

  // Remove file function.
  final Function()? onRemoveImage;

  // On file Tab.
  final IconData fileIcon;
  final Function(FileItem)? onImageTap;

  // On long press image.
  final Function(FileItem)? onLongPressImage;

  // File Details
  final bool showImageDetailsIndications;

  const CustomImageAvatar({
    super.key,
    this.isCircular = false,
    this.shouldReload = true,
    // File Future.
    required this.fileItemFuture,
    this.loadingMessage = '',
    required this.fileItem,
    this.onRemoveImage,
    this.fileIcon = AppIcons.refresh,
    this.onImageTap,
    this.onLongPressImage,
    this.showImageDetailsIndications = false,
  });

  @override
  State<CustomImageAvatar> createState() => _CustomImageAvatarState();
}

class _CustomImageAvatarState extends State<CustomImageAvatar> {
  late Future<FileItem?> _fileItemFuture;

  /// This function can be used to retrigger getting exchange rates.
  void _retriggerFileItemFuture() {
    // Update the future and trigger a rebuild.
    setState(() {
      _fileItemFuture = widget.fileItemFuture();
    });
  }

  @override
  void initState() {
    super.initState();
    _fileItemFuture = widget.fileItemFuture();
  }

  @override
  void didUpdateWidget(covariant CustomImageAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Convenience variables.
    final bool fileChanged = widget.fileItem != oldWidget.fileItem;

    // Get exchange rate again.
    if (fileChanged && widget.shouldReload) {
      // Perform tasks when the data changes.
      _fileItemFuture = widget.fileItemFuture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FileItem?>(
      future: _fileItemFuture,
      builder: (context, snapshot) {
        // Avatar is loading.
        if (snapshot.connectionState == ConnectionState.waiting) {
          // * This column is needed otherwise the sizedbox constraints are not respected.
          return Column(
            children: [
              if (widget.onRemoveImage != null)
                IconButton(
                  icon: Icon(
                    AppIcons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: widget.onRemoveImage,
                ),
              SizedBox(
                height: widget.isCircular ? 160.0 : 120.0,
                width: widget.isCircular ? 160.0 : 120.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.isCircular ? 100.0 : 10.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.5,
                    ),
                  ),
                  child: CustomLoadingSpinner(
                    loadingMessage: widget.loadingMessage,
                  ),
                ),
              ),
            ],
          );
        }

        // Convenience variables.
        final FileItem? fileItem = snapshot.data;

        // Show failure.
        final bool hasFailure = fileItem == null || fileItem.bytes == null;

        // Avatar has failure.
        if (fileItem == null || hasFailure) {
          // * This column is needed otherwise the sizedbox constraints are not respected.
          return Column(
            children: [
              if (widget.onRemoveImage != null)
                IconButton(
                  icon: Icon(
                    AppIcons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: widget.onRemoveImage,
                ),
              SizedBox(
                height: widget.isCircular ? 160.0 : 120.0,
                width: widget.isCircular ? 160.0 : 120.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.isCircular ? 100.0 : 10.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.5,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _retriggerFileItemFuture(),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                    child: Icon(
                      widget.fileIcon,
                      color: Theme.of(context).iconTheme.color,
                      size: widget.isCircular ? 30.0 : 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Center(
          child: Column(
            children: [
              if (widget.onRemoveImage != null)
                IconButton(
                  icon: Icon(
                    AppIcons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: widget.onRemoveImage,
                ),
              GestureDetector(
                onTap: widget.onImageTap == null ? () {} : () => widget.onImageTap!(fileItem),
                onLongPress: widget.onLongPressImage == null ? () {} : () => widget.onLongPressImage!(fileItem),
                child: SizedBox(
                  height: widget.isCircular ? 160.0 : 120.0,
                  width: widget.isCircular ? 160.0 : 120.0,
                  child: Card(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.isCircular ? 100.0 : 10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(widget.isCircular ? 100.0 : 10.0),
                      child: Builder(
                        builder: (context) {
                          // No image available.
                          if (fileItem.bytes == null) return Image.asset('assets/images/placeholder.png', fit: BoxFit.fill);

                          // Display image.
                          return Image.memory(fileItem.bytes!, fit: BoxFit.fill);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.showImageDetailsIndications)
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
          ),
        );
      },
    );
  }
}
