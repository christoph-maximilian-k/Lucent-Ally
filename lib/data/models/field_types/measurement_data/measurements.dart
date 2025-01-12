import 'package:equatable/equatable.dart';

// Models.
import '/data/models/field_types/measurement_data/measurement_data.dart';

class Measurements extends Equatable {
  final List<MeasurementData> items;

  const Measurements({
    required this.items,
  });

  /// This can be used to initialize a ```Measurements``` object.
  factory Measurements.initial() {
    return const Measurements(
      items: [],
    );
  }

  @override
  List<Object?> get props => [items];

  /// This method can be used to get an item by category and unit.
  /// * Returns the first pair found.
  /// * Returns ```null``` if pair was not found.
  MeasurementData? getByCategoryAndUnit({required String category, required String unit}) {
    for (final MeasurementData item in items) {
      if (item.category == category && item.unit == unit) return item;
    }

    return null;
  }

  /// This getter can be used to access the pair that was used the most often.
  /// * Only works if value of MeasurementData was used as a counter instead of the actual value.
  /// * Returns null if no data was found.
  MeasurementData? get getMostUtilized {
    // Init helper.
    double currentMax = 0.0;
    MeasurementData? mostUtilized;

    for (final MeasurementData item in items) {
      if (item.valueAsDouble > currentMax) {
        currentMax = item.valueAsDouble;
        mostUtilized = item;
      }
    }

    return mostUtilized;
  }

  // ######################################
  // Cloud
  // ######################################

  /// This method can be used to decode Measurements from request JSON.
  static Map<String, Measurements> parseMeasurementsByFieldId(data) {
    // Init helper.
    Map<String, Measurements> utilizedCategoriesAndUnits = {};

    data.forEach((key, value) {
      // Access fieldId.
      final String fieldId = key;

      // Init helper.
      List<MeasurementData> helper = [];

      for (final dynamic element in value) {
        // Access Measurement data.
        final MeasurementData measurementData = MeasurementData.initial().copyWith(
          category: element["category"],
          unit: element["unit"],
          createdAtInUtc: element['created_at_in_utc'] == null ? null : DateTime.parse(element['created_at_in_utc']),
          createdAtTimezone: element['timezone'] ?? "",
          value: element["count"].toDouble().toString(), // * In this case value is missused on purpose for count.
        );

        helper.add(measurementData);
      }

      // Create object.
      utilizedCategoriesAndUnits[fieldId] = Measurements(items: helper);
    });

    return utilizedCategoriesAndUnits;
  }

  // ######################################
  // Copy With
  // ######################################

  Measurements copyWith({
    List<MeasurementData>? items,
  }) {
    return Measurements(
      items: items ?? this.items,
    );
  }
}
