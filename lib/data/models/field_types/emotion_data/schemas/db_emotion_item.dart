import 'package:isar/isar.dart';

part 'db_emotion_item.g.dart';

@embedded
class DbEmotionItem {
  String? emotion;
  int? intensity;
  int? occurrenceInUtc;
  String? occurrenceTimeZone;

  DbEmotionItem({
    this.emotion,
    this.intensity,
    this.occurrenceInUtc,
    this.occurrenceTimeZone,
  });
}
