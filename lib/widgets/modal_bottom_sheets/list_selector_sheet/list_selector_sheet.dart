import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';
import '/config/country_specification.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/list_selector_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/debouncer/debouncer.dart';
import '/widgets/customs/custom_text_field.dart';

// Models.
import '/data/models/entries/entry.dart';

class ListSelectorSheet extends StatelessWidget {
  const ListSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Access screen size.
    final double height = MediaQuery.of(context).size.height;

    // Instantiate debouncer.
    final Debouncer debouncer = Debouncer();

    return BlocConsumer<ListSelectorSheetCubit, ListSelectorSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ListSelectorSheetStatus.close && current.status == ListSelectorSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == ListSelectorSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != ListSelectorSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ListSelectorSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ListSelectorSheetStatus.pageHasError;
        final bool loading = state.status == ListSelectorSheetStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ListSelectorSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ListSelectorSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<ListSelectorSheetCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ListSelectorSheetCubit>().closeSheet(),
          // Leading Icon Button
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ListSelectorSheetCubit>().closeSheet(),
          // Floating action bar.
          floatingActionBarDisabled: true,
          // AppBar.
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
                    action: () => context.read<ListSelectorSheetCubit>().onSearched(value: value),
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
                  onTap: () => context.read<ListSelectorSheetCubit>().closeSheet(),
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
          contentHeight: height * 0.71,
          content: loading
              ? [
                  SizedBox(
                    height: height * 0.38,
                    child: const Center(
                      child: CustomLoadingSpinner(),
                    ),
                  )
                ]
              : [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.matching.isNotEmpty
                          ? state.matching.length
                          : state.currentSearchCriteria.isNotEmpty || state.items.isEmpty
                              ? 1
                              : state.items.length,
                      itemBuilder: (context, index) {
                        // * If no items were supplied.
                        if (state.items.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text(
                                labels.listSelectorNoItemsFound(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          );
                        }

                        // * If a search was conducted, but nothing was found, return indication.
                        if (state.matching.isEmpty && state.currentSearchCriteria.isNotEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text(
                                labels.listSelectorSheetNoMatchingResults(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          );
                        }

                        // Access current country.
                        var item = state.matching.isNotEmpty ? state.matching[index] : state.items[index];

                        // Item type is CountrySpecification.
                        if (item is CountrySpecification) {
                          final CountrySpecification countrySpecification = item;

                          String label = '${countrySpecification.countryName} (${countrySpecification.internationalPhonePrefix})';
                          if (state.isCurrencySelector) label = countrySpecification.currencyName;

                          return Container(
                            height: 60.0,
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Card(
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(countrySpecification),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: state.isCurrencySelector
                                            ? Center(
                                                child: Text(
                                                  countrySpecification.currencySymbol,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            : countrySpecification.flag!,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Text(
                                            label,
                                            style: Theme.of(context).textTheme.labelSmall,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        // Item type is Entry.
                        if (item is Entry) {
                          final Entry entry = item;

                          String label = entry.entryName;

                          return Container(
                            height: 60.0,
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Card(
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(entry),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Text(
                                            label,
                                            style: Theme.of(context).textTheme.labelSmall,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        // Item type is unknown.
                        return Container(
                          height: 60.0,
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Card(
                            child: Center(
                              child: Text(
                                labels.listSelectorSheetUnknownItem(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
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
