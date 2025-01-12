import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

// User with Settings and Labels.
import '/main.dart';

// Models.
import '/data/models/picker_items/color_item.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

/// This method can be used to convert a csvTable to a Map.
/// * Should be used in a try catch block.
/// * Is outside of `HelperFunctions` to enable `compute`.
/// * If ```convertRows == null``` all rows will be converted, otherwise only the specified number of rows are converted.
Future<List<Map<String, dynamic>>> _convertCsvToMap(Map<String, dynamic> map) async {
  // Access map values.
  final List<List<dynamic>> csvTable = map['csv'];
  final int? convertRows = map['convert_rows'];

  // Access header.
  final List<dynamic> header = csvTable[0];

  // Init list.
  List<Map<String, dynamic>> helperList = [];

  // Go through data and fill list.
  for (int i = 0; i < csvTable.length; i++) {
    // Skip header.
    if (i == 0) continue;

    // Access row.
    final List<dynamic> row = csvTable[i];

    // Init helper.
    Map<String, dynamic> helper = {};

    // Go through row data and match to map.
    for (int x = 0; x < row.length; x++) {
      // Access key.
      final String key = header[x];

      // Access data point.
      dynamic datapoint = row[x];

      // Convert missing to null.
      if (datapoint == null || datapoint == '') datapoint = null;

      // Init map.
      helper[key] = datapoint;
    }

    // Add to list.
    helperList.add(helper);

    // Only convert specified number of rows.
    if (convertRows == i) break;
  }

  return helperList;
}

mixin HelperFunctions {
  /// This list can be used to init a color picker.
  static final List<ColorItem> availableColors = [
    ColorItem(
      id: 'amber',
      label: labels.pickerItemsColorAmber(),
      color: Colors.amber,
    ),
    ColorItem(
      id: 'green',
      label: labels.pickerItemsColorGreen(),
      color: Colors.green,
    ),
    ColorItem(
      id: 'red',
      label: labels.pickerItemsColorRed(),
      color: Colors.red,
    ),
    ColorItem(
      id: 'purple',
      label: labels.pickerItemsColorPurple(),
      color: Colors.purple,
    ),
    ColorItem(
      id: 'deep_purple',
      label: labels.pickerItemsColorDeepPurple(),
      color: Colors.deepPurple,
    ),
    ColorItem(
      id: 'orange',
      label: labels.pickerItemsColorOrange(),
      color: Colors.orange,
    ),
    ColorItem(
      id: 'deep_orange',
      label: labels.pickerItemsColorDeepOrange(),
      color: Colors.deepOrange,
    ),
    ColorItem(
      id: 'brown',
      label: labels.pickerItemsColorBrown(),
      color: Colors.brown,
    ),
    ColorItem(
      id: 'teal',
      label: labels.pickerItemsColorTeal(),
      color: Colors.teal,
    ),
    ColorItem(
      id: 'blue',
      label: labels.pickerItemsColorBlue(),
      color: const Color.fromARGB(255, 18, 99, 165),
    ),
    ColorItem(
      id: 'pink',
      label: labels.pickerItemsColorPink(),
      color: Colors.pink,
    ),
    // Additional Colors
    ColorItem(
      id: 'cyan',
      label: labels.pickerItemsColorCyan(),
      color: Colors.cyan,
    ),
    ColorItem(
      id: 'lime',
      label: labels.pickerItemsColorLime(),
      color: Colors.lime,
    ),
    ColorItem(
      id: 'indigo',
      label: labels.pickerItemsColorIndigo(),
      color: Colors.indigo,
    ),
    ColorItem(
      id: 'light_blue',
      label: labels.pickerItemsColorLightBlue(),
      color: Colors.lightBlue,
    ),
    ColorItem(
      id: 'light_green',
      label: labels.pickerItemsColorLightGreen(),
      color: Colors.lightGreen,
    ),
    ColorItem(
      id: 'yellow',
      label: labels.pickerItemsColorYellow(),
      color: Colors.yellow,
    ),
    ColorItem(
      id: 'black',
      label: labels.pickerItemsColorBlack(),
      color: Colors.black,
    ),
    ColorItem(
      id: 'white',
      label: labels.pickerItemsColorWhite(),
      color: Colors.white,
    ),
    ColorItem(
      id: 'light_pink',
      label: labels.pickerItemsColorLightPink(),
      color: Colors.pink[200]!,
    ),
    ColorItem(
      id: 'light_purple',
      label: labels.pickerItemsColorLightPurple(),
      color: Colors.purple[200]!,
    ),
    ColorItem(
      id: 'light_red',
      label: labels.pickerItemsColorLightRed(),
      color: Colors.red[200]!,
    ),
    ColorItem(
      id: 'light_orange',
      label: labels.pickerItemsColorLightOrange(),
      color: Colors.orange[200]!,
    ),
    ColorItem(
      id: 'light_teal',
      label: labels.pickerItemsColorLightTeal(),
      color: Colors.teal[200]!,
    ),
    ColorItem(
      id: 'light_brown',
      label: labels.pickerItemsColorLightBrown(),
      color: Colors.brown[200]!,
    ),
    ColorItem(
      id: 'magenta',
      label: labels.pickerItemsColorMagenta(),
      color: const Color(0xFFFF00FF),
    ),
    ColorItem(
      id: 'chartreuse',
      label: labels.pickerItemsColorChartreuse(),
      color: const Color(0xFF7FFF00),
    ),
    ColorItem(
      id: 'navy',
      label: labels.pickerItemsColorNavy(),
      color: const Color(0xFF000080),
    ),
    ColorItem(
      id: 'olive',
      label: labels.pickerItemsColorOlive(),
      color: const Color(0xFF808000),
    ),
  ];

  /// This method can be used to get a ColorItem of available colors by its id.
  /// * Returns ```null``` if id was not found.
  static ColorItem? getColorById({required String id}) {
    // In case of speciel color return it.
    if (id == "blue_grey") {
      return ColorItem(
        id: "blue_grey",
        label: labels.pickerItemsColorBlueGrey(),
        color: Colors.blueGrey,
      );
    }

    // Otherwise go through available colors.
    for (final ColorItem item in availableColors) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to choose a color from available colors.
  /// * Starts with first color and returns next with each iteration.
  /// * Returns a random color if all available colors have been used already.
  /// * Duplicates are possible if available colors have been exhausted.
  Color getNextColorFromAvailableColors({required List<Color> previousColors}) {
    // Go through colors and return next item that is not in previousColors.
    for (final ColorItem item in availableColors) {
      if (previousColors.contains(item.color)) continue;
      return item.color;
    }

    return getRandomColor();
  }

  /// This method can be used to display a debug message if context is not mounted.
  void contextNotMountedHelper({required String parent, required String sourceMethod}) {
    debugPrint('$parent --> $sourceMethod --> failure, context is not mounted.');

    return;
  }

  /// This method can be used to access a random color.
  /// * Returns null if a new color could not be found.
  Color? getRandomDarkColor({required List<Color> previousColors}) {
    // Try 100 times to get a color that is not in previousColors.
    for (var i = 0; i < 100; i++) {
      // Generate random values for red, green, and blue components
      final Random random = Random();

      // Define the minimum and maximum values for each RGB component
      const int minComponentValue = 0; // Minimum value for a dark color
      const int maxComponentValue = 100; // Maximum value to keep colors dark

      // Generate random values for red, green, and blue components
      final int red = minComponentValue + random.nextInt(maxComponentValue - minComponentValue + 1);
      final int green = minComponentValue + random.nextInt(maxComponentValue - minComponentValue + 1);
      final int blue = minComponentValue + random.nextInt(maxComponentValue - minComponentValue + 1);

      // Create a dark color using the random RGB values
      final Color color = Color.fromARGB(255, red, green, blue);

      if (previousColors.contains(color)) continue;

      return color;
    }

    return null;
  }

  /// This method can be used to access a random color.
  /// * Duplicates are possible!
  static Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // Alpha value (opacity) is set to 255 (fully opaque).
      random.nextInt(256), // Red component.
      random.nextInt(256), // Green component.
      random.nextInt(256), // Blue component.
    );
  }

  /// This method can be used to upper case a String value.
  String capitalizeFirstCharacter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  /// This method can be used to parse an unknown String to a DateTime.
  /// * Returns ```null``` if no formats match.
  static DateTime? parseDate({required dynamic value}) {
    // If null was supplied, return null.
    if (value == null) return null;

    // Make sure variable is a String.
    if (value is String == false) return null;

    // Currently available date formats.
    final List<DateFormat> formats = [
      // ! It matters that the format with double digit year is checked first because if a format like "dd.MM.yyy" tries to
      // ! to format a double digit year date (08.05.24) it will succeed with a false positive year: 0024.
      // Date-only formats
      DateFormat("dd.MM.yy"), // Example: 31.12.22
      DateFormat("dd.MM.yyyy"), // Example: 31.12.2022
      DateFormat("yyyy-MM-dd"), // Example: 2022-12-31
      DateFormat("MM/dd/yyyy"), // Example: 12/31/2022
      DateFormat("dd-MM-yyyy"), // Example: 31-12-2022
      DateFormat("yyyy.MM.dd"), // Example: 2022.12.31
      DateFormat("dd/MM/yyyy"), // Example: 31/12/2022
      DateFormat("MMMM d, yyyy"), // Example: December 31, 2022
      DateFormat("d MMM yyyy"), // Example: 31 Dec 2022
      DateFormat("EEE, d MMM yyyy"), // Example: Sat, 31 Dec 2022
      DateFormat("EEE, MMM d, yyyy"), // Example: Sat, Dec 31, 2022
      DateFormat("dd MMMM yyyy"), // Example: 31 December 2022
      DateFormat("yyyy/MM/dd"), // Example: 2022/12/31
      DateFormat("yyyyMMdd"), // Example: 20221231
      DateFormat("d MMMM yyyy"), // Example: 31 December 2022
      DateFormat("MM-dd-yyyy"), // Example: 12-31-2022

      // Time-only formats
      DateFormat("HH:mm"), // Example: 18:30 (24-hour format)
      DateFormat("HH:mm:ss"), // Example: 18:30:45 (24-hour format with seconds)
      DateFormat("hh:mm a"), // Example: 06:30 PM (12-hour format with AM/PM)
      DateFormat("hh:mm:ss a"), // Example: 06:30:45 PM (12-hour format with seconds and AM/PM)
      DateFormat("HH:mm:ss.SSS"), // Example: 18:30:45.123 (24-hour format with milliseconds)
      DateFormat("h:mm a"), // Example: 6:30 PM (12-hour format, no leading zero on the hour)
      DateFormat("HH:mm:ssZ"), // Example: 18:30:45+0000 (24-hour format with seconds and time zone offset)
      DateFormat("HH:mm:ss.SSSZ"), // Example: 18:30:45.123+0000 (24-hour format with milliseconds and time zone offset)
      DateFormat("HH:mm:ss z"), // Example: 18:30:45 GMT (24-hour format with time zone abbreviation)
      DateFormat("HH:mm:ss.SSS z"), // Example: 18:30:45.123 GMT (24-hour format with milliseconds and time zone abbreviation)
      DateFormat("HH:mm:ss.SSSSSS"), // Example: 18:30:45.123456
      DateFormat("hh:mm a z"), // Example: 06:30 PM GMT

      // Date and time formats
      DateFormat("yyyy-MM-dd HH:mm:ss.SSS"), // Example: 2024-08-14 00:00:00.000 (with milliseconds)
      DateFormat("dd MMM yyyy HH:mm"), // Example: 31 Dec 2022 18:30
      DateFormat("MM/dd/yyyy HH:mm"), // Example: 12/31/2022 18:30
      DateFormat("yyyy-MM-ddTHH:mm:ss"), // Example: 2022-12-31T18:30:00 (ISO 8601)
      DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ"), // Example: 2022-12-31T18:30:00.000+0000 (ISO 8601 with milliseconds)
      DateFormat("dd.MM.yyyy HH:mm:ss"), // Example: 31.12.2022 18:30:00
      DateFormat("dd.MM.yyyy HH:mm"), // Example: 31.12.2022 18:30
      DateFormat("yyyy.MM.dd HH:mm"), // Example: 2022.12.31 18:30
      DateFormat("yyyy-MM-dd HH:mm"), // Example: 2022-12-31 18:30
      DateFormat("yyyy/MM/dd HH:mm:ss"), // Example: 2022/12/31 18:30:45
      DateFormat("dd-MM-yyyy HH:mm:ss"), // Example: 31-12-2022 18:30:45
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"), // Example: 2022-12-31T18:30:00.000Z (ISO 8601 UTC)
      DateFormat("yyyyMMdd HHmmss"), // Example: 20221231 183000
      DateFormat("yyyy-MM-ddTHH:mm"), // Example: 2022-12-31T18:30 (ISO 8601 without seconds)
      DateFormat("MM/dd/yyyy HH:mm:ss"), // Example: 12/31/2022 18:30:00
      DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS"), // Example: 2024-08-14 00:00:00.123456
      DateFormat("yyyy-MM-dd HH:mm:ss Z"), // Example: 2022-12-31 18:30:45 +0000
      DateFormat("EEE, MMM d yyyy h:mm:ss a"), // Example: Sat, Dec 31 2022 6:30:45 PM
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ"), // Example: 2022-12-31T18:30:45.123+0000

      // Full day names with date and time
      DateFormat("EEEE, MMM d, yyyy h:mm a"), // Example: Saturday, Dec 31, 2022 6:30 PM
      DateFormat("EEEE, d MMM yyyy HH:mm:ss"), // Example: Saturday, 31 Dec 2022 18:30:45
      DateFormat("EEEE, d MMMM yyyy HH:mm:ss"), // Example: Saturday, 31 December 2022 18:30:45
      DateFormat("MMM d, yyyy h:mm:ss a"), // Example: Dec 31, 2022 6:30:45 PM
    ];

    // Go through formats and try to parse dates.
    for (final DateFormat format in formats) {
      // Try parsing the date with current format.
      DateTime? date = format.tryParse(value);

      // If the conversion was a success, return value.
      if (date != null) return date;
    }

    // Return null if no formats match.
    return null;
  }

  /// This method can be used to parse an unknown String to a `List<String>`.
  /// * Returns ```null``` if conversion fails.
  List<String>? tryParseStringList({required dynamic value}) {
    try {
      // If null was supplied, return null.
      if (value == null) return null;

      // Make sure variable is a String.
      if (value is String == false) return null;

      // Set type so that IDE can help coding.
      final String stringValue = value;

      // Convert list.
      final List<String> converted = stringValue.split(',');

      // Return it on success.
      return converted;
    } catch (exception) {
      // Output debug message.
      debugPrint('HelperFunctions --> tryParseStringList() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This method is a wrapper function of `_convertCsvToMap` to enable `compute` and can be used to convert a csvTable to a Map.
  /// * Should be used in a try catch block.
  static Future<List<Map<String, dynamic>>> wrapperConvertCsvToMap({required List<List<dynamic>> csvTable, required int? convertRows}) async {
    // ! This needs to be a static function otherwise import fails for some reason that has to do with the timer in state being an
    // ! unsendable object. I dont understand but whatever.

    // Perform task.
    final List<Map<String, dynamic>> csvMap = await compute(
      _convertCsvToMap,
      {
        'csv': csvTable,
        'convert_rows': convertRows,
      },
    );

    return csvMap;
  }

  /// This method can be used to check the current platform.
  String getCurrentPlatform() {
    if (Platform.isIOS) return 'ios';
    if (Platform.isAndroid) return 'android';
    if (Platform.isFuchsia) return 'fuchsia';
    if (Platform.isLinux) return 'linux';
    if (Platform.isMacOS) return 'macos';
    if (Platform.isWindows) return 'windows';
    return '';
  }

  /// This method can be used to access current user time zone from local in timezone package.
  /// * Returns `null` on error.
  static String? getCurrentTimezone() {
    try {
      // Access the current timezone.
      final String timezone = tz.local.name;

      // Timezone invalid.
      if (timezone.isEmpty) return null;

      return timezone;
    } catch (exception) {
      // Output debug message.
      debugPrint('HelperFunctions --> getCurrentTimezone() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This method can be used to access all relevant timezones.
  /// * Returns `""` on error.
  /// * Returns timezones sorted.
  Future<PickerItems> getAllTimezones() async {
    try {
      // Access all timezones.
      final List<String> availableTimezones = tz.timeZoneDatabase.locations.keys.toList();

      // No timezones available.
      if (availableTimezones.isEmpty) return PickerItems.initial();

      // Sort timezones.
      availableTimezones.sort();

      // Generate a list of timezones.
      List<PickerItem> pickerItems = List<PickerItem>.generate(
        availableTimezones.length,
        (index) => PickerItem(id: availableTimezones[index], label: availableTimezones[index]),
      );

      // Add UTC PickerItem at the beginning.
      pickerItems.insert(0, PickerItem(id: 'UTC', label: 'UTC'));

      return PickerItems(items: pickerItems);
    } catch (exception) {
      // Output debug message.
      debugPrint('HelperFunctions --> getAllTimezones() --> exception: ${exception.toString()}');

      return PickerItems.initial();
    }
  }

  /// This method can be used to get the local DateTime specified.
  /// * This will convert `toLocal` if the timezone `isEmpty` or if `timezone == "UTC"` .
  /// * Otherwise converts to the provided `timezone`.
  static tz.TZDateTime convertToTimezone({required DateTime? dateTimeInUtc, required String timezone, required bool preserveUtc}) {
    // If the provided dateTime is null, a new tz.TZDateTime will be constructed with the current local date.
    if (dateTimeInUtc == null) {
      // Get the stored timezone location (e.g., Europe/Berlin)
      final tz.Location storedLocation = tz.getLocation(timezone);

      // Access now.
      final DateTime now = DateTime.now();

      return tz.TZDateTime(
        storedLocation,
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond,
      );
    }

    // If no timezone is provided or the timezone is specified as UTC, return the time in local time.
    // * The isEmpty is needed because before data is initialized cubit state has an empty timezone present and this will throw an error because a empty timezone does not exist in package.
    if (timezone.isEmpty || timezone == "UTC") {
      // If the flag to preserve as UTC was set, return as is.
      if (preserveUtc) return tz.TZDateTime.from(dateTimeInUtc, tz.UTC);

      // Otherwise convert to local.
      return tz.TZDateTime.from(dateTimeInUtc, tz.local);
    }

    // Get the stored timezone location (e.g., Europe/Berlin)
    final tz.Location storedLocation = tz.getLocation(timezone);

    // Convert the UTC time to the stored time zone (e.g., Europe/Berlin)
    final tz.TZDateTime storedLocalTime = tz.TZDateTime.from(dateTimeInUtc, storedLocation);

    return storedLocalTime;
  }

  /// This method can be used to convert default values to a utc DateTime of given timezone.
  static DateTime convertDefaultsToUtc({required DateTime? defaultDate, required TimeOfDay? defaultTime, required String timezone}) {
    // Convenience variables.
    final bool hasDateTimeDefaults = defaultDate != null || defaultTime != null;

    // Access now.
    final DateTime now = DateTime.now();

    // Get the timezone location.
    final tz.Location location = tz.getLocation(timezone);

    // Create new tz.DateTime
    final tz.TZDateTime localTimeInTimezone = tz.TZDateTime(
      location,
      defaultDate?.year ?? now.year,
      defaultDate?.month ?? now.month,
      defaultDate?.day ?? now.day,
      defaultTime?.hour ?? now.hour,
      defaultTime?.minute ?? now.minute,
      hasDateTimeDefaults ? 0 : now.second,
      hasDateTimeDefaults ? 0 : now.millisecond,
      hasDateTimeDefaults ? 0 : now.microsecond,
    );

    return localTimeInTimezone.toUtc();
  }

  /// This method can be used to change the location of a `tz.TZDateTime`.
  /// * Keeps the original values and changes only the timezone.
  static tz.TZDateTime changeTimezone({required DateTime dateTimeInUtc, required String originalTimezone, required String newTimezone}) {
    // Access initial DateTime with its original timezone.
    final tz.TZDateTime initialDateTime = convertToTimezone(
      dateTimeInUtc: dateTimeInUtc,
      timezone: originalTimezone,
      preserveUtc: true,
    );

    // Get the stored timezone location (e.g., Europe/Berlin).
    final tz.Location storedLocation = tz.getLocation(newTimezone);

    // Create new tz.DateTime
    final tz.TZDateTime updated = tz.TZDateTime(
      storedLocation,
      initialDateTime.year,
      initialDateTime.month,
      initialDateTime.day,
      initialDateTime.hour,
      initialDateTime.minute,
      initialDateTime.second,
      initialDateTime.millisecond,
      initialDateTime.microsecond,
    );

    return updated;
  }

  /// This method can be used to change the date of a `tz.TZDateTime`.
  /// * Creates a new object with the values from `localDate` that retains the `originalTimezoneLocation`.
  static tz.TZDateTime changeDate({required DateTime localDate, required tz.Location originalTimezoneLocation}) {
    // Create new tz.DateTime
    final tz.TZDateTime updated = tz.TZDateTime(
      originalTimezoneLocation,
      localDate.year,
      localDate.month,
      localDate.day,
      localDate.hour,
      localDate.minute,
      localDate.second,
      localDate.millisecond,
      localDate.microsecond,
    );

    return updated;
  }

  /// This method can be used to change the date of a `tz.TZDateTime`.
  /// * Creates a new object with the values from `timeOfDay` that retains the `originalTimezoneLocation`.
  static tz.TZDateTime changeTime({required DateTime localDate, required TimeOfDay timeOfDay, required tz.Location originalTimezoneLocation}) {
    // Create new tz.DateTime
    final tz.TZDateTime updated = tz.TZDateTime(
      originalTimezoneLocation,
      localDate.year,
      localDate.month,
      localDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
      localDate.second,
      localDate.millisecond,
      localDate.microsecond,
    );

    return updated;
  }

  /// This method can be used to try and parse a TimeOfDay from a String.
  static TimeOfDay? parseTimeOfDay({required String? value}) {
    try {
      // Test for invalid value.
      if (value == null || value.isEmpty) return null;

      // Split the string into parts (e.g., "14:30" -> ["14", "30"]).
      final parts = value.split(':');
      if (parts.length != 2) return null; // Ensure the format is valid.

      // Parse hours and minutes.
      final int hour = int.parse(parts[0]);
      final int minute = int.parse(parts[1]);

      // Validate the hour and minute ranges.
      if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

      // Return the parsed TimeOfDay object.
      return TimeOfDay(hour: hour, minute: minute);
    } catch (exception) {
      return null;
    }
  }

  /// This method can be used to format a TimeOfDay object in a String of 24 hour format.
  static String formatTimeOfDayTo24Hour({required TimeOfDay timeOfDay}) {
    return "${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}";
  }
}
