import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';
import '/config/country_specification.dart';

// Labels.
import '/main.dart';

// Schemas.
import '/data/models/fields/schemas/db_field.dart';

// Logic.
import '/logic/helper_functions/helper_functions.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';

// Models.
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/failure.dart';
import '/data/models/field_types/payment_data/share_reference.dart';
import '/data/models/field_types/payment_data/share_references.dart';
import '/data/models/import_specifications/import_specifications.dart';
import '/data/models/members/member.dart';
import '/data/models/references/member_to_import_reference/member_to_import_reference.dart';
import '/data/models/references/member_to_import_reference/member_to_import_references.dart';
import '/data/models/tags/tag.dart';
import '/data/models/field_types/date_data/date_data.dart';
import '/data/models/field_types/date_and_time_data/date_and_time_data.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/password_data/password_data.dart';
import '/data/models/field_types/phone_data/phone_data.dart';
import '/data/models/field_types/text_data/text_data.dart';
import '/data/models/field_types/time_data/time_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/website_data/website_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/field_types/image_data/image_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/emotion_data/emotion_item.dart';
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/exchange_rates/exchange_rates.dart';
import '/data/models/field_types/file_data/file_data.dart';

// TODO: "Rating" field (new_feature).

class Field extends Equatable with HelperFunctions {
  final String fieldId;
  final String fieldType;

  final bool canChangeParameters;

  final DateData? dateData;
  final NumberData? numberData;
  final MoneyData? moneyData;
  final PasswordData? passwordData;
  final PhoneData? phoneData;
  final TextData? textData;
  final TimeData? timeData;
  final EmailData? emailData;
  final WebsiteData? websiteData;
  final UsernameData? usernameData;
  final DateAndTimeData? dateAndTimeData;
  final LocationData? locationData;
  final ImageData? imageData;
  final FileData? fileData;
  final PaymentData? paymentData;
  final DateOfBirthData? dateOfBirthData;
  final TagsData? tagsData;
  final MeasurementData? measurementData;
  final EmotionData? emotionData;
  final AvatarImageData? avatarImageData;
  final BooleanData? booleanData;

  const Field({
    required this.fieldId,
    required this.fieldType,
    required this.canChangeParameters,
    required this.dateData,
    required this.numberData,
    required this.moneyData,
    required this.passwordData,
    required this.phoneData,
    required this.textData,
    required this.timeData,
    required this.emailData,
    required this.websiteData,
    required this.usernameData,
    required this.dateAndTimeData,
    required this.locationData,
    required this.imageData,
    required this.paymentData,
    required this.dateOfBirthData,
    required this.tagsData,
    required this.measurementData,
    required this.emotionData,
    required this.avatarImageData,
    required this.booleanData,
    required this.fileData,
  });

  @override
  List<Object?> get props => [
        fieldId,
        fieldType,
        canChangeParameters,
        textData,
        passwordData,
        phoneData,
        dateData,
        timeData,
        numberData,
        emailData,
        websiteData,
        usernameData,
        dateAndTimeData,
        locationData,
        imageData,
        moneyData,
        paymentData,
        dateOfBirthData,
        tagsData,
        measurementData,
        emotionData,
        avatarImageData,
        booleanData,
        fileData,
      ];

  /// Initialize a new ```Field``` object.
  factory Field.initial({required String fieldId, required String fieldType}) {
    return Field(
      fieldId: fieldId,
      fieldType: fieldType,
      canChangeParameters: true,
      textData: fieldType == fieldTypeText ? TextData.initial() : null,
      passwordData: fieldType == fieldTypePassword ? PasswordData.initial() : null,
      phoneData: fieldType == fieldTypePhone ? PhoneData.initial() : null,
      dateData: fieldType == fieldTypeDate ? DateData.initial() : null,
      timeData: fieldType == fieldTypeTimeOfDay ? TimeData.initial() : null,
      numberData: fieldType == fieldTypeNumber ? NumberData.initial() : null,
      moneyData: fieldType == fieldTypeMoney ? MoneyData.initial() : null,
      emailData: fieldType == fieldTypeEmail ? EmailData.initial() : null,
      websiteData: fieldType == fieldTypeWebsite ? WebsiteData.initial() : null,
      usernameData: fieldType == fieldTypeUsername ? UsernameData.initial() : null,
      dateAndTimeData: fieldType == fieldTypeDateAndTime ? DateAndTimeData.initial() : null,
      locationData: fieldType == fieldTypeLocation ? LocationData.initial() : null,
      imageData: fieldType == fieldTypeImages ? ImageData.initial() : null,
      fileData: fieldType == fieldTypeFiles ? FileData.initial() : null,
      paymentData: fieldType == fieldTypePayment ? PaymentData.initial() : null,
      dateOfBirthData: fieldType == fieldTypeDateOfBirth ? DateOfBirthData.initial() : null,
      tagsData: fieldType == fieldTypeTags ? TagsData.initial() : null,
      measurementData: fieldType == fieldTypeMeasurement ? MeasurementData.initial() : null,
      emotionData: fieldType == fieldTypeEmotion ? EmotionData.initial() : null,
      avatarImageData: fieldType == fieldTypeAvatarImage ? AvatarImageData.initial() : null,
      booleanData: fieldType == fieldTypeBoolean ? BooleanData.initial() : null,
    );
  }

  // ######################################
  // Statics
  // ######################################

  /// Field identification for a boolean field.
  /// ```dart
  /// static const String fieldTypeBoolean = 'boolean_data';
  /// ```
  static const String fieldTypeBoolean = 'boolean_data';

  /// Field identification for a avatar image field.
  /// ```dart
  /// static const String fieldTypeAvatarImage = 'avatar_image';
  /// ```
  static const String fieldTypeAvatarImage = 'avatar_image';

  /// Field identification for a emotion field.
  /// ```dart
  /// static const String fieldTypeEmotion = 'emotion';
  /// ```
  static const String fieldTypeEmotion = 'emotion';

  /// Field identification for a measurement field.
  /// ```dart
  /// static const String fieldTypeMeasurement = 'measurement';
  /// ```
  static const String fieldTypeMeasurement = 'measurement';

  /// Field identification for a text field.
  /// ```dart
  /// static const String fieldTypeText = 'text';
  /// ```
  static const String fieldTypeText = 'text';

  /// Field identification for a password field.
  /// ```dart
  /// static const String fieldTypePassword = 'password';
  /// ```
  static const String fieldTypePassword = 'password';

  /// Field identification for a phone field.
  /// ```dart
  /// static const String fieldTypePhone = 'phone';
  /// ```
  static const String fieldTypePhone = 'phone';

  /// Field identification for a date field.
  /// ```dart
  /// static const String fieldTypeDate = 'date';
  /// ```
  static const String fieldTypeDate = 'date';

  /// Field identification for a date field.
  /// ```dart
  /// static const String fieldTypeDateAndTime = 'date_and_time';
  /// ```
  static const String fieldTypeDateAndTime = 'date_and_time';

  /// Field identification for a number field.
  /// ```dart
  /// static const String fieldTypeNumber = 'number';
  /// ```
  static const String fieldTypeNumber = 'number';

  /// Field identification for a money field.
  /// ```dart
  /// static const String fieldTypeMoney = 'money';
  /// ```
  static const String fieldTypeMoney = 'money';

  /// Field identification for a time of day field.
  /// ```dart
  /// static const String fieldTypeTimeOfDay = 'time_of_day';
  /// ```
  static const String fieldTypeTimeOfDay = 'time_of_day';

  /// Field identification for a email field.
  /// ```dart
  /// static const String fieldTypeEmail = 'email';
  /// ```
  static const String fieldTypeEmail = 'email';

  /// Field identification for a website field.
  /// ```dart
  /// static const String fieldTypeWebsite = 'website';
  /// ```
  static const String fieldTypeWebsite = 'website';

  /// Field identification for a username field.
  /// ```dart
  /// static const String fieldTypeUsername = 'username';
  /// ```
  static const String fieldTypeUsername = 'username';

  /// Field identification for a location field.
  /// ```dart
  /// static const String fieldTypeLocation = 'location';
  /// ```
  static const String fieldTypeLocation = 'location';

  /// Field identification for an images field.
  /// ```dart
  /// static const String fieldTypeImages = 'images';
  /// ```
  static const String fieldTypeImages = 'images';

  /// Field identification for a files field.
  /// ```dart
  /// static const String fieldTypeFiles = 'files';
  /// ```
  static const String fieldTypeFiles = 'files';

  /// Field identification for a payment field.
  /// ```dart
  /// static const String fieldTypePayment = 'payment';
  /// ```
  static const String fieldTypePayment = 'payment';

  /// Field identification for a date of birth field.
  /// ```dart
  /// static const String fieldTypeDateOfBirth = 'date_of_birth';
  /// ```
  static const String fieldTypeDateOfBirth = 'date_of_birth';

  /// Field identification for a tags field.
  /// ```dart
  /// static const String fieldTypeTags = 'tags';
  /// ```
  static const String fieldTypeTags = 'tags';

  /// Field identification for an entry field.
  /// ```dart
  /// static const String fieldTypeEntry = 'entry';
  /// ```
  static const String fieldTypeEntry = 'entry';

  /// This list specifies which types have charts available.
  static const List<String> chartsAvailable = [
    fieldTypePayment,
    fieldTypeNumber,
    fieldTypeBoolean,
    fieldTypeEmail,
    fieldTypeUsername,
    fieldTypeAvatarImage,
    fieldTypeDateOfBirth,
    fieldTypeMoney,
    fieldTypeTags,
    fieldTypeEmotion,
    fieldTypeMeasurement,
  ];

  /// This method can be used to access FieldTypes and their translations.
  static Map<String, String> fieldsByTypeAndLanguage() {
    return {
      fieldTypeDate: labels.fieldTypeDate(),
      fieldTypeDateAndTime: labels.fieldTypeDateAndTime(),
      fieldTypeDateOfBirth: labels.fieldTypeDateOfBirth(),
      fieldTypeEmail: labels.fieldTypeEmail(),
      fieldTypePayment: labels.fieldTypePayment(),
      fieldTypeImages: labels.fieldTypeImages(),
      fieldTypeFiles: labels.fieldTypeFiles(),
      fieldTypeLocation: labels.fieldTypeLocation(),
      fieldTypeMoney: labels.fieldTypeMoney(),
      fieldTypeNumber: labels.fieldTypeNumber(),
      fieldTypePassword: labels.fieldTypePassword(),
      fieldTypePhone: labels.fieldTypePhone(),
      fieldTypeTags: labels.fieldTypeTags(),
      fieldTypeText: labels.fieldTypeText(),
      fieldTypeTimeOfDay: labels.fieldTypeTimeOfDay(),
      fieldTypeUsername: labels.fieldTypeUsername(),
      fieldTypeWebsite: labels.fieldTypeWebsite(),
      fieldTypeMeasurement: labels.fieldTypeMeasurement(),
      fieldTypeEmotion: labels.fieldTypeEmotion(),
      fieldTypeAvatarImage: labels.fieldTypeAvatarImage(),
      fieldTypeBoolean: labels.fieldTypeBoolean(),
    };
  }

  /// Get [PickerItems] for all fields.
  /// * ```id = fieldType```
  /// * Translates labels.
  /// * Only shows specific types if this is a shared model entry.
  static Future<PickerItems> fieldsAsPickerItems({required bool isShared, required bool isImport}) async {
    // Create items.
    final List<PickerItem> items = [
      PickerItem(
        id: fieldTypeEmail,
        label: labels.fieldTypeEmail(),
      ),
      PickerItem(
        id: fieldTypeUsername,
        label: labels.fieldTypeUsername(),
      ),
      PickerItem(
        id: fieldTypeBoolean,
        label: labels.fieldTypeBoolean(),
      ),
      if (isImport == false && isShared == false)
        PickerItem(
          id: fieldTypeAvatarImage,
          label: labels.fieldTypeAvatarImage(),
        ),
      if (isShared == false)
        PickerItem(
          id: fieldTypePassword,
          label: labels.fieldTypePassword(),
        ),
      PickerItem(
        id: fieldTypeDateOfBirth,
        label: labels.fieldTypeDateOfBirth(),
      ),
      PickerItem(
        id: fieldTypePhone,
        label: labels.fieldTypePhone(),
      ),
      PickerItem(
        id: fieldTypeWebsite,
        label: labels.fieldTypeWebsite(),
      ),
      PickerItem(
        id: fieldTypeText,
        label: labels.fieldTypeText(),
      ),
      PickerItem(
        id: fieldTypeNumber,
        label: labels.fieldTypeNumber(),
      ),
      PickerItem(
        id: fieldTypeMoney,
        label: labels.fieldTypeMoney(),
      ),
      PickerItem(
        id: fieldTypePayment,
        label: labels.fieldTypePayment(),
      ),
      PickerItem(
        id: fieldTypeDate,
        label: labels.fieldTypeDate(),
      ),
      PickerItem(
        id: fieldTypeTimeOfDay,
        label: labels.fieldTypeTimeOfDay(),
      ),
      PickerItem(
        id: fieldTypeDateAndTime,
        label: labels.fieldTypeDateAndTime(),
      ),
      PickerItem(
        id: fieldTypeLocation,
        label: labels.fieldTypeLocation(),
      ),
      if (isImport == false && isShared == false)
        PickerItem(
          id: fieldTypeImages,
          label: labels.fieldTypeImages(),
        ),
      if (isImport == false && isShared == false)
        PickerItem(
          id: fieldTypeFiles,
          label: labels.fieldTypeFiles(),
        ),
      PickerItem(
        id: fieldTypeTags,
        label: labels.fieldTypeTags(),
      ),
      PickerItem(
        id: fieldTypeMeasurement,
        label: labels.fieldTypeMeasurement(),
      ),
      PickerItem(
        id: fieldTypeEmotion,
        label: labels.fieldTypeEmotion(),
      ),
    ];

    return PickerItems(items: items);
  }

  /// Method which returns field hints depending on field type.
  /// * returns ```''``` as defaut if field type is unknown
  static String getHintByType({required String fieldType}) {
    if (fieldType == fieldTypeText) return labels.fieldTypeTextHint();
    if (fieldType == fieldTypePassword) return labels.fieldTypePasswordHint();
    if (fieldType == fieldTypePhone) return labels.fieldTypePhoneHint();
    if (fieldType == fieldTypeDate) return labels.fieldTypeDateHint();
    if (fieldType == fieldTypeTimeOfDay) return labels.fieldTypeTimeOfDayHint();
    if (fieldType == fieldTypeNumber) return labels.fieldTypeNumberHint();
    if (fieldType == fieldTypeMoney) return labels.fieldTypeMoneyHint();
    if (fieldType == fieldTypeEmail) return labels.fieldTypeEmailHint();
    if (fieldType == fieldTypeWebsite) return labels.fieldTypeWebsiteHint();
    if (fieldType == fieldTypeUsername) return labels.fieldTypeUsernameHint();
    if (fieldType == fieldTypeDateAndTime) return labels.fieldTypeDateAndTimeHint();
    if (fieldType == fieldTypeLocation) return labels.fieldTypeLocationHint();
    if (fieldType == fieldTypeImages) return labels.fieldTypeImagesHint();
    if (fieldType == fieldTypeFiles) return labels.fieldTypeFilesHint();
    if (fieldType == fieldTypePayment) return labels.fieldTypePaymentsHint();
    if (fieldType == fieldTypeDateOfBirth) return labels.fieldTypeDateOfBirthHint();
    if (fieldType == fieldTypeTags) return labels.fieldTypeTagsHint();
    if (fieldType == fieldTypeMeasurement) return labels.fieldTypeMeasurementHint();
    if (fieldType == fieldTypeEmotion) return labels.fieldTypeEmotionHint();
    if (fieldType == fieldTypeAvatarImage) return labels.fieldTypeAvatarImageHint();
    if (fieldType == fieldTypeBoolean) return labels.fieldTypeBooleanDataHint();

    // Output debug message.
    debugPrint('Field --> getHintByType --> unknown field type, return default');

    // Return default.
    return '';
  }

  /// Method which returns IconData depending on field type.
  /// * Returns ```AppIcons.error``` as defaut if field type is unknown.
  static IconData getIconDataByFieldType({required String fieldType}) {
    if (fieldType == fieldTypeText) return AppIcons.fieldTypeText;
    if (fieldType == fieldTypePassword) return AppIcons.fieldTypePassword;
    if (fieldType == fieldTypePhone) return AppIcons.fieldTypePhone;
    if (fieldType == fieldTypeDate) return AppIcons.fieldTypeDate;
    if (fieldType == fieldTypeTimeOfDay) return AppIcons.fieldTypeTimeOfDay;
    if (fieldType == fieldTypeNumber) return AppIcons.fieldTypeNumber;
    if (fieldType == fieldTypeMoney) return AppIcons.fieldTypeMoney;
    if (fieldType == fieldTypeEmail) return AppIcons.fieldTypeEmail;
    if (fieldType == fieldTypeWebsite) return AppIcons.fieldTypeWebsite;
    if (fieldType == fieldTypeUsername) return AppIcons.fieldTypeUsername;
    if (fieldType == fieldTypeDateAndTime) return AppIcons.fieldTypeDateAndTime;
    if (fieldType == fieldTypeLocation) return AppIcons.fieldTypeLocation;
    if (fieldType == fieldTypeImages) return AppIcons.fieldTypeImages;
    if (fieldType == fieldTypeFiles) return AppIcons.fieldTypeFiles;
    if (fieldType == fieldTypePayment) return AppIcons.fieldTypeExpense;
    if (fieldType == fieldTypeDateOfBirth) return AppIcons.fieldTypeDateOfBirth;
    if (fieldType == fieldTypeTags) return AppIcons.fieldTypeTags;
    if (fieldType == fieldTypeMeasurement) return AppIcons.fieldTypeMeasurement;
    if (fieldType == fieldTypeEmotion) return AppIcons.fieldTypeEmotion;
    if (fieldType == fieldTypeAvatarImage) return AppIcons.fieldTypeAvatarImage;
    if (fieldType == fieldTypeBoolean) return AppIcons.fieldTypeBoolean;

    // Output debug message.
    debugPrint('Field --> getIconDataByFieldType --> unknown field type, return default');

    // Return default.
    return AppIcons.error;
  }

  // ######################################
  // Getters
  // ######################################

  /// This getter can be used to check if a field is a: Field.fieldTypeText
  bool get getIsTextField {
    if (fieldType == fieldTypeText) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypePassword```
  bool get getIsPasswordField {
    if (fieldType == fieldTypePassword) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypePhone```
  bool get getIsPhoneField {
    if (fieldType == fieldTypePhone) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeDate```
  bool get getIsDateField {
    if (fieldType == fieldTypeDate) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeDateAndTime```
  bool get getIsDateAndTimeField {
    if (fieldType == fieldTypeDateAndTime) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeTimeOfDay```
  bool get getIsTimeField {
    if (fieldType == fieldTypeTimeOfDay) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeNumber```
  bool get getIsNumberField {
    if (fieldType == fieldTypeNumber) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeEmail```
  bool get getIsEmailField {
    if (fieldType == fieldTypeEmail) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeWebsite```
  bool get getIsWebsiteField {
    if (fieldType == fieldTypeWebsite) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeUsername```
  bool get getIsUsernameField {
    if (fieldType == fieldTypeUsername) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeLocation```
  bool get getIsLocationField {
    if (fieldType == fieldTypeLocation) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeMoney```
  bool get getIsMoneyField {
    if (fieldType == fieldTypeMoney) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypePayment```
  bool get getIsPaymentField {
    if (fieldType == fieldTypePayment) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeDateOfBirth```
  bool get getIsDateOfBirthField {
    if (fieldType == fieldTypeDateOfBirth) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeTags```
  bool get getIsTagsField {
    if (fieldType == fieldTypeTags) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeMeasurement```
  bool get getIsMeasurementField {
    if (fieldType == fieldTypeMeasurement) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeBoolean```
  bool get getIsBooleanField {
    if (fieldType == fieldTypeBoolean) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeEmotion```
  bool get getIsEmotionField {
    if (fieldType == fieldTypeEmotion) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeImages```
  bool get getIsImagesField {
    if (fieldType == fieldTypeImages) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeFiles```
  bool get getIsFilesField {
    if (fieldType == fieldTypeFiles) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeAvatarImage```
  bool get getIsAvatarImageField {
    if (fieldType == fieldTypeAvatarImage) return true;
    return false;
  }

  /// This getter can be used to check if a field is a: ```Field.fieldTypeEntry```
  bool get getIsEntryField {
    if (fieldType == fieldTypeEntry) return true;
    return false;
  }

  /// This getter can be used to access the copy value of a ```Field```.
  /// * returns ```null``` if value is not set or ```fieldType``` is unknown
  String? get getCopyValue {
    if (getIsTextField) return TextData.getCopyValue(textData: textData);
    if (getIsPasswordField) return PasswordData.getCopyValue(passwordData: passwordData);
    if (getIsPhoneField) return PhoneData.getCopyValue(phoneData: phoneData);
    if (getIsDateField) return DateData.getCopyValue(dateData: dateData);
    if (getIsTimeField) return TimeData.getCopyValue(timeData: timeData);
    if (getIsNumberField) return NumberData.getCopyValue(numberData: numberData);
    if (getIsMoneyField) return MoneyData.getCopyValue(moneyData: moneyData);
    if (getIsEmailField) return EmailData.getCopyValue(emailData: emailData);
    if (getIsWebsiteField) return WebsiteData.getCopyValue(websiteData: websiteData);
    if (getIsUsernameField) return UsernameData.getCopyValue(usernameData: usernameData);
    if (getIsDateAndTimeField) return DateAndTimeData.getCopyValue(dateAndTimeData: dateAndTimeData);
    if (getIsLocationField) return LocationData.getCopyValue(locationData: locationData);
    if (getIsImagesField) return ImageData.getCopyValue();
    if (getIsFilesField) return FileData.getCopyValue();
    if (getIsPaymentField) return PaymentData.getCopyValue(paymentData: paymentData);
    if (getIsDateOfBirthField) return DateOfBirthData.getCopyValue(dateOfBirthData: dateOfBirthData);
    if (getIsMeasurementField) return MeasurementData.getCopyValue(measurementData: measurementData);
    if (getIsAvatarImageField) return AvatarImageData.getCopyValue(avatarImageData: avatarImageData);
    if (getIsBooleanField) return null;
    if (getIsEmotionField) return null;
    if (getIsTagsField) return null;

    // Output debug message.
    debugPrint('Field --> getCopyValue --> Error, unknown fieldType.');

    return null;
  }

  /// This method can be used to access the subtitle to be displayed in ```CardEntryPreview```.
  /// * returns ```null``` if field has no subtitle available
  String? getSubtitle({required String fieldLabel}) {
    if (textData != null) return textData!.getSubtitle(fieldLabel: fieldLabel);
    if (passwordData != null) return passwordData!.getSubtitle(fieldLabel: fieldLabel);
    if (phoneData != null) return phoneData!.getSubtitle(fieldLabel: fieldLabel);
    if (dateData != null) return dateData!.getSubtitle(fieldLabel: fieldLabel);
    if (timeData != null) return timeData!.getSubtitle(fieldLabel: fieldLabel);
    if (numberData != null) return numberData!.getSubtitle(fieldLabel: fieldLabel);
    if (emailData != null) return emailData!.getSubtitle(fieldLabel: fieldLabel);
    if (websiteData != null) return websiteData!.getSubtitle(fieldLabel: fieldLabel);
    if (usernameData != null) return usernameData!.getSubtitle(fieldLabel: fieldLabel);
    if (dateAndTimeData != null) return dateAndTimeData!.getSubtitle(fieldLabel: fieldLabel);
    if (locationData != null) return locationData!.getSubtitle(fieldLabel: fieldLabel);
    if (moneyData != null) return moneyData!.getSubtitle(fieldLabel: fieldLabel);
    if (dateOfBirthData != null) return dateOfBirthData!.getSubtitle(fieldLabel: fieldLabel);
    if (imageData != null) return imageData!.getSubtitle(fieldLabel: fieldLabel);
    if (fileData != null) return fileData!.getSubtitle(fieldLabel: fieldLabel);
    if (paymentData != null) return paymentData!.getSubtitle(fieldLabel: fieldLabel);
    if (measurementData != null) return measurementData!.getSubtitle(fieldLabel: fieldLabel);
    if (avatarImageData != null) return avatarImageData!.getSubtitle(fieldLabel: fieldLabel);
    if (booleanData != null) return booleanData!.getSubtitle(fieldLabel: fieldLabel);
    if (emotionData != null) return null;
    if (tagsData != null) return null;

    return null;
  }

  /// This method can be used to access the thirdline to be displayed in ```CardEntryPreview```.
  /// * returns ```null``` if field has no thirdline available
  String? getThirdline({required String fieldLabel}) {
    if (textData != null) return textData!.getThirdline(fieldLabel: fieldLabel);
    if (passwordData != null) return passwordData!.getThirdline(fieldLabel: fieldLabel);
    if (phoneData != null) return phoneData!.getThirdline(fieldLabel: fieldLabel);
    if (dateData != null) return dateData!.getThirdline(fieldLabel: fieldLabel);
    if (timeData != null) return timeData!.getThirdline(fieldLabel: fieldLabel);
    if (numberData != null) return numberData!.getThirdline(fieldLabel: fieldLabel);
    if (emailData != null) return emailData!.getThirdline(fieldLabel: fieldLabel);
    if (websiteData != null) return websiteData!.getThirdline(fieldLabel: fieldLabel);
    if (usernameData != null) return usernameData!.getThirdline(fieldLabel: fieldLabel);
    if (dateAndTimeData != null) return dateAndTimeData!.getThirdline(fieldLabel: fieldLabel);
    if (locationData != null) return locationData!.getThirdline(fieldLabel: fieldLabel);
    if (moneyData != null) return moneyData!.getThirdline(fieldLabel: fieldLabel);
    if (dateOfBirthData != null) return dateOfBirthData!.getThirdline(fieldLabel: fieldLabel);
    if (imageData != null) return imageData!.getThirdline(fieldLabel: fieldLabel);
    if (fileData != null) return fileData!.getThirdline(fieldLabel: fieldLabel);
    if (paymentData != null) return paymentData!.getThirdline(fieldLabel: fieldLabel);
    if (measurementData != null) return measurementData!.getThirdline(fieldLabel: fieldLabel);
    if (avatarImageData != null) return avatarImageData!.getThirdline(fieldLabel: fieldLabel);
    if (booleanData != null) return booleanData!.getThirdline(fieldLabel: fieldLabel);
    if (emotionData != null) return null;
    if (tagsData != null) return null;

    return null;
  }

  /// This method can be used to indicate if a ```Field``` should be excluded from being saved to local storage.
  bool getExcludeField({required bool isDefault, required bool isImport}) {
    if (getIsTextField) return TextData.includeField(textData: textData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsPasswordField) return PasswordData.includeField(passwordData: passwordData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsPhoneField) return PhoneData.includeField(phoneData: phoneData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsDateField) return DateData.includeField(dateData: dateData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsTimeField) return TimeData.includeField(timeData: timeData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsNumberField) return NumberData.includeField(numberData: numberData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsMoneyField) return MoneyData.includeField(moneyData: moneyData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsEmailField) return EmailData.includeField(emailData: emailData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsWebsiteField) return WebsiteData.includeField(websiteData: websiteData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsUsernameField) return UsernameData.includeField(usernameData: usernameData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsDateAndTimeField) return DateAndTimeData.includeField(dateAndTimeData: dateAndTimeData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsLocationField) return LocationData.includeField(locationData: locationData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsPaymentField) return PaymentData.includeField(paymentData: paymentData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsDateOfBirthField) return DateOfBirthData.includeField(dateOfBirthData: dateOfBirthData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsTagsField) return TagsData.includeField(tagsData: tagsData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsMeasurementField) return MeasurementData.includeField(measurementData: measurementData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsEmotionField) return EmotionData.includeField(emotionData: emotionData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsBooleanField) return BooleanData.includeField(booleanData: booleanData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsImagesField) return ImageData.includeField(imageData: imageData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsFilesField) return FileData.includeField(fileData: fileData, isDefault: isDefault, isImport: isImport) == false;
    if (getIsAvatarImageField) return AvatarImageData.includeField(avatarImageData: avatarImageData, isDefault: isDefault, isImport: isImport) == false;

    // Output debug message.
    debugPrint('Field --> getExcludeField --> Error, unknown fieldType, exclude field.');

    return true;
  }

  // ######################################
  // Data Import Methods
  // ######################################

  /// This method can be used to update the import reference of a field depending on supplied indications.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```fieldType``` is unknown.
  Field? updateImportReference({required String importReference, required String objectReferenceType, required String? memberId}) {
    // Check the object Reference Type.
    final bool isValueType = objectReferenceType == ImportSpecifications.objectReferenceValue;
    final bool isOptionalValueType = objectReferenceType == ImportSpecifications.objectReferenceOptionalValue;
    final bool isCurrencyType = objectReferenceType == ImportSpecifications.objectReferenceCurrency;
    final bool isPaidByType = objectReferenceType == ImportSpecifications.objectReferencePaidBy;
    final bool isCompensatedType = objectReferenceType == ImportSpecifications.objectReferenceIsCompensated;
    final bool isMemberType = objectReferenceType == ImportSpecifications.objectReferenceMember;
    final bool isDateType = objectReferenceType == ImportSpecifications.objectReferenceDate;
    final bool isTagsType = objectReferenceType == ImportSpecifications.objectReferenceTags;
    final bool isLatitudeType = objectReferenceType == ImportSpecifications.objectReferenceLatitude;
    final bool isLongitudeType = objectReferenceType == ImportSpecifications.objectReferenceLongitude;
    final bool isCategoryType = objectReferenceType == ImportSpecifications.objectReferenceCategory;
    final bool isUnitType = objectReferenceType == ImportSpecifications.objectReferenceUnit;
    final bool isExchangeRateType = objectReferenceType == ImportSpecifications.objectReferenceCustomExchangeRate;
    final bool isEmotionType = objectReferenceType == ImportSpecifications.objectReferenceEmotion;
    final bool isOccurrenceType = objectReferenceType == ImportSpecifications.objectReferenceOccurrence;
    final bool isIntensityType = objectReferenceType == ImportSpecifications.objectReferenceIntensity;

    // * Update textData.
    if (getIsTextField) {
      // Create updated TextData.
      final TextData updated = textData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(textData: updated);
    }

    // * Update booleanData.
    if (getIsBooleanField) {
      // Create updated BooleanData.
      final BooleanData updated = booleanData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(booleanData: updated);
    }

    // * Update passwordData.
    if (getIsPasswordField) {
      // Create updated PasswordData.
      final PasswordData updated = passwordData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(passwordData: updated);
    }

    // * Update MoneyData.
    if (getIsMoneyField) {
      // Create updated TextData.
      final MoneyData updated = moneyData!.copyWith(
        importReferenceValue: isValueType ? importReference : null,
        importReferenceCurrency: isCurrencyType ? importReference : null,
        importReferenceExchangeRate: isExchangeRateType ? importReference : null,
        importReferenceTags: isTagsType ? importReference : null,
        importReferenceDate: isDateType ? importReference : null,
      );

      // Return updated fields.
      return copyWith(moneyData: updated);
    }

    // * Update TagsData.
    if (getIsTagsField) {
      // Create updated TextData.
      final TagsData updated = tagsData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(tagsData: updated);
    }

    // * Update PaymentData.
    if (getIsPaymentField) {
      // Init member references.
      MemberToImportReferences? importReferencesMembers;

      // Update member references if specifed.
      if (isMemberType) {
        // Check if object needs to be initialized.
        if (paymentData!.importReferencesMembers == null) {
          // Create Reference.
          MemberToImportReference memberToImportReference = MemberToImportReference.initial().copyWith(
            memberId: memberId!,
            importReference: importReference,
          );

          // Add MemberToImportReference.
          importReferencesMembers = MemberToImportReferences.initial().add(
            memberToImportReference: memberToImportReference,
          );
        }

        // Otherwise set object.
        if (paymentData!.importReferencesMembers != null) {
          // Set Reference.
          importReferencesMembers = paymentData!.importReferencesMembers!.set(
            memberId: memberId!,
            importReference: importReference,
          );
        }
      }

      // Create updated PaymentData.
      final PaymentData updated = paymentData!.copyWith(
        importReferenceTotalValue: isValueType ? importReference : null,
        importReferenceTotalCurrency: isCurrencyType ? importReference : null,
        importReferencePaidById: isPaidByType ? importReference : null,
        importReferenceIsCompensated: isCompensatedType ? importReference : null,
        importReferencesMembers: importReferencesMembers,
        importReferencePaymentDate: isDateType ? importReference : null,
        importReferenceTags: isTagsType ? importReference : null,
        importReferenceExchangeRate: isExchangeRateType ? importReference : null,
      );

      // Return updated fields.
      return copyWith(paymentData: updated);
    }

    // * Update emailData.
    if (getIsEmailField) {
      // Create updated EmailData.
      final EmailData updated = emailData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(emailData: updated);
    }

    // * Update usernameData.
    if (getIsUsernameField) {
      // Create updated usernameData.
      final UsernameData updated = usernameData!.copyWith(
        importReferenceValue: isValueType ? importReference : null,
        importReferenceOptionalValue: isOptionalValueType ? importReference : null,
      );

      // Return updated fields.
      return copyWith(usernameData: updated);
    }

    // * Update websiteData.
    if (getIsWebsiteField) {
      // Create updated WebsiteData.
      final WebsiteData updated = websiteData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(websiteData: updated);
    }

    // * Update DateOfBirth.
    if (getIsDateOfBirthField) {
      // Create updated DateOfBirth.
      final DateOfBirthData updated = dateOfBirthData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(dateOfBirthData: updated);
    }

    // * Update DateData.
    if (getIsDateField) {
      // Create updated DateData.
      final DateData updated = dateData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(dateData: updated);
    }

    // * Update DateAndTimeData.
    if (getIsDateAndTimeField) {
      // Create updated DateData.
      final DateAndTimeData updated = dateAndTimeData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(dateAndTimeData: updated);
    }

    // * Update TimeData.
    if (getIsTimeField) {
      // Create updated TimeOfDay.
      final TimeData updated = timeData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(timeData: updated);
    }

    // * Update NumberData.
    if (getIsNumberField) {
      // Create updated NumberData.
      final NumberData updated = numberData!.copyWith(
        importReference: importReference,
      );

      // Return updated fields.
      return copyWith(numberData: updated);
    }

    // * Update PhoneData.
    if (getIsPhoneField) {
      // Create updated PhoneData.
      final PhoneData updated = phoneData!.copyWith(
        importReference: isValueType ? importReference : null,
        importReferenceInternationalPrefix: isOptionalValueType ? importReference : null,
      );

      // Return updated fields.
      return copyWith(phoneData: updated);
    }

    // * Update LocationData.
    if (getIsLocationField) {
      // Create updated LocationData.
      final LocationData updated = locationData!.copyWith(
        importReferenceLatitude: isLatitudeType ? importReference : null,
        importReferenceLongitude: isLongitudeType ? importReference : null,
        importReferenceTags: isTagsType ? importReference : null,
        importReferenceDate: isDateType ? importReference : null,
      );

      // Return updated fields.
      return copyWith(locationData: updated);
    }

    // * Update MeasurementData.
    if (getIsMeasurementField) {
      // Create updated MeasurementData.
      final MeasurementData updated = measurementData!.copyWith(
        importReferenceCategory: isCategoryType ? importReference : null,
        importReferenceUnit: isUnitType ? importReference : null,
        importReferenceValue: isValueType ? importReference : null,
        importReferenceDate: isDateType ? importReference : null,
      );

      // Return updated fields.
      return copyWith(measurementData: updated);
    }

    // * Update EmotionData.
    if (getIsEmotionField) {
      // Create updated MeasurementData.
      final EmotionData updated = emotionData!.copyWith(
        importReferenceEmotion: isEmotionType ? importReference : null,
        importReferenceOccurrence: isOccurrenceType ? importReference : null,
        importReferenceIntensity: isIntensityType ? importReference : null,
      );

      // Return updated fields.
      return copyWith(emotionData: updated);
    }

    return null;
  }

  /// This method can be used to create a field from supplied data based on provided sample.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```fieldType``` is unknown.
  Future<Map<String, dynamic>?> importField({required Map<String, dynamic> row, required String defaultCurrencyCode, required LocalStorageCubit localStorageCubit, required int currentRow, required String invalidValueRule, required String missingValueRule, required String participantReference}) async {
    // Init helper field.
    Field field = Field.initial(fieldId: fieldId, fieldType: fieldType);

    // Access import rules.
    final bool invalidShouldFail = invalidValueRule == ImportSpecifications.importRuleFail;
    final bool missingShouldFail = missingValueRule == ImportSpecifications.importRuleFail;

    final bool invalidShouldSkip = invalidValueRule == ImportSpecifications.importRuleSkip;
    final bool missingShouldSkip = missingValueRule == ImportSpecifications.importRuleSkip;

    final bool invalidDefaultOrFail = invalidValueRule == ImportSpecifications.importRuleDefaultOrFail;
    final bool missingDefaultOrFail = missingValueRule == ImportSpecifications.importRuleDefaultOrFail;

    final bool invalidDefaultOrSkip = invalidValueRule == ImportSpecifications.importRuleDefaultOrSkip;
    final bool missingDefaultOrSkip = missingValueRule == ImportSpecifications.importRuleDefaultOrSkip;

    // Alert developer if a unknown import rule was used.
    if (!missingShouldFail && !missingShouldSkip && !missingDefaultOrFail && !missingDefaultOrSkip) throw Failure.unknownImportRule();
    if (!invalidShouldFail && !invalidShouldSkip && !invalidDefaultOrFail && !invalidDefaultOrSkip) throw Failure.unknownImportRule();

    // Conduct EmailData import.
    if (field.getIsEmailField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        emailData: emailData!,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Access the provider if available.
      final String provider = EmailData.accessProvider(value: valueMap['value']);

      // Otherwise data is available. Init it.
      final EmailData initData = EmailData.initial().copyWith(
        value: valueMap['value'],
        provider: provider,
      );

      // Update relevant data of field.
      field = field.copyWith(emailData: initData);

      return {'skip': false, 'field': field};
    }

    // Conduct BooleanData import.
    if (field.getIsBooleanField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        booleanData: booleanData!,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Otherwise data is available. Init it.
      final BooleanData initData = BooleanData.initial().copyWith(
        value: bool.parse(valueMap['value'], caseSensitive: false),
      );

      // Update relevant data of field.
      field = field.copyWith(booleanData: initData);

      return {'skip': false, 'field': field};
    }

    // Conduct PasswordData import.
    if (field.getIsPasswordField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        passwordData: passwordData,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Otherwise data is available. Init it.
      final PasswordData initData = PasswordData.initial().copyWith(
        value: valueMap['value'],
      );

      // Update relevant data of field.
      field = field.copyWith(passwordData: initData);

      return {'skip': false, 'field': field};
    }

    // Conduct UsernameData import.
    if (field.getIsUsernameField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        usernameData: usernameData!,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // * Check for optional value.
      final bool rowValueExists = usernameData!.importReferenceOptionalValue != null && row[usernameData!.importReferenceOptionalValue] != null && row[usernameData!.importReferenceOptionalValue].toString().trim().isNotEmpty;

      // Check if a default was set.
      final bool hasDefaultValue = usernameData!.service.trim().isNotEmpty;

      // Init optional value.
      String service = "";

      // Set value.
      if (rowValueExists) service = row[usernameData!.importReferenceOptionalValue].toString().trim();

      // No value found but a default exists.
      if (rowValueExists == false && hasDefaultValue) service = usernameData!.service.trim();

      // Init data.
      final UsernameData initData = UsernameData.initial().copyWith(
        value: valueMap['value'],
        service: service,
      );

      // Update relevant data of field.
      field = field.copyWith(usernameData: initData);

      return {'skip': false, 'field': field};
    }

    // Conduct TextData import.
    if (field.getIsTextField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        textData: textData!,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Otherwise data is available. Init it.
      final TextData initTextData = TextData.initial().copyWith(
        value: valueMap['value'],
      );

      // Update relevant data of field.
      field = field.copyWith(textData: initTextData);

      return {'skip': false, 'field': field};
    }

    // Conduct WebsiteData import.
    if (field.getIsWebsiteField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        websiteData: websiteData,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Otherwise data is available. Init it.
      final WebsiteData data = WebsiteData.initial().copyWith(
        value: valueMap['value'],
      );

      // Update relevant data of field.
      field = field.copyWith(websiteData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct DateOfBirthData import.
    if (field.getIsDateOfBirthField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        dateOfBirthData: dateOfBirthData,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Turn String into dateTime.
      final DateTime converted = HelperFunctions.parseDate(value: valueMap['value'])!;

      // Otherwise data is available. Init it.
      final DateOfBirthData data = DateOfBirthData.initial().copyWith(
        value: converted,
        showAutoNotificationChoice: false,
        autoNotification: false,
      );

      // Update relevant data of field.
      field = field.copyWith(dateOfBirthData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct DateData import.
    if (field.getIsDateField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        dateData: dateData,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Turn String into dateTime.
      final DateTime converted = HelperFunctions.parseDate(value: valueMap['value'])!;
      final String timezone = dateData!.timezone.isEmpty ? 'UTC' : dateData!.timezone;

      final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
        defaultDate: converted,
        defaultTime: TimeOfDay(hour: 0, minute: 0),
        timezone: timezone,
      );

      // Otherwise data is available. Init it.
      final DateData data = DateData.initial().copyWith(
        valueInUtc: inUtc,
        timezone: timezone,
      );

      // Update relevant data of field.
      field = field.copyWith(dateData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct DateAndTimeData import.
    if (field.getIsDateAndTimeField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        dateAndTimeData: dateAndTimeData,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Turn String into dateTime.
      final DateTime convertedInUtc = HelperFunctions.parseDate(value: valueMap['value'])!;

      // Access timezone.
      final String timezone = dateAndTimeData!.timezone.isEmpty ? 'UTC' : dateAndTimeData!.timezone;

      // Otherwise data is available. Init it.
      final DateAndTimeData data = DateAndTimeData.initial().copyWith(
        valueInUtc: convertedInUtc,
        timezone: timezone,
      );

      // Update relevant data of field.
      field = field.copyWith(dateAndTimeData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct TimeData import.
    if (field.getIsTimeField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        timeData: timeData,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Turn String into dateTime.
      final DateTime converted = HelperFunctions.parseDate(value: valueMap['value'])!;

      // Otherwise data is available. Init it.
      final TimeData data = TimeData.initial().copyWith(
        value: TimeOfDay.fromDateTime(converted),
      );

      // Update relevant data of field.
      field = field.copyWith(timeData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct PhoneData import.
    if (field.getIsPhoneField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validatePhoneData(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        phoneData: phoneData!,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Otherwise data is available. Init it.
      final PhoneData data = PhoneData.initial().copyWith(
        value: valueMap['phone'],
        internationalPrefix: valueMap['prefix'],
      );

      // Update relevant data of field.
      field = field.copyWith(phoneData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct MoneyData import.
    if (field.getIsMoneyField) {
      // Validate total amount.
      final Map<String, dynamic> validator = _validateMoneyData(
        row: row,
        currentRow: currentRow,
        importReferenceValue: moneyData!.importReferenceValue,
        importReferenceCurrency: moneyData!.importReferenceCurrency,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        moneyData: moneyData!,
        paymentData: null,
      );

      // Check if field should be skipped.
      if (validator['skip']) return {'skip': true, 'field': null};

      // Convenience variables.
      final String value = validator['value'];
      final String currencyCode = validator['currency_code'];
      final bool currenciesDiffer = defaultCurrencyCode != currencyCode;
      ExchangeRates customExchangeRates = ExchangeRates.initial();
      DateTime? dateInUtc;
      String defaultDateTimezone = 'UTC';

      // Check if specified instruction results in a value.
      final bool exchangeRateValueExists = moneyData!.importReferenceExchangeRate != null && row[moneyData!.importReferenceExchangeRate] != null && row[moneyData!.importReferenceExchangeRate].toString().trim().isNotEmpty;
      final bool dateRowValueExists = moneyData!.importReferenceDate != null && row[moneyData!.importReferenceDate] != null && row[moneyData!.importReferenceDate].toString().trim().isNotEmpty;

      // ############################
      // Money Date.
      // ############################

      //  Date was not found.
      if (dateRowValueExists == false) {
        // * User specified that import should fail.
        if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: moneyData!.importReferenceDate, row: currentRow);

        // * User specified that import should skip.
        if (missingShouldSkip) return {'skip': true, 'field': null};

        // * User specified to use default or fail.
        // * In this case there is always a default.
        if (missingDefaultOrFail || missingDefaultOrSkip) {
          // Parse default date.
          final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: moneyData!.defaultDate)!;

          // Parse default time.
          TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: moneyData!.defaultTime)!;

          // Access timezone.
          if (moneyData!.timezone.isNotEmpty) defaultDateTimezone = moneyData!.timezone;

          // Convert to utc.
          final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
            defaultDate: parsedDefaultDate,
            defaultTime: parsedDefaultTime,
            timezone: defaultDateTimezone,
          );

          dateInUtc = inUtc;
        }
      }

      // Date was found.
      if (dateRowValueExists) {
        // Check value.
        final DateTime? isValidDate = HelperFunctions.parseDate(value: row[moneyData!.importReferenceDate].toString().trim());

        // Row value is not a date.
        if (isValidDate == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: moneyData!.importReferenceDate, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true, 'field': null};

          // * User specified to use default or fail.
          // * In this case there is always a default.
          if (missingDefaultOrFail || missingDefaultOrSkip) {
            // Parse default date.
            final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: moneyData!.defaultDate)!;

            // Parse default time.
            TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: moneyData!.defaultTime)!;

            // Access timezone.
            if (moneyData!.timezone.isNotEmpty) defaultDateTimezone = moneyData!.timezone;

            // Convert to utc.
            final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
              defaultDate: parsedDefaultDate,
              defaultTime: parsedDefaultTime,
              timezone: defaultDateTimezone,
            );

            dateInUtc = inUtc;
          }
        }

        // Set value.
        if (isValidDate != null) dateInUtc = isValidDate.toUtc();
      }

      // * For custom exchange rate do not throw errors on missing or invalid.
      if (currenciesDiffer && exchangeRateValueExists) {
        // Convert to default number format.
        final String customExchangeRateValue = NumberData.convertToDefaultNumberFormat(value: row[moneyData!.importReferenceExchangeRate]);

        // Check value.
        final bool isValidNumber = NumberData.numberValidator(input: customExchangeRateValue);

        // Custom exchange rate is a valid number, set it.
        if (isValidNumber) {
          // Ensure that value is not to big.
          final bool tooManyChars = NumberData.tooManyNumberCharacters(input: customExchangeRateValue);

          // Inform user.
          if (tooManyChars) throw Failure.numberHasTooManyCharacters();

          // Convert to double.
          final double asDouble = double.parse(customExchangeRateValue);

          // Create CustomExchangeRate object.
          final ExchangeRate customExchangeRate = ExchangeRate.initial().copyWith(
            exchangeRateDateInUtc: null,
            fromCurrencyCode: currencyCode,
            toCurrencyCode: defaultCurrencyCode,
            exchangeRate: asDouble,
          );

          // Update Exchange rates object.
          customExchangeRates = ExchangeRates(items: [customExchangeRate]);
        }
      }

      // ############################
      // Money Tags.
      // ############################

      // Validate Tags.
      final Map<String, dynamic> tagsValidator = await _validateTagsData(
        row: row,
        currentRow: currentRow,
        importReferenceTags: moneyData!.importReferenceTags,
        localStorageCubit: localStorageCubit,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        moneyData: moneyData,
        locationData: null,
        paymentData: null,
        tagsData: null,
      );

      // Init text data.
      final MoneyData initMoneyData = MoneyData.initial().copyWith(
        value: value,
        currencyCode: currencyCode,
        createdAtInUtc: dateInUtc,
        timezone: defaultDateTimezone,
        customExchangeRates: customExchangeRates,
        // ! In case tags data suggests skip, overwrite this indication because for money data tags values are optional
        // ! And even if there are no tags, the money data should be imported.
        tagsData: tagsValidator['skip'] ? TagsData.initial() : tagsValidator['tags_data'],
      );

      // Update relevant data of field.
      field = field.copyWith(moneyData: initMoneyData);

      return {'skip': false, 'field': field};
    }

    // Conduct TagsData import.
    if (field.getIsTagsField) {
      // Validate Tags.
      final Map<String, dynamic> tagsValidator = await _validateTagsData(
        row: row,
        currentRow: currentRow,
        importReferenceTags: tagsData!.importReference,
        localStorageCubit: localStorageCubit,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        tagsData: tagsData!,
        locationData: null,
        moneyData: null,
        paymentData: null,
      );

      // Check if field should be skipped.
      if (tagsValidator['skip']) return {'skip': true, 'field': null};

      // Update relevant data of field.
      field = field.copyWith(tagsData: tagsValidator['tags_data']);

      return {'skip': false, 'field': field};
    }

    // Conduct PaymentData import.
    if (field.getIsPaymentField) {
      // * Ensure a participant reference was set.
      if (participantReference.isEmpty) throw Failure.groupDoesNotHaveAParticipant();

      // Validate total amount.
      final Map<String, dynamic> validator = _validateMoneyData(
        row: row,
        currentRow: currentRow,
        importReferenceValue: paymentData!.importReferenceTotalValue,
        importReferenceCurrency: paymentData!.importReferenceTotalCurrency,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        paymentData: paymentData!,
        moneyData: null,
      );

      // Check if field should be skipped.
      if (validator['skip']) return {'skip': true, 'field': null};

      // Convenience variables.
      final String totalValue = validator['value'];
      final String currencyCode = validator['currency_code'];
      final bool currenciesDiffer = defaultCurrencyCode != currencyCode;
      Member? paidByMember;
      bool isCompensated = false;
      DateTime? dateInUtc;
      String defaultDateTimezone = 'UTC';
      ExchangeRates customExchangeRates = ExchangeRates.initial();

      // Check if specified instruction results in a value.
      final bool exchangeRateValueExists = paymentData!.importReferenceExchangeRate != null && row[paymentData!.importReferenceExchangeRate] != null && row[paymentData!.importReferenceExchangeRate].toString().trim().isNotEmpty;
      final bool paidByRowValueExists = paymentData!.importReferencePaidById != null && row[paymentData!.importReferencePaidById] != null && row[paymentData!.importReferencePaidById].toString().trim().isNotEmpty;
      final bool isCompensatedRowValueExists = paymentData!.importReferenceIsCompensated != null && row[paymentData!.importReferenceIsCompensated] != null && row[paymentData!.importReferenceIsCompensated].toString().trim().isNotEmpty;
      final bool paymentDateRowValueExists = paymentData!.importReferencePaymentDate != null && row[paymentData!.importReferencePaymentDate] != null && row[paymentData!.importReferencePaymentDate].toString().trim().isNotEmpty;

      // A value for the paid by member was not found.
      if (paidByRowValueExists == false) {
        // * User specified that import should fail.
        if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: paymentData!.importReferencePaidById, row: currentRow);

        // * User specified that import should skip.
        if (missingShouldSkip) return {'skip': true, 'field': null};

        // * User specified to use default or fail.
        // * In this case there is no default available which means it should fail.
        if (missingDefaultOrFail) throw Failure.importMissingValueShouldFail(rowKey: paymentData!.importReferencePaidById, row: currentRow);

        // * User specified to use default or skip.
        // * In this case there is no default available which means it should skip.
        if (missingDefaultOrSkip) return {'skip': true, 'field': null};
      }

      // A value for the paid by member was found. Try and access member.
      if (paidByRowValueExists) {
        // Check in import to member references if member with this name exists.
        MemberToImportReference? memberToImportReference = paymentData!.importReferencesMembers!.getByImportReference(
          importReference: row[paymentData!.importReferencePaidById],
        );

        // Maybe a id was supplied.
        memberToImportReference ??= paymentData!.importReferencesMembers!.getByMemberId(
          memberId: row[paymentData!.importReferencePaidById],
        );

        // * Reference not found. Try and
        if (memberToImportReference == null) throw Failure.importCouldNotFindMemberName(providedMemberName: row[paymentData!.importReferencePaidById], rowKey: paymentData!.importReferencePaidById!, row: currentRow);

        // Member was not found by name. Maybe ids were given in row.
        paidByMember = await localStorageCubit.getLocalMemberById(memberId: memberToImportReference.memberId);

        // Provided paid by member was not found.
        if (paidByMember == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: paymentData!.importReferencePaidById, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true, 'field': null};

          // * User specified to use default or fail.
          // * In this case there is no default available which means it should fail.
          if (invalidDefaultOrFail) throw Failure.importInvalidValueShouldFail(rowKey: paymentData!.importReferencePaidById, row: currentRow, tooManyChars: false);

          // * User specified to use default or skip.
          // * In this case there is no default available which means it should skip.
          if (invalidDefaultOrSkip) return {'skip': true, 'field': null};
        }
      }

      // A value for is compensated was not found.
      // * In this case always use default.
      if (isCompensatedRowValueExists == false) isCompensated = paymentData!.isCompensated;

      // A value for is compensated was found.
      if (isCompensatedRowValueExists) {
        // Try and parse the value into a boolean.
        final bool? isCompensatedParsed = BooleanData.tryParse(value: row[paymentData!.importReferenceIsCompensated].toString());

        // Failed to parse value.
        if (isCompensatedParsed == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: paymentData!.importReferenceIsCompensated, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true, 'field': null};

          // * User specified to use default or fail.
          // * In this case there is always a default.
          if (invalidDefaultOrFail) isCompensated = paymentData!.isCompensated;

          // * User specified to use default or skip.
          // * In this case there is always a default.
          if (invalidDefaultOrSkip) isCompensated = paymentData!.isCompensated;
        }

        // Set value.
        if (isCompensatedParsed != null) isCompensated = isCompensatedParsed;
      }

      // Payment date was not found.
      if (paymentDateRowValueExists == false) {
        // * User specified that import should fail.
        if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: paymentData!.importReferencePaymentDate, row: currentRow);

        // * User specified that import should skip.
        if (missingShouldSkip) return {'skip': true, 'field': null};

        // * User specified to use default or fail.
        // * In this case there is always a default.
        if (missingDefaultOrFail || missingDefaultOrSkip) {
          // Parse default date.
          final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: paymentData!.paymentDateDefaultDate)!;

          // Parse default time.
          TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: paymentData!.paymentDateDefaultTime)!;

          // Access timezone.
          if (paymentData!.paymentDateTimezone.isNotEmpty) defaultDateTimezone = paymentData!.paymentDateTimezone;

          // Convert to utc.
          final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
            defaultDate: parsedDefaultDate,
            defaultTime: parsedDefaultTime,
            timezone: defaultDateTimezone,
          );

          dateInUtc = inUtc;
        }
      }

      // Payment date was found.
      if (paymentDateRowValueExists) {
        // Check value.
        final DateTime? isValidDate = HelperFunctions.parseDate(value: row[paymentData!.importReferencePaymentDate].toString().trim());

        // Row value is not a date.
        if (isValidDate == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: paymentData!.importReferencePaymentDate, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true, 'field': null};

          // * User specified to use default or fail.
          // * In this case there is always a default.
          if (missingDefaultOrFail || missingDefaultOrSkip) {
            // Parse default date.
            final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: paymentData!.paymentDateDefaultDate)!;

            // Parse default time.
            TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: paymentData!.paymentDateDefaultTime)!;

            // Access timezone.
            if (paymentData!.paymentDateTimezone.isNotEmpty) defaultDateTimezone = paymentData!.paymentDateTimezone;

            // Convert to utc.
            final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
              defaultDate: parsedDefaultDate,
              defaultTime: parsedDefaultTime,
              timezone: defaultDateTimezone,
            );

            dateInUtc = inUtc;
          }
        }

        // Set value.
        if (isValidDate != null) dateInUtc = isValidDate.toUtc();
      }

      // * For custom exchange rate do not throw errors on missing or invalid.
      if (currenciesDiffer && exchangeRateValueExists) {
        // Convert to default number format.
        final String customExchangeRateValue = NumberData.convertToDefaultNumberFormat(value: row[paymentData!.importReferenceExchangeRate]);

        // Check value.
        final bool isValidNumber = NumberData.numberValidator(input: customExchangeRateValue);

        // Custom exchange rate is a valid number, set it.
        if (isValidNumber) {
          // Ensure that value is not to big.
          final bool tooManyChars = NumberData.tooManyNumberCharacters(input: customExchangeRateValue);

          // Inform user.
          if (tooManyChars) throw Failure.numberHasTooManyCharacters();

          // Convert to double.
          final double asDouble = double.parse(customExchangeRateValue);

          // Create CustomExchangeRate object.
          final ExchangeRate customExchangeRate = ExchangeRate.initial().copyWith(
            exchangeRateDateInUtc: null,
            fromCurrencyCode: currencyCode,
            toCurrencyCode: defaultCurrencyCode,
            exchangeRate: asDouble,
          );

          // Update Exchange rates object.
          customExchangeRates = ExchangeRates(items: [customExchangeRate]);
        }
      }

      // * This has to be set before continuing with distribution because it is needed for exchange rate.
      PaymentData updatedPaymentData = paymentData!.copyWith(
        participantReference: participantReference,
        total: totalValue,
        currencyCode: currencyCode,
        customExchangeRates: customExchangeRates,
        paidById: paidByMember!.memberId,
        isCompensated: isCompensated,
        paymentDateInUtc: dateInUtc,
        paymentDateTimezone: defaultDateTimezone,
        distributeEqually: false,
      );

      // ############################
      // Distribution calculation.
      // ############################

      // First make sure a distribution was selected.
      final bool hasMemberReferences = updatedPaymentData.importReferencesMembers != null && updatedPaymentData.importReferencesMembers!.items.isNotEmpty;

      // Skip import.
      if (hasMemberReferences == false) {
        // * User specified that import should fail.
        if (invalidShouldFail) throw Failure.importInvalidMemberReferences();

        // * User specified that import should skip.
        if (invalidShouldSkip) return {'skip': true, 'field': null};

        // * User specified to use default or fail.
        if (invalidDefaultOrFail) throw Failure.importInvalidMemberReferences();

        // * User specified to use default or skip.
        if (invalidDefaultOrSkip) return {'skip': true, 'field': null};
      }

      // Init ShareReferences.
      ShareReferences shareReferences = ShareReferences.initial();

      // Access relevant values.
      for (final MemberToImportReference item in updatedPaymentData.importReferencesMembers!.items) {
        // Access member value.
        final Map<String, dynamic> memberValue = _accessMemberValue(
          row: row,
          currentRow: currentRow,
          importReferenceValue: item.importReference,
          missingShouldFail: missingShouldFail,
          missingShouldSkip: missingShouldSkip,
          missingDefaultOrFail: missingDefaultOrFail,
          missingDefaultOrSkip: missingDefaultOrSkip,
          invalidShouldFail: invalidShouldFail,
          invalidShouldSkip: invalidShouldSkip,
          invalidDefaultOrSkip: invalidDefaultOrSkip,
          invalidDefaultOrFail: invalidDefaultOrFail,
          paymentData: updatedPaymentData,
        );

        // Check if skip was set to true.
        if (memberValue['skip']) return {'skip': true, 'field': null};

        // Create Share reference.
        final ShareReference shareReference = ShareReference(id: item.memberId, value: memberValue['value']);

        // Add to references.
        shareReferences = shareReferences.addShareReference(shareReference: shareReference);
      }

      // Update paymentData with shareReferences to enable methods.
      updatedPaymentData = updatedPaymentData.copyWith(shareReferences: shareReferences);

      // Access the combined total.
      final double shareSum = updatedPaymentData.getCombinedSharedAmount;

      // Init percentage helpers.
      Map<String, double> percentages = {};

      // Calculate the percentage distribution for each member.
      for (final ShareReference ref in updatedPaymentData.shareReferences.items) {
        // Calculate percentage.
        final double percentage = shareSum == 0 ? 0 : (ref.valueAsDouble / shareSum) * 100;

        // Update helper.
        percentages[ref.id] = percentage;
      }

      // Init helper.
      ShareReferences finalShareReferences = ShareReferences.initial();

      // Go through percentages and create share references.
      // * Use unconverted totalAsDouble here because the conversion does not happen in the shares but on demand.
      percentages.forEach((key, value) {
        // Calculate value.
        final double percentageOfTotal = updatedPaymentData.totalAsDouble * (value / 100);

        // * Make sure that calculation is always done with only two decimals.
        final double truncated = ((percentageOfTotal * 100).truncateToDouble()) / 100;

        // Create ShareReference.
        final ShareReference share = ShareReference(id: key, value: truncated.toString());

        // Add to helper.
        finalShareReferences = finalShareReferences.addShareReference(shareReference: share);
      });

      // ! Attention: error correction required.
      // * This is needed because it might be that because of rounding error the total does not equal to the sum of shares by a
      // * minor amount. In that case get that minor amount and add it to a random member. Except members who have zero shares.
      // * A currency conversion is not required because amounts should be in the same currency here.
      final double truncated = ((finalShareReferences.getCombinedSharedAmount * 100).truncateToDouble()) / 100;
      final double calculatedDifference = updatedPaymentData.totalAsDouble - truncated;

      // * This is required because of floating point error so that 0.00999 is converted to 0.01.
      final double manipulated = double.parse(calculatedDifference.toStringAsFixed(2));

      // Error correction is required.
      if (manipulated != 0) {
        // Output debug message.
        debugPrint('Field --> importField() --> fix payment rounding error in row $currentRow; correction by difference: ${manipulated.toStringAsFixed(2)}');

        // Conduct error correction.
        finalShareReferences = finalShareReferences.conductImportRoundingErrorCorrection(
          difference: manipulated,
        );
      }

      // Update payment data.
      updatedPaymentData = updatedPaymentData.copyWith(
        shareReferences: finalShareReferences,
      );

      // ############################
      // Payment Tags.
      // ############################

      // Validate Tags.
      final Map<String, dynamic> tagsValidator = await _validateTagsData(
        row: row,
        currentRow: currentRow,
        importReferenceTags: paymentData!.importReferenceTags,
        localStorageCubit: localStorageCubit,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        paymentData: paymentData,
        locationData: null,
        moneyData: null,
        tagsData: null,
      );

      // Update relevant data of field.
      updatedPaymentData = updatedPaymentData.copyWith(
        // ! In case tags data suggests skip, overwrite this indication because for payment data tags values are optional
        // ! And even if there are no tags, the money data should be imported.
        tagsData: tagsValidator['skip'] ? TagsData.initial() : tagsValidator['tags_data'],
      );

      // Update relevant data of field.
      field = field.copyWith(paymentData: updatedPaymentData);

      return {
        'skip': false,
        'field': field,
      };
    }

    // Conduct NumberData import.
    if (field.getIsNumberField) {
      // Access value.
      final Map<String, dynamic> valueMap = _validateStringValue(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        numberData: numberData,
      );

      // Skip if specified so.
      if (valueMap['skip']) return {'skip': true, 'field': null};

      // Otherwise data is available. Init it.
      final NumberData data = NumberData.initial().copyWith(
        value: valueMap['value'],
      );

      // Update relevant data of field.
      field = field.copyWith(numberData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct LocationData import.
    if (field.getIsLocationField) {
      // Validate total amount.
      final Map<String, dynamic> validator = _validateLocationData(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        locationData: locationData!,
      );

      // Check if field should be skipped.
      if (validator['skip']) return {'skip': true, 'field': null};

      // ############################
      // Location Date.
      // ############################

      // Convenience variables.
      DateTime? dateInUtc;
      String defaultDateTimezone = 'UTC';

      // Check if a date value exists.
      final bool locationDateRowValueExists = locationData!.importReferenceDate != null && row[locationData!.importReferenceDate] != null && row[locationData!.importReferenceDate].toString().trim().isNotEmpty;

      // Payment date was not found.
      if (locationDateRowValueExists == false) {
        // * User specified that import should fail.
        if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: locationData!.importReferenceDate, row: currentRow);

        // * User specified that import should skip.
        if (missingShouldSkip) return {'skip': true, 'field': null};

        // * User specified to use default or fail.
        // * In this case there is always a default.
        if (missingDefaultOrFail || missingDefaultOrSkip) {
          // Parse default date.
          final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: locationData!.defaultDate)!;

          // Parse default time.
          TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: locationData!.defaultTime)!;

          // Access timezone.
          if (locationData!.createdAtTimezone.isNotEmpty) defaultDateTimezone = locationData!.createdAtTimezone;

          // Convert to utc.
          final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
            defaultDate: parsedDefaultDate,
            defaultTime: parsedDefaultTime,
            timezone: defaultDateTimezone,
          );

          dateInUtc = inUtc;
        }
      }

      // Payment date was found.
      if (locationDateRowValueExists) {
        // Check value.
        final DateTime? isValidDate = HelperFunctions.parseDate(value: row[locationData!.importReferenceDate].toString().trim());

        // Row value is not a date.
        if (isValidDate == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: locationData!.importReferenceDate, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true, 'field': null};

          // * User specified to use default or fail.
          // * In this case there is always a default.
          if (missingDefaultOrFail || missingDefaultOrSkip) {
            // Parse default date.
            final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: locationData!.defaultDate)!;

            // Parse default time.
            TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: locationData!.defaultTime)!;

            // Access timezone.
            if (locationData!.createdAtTimezone.isNotEmpty) defaultDateTimezone = locationData!.createdAtTimezone;

            // Convert to utc.
            final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
              defaultDate: parsedDefaultDate,
              defaultTime: parsedDefaultTime,
              timezone: defaultDateTimezone,
            );

            dateInUtc = inUtc;
          }
        }

        // Set value.
        if (isValidDate != null) dateInUtc = isValidDate.toUtc();
      }

      // ############################
      // Location Tags.
      // ############################

      // Validate Tags.
      final Map<String, dynamic> tagsValidator = await _validateTagsData(
        row: row,
        currentRow: currentRow,
        importReferenceTags: locationData!.importReferenceTags,
        localStorageCubit: localStorageCubit,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        locationData: locationData,
        moneyData: null,
        paymentData: null,
        tagsData: null,
      );

      // Init LocationData.
      final LocationData data = LocationData.initial().copyWith(
        latitude: validator['lat'],
        longitude: validator['lng'],
        type: validator['type'],
        // ! In case tags data suggests skip, overwrite this indication because for location data tags values are optional
        // ! And even if there are no tags, the money data should be imported.
        tagsData: tagsValidator['skip'] ? TagsData.initial() : tagsValidator['tags_data'],
        createdAtInUtc: dateInUtc,
        createdAtTimezone: defaultDateTimezone,
      );

      // Update relevant data of field.
      field = field.copyWith(locationData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct MeasurementData import.
    if (field.getIsMeasurementField) {
      // Perform validation.
      final Map<String, dynamic> validator = _validateMeasurementData(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        measurementData: measurementData!,
      );

      // Check if field should be skipped.
      if (validator['skip']) return {'skip': true, 'field': null};

      // Convenience variables.
      DateTime? dateInUtc;
      String defaultDateTimezone = 'UTC';

      // Check if a date value exists.
      final bool measurementDateRowValueExists = measurementData!.importReferenceDate != null && row[measurementData!.importReferenceDate] != null && row[measurementData!.importReferenceDate].toString().trim().isNotEmpty;

      // Measurement date was not found.
      if (measurementDateRowValueExists == false) {
        // * User specified that import should fail.
        if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: measurementData!.importReferenceDate, row: currentRow);

        // * User specified that import should skip.
        if (missingShouldSkip) return {'skip': true, 'field': null};

        // * User specified to use default or fail.
        // * In this case there is always a default.
        if (missingDefaultOrFail || missingDefaultOrSkip) {
          // Parse default date.
          final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: measurementData!.createdAtDefaultDate)!;

          // Parse default time.
          TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: measurementData!.createdAtDefaultTime)!;

          // Access timezone.
          if (measurementData!.createdAtTimezone.isNotEmpty) defaultDateTimezone = measurementData!.createdAtTimezone;

          // Convert to utc.
          final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
            defaultDate: parsedDefaultDate,
            defaultTime: parsedDefaultTime,
            timezone: defaultDateTimezone,
          );

          dateInUtc = inUtc;
        }
      }

      // Payment date was found.
      if (measurementDateRowValueExists) {
        // Check value.
        final DateTime? isValidDate = HelperFunctions.parseDate(value: row[measurementData!.importReferenceDate].toString().trim());

        // Row value is not a date.
        if (isValidDate == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: measurementData!.importReferenceDate, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true, 'field': null};

          // * User specified to use default or fail.
          // * In this case there is always a default.
          if (missingDefaultOrFail || missingDefaultOrSkip) {
            // Parse default date.
            final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: measurementData!.createdAtDefaultDate)!;

            // Parse default time.
            TimeOfDay parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: measurementData!.createdAtDefaultTime)!;

            // Access timezone.
            if (measurementData!.createdAtTimezone.isNotEmpty) defaultDateTimezone = measurementData!.createdAtTimezone;

            // Convert to utc.
            final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
              defaultDate: parsedDefaultDate,
              defaultTime: parsedDefaultTime,
              timezone: defaultDateTimezone,
            );

            dateInUtc = inUtc;
          }
        }

        // Set value.
        if (isValidDate != null) dateInUtc = isValidDate.toUtc();
      }

      // Init MeasurementData.
      final MeasurementData data = MeasurementData.initial().copyWith(
        category: validator['category'],
        unit: validator['unit'],
        value: validator['value'],
        createdAtInUtc: dateInUtc,
        createdAtTimezone: defaultDateTimezone,
      );

      // Update relevant data of field.
      field = field.copyWith(measurementData: data);

      return {'skip': false, 'field': field};
    }

    // Conduct EmotionData import.
    if (field.getIsEmotionField) {
      // Perform validation.
      final Map<String, dynamic> validator = _validateEmotionData(
        row: row,
        currentRow: currentRow,
        missingShouldFail: missingShouldFail,
        missingShouldSkip: missingShouldSkip,
        missingDefaultOrFail: missingDefaultOrFail,
        missingDefaultOrSkip: missingDefaultOrSkip,
        invalidShouldFail: invalidShouldFail,
        invalidShouldSkip: invalidShouldSkip,
        invalidDefaultOrSkip: invalidDefaultOrSkip,
        invalidDefaultOrFail: invalidDefaultOrFail,
        emotionData: emotionData!,
      );

      // Check if field should be skipped.
      if (validator['skip']) return {'skip': true, 'field': null};

      // Init EmotionData.
      final EmotionData data = EmotionData.initial().copyWith(
        emotions: validator['emotions'],
      );

      // Update relevant data of field.
      field = field.copyWith(emotionData: data);

      return {'skip': false, 'field': field};
    }

    // Unknown field type.
    return null;
  }

  /// This helper can be used to validate single String values.
  /// * Ensure that only one DataType at a time is supplied or invalid results will be returned!
  Map<String, dynamic> _validateStringValue({
    required Map<String, dynamic> row,
    DateData? dateData,
    DateAndTimeData? dateAndTimeData,
    DateOfBirthData? dateOfBirthData,
    WebsiteData? websiteData,
    PasswordData? passwordData,
    BooleanData? booleanData,
    UsernameData? usernameData,
    TextData? textData,
    EmailData? emailData,
    TimeData? timeData,
    NumberData? numberData,
    required int currentRow,
    required bool missingShouldFail,
    required bool missingShouldSkip,
    required bool missingDefaultOrFail,
    required bool missingDefaultOrSkip,
    required bool invalidShouldFail,
    required bool invalidShouldSkip,
    required bool invalidDefaultOrFail,
    required bool invalidDefaultOrSkip,
  }) {
    // Init value.
    String? value;
    String defaultValue = '';

    bool hasDefaultValue = false;

    String? importReference;

    // A default numberData object was supplied. Check for values.
    if (numberData != null) {
      // Access import reference.
      importReference = numberData.importReference;

      // Check if a default was set.
      hasDefaultValue = numberData.value.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = numberData.value.trim();
    }

    // A default textData object was supplied. Check for values.
    if (textData != null) {
      // Access import reference.
      importReference = textData.importReference;

      // Check if a default was set.
      hasDefaultValue = textData.value.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = textData.value.trim();
    }

    // A default emailData object was supplied. Check for values.
    if (emailData != null) {
      // Access import reference.
      importReference = emailData.importReference;

      // Check if a default was set.
      hasDefaultValue = emailData.value.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = emailData.value.trim();
    }

    // A default usernameData object was supplied. Check for values.
    if (usernameData != null) {
      // Access import reference.
      importReference = usernameData.importReferenceValue;

      // Check if a default was set.
      hasDefaultValue = usernameData.value.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = usernameData.value.trim();
    }

    // A default booleanData object was supplied. Check for values.
    if (booleanData != null) {
      // Access import reference.
      importReference = booleanData.importReference;

      // Check if a default was set.
      hasDefaultValue = booleanData.value != null;

      // Set defaults.
      if (hasDefaultValue) defaultValue = booleanData.value.toString();
    }

    // A default passwordData object was supplied. Check for values.
    if (passwordData != null) {
      // Access import reference.
      importReference = passwordData.importReference;

      // Check if a default was set.
      hasDefaultValue = passwordData.value.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = passwordData.value.trim();
    }

    // A default websiteData object was supplied. Check for values.
    if (websiteData != null) {
      // Access import reference.
      importReference = websiteData.importReference;

      // Check if a default was set.
      hasDefaultValue = websiteData.value.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = websiteData.value.trim();
    }

    // A default dateOfBirthData object was supplied. Check for values.
    if (dateOfBirthData != null) {
      // Access import reference.
      importReference = dateOfBirthData.importReference;

      // Check if a default was set.
      hasDefaultValue = dateOfBirthData.value != null;

      // Set defaults.
      if (hasDefaultValue) defaultValue = dateOfBirthData.value!.toIso8601String();
    }

    // A default dateData object was supplied. Check for values.
    if (dateData != null) {
      // Access import reference.
      importReference = dateData.importReference;

      // Check if a default was set.
      hasDefaultValue = dateData.valueDefaultDate != null && dateData.valueDefaultDate!.isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = dateData.valueDefaultDate!;
    }

    // A default dateAndTimeData object was supplied. Check for values.
    if (dateAndTimeData != null) {
      // Access import reference.
      importReference = dateAndTimeData.importReference;

      // Check if a default was set.
      final bool hasDefaultDateValue = dateAndTimeData.valueDefaultDate != null && dateAndTimeData.valueDefaultDate!.isNotEmpty;
      final bool hasDefaultTimeValue = dateAndTimeData.valueDefaultTime != null && dateAndTimeData.valueDefaultTime!.isNotEmpty;

      // Access timezone.
      final String timezone = dateAndTimeData.timezone.isEmpty ? 'UTC' : dateAndTimeData.timezone;

      // User specified a default.
      if (hasDefaultDateValue) {
        // Update global.
        hasDefaultValue = true;

        // Parse default date.
        final DateTime parsedDefaultDate = HelperFunctions.parseDate(value: dateAndTimeData.valueDefaultDate)!;

        // Parse default time.
        TimeOfDay? parsedDefaultTime = HelperFunctions.parseTimeOfDay(value: dateAndTimeData.valueDefaultTime);

        // If user did not include a time as default but a date, make import possible.
        if (hasDefaultTimeValue == false || parsedDefaultTime == null) parsedDefaultTime = TimeOfDay(hour: 0, minute: 0);

        // Convert to utc.
        final DateTime inUtc = HelperFunctions.convertDefaultsToUtc(
          defaultDate: parsedDefaultDate,
          defaultTime: parsedDefaultTime,
          timezone: timezone,
        );

        // Update default value.
        defaultValue = inUtc.toIso8601String();
      }
    }

    // A default timeData object was supplied. Check for values.
    if (timeData != null) {
      // Access import reference.
      importReference = timeData.importReference;

      // Check if a default was set.
      hasDefaultValue = timeData.value != null;

      // Set defaults.
      if (hasDefaultValue) defaultValue = timeData.getFormattedTime;
    }

    // Check if specified instruction results in a value.
    final bool rowValueExists = importReference != null && row[importReference] != null && row[importReference].toString().trim().isNotEmpty;

    // No value was found.
    if (rowValueExists == false) {
      // * User specified that import should fail.
      if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: importReference, row: currentRow);

      // * User specified that import should skip.
      if (missingShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (missingDefaultOrFail) {
        // * A default was found, use it.
        if (hasDefaultValue) value = defaultValue;

        // * No default found, fail as specified.
        if (hasDefaultValue == false) throw Failure.importMissingValueShouldFail(rowKey: importReference, row: currentRow);
      }

      // * User specified to use default or skip.
      if (missingDefaultOrSkip) {
        // * A default was found, use it.
        if (hasDefaultValue) value = defaultValue;

        // * No default found, skip as specified.
        if (hasDefaultValue == false) return {'skip': true};
      }
    }

    // A value was found, set it.
    if (rowValueExists) {
      value = row[importReference].toString().trim();

      // Make sure that supplied email is valid.
      if (emailData != null) {
        // Check value.
        final bool isValidEmail = EmailData.isValidEmail(value: value);

        // An invalid email was found.
        if (isValidEmail == false) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true};

          // * User specified to use default or fail.
          if (invalidDefaultOrFail) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, fail as specified.
            if (hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);
          }

          // * User specified to use default or skip.
          if (invalidDefaultOrSkip) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, skip as specified.
            if (hasDefaultValue == false) return {'skip': true};
          }
        }
      }

      // Make sure that supplied boolean is valid.
      if (booleanData != null) {
        // Check value.
        final bool? parsed = BooleanData.tryParse(value: value);

        // Boolean could not be parsed
        if (parsed == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true};

          // * User specified to use default or fail.
          if (invalidDefaultOrFail) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, fail as specified.
            if (hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);
          }

          // * User specified to use default or skip.
          if (invalidDefaultOrSkip) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, skip as specified.
            if (hasDefaultValue == false) return {'skip': true};
          }
        }

        // Boolean is valid, set value.
        if (parsed != null) {
          value = parsed.toString();
        }
      }

      // Make sure that supplied DateOfBirth, dateData or dateAndTimeData is valid.
      if (dateOfBirthData != null || dateData != null || dateAndTimeData != null) {
        // Check value.
        final DateTime? isValidDate = HelperFunctions.parseDate(value: value);

        // An invalid date was found.
        if (isValidDate == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true};

          // * User specified to use default or fail.
          if (invalidDefaultOrFail) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, fail as specified.
            if (hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);
          }

          // * User specified to use default or skip.
          if (invalidDefaultOrSkip) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, skip as specified.
            if (hasDefaultValue == false) return {'skip': true};
          }
        }

        // Boolean is valid, set value.
        if (isValidDate != null) value = isValidDate.toIso8601String();
      }

      // Make sure that supplied TimeData is valid.
      if (timeData != null) {
        // Try and turn into dateTime.
        final DateTime? parsed = HelperFunctions.parseDate(value: value);

        // An invalid date was found.
        if (parsed == null) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true};

          // * User specified to use default or fail.
          if (invalidDefaultOrFail) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, fail as specified.
            if (hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: false);
          }

          // * User specified to use default or skip.
          if (invalidDefaultOrSkip) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, skip as specified.
            if (hasDefaultValue == false) return {'skip': true};
          }
        }

        // Set value.
        if (parsed != null) {
          value = parsed.toIso8601String();
        }
      }

      // Make sure that supplied NumberData is valid.
      if (numberData != null) {
        // Convert to default number format.
        value = NumberData.convertToDefaultNumberFormat(value: value);

        // Check value.
        final bool isValidNumber = NumberData.numberValidator(input: value);

        // Ensure that value is not to big.
        final bool tooManyChars = NumberData.tooManyNumberCharacters(input: value);

        // An invalid number was found.
        if (isValidNumber == false || tooManyChars) {
          // * User specified that import should fail.
          if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: tooManyChars);

          // * User specified that import should skip.
          if (invalidShouldSkip) return {'skip': true};

          // * User specified to use default or fail.
          if (invalidDefaultOrFail) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, fail as specified.
            if (hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReference, row: currentRow, tooManyChars: tooManyChars);
          }

          // * User specified to use default or skip.
          if (invalidDefaultOrSkip) {
            // * A default value was found.
            if (hasDefaultValue) value = defaultValue;

            // * No default found, skip as specified.
            if (hasDefaultValue == false) return {'skip': true};
          }
        }
      }
    }

    return {'skip': false, 'value': value};
  }

  /// This helper function can be used to validate tags data.
  /// * Fails if both ```paymentData``` and ```tagsData``` are set.
  Future<Map<String, dynamic>> _validateTagsData({required Map<String, dynamic> row, required LocalStorageCubit localStorageCubit, required PaymentData? paymentData, required LocationData? locationData, required MoneyData? moneyData, required TagsData? tagsData, required int currentRow, required String? importReferenceTags, required bool missingShouldFail, required bool missingShouldSkip, required bool missingDefaultOrFail, required bool missingDefaultOrSkip, required bool invalidShouldFail, required bool invalidShouldSkip, required bool invalidDefaultOrFail, required bool invalidDefaultOrSkip}) async {
    // Init values.
    bool hasDefaults = false;
    TagsData initTagsData = TagsData.initial();

    // Check if specified instruction results in a value.
    final bool rowValueExists = importReferenceTags != null && row[importReferenceTags] != null && row[importReferenceTags].toString().trim().isNotEmpty;

    // A default payment data object was supplied. Check for defaults.
    if (paymentData != null) hasDefaults = paymentData.tagsData.tagReferences.isNotEmpty;

    // A default money data object was supplied. Check for defaults.
    if (moneyData != null) hasDefaults = moneyData.tagsData.tagReferences.isNotEmpty;

    // A default location data object was supplied. Check for defaults.
    if (locationData != null) hasDefaults = locationData.tagsData.tagReferences.isNotEmpty;

    // A default money data object was supplied. Check for defaults.
    if (tagsData != null) hasDefaults = tagsData.tagReferences.isNotEmpty;

    // No value was found.
    if (rowValueExists == false) {
      // * User specified that import should fail.
      if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: importReferenceTags, row: currentRow);

      // * User specified that import should skip.
      if (missingShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (missingDefaultOrFail) {
        // * A default was found, use it.
        if (hasDefaults) {
          // Is in payment mode.
          if (paymentData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...paymentData.tagsData.tagReferences],
            );
          }

          // Is in money mode.
          if (moneyData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...moneyData.tagsData.tagReferences],
            );
          }

          // Is in location mode.
          if (locationData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...locationData.tagsData.tagReferences],
            );
          }

          // Is in tags mode.
          if (tagsData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...tagsData.tagReferences],
            );
          }
        }

        // * No default found, fail as specified.
        if (hasDefaults == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceTags, row: currentRow);
      }

      // * User specified to use default or skip.
      if (missingDefaultOrSkip) {
        // * A default was found, use it.
        if (hasDefaults) {
          // Is in payment mode.
          if (paymentData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...paymentData.tagsData.tagReferences],
            );
          }

          // Is in money mode.
          if (moneyData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...moneyData.tagsData.tagReferences],
            );
          }

          // Is in location mode.
          if (locationData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...locationData.tagsData.tagReferences],
            );
          }

          // Is in tags mode.
          if (tagsData != null) {
            initTagsData = initTagsData.copyWith(
              tagReferences: [...tagsData.tagReferences],
            );
          }
        }

        // * No default found, skip as specified.
        if (hasDefaults == false) return {'skip': true};
      }
    }

    // A row value exists.
    if (rowValueExists) {
      // Access tag value if available.
      final String value = row[importReferenceTags].toString().trim();

      // Convert value to lower case.
      // * If null --> tag is invalid.
      final String? cleanedTagLabel = TagsData.validateTag(value: value);

      // Tag value is valid.
      if (cleanedTagLabel != null) {
        // Check if this is a new or an existing Tag.
        Tag? tag = await localStorageCubit.getLocalTagByLabel(
          tagLabel: cleanedTagLabel,
        );

        // Tag does not exist, create it.
        if (tag == null) {
          // Create tag object.
          final Tag newTag = Tag.initial().copyWith(
            label: cleanedTagLabel,
            creator: user.userId,
          );

          // Update local storage with new tag.
          await localStorageCubit.state.database!.writeTxn(() async {
            tag = await localStorageCubit.createLocalTag(tag: newTag);
          });
        }

        // Create updated Tags object.
        initTagsData = initTagsData.add(
          tagId: tag!.tagId,
        );
      }

      // Tag value is invalid.
      if (cleanedTagLabel == null) {
        // * User specified that import should fail.
        if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceTags, row: currentRow, tooManyChars: false);

        // * User specified that import should skip.
        if (invalidShouldSkip) return {'skip': true};

        // * User specified to use default or fail.
        if (invalidDefaultOrFail) {
          // * A default was found, use it.
          if (hasDefaults) {
            // Is in payment mode.
            if (paymentData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...paymentData.tagsData.tagReferences],
              );
            }

            // Is in money mode.
            if (moneyData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...moneyData.tagsData.tagReferences],
              );
            }

            // Is in location mode.
            if (locationData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...locationData.tagsData.tagReferences],
              );
            }

            // Is in tags mode.
            if (tagsData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...tagsData.tagReferences],
              );
            }
          }

          // * No default found, fail as specified.
          if (hasDefaults == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceTags, row: currentRow, tooManyChars: false);
        }

        // * User specified to use default or skip.
        if (invalidDefaultOrSkip) {
          // * A default was found, use it.
          if (hasDefaults) {
            // Is in payment mode.
            if (paymentData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...paymentData.tagsData.tagReferences],
              );
            }

            // Is in money mode.
            if (moneyData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...moneyData.tagsData.tagReferences],
              );
            }

            // Is in location mode.
            if (locationData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...locationData.tagsData.tagReferences],
              );
            }

            // Is in tags mode.
            if (tagsData != null) {
              initTagsData = initTagsData.copyWith(
                tagReferences: [...tagsData.tagReferences],
              );
            }
          }

          // * No default found, skip as specified.
          if (hasDefaults == false) return {'skip': true};
        }
      }
    }

    return {'skip': false, 'tags_data': initTagsData};
  }

  /// This helper function can be used to validate money data in an import match.
  /// * Fails if both ```paymentData``` and ```moneyData``` are set.
  Map<String, dynamic> _validateMoneyData({required Map<String, dynamic> row, required PaymentData? paymentData, required MoneyData? moneyData, required int currentRow, required String? importReferenceValue, required String? importReferenceCurrency, required bool missingShouldFail, required bool missingShouldSkip, required bool missingDefaultOrFail, required bool missingDefaultOrSkip, required bool invalidShouldFail, required bool invalidShouldSkip, required bool invalidDefaultOrFail, required bool invalidDefaultOrSkip}) {
    // Init values.
    String value = '';
    String currencyCode = '';
    String defaultValue = '';
    String defaultCurrency = '';
    bool hasDefaultValue = false;
    bool hasDefaultCurrency = false;

    // Make sure method fails if both default objects are set because this method can only handle one at a time.
    if (paymentData != null && moneyData != null) throw Failure.genericError();

    // Check if specified instruction results in a value.
    final bool rowValueExists = importReferenceValue != null && row[importReferenceValue] != null && row[importReferenceValue].toString().trim().isNotEmpty;
    final bool rowValueCurrencyExists = importReferenceCurrency != null && row[importReferenceCurrency] != null && row[importReferenceCurrency].toString().trim().isNotEmpty;

    // A default payment data object was supplied. Check for values.
    if (paymentData != null) {
      // Check if a default was set.
      hasDefaultValue = paymentData.total.trim().isNotEmpty;
      hasDefaultCurrency = paymentData.currencyCode.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = paymentData.total.trim();
      if (hasDefaultCurrency) defaultCurrency = paymentData.currencyCode.trim();
    }

    // A default money data object was supplied. Check for values.
    if (moneyData != null) {
      // Check if a default was set.
      hasDefaultValue = moneyData.value.trim().isNotEmpty;
      hasDefaultCurrency = moneyData.currencyCode.trim().isNotEmpty;

      // Set defaults.
      if (hasDefaultValue) defaultValue = moneyData.value.trim();
      if (hasDefaultCurrency) defaultCurrency = moneyData.currencyCode.trim();
    }

    // If a row value or currency exists, set them.
    if (rowValueExists) value = NumberData.convertToDefaultNumberFormat(value: row[importReferenceValue].toString());
    if (rowValueCurrencyExists) currencyCode = row[importReferenceCurrency].toString();

    // No value or currency code was found.
    if (rowValueExists == false || rowValueCurrencyExists == false) {
      // * User specified that import should fail for missing value or currency.
      if (missingShouldFail && rowValueExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceValue, row: currentRow);
      if (missingShouldFail && rowValueCurrencyExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceCurrency, row: currentRow);

      // * User specified that import should skip for missing value or currency.
      if (missingShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (missingDefaultOrFail) {
        // * A default value and currency were found, use them.
        if (hasDefaultValue) value = defaultValue;
        if (hasDefaultCurrency) currencyCode = defaultCurrency;

        // * No default found, fail as specified.
        if (hasDefaultValue == false || hasDefaultCurrency == false) {
          if (hasDefaultValue == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceValue!, row: currentRow);
          if (hasDefaultCurrency == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceCurrency!, row: currentRow);
        }
      }

      // * User specified to use default or skip.
      if (missingDefaultOrSkip) {
        // * A default value and currency were found, use them.
        if (hasDefaultValue) value = defaultValue;
        if (hasDefaultCurrency) currencyCode = defaultCurrency;

        // * No default found, skip as specified.
        if (hasDefaultValue == false || hasDefaultCurrency == false) return {'skip': true};
      }
    }

    // Make sure value is number.
    // * This returns false if the value is empty.
    final bool validNumber = NumberData.numberValidator(input: value);

    // Ensure that value is not to big.
    final bool tooManyChars = NumberData.tooManyNumberCharacters(input: value);

    // Make sure currency code is known.
    // * This returns null if value is empty.
    final CountrySpecification? countrySpecification = CountrySpecification.getCountrySpecificationByIsoCurrencyCode(isoCurrencyCode: currencyCode);

    // * Invalid number or invalid currency code.
    if (validNumber == false || countrySpecification == null || tooManyChars) {
      // * User specified that import should fail.
      if (invalidShouldFail) {
        if (validNumber == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceValue, row: currentRow, tooManyChars: tooManyChars);
        if (countrySpecification == null) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceCurrency, row: currentRow, tooManyChars: tooManyChars);
      }

      // * User specified that import should skip.
      if (invalidShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (invalidDefaultOrFail) {
        // * A default value and currency were found, use them.
        if (hasDefaultValue) value = defaultValue;
        if (hasDefaultCurrency) currencyCode = defaultCurrency;

        // * No default found, fail as specified.
        if (hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceValue, row: currentRow, tooManyChars: false);
        if (hasDefaultCurrency == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceCurrency, row: currentRow, tooManyChars: false);
      }

      // * User specified to use default or skip.
      if (invalidDefaultOrSkip) {
        // * A default value and currency were found, use them.
        if (hasDefaultValue) value = defaultValue;
        if (hasDefaultCurrency) currencyCode = defaultCurrency;

        // * No default found, skip as specified.
        if (hasDefaultValue == false || hasDefaultCurrency == false) return {'skip': true};
      }
    }

    return {'skip': false, 'value': value, 'currency_code': currencyCode};
  }

  /// This helper function can be used to access a member value for a payment field from supplied row.
  Map<String, dynamic> _accessMemberValue({required Map<String, dynamic> row, required PaymentData paymentData, required int currentRow, required String? importReferenceValue, required bool missingShouldFail, required bool missingShouldSkip, required bool missingDefaultOrFail, required bool missingDefaultOrSkip, required bool invalidShouldFail, required bool invalidShouldSkip, required bool invalidDefaultOrFail, required bool invalidDefaultOrSkip}) {
    // Init values.
    String value = '';

    // Check if specified instruction results in a value.
    final bool rowValueExists = importReferenceValue != null && row[importReferenceValue] != null && row[importReferenceValue].toString().trim().isNotEmpty;

    // Check if a default was set.
    final bool hasDefaultValue = paymentData.total.isNotEmpty;

    // If a row value or currency exists, set them.
    if (rowValueExists) value = NumberData.convertToDefaultNumberFormat(value: row[importReferenceValue].toString());

    // No value was found.
    if (rowValueExists == false) {
      // If user specified that missing member values should be declared as 0.00, do so.
      if (paymentData.importReferenceForceMemberValueImport) value = '0.00';

      // Only perform these if user specified to.
      if (paymentData.importReferenceForceMemberValueImport == false) {
        // * User specified that import should fail for missing value or currency.
        if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: importReferenceValue, row: currentRow);

        // * User specified that import should skip for missing value or currency.
        if (missingShouldSkip) return {'skip': true};

        // * User specified to use default or fail.
        if (missingDefaultOrFail) {
          // * A default value was found, use them.
          if (hasDefaultValue) value = paymentData.total;

          // * No default found, fail as specified.
          if (hasDefaultValue == false) {
            if (hasDefaultValue == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceValue!, row: currentRow);
          }
        }

        // * User specified to use default or skip.
        if (missingDefaultOrSkip) {
          // * A default value was found, use them.
          if (hasDefaultValue) value = paymentData.total;

          // * No default found, skip as specified.
          if (hasDefaultValue == false) return {'skip': true};
        }
      }
    }

    // Make sure value is number.
    // * This returns false if the value is empty.
    final bool validNumber = NumberData.numberValidator(input: value);

    // Ensure that value is not to big.
    final bool tooManyChars = NumberData.tooManyNumberCharacters(input: value);

    // * Invalid number code.
    if (validNumber == false || tooManyChars) {
      // * User specified that import should fail.
      if (invalidShouldFail) {
        if (validNumber == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceValue, row: currentRow, tooManyChars: tooManyChars);
      }

      // * User specified that import should skip.
      if (invalidShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (invalidDefaultOrFail) {
        // * A default value and currency were found, use them.
        if (hasDefaultValue) value = paymentData.total;

        // * No default found, fail as specified.
        if (hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceValue, row: currentRow, tooManyChars: tooManyChars);
      }

      // * User specified to use default or skip.
      if (invalidDefaultOrSkip) {
        // * A default value and currency were found, use them.
        if (hasDefaultValue) value = paymentData.total;

        // * No default found, skip as specified.
        if (hasDefaultValue == false) return {'skip': true};
      }
    }

    // If the value is negative, turn into a positive number.
    if (double.parse(value) < 0) value = (double.parse(value) * -1).toString();

    return {'skip': false, 'value': value};
  }

  /// This helper function can be used to validate LocationData in an import match.
  Map<String, dynamic> _validateLocationData({required Map<String, dynamic> row, required LocationData locationData, required int currentRow, required bool missingShouldFail, required bool missingShouldSkip, required bool missingDefaultOrFail, required bool missingDefaultOrSkip, required bool invalidShouldFail, required bool invalidShouldSkip, required bool invalidDefaultOrFail, required bool invalidDefaultOrSkip}) {
    // Init values.
    String latitudeValue = '';
    String longitudeValue = '';

    String defaultLatitude = '';
    String defaultLongitude = '';

    // Access import references.
    final String? importReferenceLatitude = locationData.importReferenceLatitude;
    final String? importReferenceLongitude = locationData.importReferenceLongitude;

    // Check if specified instruction results in a value.
    final bool rowValueLatitudeExists = importReferenceLatitude != null && row[importReferenceLatitude] != null && row[importReferenceLatitude].toString().trim().isNotEmpty;
    final bool rowValueLongitudeExists = importReferenceLongitude != null && row[importReferenceLongitude] != null && row[importReferenceLongitude].toString().trim().isNotEmpty;

    // Check if a default was set.
    final bool hasDefaultLatitude = locationData.latitude.trim().isNotEmpty;
    final bool hasDefaultLongitude = locationData.longitude.trim().isNotEmpty;

    // Set defaults.
    if (hasDefaultLatitude) defaultLatitude = locationData.latitude.trim();
    if (hasDefaultLongitude) defaultLongitude = locationData.longitude.trim();

    // If a row values exists, set them.
    if (rowValueLatitudeExists) latitudeValue = NumberData.convertToDefaultNumberFormat(value: row[importReferenceLatitude].toString());
    if (rowValueLongitudeExists) longitudeValue = NumberData.convertToDefaultNumberFormat(value: row[importReferenceLongitude].toString());

    // No latitude or longitude found.
    if (rowValueLatitudeExists == false || rowValueLongitudeExists == false) {
      // * User specified that import should fail for missing value or currency.
      if (missingShouldFail && rowValueLatitudeExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceLatitude, row: currentRow);
      if (missingShouldFail && rowValueLongitudeExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceLongitude, row: currentRow);

      // * User specified that import should skip for missing value or currency.
      if (missingShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (missingDefaultOrFail) {
        // Check for latitude defaults.
        if (rowValueLatitudeExists == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLatitude) latitudeValue = defaultLatitude;
        }

        // Check for longitude defaults.
        if (rowValueLongitudeExists == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLongitude) longitudeValue = defaultLongitude;
        }

        // * No default found, fail as specified.
        if (rowValueLatitudeExists == false && hasDefaultLatitude == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceLatitude!, row: currentRow);
        if (rowValueLongitudeExists == false && hasDefaultLongitude == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceLongitude!, row: currentRow);
      }

      // * User specified to use default or skip.
      if (missingDefaultOrSkip) {
        // Check for latitude defaults.
        if (rowValueLatitudeExists == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLatitude) latitudeValue = defaultLatitude;
        }

        // Check for longitude defaults.
        if (rowValueLongitudeExists == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLongitude) longitudeValue = defaultLongitude;
        }

        // * No default found, skip as specified.
        if (rowValueLatitudeExists == false && hasDefaultLatitude == false) return {'skip': true};
        if (rowValueLongitudeExists == false && hasDefaultLongitude == false) return {'skip': true};
      }
    }

    // Make sure values are numbers.
    // * This returns false if the value is empty.
    final bool validLatitude = NumberData.numberValidator(input: latitudeValue);
    final bool validLongitude = NumberData.numberValidator(input: longitudeValue);

    // Ensure that value is not to big.
    final bool tooManyCharsLat = NumberData.tooManyNumberCharacters(input: latitudeValue);

    // Ensure that value is not to big.
    final bool tooManyCharsLng = NumberData.tooManyNumberCharacters(input: longitudeValue);

    // * Invalid lat or lng.
    if (validLatitude == false || validLongitude == false) {
      // * User specified that import should fail.
      if (invalidShouldFail) {
        if (validLatitude == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceLatitude, row: currentRow, tooManyChars: tooManyCharsLat);
        if (validLongitude == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceLongitude, row: currentRow, tooManyChars: tooManyCharsLng);
      }

      // * User specified that import should skip.
      if (invalidShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (invalidDefaultOrFail) {
        // Check for latitude defaults.
        if (validLatitude == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLatitude) latitudeValue = defaultLatitude;
        }

        // Check for longitude defaults.
        if (validLongitude == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLongitude) longitudeValue = defaultLongitude;
        }

        // * No default found, fail as specified.
        if (validLatitude == false && hasDefaultLatitude == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceLatitude!, row: currentRow, tooManyChars: tooManyCharsLat);
        if (validLongitude == false && hasDefaultLongitude == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceLongitude!, row: currentRow, tooManyChars: tooManyCharsLng);
      }

      // * User specified to use default or skip.
      if (invalidDefaultOrSkip) {
        // Check for latitude defaults.
        if (validLatitude == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLatitude) latitudeValue = defaultLatitude;
        }

        // Check for longitude defaults.
        if (validLongitude == false) {
          // * A default value and currency were found, use them.
          if (hasDefaultLongitude) longitudeValue = defaultLongitude;
        }

        // * No default found, skip as specified.
        if (validLatitude == false && hasDefaultLatitude == false) return {'skip': true};
        if (validLongitude == false && hasDefaultLongitude == false) return {'skip': true};
      }
    }

    return {'skip': false, 'lat': latitudeValue, 'lng': longitudeValue, 'type': "Point"};
  }

  /// This helper function can be used to validate Measurement in an import match.
  Map<String, dynamic> _validateMeasurementData({required Map<String, dynamic> row, required MeasurementData measurementData, required int currentRow, required bool missingShouldFail, required bool missingShouldSkip, required bool missingDefaultOrFail, required bool missingDefaultOrSkip, required bool invalidShouldFail, required bool invalidShouldSkip, required bool invalidDefaultOrFail, required bool invalidDefaultOrSkip}) {
    // Init values.
    String category = '';
    String unit = '';
    String value = '';

    String defaultCategory = '';
    String defaultUnit = '';
    String defaultValue = '';

    // Access import references.
    final String? importReferenceCategory = measurementData.importReferenceCategory;
    final String? importReferenceUnit = measurementData.importReferenceUnit;
    final String? importReferenceValue = measurementData.importReferenceValue;

    // Check if specified instruction results in a value.
    final bool rowValueCategoryExists = importReferenceCategory != null && row[importReferenceCategory] != null && row[importReferenceCategory].toString().trim().isNotEmpty;
    final bool rowValueUnitExists = importReferenceUnit != null && row[importReferenceUnit] != null && row[importReferenceUnit].toString().trim().isNotEmpty;
    final bool rowValueExists = importReferenceValue != null && row[importReferenceValue] != null && row[importReferenceValue].toString().trim().isNotEmpty;

    // Check if a default was set.
    final bool hasDefaultCategory = measurementData.category.trim().isNotEmpty;
    final bool hasDefaultUnit = measurementData.unit.trim().isNotEmpty;
    final bool hasDefaultValue = measurementData.value.trim().isNotEmpty;

    // Set defaults.
    if (hasDefaultCategory) defaultCategory = measurementData.category.trim();
    if (hasDefaultUnit) defaultUnit = measurementData.unit.trim();
    if (hasDefaultValue) defaultValue = measurementData.value.trim();

    // If a row values exists, set them.
    if (rowValueCategoryExists) category = row[importReferenceCategory].toString();
    if (rowValueUnitExists) unit = row[importReferenceUnit].toString();
    if (rowValueExists) value = NumberData.convertToDefaultNumberFormat(value: row[importReferenceValue].toString());

    // Handle missing values.
    if (rowValueCategoryExists == false || rowValueUnitExists == false || rowValueExists == false) {
      // * User specified that import should fail for missing value or currency.
      if (missingShouldFail && rowValueCategoryExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceCategory, row: currentRow);
      if (missingShouldFail && rowValueUnitExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceUnit, row: currentRow);
      if (missingShouldFail && rowValueExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceValue, row: currentRow);

      // * User specified that import should skip for missing value or currency.
      if (missingShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (missingDefaultOrFail) {
        // Check for defaults.
        if (rowValueCategoryExists == false) {
          // * A default value was found, use them.
          if (hasDefaultCategory) category = defaultCategory;
        }

        // Check for defaults.
        if (rowValueUnitExists == false) {
          // * A default value was found, use them.
          if (hasDefaultUnit) unit = defaultUnit;
        }

        // Check for defaults.
        if (rowValueExists == false) {
          // * A default value was found, use them.
          if (hasDefaultValue) value = defaultValue;
        }

        // * No default found, fail as specified.
        if (rowValueCategoryExists == false && hasDefaultCategory == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceCategory!, row: currentRow);
        if (rowValueUnitExists == false && hasDefaultUnit == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceUnit!, row: currentRow);
        if (rowValueExists == false && hasDefaultValue == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceValue!, row: currentRow);
      }

      // * User specified to use default or skip.
      if (missingDefaultOrSkip) {
        // Check for defaults.
        if (rowValueCategoryExists == false) {
          // * A default value was found, use them.
          if (hasDefaultCategory) category = defaultCategory;
        }

        // Check for defaults.
        if (rowValueUnitExists == false) {
          // * A default value was found, use them.
          if (hasDefaultUnit) unit = defaultUnit;
        }

        // Check for defaults.
        if (rowValueExists == false) {
          // * A default value was found, use them.
          if (hasDefaultValue) value = defaultValue;
        }

        // * No default found, skip as specified.
        if (rowValueCategoryExists == false && hasDefaultCategory == false) return {'skip': true};
        if (rowValueUnitExists == false && hasDefaultUnit == false) return {'skip': true};
        if (rowValueExists == false && hasDefaultValue == false) return {'skip': true};
      }
    }

    // Translate category to english.
    final String? mappedCategory = MeasurementData.mapCategoryToEnglish(category: category);

    // Set value if it was found.
    if (mappedCategory != null) category = mappedCategory;

    // Make sure that category is valid.
    final bool isValidCategory = MeasurementData.isValidCategory(category: category);

    // Make sure that unit is valid.
    final bool isValidUnit = MeasurementData.isValidUnit(unit: unit);

    // Make sure category and unit form a valid pair.
    bool isValidPair = false;
    bool isValidDefaultPair = false;

    // If both values seem valid, check if they form a valid pair
    if (isValidCategory && isValidUnit) {
      // Ensure that picked unit fits with picked category.
      final PickerItems unitsOfCategory = MeasurementData.unitsAsPickerItems(category: category)!;

      // Check if unit exists for this category.
      final PickerItem? pickedItem = unitsOfCategory.getById(id: unit, caseSensitive: false);

      // Update valid pair flag.
      if (pickedItem != null) isValidPair = true;
    }

    // Transform value into default number format.
    value = NumberData.convertToDefaultNumberFormat(value: value);

    // Make sure value is valid number.
    final bool isValidValue = NumberData.numberValidator(input: value);

    // Ensure that value is not to big.
    final bool tooManyChars = NumberData.tooManyNumberCharacters(input: value);

    // * Invalid category, unit, pair or value.
    if (isValidCategory == false || isValidUnit == false || isValidValue == false || isValidPair == false) {
      // * User specified that import should fail.
      if (invalidShouldFail) {
        if (isValidCategory == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceCategory, row: currentRow, tooManyChars: tooManyChars);
        if (isValidUnit == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceUnit, row: currentRow, tooManyChars: tooManyChars);
        if (isValidPair == false) throw Failure.importInvalidMeasurementPair(category: category, unit: unit, row: currentRow);
        if (isValidValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceValue, row: currentRow, tooManyChars: tooManyChars);
      }

      // * User specified that import should skip.
      if (invalidShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (invalidDefaultOrFail) {
        // Check for defaults.
        if (isValidCategory == false) {
          // * A default was found, use them.
          if (hasDefaultCategory) category = defaultCategory;
        }

        // Check for defaults.
        if (isValidUnit == false) {
          // * A default was found, use them.
          if (hasDefaultUnit) unit = defaultUnit;
        }

        // Check for defaults.
        if (isValidValue == false) {
          // * A default was found, use them.
          if (hasDefaultValue) value = defaultValue;
        }

        // * Check again if category and unit are still a valid pair. This is needed because it is possible that only one
        // * of the two was changed to the default.

        // Ensure that picked unit fits with picked category.
        final PickerItems? unitsOfCategory = MeasurementData.unitsAsPickerItems(category: category);

        // Check if unit exists for this category.
        final PickerItem? pickedItem = unitsOfCategory?.getById(id: unit, caseSensitive: false);

        // Update valid pair flag.
        if (pickedItem != null) isValidDefaultPair = true;

        // Invalid pair.
        if (isValidDefaultPair == false) throw Failure.importInvalidMeasurementPair(category: category, unit: unit, row: currentRow);

        // * No default found, fail as specified.
        if (isValidCategory == false && hasDefaultCategory == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceCategory!, row: currentRow, tooManyChars: false);
        if (isValidUnit == false && hasDefaultUnit == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceUnit!, row: currentRow, tooManyChars: false);
        if (isValidValue == false && hasDefaultValue == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceValue!, row: currentRow, tooManyChars: false);
      }

      // * User specified to use default or skip.
      if (invalidDefaultOrSkip) {
        // Check for defaults.
        if (isValidCategory == false) {
          // * A default was found, use them.
          if (hasDefaultCategory) category = defaultCategory;
        }

        // Check for defaults.
        if (isValidUnit == false) {
          // * A default was found, use them.
          if (hasDefaultUnit) unit = defaultUnit;
        }

        // Check for defaults.
        if (isValidValue == false) {
          // * A default was found, use them.
          if (hasDefaultValue) value = defaultValue;
        }

        // * Check again if category and unit are still a valid pair. This is needed because it is possible that only one
        // * of the two was changed to the default.

        // Ensure that picked unit fits with picked category.
        final PickerItems? unitsOfCategory = MeasurementData.unitsAsPickerItems(category: category);

        // Check if unit exists for this category.
        final PickerItem? pickedItem = unitsOfCategory?.getById(id: unit, caseSensitive: false);

        // Update valid pair flag.
        if (pickedItem != null) isValidDefaultPair = true;

        // Invalid pair.
        if (isValidDefaultPair == false) return {'skip': true};

        // * No default found, fail as specified.
        if (isValidCategory == false && hasDefaultCategory == false) return {'skip': true};
        if (isValidUnit == false && hasDefaultUnit == false) return {'skip': true};
        if (isValidValue == false && hasDefaultValue == false) return {'skip': true};
      }
    }

    return {'skip': false, 'category': category, 'unit': unit, 'value': value};
  }

  /// This helper function can be used to validate PhoneData in an import match.
  Map<String, dynamic> _validatePhoneData({required Map<String, dynamic> row, required PhoneData phoneData, required int currentRow, required bool missingShouldFail, required bool missingShouldSkip, required bool missingDefaultOrFail, required bool missingDefaultOrSkip, required bool invalidShouldFail, required bool invalidShouldSkip, required bool invalidDefaultOrFail, required bool invalidDefaultOrSkip}) {
    // Init values.
    String prefix = '';
    String phone = '';

    String defaultPrefix = "";
    String defaultPhone = '';

    // Access import references.
    final String? importReferencePrefix = phoneData.importReferenceInternationalPrefix;
    final String? importReferencePhone = phoneData.importReference;

    // Check if specified instruction results in a value.
    final bool rowValuePrefixExists = importReferencePrefix != null && row[importReferencePrefix] != null && row[importReferencePrefix].toString().trim().isNotEmpty;
    final bool rowValuePhoneExists = importReferencePhone != null && row[importReferencePhone] != null && row[importReferencePhone].toString().trim().isNotEmpty;

    // Check if a default was set.
    final bool hasDefaultPrefix = phoneData.internationalPrefix.trim().isNotEmpty;
    final bool hasDefaultPhone = phoneData.value.trim().isNotEmpty;

    // Set defaults.
    if (hasDefaultPrefix) defaultPrefix = phoneData.internationalPrefix.trim();
    if (hasDefaultPhone) defaultPhone = phoneData.value.trim();

    // If a row values exists, set them.
    if (rowValuePrefixExists) prefix = row[importReferencePrefix].toString();
    if (rowValuePhoneExists) phone = row[importReferencePhone].toString();

    // Handle missing values.
    if (rowValuePhoneExists == false) {
      // * User specified that import should fail for missing value.
      if (missingShouldFail) throw Failure.importMissingValueShouldFail(rowKey: importReferencePhone, row: currentRow);

      // * User specified that import should skip for missing value.
      if (missingShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (missingDefaultOrFail) {
        // * A default value was found, use them.
        if (hasDefaultPhone) phone = defaultPhone;

        // * No default found, fail as specified.
        if (hasDefaultPhone == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferencePhone!, row: currentRow);
      }

      // * User specified to use default or skip.
      if (missingDefaultOrSkip) {
        // * A default value was found, use them.
        if (hasDefaultPhone) phone = defaultPhone;

        // * No default found, skip as specified.
        if (hasDefaultPhone == false) return {'skip': true};
      }
    }

    // Make sure that prefix is valid.
    // * This will return an empty String if prefix is empty or null because that means user does not want a prefix which is possible
    // * because it is a optional value.
    String? validatedPrefix = PhoneData.validatePrefix(value: prefix);

    // Make sure that phone is valid.
    String? validatedPhone = PhoneData.validatePhone(value: phone);

    // * Invalid prefix or phone.
    if (validatedPhone == null) {
      // * User specified that import should fail.
      if (invalidShouldFail) throw Failure.importInvalidValueShouldFail(rowKey: importReferencePhone, row: currentRow, tooManyChars: false);

      // * User specified that import should skip.
      if (invalidShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (invalidDefaultOrFail) {
        // * A default value was found, use them.
        if (hasDefaultPhone) validatedPhone = defaultPhone;

        // * No default found, fail as specified.
        if (hasDefaultPhone == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferencePhone!, row: currentRow, tooManyChars: false);
      }

      // * User specified to use default or skip.
      if (invalidDefaultOrSkip) {
        // * A default value was found, use them.
        if (hasDefaultPhone) validatedPhone = defaultPhone;

        // * No default found, fail as specified.
        if (hasDefaultPhone == false) return {'skip': true};
      }
    }

    // Check if a default rpefix exists.
    if (defaultPrefix.isNotEmpty) {
      // If a prefix is not available but a default was set, use it.
      if (validatedPrefix == null || validatedPrefix.isEmpty) validatedPrefix = defaultPrefix;
    }

    return {'skip': false, 'prefix': validatedPrefix ?? "", 'phone': validatedPhone};
  }

  /// This helper function can be used to validate EmotionData in an import match.
  Map<String, dynamic> _validateEmotionData({required Map<String, dynamic> row, required EmotionData emotionData, required int currentRow, required bool missingShouldFail, required bool missingShouldSkip, required bool missingDefaultOrFail, required bool missingDefaultOrSkip, required bool invalidShouldFail, required bool invalidShouldSkip, required bool invalidDefaultOrFail, required bool invalidDefaultOrSkip}) {
    List<EmotionItem> emotionItems = [];
    List<EmotionItem> defaultEmotions = [];

    // Access import references.
    final String? importReferenceEmotion = emotionData.importReferenceEmotion;
    final String? importReferenceIntensity = emotionData.importReferenceIntensity;
    final String? importReferenceOccurrence = emotionData.importReferenceOccurrence;

    // Check if specified instruction results in a value.
    bool rowValueEmotionExists = importReferenceEmotion != null && row[importReferenceEmotion] != null && row[importReferenceEmotion].toString().trim().isNotEmpty;
    bool rowValueIntensityExists = importReferenceIntensity != null && row[importReferenceIntensity] != null && row[importReferenceIntensity].toString().trim().isNotEmpty;
    bool rowValueOccurrenceExists = importReferenceOccurrence != null && row[importReferenceOccurrence] != null && row[importReferenceOccurrence].toString().trim().isNotEmpty;

    // Access values.
    final List<String>? parsedEmotions = rowValueEmotionExists ? tryParseStringList(value: row[importReferenceEmotion]) : [];
    final List<String>? parsedIntensities = rowValueIntensityExists ? tryParseStringList(value: row[importReferenceIntensity]) : [];
    final List<String>? parsedOccurrences = rowValueOccurrenceExists ? tryParseStringList(value: row[importReferenceOccurrence]) : [];

    // Update indicators.
    if (parsedEmotions != null && parsedEmotions.isEmpty) rowValueEmotionExists = false;
    if (parsedIntensities != null && parsedIntensities.isEmpty) rowValueIntensityExists = false;
    if (parsedOccurrences != null && parsedOccurrences.isEmpty) rowValueOccurrenceExists = false;

    // Check if a default was set.
    final bool hasDefaultEmotions = emotionData.emotions.isNotEmpty;

    // Set defaults.
    if (hasDefaultEmotions) defaultEmotions = emotionData.emotions;

    // Handle missing values.
    if (rowValueEmotionExists == false || rowValueIntensityExists == false || rowValueOccurrenceExists == false) {
      // * User specified that import should fail for missing value or currency.
      if (missingShouldFail && rowValueEmotionExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceEmotion, row: currentRow);
      if (missingShouldFail && rowValueIntensityExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceIntensity, row: currentRow);
      if (missingShouldFail && rowValueOccurrenceExists == false) throw Failure.importMissingValueShouldFail(rowKey: importReferenceOccurrence, row: currentRow);

      // * User specified that import should skip for missing value or currency.
      if (missingShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (missingDefaultOrFail) {
        // * A default value was found, use them.
        if (hasDefaultEmotions) emotionItems = defaultEmotions;

        // * No default found, fail as specified.
        if (hasDefaultEmotions == false) throw Failure.importMissingDefaultShouldFail(rowKey: importReferenceEmotion!, row: currentRow);
      }

      // * User specified to use default or skip.
      if (missingDefaultOrSkip) {
        // * A default value was found, use them.
        if (hasDefaultEmotions) emotionItems = defaultEmotions;

        // * No default found, fail as specified.
        if (hasDefaultEmotions == false) return {'skip': true};
      }
    }

    // Indicator if all list have an equal amount of items.
    bool equalListLength = false;

    // If all three lists seem to have items set, make sure their length is equal because
    // only then the emotion items can be correctly generated.
    if (parsedEmotions != null && parsedIntensities != null && parsedOccurrences != null) {
      // Access number of emotions.
      final int numberOfEmotions = parsedEmotions.length;
      final int numberOfIntensities = parsedIntensities.length;
      final int numberOfOccurrences = parsedOccurrences.length;

      equalListLength = numberOfEmotions == numberOfIntensities && numberOfIntensities == numberOfOccurrences;
    }

    // * Invalid lists.
    if (equalListLength == false || parsedEmotions == null || parsedIntensities == null || parsedOccurrences == null) {
      // * User specified that import should fail.
      if (invalidShouldFail) {
        if (equalListLength == false) throw Failure.importEmotionsListLengthsDiffer(row: currentRow);
        if (parsedEmotions == null) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceEmotion, row: currentRow, tooManyChars: false);
        if (parsedIntensities == null) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceIntensity, row: currentRow, tooManyChars: false);
        if (parsedOccurrences == null) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceOccurrence, row: currentRow, tooManyChars: false);
      }

      // * User specified that import should skip.
      if (invalidShouldSkip) return {'skip': true};

      // * User specified to use default or fail.
      if (invalidDefaultOrFail) {
        // * A default value was found, use them.
        if (hasDefaultEmotions) emotionItems = defaultEmotions;

        // * No default found, fail as specified.
        if (hasDefaultEmotions == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceEmotion!, row: currentRow, tooManyChars: false);
      }

      // * User specified to use default or skip.
      if (invalidDefaultOrSkip) {
        // * A default value was found, use them.
        if (hasDefaultEmotions) emotionItems = defaultEmotions;

        // * No default found, fail as specified.
        if (hasDefaultEmotions == false) return {'skip': true};
      }
    }

    // Access language specific emotions.
    final PickerItems pickerItems = EmotionData.emotionsAsPickerItems();

    // Validate and set emotion items.
    for (int i = 0; i < parsedEmotions!.length; i++) {
      // Access data.
      final String emotion = parsedEmotions[i];
      final int? intensity = int.tryParse(parsedIntensities![i]);
      final DateTime? occurrenceInUtc = HelperFunctions.parseDate(value: parsedOccurrences![i])?.toUtc();

      // Check if values are valid.
      final bool validEmotion = pickerItems.getById(id: emotion) != null;
      final bool validIntensity = intensity != null;
      final bool validOccurrence = occurrenceInUtc != null;

      // Invalid data!
      if (validEmotion == false || validIntensity == false || validOccurrence == false) {
        // * User specified that import should fail.
        // * In this case no default is possible which is why invalidDefaultOrFail is the same as invalidShouldFail.
        if (invalidShouldFail || invalidDefaultOrFail) {
          if (validEmotion == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceEmotion, row: currentRow, tooManyChars: false);
          if (validIntensity == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceIntensity, row: currentRow, tooManyChars: false);
          if (validOccurrence == false) throw Failure.importInvalidValueShouldFail(rowKey: importReferenceOccurrence, row: currentRow, tooManyChars: false);
        }

        // * User specified that import should skip.
        // * In this case no default is possible.
        if (invalidShouldSkip || invalidDefaultOrSkip) return {'skip': true};
      }

      // Create EmotionItem.
      final EmotionItem emotionItem = EmotionItem.initial().copyWith(
        emotion: emotion,
        intensity: intensity!,
        occurrenceInUtc: occurrenceInUtc!,
        occurrenceTimeZone: 'UTC',
      );

      // Add to list.
      emotionItems.add(emotionItem);
    }

    return {'skip': false, 'emotions': emotionItems};
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```Field``` object to a ```DbField``` object.
  DbField toSchema({required bool isDefault, required bool isImport}) {
    // Convenience variables.
    final bool includeTextField = TextData.includeField(textData: textData, isDefault: isDefault, isImport: isImport);
    final bool includePasswordField = PasswordData.includeField(passwordData: passwordData, isDefault: isDefault, isImport: isImport);
    final bool includePhoneData = PhoneData.includeField(phoneData: phoneData, isDefault: isDefault, isImport: isImport);
    final bool includeDateData = DateData.includeField(dateData: dateData, isDefault: isDefault, isImport: isImport);
    final bool includeDateAndTimeData = DateAndTimeData.includeField(dateAndTimeData: dateAndTimeData, isDefault: isDefault, isImport: isImport);
    final bool includeTimeData = TimeData.includeField(timeData: timeData, isDefault: isDefault, isImport: isImport);
    final bool includeNumberData = NumberData.includeField(numberData: numberData, isDefault: isDefault, isImport: isImport);
    final bool includeEmailData = EmailData.includeField(emailData: emailData, isDefault: isDefault, isImport: isImport);
    final bool includeWebsiteData = WebsiteData.includeField(websiteData: websiteData, isDefault: isDefault, isImport: isImport);
    final bool includeUsernameData = UsernameData.includeField(usernameData: usernameData, isDefault: isDefault, isImport: isImport);
    final bool includeLocationData = LocationData.includeField(locationData: locationData, isDefault: isDefault, isImport: isImport);
    final bool includeMoneyField = MoneyData.includeField(moneyData: moneyData, isDefault: isDefault, isImport: isImport);
    final bool includePaymentField = PaymentData.includeField(paymentData: paymentData, isDefault: isDefault, isImport: isImport);
    final bool includeDateOfBirthField = DateOfBirthData.includeField(dateOfBirthData: dateOfBirthData, isDefault: isDefault, isImport: isImport);
    final bool includeTagsField = TagsData.includeField(tagsData: tagsData, isDefault: isDefault, isImport: isImport);
    final bool includeMeasurementField = MeasurementData.includeField(measurementData: measurementData, isDefault: isDefault, isImport: isImport);
    final bool includeBooleanData = BooleanData.includeField(booleanData: booleanData, isDefault: isDefault, isImport: isImport);
    final bool includeEmotionData = EmotionData.includeField(emotionData: emotionData, isDefault: isDefault, isImport: isImport);
    final bool includeImageData = ImageData.includeField(imageData: imageData, isDefault: isDefault, isImport: isImport);
    final bool includeFileData = FileData.includeField(fileData: fileData, isDefault: isDefault, isImport: isImport);
    final bool includeAvatarImageData = AvatarImageData.includeField(avatarImageData: avatarImageData, isDefault: isDefault, isImport: isImport);

    return DbField(
      fieldId: fieldId,
      fieldType: fieldType,
      canChangeParameters: canChangeParameters,
      textData: includeTextField ? textData!.toSchema() : null,
      passwordData: includePasswordField ? passwordData!.toSchema() : null,
      phoneData: includePhoneData ? phoneData!.toSchema() : null,
      dateData: includeDateData ? dateData!.toSchema() : null,
      timeData: includeTimeData ? timeData!.toSchema() : null,
      numberData: includeNumberData ? numberData!.toSchema() : null,
      emailData: includeEmailData ? emailData!.toSchema() : null,
      websiteData: includeWebsiteData ? websiteData!.toSchema() : null,
      usernameData: includeUsernameData ? usernameData!.toSchema() : null,
      dateAndTimeData: includeDateAndTimeData ? dateAndTimeData!.toSchema() : null,
      locationData: includeLocationData ? locationData!.toSchema() : null,
      moneyData: includeMoneyField ? moneyData!.toSchema() : null,
      paymentData: includePaymentField ? paymentData!.toSchema() : null,
      dateOfBirthData: includeDateOfBirthField ? dateOfBirthData!.toSchema() : null,
      tagsData: includeTagsField ? tagsData!.toSchema() : null,
      measurementData: includeMeasurementField ? measurementData!.toSchema() : null,
      emotionData: includeEmotionData ? emotionData!.toSchema() : null,
      booleanData: includeBooleanData ? booleanData!.toSchema() : null,
      imageData: includeImageData ? imageData!.toSchema() : null,
      fileData: includeFileData ? fileData!.toSchema() : null,
      avatarImageData: includeAvatarImageData ? avatarImageData!.toSchema() : null,
    );
  }

  /// Convert a ```DbField``` object to a ```Field``` object.
  static Field fromSchema({required DbField schema}) {
    return Field(
      fieldId: schema.fieldId!,
      fieldType: schema.fieldType!,
      canChangeParameters: schema.canChangeParameters!,
      dateData: DateData.fromSchema(schema: schema.dateData),
      numberData: NumberData.fromSchema(schema: schema.numberData),
      moneyData: MoneyData.fromSchema(schema: schema.moneyData),
      passwordData: PasswordData.fromSchema(schema: schema.passwordData),
      phoneData: PhoneData.fromSchema(schema: schema.phoneData),
      textData: TextData.fromSchema(schema: schema.textData),
      timeData: TimeData.fromSchema(schema: schema.timeData),
      emailData: EmailData.fromSchema(schema: schema.emailData),
      websiteData: WebsiteData.fromSchema(schema: schema.websiteData),
      usernameData: UsernameData.fromSchema(schema: schema.usernameData),
      dateAndTimeData: DateAndTimeData.fromSchema(schema: schema.dateAndTimeData),
      locationData: LocationData.fromSchema(schema: schema.locationData),
      // * CustomExchangeRateDate is available in the PaymentField.
      paymentData: PaymentData.fromSchema(schema: schema.paymentData),
      dateOfBirthData: DateOfBirthData.fromSchema(schema: schema.dateOfBirthData),
      tagsData: TagsData.fromSchema(schema: schema.tagsData),
      measurementData: MeasurementData.fromSchema(schema: schema.measurementData),
      emotionData: EmotionData.fromSchema(schema: schema.emotionData),
      booleanData: BooleanData.fromSchema(schema: schema.booleanData),
      avatarImageData: AvatarImageData.fromSchema(schema: schema.avatarImageData),
      imageData: ImageData.fromSchema(schema: schema.imageData),
      fileData: FileData.fromSchema(schema: schema.fileData),
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Decode a ```Field``` object from JSON.
  static Field fromCloudObject(document) {
    return Field(
      fieldId: document['field_id'],
      fieldType: document['field_type'],
      canChangeParameters: document['can_change_parameters'],
      textData: document['text_data'] != null ? TextData.fromCloudObject(document['text_data']) : null,
      passwordData: document['password_data'] != null ? PasswordData.fromCloudObject(document['password_data']) : null,
      phoneData: document['phone_data'] != null ? PhoneData.fromCloudObject(document['phone_data']) : null,
      dateData: document['date_data'] != null ? DateData.fromCloudObject(document['date_data']) : null,
      timeData: document['time_data'] != null ? TimeData.fromCloudObject(document['time_data']) : null,
      numberData: document['number_data'] != null ? NumberData.fromCloudObject(document['number_data']) : null,
      moneyData: document['money_data'] != null ? MoneyData.fromCloudObject(document['money_data']) : null,
      emailData: document['email_data'] != null ? EmailData.fromCloudObject(document['email_data']) : null,
      websiteData: document['website_data'] != null ? WebsiteData.fromCloudObject(document['website_data']) : null,
      usernameData: document['username_data'] != null ? UsernameData.fromCloudObject(document['username_data']) : null,
      dateAndTimeData: document['date_and_time_data'] != null ? DateAndTimeData.fromCloudObject(document['date_and_time_data']) : null,
      locationData: document['location_data'] != null ? LocationData.fromCloudObject(document['location_data']) : null,
      paymentData: document['payment_data'] != null ? PaymentData.fromCloudObject(document['payment_data']) : null,
      dateOfBirthData: document['date_of_birth_data'] != null ? DateOfBirthData.fromCloudObject(document['date_of_birth_data']) : null,
      tagsData: document['tags_data'] != null ? TagsData.fromCloudObject(document['tags_data']) : null,
      measurementData: document['measurement_data'] != null ? MeasurementData.fromCloudObject(document['measurement_data']) : null,
      emotionData: document['emotion_data'] != null ? EmotionData.fromCloudObject(document['emotion_data']) : null,
      booleanData: document['boolean_data'] != null ? BooleanData.fromCloudObject(document['boolean_data']) : null,
      // ! Currently fields of type ImageData, FileData and AvatarImageData is only supported locally.
      avatarImageData: null,
      imageData: null,
      fileData: null,
    );
  }

  /// Encode a ```Field``` object to a JSON object suitable for cloud storage.
  Map<String, dynamic> toCloudObject({required bool isDefault, required isImport}) {
    // ! Currently fields of type ImageData, FileData and AvatarImageData is only supported locally.

    // Convenience variables.
    final bool hasTextData = TextData.includeField(textData: textData, isDefault: isDefault, isImport: isImport);
    final bool hasPasswordData = PasswordData.includeField(passwordData: passwordData, isDefault: isDefault, isImport: isImport);
    final bool hasPhoneData = PhoneData.includeField(phoneData: phoneData, isDefault: isDefault, isImport: isImport);
    final bool hasDateData = DateData.includeField(dateData: dateData, isDefault: isDefault, isImport: isImport);
    final bool hasTimeData = TimeData.includeField(timeData: timeData, isDefault: isDefault, isImport: isImport);
    final bool hasNumberData = NumberData.includeField(numberData: numberData, isDefault: isDefault, isImport: isImport);
    final bool hasEmailData = EmailData.includeField(emailData: emailData, isDefault: isDefault, isImport: isImport);
    final bool hasWebsiteData = WebsiteData.includeField(websiteData: websiteData, isDefault: isDefault, isImport: isImport);
    final bool hasUsernameData = UsernameData.includeField(usernameData: usernameData, isDefault: isDefault, isImport: isImport);
    final bool hasDateAndTimeData = DateAndTimeData.includeField(dateAndTimeData: dateAndTimeData, isDefault: isDefault, isImport: isImport);
    final bool hasLocationData = LocationData.includeField(locationData: locationData, isDefault: isDefault, isImport: isImport);
    final bool hasMoneyData = MoneyData.includeField(moneyData: moneyData, isDefault: isDefault, isImport: isImport);
    final bool hasPaymentData = PaymentData.includeField(paymentData: paymentData, isDefault: isDefault, isImport: isImport);
    final bool hasDateOfBirthData = DateOfBirthData.includeField(dateOfBirthData: dateOfBirthData, isDefault: isDefault, isImport: isImport);
    final bool hasTagsData = TagsData.includeField(tagsData: tagsData, isDefault: isDefault, isImport: isImport);
    final bool hasMeasurementData = MeasurementData.includeField(measurementData: measurementData, isDefault: isDefault, isImport: isImport);
    final bool hasBooleanData = BooleanData.includeField(booleanData: booleanData, isDefault: isDefault, isImport: isImport);
    final bool hasEmotionData = EmotionData.includeField(emotionData: emotionData, isDefault: isDefault, isImport: isImport);

    return {
      'field_id': fieldId,
      'field_type': fieldType,
      'can_change_parameters': canChangeParameters,
      if (hasTextData) 'text_data': textData!.toCloudObject(),
      if (hasPasswordData) 'password_data': passwordData!.toCloudObject(),
      if (hasPhoneData) 'phone_data': phoneData!.toCloudObject(),
      if (hasDateData) 'date_data': dateData!.toCloudObject(),
      if (hasTimeData) 'time_data': timeData!.toCloudObject(),
      if (hasNumberData) 'number_data': numberData!.toCloudObject(),
      if (hasEmailData) 'email_data': emailData!.toCloudObject(),
      if (hasWebsiteData) 'website_data': websiteData!.toCloudObject(),
      if (hasUsernameData) 'username_data': usernameData!.toCloudObject(),
      if (hasDateAndTimeData) 'date_and_time_data': dateAndTimeData!.toCloudObject(),
      if (hasLocationData) 'location_data': locationData!.toCloudObject(),
      if (hasMoneyData) 'money_data': moneyData!.toCloudObject(),
      if (hasPaymentData) 'payment_data': paymentData!.toCloudObject(),
      if (hasDateOfBirthData) 'date_of_birth_data': dateOfBirthData!.toCloudObject(),
      if (hasTagsData) 'tags_data': tagsData!.toCloudObject(),
      if (hasMeasurementData) 'measurement_data': measurementData!.toCloudObject(),
      if (hasEmotionData) 'emotion_data': emotionData!.toCloudObject(),
      if (hasBooleanData) 'boolean_data': booleanData!.toCloudObject(),
    };
  }

  // ######################################
  // CopyWith
  // ######################################

  Field copyWith({
    String? fieldId,
    String? fieldType,
    bool? canChangeParameters,
    DateData? dateData,
    NumberData? numberData,
    MoneyData? moneyData,
    PasswordData? passwordData,
    PhoneData? phoneData,
    TextData? textData,
    TimeData? timeData,
    EmailData? emailData,
    WebsiteData? websiteData,
    UsernameData? usernameData,
    DateAndTimeData? dateAndTimeData,
    LocationData? locationData,
    ImageData? imageData,
    FileData? fileData,
    PaymentData? paymentData,
    DateOfBirthData? dateOfBirthData,
    TagsData? tagsData,
    MeasurementData? measurementData,
    EmotionData? emotionData,
    AvatarImageData? avatarImageData,
    BooleanData? booleanData,
  }) {
    return Field(
      fieldId: fieldId ?? this.fieldId,
      fieldType: fieldType ?? this.fieldType,
      canChangeParameters: canChangeParameters ?? this.canChangeParameters,
      dateData: dateData ?? this.dateData,
      numberData: numberData ?? this.numberData,
      moneyData: moneyData ?? this.moneyData,
      passwordData: passwordData ?? this.passwordData,
      phoneData: phoneData ?? this.phoneData,
      textData: textData ?? this.textData,
      timeData: timeData ?? this.timeData,
      emailData: emailData ?? this.emailData,
      websiteData: websiteData ?? this.websiteData,
      usernameData: usernameData ?? this.usernameData,
      dateAndTimeData: dateAndTimeData ?? this.dateAndTimeData,
      locationData: locationData ?? this.locationData,
      imageData: imageData ?? this.imageData,
      fileData: fileData ?? this.fileData,
      paymentData: paymentData ?? this.paymentData,
      dateOfBirthData: dateOfBirthData ?? this.dateOfBirthData,
      tagsData: tagsData ?? this.tagsData,
      measurementData: measurementData ?? this.measurementData,
      emotionData: emotionData ?? this.emotionData,
      avatarImageData: avatarImageData ?? this.avatarImageData,
      booleanData: booleanData ?? this.booleanData,
    );
  }
}
