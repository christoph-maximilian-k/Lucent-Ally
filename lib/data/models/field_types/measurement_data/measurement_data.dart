import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// User with labels.
import '/main.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/field_types/measurement_data/measurements.dart';

// Schemas.
import '/data/models/field_types/measurement_data/schemas/db_measurement_data.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';

class MeasurementData extends Equatable {
  final String category;
  final String unit;
  final String value;

  /// This can be null in case of default.
  final DateTime? createdAtInUtc;

  /// This value can be used to save a "dumb" date as a default value.
  final String? createdAtDefaultDate;

  /// This value can be used to save a "dumb" time as a default value.
  final String? createdAtDefaultTime;

  /// This can be empty in case of default.
  final String createdAtTimezone;

  final String? importReferenceCategory;
  final String? importReferenceUnit;
  final String? importReferenceValue;
  final String? importReferenceDate;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedCategory;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedUnit;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const MeasurementData({
    required this.category,
    required this.unit,
    required this.value,
    required this.createdAtInUtc,
    required this.createdAtDefaultDate,
    required this.createdAtDefaultTime,
    required this.createdAtTimezone,
    required this.importReferenceCategory,
    required this.importReferenceUnit,
    required this.importReferenceValue,
    required this.importReferenceDate,
    required this.encryptedCategory,
    required this.encryptedUnit,
    required this.encryptedValue,
  });

  @override
  List<Object?> get props => [
        category,
        unit,
        value,
        importReferenceCategory,
        importReferenceDate,
        createdAtTimezone,
        createdAtInUtc,
        importReferenceUnit,
        importReferenceValue,
        encryptedCategory,
        encryptedUnit,
        encryptedValue,
        createdAtDefaultDate,
        createdAtDefaultTime,
      ];

  /// Initialize a new ```MeasurementData``` object.
  factory MeasurementData.initial() {
    return MeasurementData(
      category: '',
      unit: '',
      value: '',
      createdAtInUtc: null,
      createdAtDefaultDate: null,
      createdAtDefaultTime: null,
      createdAtTimezone: "",
      importReferenceCategory: null,
      importReferenceUnit: null,
      importReferenceValue: null,
      importReferenceDate: null,
      encryptedCategory: null,
      encryptedUnit: null,
      encryptedValue: null,
    );
  }

  /// This getter can be used to access occurrence in a readable format.
  /// * Assumes values are not null.
  String getCreatedAt({required bool preserveUtc, required bool date, required bool time, String dateFormat = 'yyyy-MM-dd'}) {
    // Convert value.
    final DateTime converted = HelperFunctions.convertToTimezone(
      dateTimeInUtc: createdAtInUtc!,
      timezone: createdAtTimezone,
      preserveUtc: preserveUtc,
    );

    if (date && time) return '${DateFormat(dateFormat).format(converted)} ${labels.basicLabelsAt()} ${DateFormat("HH:mm").format(converted)}';

    if (date) return DateFormat(dateFormat).format(converted);

    return DateFormat("HH:mm").format(converted);
  }

  /// This getter can be used to access timezone in a readable format.
  String getCreatedAtTimezone({required bool preserveUtc}) {
    // If the value was stored in utc, use local timezone.
    if (createdAtTimezone.isEmpty || createdAtTimezone == "UTC") {
      // If flag was set, return UTC timezone.
      if (preserveUtc) return "UTC";

      // Try and access local timezone.
      final String? localTimezone = HelperFunctions.getCurrentTimezone();

      // It seems like local timezone could not be accessed.
      if (localTimezone == null || localTimezone.isEmpty) return "UTC";

      return localTimezone;
    }

    // Otherwise return stored timezone.
    return createdAtTimezone;
  }

  /// This getter can be used to parse ```value``` to a double.
  /// * This getter assumes that value is a valid double.
  double get valueAsDouble {
    return double.parse(value);
  }

  // ##############################
  // Measure Categories
  // ##############################

  /// Category identification for a Distance measurement.
  /// ```dart
  /// static const String measureCategoryDistance = 'distance';
  /// ```
  static const String measureCategoryDistance = 'distance';

  /// Category identification for a Mass measurement.
  /// ```dart
  /// static const String measureCategoryMass = 'mass';
  /// ```
  static const String measureCategoryMass = 'mass';

  /// Category identification for a Volume measurement.
  /// ```dart
  /// static const String measureCategoryVolume = 'volume';
  /// ```
  static const String measureCategoryVolume = 'volume';

  /// Category identification for a Time measurement.
  /// ```dart
  /// static const String measureCategoryTime = 'time';
  /// ```
  static const String measureCategoryTime = 'time';

  /// Category identification for a Temperature measurement.
  /// ```dart
  /// static const String measureCategoryTemperature = 'distance';
  /// ```
  static const String measureCategoryTemperature = 'temperature';

  /// Category identification for an Area measurement.
  /// ```dart
  /// static const String measureCategoryArea = 'area';
  /// ```
  static const String measureCategoryArea = 'area';

  /// Category identification for a Velocity measurement.
  /// ```dart
  /// static const String measureCategoryVelocity = 'velocity';
  /// ```
  static const String measureCategoryVelocity = 'velocity';

  /// Category identification for an Energy measurement.
  /// ```dart
  /// static const String measureCategoryEnergy = 'energy';
  /// ```
  static const String measureCategoryEnergy = 'energy';

  /// Category identification for a Power measurement.
  /// ```dart
  /// static const String measureCategoryPower = 'power';
  /// ```
  static const String measureCategoryPower = 'power';

  /// Category identification for a Pressure measurement.
  /// ```dart
  /// static const String measureCategoryPressure = 'pressure';
  /// ```
  static const String measureCategoryPressure = 'pressure';

  /// Category identification for a Sound measurement.
  /// ```dart
  /// static const String measureCategorySound = 'sound';
  /// ```
  static const String measureCategorySound = 'sound';

  /// Category identification for a Count measurement.
  /// ```dart
  /// static const String measureCategoryCount = 'count';
  /// ```
  static const String measureCategoryCount = 'count';

  /// List of category identifications for available measurements.
  static const List<String> measurementCategories = [
    measureCategoryDistance,
    measureCategoryMass,
    measureCategoryVolume,
    measureCategoryTime,
    measureCategoryTemperature,
    measureCategoryArea,
    measureCategoryVelocity,
    measureCategoryEnergy,
    measureCategoryPower,
    measureCategoryPressure,
    measureCategorySound,
    measureCategoryCount,
  ];

  // ##############################
  // Measure Units
  // ##############################

  /// Unit identification for km.
  /// ```dart
  /// static const String measureUnitKilometer = 'km';
  /// ```
  static const String measureUnitKilometer = 'km';

  /// Unit identification for meters.
  /// ```dart
  /// static const String measureUnitMeter = 'm';
  /// ```
  static const String measureUnitMeter = 'm';

  /// Unit identification for centimeters.
  /// ```dart
  /// static const String measureUnitCentimeter = 'cm';
  /// ```
  static const String measureUnitCentimeter = 'cm';

  /// Unit identification for millimeters.
  /// ```dart
  /// static const String measureUnitMillimeter = 'mm';
  /// ```
  static const String measureUnitMillimeter = 'mm';

  /// Unit identification for tons.
  /// ```dart
  /// static const String measureUnitTon = 't';
  /// ```
  static const String measureUnitTon = 't';

  /// Unit identification for kilograms.
  /// ```dart
  /// static const String measureUnitKilogram = 'kg';
  /// ```
  static const String measureUnitKilogram = 'kg';

  /// Unit identification for grams.
  /// ```dart
  /// static const String measureUnitGram = 'g';
  /// ```
  static const String measureUnitGram = 'g';

  /// Unit identification for milligrams.
  /// ```dart
  /// static const String measureUnitMilligram = 'mg';
  /// ```
  static const String measureUnitMilligram = 'mg';

  /// Unit identification for micrograms.
  /// ```dart
  /// static const String measureUnitMicrogram = 'µg';
  /// ```
  static const String measureUnitMicrogram = 'µg';

  /// Unit identification for liters.
  /// ```dart
  /// static const String measureUnitLiter = 'L';
  /// ```
  static const String measureUnitLiter = 'L';

  /// Unit identification for milliliters.
  /// ```dart
  /// static const String measureUnitMilliliter = 'mL';
  /// ```
  static const String measureUnitMilliliter = 'mL';

  /// Unit identification for cubic meters.
  /// ```dart
  /// static const String measureUnitCubicMeter = 'm³';
  /// ```
  static const String measureUnitCubicMeter = 'm³';

  /// Unit identification for cubic centimeters.
  /// ```dart
  /// static const String measureUnitCubicCentimeter = 'cm³';
  /// ```
  static const String measureUnitCubicCentimeter = 'cm³';

  /// Unit identification for milliseconds.
  /// ```dart
  /// static const String measureUnitMillisecond = 'ms';
  /// ```
  static const String measureUnitMillisecond = 'ms';

  /// Unit identification for seconds.
  /// ```dart
  /// static const String measureUnitSecond = 's';
  /// ```
  static const String measureUnitSecond = 's';

  /// Unit identification for minutes.
  /// ```dart
  /// static const String measureUnitMinute = 'min';
  /// ```
  static const String measureUnitMinute = 'min';

  /// Unit identification for hours.
  /// ```dart
  /// static const String measureUnitHour = 'h';
  /// ```
  static const String measureUnitHour = 'h';

  /// Unit identification for days.
  /// ```dart
  /// static const String measureUnitDay = 'd';
  /// ```
  static const String measureUnitDay = 'd';

  /// Unit identification for weeks.
  /// ```dart
  /// static const String measureUnitWeek = 'wk';
  /// ```
  static const String measureUnitWeek = 'wk';

  /// Unit identification for months.
  /// ```dart
  /// static const String measureUnitMonth = 'mo';
  /// ```
  static const String measureUnitMonth = 'mo';

  /// Unit identification for years.
  /// ```dart
  /// static const String measureUnitYear = 'yr';
  /// ```
  static const String measureUnitYear = 'yr';

  /// Unit identification for degrees Celsius.
  /// ```dart
  /// static const String measureUnitCelsius = '°C';
  /// ```
  static const String measureUnitCelsius = '°C';

  /// Unit identification for degrees Fahrenheit.
  /// ```dart
  /// static const String measureUnitFahrenheit = '°F';
  /// ```
  static const String measureUnitFahrenheit = '°F';

  /// Unit identification for Kelvin.
  /// ```dart
  /// static const String measureUnitKelvin = 'K';
  /// ```
  static const String measureUnitKelvin = 'K';

  /// Unit identification for square meters.
  /// ```dart
  /// static const String measureUnitSquareMeter = 'm²';
  /// ```
  static const String measureUnitSquareMeter = 'm²';

  /// Unit identification for square kilometers.
  /// ```dart
  /// static const String measureUnitSquareKilometer = 'km²';
  /// ```
  static const String measureUnitSquareKilometer = 'km²';

  /// Unit identification for square centimeters.
  /// ```dart
  /// static const String measureUnitSquareCentimeter = 'cm²';
  /// ```
  static const String measureUnitSquareCentimeter = 'cm²';

  /// Unit identification for square millimeters.
  /// ```dart
  /// static const String measureUnitSquareMillimeter = 'mm²';
  /// ```
  static const String measureUnitSquareMillimeter = 'mm²';

  /// Unit identification for acres.
  /// ```dart
  /// static const String measureUnitAcre = 'acre';
  /// ```
  static const String measureUnitAcre = 'acre';

  /// Unit identification for meters per second.
  /// ```dart
  /// static const String measureUnitMeterPerSecond = 'm/s';
  /// ```
  static const String measureUnitMeterPerSecond = 'm/s';

  /// Unit identification for kilometers per hour.
  /// ```dart
  /// static const String measureUnitKilometerPerHour = 'km/h';
  /// ```
  static const String measureUnitKilometerPerHour = 'km/h';

  /// Unit identification for knots.
  /// ```dart
  /// static const String measureUnitKnot = 'kt';
  /// ```
  static const String measureUnitKnot = 'kt';

  /// Unit identification for joule.
  /// ```dart
  /// static const String measureUnitJoule  = 'J';
  /// ```
  static const String measureUnitJoule = 'J';

  /// Unit identification for kilojoule.
  /// ```dart
  /// static const String measureUnitKilojoule = 'kJ';
  /// ```
  static const String measureUnitKilojoule = 'kJ';

  /// Unit identification for calorie.
  /// ```dart
  /// static const String measureUnitCalorie = 'cal';
  /// ```
  static const String measureUnitCalorie = 'cal';

  /// Unit identification for kilocalorie.
  /// ```dart
  /// static const String measureUnitKilocalorie = 'kcal';
  /// ```
  static const String measureUnitKilocalorie = 'kcal';

  /// Unit identification for electronvolt.
  /// ```dart
  /// static const String measureUnitElectronvolt = 'eV';
  /// ```
  static const String measureUnitElectronvolt = 'eV';

  /// Unit identification for watt.
  /// ```dart
  /// static const String measureUnitWatt = 'W';
  /// ```
  static const String measureUnitWatt = 'W';

  /// Unit identification for kilowatt.
  /// ```dart
  /// static const String measureUnitKilowatt = 'kW';
  /// ```
  static const String measureUnitKilowatt = 'kW';

  /// Unit identification for megawatt.
  /// ```dart
  /// static const String measureUnitMegawatt = 'MW';
  /// ```
  static const String measureUnitMegawatt = 'MW';

  /// Unit identification for horsepower.
  /// ```dart
  /// static const String measureUnitHorsepower = 'hp';
  /// ```
  static const String measureUnitHorsepower = 'hp';

  /// Unit identification for pascal.
  /// ```dart
  /// static const String measureUnitPascal = 'Pa';
  /// ```
  static const String measureUnitPascal = 'Pa';

  /// Unit identification for kilopascal.
  /// ```dart
  /// static const String measureUnitKilopascal = 'kPa';
  /// ```
  static const String measureUnitKilopascal = 'kPa';

  /// Unit identification for megapascal.
  /// ```dart
  /// static const String measureUnitMegapascal = 'MPa';
  /// ```
  static const String measureUnitMegapascal = 'MPa';

  /// Unit identification for bar.
  /// ```dart
  /// static const String measureUnitBar = 'bar';
  /// ```
  static const String measureUnitBar = 'bar';

  /// Unit identification for atmosphere.
  /// ```dart
  /// static const String measureUnitAtmosphere = 'atm';
  /// ```
  static const String measureUnitAtmosphere = 'atm';

  /// Unit identification for decibel.
  /// ```dart
  /// static const String measureUnitDecibel = 'dB';
  /// ```
  static const String measureUnitDecibel = 'dB';

  /// Unit identification for count.
  /// ```dart
  /// static const String measureUnitCount = 'times';
  /// ```
  static const String measureUnitCount = 'times';

  /// List of unit identifications for available measurements.
  static const List<String> measurementUnits = [
    measureUnitKilometer,
    measureUnitMeter,
    measureUnitCentimeter,
    measureUnitMillimeter,
    measureUnitTon,
    measureUnitKilogram,
    measureUnitGram,
    measureUnitMilligram,
    measureUnitMicrogram,
    measureUnitLiter,
    measureUnitMilliliter,
    measureUnitCubicMeter,
    measureUnitCubicCentimeter,
    measureUnitMillisecond,
    measureUnitSecond,
    measureUnitMinute,
    measureUnitHour,
    measureUnitDay,
    measureUnitWeek,
    measureUnitMonth,
    measureUnitYear,
    measureUnitCelsius,
    measureUnitFahrenheit,
    measureUnitKelvin,
    measureUnitSquareMeter,
    measureUnitSquareKilometer,
    measureUnitSquareCentimeter,
    measureUnitSquareMillimeter,
    measureUnitAcre,
    measureUnitMeterPerSecond,
    measureUnitKilometerPerHour,
    measureUnitKnot,
    measureUnitJoule,
    measureUnitKilojoule,
    measureUnitCalorie,
    measureUnitKilocalorie,
    measureUnitElectronvolt,
    measureUnitWatt,
    measureUnitKilowatt,
    measureUnitMegawatt,
    measureUnitHorsepower,
    measureUnitPascal,
    measureUnitKilopascal,
    measureUnitMegapascal,
    measureUnitBar,
    measureUnitAtmosphere,
    measureUnitDecibel,
    measureUnitCount,
  ];

  /// This method can be used to translate a given category to english.
  /// * This is used by import to ensure that provided categories are valid in different categories.
  /// * Returns null on error.
  static String? mapCategoryToEnglish({required String? category}) {
    // Invalid category.
    if (category == null || category.trim().isEmpty) return null;

    // Convenience variables.
    final String converted = category.trim().toLowerCase();

    // Mappings.
    if (["länge", "distanz", "longueur", "distance", "length", "distanza", "longitud", "lunghezza"].contains(converted)) return measureCategoryDistance;
    if (["gewicht", "weight", "poids", "peso", "massa", "masse"].contains(converted)) return measureCategoryMass;
    if (["volumen", "volume", "volumen", "capacité", "capacità"].contains(converted)) return measureCategoryVolume;
    if (["zeit", "temps", "tiempo", "time", "tempo"].contains(converted)) return measureCategoryTime;
    if (["temperatur", "température", "temperatura", "temperature", "temperatura"].contains(converted)) return measureCategoryTemperature;
    if (["fläche", "surface", "aire", "superficie", "area", "superfice"].contains(converted)) return measureCategoryArea;
    if (["geschwindigkeit", "vitesse", "velocidad", "velocity", "speed", "velocità"].contains(converted)) return measureCategoryVelocity;
    if (["energie", "énergie", "energía", "energy", "energia"].contains(converted)) return measureCategoryEnergy;
    if (["leistung", "puissance", "potenza", "power"].contains(converted)) return measureCategoryPower;
    if (["druck", "pression", "presión", "pressure", "pressione"].contains(converted)) return measureCategoryPressure;
    if (["lautstärke", "volume sonore", "son", "suono", "sound", "suono", "volumen sonoro"].contains(converted)) return measureCategorySound;
    if (["anzahl", "quantité", "nombre", "cantidad", "count", "numero"].contains(converted)) return measureCategoryCount;

    return converted;
  }

  /// This method can be used to check if a given category is valid, i.e. known.
  static bool isValidCategory({required String? category}) {
    // No category provided.
    if (category == null || category.isEmpty) return false;

    // Check if provided category is in available categories.
    if (measurementCategories.contains(category.trim().toLowerCase())) return true;

    return false;
  }

  /// This method can be used to check if a given unit is valid, i.e. known.
  static bool isValidUnit({required String? unit}) {
    // No category provided.
    if (unit == null || unit.isEmpty) return false;

    // Check if provided category is in available categories.
    if (measurementUnits.contains(unit.trim().toLowerCase())) return true;

    return false;
  }

  /// This method can be used to access Categories and their translations.
  static Map<String, String> categoriesByTypeAndLanguage() {
    return {
      measureCategoryDistance: labels.measureCategoryDistance(),
      measureCategoryMass: labels.measureCategoryMass(),
      measureCategoryVolume: labels.measureCategoryVolume(),
      measureCategoryTime: labels.measureCategoryTime(),
      measureCategoryTemperature: labels.measureCategoryTemperature(),
      measureCategoryArea: labels.measureCategoryArea(),
      measureCategoryVelocity: labels.measureCategoryVelocity(),
      measureCategoryEnergy: labels.measureCategoryEnergy(),
      measureCategoryPower: labels.measureCategoryPower(),
      measureCategoryPressure: labels.measureCategoryPressure(),
      measureCategorySound: labels.measureCategorySound(),
      measureCategoryCount: labels.measureCategoryCount(),
    };
  }

  /// This getter can be used to access categories as PickerItems.
  static PickerItems categoriesAsPickerItems() {
    return PickerItems(
      items: [
        PickerItem(
          id: measureCategoryDistance,
          label: labels.measureCategoryDistance(),
        ),
        PickerItem(
          id: measureCategoryMass,
          label: labels.measureCategoryMass(),
        ),
        PickerItem(
          id: measureCategoryVolume,
          label: labels.measureCategoryVolume(),
        ),
        PickerItem(
          id: measureCategoryTime,
          label: labels.measureCategoryTime(),
        ),
        PickerItem(
          id: measureCategoryTemperature,
          label: labels.measureCategoryTemperature(),
        ),
        PickerItem(
          id: measureCategoryArea,
          label: labels.measureCategoryArea(),
        ),
        PickerItem(
          id: measureCategoryVelocity,
          label: labels.measureCategoryVelocity(),
        ),
        PickerItem(
          id: measureCategoryEnergy,
          label: labels.measureCategoryEnergy(),
        ),
        PickerItem(
          id: measureCategoryPower,
          label: labels.measureCategoryPower(),
        ),
        PickerItem(
          id: measureCategoryPressure,
          label: labels.measureCategoryPressure(),
        ),
        PickerItem(
          id: measureCategorySound,
          label: labels.measureCategorySound(),
        ),
        PickerItem(
          id: measureCategoryCount,
          label: labels.measureCategoryCount(),
        ),
      ],
    );
  }

  /// This method can be used to access relevant categories as PickerItems depending on supplied fieldId and utilized category/unit pairs.
  static PickerItems getRelevantCategories({required String filterByFieldId, required Map<String, Measurements> utilizedCategoriesAndUnits}) {
    // Convenience variables.
    final PickerItems allCategories = MeasurementData.categoriesAsPickerItems();

    // Create helper.
    PickerItems relevantCategories = PickerItems.initial();

    // A field id exist. Only categories available for this field id are relevant.
    if (filterByFieldId.isNotEmpty) {
      // Access relevant Measurements.
      final Measurements? relevantMeasurements = utilizedCategoriesAndUnits[filterByFieldId];

      // * If this is null, which happens if PickerItem.identificationAllFieldsOfType was selected, return all available categories.
      if (relevantMeasurements == null) return allCategories;

      // Go through picker items and select those that are relevant.
      for (final MeasurementData data in relevantMeasurements.items) {
        // Get PickerItem for category.
        // * This should never be null. If it is null a bug exists and this method should fail.
        final PickerItem pickerItem = allCategories.getById(id: data.category)!;

        // Check if this category was already added to helper list.
        final bool exists = relevantCategories.getById(id: data.category) != null;

        // This category already exists and does not need to be added again.
        if (exists) continue;

        relevantCategories = relevantCategories.add(pickerItem: pickerItem);
      }

      return relevantCategories;
    }

    // A field id does not exist. Display all categories found in utilizedCategoriesAndUnits.
    utilizedCategoriesAndUnits.forEach((key, value) {
      // Go through measurements and add categories to helper.
      for (final MeasurementData item in value.items) {
        // Get PickerItem for category.
        // * This should never be null. If it is null a bug exists and this method should fail.
        final PickerItem pickerItem = allCategories.getById(id: item.category)!;

        // Check if this category was already added to helper list.
        final bool exists = relevantCategories.getById(id: item.category) != null;

        // This category already exists and does not need to be added again.
        if (exists) continue;

        relevantCategories = relevantCategories.add(pickerItem: pickerItem);
      }
    });

    return relevantCategories;
  }

  /// This method can be used to access the most used unit of provided category.
  /// * This only works if the value of MeasurementData was used to count the number of unit occurances.
  static String getMostRelevantUnit({required Map<String, Measurements> utilizedCategoriesAndUnits, required String category}) {
    // Init helpers.
    double max = 0.0;
    String unit = '';

    // A field id does not exist. Display all categories found in utilizedCategoriesAndUnits.
    utilizedCategoriesAndUnits.forEach((key, value) {
      // Go through measurements and add categories to helper.
      for (final MeasurementData item in value.items) {
        // Category was not found, continue with next item.
        if (item.category != category) continue;

        if (item.valueAsDouble > max) {
          max = item.valueAsDouble;
          unit = item.unit;
        }
      }
    });

    return unit;
  }

  /// This getter can be used to access units of category as PickerItems.
  /// * Returns ```null``` if category was not found.
  static PickerItems? unitsAsPickerItems({required String category}) {
    // * Return distance units.
    if (category == measureCategoryDistance) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitKilometer,
            label: measureUnitKilometer,
          ),
          PickerItem(
            id: measureUnitMeter,
            label: measureUnitMeter,
          ),
          PickerItem(
            id: measureUnitCentimeter,
            label: measureUnitCentimeter,
          ),
          PickerItem(
            id: measureUnitMillimeter,
            label: measureUnitMillimeter,
          ),
        ],
      );
    }

    // * Return mass units.
    if (category == measureCategoryMass) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitTon,
            label: measureUnitTon,
          ),
          PickerItem(
            id: measureUnitKilogram,
            label: measureUnitKilogram,
          ),
          PickerItem(
            id: measureUnitGram,
            label: measureUnitGram,
          ),
          PickerItem(
            id: measureUnitMilligram,
            label: measureUnitMilligram,
          ),
          PickerItem(
            id: measureUnitMicrogram,
            label: measureUnitMicrogram,
          ),
        ],
      );
    }

    // * Return volume units.
    if (category == measureCategoryVolume) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitLiter,
            label: measureUnitLiter,
          ),
          PickerItem(
            id: measureUnitMilliliter,
            label: measureUnitMilliliter,
          ),
          PickerItem(
            id: measureUnitCubicMeter,
            label: measureUnitCubicMeter,
          ),
          PickerItem(
            id: measureUnitCubicCentimeter,
            label: measureUnitCubicCentimeter,
          ),
        ],
      );
    }

    // * Return time units.
    if (category == measureCategoryTime) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitMillisecond,
            label: measureUnitMillisecond,
          ),
          PickerItem(
            id: measureUnitSecond,
            label: measureUnitSecond,
          ),
          PickerItem(
            id: measureUnitMinute,
            label: measureUnitMinute,
          ),
          PickerItem(
            id: measureUnitHour,
            label: measureUnitHour,
          ),
          PickerItem(
            id: measureUnitDay,
            label: measureUnitDay,
          ),
          PickerItem(
            id: measureUnitWeek,
            label: measureUnitWeek,
          ),
          PickerItem(
            id: measureUnitMonth,
            label: measureUnitMonth,
          ),
          PickerItem(
            id: measureUnitYear,
            label: measureUnitYear,
          ),
        ],
      );
    }

    // * Return temperature units.
    if (category == measureCategoryTemperature) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitCelsius,
            label: measureUnitCelsius,
          ),
          PickerItem(
            id: measureUnitFahrenheit,
            label: measureUnitFahrenheit,
          ),
          PickerItem(
            id: measureUnitKelvin,
            label: measureUnitKelvin,
          ),
        ],
      );
    }

    // * Return area units.
    if (category == measureCategoryArea) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitSquareMeter,
            label: measureUnitSquareMeter,
          ),
          PickerItem(
            id: measureUnitSquareKilometer,
            label: measureUnitSquareKilometer,
          ),
          PickerItem(
            id: measureUnitSquareCentimeter,
            label: measureUnitSquareCentimeter,
          ),
          PickerItem(
            id: measureUnitSquareMillimeter,
            label: measureUnitSquareMillimeter,
          ),
          PickerItem(
            id: measureUnitAcre,
            label: measureUnitAcre,
          ),
        ],
      );
    }

    // * Return velocity units.
    if (category == measureCategoryVelocity) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitMeterPerSecond,
            label: measureUnitMeterPerSecond,
          ),
          PickerItem(
            id: measureUnitKilometerPerHour,
            label: measureUnitKilometerPerHour,
          ),
          PickerItem(
            id: measureUnitKnot,
            label: measureUnitKnot,
          ),
        ],
      );
    }

    // * Return energy units.
    if (category == measureCategoryEnergy) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitJoule,
            label: measureUnitJoule,
          ),
          PickerItem(
            id: measureUnitKilojoule,
            label: measureUnitKilojoule,
          ),
          PickerItem(
            id: measureUnitCalorie,
            label: measureUnitCalorie,
          ),
          PickerItem(
            id: measureUnitKilocalorie,
            label: measureUnitKilocalorie,
          ),
          PickerItem(
            id: measureUnitElectronvolt,
            label: measureUnitElectronvolt,
          ),
        ],
      );
    }

    // * Return power units.
    if (category == measureCategoryPower) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitWatt,
            label: measureUnitWatt,
          ),
          PickerItem(
            id: measureUnitKilowatt,
            label: measureUnitKilowatt,
          ),
          PickerItem(
            id: measureUnitMegawatt,
            label: measureUnitMegawatt,
          ),
          PickerItem(
            id: measureUnitHorsepower,
            label: measureUnitHorsepower,
          ),
        ],
      );
    }

    // * Return pressure units.
    if (category == measureCategoryPressure) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitPascal,
            label: measureUnitPascal,
          ),
          PickerItem(
            id: measureUnitKilopascal,
            label: measureUnitKilopascal,
          ),
          PickerItem(
            id: measureUnitMegapascal,
            label: measureUnitMegapascal,
          ),
          PickerItem(
            id: measureUnitBar,
            label: measureUnitBar,
          ),
          PickerItem(
            id: measureUnitAtmosphere,
            label: measureUnitAtmosphere,
          ),
        ],
      );
    }

    // * Return sound units.
    if (category == measureCategorySound) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitDecibel,
            label: measureUnitDecibel,
          ),
        ],
      );
    }

    // * Return count units.
    if (category == measureCategoryCount) {
      return const PickerItems(
        items: [
          PickerItem(
            id: measureUnitCount,
            label: measureUnitCount,
          ),
        ],
      );
    }

    return null;
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required MeasurementData? measurementData, required bool isDefault, required bool isImport}) {
    // Exclude if no value was set.
    if (measurementData == null) return false;

    // Check unit and category.
    final bool hasCategory = measurementData.category.trim().isNotEmpty;
    final bool hasUnit = measurementData.unit.trim().isNotEmpty;
    final bool hasValue = measurementData.value.trim().isNotEmpty;
    final bool hasDate = measurementData.createdAtInUtc != null;
    final bool hasTimezone = measurementData.createdAtTimezone.isNotEmpty;

    final bool hasDefaultDate = measurementData.createdAtDefaultDate != null && measurementData.createdAtDefaultDate!.isNotEmpty;
    final bool hasDefaultTime = measurementData.createdAtDefaultTime != null && measurementData.createdAtDefaultTime!.isNotEmpty;

    // Check if refs were set.
    final bool hasValueRef = measurementData.importReferenceValue != null && measurementData.importReferenceValue!.trim().isNotEmpty;
    final bool hasUnitRef = measurementData.importReferenceUnit != null && measurementData.importReferenceUnit!.trim().isNotEmpty;
    final bool hasCategoryRef = measurementData.importReferenceCategory != null && measurementData.importReferenceCategory!.trim().isNotEmpty;

    // * User is in default mode.
    if (isDefault) {
      // If any value is set, return true.
      // * In default date should be null because defaultDate and defaultTime should be used.
      return [
        hasCategory,
        hasDefaultDate,
        hasDefaultTime,
        hasTimezone,
      ].any((condition) => condition);
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import reference.
      if (hasValueRef && hasCategoryRef && hasUnitRef) return true;

      // User set refs and required defaults.
      if (hasCategoryRef && hasValue && hasUnit) return true;

      // User set refs and required defaults.
      if (hasCategoryRef && hasUnitRef && hasValue) return true;

      // User set a value ref and required default values.
      if (hasValueRef && hasCategory && hasUnit) return true;

      // User set a value ref and required default values.
      if (hasValueRef && hasCategoryRef && hasUnit) return true;

      // * User might also have set more default values but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // All fields are set.
    if (hasValue && hasCategory && hasUnit && hasDate && hasTimezone) return true;

    // Only value and category are set.
    // * Return true to be able to warn user about missing unit.
    if (hasValue && hasCategory && hasUnit == false) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required MeasurementData? measurementData}) {
    if (measurementData == null) return null;
    if (measurementData.category.isEmpty) return null;
    if (measurementData.unit.isEmpty) return null;

    return '${measurementData.value} ${measurementData.unit}';
  }

  /// This getter can be used to access measurement value as string.
  String get getValue {
    return '$value $unit';
  }

  /// This method can be used to convert value to desired unit.
  static double getConvertedValue({required String unit, required String category, required double value, required String toUnit}) {
    // * If the unit is the same, do not convert.
    if (toUnit == unit) return value;

    // * Convert distance.
    if (category == measureCategoryDistance) {
      if (unit == measureUnitKilometer) {
        if (toUnit == measureUnitMeter) return value * 1000;
        if (toUnit == measureUnitCentimeter) return value * 100000;
        if (toUnit == measureUnitMillimeter) return value * 1000000;
      }

      if (unit == measureUnitMeter) {
        if (toUnit == measureUnitKilometer) return value / 1000;
        if (toUnit == measureUnitCentimeter) return value * 100;
        if (toUnit == measureUnitMillimeter) return value * 1000;
      }

      if (unit == measureUnitCentimeter) {
        if (toUnit == measureUnitKilometer) return value / 100000;
        if (toUnit == measureUnitMeter) return value / 100;
        if (toUnit == measureUnitMillimeter) return value * 10;
      }

      if (unit == measureUnitMillimeter) {
        if (toUnit == measureUnitKilometer) return value / 1000000;
        if (toUnit == measureUnitMeter) return value / 1000;
        if (toUnit == measureUnitCentimeter) return value / 10;
      }
    }

    // * Convert mass.
    if (category == measureCategoryMass) {
      if (unit == measureUnitTon) {
        if (toUnit == measureUnitKilogram) return value * 1000;
        if (toUnit == measureUnitGram) return value * 1000000;
        if (toUnit == measureUnitMilligram) return value * 1e+6;
        if (toUnit == measureUnitMicrogram) return value * 1e+9;
      }

      if (unit == measureUnitKilogram) {
        if (toUnit == measureUnitTon) return value / 1000;
        if (toUnit == measureUnitGram) return value * 1000;
        if (toUnit == measureUnitMilligram) return value * 1e+6;
        if (toUnit == measureUnitMicrogram) return value * 1e+9;
      }

      if (unit == measureUnitGram) {
        if (toUnit == measureUnitTon) return value / 1e+6;
        if (toUnit == measureUnitKilogram) return value / 1000;
        if (toUnit == measureUnitMilligram) return value * 1000;
        if (toUnit == measureUnitMicrogram) return value * 1e+6;
      }

      if (unit == measureUnitMilligram) {
        if (toUnit == measureUnitTon) return value / 1e+6;
        if (toUnit == measureUnitKilogram) return value / 1e+6;
        if (toUnit == measureUnitGram) return value / 1000;
        if (toUnit == measureUnitMicrogram) return value * 1000;
      }

      if (unit == measureUnitMicrogram) {
        if (toUnit == measureUnitTon) return value / 1e+9;
        if (toUnit == measureUnitKilogram) return value / 1e+9;
        if (toUnit == measureUnitGram) return value / 1e+6;
        if (toUnit == measureUnitMilligram) return value / 1000;
      }
    }

    // * Convert volume.
    if (category == measureCategoryVolume) {
      if (unit == measureUnitLiter) {
        if (toUnit == measureUnitMilliliter) return value * 1000;
        if (toUnit == measureUnitCubicMeter) return value * 0.001;
        if (toUnit == measureUnitCubicCentimeter) return value * 1000;
      }

      if (unit == measureUnitMilliliter) {
        if (toUnit == measureUnitLiter) return value / 1000;
        if (toUnit == measureUnitCubicMeter) return value * 1e-6;
        if (toUnit == measureUnitCubicCentimeter) return value;
      }

      if (unit == measureUnitCubicMeter) {
        if (toUnit == measureUnitLiter) return value * 1000;
        if (toUnit == measureUnitMilliliter) return value * 1e+6;
        if (toUnit == measureUnitCubicCentimeter) return value * 1e+6;
      }

      if (unit == measureUnitCubicCentimeter) {
        if (toUnit == measureUnitLiter) return value * 0.001;
        if (toUnit == measureUnitMilliliter) return value;
        if (toUnit == measureUnitCubicMeter) return value * 1e-6;
      }
    }

    // * Convert time.
    if (category == measureCategoryTime) {
      if (unit == measureUnitYear) {
        if (toUnit == measureUnitMonth) return value * 12;
        if (toUnit == measureUnitWeek) return value * 52.1775;
        if (toUnit == measureUnitDay) return value * 365.25;
        if (toUnit == measureUnitHour) return value * 8760;
        if (toUnit == measureUnitMinute) return value * 525600;
        if (toUnit == measureUnitSecond) return value * 3.1536e+7;
        if (toUnit == measureUnitMillisecond) return value * 3.1536e+10;
      }

      if (unit == measureUnitMonth) {
        if (toUnit == measureUnitYear) return value / 12;
        if (toUnit == measureUnitWeek) return value * 4.34524;
        if (toUnit == measureUnitDay) return value * 30.4368;
        if (toUnit == measureUnitHour) return value * 730.49;
        if (toUnit == measureUnitMinute) return value * 43829.1;
        if (toUnit == measureUnitSecond) return value * 2.62974e+6;
        if (toUnit == measureUnitMillisecond) return value * 2.62974e+9;
      }

      if (unit == measureUnitWeek) {
        if (toUnit == measureUnitYear) return value / 52.1775;
        if (toUnit == measureUnitMonth) return value / 4.34524;
        if (toUnit == measureUnitDay) return value * 7;
        if (toUnit == measureUnitHour) return value * 168;
        if (toUnit == measureUnitMinute) return value * 10080;
        if (toUnit == measureUnitSecond) return value * 604800;
        if (toUnit == measureUnitMillisecond) return value * 6.048e+8;
      }

      if (unit == measureUnitDay) {
        if (toUnit == measureUnitYear) return value / 365.25;
        if (toUnit == measureUnitMonth) return value / 30.4368;
        if (toUnit == measureUnitWeek) return value / 7;
        if (toUnit == measureUnitHour) return value * 24;
        if (toUnit == measureUnitMinute) return value * 1440;
        if (toUnit == measureUnitSecond) return value * 86400;
        if (toUnit == measureUnitMillisecond) return value * 8.64e+7;
      }

      if (unit == measureUnitHour) {
        if (toUnit == measureUnitYear) return value / 8760;
        if (toUnit == measureUnitMonth) return value / 730.49;
        if (toUnit == measureUnitWeek) return value / 168;
        if (toUnit == measureUnitDay) return value / 24;
        if (toUnit == measureUnitMinute) return value * 60;
        if (toUnit == measureUnitSecond) return value * 3600;
        if (toUnit == measureUnitMillisecond) return value * 3.6e+6;
      }

      if (unit == measureUnitMinute) {
        if (toUnit == measureUnitYear) return value / 525600;
        if (toUnit == measureUnitMonth) return value / 43829.1;
        if (toUnit == measureUnitWeek) return value / 10080;
        if (toUnit == measureUnitDay) return value / 1440;
        if (toUnit == measureUnitHour) return value / 60;
        if (toUnit == measureUnitSecond) return value * 60;
        if (toUnit == measureUnitMillisecond) return value * 60000;
      }

      if (unit == measureUnitSecond) {
        if (toUnit == measureUnitYear) return value / 3.1536e+7;
        if (toUnit == measureUnitMonth) return value / 2.62974e+6;
        if (toUnit == measureUnitWeek) return value / 604800;
        if (toUnit == measureUnitDay) return value / 86400;
        if (toUnit == measureUnitHour) return value / 3600;
        if (toUnit == measureUnitMinute) return value / 60;
        if (toUnit == measureUnitMillisecond) return value * 1000;
      }

      if (unit == measureUnitMillisecond) {
        if (toUnit == measureUnitYear) return value / 3.1536e+10;
        if (toUnit == measureUnitMonth) return value / 2.62974e+9;
        if (toUnit == measureUnitWeek) return value / 6.048e+8;
        if (toUnit == measureUnitDay) return value / 8.64e+7;
        if (toUnit == measureUnitHour) return value / 3.6e+6;
        if (toUnit == measureUnitMinute) return value / 60000;
        if (toUnit == measureUnitSecond) return value / 1000;
      }
    }

    // * Convert temperature.
    if (category == measureCategoryTemperature) {
      if (unit == measureUnitCelsius) {
        if (toUnit == measureUnitFahrenheit) return (value * 9 / 5) + 32;
        if (toUnit == measureUnitKelvin) return value + 273.15;
      }

      if (unit == measureUnitFahrenheit) {
        if (toUnit == measureUnitCelsius) return (value - 32) * 5 / 9;
        if (toUnit == measureUnitKelvin) return (value + 459.67) * 5 / 9;
      }

      if (unit == measureUnitKelvin) {
        if (toUnit == measureUnitCelsius) return value - 273.15;
        if (toUnit == measureUnitFahrenheit) return (value * 9 / 5) - 459.67;
      }
    }

    // * Convert area.
    if (category == measureCategoryArea) {
      if (unit == measureUnitSquareMeter) {
        if (toUnit == measureUnitSquareKilometer) return value / 1e+6;
        if (toUnit == measureUnitSquareCentimeter) return value * 1e+4;
        if (toUnit == measureUnitSquareMillimeter) return value * 1e+6;
        if (toUnit == measureUnitAcre) return value * 0.000247105;
      }

      if (unit == measureUnitSquareKilometer) {
        if (toUnit == measureUnitSquareMeter) return value * 1e+6;
        if (toUnit == measureUnitSquareCentimeter) return value * 1e+10;
        if (toUnit == measureUnitSquareMillimeter) return value * 1e+12;
        if (toUnit == measureUnitAcre) return value * 247.105;
      }

      if (unit == measureUnitSquareCentimeter) {
        if (toUnit == measureUnitSquareMeter) return value * 1e-4;
        if (toUnit == measureUnitSquareKilometer) return value * 1e-10;
        if (toUnit == measureUnitSquareMillimeter) return value * 100;
        if (toUnit == measureUnitAcre) return value * 2.47105e-8;
      }

      if (unit == measureUnitSquareMillimeter) {
        if (toUnit == measureUnitSquareMeter) return value * 1e-6;
        if (toUnit == measureUnitSquareKilometer) return value * 1e-12;
        if (toUnit == measureUnitSquareCentimeter) return value * 0.01;
        if (toUnit == measureUnitAcre) return value * 2.47105e-10;
      }

      if (unit == measureUnitAcre) {
        if (toUnit == measureUnitSquareMeter) return value * 4046.86;
        if (toUnit == measureUnitSquareKilometer) return value * 0.00404686;
        if (toUnit == measureUnitSquareCentimeter) return value * 4.04686e+7;
        if (toUnit == measureUnitSquareMillimeter) return value * 4.04686e+9;
      }
    }

    // * Convert velocity.
    if (category == measureCategoryVelocity) {
      if (unit == measureUnitMeterPerSecond) {
        if (toUnit == measureUnitKilometerPerHour) return value * 3.6;
        if (toUnit == measureUnitKnot) return value * 1.94384;
      }

      if (unit == measureUnitKilometerPerHour) {
        if (toUnit == measureUnitMeterPerSecond) return value / 3.6;
        if (toUnit == measureUnitKnot) return value / 1.852;
      }

      if (unit == measureUnitKnot) {
        if (toUnit == measureUnitMeterPerSecond) return value * 0.514444;
        if (toUnit == measureUnitKilometerPerHour) return value * 1.852;
      }
    }

    // * Convert energy.
    if (category == measureCategoryEnergy) {
      if (unit == measureUnitJoule) {
        if (toUnit == measureUnitKilojoule) return value / 1000;
        if (toUnit == measureUnitCalorie) return value / 4.184;
        if (toUnit == measureUnitKilocalorie) return value / 4184;
        if (toUnit == measureUnitElectronvolt) return value * 6.242e+18;
      }

      if (unit == measureUnitKilojoule) {
        if (toUnit == measureUnitJoule) return value * 1000;
        if (toUnit == measureUnitCalorie) return value / 4.184;
        if (toUnit == measureUnitKilocalorie) return value / 4184;
        if (toUnit == measureUnitElectronvolt) return value * 6.242e+21;
      }

      if (unit == measureUnitCalorie) {
        if (toUnit == measureUnitJoule) return value * 4.184;
        if (toUnit == measureUnitKilojoule) return value * 4.184;
        if (toUnit == measureUnitKilocalorie) return value / 1000;
        if (toUnit == measureUnitElectronvolt) return value * 2.613e+19;
      }

      if (unit == measureUnitKilocalorie) {
        if (toUnit == measureUnitJoule) return value * 4184;
        if (toUnit == measureUnitKilojoule) return value * 4184;
        if (toUnit == measureUnitCalorie) return value * 1000;
        if (toUnit == measureUnitElectronvolt) return value * 2.613e+22;
      }

      if (unit == measureUnitElectronvolt) {
        if (toUnit == measureUnitJoule) return value * 1.602e-19;
        if (toUnit == measureUnitKilojoule) return value * 1.602e-22;
        if (toUnit == measureUnitCalorie) return value * 3.829e-20;
        if (toUnit == measureUnitKilocalorie) return value * 3.829e-23;
      }
    }

    // * Convert power.
    if (category == measureCategoryPower) {
      if (unit == measureUnitWatt) {
        if (toUnit == measureUnitKilowatt) return value / 1000;
        if (toUnit == measureUnitMegawatt) return value / 1e+6;
        if (toUnit == measureUnitHorsepower) return value * 0.00134102;
      }

      if (unit == measureUnitKilowatt) {
        if (toUnit == measureUnitWatt) return value * 1000;
        if (toUnit == measureUnitMegawatt) return value / 1000;
        if (toUnit == measureUnitHorsepower) return value * 1.34102;
      }

      if (unit == measureUnitMegawatt) {
        if (toUnit == measureUnitWatt) return value * 1e+6;
        if (toUnit == measureUnitKilowatt) return value * 1000;
        if (toUnit == measureUnitHorsepower) return value * 1341.02;
      }

      if (unit == measureUnitHorsepower) {
        if (toUnit == measureUnitWatt) return value * 745.7;
        if (toUnit == measureUnitKilowatt) return value * 0.7457;
        if (toUnit == measureUnitMegawatt) return value * 0.0007457;
      }
    }

    // * Convert preassure.
    if (category == measureCategoryPressure) {
      if (unit == measureUnitPascal) {
        if (toUnit == measureUnitKilopascal) return value / 1000;
        if (toUnit == measureUnitMegapascal) return value / 1e+6;
        if (toUnit == measureUnitBar) return value / 100000;
        if (toUnit == measureUnitAtmosphere) return value / 101325;
      }

      if (unit == measureUnitKilopascal) {
        if (toUnit == measureUnitPascal) return value * 1000;
        if (toUnit == measureUnitMegapascal) return value / 1000;
        if (toUnit == measureUnitBar) return value / 100;
        if (toUnit == measureUnitAtmosphere) return value / 101.325;
      }

      if (unit == measureUnitMegapascal) {
        if (toUnit == measureUnitPascal) return value * 1e+6;
        if (toUnit == measureUnitKilopascal) return value * 1000;
        if (toUnit == measureUnitBar) return value * 10;
        if (toUnit == measureUnitAtmosphere) return value / 0.101325;
      }

      if (unit == measureUnitBar) {
        if (toUnit == measureUnitPascal) return value * 100000;
        if (toUnit == measureUnitKilopascal) return value * 100;
        if (toUnit == measureUnitMegapascal) return value / 10;
        if (toUnit == measureUnitAtmosphere) return value / 1.01325;
      }

      if (unit == measureUnitAtmosphere) {
        if (toUnit == measureUnitPascal) return value * 101325;
        if (toUnit == measureUnitKilopascal) return value * 101.325;
        if (toUnit == measureUnitMegapascal) return value * 0.101325;
        if (toUnit == measureUnitBar) return value * 1.01325;
      }
    }

    // * Convert sound.
    if (category == measureCategorySound) {
      if (unit == measureUnitDecibel) return value;
    }

    // * Convert count.
    if (category == measureCategoryCount) {
      if (unit == measureUnitCount) return value;
    }

    // Unknown unit conversion.
    throw Failure.unknownConversion();
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// ```dart
  /// return '$fieldLabel · $value $unit';
  /// ```
  String getSubtitle({required String fieldLabel}) {
    return '$fieldLabel · $value $unit';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// ```dart
  /// return '$fieldLabel · $value $unit';
  /// ```
  String getThirdline({required String fieldLabel}) {
    return '$fieldLabel · $value $unit';
  }

  // ######################################
  // Bar Chart Instructions
  // ######################################

  /// Bar Chart identification to display progression of value.
  /// ```dart
  /// static const String barChartProgressionOfValue = 'progression_of_value';
  /// ```
  static const String barChartProgressionOfValue = 'progression_of_value';

  // ######################################
  // Database
  // ######################################

  /// Convert a ```MeasurementData``` object to a ```DbMeasurementData``` object.
  DbMeasurementData toSchema() {
    return DbMeasurementData(
      // * If encryption was applied, remove value.
      category: encryptedCategory?.isNotEmpty == true ? null : category,
      // * If encryption was applied, remove value.
      unit: encryptedUnit?.isNotEmpty == true ? null : unit,
      // * These can be null in case of defaults.
      createdAtInUtc: createdAtInUtc?.microsecondsSinceEpoch,
      createdAtDefaultDate: createdAtDefaultDate,
      createdAtDefaultTime: createdAtDefaultTime,
      createdAtTimezone: createdAtTimezone.isEmpty ? null : createdAtTimezone,
      // * Use try parse here because in case of import match there might not be a valid double here (empty)
      // * but the schema conversion is still needed.
      // * If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : double.tryParse(value),
      importReferenceCategory: importReferenceCategory,
      importReferenceUnit: importReferenceUnit,
      importReferenceValue: importReferenceValue,
      importReferenceDate: importReferenceDate,
      encryptedCategory: encryptedCategory,
      encryptedUnit: encryptedUnit,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbMeasurementData``` object to a ```MeasurementData``` object.
  static MeasurementData? fromSchema({required DbMeasurementData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return MeasurementData(
      // If encryption was applied, set value to a placeholder until decryption.
      category: schema.encryptedCategory?.isNotEmpty == true ? '' : schema.category ?? '', // ! This value can be null in case of an import match.
      // If encryption was applied, set value to a placeholder until decryption.
      unit: schema.encryptedUnit?.isNotEmpty == true ? '' : schema.unit ?? '', // ! This value can be null in case of an import match.
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true ? '' : schema.value?.toString() ?? '', // ! This value can be null in case of an import match.
      // * This can be null in case of defaults.
      createdAtInUtc: schema.createdAtInUtc == null ? null : DateTime.fromMicrosecondsSinceEpoch(schema.createdAtInUtc!, isUtc: true),
      createdAtDefaultDate: schema.createdAtDefaultDate,
      createdAtDefaultTime: schema.createdAtDefaultTime,
      // * This can be null in case of defaults.
      createdAtTimezone: schema.createdAtTimezone ?? "",
      importReferenceCategory: schema.importReferenceCategory,
      importReferenceUnit: schema.importReferenceUnit,
      importReferenceValue: schema.importReferenceValue,
      importReferenceDate: schema.importReferenceDate,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedCategory: schema.encryptedCategory != null ? Uint8List.fromList(schema.encryptedCategory!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedUnit: schema.encryptedUnit != null ? Uint8List.fromList(schema.encryptedUnit!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```MeasurementData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'category': category,
      'unit': unit,
      // In case of default, this might be empty.
      'value': value.isEmpty ? null : valueAsDouble,
      // In case of default, this might be null.
      'created_at_in_utc': createdAtInUtc?.toIso8601String(),
      'default_date': createdAtDefaultDate,
      'default_time': createdAtDefaultTime,
      'timezone': createdAtTimezone.isEmpty ? null : createdAtTimezone,
      // In case of default, this might be null.
      'tz': createdAtTimezone,
    };
  }

  /// Decode a ```MeasurementData``` object from JSON.
  static MeasurementData fromCloudObject(document) {
    return MeasurementData(
      category: document['category'],
      unit: document['unit'],
      // This might be null.
      value: document['value'] == null ? '' : document['value'].toString(),
      // In case of default, this might be null.
      createdAtInUtc: document['created_at_in_utc'] == null ? null : DateTime.parse(document['created_at_in_utc']),
      createdAtDefaultDate: document['default_date'],
      createdAtDefaultTime: document['default_time'],
      // In case of default, this might be null.
      createdAtTimezone: document['timezone'] ?? "",
      importReferenceCategory: null,
      importReferenceUnit: null,
      importReferenceValue: null,
      importReferenceDate: null,
      encryptedCategory: null,
      encryptedUnit: null,
      encryptedValue: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  MeasurementData copyWith({
    String? category,
    String? unit,
    String? value,
    DateTime? createdAtInUtc,
    String? createdAtDefaultDate,
    String? createdAtDefaultTime,
    String? createdAtTimezone,
    String? importReferenceCategory,
    String? importReferenceUnit,
    String? importReferenceValue,
    String? importReferenceDate,
    Uint8List? encryptedCategory,
    Uint8List? encryptedUnit,
    Uint8List? encryptedValue,
  }) {
    return MeasurementData(
      category: category ?? this.category,
      unit: unit ?? this.unit,
      value: value ?? this.value,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      createdAtDefaultDate: createdAtDefaultDate ?? this.createdAtDefaultDate,
      createdAtDefaultTime: createdAtDefaultTime ?? this.createdAtDefaultTime,
      createdAtTimezone: createdAtTimezone ?? this.createdAtTimezone,
      importReferenceCategory: importReferenceCategory ?? this.importReferenceCategory,
      importReferenceUnit: importReferenceUnit ?? this.importReferenceUnit,
      importReferenceValue: importReferenceValue ?? this.importReferenceValue,
      importReferenceDate: importReferenceDate ?? this.importReferenceDate,
      encryptedCategory: encryptedCategory ?? this.encryptedCategory,
      encryptedUnit: encryptedUnit ?? this.encryptedUnit,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
