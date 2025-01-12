import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/charts/chart.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/charts/bar_chart/items/bar_item.dart';
import '/data/models/charts/pie_chart/items/pie_item.dart';
import '/data/models/charts/pie_chart/items/pie_items.dart';
import '/data/models/charts/line_chart/instructions/line_chart_instruction.dart';
import '/data/models/charts/line_chart/items/line_item.dart';
import '/data/models/charts/line_chart/items/line_items.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_text_button.dart';
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/charts/custom_bar_chart.dart';

// Config.
import '/config/app_icons.dart';

class CustomChart extends StatefulWidget {
  final double? cardHeight;
  final double? cardWidth;

  // * Title.
  final String title;

  // * Subtitle.
  final String subtitle;

  // * Info line.
  final String infoLine;

  // * Static chart replacement message.
  final String staticChartReplacementMessage;

  // * Relaod indicators.
  final List<dynamic> reloadIndicators;

  // * On chart tap.
  final Function()? onTap;

  // * On reload.
  final bool showReloadIcon;

  // * Menu.
  final Function()? onMenuPressed;

  // * Drop Down Buttons.
  final List<CustomDropDownButton> dropDownButtons;

  // * Static chart data.
  final Chart chart;
  final String defaultCurrencyCode;

  // * On bar item touch.
  final Function(BarItem)? onBarItemTap;

  // * On pie item touch.
  final Function(PieItem)? onPieItemTap;

  // * On pie item legend touch.
  final Function(PieItem, int)? onPieItemLegendTap;

  // * Load data function.
  /// This function needs to return the desired chart items.
  ///
  /// * For a ```BarChart``` this would be ```BarItems```.
  /// * For a ```PieChart``` this would be ```PieItems```.
  /// * For a ```LineChart``` this would be ```LineItems```.
  ///
  /// This is because this function gets copied by a state function of this widget and that state function will be subsequently used.
  final Function(bool) loadChartData;

  // * Action Button.
  final bool showActionButton;
  final String? actionButtonLabel;
  final Function()? onActionButtonPressed;

  const CustomChart({
    super.key,
    this.cardHeight,
    this.cardWidth,
    required this.title,
    this.subtitle = '',
    this.infoLine = '',
    // * Static chart replacement message.
    required this.staticChartReplacementMessage,
    // * On chart tap.
    this.onTap,
    // * Reload indicators.
    required this.reloadIndicators,
    // * Show relaod.
    this.showReloadIcon = false,
    // * Menu.
    this.onMenuPressed,
    // * Drop Down Buttons.
    this.dropDownButtons = const [],
    // * On bar item touch.
    this.onBarItemTap,
    // * On pie item touch.
    this.onPieItemTap,
    // * On pie item legend touch.
    this.onPieItemLegendTap,
    // * Static chart data.
    required this.chart,
    required this.defaultCurrencyCode,
    // * Load data function.
    required this.loadChartData,
    // * Action Button.
    required this.showActionButton,
    this.actionButtonLabel,
    this.onActionButtonPressed,
  });

  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  late Future<dynamic> _dataFuture;
  bool _canReload = false;

  /// This function can be used to reload chart data.
  void _reloadChartData({required bool bypassCache}) {
    // Update the future and trigger a rebuild.
    setState(() {
      _canReload = false;
      _dataFuture = widget.loadChartData(bypassCache);
    });
  }

  // Can be used to update the state variable _canReload after future in future building is done.
  void _updateCanReload() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _canReload = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.staticChartReplacementMessage.isEmpty) _dataFuture = widget.loadChartData(false);
  }

  @override
  void didUpdateWidget(covariant CustomChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.staticChartReplacementMessage.isEmpty) {
      if (widget.reloadIndicators.isNotEmpty && listEquals(oldWidget.reloadIndicators, widget.reloadIndicators) == false) _reloadChartData(bypassCache: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convenience variable.
    final double screenWidth = MediaQuery.of(context).size.width;
    final Chart chart = widget.chart;

    return Card(
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // * Statistic title.
              if (widget.title.isNotEmpty)
                Container(
                  height: 50.0,
                  padding: EdgeInsets.only(left: 10.0, right: widget.onMenuPressed != null ? 0.0 : 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: widget.onMenuPressed != null ? screenWidth * 0.6 : null,
                          child: Text(
                            widget.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      if (widget.showReloadIcon)
                        IconButton(
                          key: const ValueKey('can_reload'),
                          icon: const Icon(
                            AppIcons.refresh,
                          ),
                          // * Only reload chart data if state is not already loading.
                          onPressed: _canReload ? () => _reloadChartData(bypassCache: true) : () {},
                        ),
                      if (widget.onMenuPressed != null)
                        IconButton(
                          key: const ValueKey('on_menu'),
                          icon: const Icon(
                            AppIcons.moreOptions,
                          ),
                          onPressed: () => widget.onMenuPressed!(),
                        ),
                    ],
                  ),
                ),
              if (widget.subtitle.isNotEmpty)
                Container(
                  width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Text(
                        widget.subtitle,
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              // * DropDownButtons.
              if (widget.dropDownButtons.isNotEmpty)
                SizedBox(
                  width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widget.dropDownButtons,
                      ),
                    ),
                  ),
                ),

              // * Chart data.
              Container(
                constraints: const BoxConstraints(minHeight: 230.0),
                child: widget.staticChartReplacementMessage.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(
                            widget.staticChartReplacementMessage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      )
                    : FutureBuilder<dynamic>(
                        future: _dataFuture,
                        builder: (context, snapshot) {
                          // * Show loading indication.
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CustomLoadingSpinner(
                                loadingMessage: widget.chart.loadingMessage,
                              ),
                            );
                          }

                          // * Add post frame callback, to avoid using set state during a build.
                          // * This is called here because in both cases (error and success) the relaod button
                          // * should be set to enabled again after future builder concludes.
                          // * These condition checks are needed because otherwise the _updateCanReload() function would fire constantly.
                          if (snapshot.connectionState == ConnectionState.done && _canReload == false) _updateCanReload();

                          // * Show failure.
                          if (snapshot.hasError || snapshot.hasData == false || snapshot.data == null) {
                            // Convenience variable.
                            final bool isFailure = snapshot.error != null && snapshot.error is Failure;

                            // Populate failure object.
                            final Failure failure = isFailure ? snapshot.error! as Failure : Failure.genericError();

                            return _buildFailure(
                              context: context,
                              failure: failure,
                              reloadChartData: () => _reloadChartData(bypassCache: true),
                            );
                          }

                          // ##################################################
                          // Loading chart succeeded
                          // ##################################################

                          // Display a Bar Chart.
                          if (chart.chartType == Chart.chartTypeBarChart) {
                            // Check if replacement message should be shown.
                            final String chartReplacementMessage = chart.getBarChartReplacementMessage(
                              barItems: snapshot.data! as BarItems,
                            );

                            // * Show Chart replacement message.
                            if (chartReplacementMessage.isNotEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Text(
                                    chartReplacementMessage,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              );
                            }

                            // * Display bar chart.
                            return CustomBarChart(
                              barItems: snapshot.data! as BarItems,
                              barChartInstruction: chart.barChartInstruction!,
                              onBarItemTap: widget.onBarItemTap,
                              screenWidth: screenWidth,
                            );
                          }

                          // Display a PieChart.
                          if (chart.chartType == Chart.chartTypePieChart) {
                            // Check if replacement message should be shown.
                            final String chartReplacementMessage = chart.getPieChartReplacementMessage(
                              pieItems: snapshot.data! as PieItems,
                            );

                            // * Show Chart replacement message.
                            if (chartReplacementMessage.isNotEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Text(
                                    chartReplacementMessage,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              );
                            }

                            // * Display pie chart.
                            return _pieChartBuilder(
                              context: context,
                              screenWidth: screenWidth,
                              pieItems: snapshot.data! as PieItems,
                              onPieItemTap: widget.onPieItemTap,
                              onPieItemLegendTap: widget.onPieItemLegendTap,
                            );
                          }

                          // Display a LineChart.
                          if (chart.chartType == Chart.chartTypeLineChart) {
                            // Check if replacement message should be shown.
                            final String chartReplacementMessage = chart.getLineChartReplacementMessage(
                              lineItems: snapshot.data! as LineItems,
                              defaultCurrencyCode: widget.defaultCurrencyCode,
                            );

                            // * Show Chart replacement message.
                            if (chartReplacementMessage.isNotEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: Text(
                                    chartReplacementMessage,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              );
                            }

                            // * Display line chart.
                            return _lineChartBuilder(
                              context: context,
                              screenWidth: screenWidth,
                              lineItems: snapshot.data! as LineItems,
                              lineChartInstruction: chart.lineChartInstruction!,
                            );
                          }

                          // * Unknown chart type.
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0, top: 10.0),
                              child: Text(
                                labels.basicLabelsUnknownChartType(),
                                style: Theme.of(context).textTheme.labelSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // * Info line.
              if (widget.infoLine.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        AppIcons.info,
                        size: 15,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: Text(
                          widget.infoLine,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.labelSmall!.color,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // * Action button.
              if (widget.showActionButton)
                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 15.0),
                  child: CustomElevatedButton(
                    label: widget.actionButtonLabel!,
                    onPressed: () => widget.onActionButtonPressed!(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Use this widget to build a Failure message.
Widget _buildFailure({required BuildContext context, required Failure failure, required Function() reloadChartData}) {
  return Padding(
    padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0, top: 10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          failure.message,
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
        CustomTextButton(
          label: labels.basicLabelsTryAgain(),
          onPressed: () => reloadChartData(),
        ),
      ],
    ),
  );
}

/// Use this widget to build a pie chart.
Widget _pieChartBuilder({required BuildContext context, required double screenWidth, required PieItems pieItems, required Function(PieItem)? onPieItemTap, required Function(PieItem, int)? onPieItemLegendTap}) {
  // Build PieChartSections.
  final List<PieChartSectionData> sections = List<PieChartSectionData>.generate(
    pieItems.items.length,
    (index) {
      // Access pie item.
      final PieItem pieItem = pieItems.items[index];

      return PieChartSectionData(
        value: pieItem.value,
        color: pieItem.color,
        title: pieItem.value < 7 ? '' : pieItem.title,
        titlePositionPercentageOffset: 1.35,
        titleStyle: Theme.of(context).textTheme.labelSmall,
        radius: 80.0,
      );
    },
  );

  // Build legend.
  final List<Widget> legend = List<Widget>.generate(
    pieItems.items.length,
    (index) {
      // Access pie item.
      final PieItem pieItem = pieItems.items[index];

      return SizedBox(
        height: 25.0,
        child: InkWell(
          onTap: onPieItemLegendTap == null || pieItem.referenceType.isEmpty ? null : () => onPieItemLegendTap(pieItem, index),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10.0),
              Container(
                height: 20.0,
                width: 20.0,
                color: pieItem.color,
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  pieItem.legendLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              const SizedBox(width: 5.0),
              if (pieItem.legendValue != 0)
                Text(
                  pieItem.legendSuffix.isEmpty ? '(${NumberFormat('###.##').format(pieItem.legendValue)})' : '(${NumberFormat('###.##').format(pieItem.legendValue)} ${pieItem.legendSuffix})',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
            ],
          ),
        ),
      );
    },
  );

  // Do not show sections if more then 8 sections are present.
  final bool showSections = sections.length < 8;

  return Column(
    children: [
      const SizedBox(height: 15.0),
      if (showSections)
        SizedBox(
          height: 250.0,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 10,
              borderData: FlBorderData(show: false),
              pieTouchData: onPieItemTap == null
                  ? PieTouchData(enabled: false)
                  : PieTouchData(
                      enabled: true,
                      touchCallback: (final FlTouchEvent event, final PieTouchResponse? response) {
                        if (event is FlTapUpEvent && response != null && response.touchedSection != null) {
                          // Access index.
                          final int index = response.touchedSection!.touchedSectionIndex;

                          // Access BarItem.
                          final PieItem item = pieItems.items[index];

                          // Report the tap.
                          onPieItemTap(item);
                        }
                      },
                    ),
              sections: sections,
            ),
          ),
        ),
      Container(
        constraints: BoxConstraints(
          maxHeight: showSections ? 160.0 : 250.0,
        ),
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...legend,
            ],
          ),
        ),
      ),
    ],
  );
}

/// Use this widget to build a line chart.
Widget _lineChartBuilder({required BuildContext context, required double screenWidth, required LineChartInstruction lineChartInstruction, required LineItems lineItems}) {
  // Build LineChartSections.
  final List<LineChartBarData> lineBarsData = List<LineChartBarData>.generate(
    lineItems.items.length,
    (index) {
      // Access line item.
      final LineItem lineItem = lineItems.items[index];

      // Get number of line items.
      final int numberOfDots = lineItem.lineDots.items.length;

      // Create Spots.
      final List<FlSpot> spots = List<FlSpot>.generate(
        numberOfDots,
        (index) {
          return FlSpot(
            lineItem.lineDots.items[index].xAxisValue,
            lineItem.lineDots.items[index].yAxisValue,
          );
        },
      );

      // Add a zero item.
      final List<FlSpot> withZero = [
        const FlSpot(0.0, 0.0),
        ...spots,
      ];

      return LineChartBarData(
        color: lineItem.color,
        barWidth: lineItem.lineWidth,
        dotData: FlDotData(
          show: lineItem.showDots,
        ),
        spots: numberOfDots == 1 ? withZero : spots,
        belowBarData: BarAreaData(
          show: lineItem.enableBelowLine,
          gradient: LinearGradient(
            colors: [
              lineItem.color,
              lineItem.color.withValues(alpha: 0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );
    },
  );

  // Build legend.
  final List<Widget> legend = List<Widget>.generate(
    lineItems.items.length,
    (index) {
      // Access line item.
      final LineItem lineItem = lineItems.items[index];

      return SizedBox(
        height: 25.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10.0),
            Container(
              height: 20.0,
              width: 20.0,
              color: lineItem.color,
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: Text(
                lineItem.legendValue == null ? lineItem.legendLabel : '${lineItem.legendLabel} (${NumberFormat('###.##').format(lineItem.legendValue)})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(width: 5.0),
          ],
        ),
      );
    },
  );

  // * Used to calculate the width of the chart to display chart in a scroll view if needed.
  final double chartWidth = lineBarsData.first.spots.length * 3.0;
  final double minWidth = screenWidth * 0.82;

  return Column(
    children: [
      const SizedBox(height: 15.0),
      SizedBox(
        height: 250.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: chartWidth < minWidth ? minWidth : chartWidth,
            padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    top: lineChartInstruction.showTopBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                    bottom: lineChartInstruction.showBottomBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                    left: lineChartInstruction.showLeftBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                    right: lineChartInstruction.showRightBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                  ),
                ),
                gridData: FlGridData(
                  drawVerticalLine: lineChartInstruction.showVerticalGridLine,
                  drawHorizontalLine: lineChartInstruction.showHorizontalGridLine,
                ),
                titlesData: FlTitlesData(
                  // * Right Titles.
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // * Top Titles.
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  // * Bottom Titles.
                  bottomTitles: AxisTitles(
                    axisNameSize: lineChartInstruction.bottomAxisName.isEmpty ? 0.0 : 25.0,
                    axisNameWidget: lineChartInstruction.bottomAxisName.isEmpty
                        ? null
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              lineChartInstruction.bottomAxisName,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  // * Left Titles.
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35.0,
                      getTitlesWidget: (value, meta) {
                        // Dont display highest item unless intervals match.
                        if (value == meta.max) {
                          final bool shouldBeDisplayed = value % meta.appliedInterval == 0;
                          if (shouldBeDisplayed == false) return const SizedBox.shrink();
                        }

                        String amount = value.toStringAsFixed(2);

                        if (value.abs() > 999999) {
                          amount = '${(value / 1000000).toStringAsFixed(2)} M';
                        } else if (value.abs() > 99999) {
                          amount = '${(value / 1000).toStringAsFixed(0)} K';
                        } else if (value.abs() > 999) {
                          amount = '${(value / 1000).toStringAsFixed(2)} K';
                        } else {
                          amount = value.toString();
                        }

                        return SideTitleWidget(
                          meta: meta,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              amount,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: const LineTouchData(enabled: false),
                lineBarsData: lineBarsData,
              ),
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(top: 15.0),
        constraints: const BoxConstraints(
          maxHeight: 160.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...legend,
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    ],
  );
}
