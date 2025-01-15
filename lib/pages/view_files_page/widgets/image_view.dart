import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';

// Models.
import '/data/models/files/file_item.dart';

class ImageView extends StatefulWidget {
  final FileItem fileItem;
  final bool overlayVisible;
  final Function() fileItemFuture;
  final bool shouldReload;
  final TransformationController transformationController;

  const ImageView({
    super.key,
    required this.overlayVisible,
    required this.fileItem,
    required this.fileItemFuture,
    required this.shouldReload,
    required this.transformationController,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
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
  void didUpdateWidget(covariant ImageView oldWidget) {
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
    // Access height.
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: height,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxHeight: height * 0.75),
                  child: FutureBuilder(
                    future: _fileItemFuture,
                    builder: (context, snapshot) {
                      // Show loading spinner.
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomLoadingSpinner();
                      }

                      // Convenience variables.
                      final FileItem? fileItem = snapshot.data;

                      // Show failure.
                      final bool hasFailure = fileItem == null || fileItem.bytes == null;

                      if (fileItem == null || hasFailure) {
                        return IconButton(
                          onPressed: () => _retriggerFileItemFuture(),
                          icon: Icon(
                            AppIcons.refresh,
                            color: Theme.of(context).iconTheme.color,
                            size: 30.0,
                          ),
                        );
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: InteractiveViewer(
                          transformationController: widget.transformationController,
                          panEnabled: true,
                          minScale: 1.0,
                          maxScale: 12.0,
                          child: Image.memory(
                            fileItem.bytes!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.overlayVisible && widget.fileItem.title.isNotEmpty,
              child: Positioned(
                top: 60.0,
                child: Container(
                  width: width,
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.75),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SelectableText(
                      widget.fileItem.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.overlayVisible && widget.fileItem.caption.isNotEmpty,
              child: Positioned(
                bottom: 0.0, // * Position on the bottom without any padding.
                child: Container(
                  height: height * 0.45,
                  width: width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 100.0),
                      child: SelectableText(
                        widget.fileItem.caption.isEmpty ? labels.basicLabelsNoCaption() : widget.fileItem.caption,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
