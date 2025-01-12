import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';

part 'db_location_data.g.dart';

@embedded
class DbLocationData {
  String? latitude;
  String? longitude;
  String? type;
  DbTagsData? tagsData;
  int? createdAtInUtc;
  String? defaultDate;
  String? defaultTime;
  String? createdAtTimezone;
  String? importReferenceDate;
  String? importReferenceLatitude;
  String? importReferenceLongitude;
  String? importReferenceTags;
  List<byte>? encryptedLatitude;
  List<byte>? encryptedLongitude;
  List<byte>? encryptedType;

  DbLocationData({
    this.latitude,
    this.longitude,
    this.type,
    this.tagsData,
    this.createdAtInUtc,
    this.defaultDate,
    this.defaultTime,
    this.createdAtTimezone,
    this.importReferenceDate,
    this.importReferenceTags,
    this.importReferenceLatitude,
    this.importReferenceLongitude,
    this.encryptedLatitude,
    this.encryptedLongitude,
    this.encryptedType,
  });
}
