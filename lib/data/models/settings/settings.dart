import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/settings/schemas/db_settings.dart';

// Models.
import '/data/models/labels/labels.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class Settings extends Equatable {
  final int notificationDurationInSeconds;
  final int maxLinesForTextFields;

  final String defaultCurrency;

  final bool acceptedTermsAndConditions;

  const Settings({
    required this.notificationDurationInSeconds,
    required this.maxLinesForTextFields,
    required this.acceptedTermsAndConditions,
    required this.defaultCurrency,
  });

  /// Initialize a new `Settings` object.
  factory Settings.initial() {
    return const Settings(
      notificationDurationInSeconds: 4,
      maxLinesForTextFields: 8,
      acceptedTermsAndConditions: false,
      defaultCurrency: '',
    );
  }

  /// This list represents available notification durations in seconds.
  /// ```dart
  /// static const List<int> notificationDurationsInSeconds = [2, 3, 4, 5, 6, 7, 8, 9, 10];
  /// ```
  static const List<int> notificationDurationsInSeconds = [2, 3, 4, 5, 6, 7, 8, 9, 10];

  /// This list represents available max lines for text fields.
  /// ```dart
  /// static const List<int> maxLines = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  /// ```
  static const List<int> maxLines = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

  @override
  List<Object> get props => [
        notificationDurationInSeconds,
        maxLinesForTextFields,
        acceptedTermsAndConditions,
        defaultCurrency,
      ];

  /// This method can be used access [notificationDurationsInSeconds] as [PickerItems]
  static PickerItems notificationDurationsPickerItems({required Labels labels}) {
    // Create helper list.
    List<PickerItem> list = [];

    for (final int second in notificationDurationsInSeconds) {
      // Create PickerItem.
      final PickerItem pickerItem = PickerItem.initial().copyWith(
        id: second.toString(),
        label: labels.settingsSheetNotificationDurationPickerLabel(durationInSeconds: second),
      );

      // Add to list.
      list.add(pickerItem);
    }

    return PickerItems(items: list);
  }

  /// This method can be used access [maxLines] as [PickerItems]
  static PickerItems maxLinesPickerItems({required Labels labels}) {
    // Create helper list.
    List<PickerItem> list = [];

    for (final int lines in maxLines) {
      // Create PickerItem.
      final PickerItem pickerItem = PickerItem.initial().copyWith(
        id: lines.toString(),
        label: labels.settingsSheetMaxTextFieldPickerLabel(numberOfLines: lines),
      );

      // Add to list.
      list.add(pickerItem);
    }

    return PickerItems(items: list);
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```Settings``` object to a ```DbSettings``` object.
  DbSettings toSchema() {
    return DbSettings(
      notificationDurationInSeconds: notificationDurationInSeconds,
      maxLinesForTextFields: maxLinesForTextFields,
      acceptedTermsAndConditions: acceptedTermsAndConditions,
      defaultCurrency: defaultCurrency,
    );
  }

  /// Convert a ```DbSettings``` object to a ```Settings``` object.
  static Settings fromSchema({required DbSettings schema}) {
    return Settings(
      notificationDurationInSeconds: schema.notificationDurationInSeconds!,
      maxLinesForTextFields: schema.maxLinesForTextFields!,
      acceptedTermsAndConditions: schema.acceptedTermsAndConditions!,
      defaultCurrency: schema.defaultCurrency!,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  Settings copyWith({
    int? notificationDurationInSeconds,
    int? maxLinesForTextFields,
    String? defaultCurrency,
    bool? acceptedTermsAndConditions,
  }) {
    return Settings(
      notificationDurationInSeconds: notificationDurationInSeconds ?? this.notificationDurationInSeconds,
      maxLinesForTextFields: maxLinesForTextFields ?? this.maxLinesForTextFields,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      acceptedTermsAndConditions: acceptedTermsAndConditions ?? this.acceptedTermsAndConditions,
    );
  }
}
