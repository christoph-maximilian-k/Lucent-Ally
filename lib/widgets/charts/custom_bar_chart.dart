import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Models.
import '/data/models/charts/bar_chart/instructions/bar_chart_instruction.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/charts/bar_chart/items/bar_item.dart';

class CustomBarChart extends StatefulWidget {
  final double screenWidth;
  final BarItems barItems;
  final BarChartInstruction barChartInstruction;
  final Function(BarItem)? onBarItemTap;

  const CustomBarChart({
    required this.screenWidth,
    required this.barItems,
    required this.barChartInstruction,
    required this.onBarItemTap,
    super.key,
  });

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  final ScrollController _scrollController = ScrollController();
  int startIndex = 0;
  int endIndex = 60;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      // Scrolled to the right, load the next set.
      setState(() {
        startIndex += 30;
        endIndex = (startIndex + 60).clamp(0, widget.barItems.items.length);
      });
    } else if (_scrollController.position.pixels <= _scrollController.position.minScrollExtent) {
      // Scrolled to the left, load the previous set.
      setState(() {
        startIndex = (startIndex - 30).clamp(0, widget.barItems.items.length);
        endIndex = (startIndex + 60).clamp(0, widget.barItems.items.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // * Calculate the max value.
    final BarItem? heighestAbsoluteBarItem = widget.barItems.getHighestAbsolutBarItem;

    // Access max y.
    final double? maxY = heighestAbsoluteBarItem?.yAxisValue.abs();

    // Calculate interval.
    final double? interval = heighestAbsoluteBarItem == null || heighestAbsoluteBarItem.yAxisValue == 0 ? null : heighestAbsoluteBarItem.yAxisValue.abs() * 0.5;

    // Bartouch data.
    final BarTouchData barTouchData = widget.onBarItemTap == null
        ? BarTouchData(enabled: false)
        : BarTouchData(
            enabled: true,
            allowTouchBarBackDraw: false,
            handleBuiltInTouches: false,
            touchCallback: (final FlTouchEvent event, final BarTouchResponse? response) {
              if (event is FlTapUpEvent && response != null && response.spot != null) {
                // Access index.
                final int index = response.spot!.spot.x.toInt();

                // Access BarItem.
                final BarItem item = widget.barItems.items[index];

                // Report the tap.
                widget.onBarItemTap!(item);
              }
            },
          );

    // Create bar rods.
    final List<BarChartRodData> rodData = widget.barItems.items.map((barItem) {
      return BarChartRodData(
        toY: barItem.yAxisValue,
        width: barItem.barWidth,
        color: barItem.barColor,
        borderRadius: BorderRadius.only(
          topLeft: barItem.yAxisValue < 0 ? Radius.zero : const Radius.circular(2.0),
          topRight: barItem.yAxisValue < 0 ? Radius.zero : const Radius.circular(2.0),
          bottomLeft: barItem.yAxisValue < 0 ? const Radius.circular(2.0) : Radius.zero,
          bottomRight: barItem.yAxisValue < 0 ? const Radius.circular(2.0) : Radius.zero,
        ),
      );
    }).toList();

    // Map each rod to its group with a unique x value.
    final List<BarChartGroupData> groupData = List.generate(
      rodData.length,
      (index) {
        return BarChartGroupData(
          x: index,
          barRods: [rodData[index]],
        );
      },
    );

    // * Used to calculate the width of the chart to display chart in a scroll view if needed.
    final double chartWidth = groupData.length * 20;
    final double minWidth = widget.screenWidth * 0.794;

    return Column(
      children: [
        SizedBox(height: widget.barChartInstruction.showTopTitles ? 10.0 : 25.0),
        Container(
          height: 260.0,
          margin: const EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
          child: groupData.length < 40
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: chartWidth < minWidth ? minWidth : chartWidth,
                    padding: EdgeInsets.only(left: 4.0),
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            top: widget.barChartInstruction.showTopBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                            bottom: widget.barChartInstruction.showBottomBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                            left: widget.barChartInstruction.showLeftBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                            right: widget.barChartInstruction.showRightBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                          ),
                        ),
                        gridData: FlGridData(
                          drawVerticalLine: widget.barChartInstruction.showVerticalGridLine,
                          drawHorizontalLine: widget.barChartInstruction.showHorizontalGridLine,
                        ),
                        titlesData: FlTitlesData(
                          // * Left Titles.
                          leftTitles: AxisTitles(
                            axisNameSize: widget.barChartInstruction.leftAxisName.isEmpty ? 0.0 : 25.0,
                            axisNameWidget: widget.barChartInstruction.leftAxisName.isEmpty
                                ? null
                                : FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.barChartInstruction.leftAxisName,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ),
                            sideTitles: widget.barChartInstruction.staticLeftTitles.isNotEmpty
                                ? SideTitles(
                                    reservedSize: 30.0,
                                    showTitles: true,
                                    interval: interval,
                                    getTitlesWidget: (value, meta) {
                                      // Get title.
                                      final String? title = widget.barChartInstruction.getTitleByPosition(
                                        position: value.toInt(),
                                      );

                                      // Display nothing.
                                      if (title == null || title.isEmpty) {
                                        return SideTitleWidget(
                                          meta: meta,
                                          child: const SizedBox.shrink(),
                                        );
                                      }

                                      return SideTitleWidget(
                                        meta: meta,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            title,
                                            style: TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : SideTitles(
                                    showTitles: widget.barChartInstruction.showLeftTitles,
                                    reservedSize: 30,
                                    // * It seems like interval has to be positive.
                                    interval: heighestAbsoluteBarItem == null || heighestAbsoluteBarItem.yAxisValue == 0 ? null : heighestAbsoluteBarItem.yAxisValue.abs() * 0.5,
                                    getTitlesWidget: (value, meta) {
                                      String amount = value.toStringAsFixed(2);

                                      if (value.abs() > 999) amount = '${(value / 1000).toStringAsFixed(2)} K';
                                      if (value.abs() > 99999) amount = '${(value / 1000).toStringAsFixed(0)} K';
                                      if (value.abs() > 999999) amount = '${(value / 1000000).toStringAsFixed(2)} M';

                                      return SideTitleWidget(
                                        meta: meta,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            amount,
                                            style: TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          // * Right Titles.
                          rightTitles: AxisTitles(
                            axisNameSize: widget.barChartInstruction.rightAxisName.isEmpty ? 0.0 : 25.0,
                            axisNameWidget: widget.barChartInstruction.rightAxisName.isEmpty
                                ? null
                                : FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.barChartInstruction.rightAxisName,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ),
                            sideTitles: SideTitles(
                              showTitles: widget.barChartInstruction.showRightTitles,
                              reservedSize: 25,
                              getTitlesWidget: (value, meta) {
                                // * Access BarItem.
                                final BarItem barItem = widget.barItems.items[value.toInt()];

                                return SideTitleWidget(
                                  meta: meta,
                                  child: barItem.rightTitle.isEmpty
                                      ? const SizedBox.shrink()
                                      : FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            barItem.rightTitle,
                                            style: TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                          // * Top Titles.
                          topTitles: AxisTitles(
                            axisNameSize: widget.barChartInstruction.topAxisName.isEmpty ? 0.0 : 25.0,
                            axisNameWidget: widget.barChartInstruction.topAxisName.isEmpty
                                ? null
                                : FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.barChartInstruction.topAxisName,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ),
                            sideTitles: SideTitles(
                              showTitles: widget.barChartInstruction.showTopTitles,
                              reservedSize: 45.0,
                              getTitlesWidget: (value, meta) {
                                // * Access BarItem.
                                final BarItem barItem = widget.barItems.items[value.toInt()];

                                final bool shouldTransform = double.tryParse(barItem.topTitle) != null;
                                String transformed = barItem.topTitle;

                                if (shouldTransform) {
                                  if (double.parse(barItem.topTitle).abs() > 9999) transformed = '${(double.parse(barItem.topTitle) / 1000).toStringAsFixed(2)} K';
                                  if (double.parse(barItem.topTitle).abs() > 99999) transformed = '${(double.parse(barItem.topTitle) / 1000).toStringAsFixed(0)} K';
                                  if (double.parse(barItem.topTitle).abs() > 999999) transformed = '${(double.parse(barItem.topTitle) / 1000000).toStringAsFixed(2)} M';
                                }

                                return SideTitleWidget(
                                  meta: meta,
                                  angle: -math.pi / 2,
                                  space: 18.0,
                                  child: barItem.topTitle.isEmpty
                                      ? const SizedBox.shrink()
                                      : Container(
                                          constraints: BoxConstraints(maxWidth: 45.0),
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            shouldTransform ? transformed : barItem.topTitle,
                                            style: TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                          // * Bottom Titles.
                          bottomTitles: AxisTitles(
                            axisNameSize: widget.barChartInstruction.bottomAxisName.isEmpty ? 0.0 : 25.0,
                            axisNameWidget: widget.barChartInstruction.bottomAxisName.isEmpty
                                ? null
                                : FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.barChartInstruction.bottomAxisName,
                                      style: Theme.of(context).textTheme.labelSmall,
                                    ),
                                  ),
                            sideTitles: SideTitles(
                              showTitles: widget.barChartInstruction.showBottomTitles,
                              reservedSize: 80.0,
                              getTitlesWidget: (value, meta) {
                                // * Access BarItem.
                                final BarItem barItem = widget.barItems.items[value.toInt()];

                                final bool shouldTransform = double.tryParse(barItem.bottomTitle) != null;
                                String transformed = barItem.bottomTitle;

                                if (shouldTransform) {
                                  if (double.parse(barItem.bottomTitle).abs() > 9999) transformed = '${(double.parse(barItem.bottomTitle) / 1000).toStringAsFixed(2)} K';
                                  if (double.parse(barItem.bottomTitle).abs() > 99999) transformed = '${(double.parse(barItem.bottomTitle) / 1000).toStringAsFixed(0)} K';
                                  if (double.parse(barItem.bottomTitle).abs() > 999999) transformed = '${(double.parse(barItem.bottomTitle) / 1000000).toStringAsFixed(2)} M';
                                }

                                return SideTitleWidget(
                                  meta: meta,
                                  angle: -math.pi / 2,
                                  space: 34.0,
                                  child: barItem.bottomTitle.isEmpty
                                      ? const SizedBox.shrink()
                                      : Container(
                                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                          constraints: const BoxConstraints(maxWidth: 80.0, minWidth: 80.0),
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            shouldTransform ? transformed : barItem.bottomTitle,
                                            style: TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ),
                        barTouchData: barTouchData,
                        barGroups: groupData,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: groupData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // Convenience varibales.
                    final bool isFirstGroup = index == 0;
                    final bool isLastGroup = index == groupData.length - 1;

                    return Container(
                      width: isFirstGroup ? 58 : 20,
                      padding: EdgeInsets.only(left: isFirstGroup ? 4.0 : 0.0),
                      child: BarChart(
                        BarChartData(
                          maxY: maxY,
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              top: widget.barChartInstruction.showTopBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                              bottom: widget.barChartInstruction.showBottomBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                              left: isFirstGroup && widget.barChartInstruction.showLeftBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                              right: isLastGroup && widget.barChartInstruction.showRightBorder ? BorderSide(width: 0.5, color: Theme.of(context).colorScheme.onSurface) : BorderSide.none,
                            ),
                          ),
                          gridData: FlGridData(
                            drawVerticalLine: widget.barChartInstruction.showVerticalGridLine,
                            drawHorizontalLine: widget.barChartInstruction.showHorizontalGridLine,
                          ),
                          titlesData: FlTitlesData(
                            // * Left Titles.
                            leftTitles: AxisTitles(
                              axisNameSize: isFirstGroup
                                  ? widget.barChartInstruction.leftAxisName.isEmpty
                                      ? 0.0
                                      : 25.0
                                  : 0.0,
                              axisNameWidget: isFirstGroup
                                  ? widget.barChartInstruction.leftAxisName.isEmpty
                                      ? null
                                      : FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            widget.barChartInstruction.leftAxisName,
                                            style: Theme.of(context).textTheme.labelSmall,
                                          ),
                                        )
                                  : null,
                              sideTitles: widget.barChartInstruction.staticLeftTitles.isNotEmpty
                                  ? SideTitles(
                                      reservedSize: 30.0,
                                      showTitles: isFirstGroup,
                                      interval: interval,
                                      getTitlesWidget: (value, meta) {
                                        // Get title.
                                        final String? title = widget.barChartInstruction.getTitleByPosition(
                                          position: value.toInt(),
                                        );

                                        // Display nothing.
                                        if (title == null || title.isEmpty) {
                                          return SideTitleWidget(
                                            meta: meta,
                                            child: const SizedBox.shrink(),
                                          );
                                        }

                                        return SideTitleWidget(
                                          meta: meta,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : SideTitles(
                                      showTitles: isFirstGroup && widget.barChartInstruction.showLeftTitles,
                                      reservedSize: 30,
                                      // * It seems like interval has to be positive.
                                      interval: heighestAbsoluteBarItem == null || heighestAbsoluteBarItem.yAxisValue == 0 ? null : heighestAbsoluteBarItem.yAxisValue.abs() * 0.5,
                                      getTitlesWidget: (value, meta) {
                                        String amount = value.toStringAsFixed(2);

                                        if (value.abs() > 999) amount = '${(value / 1000).toStringAsFixed(2)} K';
                                        if (value.abs() > 99999) amount = '${(value / 1000).toStringAsFixed(0)} K';
                                        if (value.abs() > 999999) amount = '${(value / 1000000).toStringAsFixed(2)} M';

                                        return SideTitleWidget(
                                          meta: meta,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              amount,
                                              style: TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            // * Right Titles.
                            rightTitles: AxisTitles(
                              axisNameSize: widget.barChartInstruction.rightAxisName.isEmpty ? 0.0 : 25.0,
                              axisNameWidget: widget.barChartInstruction.rightAxisName.isEmpty
                                  ? null
                                  : FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        widget.barChartInstruction.rightAxisName,
                                        style: Theme.of(context).textTheme.labelSmall,
                                      ),
                                    ),
                              sideTitles: SideTitles(
                                showTitles: widget.barChartInstruction.showRightTitles,
                                reservedSize: 25,
                                getTitlesWidget: (value, meta) {
                                  // * Access BarItem.
                                  final BarItem barItem = widget.barItems.items[value.toInt()];

                                  return SideTitleWidget(
                                    meta: meta,
                                    child: barItem.rightTitle.isEmpty
                                        ? const SizedBox.shrink()
                                        : FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              barItem.rightTitle,
                                              style: TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                            // * Top Titles.
                            topTitles: AxisTitles(
                              axisNameSize: widget.barChartInstruction.topAxisName.isEmpty ? 0.0 : 25.0,
                              axisNameWidget: widget.barChartInstruction.topAxisName.isEmpty
                                  ? null
                                  : FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        widget.barChartInstruction.topAxisName,
                                        style: Theme.of(context).textTheme.labelSmall,
                                      ),
                                    ),
                              sideTitles: SideTitles(
                                showTitles: widget.barChartInstruction.showTopTitles,
                                reservedSize: 45.0,
                                getTitlesWidget: (value, meta) {
                                  // * Access BarItem.
                                  final BarItem barItem = widget.barItems.items[value.toInt()];

                                  final bool shouldTransform = double.tryParse(barItem.topTitle) != null;
                                  String transformed = barItem.topTitle;

                                  if (shouldTransform) {
                                    if (double.parse(barItem.topTitle).abs() > 9999) transformed = '${(double.parse(barItem.topTitle) / 1000).toStringAsFixed(2)} K';
                                    if (double.parse(barItem.topTitle).abs() > 99999) transformed = '${(double.parse(barItem.topTitle) / 1000).toStringAsFixed(0)} K';
                                    if (double.parse(barItem.topTitle).abs() > 999999) transformed = '${(double.parse(barItem.topTitle) / 1000000).toStringAsFixed(2)} M';
                                  }

                                  return SideTitleWidget(
                                    meta: meta,
                                    angle: -math.pi / 2,
                                    space: 18.0,
                                    child: barItem.topTitle.isEmpty
                                        ? const SizedBox.shrink()
                                        : Container(
                                            constraints: BoxConstraints(maxWidth: 45.0),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              shouldTransform ? transformed : barItem.topTitle,
                                              style: TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                            // * Bottom Titles.
                            bottomTitles: AxisTitles(
                              axisNameSize: widget.barChartInstruction.bottomAxisName.isEmpty ? 0.0 : 25.0,
                              axisNameWidget: widget.barChartInstruction.bottomAxisName.isEmpty
                                  ? null
                                  : FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        widget.barChartInstruction.bottomAxisName,
                                        style: Theme.of(context).textTheme.labelSmall,
                                      ),
                                    ),
                              sideTitles: SideTitles(
                                showTitles: widget.barChartInstruction.showBottomTitles,
                                reservedSize: 80.0,
                                getTitlesWidget: (value, meta) {
                                  // * Access BarItem.
                                  final BarItem barItem = widget.barItems.items[value.toInt()];

                                  final bool shouldTransform = double.tryParse(barItem.bottomTitle) != null;
                                  String transformed = barItem.bottomTitle;

                                  if (shouldTransform) {
                                    if (double.parse(barItem.bottomTitle).abs() > 9999) transformed = '${(double.parse(barItem.bottomTitle) / 1000).toStringAsFixed(2)} K';
                                    if (double.parse(barItem.bottomTitle).abs() > 99999) transformed = '${(double.parse(barItem.bottomTitle) / 1000).toStringAsFixed(0)} K';
                                    if (double.parse(barItem.bottomTitle).abs() > 999999) transformed = '${(double.parse(barItem.bottomTitle) / 1000000).toStringAsFixed(2)} M';
                                  }

                                  return SideTitleWidget(
                                    meta: meta,
                                    angle: -math.pi / 2,
                                    space: 34.0,
                                    child: barItem.bottomTitle.isEmpty
                                        ? const SizedBox.shrink()
                                        : Container(
                                            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                                            constraints: const BoxConstraints(maxWidth: 80.0, minWidth: 80.0),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              shouldTransform ? transformed : barItem.bottomTitle,
                                              style: TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                          ),
                          barTouchData: barTouchData,
                          barGroups: [groupData[index]],
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (widget.barChartInstruction.showBottomTitles == false && widget.barChartInstruction.bottomAxisName.isEmpty) const SizedBox(height: 5.0),
      ],
    );
  }
}
