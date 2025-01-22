import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// User with Settings and Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Cubits.
import 'cubit/charts_sheet_cubit.dart';

// Models.
import '/data/models/charts/chart.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/fields/field.dart';
import '/data/models/charts/pie_chart/items/pie_item.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_drop_down_button.dart';

import '/widgets/charts/custom_chart.dart';
import '/widgets/charts/custom_generic_info_chart.dart';
import '/widgets/charts/custom_next_birthday_info_chart.dart';
import '/widgets/cards/card_error.dart';
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_loading_spinner.dart';

class ChartsSheet extends StatelessWidget {
  const ChartsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChartsSheetCubit, ChartsSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ChartsSheetStatus.close && current.status == ChartsSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == ChartsSheetStatus.close) Navigator.of(context).pop();

        // * Trigger a local state refresh.
        if (state.status == ChartsSheetStatus.refreshLocalState) {
          context.read<ChartsSheetCubit>().refreshLocal();
        }

        // * Trigger exchange rate load.
        if (state.selectedFieldType.id == Field.fieldTypePayment || state.selectedFieldType.id == Field.fieldTypeMoney) {
          // Only trigger this through listener if current state is initial, i.e. if it was never started before.
          if (state.exchangeRatesStatus == ExchangeRatesStatus.initial) context.read<ChartsSheetCubit>().accessRequiredExchangeRatesOfLocalGroup();
        }
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != ChartsSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ChartsSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ChartsSheetStatus.pageHasError;

        final bool exchangeRatesLoading = state.exchangeRatesStatus == ExchangeRatesStatus.loading;
        final bool exchangeRatesActionRequired = state.exchangeRatesStatus == ExchangeRatesStatus.actionRequired;
        final bool exchangeRatesFailure = state.exchangeRatesStatus == ExchangeRatesStatus.failure;

        return CustomBasePage(
          key: const ValueKey('charts_sheet_key'),
          isModalSheet: true,
          pageIsLoading: pageIsLoading,
          // * Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ChartsSheetCubit>().closeSheet(),
          // * Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ChartsSheetCubit>().dismissFailure(),
          // * Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ChartsSheetCubit>().closeSheet(),
          // Horizontal swipe to close.
          onHorizontalPopRoute: () => context.read<ChartsSheetCubit>().closeSheet(),
          // * Close while loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ChartsSheetCubit>().closeSheet(),
          // * Floating Action Bar.
          floatingActionBarDisabled: true,
          // * On refresh.
          isRefreshable: state.isShared,
          onRefresh: () => context.read<ChartsSheetCubit>().initializeShared(
                group: state.fromGroup,
                isRefresh: true,
              ),
          // * Content.
          content: [
            const SizedBox(height: 20.0),
            // * Generic group info chart.
            CustomGenericInfoChart(
              key: const ValueKey('group_info_chart'),
              chartTitle: labels.groupInfo(),
              staticChartReplacementMessage: '',
              triggerReload: state.status == ChartsSheetStatus.refreshValues,
              // * First future.
              firstFutureTitle: labels.basicLabelsEntries(),
              firstFutureIcon: AppIcons.entries,
              firstFuture: () => context.read<ChartsSheetCubit>().loadNumberOfEntries(),
              // * Second future.
              secondFutureTitle: labels.basicLabelsModelEntries(),
              secondFutureIcon: AppIcons.entryModels,
              secondFuture: () => context.read<ChartsSheetCubit>().loadNumberOfUniqueModelEntries(),
              // * Third future.
              thirdFutureTitle: labels.basicLabelsCreatedAt(),
              thirdFutureIcon: AppIcons.createdAt,
              thirdFuture: () => context.read<ChartsSheetCubit>().loadGroupCreatedAt(),
              // * Fourth future.
              fourthFutureTitle: labels.basicLabelsEditedAt(),
              fourthFutureIcon: AppIcons.edit,
              fourthFuture: () => context.read<ChartsSheetCubit>().loadGroupEditedAt(),
            ),
            // * ##########################################################################
            // * No field identifications have been utilized, display message.
            // * ##########################################################################
            if (state.utilizedFieldIdentifications.items.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
                child: Text(
                  labels.noMeaningfulDataInGroupYet(),
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            // * ##########################################################################
            // * Charts.
            // * ##########################################################################
            if (state.utilizedFieldIdentifications.items.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  Column(
                    children: [
                      CustomDropDownButton(
                        isOutlined: true,
                        minWidth: 200.0,
                        fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                        labelColor: Theme.of(context).textTheme.bodyLarge?.color,
                        label: state.selectedFieldType.label,
                        onTap: () => context.read<ChartsSheetCubit>().onPickFieldIdentification(
                              context: context,
                            ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      // Convenience variables.
                      final bool isPayment = state.selectedFieldType.id == Field.fieldTypePayment;
                      final bool isMoney = state.selectedFieldType.id == Field.fieldTypeMoney;

                      if (isPayment || isMoney) {
                        if (exchangeRatesLoading) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: CustomLoadingSpinner(
                              loadingMessage: labels.accessingRequiredExchangeRates(),
                            ),
                          );
                        }

                        if (exchangeRatesFailure) {
                          return CardError(
                            showCard: false,
                            failure: state.exchangeRatesFailure,
                            padding: const EdgeInsets.only(top: 35.0),
                            buttonLabel: labels.basicLabelsTryAgain(),
                            onButtonPressed: () => context.read<ChartsSheetCubit>().accessRequiredExchangeRatesOfLocalGroup(),
                          );
                        }

                        if (exchangeRatesActionRequired) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: Text(
                                  labels.invalidExchangeRatesInfoMessage(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                              CustomElevatedButton(
                                label: labels.basicLabelsProvideExchangeRates(),
                                onPressed: () => context.read<ChartsSheetCubit>().onProvideExchangeRatesPressed(
                                      context: context,
                                    ),
                              ),
                            ],
                          );
                        }
                      }

                      // * Display no charts available message.
                      if (state.charts.items.isEmpty) {
                        return Column(
                          children: [
                            const SizedBox(height: 35.0),
                            Text(
                              labels.noChartsForThisFieldType(),
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }

                      // * Display charts.
                      return Column(
                        children: [
                          const SizedBox(height: 20.0),
                          // * In case of birthday field, display next birthday card.
                          if (state.selectedFieldType.id == Field.fieldTypeDateOfBirth)
                            // * Next Birthdays info chart.
                            // * Currently not implemented in shared mode.
                            if (state.isShared == false)
                              CustomNextBirthdayInfoChart(
                                key: const ValueKey('next_birthdays'),
                                modelEntries: state.modelEntriesOfGroup,
                                chartTitle: labels.nextBirthdaysInfo(),
                                loadNextBirthdays: () => context.read<ChartsSheetCubit>().loadNextBirthdayEntries(),
                                chartInfoLine: labels.infoMessageNextBirthdays(),
                              ),
                          ...state.charts.items.map(
                            (final Chart chart) {
                              // * Show a descriptive chart.
                              if (chart.chartType == Chart.chartTypeDescriptiveChart) {
                                return CustomGenericInfoChart(
                                  key: ValueKey(chart.chartId),
                                  cardWidth: double.infinity,
                                  chartTitle: labels.basicLabelsDescriptiveValues(),
                                  subtitle: labels.basicLabelsFieldIndication(
                                    fieldIdentifications: state.utilizedFieldIdentifications,
                                    filterByFieldId: chart.filterByFieldId,
                                  ),
                                  // * Static chart replacement message.
                                  staticChartReplacementMessage: chart.getStaticChartReplacementMessage(
                                    fieldType: state.selectedFieldType.id,
                                    defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
                                  ),
                                  reloadIndicators: [
                                    chart.filterByFieldId,
                                    if (chart.getShowFilterByYear) chart.filterByYear,
                                    if (state.selectedFieldType.id == Field.fieldTypeMeasurement) chart.filterByMeasurementCategory,
                                    if (state.selectedFieldType.id == Field.fieldTypeMeasurement) chart.filterByMeasurementUnit,
                                  ],
                                  dropDownButtons: [
                                    // * Choose a year.
                                    if (chart.getShowFilterByYear)
                                      CustomDropDownButton(
                                        isOutlined: true,
                                        maxWidth: 80.0,
                                        label: chart.getSelectedDateYear,
                                        onTap: () => context.read<ChartsSheetCubit>().chooseYear(
                                              context: context,
                                              chart: chart,
                                            ),
                                      ),
                                    // * Choose a measurement category.
                                    if (state.selectedFieldType.id == Field.fieldTypeMeasurement)
                                      CustomDropDownButton(
                                        isOutlined: true,
                                        maxWidth: 80.0,
                                        label: labels.basicLabelsCategory(
                                          category: MeasurementData.categoriesByTypeAndLanguage()[chart.filterByMeasurementCategory] ?? '',
                                        ),
                                        onTap: () => context.read<ChartsSheetCubit>().onPickMeasurementCategory(
                                              context: context,
                                              chart: chart,
                                            ),
                                      ),
                                    // * Choose a measurement unit.
                                    if (state.selectedFieldType.id == Field.fieldTypeMeasurement)
                                      CustomDropDownButton(
                                        isOutlined: true,
                                        maxWidth: 80.0,
                                        label: labels.basicLabelsUnit(unit: chart.filterByMeasurementUnit),
                                        onTap: () => context.read<ChartsSheetCubit>().onPickMeasurementUnit(
                                              context: context,
                                              chart: chart,
                                            ),
                                      ),
                                  ],
                                  // * First future.
                                  firstFutureTitle: labels.basicLabelsMaximum(),
                                  firstFutureIcon: AppIcons.maximum,
                                  firstFuture: () {
                                    // * Query local chart.
                                    if (state.isShared == false) {
                                      return context.read<ChartsSheetCubit>().loadLocalDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 1,
                                          );
                                    }

                                    // * Query shared chart.
                                    if (state.isShared) {
                                      return context.read<ChartsSheetCubit>().loadSharedDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 1,
                                          );
                                    }
                                  },
                                  // * Second future.
                                  secondFutureTitle: labels.basicLabelsMinimum(),
                                  secondFutureIcon: AppIcons.minimum,
                                  secondFuture: () {
                                    // * Query local chart.
                                    if (state.isShared == false) {
                                      return context.read<ChartsSheetCubit>().loadLocalDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 2,
                                          );
                                    }

                                    // * Query shared chart.
                                    if (state.isShared) {
                                      return context.read<ChartsSheetCubit>().loadSharedDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 2,
                                          );
                                    }
                                  },
                                  // * Third future.
                                  thirdFutureTitle: labels.basicLabelsAverage(),
                                  thirdFutureIcon: AppIcons.average,
                                  thirdFuture: () {
                                    // * Query local chart.
                                    if (state.isShared == false) {
                                      return context.read<ChartsSheetCubit>().loadLocalDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 3,
                                          );
                                    }

                                    // * Query shared chart.
                                    if (state.isShared) {
                                      return context.read<ChartsSheetCubit>().loadSharedDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 3,
                                          );
                                    }
                                  },
                                  // * Fourth future.
                                  fourthFutureTitle: labels.basicLabelsSum(),
                                  fourthFutureIcon: AppIcons.sum,
                                  fourthFuture: () {
                                    // * Query local chart.
                                    if (state.isShared == false) {
                                      return context.read<ChartsSheetCubit>().loadLocalDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 4,
                                          );
                                    }

                                    // * Query shared chart.
                                    if (state.isShared) {
                                      return context.read<ChartsSheetCubit>().loadSharedDescriptiveValue(
                                            chart: chart,
                                            futurePosition: 4,
                                          );
                                    }
                                  },
                                  onMenuPressed: chart.getShowMenu
                                      ? () => context.read<ChartsSheetCubit>().onChartMoreOptions(
                                            context: context,
                                            showTimeIntervalOption: chart.showFilterByTimeInterval,
                                            showFieldOption: chart.showFilterByField,
                                            chart: chart,
                                          )
                                      : null,
                                );
                              }

                              // * Show a Visual chart.
                              return CustomChart(
                                // * A key needs to be provided otherwise charts will be incorrectly attributed
                                // * if two charts of the same type but different field are used after one another.
                                // * ValueKey with chartId is used because otherwise a specific reload will trigger all charts instead of one.
                                key: ValueKey(chart.chartId),
                                chart: chart,
                                defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
                                showReloadIcon: state.isShared,
                                onMenuPressed: chart.getShowMenu
                                    ? () => context.read<ChartsSheetCubit>().onChartMoreOptions(
                                          context: context,
                                          showTimeIntervalOption: chart.showFilterByTimeInterval,
                                          showFieldOption: chart.showFilterByField,
                                          chart: chart,
                                        )
                                    : null,
                                // * On pressed legend items.
                                onPieItemLegendTap: (final PieItem pieItem, final int index) => context.read<ChartsSheetCubit>().onPieItemLegendTap(
                                      pieItem: pieItem,
                                      legendItemIndex: index,
                                      chart: chart,
                                      context: context,
                                    ),
                                // * Chart title.
                                title: context.read<ChartsSheetCubit>().getChartTitle(chart: chart),
                                // * Chart subtitle.
                                subtitle: labels.basicLabelsFieldIndication(
                                  fieldIdentifications: state.utilizedFieldIdentifications,
                                  filterByFieldId: chart.filterByFieldId,
                                ),
                                // * Static chart replacement message.
                                staticChartReplacementMessage: chart.getStaticChartReplacementMessage(
                                  fieldType: state.selectedFieldType.id,
                                  defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
                                ),
                                // * Chart info line.
                                infoLine: context.read<ChartsSheetCubit>().getChartInfoLine(chart: chart),
                                // * Action button.
                                showActionButton: chart.showActionButton,
                                actionButtonLabel: labels.basicLabelsShowSettlementAndCosts(),
                                onActionButtonPressed: () => context.read<ChartsSheetCubit>().onActionButtonPressed(
                                      context: context,
                                      chart: chart,
                                    ),
                                // * Reload indicators.
                                reloadIndicators: [
                                  chart.filterByFieldId,
                                  if (chart.getShowFilterByYear) chart.filterByYear,
                                  if (chart.showFilterByMember) chart.filterByMember,
                                  if (chart.filterByTimeInterval != null) chart.filterByTimeInterval,
                                  if (state.selectedFieldType.id == Field.fieldTypeMeasurement) chart.filterByMeasurementCategory,
                                  if (state.selectedFieldType.id == Field.fieldTypeMeasurement) chart.filterByMeasurementUnit,
                                ],
                                // * Filter options.
                                dropDownButtons: [
                                  // * Choose a member.
                                  if (chart.showFilterByMember)
                                    CustomDropDownButton(
                                      isOutlined: true,
                                      maxWidth: 80.0,
                                      label: chart.filterByMember == null ? labels.basicLabelChooseMember() : chart.filterByMember!.memberName,
                                      onTap: () => context.read<ChartsSheetCubit>().chooseMember(
                                            context: context,
                                            chart: chart,
                                          ),
                                    ),
                                  // * Choose a year.
                                  if (chart.getShowFilterByYear)
                                    CustomDropDownButton(
                                      isOutlined: true,
                                      maxWidth: 80.0,
                                      label: chart.getSelectedDateYear,
                                      onTap: () => context.read<ChartsSheetCubit>().chooseYear(
                                            context: context,
                                            chart: chart,
                                          ),
                                    ),
                                  // * Choose a measurement category.
                                  if (state.selectedFieldType.id == Field.fieldTypeMeasurement)
                                    CustomDropDownButton(
                                      isOutlined: true,
                                      maxWidth: 80.0,
                                      label: labels.basicLabelsCategory(
                                        category: MeasurementData.categoriesByTypeAndLanguage()[chart.filterByMeasurementCategory] ?? '',
                                      ),
                                      onTap: () => context.read<ChartsSheetCubit>().onPickMeasurementCategory(
                                            context: context,
                                            chart: chart,
                                          ),
                                    ),
                                  // * Choose a measurement unit.
                                  if (state.selectedFieldType.id == Field.fieldTypeMeasurement)
                                    CustomDropDownButton(
                                      isOutlined: true,
                                      maxWidth: 80.0,
                                      label: labels.basicLabelsUnit(unit: chart.filterByMeasurementUnit),
                                      onTap: () => context.read<ChartsSheetCubit>().onPickMeasurementUnit(
                                            context: context,
                                            chart: chart,
                                          ),
                                    ),
                                ],
                                loadChartData: (final bool bypassCache) {
                                  /// ##############
                                  /// Locally there is no reload chart icon because underlying data
                                  /// can only change if user navigates back from the chart sheet
                                  /// and therefore resets it.
                                  /// This results in the fact that bypassCache is also not needed locally.
                                  /// ##############

                                  // * Load bar chart.
                                  if (chart.chartType == Chart.chartTypeBarChart) {
                                    // * Query local chart.
                                    if (state.isShared == false) {
                                      return context.read<ChartsSheetCubit>().loadLocalBarChart(
                                            chart: chart,
                                          );
                                    }

                                    // * Query shared chart.
                                    if (state.isShared) {
                                      return context.read<ChartsSheetCubit>().loadSharedBarChart(
                                            chart: chart,
                                            bypassCache: bypassCache,
                                          );
                                    }
                                  }

                                  // * Load pie chart.
                                  if (chart.chartType == Chart.chartTypePieChart) {
                                    // * Query local chart.
                                    if (state.isShared == false) {
                                      return context.read<ChartsSheetCubit>().loadLocalPieChart(
                                            chart: chart,
                                          );
                                    }

                                    // * Query shared chart.
                                    if (state.isShared) {
                                      return context.read<ChartsSheetCubit>().loadSharedPieChart(
                                            chart: chart,
                                            bypassCache: bypassCache,
                                          );
                                    }
                                  }

                                  // * Load line chart.
                                  if (chart.chartType == Chart.chartTypeLineChart) {
                                    // * Query local chart.
                                    if (state.isShared == false) {
                                      return context.read<ChartsSheetCubit>().loadLocalLineChart(
                                            chart: chart,
                                          );
                                    }

                                    // * Query shared chart.
                                    if (state.isShared) {
                                      return context.read<ChartsSheetCubit>().loadSharedLineChart(
                                            chart: chart,
                                            bypassCache: bypassCache,
                                          );
                                    }
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
