import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// Models.
import '/data/models/chip_items/chip_item.dart';
import '/data/models/chip_items/chip_items.dart';

// Schemas.
import '/data/models/field_types/date_of_birth_data/schemas/db_date_of_birth_data.dart';

// Labels.
import '/main.dart';

class DateOfBirthData extends Equatable {
  final DateTime? value;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  // * State variables.
  final bool showAutoNotificationChoice;
  final bool autoNotification;
  final String notificationTitle;

  const DateOfBirthData({
    required this.value,
    required this.importReference,
    required this.showAutoNotificationChoice,
    required this.autoNotification,
    required this.notificationTitle,
    required this.encryptedValue,
  });

  /// Initialize a new ```DateOfBirthData``` object.
  factory DateOfBirthData.initial() {
    return const DateOfBirthData(
      value: null,
      importReference: null,
      showAutoNotificationChoice: true,
      autoNotification: true,
      notificationTitle: '',
      encryptedValue: null,
    );
  }

  @override
  List<Object?> get props => [value, importReference, showAutoNotificationChoice, autoNotification, notificationTitle, encryptedValue];

  /// This getter can be used to access date value as string.
  /// * Assumes ```value != null```.
  /// ```dart
  /// return DateFormat('yyyy-MM-dd').format(value!);
  /// ```
  String get getFormattedDate {
    return DateFormat('yyyy-MM-dd').format(value!);
  }

  /// This getter can be used to access TimeOfDay value as string.
  /// * assumes ```value != null```
  String get getFormattedTime {
    // Convenience variables.
    final int hour = value!.hour;
    final int minute = value!.minute;

    return '${hour < 10 ? '0' : ''}$hour:${minute < 10 ? '0' : ''}$minute';
  }

  /// This getter can be used to check if birthday is today.
  bool get getHasBirthday {
    final DateTime today = DateTime.now();
    return today.month == value!.month && today.day == value!.day;
  }

  /// This getter can be used to calculate how many days are left until birthday.
  /// * Returns  ```null``` if ```value == null```.
  /// * Returns ```0``` if the difference is ```365```.
  int? get getDaysUntilBirthday {
    if (value == null) return null;

    final DateTime todayInLocal = DateTime.now();
    final DateTime normalizedToday = DateTime(todayInLocal.year, todayInLocal.month, todayInLocal.day);

    final DateTime valueInLocal = value!;

    DateTime nextBirthday = DateTime(todayInLocal.year, valueInLocal.month, valueInLocal.day);

    // If the next birthday this year has already passed, set it to next year
    if (nextBirthday.isBefore(normalizedToday) || nextBirthday.isAtSameMomentAs(normalizedToday)) {
      nextBirthday = DateTime(todayInLocal.year + 1, valueInLocal.month, valueInLocal.day);
    }

    final int difference = nextBirthday.difference(normalizedToday).inDays;

    if (difference == 365) return 0;

    return difference;
  }

  /// This getter can be used to calculate age.
  /// * Returns  ```null``` if ```value == null```.
  int? get getAgeInYears {
    if (value == null) return null;

    final DateTime now = DateTime.now();

    final Duration difference = now.difference(value!);
    final int ageInYears = difference.inDays ~/ 365; // Calculate age in years.

    return ageInYears;
  }

  /// This getter can be used to get age as label.
  String get getAgeAsLabel {
    if (value == null) return labels.basicLabelsNoDateFound();

    final DateTime now = DateTime.now();

    if (value!.isAfter(now)) return labels.notBornYet();

    final Duration difference = now.difference(value!);

    if (difference.inDays >= 0 && difference.inDays < 183) return labels.ageInDays(ageInDays: difference.inDays);

    if (difference.inDays >= 183 && difference.inDays <= 365) return labels.ageInMonths(ageInMonths: difference.inDays ~/ 30);

    return labels.ageInYears(ageInYears: difference.inDays ~/ 365);
  }

  /// This getter can be used access the UTC season in which ```value``` falls.
  /// * Assumes ```value != null```.
  String get getSeason {
    final int month = value!.month;
    final int day = value!.day;

    if ((month == 3 && day >= 21) || (month > 3 && month < 6) || (month == 6 && day <= 20)) return 'spring';
    if ((month == 6 && day >= 21) || (month > 6 && month < 9) || (month == 9 && day <= 20)) return 'summer';
    if ((month == 9 && day >= 21) || (month > 9 && month < 12) || (month == 12 && day <= 20)) return 'autumn';
    return 'winter';
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required DateOfBirthData? dateOfBirthData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (dateOfBirthData == null) return false;

    // Has date.
    final bool hasData = dateOfBirthData.value != null;

    final bool hasDateRef = dateOfBirthData.importReference != null && dateOfBirthData.importReference!.trim().isNotEmpty;

    // * User is in set default mode.
    if (isDefault) {
      // If any value is set, return true.
      return [
        hasData,
      ].any((condition) => condition);
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import reference.
      if (hasDateRef) return true;

      // * User might also have set a default value but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if required values are set.
    if (hasData) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required DateOfBirthData? dateOfBirthData}) {
    if (dateOfBirthData == null) return null;
    if (dateOfBirthData.value == null) return null;

    return dateOfBirthData.getFormattedDate;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` if ```value == null``` or ```getAge == null```
  /// ```dart
  /// return '$fieldLabel · $getFormatedDate';
  /// ```
  String? getSubtitle({required String fieldLabel}) {
    if (value == null) return null;
    if (getAgeInYears == null) return null;

    return '$fieldLabel · $getFormattedDate · ($getAgeInYears ${labels.dateOfBirthDataYearsOld()})';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` if ```value == null``` or ```getAge == null```
  /// ```dart
  /// return '$fieldLabel · $getFormatedDate';
  /// ```
  String? getThirdline({required String fieldLabel}) {
    if (value == null) return null;
    if (getAgeInYears == null) return null;

    return '$fieldLabel · $getFormattedDate · ($getAgeInYears ${labels.dateOfBirthDataYearsOld()})';
  }

  /// This getter can be used to access zodiac sign.
  /// * Returns ```null``` if ```value``` is ```null```.
  String? get getZodiacSign {
    // Make sure a value is available.
    if (value == null) return null;

    final int day = value!.day;
    final int month = value!.month;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return labels.zodiacSignAquarius();
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return labels.zodiacSignPisces();
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return labels.zodiacSignAries();
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return labels.zodiacSignTaurus();
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return labels.zodiacSignGemini();
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return labels.zodiacSignCancer();
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return labels.zodiacSignLeo();
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return labels.zodiacSignVirgo();
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return labels.zodiacSignLibra();
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return labels.zodiacSignScorpio();
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return labels.zodiacSignSagittarius();
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return labels.zodiacSignCapricorn();

    return null;
  }

  /// This method can be used to generate Chips that display additional data such as zodiac sign,
  /// age and days until next birthday.
  /// * Returns ```null``` if no additional indications could be accessed.
  ChipItems? additionalIndications() {
    // Get zodiac sign.
    final String? zodiacSign = getZodiacSign;

    // Access current age.
    final String ageAsLabel = getAgeAsLabel;

    // Access days until birthday.
    final int? daysUntil = getDaysUntilBirthday;

    // Create items.
    final ChipItems chipItems = ChipItems(
      items: [
        if (zodiacSign != null)
          ChipItem.initial().copyWith(
            label: zodiacSign,
          ),
        if (ageAsLabel.isNotEmpty)
          ChipItem.initial().copyWith(
            label: ageAsLabel,
          ),
        if (daysUntil != null)
          ChipItem.initial().copyWith(
            label: labels.basicLabelsDaysLeft(days: daysUntil),
          ),
      ],
      isLoading: false,
    );

    // No additional data accessed.
    if (chipItems.items.isEmpty) return null;

    return chipItems;
  }

  // #####################################
  // Pie Chart Instructions
  // #####################################

  /// Pie Chart identification to display seasonal distribution of birthdays.
  /// ```dart
  /// static const String pieChartSeasonalBirthdayDistribution = 'seasonal_distribution';
  /// ```
  static const String pieChartSeasonalBirthdayDistribution = 'seasonal_distribution';

  // #####################################
  // Bar Chart Instructions
  // #####################################

  /// Bar Chart identification to display birthdays per month.
  /// ```dart
  /// static const String barChartBirthdaysPerMonth = 'birthdays_per_month';
  /// ```
  static const String barChartBirthdaysPerMonth = 'birthdays_per_month';

  // ######################################
  // Database
  // ######################################

  /// Convert a ```DateOfBirthData``` object to a ```DbDateOfBirthData``` object.
  DbDateOfBirthData toSchema() {
    return DbDateOfBirthData(
      // * If encryption was applied, remove value.
      value: encryptedValue?.isNotEmpty == true ? null : value?.millisecondsSinceEpoch, // * Can be null in case of default.
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbDateOfBirthData``` object to a ```DateOfBirthData``` object.
  static DateOfBirthData? fromSchema({required DbDateOfBirthData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Convenience variables.
    // ! If encryption was applied, set value to a placeholder until decryption.
    final bool encrypted = schema.encryptedValue?.isNotEmpty == true;

    // ! This is, for example, null if a ModelEntry with import specs is loaded from local storage. Because in that case only the importReference is set.
    final bool nullValue = schema.value == null;

    return DateOfBirthData(
      value: encrypted || nullValue ? null : DateTime.fromMillisecondsSinceEpoch(schema.value!, isUtc: false),
      importReference: schema.importReference,
      // * Init state variables.
      showAutoNotificationChoice: false,
      autoNotification: false,
      notificationTitle: '',
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: encrypted ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```DateOfBirthData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'value': value!.toIso8601String(),
    };
  }

  /// Decode a ```DateOfBirthData``` object from JSON.
  static DateOfBirthData fromCloudObject(document) {
    return DateOfBirthData(
      value: DateTime.parse(document['value']),
      importReference: null,
      // * Set state data.
      showAutoNotificationChoice: false,
      autoNotification: false,
      notificationTitle: '',
      encryptedValue: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  DateOfBirthData copyWith({
    DateTime? value,
    String? importReference,
    bool? showAutoNotificationChoice,
    bool? autoNotification,
    String? notificationTitle,
    Uint8List? encryptedValue,
    bool explicitlySetValue = false,
  }) {
    return DateOfBirthData(
      value: explicitlySetValue ? value : value ?? this.value,
      importReference: importReference ?? this.importReference,
      showAutoNotificationChoice: showAutoNotificationChoice ?? this.showAutoNotificationChoice,
      autoNotification: autoNotification ?? this.autoNotification,
      notificationTitle: notificationTitle ?? this.notificationTitle,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
