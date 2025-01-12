import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// User with labels.
import '/main.dart';

// Models.
import '/data/models/field_types/emotion_data/emotion_item.dart';
import '/data/models/chip_items/chip_item.dart';
import '/data/models/chip_items/chip_items.dart';

// Schemas.
import '/data/models/field_types/emotion_data/schemas/db_emotion_item.dart';
import '/data/models/field_types/emotion_data/schemas/db_emotion_data.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class EmotionData extends Equatable {
  final List<EmotionItem> emotions;

  final String? importReferenceEmotion;
  final String? importReferenceIntensity;
  final String? importReferenceOccurrence;

  final Uint8List? encryptedEmotions;
  final Uint8List? encryptedIntensities;
  final Uint8List? encryptedOccurrences;
  final Uint8List? encryptedTimezones;

  const EmotionData({
    required this.emotions,
    required this.importReferenceEmotion,
    required this.importReferenceIntensity,
    required this.importReferenceOccurrence,
    required this.encryptedEmotions,
    required this.encryptedIntensities,
    required this.encryptedOccurrences,
    required this.encryptedTimezones,
  });

  /// This can be used to initialize a ```EmotionData``` object.
  factory EmotionData.initial() {
    return const EmotionData(
      emotions: [],
      importReferenceEmotion: null,
      importReferenceIntensity: null,
      importReferenceOccurrence: null,
      encryptedEmotions: null,
      encryptedIntensities: null,
      encryptedOccurrences: null,
      encryptedTimezones: null,
    );
  }

  @override
  List<Object?> get props => [
        emotions,
        importReferenceEmotion,
        importReferenceIntensity,
        importReferenceOccurrence,
        encryptedEmotions,
        encryptedIntensities,
        encryptedOccurrences,
        encryptedTimezones,
      ];

  // ##############################
  // Emotions
  // ##############################

  /// Emotion identification for a happiness measurement.
  /// ```dart
  /// static const String emotionHappiness = 'happiness';
  /// ```
  static const String emotionHappiness = 'happiness';

  /// Emotion identification for a sadness measurement.
  /// ```dart
  /// static const String emotionSadness = 'sadness';
  /// ```
  static const String emotionSadness = 'sadness';

  /// Emotion identification for a fear measurement.
  /// ```dart
  /// static const String emotionFear = 'fear';
  /// ```
  static const String emotionFear = 'fear';

  /// Emotion identification for an anger measurement.
  /// ```dart
  /// static const String emotionAnger = 'anger';
  /// ```
  static const String emotionAnger = 'anger';

  /// Emotion identification for a surprise measurement.
  /// ```dart
  /// static const String emotionSurprise = 'surprise';
  /// ```
  static const String emotionSurprise = 'surprise';

  /// Emotion identification for a disgust measurement.
  /// ```dart
  /// static const String emotionDisgust = 'disgust';
  /// ```
  static const String emotionDisgust = 'disgust';

  /// Emotion identification for a melancholy measurement.
  /// ```dart
  /// static const String emotionMelancholy = 'melancholy';
  /// ```
  static const String emotionMelancholy = 'melancholy';

  /// Emotion identification for an enthusiasm measurement.
  /// ```dart
  /// static const String emotionEnthusiasm = 'enthusiasm';
  /// ```
  static const String emotionEnthusiasm = 'enthusiasm';

  /// Emotion identification for a contentment measurement.
  /// ```dart
  /// static const String emotionContentment = 'contentment';
  /// ```
  static const String emotionContentment = 'contentment';

  /// Emotion identification for a confusion measurement.
  /// ```dart
  /// static const String emotionConfusion = 'confusion';
  /// ```
  static const String emotionConfusion = 'confusion';

  /// Emotion identification for a bitterness measurement.
  /// ```dart
  /// static const String emotionBitterness = 'bitterness';
  /// ```
  static const String emotionBitterness = 'bitterness';

  /// Emotion identification for a nostalgia measurement.
  /// ```dart
  /// static const String emotionNostalgia = 'nostalgia';
  /// ```
  static const String emotionNostalgia = 'nostalgia';

  /// Emotion identification for a jealousy measurement.
  /// ```dart
  /// static const String emotionJealousy = 'jealousy';
  /// ```
  static const String emotionJealousy = 'jealousy';

  /// Emotion identification for a guilt measurement.
  /// ```dart
  /// static const String emotionGuilt = 'guilt';
  /// ```
  static const String emotionGuilt = 'guilt';

  /// Emotion identification for an anxiety measurement.
  /// ```dart
  /// static const String emotionAnxiety = 'anxiety';
  /// ```
  static const String emotionAnxiety = 'anxiety';

  /// Emotion identification for a curiosity measurement.
  /// ```dart
  /// static const String emotionCuriosity = 'curiosity';
  /// ```
  static const String emotionCuriosity = 'curiosity';

  /// Emotion identification for a compassion measurement.
  /// ```dart
  /// static const String emotionCompassion = 'compassion';
  /// ```
  static const String emotionCompassion = 'compassion';

  /// Emotion identification for a pride measurement.
  /// ```dart
  /// static const String emotionPride = 'pride';
  /// ```
  static const String emotionPride = 'pride';

  /// Emotion identification for a shame measurement.
  /// ```dart
  /// static const String emotionShame = 'shame';
  /// ```
  static const String emotionShame = 'shame';

  /// Emotion identification for a regret measurement.
  /// ```dart
  /// static const String emotionRegret = 'regret';
  /// ```
  static const String emotionRegret = 'regret';

  /// Emotion identification for an anticipation measurement.
  /// ```dart
  /// static const String emotionAnticipation = 'anticipation';
  /// ```
  static const String emotionAnticipation = 'anticipation';

  /// Emotion identification for a satisfaction measurement.
  /// ```dart
  /// static const String emotionSatisfaction = 'satisfaction';
  /// ```
  static const String emotionSatisfaction = 'satisfaction';

  /// Emotion identification for an arousal measurement.
  /// ```dart
  /// static const String emotionArousal = 'arousal';
  /// ```
  static const String emotionArousal = 'arousal';

  /// Emotion identification for a love measurement.
  /// ```dart
  /// static const String emotionLove = 'love';
  /// ```
  static const String emotionLove = 'love';

  /// Emotion identification for a hate measurement.
  /// ```dart
  /// static const String emotionHate = 'hate';
  /// ```
  static const String emotionHate = 'hate';

  /// Emotion identification for a irritation measurement.
  /// ```dart
  /// static const String emotionIrritation = 'irritation';
  /// ```
  static const String emotionIrritation = 'irritation';

  /// Emotion identification for a empathy measurement.
  /// ```dart
  /// static const String emotionEmpathy = 'empathy';
  /// ```
  static const String emotionEmpathy = 'empathy';

  /// Emotion identification for a resentment measurement.
  /// ```dart
  /// static const String emotionResentment = 'resentment';
  /// ```
  static const String emotionResentment = 'resentment';

  /// Emotion identification for a awe measurement.
  /// ```dart
  /// static const String emotionAwe = 'awe';
  /// ```
  static const String emotionAwe = 'awe';

  /// Emotion identification for a hope measurement.
  /// ```dart
  /// static const String emotionHope = 'hope';
  /// ```
  static const String emotionHope = 'hope';

  /// Emotion identification for a relief measurement.
  /// ```dart
  /// static const String emotionRelief = 'relief';
  /// ```
  static const String emotionRelief = 'relief';

  /// Emotion identification for a despair measurement.
  /// ```dart
  /// static const String emotionDespair = 'despair';
  /// ```
  static const String emotionDespair = 'despair';

  /// Emotion identification for a frustration measurement.
  /// ```dart
  /// static const String emotionFrustration = 'frustration';
  /// ```
  static const String emotionFrustration = 'frustration';

  /// Emotion identification for a gratitude measurement.
  /// ```dart
  /// static const String emotionGratitude = 'gratitude';
  /// ```
  static const String emotionGratitude = 'gratitude';

  /// Emotion identification for a envy measurement.
  /// ```dart
  /// static const String emotionEnvy = 'envy';
  /// ```
  static const String emotionEnvy = 'envy';

  /// Emotion identification for a loneliness measurement.
  /// ```dart
  /// static const String emotionLoneliness = 'loneliness';
  /// ```
  static const String emotionLoneliness = 'loneliness';

  /// Emotion identification for a boredom measurement.
  /// ```dart
  /// static const String emotionBoredom = 'boredom';
  /// ```
  static const String emotionBoredom = 'boredom';

  /// Emotion identification for a tiredness measurement.
  /// ```dart
  /// static const String emotionTiredness = 'tiredness';
  /// ```
  static const String emotionTiredness = 'tiredness';

  /// Emotion identification for a rested measurement.
  /// ```dart
  /// static const String emotionRested = 'rested';
  /// ```
  static const String emotionRested = 'rested';

  /// Emotion identification for a resignation measurement.
  /// ```dart
  /// static const String emotionResignation = 'resignation';
  /// ```
  static const String emotionResignation = 'resignation';

  /// Emotion identification for a discouraged measurement.
  /// ```dart
  /// static const String emotionDiscouraged = 'discouraged';
  /// ```
  static const String emotionDiscouraged = 'discouraged';

  /// This list contains emotions that are usually considered positive.
  static const List<String> positiveEmotions = [
    emotionHappiness,
    emotionEnthusiasm,
    emotionContentment,
    emotionCuriosity,
    emotionCompassion,
    emotionSatisfaction,
    emotionArousal,
    emotionLove,
    emotionEmpathy,
    emotionAwe,
    emotionHope,
    emotionRelief,
    emotionGratitude,
    emotionAnticipation,
  ];

  /// This list contains emotions that are usually considered negative.
  static const List<String> negativeEmotions = [
    emotionSadness,
    emotionFear,
    emotionAnger,
    emotionConfusion,
    emotionBitterness,
    emotionJealousy,
    emotionGuilt,
    emotionAnxiety,
    emotionShame,
    emotionRegret,
    emotionHate,
    emotionIrritation,
    emotionResentment,
    emotionDespair,
    emotionFrustration,
    emotionEnvy,
    emotionLoneliness,
    emotionResignation,
    emotionDiscouraged,
  ];

  /// This getter can be used to determine if a emotion is positive.
  bool isPositiveEmotion({required EmotionItem emotionItem}) {
    if (positiveEmotions.contains(emotionItem.emotion)) return true;
    return false;
  }

  /// This getter can be used to determine if a emotion is negative.
  bool isNegativeEmotion({required EmotionItem emotionItem}) {
    if (negativeEmotions.contains(emotionItem.emotion)) return true;
    return false;
  }

  /// This method can be used to access emotions in String format.
  /// * Returns ```""``` if ```emotionData == null``` or ```emotionData.emotions.isEmpty```.
  static String emotionsToString({required EmotionData? emotionData}) {
    // Check for null and empty.
    if (emotionData == null || emotionData.emotions.isEmpty) return "";

    // Init helper.
    List<String> labels = [];

    // Access emotions.
    for (final EmotionItem element in emotionData.emotions) {
      // Add emotion.
      labels.add(element.emotion);
    }

    // Convert to csv save list.
    final String listAsString = labels.join(',');

    return listAsString;
  }

  /// This method can be used to access intensities in String format.
  /// * Returns ```""``` if ```emotionData == null``` or ```emotionData.emotions.isEmpty```.
  static String intensitiesToString({required EmotionData? emotionData}) {
    // Check for null and empty.
    if (emotionData == null || emotionData.emotions.isEmpty) return "";

    // Init helper.
    List<String> labels = [];

    // Access emotions.
    for (final EmotionItem element in emotionData.emotions) {
      // Add emotion.
      labels.add(element.intensity.toString());
    }

    // Convert to csv save list.
    final String listAsString = labels.join(',');

    return listAsString;
  }

  /// This method can be used to access occurrences in String format.
  /// * Returns ```""``` if ```emotionData == null``` or ```emotionData.emotions.isEmpty```.
  static String occurrencesToString({required EmotionData? emotionData}) {
    // Check for null and empty.
    if (emotionData == null || emotionData.emotions.isEmpty) return "";

    // Init helper.
    List<String> labels = [];

    // Access emotions.
    for (final EmotionItem element in emotionData.emotions) {
      // Add emotion.
      labels.add(element.getOccurence(preserveUtc: true));
    }

    // Convert to csv save list.
    final String listAsString = labels.join(',');

    return listAsString;
  }

  /// This method can be used to access timezones in String format.
  /// * Returns ```""``` if ```emotionData == null``` or ```emotionData.emotions.isEmpty```.
  static String timezonesToString({required EmotionData? emotionData}) {
    // Check for null and empty.
    if (emotionData == null || emotionData.emotions.isEmpty) return "";

    // Init helper.
    List<String> labels = [];

    // Access emotions.
    for (final EmotionItem element in emotionData.emotions) {
      // Add emotion.
      labels.add(element.getOccurenceTimezone(preserveUtc: true));
    }

    // Convert to csv save list.
    final String listAsString = labels.join(',');

    return listAsString;
  }

  /// This method can be used to access Emotions and their translations.
  static Map<String, String> emotionsByTypeAndLanguage() {
    return {
      emotionHappiness: labels.emotionHappiness(),
      emotionSadness: labels.emotionSadness(),
      emotionFear: labels.emotionFear(),
      emotionAnger: labels.emotionAnger(),
      emotionSurprise: labels.emotionSurprise(),
      emotionDisgust: labels.emotionDisgust(),
      emotionMelancholy: labels.emotionMelancholy(),
      emotionEnthusiasm: labels.emotionEnthusiasm(),
      emotionContentment: labels.emotionContentment(),
      emotionConfusion: labels.emotionConfusion(),
      emotionBitterness: labels.emotionBitterness(),
      emotionNostalgia: labels.emotionNostalgia(),
      emotionJealousy: labels.emotionJealousy(),
      emotionGuilt: labels.emotionGuilt(),
      emotionAnxiety: labels.emotionAnxiety(),
      emotionCuriosity: labels.emotionCuriosity(),
      emotionCompassion: labels.emotionCompassion(),
      emotionPride: labels.emotionPride(),
      emotionShame: labels.emotionShame(),
      emotionRegret: labels.emotionRegret(),
      emotionAnticipation: labels.emotionAnticipation(),
      emotionSatisfaction: labels.emotionSatisfaction(),
      emotionArousal: labels.emotionArousal(),
      emotionLove: labels.emotionLove(),
      emotionHate: labels.emotionHate(),
      emotionIrritation: labels.emotionIrritation(),
      emotionEmpathy: labels.emotionEmpathy(),
      emotionResentment: labels.emotionResentment(),
      emotionAwe: labels.emotionAwe(),
      emotionHope: labels.emotionHope(),
      emotionRelief: labels.emotionRelief(),
      emotionDespair: labels.emotionDespair(),
      emotionFrustration: labels.emotionFrustration(),
      emotionGratitude: labels.emotionGratitude(),
      emotionEnvy: labels.emotionEnvy(),
      emotionLoneliness: labels.emotionLoneliness(),
      emotionBoredom: labels.emotionBoredom(),
      emotionTiredness: labels.emotionTiredness(),
      emotionRested: labels.emotionRested(),
      emotionResignation: labels.emotionResignation(),
      emotionDiscouraged: labels.emotionDiscouraged(),
    };
  }

  /// This getter can be used to access categories as PickerItems.
  static PickerItems emotionsAsPickerItems() {
    return PickerItems(
      items: [
        PickerItem(
          id: emotionHappiness,
          label: labels.emotionHappiness(),
        ),
        PickerItem(
          id: emotionSadness,
          label: labels.emotionSadness(),
        ),
        PickerItem(
          id: emotionFear,
          label: labels.emotionFear(),
        ),
        PickerItem(
          id: emotionAnger,
          label: labels.emotionAnger(),
        ),
        PickerItem(
          id: emotionSurprise,
          label: labels.emotionSurprise(),
        ),
        PickerItem(
          id: emotionDisgust,
          label: labels.emotionDisgust(),
        ),
        PickerItem(
          id: emotionMelancholy,
          label: labels.emotionMelancholy(),
        ),
        PickerItem(
          id: emotionEnthusiasm,
          label: labels.emotionEnthusiasm(),
        ),
        PickerItem(
          id: emotionContentment,
          label: labels.emotionContentment(),
        ),
        PickerItem(
          id: emotionConfusion,
          label: labels.emotionConfusion(),
        ),
        PickerItem(
          id: emotionBitterness,
          label: labels.emotionBitterness(),
        ),
        PickerItem(
          id: emotionNostalgia,
          label: labels.emotionNostalgia(),
        ),
        PickerItem(
          id: emotionJealousy,
          label: labels.emotionJealousy(),
        ),
        PickerItem(
          id: emotionGuilt,
          label: labels.emotionGuilt(),
        ),
        PickerItem(
          id: emotionAnxiety,
          label: labels.emotionAnxiety(),
        ),
        PickerItem(
          id: emotionCuriosity,
          label: labels.emotionCuriosity(),
        ),
        PickerItem(
          id: emotionCompassion,
          label: labels.emotionCompassion(),
        ),
        PickerItem(
          id: emotionPride,
          label: labels.emotionPride(),
        ),
        PickerItem(
          id: emotionShame,
          label: labels.emotionShame(),
        ),
        PickerItem(
          id: emotionRegret,
          label: labels.emotionRegret(),
        ),
        PickerItem(
          id: emotionAnticipation,
          label: labels.emotionAnticipation(),
        ),
        PickerItem(
          id: emotionSatisfaction,
          label: labels.emotionSatisfaction(),
        ),
        PickerItem(
          id: emotionArousal,
          label: labels.emotionArousal(),
        ),
        PickerItem(
          id: emotionLove,
          label: labels.emotionLove(),
        ),
        PickerItem(
          id: emotionHate,
          label: labels.emotionHate(),
        ),
        PickerItem(
          id: emotionIrritation,
          label: labels.emotionIrritation(),
        ),
        PickerItem(
          id: emotionEmpathy,
          label: labels.emotionEmpathy(),
        ),
        PickerItem(
          id: emotionResentment,
          label: labels.emotionResentment(),
        ),
        PickerItem(
          id: emotionAwe,
          label: labels.emotionAwe(),
        ),
        PickerItem(
          id: emotionHope,
          label: labels.emotionHope(),
        ),
        PickerItem(
          id: emotionRelief,
          label: labels.emotionRelief(),
        ),
        PickerItem(
          id: emotionDespair,
          label: labels.emotionDespair(),
        ),
        PickerItem(
          id: emotionFrustration,
          label: labels.emotionFrustration(),
        ),
        PickerItem(
          id: emotionGratitude,
          label: labels.emotionGratitude(),
        ),
        PickerItem(
          id: emotionEnvy,
          label: labels.emotionEnvy(),
        ),
        PickerItem(
          id: emotionLoneliness,
          label: labels.emotionLoneliness(),
        ),
        PickerItem(
          id: emotionBoredom,
          label: labels.emotionBoredom(),
        ),
        PickerItem(
          id: emotionTiredness,
          label: labels.emotionTiredness(),
        ),
        PickerItem(
          id: emotionRested,
          label: labels.emotionRested(),
        ),
        PickerItem(
          id: emotionResignation,
          label: labels.emotionResignation(),
        ),
        PickerItem(
          id: emotionDiscouraged,
          label: labels.emotionDiscouraged(),
        ),
      ],
    ).sortAtoZ;
  }

  /// This method can be used to indicate if this field should be included to being saved to local storage.
  static bool includeField({required EmotionData? emotionData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (emotionData == null) return false;

    // Convenience variables.
    final bool hasData = emotionData.emotions.isNotEmpty;

    final bool hasEmotionRef = emotionData.importReferenceEmotion != null && emotionData.importReferenceEmotion!.trim().isNotEmpty;
    final bool hasIntensityRef = emotionData.importReferenceIntensity != null && emotionData.importReferenceIntensity!.trim().isNotEmpty;
    final bool hasOccurenceRef = emotionData.importReferenceOccurrence != null && emotionData.importReferenceOccurrence!.trim().isNotEmpty;

    // * User is in set default mode.
    if (isDefault) {
      // User set a default value.
      if (hasData) return true;

      return false;
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import reference.
      if (hasEmotionRef && hasIntensityRef && hasOccurenceRef) return true;

      // * User might also have set a default value but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if value is set.
    if (hasData) return true;

    return false;
  }

  /// This method can be used to turn emotion data into chipn items.
  ChipItems toChipItems({required bool isLoading}) {
    // Init helper.
    List<ChipItem> helper = [];

    // Access translated emotions.
    final Map<String, String> translatedEmotions = emotionsByTypeAndLanguage();

    for (final EmotionItem element in emotions) {
      // Convert Emotion item into a ChipItem.
      final ChipItem item = ChipItem.initial().copyWith(
        label: '${translatedEmotions[element.emotion]} · ${element.intensity} · ${element.getOccurence(preserveUtc: true)}',
      );

      helper.add(item);
    }

    return ChipItems(
      isLoading: isLoading,
      items: helper,
    );
  }

  /// This method can be used to remove specified item from list.
  EmotionData removeById({required String id}) {
    // Create helper.
    List<EmotionItem> helper = [];

    for (final EmotionItem element in emotions) {
      // Exclude specified item.
      if (element.id == id) continue;

      // Add all other items.
      helper.add(element);
    }

    return copyWith(emotions: helper);
  }

  // ######################################
  // Pie Chart Instructions
  // ######################################

  /// Pie Chart identification to display proportion of positive and negative emotions.
  /// ```dart
  /// static const String pieChartPositiveAndNegativeEmotionsProportion = 'positive_negative_proportion';
  /// ```
  static const String pieChartPositiveAndNegativeEmotionsProportion = 'positive_negative_proportion';

  // ######################################
  // Bar Chart Instructions
  // ######################################

  /// Bar Chart identification to display average intensity by emotion.
  /// ```dart
  /// static const String barChartAverageIntensityByEmotion = 'average_intensity_by_emotion';
  /// ```
  static const String barChartAverageIntensityByEmotion = 'average_intensity_by_emotion';

  /// Bar Chart identification to display average wellbeing over time.
  /// ```dart
  /// static const String barChartAverageWellbeing = 'average_wellbeing';
  /// ```
  static const String barChartAverageWellbeing = 'average_wellbeing';

  // ######################################
  // Database
  // ######################################

  /// Convert a ```EmotionData``` object to a ```DbEmotionData``` object.
  DbEmotionData toSchema() {
    // Create helpers.
    final bool hasEncryptedEmotions = encryptedEmotions != null && encryptedEmotions!.isNotEmpty;
    final bool hasEncryptedIntensities = encryptedIntensities != null && encryptedIntensities!.isNotEmpty;
    final bool hasEncryptedOccurrences = encryptedOccurrences != null && encryptedOccurrences!.isNotEmpty;
    final bool hasEncryptedTimezones = encryptedTimezones != null && encryptedTimezones!.isNotEmpty;

    final bool isEncryption = hasEncryptedEmotions || hasEncryptedIntensities || hasEncryptedOccurrences || hasEncryptedTimezones;

    List<DbEmotionItem> helper = [];

    // This is only needed if data is NOT encrypted.
    if (isEncryption == false) {
      for (final EmotionItem element in emotions) {
        // Convert to schema.
        final DbEmotionItem schema = element.toSchema();

        // Add to list.
        helper.add(schema);
      }
    }

    return DbEmotionData(
      // If encryption was applied, remove value.
      emotions: isEncryption ? null : helper,
      importReferenceEmotion: importReferenceEmotion,
      importReferenceIntensity: importReferenceIntensity,
      importReferenceOccurrence: importReferenceOccurrence,
      encryptedEmotions: encryptedEmotions,
      encryptedIntensities: encryptedIntensities,
      encryptedOccurrences: encryptedOccurrences,
      encryptedTimezones: encryptedTimezones,
    );
  }

  /// Convert a ```DbEmotionData``` object to a ```EmotionData``` object.
  static EmotionData? fromSchema({required DbEmotionData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Create helpers.
    final bool hasEncryptedEmotions = schema.encryptedEmotions != null && schema.encryptedEmotions!.isNotEmpty;
    final bool hasEncryptedIntensities = schema.encryptedIntensities != null && schema.encryptedIntensities!.isNotEmpty;
    final bool hasEncryptedOccurrences = schema.encryptedOccurrences != null && schema.encryptedOccurrences!.isNotEmpty;
    final bool hasEncryptedTimezones = schema.encryptedTimezones != null && schema.encryptedTimezones!.isNotEmpty;

    final bool isEncryption = hasEncryptedEmotions || hasEncryptedIntensities || hasEncryptedOccurrences || hasEncryptedTimezones;

    // Init helper.
    List<EmotionItem> helper = [];

    // This is only needed if data was NOT encrypted.
    if (isEncryption == false) {
      for (final DbEmotionItem element in schema.emotions!) {
        // Convert item.
        final EmotionItem item = EmotionItem.fromSchema(schema: element);

        // Add to helper.
        helper.add(item);
      }
    }

    return EmotionData(
      // If encryption was applied, set value to a placeholder until decryption.
      emotions: isEncryption ? const [] : helper,
      importReferenceEmotion: schema.importReferenceEmotion,
      importReferenceIntensity: schema.importReferenceIntensity,
      importReferenceOccurrence: schema.importReferenceOccurrence,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedEmotions: schema.encryptedEmotions != null ? Uint8List.fromList(schema.encryptedEmotions!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedIntensities: schema.encryptedIntensities != null ? Uint8List.fromList(schema.encryptedIntensities!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedOccurrences: schema.encryptedOccurrences != null ? Uint8List.fromList(schema.encryptedOccurrences!) : null,
      // If encryption was applied, convert to suitable format for decryption.
      encryptedTimezones: schema.encryptedTimezones != null ? Uint8List.fromList(schema.encryptedTimezones!) : null,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```EmotionData``` object to JSON.
  List<Map<String, dynamic>> toCloudObject() {
    // Create helper.
    List<Map<String, dynamic>> helper = [];

    for (final EmotionItem item in emotions) {
      // Convert to map.
      final Map<String, dynamic> json = item.toCloudObject();

      // Add to helper.
      helper.add(json);
    }

    return helper;
  }

  /// Decode a ```EmotionData``` object from JSON.
  static EmotionData fromCloudObject(document) {
    // Create helper.
    List<EmotionItem> helper = [];

    for (final Map<String, dynamic> element in document['emotions']) {
      // Convert to EmotionItem.
      final EmotionItem item = EmotionItem.fromCloudObject(element);
      // Add to helper.
      helper.add(item);
    }

    return EmotionData(
      emotions: helper,
      importReferenceEmotion: null,
      importReferenceIntensity: null,
      importReferenceOccurrence: null,
      encryptedEmotions: null,
      encryptedIntensities: null,
      encryptedOccurrences: null,
      encryptedTimezones: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  EmotionData copyWith({
    List<EmotionItem>? emotions,
    String? importReferenceEmotion,
    String? importReferenceIntensity,
    String? importReferenceOccurrence,
    Uint8List? encryptedEmotions,
    Uint8List? encryptedIntensities,
    Uint8List? encryptedOccurrences,
    Uint8List? encryptedTimezones,
  }) {
    return EmotionData(
      emotions: emotions ?? this.emotions,
      importReferenceEmotion: importReferenceEmotion ?? this.importReferenceEmotion,
      importReferenceIntensity: importReferenceIntensity ?? this.importReferenceIntensity,
      importReferenceOccurrence: importReferenceOccurrence ?? this.importReferenceOccurrence,
      encryptedEmotions: encryptedEmotions ?? this.encryptedEmotions,
      encryptedIntensities: encryptedIntensities ?? this.encryptedIntensities,
      encryptedOccurrences: encryptedOccurrences ?? this.encryptedOccurrences,
      encryptedTimezones: encryptedTimezones ?? this.encryptedTimezones,
    );
  }
}
