import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// Cubit.
import '/logic/helper_functions/helper_functions.dart';

// Schemas.
import '/data/models/field_types/emotion_data/schemas/db_emotion_item.dart';

class EmotionItem extends Equatable {
  final String id;
  final String emotion;
  final int? intensity;
  final DateTime? occurrenceInUtc;
  final String occurrenceTimeZone;

  const EmotionItem({
    required this.id,
    required this.emotion,
    required this.intensity,
    required this.occurrenceInUtc,
    required this.occurrenceTimeZone,
  });

  /// Initialize a new ```EmotionItem``` object.
  /// * Id is only used in state, so a new id is assigned every time it gets loaded.
  factory EmotionItem.initial() {
    return EmotionItem(
      id: const Uuid().v4(),
      emotion: '',
      intensity: null,
      occurrenceInUtc: null,
      occurrenceTimeZone: '',
    );
  }

  @override
  List<Object?> get props => [id, emotion, intensity, occurrenceInUtc, occurrenceTimeZone];

  /// This getter can be used to access occurrence in a readable format.
  /// * Assumes values are not null.
  String getOccurence({required bool preserveUtc, String format = 'yyyy-MM-dd'}) {
    // Convert value.
    final DateTime converted = HelperFunctions.convertToTimezone(
      dateTimeInUtc: occurrenceInUtc!,
      timezone: occurrenceTimeZone,
      preserveUtc: preserveUtc,
    );

    return DateFormat(format).format(converted);
  }

  /// This getter can be used to access timezone in a readable format.
  String getOccurenceTimezone({required bool preserveUtc}) {
    // If the value was stored in utc, use local timezone.
    if (occurrenceTimeZone.isEmpty || occurrenceTimeZone == "UTC") {
      // If flag was set, return UTC timezone.
      if (preserveUtc) return "UTC";

      // Try and access local timezone.
      final String? localTimezone = HelperFunctions.getCurrentTimezone();

      // It seems like local timezone could not be accessed.
      if (localTimezone == null || localTimezone.isEmpty) return "UTC";

      return localTimezone;
    }

    // Otherwise return stored timezone.
    return occurrenceTimeZone;
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```EmotionItem``` object to a ```DbEmotionItem``` object.
  DbEmotionItem toSchema() {
    return DbEmotionItem(
      emotion: emotion,
      intensity: intensity,
      occurrenceInUtc: occurrenceInUtc!.millisecondsSinceEpoch,
      occurrenceTimeZone: occurrenceTimeZone.isEmpty ? null : occurrenceTimeZone,
    );
  }

  /// Convert a ```DbEmotionItem``` object to a ```EmotionItem``` object.
  static EmotionItem fromSchema({required DbEmotionItem schema}) {
    return EmotionItem(
      id: const Uuid().v4(),
      emotion: schema.emotion!,
      intensity: schema.intensity!,
      occurrenceInUtc: DateTime.fromMillisecondsSinceEpoch(schema.occurrenceInUtc!, isUtc: true),
      occurrenceTimeZone: schema.occurrenceTimeZone ?? "",
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode an ```EmotionItem``` object to JSON.
  Map<String, dynamic> toCloudObject() {
    return {
      'emotion': emotion,
      'intensity': intensity!,
      'occurrence_in_utc': occurrenceInUtc!.toIso8601String(),
      // * Can be null in case of default.
      'timezone': occurrenceTimeZone.isEmpty ? null : occurrenceTimeZone,
    };
  }

  /// Decode an ```EmotionItem``` object from JSON.
  factory EmotionItem.fromCloudObject(document) {
    return EmotionItem(
      id: const Uuid().v4(),
      emotion: document['emotion'],
      intensity: document['intensity'],
      occurrenceInUtc: DateTime.parse(document['occurrence_in_utc']),
      // In case of default, this might be null.
      occurrenceTimeZone: document['timezone'] ?? "",
    );
  }

  // ######################################
  // Copy With
  // ######################################

  EmotionItem copyWith({
    String? id,
    String? emotion,
    int? intensity,
    DateTime? occurrenceInUtc,
    String? occurrenceTimeZone,
  }) {
    return EmotionItem(
      id: id ?? this.id,
      emotion: emotion ?? this.emotion,
      intensity: intensity ?? this.intensity,
      occurrenceInUtc: occurrenceInUtc ?? this.occurrenceInUtc,
      occurrenceTimeZone: occurrenceTimeZone ?? this.occurrenceTimeZone,
    );
  }
}
