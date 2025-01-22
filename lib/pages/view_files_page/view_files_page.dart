import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/files/files.dart';
import '/data/models/entries/entry.dart';
import '/data/models/files/file_item.dart';
import '/data/models/groups/group.dart';

// Widgets.

import '/widgets/customs/custom_base_page.dart';
import '/pages/view_files_page/widgets/file_view.dart';
import 'widgets/image_view.dart';

// Cubits.
import 'cubit/view_files_page_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';
import '/logic/cubit/local_storage_cubit.dart';

/// Arguments that [ViewFilesPage] can recieve.
class ViewFilesPageArguments {
  final Files files;
  final int initialPage;
  final bool isFiles;
  final Group fromGroup;
  final Entry fromEntry;

  const ViewFilesPageArguments({
    required this.files,
    required this.initialPage,
    required this.isFiles,
    required this.fromGroup,
    required this.fromEntry,
  });
}

class ViewFilesPage extends StatefulWidget {
  final ViewFilesPageArguments arguments;

  const ViewFilesPage({
    super.key,
    required this.arguments,
  });

  /// The route name for navigation purposes.
  /// ```dart
  /// static const String routeName = '/view-images-page';
  /// ```
  static const String routeName = '/view-images-page';

  /// Initial Screen route.
  static Route route({required ViewFilesPageArguments arguments}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ViewFilesPageCubit>(
        create: (_) => ViewFilesPageCubit(
          localStorageCubit: context.read<LocalStorageCubit>(),
          appMessagesCubit: context.read<AppMessagesCubit>(),
          arguments: arguments, // * Needs to be supplied here not in initialize().
        ),
        child: ViewFilesPage(
          arguments: arguments,
        ),
      ),
    );
  }

  @override
  State<ViewFilesPage> createState() => _ViewFilesPageState();
}

class _ViewFilesPageState extends State<ViewFilesPage> {
  // Init page controller.
  late PageController pageController;
  late TransformationController transformationController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.arguments.initialPage);
    transformationController = TransformationController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewFilesPageCubit, ViewFilesPageState>(
      listener: (context, state) async {
        // * A close sheet state was triggerd.
        if (state.status == ViewFilesPageStatus.close) Navigator.of(context).pop();

        // * A close sheet state was triggerd.
        if (state.status == ViewFilesPageStatus.shareFile) context.read<ViewFilesPageCubit>().shareFile(fileItem: state.currentFileItem);
      },
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ViewFilesPageStatus.close && current.status == ViewFilesPageStatus.close) return false;

        return true;
      },
      builder: (context, state) {
        // State variables.
        final bool pageHasError = state.status == ViewFilesPageStatus.pageHasError;
        final bool pageIsLoading = state.status == ViewFilesPageStatus.pageIsLoading;
        final bool loading = state.status == ViewFilesPageStatus.loading;

        return Container(
          // This is needed because otherwise if user swipes outside of page view a different color is shown.
          color: Theme.of(context).colorScheme.surface,
          child: InteractiveViewer(
            // * Ensure that if files are displayed, zoom is disabled.
            scaleEnabled: state.isFiles == false,
            panEnabled: state.isFiles == false,
            transformationController: transformationController,
            onInteractionStart: (details) => context.read<ViewFilesPageCubit>().onZoomStart(),
            onInteractionEnd: (details) => context.read<ViewFilesPageCubit>().onZoomEnd(controller: transformationController),
            minScale: 1.0,
            maxScale: 12.0,
            child: PageView.builder(
              controller: pageController,
              physics: state.pageViewPhysics,
              allowImplicitScrolling: true,
              onPageChanged: (final int pageIndex) => context.read<ViewFilesPageCubit>().onPageChanged(index: pageIndex),
              itemCount: state.files.items.length,
              itemBuilder: (context, itemIndex) {
                // Access file item.
                final FileItem fileItem = state.files.items[itemIndex];

                return CustomBasePage(
                  // Page view.
                  isPageView: true,
                  // Modal Sheet.
                  isModalSheet: false,
                  // Page loading.
                  pageIsLoading: pageIsLoading,
                  // Page Failure.
                  pageHasError: pageHasError,
                  pageFailure: state.pageFailure,
                  pageErrorButtonLabel: labels.basicLabelsClose(),
                  onPageErrorButtonPressed: () => context.read<ViewFilesPageCubit>().closePage(),
                  // Common Failure.
                  failure: state.failure,
                  onDismissFailure: () => context.read<ViewFilesPageCubit>().dismissFailure(),
                  // Close while page loading.
                  onCloseWhilePageLoadingButtonPressed: () => context.read<ViewFilesPageCubit>().closePage(),
                  // Leading Icon Button.
                  leadingIconButtonIcon: AppIcons.back,
                  onLeadingIconButtonPressed: () => context.read<ViewFilesPageCubit>().closePage(),
                  // First Trailing Icon Button.
                  firstTrailingIconButtonIcon: AppIcons.moreOptions,
                  onFirstTrailingIconButtonPressed: () => context.read<ViewFilesPageCubit>().onMenuPressed(context: context),
                  // Floating Action Bar.
                  actionBarIsLoading: loading,
                  loadingMessage: state.loadingMessage,
                  floatingActionBarDisabled: true,
                  edgeInsetsContent: const EdgeInsets.all(0.0),
                  onBasePageTap: () => context.read<ViewFilesPageCubit>().onTap(),
                  onBasePageDoubleTap: (final TapDownDetails details) => context.read<ViewFilesPageCubit>().onDoubleTap(
                        context: context,
                        details: details,
                        transformationController: transformationController,
                      ),
                  onBasePageSwipedDown: (final DragStartDetails startDetails, final DragUpdateDetails updateDetails) => context.read<ViewFilesPageCubit>().onBasePageSwipedDown(
                        startDetails: startDetails,
                        updateDetails: updateDetails,
                        transformationController: transformationController,
                      ),
                  // Scrollable.
                  isScrollable: state.isFiles,
                  // Content.
                  content: [
                    Builder(
                      builder: (context) {
                        // Show a different view for files.
                        if (state.isFiles) {
                          return FileView(
                            overlayVisible: state.overlayVisible,
                            fileItem: fileItem,
                          );
                        }

                        // Show image view.
                        return ImageView(
                          shouldReload: false,
                          overlayVisible: state.overlayVisible,
                          fileItemFuture: () => context.read<ViewFilesPageCubit>().loadFileItem(fileItem: fileItem),
                          fileItem: fileItem,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
