import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// Labels.
import '/main.dart';

// Schemas.
import '/data/models/field_types/location_data/schemas/db_location_data.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';

// Models.
import '/data/models/field_types/tags_data/tags_data.dart';

class LocationData extends Equatable {
  final String latitude;
  final String longitude;
  final String type;

  final TagsData tagsData;

  /// This can be null to enable not setting a value for createdAtInUtc when setting defaults.
  final DateTime? createdAtInUtc;

  /// This value can be used to save a "dumb" date as a default value.
  final String? defaultDate;

  /// This value can be used to save a "dumb" time as a default value.
  final String? defaultTime;

  /// This can be empty in case of default.
  final String createdAtTimezone;

  final String? importReferenceLatitude;
  final String? importReferenceLongitude;
  final String? importReferenceTags;
  final String? importReferenceDate;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedLatitude;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedLongitude;

  /// This is a state variable that should only be used during the encryption process.
  final Uint8List? encryptedType;

  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.tagsData,
    required this.defaultDate,
    required this.defaultTime,
    required this.importReferenceTags,
    required this.importReferenceLatitude,
    required this.importReferenceLongitude,
    required this.encryptedLatitude,
    required this.encryptedLongitude,
    required this.encryptedType,
    required this.createdAtInUtc,
    required this.createdAtTimezone,
    required this.importReferenceDate,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        type,
        tagsData,
        createdAtInUtc,
        defaultDate,
        defaultTime,
        createdAtTimezone,
        importReferenceDate,
        importReferenceTags,
        importReferenceLatitude,
        encryptedType,
        importReferenceLongitude,
        encryptedLatitude,
        encryptedLongitude,
      ];

  /// Initialize a new ```LocationData``` object.
  factory LocationData.initial() {
    return LocationData(
      latitude: '',
      longitude: '',
      type: 'Point',
      tagsData: TagsData.initial(),
      createdAtInUtc: null,
      defaultDate: null,
      defaultTime: null,
      createdAtTimezone: '',
      importReferenceDate: null,
      importReferenceLatitude: null,
      importReferenceLongitude: null,
      encryptedLatitude: null,
      encryptedLongitude: null,
      encryptedType: null,
      importReferenceTags: null,
    );
  }

  /// This getter can be used to access createdAt in a readable format.
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

  /// This getter can be used to access date value as string.
  /// * assumes valid latitude and longitude
  /// ```dart
  /// return 'lat: ${value.latitude}, lng: ${value.longitude}';
  /// ```
  String get getFormatedLocation {
    return 'lat: $latitude, lng: $longitude';
  }

  /// This getter can be used to check if lat and lng are both set.
  bool get getHasLatAndLng {
    if (latitude.trim().isNotEmpty && longitude.trim().isNotEmpty) return true;
    return false;
  }

  /// This getter can be used to parse ```latitude``` to a double.
  /// * This getter assumes that ```latitude``` is a valid double.
  double get latitudeAsDouble {
    return double.parse(latitude);
  }

  /// This getter can be used to parse ```longitude``` to a double.
  /// * This getter assumes that ```longitude``` is a valid double.
  double get longitudeAsDouble {
    return double.parse(longitude);
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required LocationData? locationData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (locationData == null) return false;

    // Check if latitude and longitude are set.
    final bool hasLat = locationData.latitude.trim().isNotEmpty;
    final bool hasLng = locationData.longitude.trim().isNotEmpty;
    final bool hasDate = locationData.createdAtInUtc != null;
    final bool hasTimezone = locationData.createdAtTimezone.isNotEmpty;
    final bool hasTags = locationData.tagsData.tagReferences.isNotEmpty;

    final bool hasDefaultDate = locationData.defaultDate != null && locationData.defaultDate!.isNotEmpty;
    final bool hasDefaultTime = locationData.defaultTime != null && locationData.defaultTime!.isNotEmpty;

    final bool hasLatRef = locationData.importReferenceLatitude != null && locationData.importReferenceLatitude!.trim().isNotEmpty;
    final bool hasLngRef = locationData.importReferenceLongitude != null && locationData.importReferenceLongitude!.trim().isNotEmpty;

    // In case of default, different cases apply.
    if (isDefault) {
      // If any value is set, return true.
      // * In default date should be null because defaultDate and defaultTime should be used.
      return [
        hasLat,
        hasLng,
        hasTags,
        hasDefaultDate,
        hasDefaultTime,
        hasTimezone,
      ].any((condition) => condition);
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import references.
      if (hasLatRef && hasLngRef) return true;

      // User set lat ref and a lng default.
      if (hasLatRef && hasLng) return true;

      // User set lng ref and a lat default.
      if (hasLngRef && hasLat) return true;

      // * User might also have set other default values but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if value is set.
    if (hasLat && hasLng && hasDate && hasTimezone) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required LocationData? locationData}) {
    if (locationData == null) return null;
    if (locationData.latitude.isEmpty) return null;
    if (locationData.longitude.isEmpty) return null;

    return '${locationData.latitude}, ${locationData.longitude}';
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` if ```latitude``` or ```longitude``` are invalid
  /// ```dart
  /// return '$fieldLabel · $getFormatedLocation';
  /// ```
  String? getSubtitle({required String fieldLabel}) {
    if (latitude.isEmpty) return null;
    if (longitude.isEmpty) return null;

    return '$fieldLabel · $getFormatedLocation';
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` if ```latitude``` or ```longitude``` are invalid
  /// ```dart
  /// return '$fieldLabel · $getFormatedLocation';
  /// ```
  String? getThirdline({required String fieldLabel}) {
    if (latitude.isEmpty) return null;
    if (longitude.isEmpty) return null;

    return '$fieldLabel · $getFormatedLocation';
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```LocationData``` object to a ```DbLocationData``` object.
  DbLocationData toSchema() {
    // Check if encryption was applied.
    final bool isEncrypted = encryptedLatitude?.isNotEmpty == true || encryptedLongitude?.isNotEmpty == true;

    return DbLocationData(
      // * If encryption was applied, remove value.
      latitude: isEncrypted ? null : latitude,
      longitude: isEncrypted ? null : longitude,
      type: isEncrypted ? null : type,
      tagsData: tagsData.toSchema(),
      // This can be null in case of default.
      createdAtInUtc: createdAtInUtc?.millisecondsSinceEpoch,
      defaultDate: defaultDate,
      defaultTime: defaultTime,
      createdAtTimezone: createdAtTimezone.isEmpty ? null : createdAtTimezone,
      importReferenceDate: importReferenceDate,
      importReferenceLatitude: importReferenceLatitude,
      importReferenceLongitude: importReferenceLongitude,
      importReferenceTags: importReferenceTags,
      encryptedLatitude: encryptedLatitude,
      encryptedLongitude: encryptedLongitude,
      encryptedType: encryptedType,
    );
  }

  /// Convert a ```DbLocationData``` object to a ```LocationData``` object.
  static LocationData? fromSchema({required DbLocationData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // * This manual conversion is needed here because in case of an import match schema.value might be null.
    final String latitude = schema.latitude == null ? '' : schema.latitude!;
    final String longitude = schema.longitude == null ? '' : schema.longitude!;

    return LocationData(
      // If encryption was applied, set value to a placeholder until decryption.
      latitude: schema.encryptedLatitude?.isNotEmpty == true ? '' : latitude,
      longitude: schema.encryptedLongitude?.isNotEmpty == true ? '' : longitude,
      type: schema.encryptedType?.isNotEmpty == true ? '' : schema.type!,
      tagsData: TagsData.fromSchema(schema: schema.tagsData)!,
      // * This can be null in case of defaults.
      createdAtInUtc: schema.createdAtInUtc == null ? null : DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc!, isUtc: true),
      defaultDate: schema.defaultDate,
      defaultTime: schema.defaultTime,
      // * This can be null in case of defaults.
      createdAtTimezone: schema.createdAtTimezone ?? "",
      importReferenceLatitude: schema.importReferenceLatitude,
      importReferenceLongitude: schema.importReferenceLongitude,
      importReferenceTags: schema.importReferenceTags,
      importReferenceDate: schema.importReferenceDate,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedLatitude: schema.encryptedLatitude != null ? Uint8List.fromList(schema.encryptedLatitude!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedLongitude: schema.encryptedLongitude != null ? Uint8List.fromList(schema.encryptedLongitude!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedType: schema.encryptedType != null ? Uint8List.fromList(schema.encryptedType!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```LocationData``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      // In case of default, these might be empty.
      'lat': latitude.isEmpty ? null : latitudeAsDouble,
      'lng': longitude.isEmpty ? null : longitudeAsDouble,
      // In case of default, this might be null.
      'created_at_in_utc': createdAtInUtc?.toIso8601String(),
      'default_date': defaultDate,
      'default_time': defaultTime,
      'timezone': createdAtTimezone.isEmpty ? null : createdAtTimezone,
      'type': type,
      'tags_data': tagsData.toCloudObject(),
    };
  }

  /// Decode a ```LocationData``` object from JSON.
  static LocationData fromCloudObject(document) {
    return LocationData(
      latitude: document['lat'].toString(),
      longitude: document['lng'].toString(),
      type: document['type'],
      // In case of default, this might be null.
      createdAtInUtc: document['created_at_in_utc'] == null ? null : DateTime.parse(document['created_at_in_utc']),
      defaultDate: document['default_date'],
      defaultTime: document['default_time'],
      // In case of default, this might be null.
      createdAtTimezone: document['timezone'] ?? "",
      tagsData: TagsData.fromCloudObject(document['tags_data']),
      importReferenceDate: null,
      importReferenceLatitude: null,
      importReferenceLongitude: null,
      importReferenceTags: null,
      encryptedLatitude: null,
      encryptedLongitude: null,
      encryptedType: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  LocationData copyWith({
    String? latitude,
    String? longitude,
    String? type,
    TagsData? tagsData,
    DateTime? createdAtInUtc,
    String? defaultDate,
    String? defaultTime,
    String? createdAtTimezone,
    String? importReferenceLatitude,
    String? importReferenceLongitude,
    String? importReferenceTags,
    String? importReferenceDate,
    Uint8List? encryptedLatitude,
    Uint8List? encryptedLongitude,
    Uint8List? encryptedType,
  }) {
    return LocationData(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      type: type ?? this.type,
      tagsData: tagsData ?? this.tagsData,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      defaultDate: defaultDate ?? this.defaultDate,
      defaultTime: defaultTime ?? this.defaultTime,
      createdAtTimezone: createdAtTimezone ?? this.createdAtTimezone,
      importReferenceLatitude: importReferenceLatitude ?? this.importReferenceLatitude,
      importReferenceLongitude: importReferenceLongitude ?? this.importReferenceLongitude,
      importReferenceTags: importReferenceTags ?? this.importReferenceTags,
      importReferenceDate: importReferenceDate ?? this.importReferenceDate,
      encryptedLatitude: encryptedLatitude ?? this.encryptedLatitude,
      encryptedLongitude: encryptedLongitude ?? this.encryptedLongitude,
      encryptedType: encryptedType ?? this.encryptedType,
    );
  }
}
