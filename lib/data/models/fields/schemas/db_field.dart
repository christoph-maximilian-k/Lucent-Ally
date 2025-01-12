import 'package:isar/isar.dart';

// Schemas.
import '/data/models/field_types/date_data/schemas/db_date_data.dart';
import '/data/models/field_types/date_and_time_data/schemas/db_date_and_time_data.dart';
import '/data/models/field_types/time_data/schemas/db_time_data.dart';
import '/data/models/field_types/date_of_birth_data/schemas/db_date_of_birth_data.dart';
import '/data/models/field_types/number_data/schemas/db_number_data.dart';
import '/data/models/field_types/money_data/schemas/db_money_data.dart';
import '/data/models/field_types/password_data/schemas/db_password_data.dart';
import '/data/models/field_types/phone_data/schemas/db_phone_data.dart';
import '/data/models/field_types/text_data/schemas/db_text_data.dart';
import '/data/models/field_types/email_data/schemas/db_email_data.dart';
import '/data/models/field_types/website_data/schemas/db_website_data.dart';
import '/data/models/field_types/username_data/schemas/db_username_data.dart';
import '/data/models/field_types/location_data/schemas/db_location_data.dart';
import '/data/models/field_types/image_data/schemas/db_image_data.dart';
import '/data/models/field_types/payment_data/schemas/db_payment_data.dart';
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';
import '/data/models/field_types/measurement_data/schemas/db_measurement_data.dart';
import '/data/models/field_types/emotion_data/schemas/db_emotion_data.dart';
import '/data/models/field_types/avatar_image_data/schemas/db_avatar_image_data.dart';
import '/data/models/field_types/boolean_data/schemas/db_boolean_data.dart';
import '/data/models/field_types/file_data/schemas/db_file_data.dart';

part 'db_field.g.dart';

@embedded
class DbField {
  String? fieldId;
  String? fieldType;
  bool? canChangeParameters;

  DbDateData? dateData;
  DbDateAndTimeData? dateAndTimeData;
  DbTimeData? timeData;

  DbDateOfBirthData? dateOfBirthData;

  DbNumberData? numberData;
  DbMoneyData? moneyData;
  DbPasswordData? passwordData;
  DbPhoneData? phoneData;
  DbTextData? textData;
  DbEmailData? emailData;
  DbWebsiteData? websiteData;
  DbUsernameData? usernameData;
  DbLocationData? locationData;
  DbImageData? imageData;
  DbFileData? fileData;
  DbPaymentData? paymentData;
  DbTagsData? tagsData;
  DbMeasurementData? measurementData;
  DbEmotionData? emotionData;
  DbAvatarImageData? avatarImageData;
  DbBooleanData? booleanData;

  DbField({
    this.fieldId,
    this.fieldType,
    this.canChangeParameters,
    this.dateData,
    this.dateAndTimeData,
    this.timeData,
    this.dateOfBirthData,
    this.numberData,
    this.moneyData,
    this.passwordData,
    this.phoneData,
    this.textData,
    this.emailData,
    this.websiteData,
    this.usernameData,
    this.locationData,
    this.imageData,
    this.fileData,
    this.paymentData,
    this.tagsData,
    this.measurementData,
    this.emotionData,
    this.avatarImageData,
    this.booleanData,
  });
}
