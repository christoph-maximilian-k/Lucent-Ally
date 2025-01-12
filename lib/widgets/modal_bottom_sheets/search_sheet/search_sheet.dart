import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/entries/entry.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/search_sheet/cubit/search_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_text_field.dart';
import '/widgets/debouncer/debouncer.dart';

class SearchSheet extends StatelessWidget {
  const SearchSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size.
    final double height = MediaQuery.of(context).size.height;

    // Instantiate debouncer.
    final Debouncer debouncer = Debouncer();

    return BlocBuilder<SearchSheetCubit, SearchSheetState>(
      builder: (context, state) {
        // Convenience variables.
        final bool pageHasError = state.status == SearchSheetStatus.pageHasError;
        final bool pageIsLoading = state.status == SearchSheetStatus.pageIsLoading;

        final bool initial = state.status == SearchSheetStatus.initial;
        final bool loading = state.status == SearchSheetStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // Page is loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.failure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<SearchSheetCubit>().closeSheet(context: context),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<SearchSheetCubit>().dismissFailure(),
          // Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<SearchSheetCubit>().closeSheet(context: context),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<SearchSheetCubit>().closeSheet(context: context),
          // Floating Action Bar.
          floatingActionBarDisabled: true,
          // App bar.
          appBarWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  AppIcons.search,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                ),
              ),
              Expanded(
                child: CustomTextField(
                  shouldRequestFocus: true,
                  onChanged: (final String value, final TextEditingController controller) => debouncer.run(
                    action: () => context.read<SearchSheetCubit>().onSearched(value: value),
                  ),
                ),
              ),
              Container(
                height: 35.0,
                width: 80.0,
                padding: const EdgeInsets.only(left: 10.0),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                  child: Center(
                    child: Text(
                      labels.searchSheetCancel(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content.
          bottomIndent: 0.0, // * Set to 0.0 because there is no FloatingActionBar, so no extra space is needed.
          contentHeight: height * 0.41,
          content: [
            SizedBox(
              height: height * 0.38,
              child: loading
                  ? const Center(
                      child: CustomLoadingSpinner(),
                    )
                  : state.matchingEntries.items.isEmpty
                      ? Center(
                          child: Text(
                            initial ? labels.searchSheetTypeToSearch() : labels.searchSheetNoMatchingResults(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.matchingEntries.items.length,
                          itemBuilder: (context, index) {
                            // Access relevant entries.
                            final Entry entry = state.matchingEntries.items[index];

                            return Card(
                              child: ListTile(
                                dense: false,
                                onTap: () => context.read<SearchSheetCubit>().entryPicked(
                                      context: context,
                                      entry: entry,
                                    ),
                                title: Text(
                                  entry.entryName,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        );
      },
    );
  }
}
