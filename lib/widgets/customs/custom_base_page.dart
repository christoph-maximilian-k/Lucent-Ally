import 'dart:io' show Platform;

import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/failure.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/cards/card_error_overlay.dart';
import '/widgets/cards/card_error.dart';
import '/widgets/cards/card_menu_item.dart';
import '/widgets/floating_action_bar/floating_action_bar.dart';
import '/widgets/floating_action_bar/widgets/card_button.dart';

class CustomBasePage extends StatefulWidget {
  // ####################################
  //                State
  // ####################################

  final bool isPageView;

  /// This can be used to controle the height of the complete widget.
  final double? height;

  /// Disables swipe to close and android back button if set to ```false```.
  final bool canPop;

  /// This function is triggered if user taps anywhere on the base page.
  final Function()? onBasePageTap;

  /// This function is triggered if user double taps anywhere on the base page.
  final Function()? onBasePageDoubleTap;

  /// This method is triggerd if user swipes to close or uses the android back button.
  final Function()? onHorizontalPopRoute;

  final bool isModalSheet;

  /// If this is set to ```false``` CustomBasePage will not scroll which means it can be dismissed by strokeing down as expected in a ModalSheet.
  final bool isScrollable;

  /// Use this to prevent FloatingActionBar or CardErrorOverlay from covering UI elements.
  final double bottomIndent;

  final bool pageIsLoading;
  final String pageIsLoadingMessage;
  final bool showPageLoadingButton;
  final String? onPageLoadingButtonLabel;
  final Function()? onPageLoadingButtonPressed;

  final bool pageHasError;
  final Failure pageFailure;
  final String pageErrorButtonLabel;
  final Function() onPageErrorButtonPressed;

  final FocusScopeNode? focusScopeNode;

  // ####################################
  // Error Overlay
  // ####################################

  final Failure failure;
  final Function() onDismissFailure;

  // ####################################
  // Corner Close Button
  // ####################################

  final Function()? onCornerClosePressed;

  // ####################################
  // Close while loading button
  // ####################################

  final IconData? closeWhilePageLoadingButtonIcon;
  final Color? closeWhilePageLoadingButtonColor;
  final Function()? onCloseWhilePageLoadingButtonPressed;

  // ####################################
  //               App Bar
  // ####################################

  final Widget? appBarWidget;
  final Color? appBarColor;
  final Function()? onAppBarMorePressed;
  final EdgeInsets? appBarMorePadding;

  // ####################################
  //               Refresh
  // ####################################

  final bool isRefreshable;
  final Future<void> Function()? onRefresh;

  // ####################################
  //              Grid View
  // ####################################

  final bool gridViewVisible;

  final String? gridViewTitle;
  final IconData? gridViewIcon;
  final bool displayGridViewTitleAsColumn;

  final bool? gridViewHasFailure;
  final Failure? gridViewFailure;
  final String? gridViewFailureButtonLabel;
  final Function()? onGridViewFailurePressed;

  /// This controles the height of GridViewBuilder and the height of the GridView items.
  final double gridViewBuilderHeight;

  final EdgeInsets edgeInsetsGrid;

  final int? gridViewCount;
  final Function(BuildContext, int)? gridViewBuilder;

  final bool gridViewActionVisible;
  final String? gridViewActionLabel;
  final IconData? gridViewActionIcon;
  final Function()? onGridViewActionPressed;

  // ####################################
  //              Content
  // ####################################

  final double? contentHeight;
  final EdgeInsets edgeInsetsContent;
  final List<Widget> content;
  final double loadMoreDataThreshold;
  final Function()? onLoadMoreContent;
  final bool moreContentIsLoading;

  // ####################################
  //         Floating Action Bar
  // ####################################

  /// The main ```FloatingActionBar``` button will be hidden if this is set to ```true```.
  final bool floatingActionBarDisabled;

  final bool actionBarIsLoading;
  final String loadingMessage;

  // Leading icon button.
  final Color? leadingIconButtonColor;
  final IconData? leadingIconButtonIcon;
  final Function()? onLeadingIconButtonPressed;

  // Floating action button
  final String? floatingActionBarLabel;
  final IconData? floatingActionBarIcon;
  final Function()? onLongPressFloatingActionBar;
  final Function()? onFloatingActionBarPressed;

  // First trailing icon button.
  final Color? firstTrailingIconButtonColor;
  final IconData? firstTrailingIconButtonIcon;
  final Function()? onFirstTrailingIconButtonPressed;

  // First trailing icon button.
  final Color? secondTrailingIconButtonColor;
  final IconData? secondTrailingIconButtonIcon;
  final Function()? onSecondTrailingIconButtonPressed;

  const CustomBasePage({
    super.key,
    // ----- State -----
    this.isPageView = false,
    this.height,
    required this.isModalSheet,
    this.isScrollable = true,
    this.canPop = true,
    this.onBasePageTap,
    this.onBasePageDoubleTap,
    this.onHorizontalPopRoute,
    this.bottomIndent = 95.0,
    required this.pageIsLoading,
    this.showPageLoadingButton = false,
    this.onPageLoadingButtonLabel,
    this.onPageLoadingButtonPressed,
    this.pageIsLoadingMessage = '',
    required this.pageHasError,
    required this.pageFailure,
    required this.pageErrorButtonLabel,
    required this.onPageErrorButtonPressed,
    this.focusScopeNode,
    // ----- Error Overlay -----
    required this.failure,
    required this.onDismissFailure,
    // ----- Top Right IconButton -----
    this.onCornerClosePressed,
    // ----- Close while loading button -----
    this.leadingIconButtonColor,
    this.leadingIconButtonIcon,
    this.onLeadingIconButtonPressed,
    // ----- App Bar -----
    this.appBarWidget,
    this.onAppBarMorePressed,
    this.appBarMorePadding,
    this.appBarColor,
    // ----- Refresh -----
    this.isRefreshable = false,
    this.onRefresh,
    // ----- Grid View -----
    this.gridViewVisible = false,
    this.gridViewTitle,
    this.displayGridViewTitleAsColumn = true,
    this.gridViewIcon,
    this.gridViewHasFailure,
    this.gridViewFailure,
    this.gridViewFailureButtonLabel,
    this.onGridViewFailurePressed,
    this.gridViewBuilderHeight = 110.0,
    this.edgeInsetsGrid = const EdgeInsets.only(left: 15.0),
    this.gridViewCount,
    this.gridViewBuilder,
    this.gridViewActionVisible = false,
    this.gridViewActionLabel,
    this.gridViewActionIcon,
    this.onGridViewActionPressed,
    // ----- Content -----
    this.contentHeight,
    this.edgeInsetsContent = const EdgeInsets.symmetric(horizontal: 15.0),
    required this.content,
    this.loadMoreDataThreshold = 250.0,
    this.onLoadMoreContent,
    this.moreContentIsLoading = false,
    // ----- FLoatingActionBar -----
    this.floatingActionBarDisabled = false,
    this.actionBarIsLoading = false,
    this.loadingMessage = '',
    this.closeWhilePageLoadingButtonIcon,
    this.closeWhilePageLoadingButtonColor,
    this.onCloseWhilePageLoadingButtonPressed,
    this.floatingActionBarLabel,
    this.floatingActionBarIcon,
    this.onLongPressFloatingActionBar,
    this.onFloatingActionBarPressed,
    this.firstTrailingIconButtonColor,
    this.firstTrailingIconButtonIcon,
    this.onFirstTrailingIconButtonPressed,
    this.secondTrailingIconButtonColor,
    this.secondTrailingIconButtonIcon,
    this.onSecondTrailingIconButtonPressed,
  });

  @override
  State<CustomBasePage> createState() => _CustomBasePageState();
}

class _CustomBasePageState extends State<CustomBasePage> with WidgetsBindingObserver {
  final ScrollController scrollController = ScrollController();
  double previousScrollPosition = 0.0;
  double scrollPosition = 0.0;
  double position = 0.0;

  bool keyboardIsAnimating = false;
  double keyboardHeight = 0.0;

  @override
  void initState() {
    super.initState();

    // Add observer.
    WidgetsBinding.instance.addObserver(this);

    // Add scroll listener.
    scrollController.addListener(() {
      // Update previous scroll position
      previousScrollPosition = scrollPosition;

      // Set new position.
      scrollPosition = scrollController.position.pixels;
    });
  }

  @override
  void dispose() {
    // Remove listener.
    scrollController.dispose();

    // Dispose observer.
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (mounted) keyboardHeight = MediaQuery.of(context).viewInsets.bottom + widget.bottomIndent;
  }

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final Size size = MediaQuery.of(context).size;

    // Access current bottom inset.
    final double currentBottomInset = MediaQuery.of(context).viewInsets.bottom + widget.bottomIndent;

    // Display an error if isScrollable and isRefreshable are in conflict.
    final bool hasConflict = widget.isScrollable == false && widget.isRefreshable == true;

    return SizedBox(
      height: widget.height ?? (widget.isModalSheet ? size.height * 0.85 : size.height),
      width: double.infinity,
      child: PopScope(
        canPop: widget.canPop,
        child: KeyboardVisibilityBuilder(
          builder: (context, keyboardIsVisible) => hasConflict
              ? const Center(
                  child: Text(
                    'Variable isScrollable cannot be set to false if isRefreshable is set to true.',
                    textAlign: TextAlign.center,
                  ),
                )
              : FocusScope(
                  node: widget.focusScopeNode,
                  child: GestureDetector(
                    onTap: widget.onBasePageTap,
                    onDoubleTap: widget.onBasePageDoubleTap,
                    // * A page view needs to handle horizontal swipe gesture internally.
                    onHorizontalDragStart: widget.isPageView
                        ? null
                        : (final DragStartDetails details) {
                            // * User swiped to close.
                            if (widget.canPop && details.globalPosition.dx < 20.0) {
                              // Check if this route can pop.
                              final bool canPop = Navigator.of(context).canPop();

                              // Close route if possible and onPopRoute is not defined.
                              if (canPop && widget.onHorizontalPopRoute == null) Navigator.of(context).pop();

                              // Trigger onPopRoute if it is defined.
                              if (canPop && widget.onHorizontalPopRoute != null) widget.onHorizontalPopRoute!();
                            }
                          },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Scaffold(
                          // * Use this background color if it is not in a modal sheet.
                          backgroundColor: widget.isModalSheet == false ? Theme.of(context).colorScheme.surface : null,
                          resizeToAvoidBottomInset: true,
                          body: Builder(
                            builder: (context) {
                              // * Show page loading indicator.
                              if (widget.pageIsLoading) {
                                return Center(
                                  child: CustomLoadingSpinner(
                                    loadingMessage: widget.pageIsLoadingMessage,
                                    showButton: widget.showPageLoadingButton,
                                    buttonLabel: widget.onPageLoadingButtonLabel,
                                    onButtonPressed: widget.onPageLoadingButtonPressed,
                                  ),
                                );
                              }

                              // * Show page error indication.
                              if (widget.pageHasError) {
                                return Center(
                                  child: CardError(
                                    showCard: false,
                                    failure: widget.pageFailure,
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    buttonLabel: widget.pageErrorButtonLabel,
                                    onButtonPressed: widget.onPageErrorButtonPressed,
                                  ),
                                );
                              }

                              return NotificationListener(
                                onNotification: (final ScrollNotification scrollNotification) {
                                  final double distanceToBottom = scrollController.position.maxScrollExtent - scrollPosition;
                                  final bool reverse = scrollController.position.userScrollDirection == ScrollDirection.reverse;

                                  // Check if keyboard is animating.
                                  // * The reason for the -5 is that for some reason keyboardHeight and currentBottomInset wont match exactly
                                  // * even if they should. So what the -5 does is basically saying: its good enaugh in this threshold.
                                  // * Ultimately the -5 is a randomly chosen number found out by trial and error.
                                  keyboardIsAnimating = keyboardHeight > widget.bottomIndent && keyboardHeight < (currentBottomInset - 5);

                                  // Check if the scroll was user-initiated
                                  final bool isUserScroll = scrollController.position.userScrollDirection != ScrollDirection.idle;

                                  // Unfocus if user scrolls.
                                  if (isUserScroll && (scrollPosition - previousScrollPosition).abs() > 10) {
                                    if (keyboardHeight > widget.bottomIndent && keyboardIsAnimating == false && keyboardIsVisible) {
                                      // Onfucus.
                                      if (mounted) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    }
                                  }

                                  if (reverse && scrollNotification is ScrollEndNotification) {
                                    if ((scrollPosition == 0.0 && scrollController.position.maxScrollExtent == 0.0) || (distanceToBottom < widget.loadMoreDataThreshold)) {
                                      if (widget.onLoadMoreContent != null) widget.onLoadMoreContent!();
                                    }
                                  }

                                  // Return true to allow the notification to continue to bubble up.
                                  return true;
                                },
                                child: CustomScrollView(
                                  controller: scrollController,
                                  physics: widget.isScrollable == false
                                      ? const NeverScrollableScrollPhysics()
                                      : widget.isRefreshable == false
                                          ? const AlwaysScrollableScrollPhysics()
                                          // * BouncingScrollPhysics is needed for CupertinoSliverRefreshControl.
                                          : const BouncingScrollPhysics(
                                              parent: AlwaysScrollableScrollPhysics(),
                                            ),
                                  slivers: [
                                    // * AppBar.
                                    if (widget.appBarWidget != null)
                                      SliverAppBar(
                                        pinned: true,
                                        automaticallyImplyLeading: false,
                                        backgroundColor: widget.appBarColor,
                                        toolbarHeight: 75.0,
                                        title: Center(
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 20.0),
                                                  widget.appBarWidget!,
                                                  const SizedBox(height: 10.0),
                                                ],
                                              ),
                                              if (widget.onAppBarMorePressed != null)
                                                Container(
                                                  padding: widget.appBarMorePadding,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        AppIcons.moreOptions,
                                                      ),
                                                      onPressed: widget.onAppBarMorePressed!,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    // * Refresh indicator.
                                    if (widget.isRefreshable)
                                      CupertinoSliverRefreshControl(
                                        builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance, refreshIndicatorExtent) {
                                          // * Prevents Spinner from immediately showing if user pulls down just a bit.
                                          if (pulledExtent < 40.0) return const SizedBox();

                                          return const CustomLoadingSpinner(
                                            onlySpinner: true,
                                            paddingTop: 10.0,
                                          );
                                        },
                                        onRefresh: widget.onRefresh == null ? null : () => widget.onRefresh!(),
                                      ),
                                    // * GridView.
                                    if (widget.gridViewVisible)
                                      SliverToBoxAdapter(
                                        child: IntrinsicHeight(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: widget.gridViewHasFailure!
                                                ? [
                                                    Center(
                                                      child: CardError(
                                                        padding: widget.edgeInsetsGrid,
                                                        failure: widget.gridViewFailure!,
                                                        buttonLabel: widget.gridViewFailureButtonLabel!,
                                                        onButtonPressed: widget.onGridViewFailurePressed!,
                                                      ),
                                                    ),
                                                  ]
                                                : [
                                                    // GridView title.
                                                    if (widget.gridViewTitle != null)
                                                      CustomHeader(
                                                        icon: widget.gridViewIcon!,
                                                        title: widget.gridViewTitle,
                                                        displayAsColumn: widget.displayGridViewTitleAsColumn,
                                                      ),

                                                    // GridView.
                                                    if (widget.gridViewCount! != 0)
                                                      Container(
                                                        height: widget.gridViewBuilderHeight,
                                                        margin: widget.gridViewTitle == null ? const EdgeInsets.only(top: 10.0) : null,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          padding: const EdgeInsets.only(bottom: 10.0),
                                                          itemCount: widget.gridViewCount!,
                                                          itemBuilder: (context, index) => widget.gridViewBuilder!(context, index),
                                                        ),
                                                      ),
                                                    // GridView Action.
                                                    if (widget.gridViewActionVisible)
                                                      CardMenuItem(
                                                        padding: EdgeInsets.only(
                                                          left: widget.edgeInsetsContent.left,
                                                          right: widget.edgeInsetsContent.right,
                                                        ),
                                                        title: widget.gridViewActionLabel!,
                                                        leadingIcon: widget.gridViewActionIcon!,
                                                        onTap: widget.onGridViewActionPressed!,
                                                      ),
                                                  ],
                                          ),
                                        ),
                                      ),
                                    // * Content.
                                    SliverToBoxAdapter(
                                      child: Container(
                                        height: widget.contentHeight,
                                        padding: widget.edgeInsetsContent,
                                        child: Column(
                                          children: [
                                            ...widget.content,
                                            if (widget.moreContentIsLoading)
                                              const SizedBox(
                                                height: 50.0,
                                                child: CustomLoadingSpinner(),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // * This SizedBox is needed for FloatingActionBar and ErrorCard to not cover any UI elements.
                                    SliverToBoxAdapter(
                                      child: SizedBox(height: widget.bottomIndent),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // * Corner close button.
                        if ((keyboardIsVisible) && widget.onCornerClosePressed != null)
                          Positioned(
                            left: 12.0,
                            child: CardButton(
                              alignment: Alignment.centerLeft,
                              icon: AppIcons.back,
                              minSize: 50.0,
                              iconSize: 20.0,
                              onPressed: widget.onCornerClosePressed!,
                            ),
                          ),
                        // * Bottom Widgets which should not get rendered if page has error or is loading.
                        if (widget.pageHasError == false && widget.pageIsLoading == false)
                          Positioned(
                            right: 5.0,
                            left: 5.0,
                            bottom: Platform.isIOS ? 40.0 : 10.0,
                            child: Column(
                              children: [
                                // * Error Card
                                CardErrorOverlay(
                                  failure: widget.failure,
                                  onDismissFailure: widget.onDismissFailure,
                                ),
                                const SizedBox(height: 10.0),
                                // * Floating Action Bar.
                                FloatingActionBar(
                                  // State.
                                  visible: keyboardIsVisible == false,
                                  showLoadingSpinner: widget.actionBarIsLoading,
                                  loadingMessage: widget.loadingMessage,
                                  // Leading icon button.
                                  leadingIconButtonColor: widget.leadingIconButtonColor,
                                  leadingIconButtonIcon: widget.leadingIconButtonIcon,
                                  onLeadingIconButtonPressed: widget.onLeadingIconButtonPressed,
                                  // Main button.
                                  disableButton: widget.floatingActionBarDisabled,
                                  buttonLabel: widget.floatingActionBarLabel ?? '',
                                  buttonIcon: widget.floatingActionBarIcon,
                                  onLongPressed: widget.onLongPressFloatingActionBar ?? () {},
                                  onPressed: widget.onFloatingActionBarPressed ?? () {},
                                  // First trailing icon button.
                                  firstTrailingIconButtonColor: widget.firstTrailingIconButtonColor,
                                  firstTrailingIconButtonIcon: widget.firstTrailingIconButtonIcon,
                                  onFirstTrailingIconButtonPressed: widget.onFirstTrailingIconButtonPressed,
                                  // Second trailing icon button.
                                  secondTrailingIconButtonColor: widget.secondTrailingIconButtonColor,
                                  secondTrailingIconButtonIcon: widget.secondTrailingIconButtonIcon,
                                  onSecondTrailingIconButtonPressed: widget.onSecondTrailingIconButtonPressed,
                                ),
                              ],
                            ),
                          ),
                        // * Close while loading button.
                        if (widget.pageIsLoading && widget.onCloseWhilePageLoadingButtonPressed != null)
                          Positioned(
                            right: 5.0,
                            left: 3.0,
                            bottom: Platform.isIOS ? 40.0 : 10.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: CardButton(
                                alignment: Alignment.centerLeft,
                                minSize: 50.0,
                                icon: widget.closeWhilePageLoadingButtonIcon ?? AppIcons.back,
                                iconSize: 20.0,
                                iconColor: widget.closeWhilePageLoadingButtonColor,
                                onPressed: widget.onCloseWhilePageLoadingButtonPressed,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
