import 'package:equatable/equatable.dart';

// Models.
import 'chart.dart';
import '/data/models/failure.dart';
import '/data/models/charts/bar_chart/items/bar_item.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/fields/field.dart';
import '/data/models/charts/line_chart/items/line_items.dart';
import '/data/models/charts/pie_chart/items/pie_items.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import 'descriptive_chart/descriptive_value_instruction.dart';

class Charts extends Equatable {
  final List<Chart> items;

  const Charts({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```Chart``` object.
  factory Charts.initial() {
    return const Charts(
      items: [],
    );
  }

  /// This method can be used to access a chart by its id.
  /// * Returns ```null``` if chart was not found.
  Chart? getById({required String chartId}) {
    for (final Chart item in items) {
      if (item.chartId == chartId) return item;
    }

    return null;
  }

  /// This method can be used to add a ```Chart``` to ```items```.
  Charts add({required Chart chart}) {
    return Charts(
      items: [...items, chart],
    );
  }

  /// This method can be used to remove a ```Chart``` from ```items```.
  Charts remove({required Chart chart}) {
    // Init helper.
    List<Chart> helper = [];

    // Go through items and add relevant data.
    for (final Chart item in items) {
      // * exclude specified item.
      if (item.chartId == chart.chartId) continue;

      helper.add(item);
    }

    return Charts(
      items: helper,
    );
  }

  /// This method can be used to update a ```Chart``` in ```items```.
  /// * Returns ```null``` if chart was not found.
  Charts? update({required Chart updatedChart}) {
    // Init helper.
    List<Chart> helper = [];
    bool idFound = false;

    // Go through items and add relevant data.
    for (final Chart item in items) {
      // * insert specified item.
      if (item.chartId == updatedChart.chartId) {
        // Add updated object.
        helper.add(updatedChart);

        // Notify flag.
        idFound = true;

        continue;
      }

      helper.add(item);
    }

    // Return error if update was conducted on an id that does not exist in items.
    if (idFound == false) return null;

    return Charts(
      items: helper,
    );
  }

  /// This method can be used to access cached value charts.
  /// Returns ```null``` if value was not found in cache.
  Future<double?> getCachedDescriptiveValue({required Chart chart, required DescriptiveValueInstruction instruction}) async {
    for (final Chart cachedChart in items) {
      // Convenience variables.
      final bool equalChartType = cachedChart.chartType == chart.chartType;
      final bool equalField = cachedChart.filterByFieldId == chart.filterByFieldId;
      final bool equalCategory = cachedChart.filterByMeasurementCategory == chart.filterByMeasurementCategory;
      final bool equalMember = cachedChart.filterByMember == chart.filterByMember;
      final bool equalInterval = cachedChart.filterByTimeInterval == chart.filterByTimeInterval;
      final bool equalYear = cachedChart.getSelectedDateYear == chart.getSelectedDateYear;
      final bool equalInstructionType = cachedChart.cachedDescriptiveValueInstruction!.instructionType == instruction.instructionType;
      final bool equalFieldType = cachedChart.cachedDescriptiveValueInstruction!.fieldType == instruction.fieldType;

      final bool shouldUseCache = equalChartType && equalInstructionType && equalFieldType && equalField && equalCategory && equalMember && equalInterval && equalYear;

      // A cached version of this chart exists.
      if (shouldUseCache) {
        // In case this is a measurement type, do conversion if needed.
        if (cachedChart.cachedDescriptiveValueInstruction!.fieldType == Field.fieldTypeMeasurement) {
          // Convenience variable.
          final bool equalUnit = cachedChart.filterByMeasurementUnit == chart.filterByMeasurementUnit;

          // Do conversion.
          if (equalUnit == false) {
            // Calculate converted value.
            final double convertedValue = MeasurementData.getConvertedValue(
              unit: cachedChart.filterByMeasurementUnit,
              category: cachedChart.filterByMeasurementCategory,
              value: cachedChart.cachedDescriptiveValue!,
              toUnit: chart.filterByMeasurementUnit,
            );

            return convertedValue;
          }
        }

        // Return cached values.
        return cachedChart.cachedDescriptiveValue!;
      }
    }

    return null;
  }

  /// This method can be used to access cached bar items of a chart.
  /// * This method will convert the units of a measurement field if a cached chart exists where only the units differ.
  /// * Returns ```null``` if bar items were not found in cache.
  Future<BarItems?> getCachedBarItems({required Chart chart, required String selectedFieldType}) async {
    for (final Chart cachedChart in items) {
      // Convenience variables.
      final bool equalChartType = cachedChart.chartType == chart.chartType;
      final bool equalFieldType = cachedChart.barChartInstruction!.barInstruction.fieldType == chart.barChartInstruction!.barInstruction.fieldType;
      final bool equalInstruction = cachedChart.barChartInstruction!.barInstruction.instructionType == chart.barChartInstruction!.barInstruction.instructionType;
      final bool equalField = cachedChart.filterByFieldId == chart.filterByFieldId;
      final bool equalCategory = cachedChart.filterByMeasurementCategory == chart.filterByMeasurementCategory;
      final bool equalMember = cachedChart.filterByMember == chart.filterByMember;
      final bool equalInterval = cachedChart.filterByTimeInterval == chart.filterByTimeInterval;
      final bool equalYear = cachedChart.getSelectedDateYear == chart.getSelectedDateYear;

      final bool shouldUseCache = equalChartType && equalFieldType && equalInstruction && equalField && equalCategory && equalMember && equalInterval && equalYear;

      // A cached version of this chart exists.
      if (shouldUseCache) {
        // In case this is a measurement type, do conversion if needed.
        if (selectedFieldType == Field.fieldTypeMeasurement) {
          // Convenience variable.
          final bool equalUnit = cachedChart.filterByMeasurementUnit == chart.filterByMeasurementUnit;

          // Do conversion.
          if (equalUnit == false) {
            // Init helper.
            BarItems barItems = BarItems.initial();

            // Go through cached bar items and convert values.
            for (final BarItem barItem in cachedChart.cachedBarItems!.items) {
              // Calculate converted value.
              final double convertedValue = MeasurementData.getConvertedValue(
                unit: cachedChart.filterByMeasurementUnit,
                category: cachedChart.filterByMeasurementCategory,
                value: barItem.yAxisValue,
                toUnit: chart.filterByMeasurementUnit,
              );

              // Update bar item.
              final BarItem updated = barItem.copyWith(
                topTitle: convertedValue.toStringAsFixed(2),
                yAxisValue: convertedValue,
              );

              // Add to list.
              barItems = barItems.add(barItem: updated);
            }

            return barItems;
          }
        }

        // Return cached values.
        return cachedChart.cachedBarItems;
      }
    }

    return null;
  }

  /// This method can be used to access cached pie items of a chart.
  /// * Returns ````null``` if pie items were not found in cache.
  Future<PieItems?> getCachedPieItems({required Chart chart, required String selectedFieldType}) async {
    for (final Chart cachedChart in items) {
      // Convenience variables.
      final bool equalChartType = cachedChart.chartType == chart.chartType;
      final bool equalFieldType = cachedChart.pieChartInstruction!.pieInstruction.fieldType == chart.pieChartInstruction!.pieInstruction.fieldType;
      final bool equalInstruction = cachedChart.pieChartInstruction!.pieInstruction.instructionType == chart.pieChartInstruction!.pieInstruction.instructionType;
      final bool equalField = cachedChart.filterByFieldId == chart.filterByFieldId;
      final bool equalCategory = cachedChart.filterByMeasurementCategory == chart.filterByMeasurementCategory;
      final bool equalMember = cachedChart.filterByMember == chart.filterByMember;
      final bool equalInterval = cachedChart.filterByTimeInterval == chart.filterByTimeInterval;
      final bool equalYear = cachedChart.getSelectedDateYear == chart.getSelectedDateYear;

      final bool shouldUseCache = equalChartType && equalFieldType && equalInstruction && equalField && equalCategory && equalMember && equalInterval && equalYear;

      // A cached version of this chart exists.
      if (shouldUseCache) {
        // In case this is a measurement type, do conversion if needed.
        if (selectedFieldType == Field.fieldTypeMeasurement) {
          // Convenience variable.
          final bool equalUnit = cachedChart.filterByMeasurementUnit == chart.filterByMeasurementUnit;

          // Do conversion.
          if (equalUnit == false) throw Failure.unimplemented();
        }

        // Return cached values.
        return cachedChart.cachedPieItems;
      }
    }

    return null;
  }

  /// This method can be used to access cached line items of a chart.
  /// * This method will convert the units of a measurement field if a cached chart exists where only the units differ.
  /// * Returns ```null``` if line items were not found in cache.
  Future<LineItems?> getCachedLineItems({required Chart chart, required String selectedFieldType}) async {
    for (final Chart cachedChart in items) {
      // Convenience variables.
      final bool equalChartType = cachedChart.chartType == chart.chartType;
      final bool equalFieldType = cachedChart.lineChartInstruction!.lineInstruction.fieldType == chart.lineChartInstruction!.lineInstruction.fieldType;
      final bool equalInstruction = cachedChart.lineChartInstruction!.lineInstruction.instructionType == chart.lineChartInstruction!.lineInstruction.instructionType;
      final bool equalField = cachedChart.filterByFieldId == chart.filterByFieldId;
      final bool equalCategory = cachedChart.filterByMeasurementCategory == chart.filterByMeasurementCategory;
      final bool equalMember = cachedChart.filterByMember == chart.filterByMember;
      final bool equalInterval = cachedChart.filterByTimeInterval == chart.filterByTimeInterval;
      final bool equalYear = cachedChart.getSelectedDateYear == chart.getSelectedDateYear;

      final bool shouldUseCache = equalChartType && equalFieldType && equalInstruction && equalField && equalCategory && equalMember && equalInterval && equalYear;

      // A cached version of this chart exists.
      if (shouldUseCache) {
        // In case this is a measurement type, do conversion if needed.
        if (selectedFieldType == Field.fieldTypeMeasurement) {
          // Convenience variable.
          final bool equalUnit = cachedChart.filterByMeasurementUnit == chart.filterByMeasurementUnit;

          // Do conversion.
          if (equalUnit == false) throw Failure.unimplemented();
        }

        // Return cached values.
        return cachedChart.cachedLineItems;
      }
    }

    return null;
  }

  // ######################################
  // CopyWith
  // ######################################

  Charts copyWith({
    List<Chart>? items,
  }) {
    return Charts(
      items: items ?? this.items,
    );
  }
}
