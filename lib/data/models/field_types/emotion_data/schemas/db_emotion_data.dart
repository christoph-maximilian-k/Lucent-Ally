import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_types/emotion_data/schemas/db_emotion_item.dart';

part 'db_emotion_data.g.dart';

@embedded
class DbEmotionData {
  List<DbEmotionItem>? emotions;

  String? importReferenceEmotion;
  String? importReferenceIntensity;
  String? importReferenceOccurrence;

  List<byte>? encryptedEmotions;
  List<byte>? encryptedIntensities;
  List<byte>? encryptedOccurrences;
  List<byte>? encryptedTimezones;

  DbEmotionData({
    this.emotions,
    this.importReferenceEmotion,
    this.importReferenceIntensity,
    this.importReferenceOccurrence,
    this.encryptedEmotions,
    this.encryptedIntensities,
    this.encryptedOccurrences,
    this.encryptedTimezones,
  });
}
