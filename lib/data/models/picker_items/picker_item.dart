import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Labels.
import '/main.dart';

class PickerItem extends Equatable {
  final String id;
  final String label;
  final String infoMessage;
  final dynamic additionalData;

  const PickerItem({
    required this.id,
    required this.label,
    this.infoMessage = '',
    this.additionalData,
  });

  /// PickerItem identification for all fields of type.
  /// ```dart
  /// static const String identificationAllFieldsOfType = 'all_fields_of_type';
  /// ```
  static const String identificationAllFieldsOfType = 'all_fields_of_type';

  /// PickerItem identification for all years.
  /// ```dart
  /// static const String identificationAllYears = 'all_years';
  /// ```
  static const String identificationAllYears = 'all_years';

  /// PickerItem identification for time interval yearly.
  /// ```dart
  /// static const String intervalYearly = 'yearly';
  /// ```
  static const String intervalYearly = 'yearly';

  /// PickerItem identification for time interval monthly.
  /// ```dart
  /// static const String intervalMonthly = 'monthly';
  /// ```
  static const String intervalMonthly = 'monthly';

  /// PickerItem identification for time interval daily.
  /// ```dart
  /// static const String intervalDaily = 'daily';
  /// ```
  static const String intervalDaily = 'daily';

  /// Initialize a new [PickerItem] object.
  factory PickerItem.initial() {
    return PickerItem(
      id: const Uuid().v4(),
      label: '',
      infoMessage: '',
    );
  }

  /// Initialize a ```PickerItem``` object for all fields.
  factory PickerItem.allFieldsOfType() {
    return PickerItem(
      id: identificationAllFieldsOfType,
      label: labels.considerAllFields(),
    );
  }

  /// Initialize a ```PickerItem``` object for all years.
  factory PickerItem.allYears() {
    return PickerItem(
      id: identificationAllYears,
      label: labels.considerAllYears(),
    );
  }

  /// Initialize a ```PickerItem``` object for time interval yearly.
  factory PickerItem.yearly() {
    return PickerItem(
      id: intervalYearly,
      label: labels.timeIntervalYearly(),
    );
  }

  /// Initialize a ```PickerItem``` object for time interval monthly.
  factory PickerItem.monthly() {
    return PickerItem(
      id: intervalMonthly,
      label: labels.timeIntervalMonthly(),
    );
  }

  /// Initialize a ```PickerItem``` object for time interval daily.
  factory PickerItem.daily() {
    return PickerItem(
      id: intervalDaily,
      label: labels.timeIntervalDaily(),
    );
  }

  @override
  List<Object?> get props => [id, label, infoMessage, additionalData];

  PickerItem copyWith({
    String? id,
    String? label,
    String? infoMessage,
    dynamic additionalData,
  }) {
    return PickerItem(
      id: id ?? this.id,
      label: label ?? this.label,
      infoMessage: infoMessage ?? this.infoMessage,
      additionalData: additionalData ?? this.additionalData,
    );
  }
}
