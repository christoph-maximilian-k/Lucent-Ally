import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Schemas.
import '/data/models/field_types/time_data/schemas/db_time_data.dart';

class TimeData extends Equatable {
  final TimeOfDay? value;

  final String? importReference;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedValue;

  const TimeData({
    required this.value,
    required this.importReference,
    required this.encryptedValue,
  });

  /// Initialize a new ```TimeData``` object.
  factory TimeData.initial() {
    return const TimeData(
      value: null,
      importReference: null,
      encryptedValue: null,
    );
  }

  @override
  List<Object?> get props => [value, importReference, encryptedValue];

  /// This getter can be used to access TimeOfDay value as string.
  /// * assumes ```value != null```
  String get getFormattedTime {
    // Convenience variables.
    final int hour = value!.hour;
    final int minute = value!.minute;

    return '${hour < 10 ? '0' : ''}$hour:${minute < 10 ? '0' : ''}$minute';
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required TimeData? timeData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (timeData == null) return false;

    // Convenience variables.
    final bool hasData = timeData.value != null;

    final bool hasRef = timeData.importReference != null && timeData.importReference!.trim().isNotEmpty;

    // * User is in set default mode.
    if (isDefault) {
      // User set a default value.
      if (hasData) return true;

      return false;
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import reference.
      if (hasRef) return true;

      // * User might also have set a default value but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if value is set.
    if (hasData) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required TimeData? timeData}) {
    if (timeData == null) return null;
    if (timeData.value == null) return null;

    return timeData.getFormattedTime;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` if ```value == null```
  /// ```dart
  /// return '$fieldLabel · $getFormatedDate';
  /// ```
  String? getSubtitle({required String fieldLabel}) {
    if (value == null) return null;
    return '$fieldLabel · $getFormattedTime';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` if ```value == null```
  /// ```dart
  /// return '$fieldLabel · $getFormatedDate';
  /// ```
  String? getThirdline({required String fieldLabel}) {
    if (value == null) return null;
    return '$fieldLabel · $getFormattedTime';
  }

  /// #####################################
  /// Statistics
  /// #####################################

  /// This method can be used to access label of provided chart instruction.
  /// * returns ```null``` if ```instructionType``` is not known
  static String? instructionTypeLabels({required String instructionType}) {
    return null;
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```TimeData``` object to a ```DbTimeData``` object.
  DbTimeData toSchema() {
    // ! Hour/minute are null if a ModelEntry with import specs is saved to local storage. Because in that case only the importReference is set.
    return DbTimeData(
      // If encryption was applied, remove value.
      hour: encryptedValue?.isNotEmpty == true ? null : value?.hour,
      // If encryption was applied, remove value.
      minute: encryptedValue?.isNotEmpty == true ? null : value?.minute,
      importReference: importReference,
      encryptedValue: encryptedValue,
    );
  }

  /// Convert a ```DbTimeData``` object to a ```TimeData``` object.
  static TimeData? fromSchema({required DbTimeData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Check if hour or minute are null. This occurs if a import reference is loaded.
    final bool hasTimeData = schema.hour != null && schema.minute != null;

    return TimeData(
      // If encryption was applied, set value to a placeholder until decryption.
      value: schema.encryptedValue?.isNotEmpty == true
          ? null
          : hasTimeData
              ? TimeOfDay(hour: schema.hour!, minute: schema.minute!)
              : null, // ! This is null if a ModelEntry with import specs is loaded from local storage. Because in that case only the importReference is set.
      importReference: schema.importReference,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedValue: schema.encryptedValue != null ? Uint8List.fromList(schema.encryptedValue!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```TimeData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'hour': value!.hour,
      'minute': value!.minute,
    };
  }

  /// Decode a ```TimeData``` object from JSON.
  static TimeData fromCloudObject(document) {
    return TimeData(
      value: TimeOfDay(
        hour: document['hour'],
        minute: document['minute'],
      ),
      importReference: null,
      encryptedValue: null,
    );
  }

  TimeData copyWith({
    TimeOfDay? value,
    String? importReference,
    Uint8List? encryptedValue,
  }) {
    return TimeData(
      value: value ?? this.value,
      importReference: importReference ?? this.importReference,
      encryptedValue: encryptedValue ?? this.encryptedValue,
    );
  }
}
