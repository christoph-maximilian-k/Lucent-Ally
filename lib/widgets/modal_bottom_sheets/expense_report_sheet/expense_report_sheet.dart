import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/expense_report_sheet_cubit.dart';

// Models.
import '/data/models/field_types/payment_data/creditor_debitor.dart';
import '/data/models/charts/chart.dart';
import '/data/models/charts/pie_chart/items/pie_item.dart';
import '/data/models/fields/field.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/charts/custom_chart.dart';

class ExpenseReportSheet extends StatelessWidget {
  const ExpenseReportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpenseReportSheetCubit, ExpenseReportSheetState>(
      listener: (context, state) {
        // * User wants to close the sheet.
        if (state.status == ExpenseReportSheetStatus.close) {
          context.read<ExpenseReportSheetCubit>().closeSheet(context: context);
        }

        // * Trigger a local state refresh.
        if (state.status == ExpenseReportSheetStatus.refreshLocalState) {
          context.read<ExpenseReportSheetCubit>().initialize(
                isShared: state.isShared,
                isRefresh: true,
                group: state.fromGroup,
                participantMembers: state.participantMembers,
                utilizedFieldIdentifications: state.utilizedFieldIdentifications,
                filterByFieldId: state.filterByFieldId,
                filterByYear: state.filterByYear,
              );
        }

        // * User wants to reload settlement.
        if (state.settlementStatus == LoadSettlementStatus.triggerReload) {
          context.read<ExpenseReportSheetCubit>().loadSettlement();
        }
      },
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ExpenseReportSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ExpenseReportSheetStatus.pageHasError;

        // Convenience variables.
        final bool settlementIsLoading = state.settlementStatus == LoadSettlementStatus.loading;
        final bool settlementHasError = state.settlementStatus == LoadSettlementStatus.failure;

        return SizedBox(
          key: const ValueKey('expense_report_sheet_key'),
          child: CustomBasePage(
            isModalSheet: true,
            pageIsLoading: pageIsLoading,
            pageIsLoadingMessage: state.pageLoadingMessage,
            // Page Failure.
            pageHasError: pageHasError,
            pageFailure: state.pageFailure,
            pageErrorButtonLabel: labels.basicLabelsClose(),
            onPageErrorButtonPressed: () => context.read<ExpenseReportSheetCubit>().closeSheet(context: context),
            // Common Failure.
            failure: state.failure,
            onDismissFailure: () => context.read<ExpenseReportSheetCubit>().dismissFailure(),
            // Leading Icon Button.
            leadingIconButtonIcon: AppIcons.back,
            onLeadingIconButtonPressed: () => context.read<ExpenseReportSheetCubit>().closeSheet(context: context),
            // * On refresh.
            isRefreshable: state.isShared,
            onRefresh: () => context.read<ExpenseReportSheetCubit>().initialize(
                  isShared: state.isShared,
                  isRefresh: true,
                  group: state.fromGroup,
                  participantMembers: state.participantMembers,
                  utilizedFieldIdentifications: state.utilizedFieldIdentifications,
                  filterByFieldId: state.filterByFieldId,
                  filterByYear: state.filterByYear,
                ),
            // Floating action button.
            floatingActionBarDisabled: true,
            content: [
              const SizedBox(height: 5.0),
              Center(
                child: Text(
                  labels.basicLabelsRepayments(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(minWidth: 210.0),
                    child: CustomDropDownButton(
                      isOutlined: true,
                      label: labels.dropDownButtonShowAllTransactions(
                        showAllTransactions: state.showAllTransactions,
                      ),
                      onTap: () => context.read<ExpenseReportSheetCubit>().onShowOptimizeOptions(context: context),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  IconButton(
                    key: const ValueKey('reload_settlement'),
                    icon: const Icon(
                      AppIcons.refresh,
                    ),
                    onPressed: () => context.read<ExpenseReportSheetCubit>().reloadSettlement(),
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Center(
                child: Text(
                  labels.infoMessageCreditorsDebitors(
                    showAllTransactions: state.showAllTransactions,
                    defaultCurrency: state.fromGroup.defaultCurrencyCode,
                    fieldLabel: state.utilizedFieldIdentifications.getById(fieldId: state.filterByFieldId)?.label ?? '',
                    filterByYear: state.filterByYear?.year.toString() ?? '',
                  ),
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 25.0),
              Builder(
                builder: (context) {
                  // * Show loading indication.
                  if (settlementIsLoading) {
                    return Column(
                      children: [
                        const SizedBox(height: 50.0),
                        CustomLoadingSpinner(
                          loadingMessage: state.creditorsDebitorsLoadingMessage,
                        ),
                        const SizedBox(height: 50.0),
                      ],
                    );
                  }

                  // * Show error.
                  if (settlementHasError) {
                    return Column(
                      children: [
                        const SizedBox(height: 50.0),
                        CustomElevatedButton(
                          label: labels.basicLabelsTryAgain(),
                          onPressed: () => context.read<ExpenseReportSheetCubit>().loadSettlement(),
                        ),
                        const SizedBox(height: 15.0),
                        SizedBox(
                          width: 200.0,
                          child: Text(
                            labels.failureGenericError(),
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50.0),
                      ],
                    );
                  }

                  // * Show indication that account is leveled out.
                  if (state.creditorsDebitors.items.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Text(
                          labels.expenseReportSheetAccountIsLeveledOut(),
                          style: Theme.of(context).textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  // * Show expense reports.
                  return Column(
                    children: [
                      ...List<Widget>.generate(
                        state.creditorsDebitors.items.length,
                        (index) {
                          // Access CreditorDebitor.
                          final CreditorDebitor creditorDebitor = state.creditorsDebitors.items[index];

                          return SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Column(
                                children: [
                                  const SizedBox(height: 10.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    width: double.infinity,
                                    child: Text(
                                      creditorDebitor.debitor.memberName,
                                      style: Theme.of(context).textTheme.titleSmall,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          labels.expenseReportSheetOwns(),
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                        Text(
                                          '${creditorDebitor.value.toStringAsFixed(2)} ${state.fromGroup.defaultCurrencyCode}',
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    width: double.infinity,
                                    child: Text(
                                      creditorDebitor.creditor.memberName,
                                      style: Theme.of(context).textTheme.titleSmall,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    labels.expenseReportSheetExpenseReport(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              // * #####################################
              // * Charts.
              // * #####################################
              ...state.charts.items.map(
                (final Chart chart) {
                  return CustomChart(
                    // * A key needs to be provided otherwise charts will be incorrectly attributed
                    // * if two charts of the same type but different field are used after one another.
                    // * ValueKey with chartId is used because otherwise a specific reload will trigger all charts instead of one.
                    key: ValueKey(chart.chartId),
                    chart: chart,
                    defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
                    showReloadIcon: state.isShared,
                    // * Chart title.
                    title: context.read<ExpenseReportSheetCubit>().getChartTitle(chart: chart),
                    // * Chart subtitle.
                    subtitle: labels.basicLabelsFieldIndication(
                      fieldIdentifications: state.utilizedFieldIdentifications,
                      filterByFieldId: chart.filterByFieldId,
                    ),
                    // * Static chart replacement message.
                    staticChartReplacementMessage: chart.getStaticChartReplacementMessage(
                      fieldType: Field.fieldTypePayment,
                      defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
                    ),
                    // * Chart info line.
                    infoLine: context.read<ExpenseReportSheetCubit>().getChartInfoLine(chart: chart),
                    // * Action button.
                    showActionButton: false,
                    // * On pressed legend items.
                    onPieItemLegendTap: (final PieItem pieItem, final int index) => context.read<ExpenseReportSheetCubit>().onPieItemLegendTap(
                          pieItem: pieItem,
                          legendItemIndex: index,
                          chart: chart,
                          context: context,
                        ),
                    // * Reload indicators.
                    reloadIndicators: [
                      chart.filterByFieldId,
                      if (chart.getShowFilterByYear) chart.filterByYear,
                      if (chart.showFilterByMember) chart.filterByMember,
                      if (chart.filterByTimeInterval != null) chart.filterByTimeInterval,
                    ],
                    // * Filter options.
                    dropDownButtons: [
                      // * Choose a member.
                      if (chart.showFilterByMember)
                        CustomDropDownButton(
                          isOutlined: true,
                          maxWidth: 80.0,
                          label: chart.filterByMember == null ? labels.basicLabelChooseMember() : chart.filterByMember!.memberName,
                          onTap: () => context.read<ExpenseReportSheetCubit>().chooseMember(
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
                          onTap: () => context.read<ExpenseReportSheetCubit>().chooseYear(
                                context: context,
                                chart: chart,
                              ),
                        ),
                    ],
                    // * Load data.
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
                          return context.read<ExpenseReportSheetCubit>().loadlocalBarChart(
                                chart: chart,
                              );
                        }

                        // * Query shared chart.
                        if (state.isShared) {
                          return context.read<ExpenseReportSheetCubit>().loadSharedBarChart(
                                chart: chart,
                                bypassCache: bypassCache,
                              );
                        }
                      }

                      // * Load pie chart.
                      if (chart.chartType == Chart.chartTypePieChart) {
                        // * Query local chart.
                        if (state.isShared == false) {
                          return context.read<ExpenseReportSheetCubit>().loadlocalPieChart(
                                chart: chart,
                              );
                        }

                        // * Query shared chart.
                        if (state.isShared) {
                          return context.read<ExpenseReportSheetCubit>().loadSharedPieChart(
                                chart: chart,
                                bypassCache: bypassCache,
                              );
                        }
                      }

                      // * Load line chart.
                      if (chart.chartType == Chart.chartTypeLineChart) {
                        // * Query local chart.
                        if (state.isShared == false) {
                          return context.read<ExpenseReportSheetCubit>().loadLocalLineChart(
                                chart: chart,
                              );
                        }

                        // * Query shared chart.
                        if (state.isShared) {
                          return context.read<ExpenseReportSheetCubit>().loadSharedLineChart(
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
          ),
        );
      },
    );
  }
}
