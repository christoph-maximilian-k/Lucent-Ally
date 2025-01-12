import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Labels.
import '/main.dart';

// Schemas.
import '/data/models/fields/schemas/db_field.dart';
import '/data/models/fields/schemas/db_fields.dart';

// Models.
import 'field.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/files/file_item.dart';
import '/data/models/failure.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/date_and_time_data/date_and_time_data.dart';
import '/data/models/field_types/date_data/date_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/password_data/password_data.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/phone_data/phone_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/field_types/text_data/text_data.dart';
import '/data/models/field_types/time_data/time_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/field_types/website_data/website_data.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/image_data/image_data.dart';
import '/data/models/field_types/file_data/file_data.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/local_notification_sheet/cubit/local_notification_cubit.dart';
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';

class Fields extends Equatable {
  final List<Field> items;

  const Fields({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```Fields``` object.
  factory Fields.initial() {
    return const Fields(
      items: [],
    );
  }

  /// This getter can be used to indicate if fields contains a expense data field.
  bool get containsExpenseData {
    for (final Field field in items) {
      if (field.getIsPaymentField) return true;
    }

    return false;
  }

  /// This getter can be used to check if a AvatarImage field exists.
  bool get getContainsAvatarImageField {
    for (final Field field in items) {
      if (field.getIsAvatarImageField) return true;
    }

    return false;
  }

  /// This method can be used to access a field by its id.
  /// * Returns ```null``` if fieldId was not found.
  Field? getById({required String fieldId}) {
    for (final Field field in items) {
      if (field.fieldId == fieldId) return field;
    }

    return null;
  }

  /// Retrieves the `fieldId` of a specified `FileItem`.
  /// * Returns `null` if `fileItem` id is not found.
  String? getFieldIdOfFile({required FileItem fileItem}) {
    // Loop through all fields in the `items` collection.
    for (final Field field in items) {
      // Check if the field type is for an avatar image and contains avatar image data.
      if (field.getIsAvatarImageField) {
        // Ensure that image is available.
        if (field.avatarImageData == null) continue;

        // Return the fieldId if the `image.id` matches the avatar image id.
        if (field.avatarImageData!.image?.id == fileItem.id) return field.fieldId;
      }

      // Check if the field type is for images and contains image data.
      if (field.getIsImagesField) {
        // Ensure that images are available.
        if (field.imageData == null) continue;

        // Search through each `FileItem` in the images list.
        for (final FileItem item in field.imageData!.images.items) {
          // Return the fieldId if a matching `image.id` is found.
          if (item.id == fileItem.id) return field.fieldId;
        }
      }

      // Check if the field type is for files and contains files data.
      if (field.getIsFilesField) {
        // Ensure that files are available.
        if (field.fileData == null) continue;

        // Search through each `FileItem` in the images list.
        for (final FileItem item in field.fileData!.files.items) {
          // Return the fieldId if a matching `image.id` is found.
          if (item.id == fileItem.id) return field.fieldId;
        }
      }
    }

    // Return null if the specified `fileItem.id` is not found in any `Field`.
    return null;
  }

  /// This method can be used to set notifications to desired fields.
  /// * This methods catches errors internally to prevent errors from interrupting processes.
  Future<void> setAutoNotifications({required LocalNotificationCubit localNotificationsCubit, required EntrySelectedSheetCubit? entrySelectedSheetCubit, required String groupId, required String entryId, required String entryName}) async {
    for (final Field field in items) {
      try {
        // Ignore other field types.
        if (field.fieldType != Field.fieldTypeDateOfBirth) continue;

        // Access field.
        final DateOfBirthData dateOfBirthData = field.dateOfBirthData!;

        // Make sure value was set.
        if (dateOfBirthData.value == null) continue;

        // Only set notification if user chose to.
        if (dateOfBirthData.autoNotification == false) continue;

        // Make sure that plugin is not null.
        if (localNotificationsCubit.state.notificationsPlugin == null) {
          // Output debug message.
          debugPrint('Fields --> setNotifications --> _localNotificationsCubit.state.notificationsPlugin == null');

          // Stop loop.
          break;
        }

        // Get a unique notification id.
        final int notificationId = UniqueKey().hashCode;

        // Is notification Id really unique?
        // * I dont trust this shit...
        final bool isUnique = localNotificationsCubit.state.getNotificationIdIsUnique(
          notificationId: notificationId,
        );

        // Notification Id is not unique.
        if (isUnique == false) {
          // Output debug message.
          debugPrint('Fields --> setNotifications() --> isUnique == false');

          // Keep going with next items because they might work.
          continue;
        }

        // Create now.
        final DateTime now = DateTime.now();

        // Create a DateTime for the next occurrence of the birthday in the current year.
        DateTime nextBirthday = DateTime(now.year, dateOfBirthData.value!.month, dateOfBirthData.value!.day);

        // If the next birthday is in the past, use the next year.
        if (nextBirthday.isBefore(now)) {
          nextBirthday = DateTime(now.year + 1, dateOfBirthData.value!.month, dateOfBirthData.value!.day, 13);
        }

        // Create the notification.
        await localNotificationsCubit.createNotification(
          entryId: entryId,
          fieldId: field.fieldId,
          groupId: groupId,
          isAutoGenerated: true,
          firstScheduledAtInLocal: nextBirthday,
          repeatId: LocalNotificationState.repeatEveryYear,
          channelId: LocalNotificationState.channelIdReminders,
          channelName: LocalNotificationState.channelIdReminders,
          notificationId: notificationId,
          notificationTitle: dateOfBirthData.notificationTitle.isNotEmpty
              ? dateOfBirthData.notificationTitle
              : labels.dateOfBirthNotificationTitle(
                  entryName: entryName,
                ),
          // ! Why is this empty? The problem is that this is static. Meaning that if it is set to
          // ! for example dateOfBirthData.getAgeAsLabel the same age will always be shown regardless
          // ! of how many birthdays have already passed.
          notificationMessage: '',
          notificationDateTimeInLocal: nextBirthday,
          dateTimeComponents: DateTimeComponents.dateAndTime,
          notificationsPlugin: localNotificationsCubit.state.notificationsPlugin!,
        );
      } catch (exception) {
        // Output debug message.
        debugPrint("Fields --> setNotifications() --> exception: $exception");
      }
    }

    // Creation success, notify parent cubits.
    // * Only do this if entrySelectedSheetCubit is available and a notification was set.
    if (entrySelectedSheetCubit != null) {
      await entrySelectedSheetCubit.reloadLocalNotifications();
    }
  }

  /// This helper method updates a specified field in [items].
  Fields updateField({required Field updatedField}) {
    // Init helper list.
    List<Field> fields = [];

    // Go through items and add relevant data.
    for (final Field item in items) {
      // * insert specified field.
      if (item.fieldId == updatedField.fieldId) {
        fields.add(updatedField);
        continue;
      }

      fields.add(item);
    }

    return Fields(
      items: fields,
    );
  }

  /// This method can be used to remove a ```Field``` object from ```items```.
  Fields remove({required String fieldId}) {
    // Init helper.
    List<Field> helper = [];

    // Go through items and add relevant data.
    for (final Field item in items) {
      // * Exclude specified item.
      if (item.fieldId == fieldId) continue;

      helper.add(item);
    }

    return Fields(
      items: helper,
    );
  }

  // ######################################
  // Sanitation.
  // ######################################

  /// This method can be used to sanitize `Fields` of an `Entry`.
  /// * This method ensures that only fields with valid data are in database.
  Fields sanitizeFields({required bool isDefault, required isImport}) {
    // Init helper variable.
    final List<Field> stateFields = [];

    // Delete empty fields.
    for (final Field item in items) {
      // Check if field should be excluded.
      final bool exclude = item.getExcludeField(isDefault: isDefault, isImport: isImport);

      // * Exclude field.
      if (exclude) continue;

      // * PasswordData.
      if (item.getIsPasswordField) {
        // If obscure was set to false, revert.
        if (item.passwordData!.obscure == false) {
          // * Create updated field.
          final Field updated = item.copyWith(
            passwordData: item.passwordData!.copyWith(obscure: true),
          );

          // * Add to state.
          stateFields.add(updated);

          continue;
        }
      }

      // * NumberData.
      if (item.getIsNumberField) {
        // Set number data to default number format.
        final String converted = NumberData.convertToDefaultNumberFormat(value: item.numberData!.value);

        // * Create updated field.
        final Field updated = item.copyWith(
          numberData: item.numberData!.copyWith(value: converted),
        );

        // * Add to state.
        stateFields.add(updated);

        continue;
      }

      // * LocationField.
      if (item.getIsLocationField) {
        // Set number data to default number format.
        final String convertedLat = NumberData.convertToDefaultNumberFormat(value: item.locationData!.latitude);
        final String convertedLng = NumberData.convertToDefaultNumberFormat(value: item.locationData!.longitude);

        // Updaded location Data.
        final LocationData updatedLocationData = item.locationData!.copyWith(
          latitude: convertedLat,
          longitude: convertedLng,
        );

        // * Create updated field.
        final Field updated = item.copyWith(
          locationData: updatedLocationData,
        );

        // * Add to state.
        stateFields.add(updated);

        continue;
      }

      // * MoneyField.
      if (item.getIsMoneyField) {
        // Set number data to default number format.
        final String converted = NumberData.convertToDefaultNumberFormat(value: item.moneyData!.value);

        // * Create updated field.
        final Field updated = item.copyWith(
          moneyData: item.moneyData!.copyWith(value: converted),
        );

        // * Add to state.
        stateFields.add(updated);

        continue;
      }

      // * PaymentField.
      if (item.getIsPaymentField) {
        // Set number data to default number format.
        final String converted = NumberData.convertToDefaultNumberFormat(value: item.paymentData!.total);

        // * Create updated field.
        final Field updated = item.copyWith(
          paymentData: item.paymentData!.copyWith(total: converted),
        );

        // * Add to state.
        stateFields.add(updated);

        continue;
      }

      // * MeasurementField.
      if (item.getIsMeasurementField) {
        // Set number data to default number format.
        final String converted = NumberData.convertToDefaultNumberFormat(value: item.measurementData!.value);

        // * Create updated field.
        final Field updated = item.copyWith(
          measurementData: item.measurementData!.copyWith(value: converted),
        );

        // * Add to state.
        stateFields.add(updated);

        continue;
      }

      // Field has value, add to list.
      stateFields.add(item);
    }

    return Fields(
      items: stateFields,
    );
  }

  // ######################################
  // Validation.
  // ######################################

  /// This method can be used to validate input of fields.
  /// * Should be used in a try catch block.
  Future<void> validateFields({required FieldIdentifications fieldIdentifications, required bool isDefault, required bool isImport}) async {
    // Make sure number fields are set with numbers.
    for (final Field field in items) {
      // Access corresponding FieldIdentification.
      final FieldIdentification fieldIdentification = fieldIdentifications.getById(fieldId: field.fieldId)!;
      final String fieldName = fieldIdentification.label;

      // * Validate TextField.
      if (field.getIsTextField) {
        // Helper var.
        final bool isIncluded = TextData.includeField(textData: field.textData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate BooleanField.
      if (field.getIsBooleanField) {
        // Helper var.
        final bool isIncluded = BooleanData.includeField(booleanData: field.booleanData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate PasswordField.
      if (field.getIsPasswordField) {
        // Helper var.
        final bool isIncluded = PasswordData.includeField(passwordData: field.passwordData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate PhoneField.
      if (field.getIsPhoneField) {
        // Helper var.
        final bool isIncluded = PhoneData.includeField(phoneData: field.phoneData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate DateField.
      if (field.getIsDateField) {
        // Helper var.
        final bool isIncluded = DateData.includeField(dateData: field.dateData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate DateAndTimeField.
      if (field.getIsDateAndTimeField) {
        // Helper var.
        final bool isIncluded = DateAndTimeData.includeField(dateAndTimeData: field.dateAndTimeData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate DateOfBirthData.
      if (field.getIsDateOfBirthField) {
        // Helper var.
        final bool isIncluded = DateOfBirthData.includeField(dateOfBirthData: field.dateOfBirthData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate TimeField.
      if (field.getIsTimeField) {
        // Helper var.
        final bool isIncluded = TimeData.includeField(timeData: field.timeData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate EmailField.
      if (field.getIsEmailField) {
        // Helper var.
        final bool isIncluded = EmailData.includeField(emailData: field.emailData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate WebsiteField.
      if (field.getIsWebsiteField) {
        // Helper var.
        final bool isIncluded = WebsiteData.includeField(websiteData: field.websiteData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate UsernameField.
      if (field.getIsUsernameField) {
        // Helper var.
        final bool isIncluded = UsernameData.includeField(usernameData: field.usernameData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate TagsField.
      if (field.getIsTagsField) {
        // Helper var.
        final bool isIncluded = TagsData.includeField(tagsData: field.tagsData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate EmotionField.
      if (field.getIsEmotionField) {
        // Helper var.
        final bool isIncluded = EmotionData.includeField(emotionData: field.emotionData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate AvatarImageField.
      if (field.getIsAvatarImageField) {
        // Helper var.
        final bool isIncluded = AvatarImageData.includeField(avatarImageData: field.avatarImageData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate ImageField.
      if (field.getIsImagesField) {
        // Helper var.
        final bool isIncluded = ImageData.includeField(imageData: field.imageData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate FilesField.
      if (field.getIsFilesField) {
        // Helper var.
        final bool isIncluded = FileData.includeField(fileData: field.fileData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        continue;
      }

      // * Validate number fields.
      if (field.getIsNumberField) {
        // Helper var.
        final bool isIncluded = NumberData.includeField(numberData: field.numberData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        // * This is a default creation or a import template check for field validity less rigorus.
        if (isDefault || isImport) {
          // Only check for valid number if a value was supplied.
          if (field.numberData!.value.trim().isNotEmpty) {
            // Make sure value is a valid number.
            final bool isValidNumber = NumberData.numberValidator(input: field.numberData!.value);

            // Invlid number, raise error.
            if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: fieldName);

            // Ensure that value is not to big.
            final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.numberData!.value);

            // Raise error.
            if (tooManyChars) throw Failure.numberHasTooManyCharacters();
          }

          continue;
        }

        // Make sure value is a valid number.
        final bool isValidNumber = NumberData.numberValidator(input: field.numberData!.value);

        // Invlid number, raise error.
        if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: fieldName);

        // Ensure that value is not to big.
        final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.numberData!.value);

        // Raise error.
        if (tooManyChars) throw Failure.numberHasTooManyCharacters();

        continue;
      }

      // * Validate money fields.
      if (field.getIsMoneyField) {
        // Helper var.
        final bool isIncluded = MoneyData.includeField(moneyData: field.moneyData, isDefault: isDefault, isImport: isImport);

        // Field does not have a value set.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        // * Make sure that tags are set if they are required.
        if (fieldIdentification.required && field.moneyData!.tagsData.tagReferences.isEmpty) {
          throw Failure.tagsRequired(fieldName: fieldName);
        }

        // Convenience variables.
        final bool hasDate = field.moneyData!.createdAtInUtc != null;

        // * This is a default creation or a import template check for field validity less rigorus.
        if (isDefault || isImport) {
          // Only check for valid number if a value was supplied.
          if (field.moneyData!.value.trim().isNotEmpty) {
            // Make sure value is a valid number.
            final bool isValidNumber = NumberData.numberValidator(input: field.moneyData!.value);

            // Invlid number, raise error.
            if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: fieldName);

            // Ensure that value is not to big.
            final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.moneyData!.value);

            // Raise error.
            if (tooManyChars) throw Failure.numberHasTooManyCharacters();
          }

          continue;
        }

        // Make sure a currency was selected.
        if (field.moneyData!.currencyCode.isEmpty) throw Failure.moneyFieldCurrencyRequired(fieldName: fieldName);

        // Make sure value is a valid number.
        final bool isValidNumber = NumberData.numberValidator(input: field.moneyData!.value);

        // Invlid number, raise error.
        if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: fieldName);

        // Ensure that value is not to big.
        final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.moneyData!.value);

        // Raise error.
        if (tooManyChars) throw Failure.numberHasTooManyCharacters();

        // Ensure a date is set.
        if (hasDate == false) throw Failure.moneyDateIsRequired(fieldName: fieldName);

        continue;
      }

      // * Validate measurement fields.
      if (field.getIsMeasurementField) {
        // Helper vars.
        final bool isIncluded = MeasurementData.includeField(measurementData: field.measurementData, isDefault: isDefault, isImport: isImport);

        // Field will not be included.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        // Helper vars.
        final bool hasCategory = field.measurementData!.category.isNotEmpty;
        final bool hasUnit = field.measurementData!.unit.isNotEmpty;
        final bool hasDate = field.measurementData!.createdAtInUtc != null;

        // * This is a default creation or a import templace check for field validity less rigorus.
        if (isDefault || isImport) {
          // Only check for valid number if a value was supplied.
          if (field.measurementData!.value.trim().isNotEmpty) {
            // Make sure value is a valid number.
            final bool isValidNumber = NumberData.numberValidator(input: field.measurementData!.value);

            // Invlid number, raise error.
            if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: fieldName);

            // Ensure that value is not to big.
            final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.measurementData!.value);

            // Raise error.
            if (tooManyChars) throw Failure.numberHasTooManyCharacters();
          }

          continue;
        }

        // * Let user know that a category was picked but not a unit.
        if (hasCategory && hasUnit == false) throw Failure.measurementUnitIsRequired(fieldName: fieldName);

        // Make sure value is a valid number.
        final bool isValidNumber = NumberData.numberValidator(input: field.measurementData!.value);

        // Invlid number, raise error.
        if (isValidNumber == false) throw Failure.invalidNumberInput(fieldName: fieldName);

        // Ensure that value is not to big.
        final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.measurementData!.value);

        // Raise error.
        if (tooManyChars) throw Failure.numberHasTooManyCharacters();

        // Ensure a date is set.
        if (hasDate == false) throw Failure.measurementDateIsRequired(fieldName: fieldName);

        continue;
      }

      // * Validate location fields.
      if (field.getIsLocationField) {
        // Helper var.
        final bool isIncluded = LocationData.includeField(locationData: field.locationData, isDefault: isDefault, isImport: isImport);

        // Field will not be included.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        // * Make sure that tags are set if they are required.
        if (fieldIdentification.required && field.locationData!.tagsData.tagReferences.isEmpty) {
          throw Failure.tagsRequired(fieldName: fieldName);
        }

        // * This is a default creation or a import template check for field validity less rigorus.
        if (isDefault || isImport) {
          // Only check for valid number if a value was supplied.
          if (field.locationData!.longitude.trim().isNotEmpty) {
            // Make sure value is a valid number.
            final bool isValidLng = NumberData.numberValidator(input: field.locationData!.longitude);

            // Invlid number, raise error.
            if (isValidLng == false) throw Failure.invalidNumberInput(fieldName: fieldName);

            // Ensure that value is not to big.
            final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.locationData!.longitude);

            // Raise error.
            if (tooManyChars) throw Failure.numberHasTooManyCharacters();
          }

          // Only check for valid number if a value was supplied.
          if (field.locationData!.latitude.trim().isNotEmpty) {
            // Make sure value is a valid number.
            final bool isValidLng = NumberData.numberValidator(input: field.locationData!.latitude);

            // Invlid number, raise error.
            if (isValidLng == false) throw Failure.invalidNumberInput(fieldName: fieldName);

            // Ensure that value is not to big.
            final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.locationData!.latitude);

            // Raise error.
            if (tooManyChars) throw Failure.numberHasTooManyCharacters();
          }

          continue;
        }

        // Make sure value is a valid number.
        final bool isValidLng = NumberData.numberValidator(input: field.locationData!.longitude);
        final bool isValidLat = NumberData.numberValidator(input: field.locationData!.latitude);

        // Invlid number, raise error.
        if (isValidLng == false || isValidLat == false) throw Failure.invalidNumberInput(fieldName: fieldName);

        // Ensure that value is not to big.
        final bool tooManyCharsLat = NumberData.tooManyNumberCharacters(input: field.locationData!.longitude);
        final bool tooManyCharsLng = NumberData.tooManyNumberCharacters(input: field.locationData!.latitude);

        // Raise error.
        if (tooManyCharsLat || tooManyCharsLng) throw Failure.numberHasTooManyCharacters();

        continue;
      }

      // * Validate payment field.
      if (field.getIsPaymentField) {
        // Helper var.
        final bool isIncluded = PaymentData.includeField(paymentData: field.paymentData, isDefault: isDefault, isImport: isImport);

        // Field will not be included.
        if (isIncluded == false) {
          // * Field is required.
          if (fieldIdentification.required) throw Failure.requiredValueMissing(fieldName: fieldName);

          // Continue with next field because user wants this field to be empty.
          continue;
        }

        // * This is a default creation or a import template check for field validity less rigorus.
        if (isDefault || isImport) {
          // Only check for valid number if a value was supplied.
          if (field.paymentData!.total.trim().isNotEmpty) {
            // Make sure value is a valid number.
            final bool isValidNumber = NumberData.numberValidator(input: field.paymentData!.total);

            // Invlid number, raise error.
            if (isValidNumber == false) throw Failure.paymentInvalidNumber(fieldName: fieldName);

            // Ensure that value is not to big.
            final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.paymentData!.total);

            // Raise error.
            if (tooManyChars) throw Failure.numberHasTooManyCharacters();
          }

          continue;
        }

        // Make sure value is a valid number.
        final bool isValidNumber = NumberData.numberValidator(input: field.paymentData!.total);

        // Invalid number, raise error.
        if (isValidNumber == false) throw Failure.paymentInvalidNumber(fieldName: fieldName);

        // Ensure that value is not to big.
        final bool tooManyChars = NumberData.tooManyNumberCharacters(input: field.paymentData!.total);

        // Raise error.
        if (tooManyChars) throw Failure.numberHasTooManyCharacters();

        // * Validate values, throw failures on error.
        field.paymentData!.validatePaymentData(
          fieldName: fieldName,
          tagsRequired: fieldIdentification.required,
        );

        continue;
      }
    }
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```Fields``` object to a ```DbFields``` object.
  DbFields toSchema({required bool isDefault, required bool isImport}) {
    // Init helper.
    List<DbField> helper = [];

    for (final Field field in items) {
      // Convert field to schema.
      final DbField dbField = field.toSchema(isDefault: isDefault, isImport: isImport);

      // Add to helper.
      helper.add(dbField);
    }

    return DbFields(items: helper);
  }

  /// Convert a ```DbFields``` object to a ```Fields``` object.
  static Fields fromSchema({required DbFields schema}) {
    // Init helper.
    List<Field> helper = [];

    for (final DbField dbField in schema.items!) {
      // Convert DbField to Field.
      final Field field = Field.fromSchema(schema: dbField);

      // Add to helper.
      helper.add(field);
    }

    return Fields(
      items: helper,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```Fields``` object to JSON suitable fro cloud storage.
  List<Map<String, dynamic>> toCloudObject({required bool isDefault, required bool isImport}) {
    // Init json list.
    List<Map<String, dynamic>> jsonList = [];

    // Populate jsonList with data.
    for (final Field field in items) {
      jsonList.add(field.toCloudObject(isDefault: isDefault, isImport: isImport));
    }

    return jsonList;
  }

  /// Decode a ```Fields``` object from JSON.
  static Fields fromCloudObject(document) {
    // Initialize Fields object.
    List<Field> fields = [];

    // Go through list and add converted json to list.
    for (final Map<String, dynamic> field in document) {
      fields.add(Field.fromCloudObject(field));
    }

    return Fields(
      items: fields,
    );
  }

  Fields copyWith({
    List<Field>? items,
  }) {
    return Fields(
      items: items ?? this.items,
    );
  }
}
