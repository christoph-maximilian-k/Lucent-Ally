import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// User with Settings and Labels.
import '/main.dart';

// Cubits.
import '/pages/entry_selected_page/cubit/entry_selected_page_cubit.dart';

// Models.
import '/data/models/entries/entry.dart';
import '/data/models/failure.dart';

// Widgets.
import '/widgets/cards/card_error.dart';
import '/widgets/customs/custom_loading_spinner.dart';

class EntrySelectedPage extends StatefulWidget {
  final int initialPage;
  const EntrySelectedPage({
    super.key,
    required this.initialPage,
  });

  @override
  State<EntrySelectedPage> createState() => _EntrySelectedPageState();
}

class _EntrySelectedPageState extends State<EntrySelectedPage> {
  // Init page controller.
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EntrySelectedPageCubit, EntrySelectedPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        // Access entries length.
        final int entriesLength = context.read<EntrySelectedPageCubit>().getEntriesLength;

        // Get indications.
        final bool showLoadingPage = state.status == EntrySelectedPageStatus.loadingMoreContent;
        final bool showErrorPage = state.status == EntrySelectedPageStatus.loadingMoreContentFailure;

        // Access correct itemCount.
        final int itemCount = state.isFinished || entriesLength == (widget.initialPage + 1) ? entriesLength : entriesLength + 1;

        // Return Widget.
        return Container(
          // * This is required because otherwise CustomBasePage will fill screen because it is wrapped with a PageView.
          height: MediaQuery.of(context).size.height * 0.85,
          // * This is required because otherwise Swiping beyond bounds will reveil a different color.
          color: Theme.of(context).colorScheme.surface,
          child: PageView.builder(
            controller: pageController,
            allowImplicitScrolling: entriesLength > 1,
            onPageChanged: (final int index) => context.read<EntrySelectedPageCubit>().onPageChanged(index: index),
            itemCount: itemCount,
            itemBuilder: (context, itemIndex) {
              // Check bounds.
              final bool outOfBounds = itemIndex >= entriesLength;
              final bool inBounds = itemIndex < entriesLength;

              // Return a loading page.
              if (outOfBounds) {
                // Show loading indication.
                if (itemIndex == entriesLength && showLoadingPage) {
                  return Center(
                    child: CustomLoadingSpinner(
                      loadingMessage: labels.loadingMoreEntries(),
                    ),
                  );
                }

                // Return a loading page.
                if (itemIndex == entriesLength && showErrorPage) {
                  return Center(
                    child: CardError(
                      showCard: false,
                      failure: Failure.failedToLoadEntries(),
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      buttonLabel: labels.basicLabelsTryAgain(),
                      onButtonPressed: () => context.read<EntrySelectedPageCubit>().triggerLoadMoreEntriesEvent(fromOnTap: true),
                    ),
                  );
                }
              }

              // If page is within bounds, show entry.
              if (inBounds) {
                // Access entry.
                final Entry entry = context.read<EntrySelectedPageCubit>().getEntry(index: itemIndex);

                // Return the page.
                return context.read<EntrySelectedPageCubit>().createEntrySelectedSheetWidget(context: context, entry: entry);
              }

              // Fallback, in case something unexpected happens.
              return SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
