import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// Config.
import '/config/country_specification.dart';

// Labels.
import '/main.dart';

// Schemas.
import '/data/models/model_entries/schemas/db_model_entry.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';

// Models.
import '/data/models/entries/entry.dart';
import '/data/models/fields/field.dart';
import '/data/models/fields/fields.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/model_entry_prefs/model_entry_prefs.dart';
import '/data/models/model_entry_prefs/default_fields.dart';
import '/data/models/import_specifications/import_specifications.dart';
import '/data/models/field_types/tags_data/tags_data.dart';

class ModelEntry extends Equatable {
  final String modelEntryId;

  final bool entryCreatedAtIsEditable;

  final DateTime createdAtInUtc;
  final DateTime editedAtInUtc;

  final String modelEntryCreator;

  final String modelEntryName;

  final FieldIdentifications fieldIdentifications;

  final ModelEntryPrefs modelEntryPrefs;

  final ImportSpecifications? importSpecifications;

  const ModelEntry({
    required this.modelEntryId,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.entryCreatedAtIsEditable,
    required this.modelEntryCreator,
    required this.modelEntryName,
    required this.fieldIdentifications,
    required this.modelEntryPrefs,
    required this.importSpecifications,
  });

  @override
  List<Object?> get props => [
        modelEntryId,
        entryCreatedAtIsEditable,
        createdAtInUtc,
        editedAtInUtc,
        modelEntryCreator,
        modelEntryName,
        fieldIdentifications,
        modelEntryPrefs,
        importSpecifications,
      ];

  /// Initialize a new ```EntryModel``` object.
  factory ModelEntry.initial() {
    // Init now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    return ModelEntry(
      modelEntryId: const Uuid().v4(),
      entryCreatedAtIsEditable: true,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      modelEntryCreator: '',
      modelEntryName: '',
      fieldIdentifications: FieldIdentifications.initial(),
      modelEntryPrefs: ModelEntryPrefs.initial(),
      importSpecifications: null,
    );
  }

  // #####################################
  // Predefined models.
  // #####################################

  /// A static "Login" ```ModelEntry``` that will be available for all users on app start.
  factory ModelEntry.login() {
    // Convenience variables.
    final String modelEntryId = const Uuid().v4();
    final DateTime nowInUtc = DateTime.now().toUtc();

    // Init copy id and subtitle id.
    final String passwordId = const Uuid().v4();
    final String emailId = const Uuid().v4();

    // Init prefs.
    final ModelEntryPrefs modelEntryPrefs = ModelEntryPrefs.initial().copyWith(
      copyFieldId: passwordId,
      subtitleFieldId: emailId,
    );

    return ModelEntry(
      modelEntryId: modelEntryId,
      entryCreatedAtIsEditable: true,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      modelEntryCreator: user.userId,
      modelEntryName: labels.modelEntryLogin(),
      modelEntryPrefs: modelEntryPrefs,
      importSpecifications: null,
      fieldIdentifications: FieldIdentifications(
        items: [
          FieldIdentification(
            fieldId: emailId,
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeEmail,
            label: labels.modelEntryEmail(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeUsername,
            label: labels.modelEntryUsername(),
            required: false,
          ),
          FieldIdentification(
            fieldId: passwordId,
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypePassword,
            label: labels.modelEntryPassword(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeWebsite,
            label: labels.modelEntryWebsite(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypePhone,
            label: labels.modelEntryConnectedPhone(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeText,
            label: labels.modelEntryNotes(),
            required: false,
          ),
        ],
      ),
    );
  }

  /// A static "Person" ```ModelEntry``` that will be available for all users on app start.
  factory ModelEntry.person() {
    // Convenience variables.
    final String modelEntryId = const Uuid().v4();
    final DateTime nowInUtc = DateTime.now().toUtc();

    // Init copy id and subtitle id.
    final String birthdayId = const Uuid().v4();
    final String phoneId = const Uuid().v4();

    // Init prefs.
    final ModelEntryPrefs modelEntryPrefs = ModelEntryPrefs.initial().copyWith(
      copyFieldId: phoneId,
      subtitleFieldId: phoneId,
      thirdLineFieldId: birthdayId,
    );

    return ModelEntry(
      modelEntryId: modelEntryId,
      entryCreatedAtIsEditable: true,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      modelEntryCreator: user.userId,
      modelEntryName: labels.modelEntryPerson(),
      modelEntryPrefs: modelEntryPrefs,
      importSpecifications: null,
      fieldIdentifications: FieldIdentifications(
        items: [
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeEmail,
            label: labels.modelEntryEmail(),
            required: false,
          ),
          FieldIdentification(
            fieldId: phoneId,
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypePhone,
            label: labels.modelEntryPhone(),
            required: false,
          ),
          FieldIdentification(
            fieldId: birthdayId,
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeDateOfBirth,
            label: labels.modelEntryDateOfBirth(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.modelEntryGender(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeText,
            label: labels.modelEntryNotes(),
            required: false,
          ),
        ],
      ),
    );
  }

  /// A static "Entry" ```ModelEntry``` which includes all field identifications.
  factory ModelEntry.entry({required bool isShared}) {
    // Convenience variables.
    final String modelEntryId = const Uuid().v4();
    final DateTime nowInUtc = DateTime.now().toUtc();

    return ModelEntry(
      modelEntryId: modelEntryId,
      entryCreatedAtIsEditable: true,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      modelEntryCreator: user.userId,
      modelEntryName: labels.basicLabelsGenericEntry(isShared: isShared),
      modelEntryPrefs: ModelEntryPrefs.initial(),
      importSpecifications: null,
      fieldIdentifications: FieldIdentifications(
        items: [
          if (isShared == false)
            FieldIdentification(
              fieldId: const Uuid().v4(),
              modelEntryId: modelEntryId,
              fieldType: Field.fieldTypeAvatarImage,
              label: labels.fieldTypeAvatarImage(),
              required: false,
            ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeEmail,
            label: labels.fieldTypeEmail(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeEmotion,
            label: labels.fieldTypeEmotion(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeBoolean,
            label: labels.fieldTypeBoolean(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeMeasurement,
            label: labels.fieldTypeMeasurement(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeUsername,
            label: labels.fieldTypeUsername(),
            required: false,
          ),
          if (isShared == false)
            FieldIdentification(
              fieldId: const Uuid().v4(),
              modelEntryId: modelEntryId,
              fieldType: Field.fieldTypePassword,
              label: labels.fieldTypePassword(),
              required: false,
            ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeDateOfBirth,
            label: labels.fieldTypeDateOfBirth(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypePhone,
            label: labels.fieldTypePhone(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeWebsite,
            label: labels.fieldTypeWebsite(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeText,
            label: labels.fieldTypeText(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeNumber,
            label: labels.fieldTypeNumber(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeMoney,
            label: labels.fieldTypeMoney(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypePayment,
            label: labels.fieldTypePayment(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeDate,
            label: labels.fieldTypeDate(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTimeOfDay,
            label: labels.fieldTypeTimeOfDay(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeDateAndTime,
            label: labels.fieldTypeDateAndTime(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeLocation,
            label: labels.fieldTypeLocation(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.fieldTypeTags(),
            required: false,
          ),
          if (isShared == false)
            FieldIdentification(
              fieldId: const Uuid().v4(),
              modelEntryId: modelEntryId,
              fieldType: Field.fieldTypeImages,
              label: labels.fieldTypeImages(),
              required: false,
            ),
          if (isShared == false)
            FieldIdentification(
              fieldId: const Uuid().v4(),
              modelEntryId: modelEntryId,
              fieldType: Field.fieldTypeFiles,
              label: labels.fieldTypeFiles(),
              required: false,
            ),
        ],
      ),
    );
  }

  /// A static "Shared Expenses" ```ModelEntry``` that will be available for all users on app start.
  factory ModelEntry.sharedExpenses() {
    // Convenience variables.
    final String modelEntryId = const Uuid().v4();
    final DateTime nowInUtc = DateTime.now().toUtc();

    // Init copy id and subtitle id.
    final String paymentId = const Uuid().v4();

    // Init prefs.
    final ModelEntryPrefs modelEntryPrefs = ModelEntryPrefs.initial().copyWith(
      copyFieldId: paymentId,
      subtitleFieldId: paymentId,
    );

    return ModelEntry(
      modelEntryId: modelEntryId,
      entryCreatedAtIsEditable: true,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      modelEntryCreator: user.userId,
      modelEntryName: labels.modelEntrySharedExpense(),
      modelEntryPrefs: modelEntryPrefs,
      importSpecifications: null,
      fieldIdentifications: FieldIdentifications(
        items: [
          FieldIdentification(
            fieldId: paymentId,
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypePayment,
            label: labels.modelEntryPayment(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeImages,
            label: labels.fieldTypeImages(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeFiles,
            label: labels.fieldTypeFiles(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeText,
            label: labels.modelEntryNotes(),
            required: false,
          ),
        ],
      ),
    );
  }

  /// A static "Mood" ```ModelEntry``` that will be available for all users on app start.
  factory ModelEntry.mood() {
    // Convenience variables.
    final String modelEntryId = const Uuid().v4();
    final DateTime nowInUtc = DateTime.now().toUtc();

    return ModelEntry(
      modelEntryId: modelEntryId,
      entryCreatedAtIsEditable: true,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      modelEntryCreator: user.userId,
      modelEntryName: labels.modelEntryMood(),
      modelEntryPrefs: ModelEntryPrefs.initial(),
      importSpecifications: null,
      fieldIdentifications: FieldIdentifications(
        items: [
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeEmotion,
            label: labels.modelEntryCurrentMood(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeNumber,
            label: labels.modelEntryMoodSleepDuration(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeBoolean,
            label: labels.modelEntryMoodSleptWell(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeNumber,
            label: labels.modelEntryMoodCurrentStressLevel(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeNumber,
            label: labels.modelEntryMoodCurrentEnergyLevel(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.modelEntryMoodGoals(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.modelEntryMoodActivities(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeText,
            label: labels.modelEntryNotes(),
            required: false,
          ),
        ],
      ),
    );
  }

  /// A static "IncomeExpense" ```ModelEntry``` that will be available for all users on app start.
  factory ModelEntry.incomeExpense() {
    // Convenience variables.
    final String modelEntryId = const Uuid().v4();
    final DateTime nowInUtc = DateTime.now().toUtc();

    // Init copy id and subtitle id.
    final String moneyId = const Uuid().v4();

    // Init prefs.
    final ModelEntryPrefs modelEntryPrefs = ModelEntryPrefs.initial().copyWith(
      copyFieldId: moneyId,
      subtitleFieldId: moneyId,
    );

    return ModelEntry(
      modelEntryId: modelEntryId,
      entryCreatedAtIsEditable: true,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      modelEntryCreator: user.userId,
      modelEntryName: labels.modelEntryIncomeExpense(),
      modelEntryPrefs: modelEntryPrefs,
      importSpecifications: null,
      fieldIdentifications: FieldIdentifications(
        items: [
          FieldIdentification(
            fieldId: moneyId,
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeMoney,
            label: labels.modelEntryIncomeExpense(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.modelEntryIncomeExpenseAdditionalReference(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.modelEntryIncomeExpenseBanknameParticipant(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.modelEntryIncomeExpenseIBANParticipant(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeTags,
            label: labels.modelEntryIncomeBookingText(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeText,
            label: labels.modelEntryIncomeBookingVerwendungszweck(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeImages,
            label: labels.fieldTypeImages(),
            required: false,
          ),
          FieldIdentification(
            fieldId: const Uuid().v4(),
            modelEntryId: modelEntryId,
            fieldType: Field.fieldTypeFiles,
            label: labels.fieldTypeFiles(),
            required: false,
          ),
        ],
      ),
    );
  }

  // #####################################
  // Entry initializers.
  // #####################################

  /// Convert an [ModelEntry] object to a new [Entry] object.
  /// * This will initialize ```null``` fields and keep non ```null``` fields.
  Entry initEntryModeEntry({required bool isShared, required Entry? existingEntry, required String? entryCreator, required String currentTimezone, required String defaultCurrencyCode, required String isoCountryCode, required String participantReference}) {
    // Initialize Fields object.
    List<Field> fields = [];

    // Get indication if user is in edit mode.
    final bool isEdit = existingEntry != null;

    // Check if both defaults are set.
    // * In this case a priority over which values apply need to be found.
    // * Self default has priority except with Tags, those will be combined.
    final bool hasBothDefaults = hasDefaultSelf && hasDefaultEveryone;

    // Init entry name.
    String defaultEntryName = hasDefaultSelf ? modelEntryPrefs.defaultSelf.defaultEntryName : modelEntryPrefs.defaultEveryone.defaultEntryName;

    // Go through list and add field data depending on type.
    for (final FieldIdentification fieldIdentification in fieldIdentifications.items) {
      // Check for default field self.
      final Field? defaultFieldSelf = modelEntryPrefs.defaultSelf.fields?.getById(
        fieldId: fieldIdentification.fieldId,
      );

      // Check for default field everyone.
      final Field? defaultFieldEveryone = modelEntryPrefs.defaultEveryone.fields?.getById(
        fieldId: fieldIdentification.fieldId,
      );

      // Check for existing field.
      final Field? existingField = existingEntry?.fields.getById(
        fieldId: fieldIdentification.fieldId,
      );

      // Indicators about validity of provided fields.
      final bool excludeSelfField = defaultFieldSelf?.getExcludeField(isDefault: true, isImport: false) ?? true;
      final bool excludeEveryoneField = defaultFieldEveryone?.getExcludeField(isDefault: true, isImport: false) ?? true;

      // Check if default field for everyone should get used. This is the case if default field self is empty
      // but default field everyone has a value set.
      final bool overridePriority = excludeSelfField && excludeEveryoneField == false;

      // Init priority default field.
      final Field? defaultField = overridePriority
          ? defaultFieldEveryone
          : hasDefaultSelf || hasBothDefaults
              ? defaultFieldSelf
              : defaultFieldEveryone;

      // Indicator if a default field was used.
      final bool defaultUsed = defaultField != null;

      // Initialize field.
      Field field = Field.initial(
        fieldId: fieldIdentification.fieldId,
        fieldType: fieldIdentification.fieldType,
      );

      // * Set to default if defaults were found.
      if (defaultField != null) field = defaultField;

      // * Use existing field if it was supplied.
      // ! Is used after default field because it should overwrite defaults.
      if (existingField != null) field = existingField;

      // Set date if this is a measurement field.
      if (field.getIsMeasurementField) {
        // Parse defaultDate and defaultTime if they are present.
        final DateTime? defaultDate = HelperFunctions.parseDate(value: field.measurementData?.createdAtDefaultDate);
        final TimeOfDay? defaultTime = HelperFunctions.parseTimeOfDay(value: field.measurementData?.createdAtDefaultTime);
        final String timezone = field.measurementData!.createdAtTimezone.isEmpty ? currentTimezone : field.measurementData!.createdAtTimezone;

        // Access utc of date and timezone.
        final DateTime dateInUtc = HelperFunctions.convertDefaultsToUtc(
          defaultDate: defaultDate,
          defaultTime: defaultTime,
          timezone: timezone,
        );

        // Create updated field.
        field = field.copyWith(
          measurementData: field.measurementData!.copyWith(
            createdAtInUtc: field.measurementData!.createdAtInUtc ?? dateInUtc,
            createdAtTimezone: timezone,
          ),
        );
      }

      // Set date if this is a location field and no default was found.
      if (field.getIsLocationField) {
        // Parse defaultDate and defaultTime if they are present.
        final DateTime? defaultDate = HelperFunctions.parseDate(value: field.locationData?.defaultDate);
        final TimeOfDay? defaultTime = HelperFunctions.parseTimeOfDay(value: field.locationData?.defaultTime);
        final String timezone = field.locationData!.createdAtTimezone.isEmpty ? currentTimezone : field.locationData!.createdAtTimezone;

        // Access utc of date and timezone.
        final DateTime dateInUtc = HelperFunctions.convertDefaultsToUtc(
          defaultDate: defaultDate,
          defaultTime: defaultTime,
          timezone: timezone,
        );

        // Create updated field.
        field = field.copyWith(
          locationData: field.locationData!.copyWith(
            createdAtInUtc: field.locationData!.createdAtInUtc ?? dateInUtc,
            createdAtTimezone: timezone,
          ),
        );
      }

      // Set DateOfBirth data.
      if (field.getIsDateOfBirthField) {
        // Init variable values.
        bool showAutoNotificationChoice = false;
        bool autoNotification = false;
        String notificationTitle = '';

        // * Currently autoNotification is disabled for shared entries (This is here for code clarity).
        if (isShared) {
          showAutoNotificationChoice = false;
          autoNotification = false;
          notificationTitle = '';
        }

        // * In case this was a default field, update show auto notification.
        if (defaultUsed) {
          showAutoNotificationChoice = true;
          autoNotification = true;
          notificationTitle = '';
        }

        // * In case this is an edit do not automatically create notifications.
        if (isEdit) {
          showAutoNotificationChoice = false;
          autoNotification = false;
          notificationTitle = '';
        }

        // Create updated field.
        field = field.copyWith(
          dateOfBirthData: field.dateOfBirthData!.copyWith(
            showAutoNotificationChoice: showAutoNotificationChoice,
            autoNotification: autoNotification,
            notificationTitle: notificationTitle,
          ),
        );
      }

      // Set phone flag.
      // * Should only be conducted if this was not a default field.
      if (field.getIsPhoneField) {
        // Find specification.
        final CountrySpecification? countrySpecification = CountrySpecification.getCountrySpecificationByIsoCountryCode(
          isoCountryCode: isoCountryCode,
        );

        // Init international prefix.
        String prefix = '';

        // Default was used.
        if (defaultUsed) prefix = field.phoneData!.internationalPrefix;

        // Default was not used and a country specification was found.
        if (defaultUsed == false && countrySpecification != null) prefix = countrySpecification.internationalPhonePrefix;

        // If this was an edit, retain set value.
        if (isEdit) prefix = field.phoneData!.internationalPrefix;

        // Create updated field.
        field = field.copyWith(
          phoneData: field.phoneData!.copyWith(
            internationalPrefix: prefix,
          ),
        );
      }

      // Set defaultCurrencyCode for expense fields.
      if (field.getIsPaymentField) {
        // Get indication if group default currency should be used.
        final bool useGroupDefaultCurrency = field.paymentData!.currencyCode.isEmpty;

        // Access timezone.
        final String timezone = field.paymentData!.paymentDateTimezone.isEmpty ? currentTimezone : field.paymentData!.paymentDateTimezone;

        // Create updated field.
        field = field.copyWith(
          paymentData: field.paymentData!.copyWith(
            participantReference: participantReference,
            // * Should only be conducted if this was NOT a default field.
            currencyCode: useGroupDefaultCurrency ? defaultCurrencyCode : null,
            // * Only conduct this if a createdAt does for some reason not exist.
            paymentDateInUtc: field.paymentData!.paymentDateInUtc ?? DateTime.now().toUtc(),
            paymentDateTimezone: timezone,
          ),
        );
      }

      // Init potentially missing values.
      if (field.getIsMoneyField) {
        // Get indication if group default currency should be used.
        final bool useGroupDefaultCurrency = field.moneyData!.currencyCode.isEmpty;

        // Parse defaultDate and defaultTime if they are present.
        final DateTime? defaultDate = HelperFunctions.parseDate(value: field.moneyData?.defaultDate);
        final TimeOfDay? defaultTime = HelperFunctions.parseTimeOfDay(value: field.moneyData?.defaultTime);
        final String timezone = field.moneyData!.timezone.isEmpty ? currentTimezone : field.moneyData!.timezone;

        // Access utc of date and timezone.
        final DateTime dateInUtc = HelperFunctions.convertDefaultsToUtc(
          defaultDate: defaultDate,
          defaultTime: defaultTime,
          timezone: timezone,
        );

        // Create updated field.
        field = field.copyWith(
          moneyData: field.moneyData!.copyWith(
            // * Should only be conducted if this was NOT a default field and not a import match.
            currencyCode: useGroupDefaultCurrency ? defaultCurrencyCode : null,
            // * Only conduct this if a createdAt does for some reason not exist.
            createdAtInUtc: field.moneyData!.createdAtInUtc ?? dateInUtc,
            timezone: timezone,
          ),
        );
      }

      // Init potentially missing values.
      if (field.getIsDateField) {
        // Parse defaultDate and defaultTime if they are present.
        final DateTime? defaultDate = HelperFunctions.parseDate(value: field.dateData?.valueDefaultDate);
        final String timezone = field.dateData!.timezone.isEmpty ? currentTimezone : field.dateData!.timezone;

        // * This check is needed because user might want to NOT set a value for this field. So if no defaults
        // * are supplied, leave the field empty.
        final bool hasDefaults = defaultDate != null;

        // Access utc of date and timezone.
        // * These should not be initialized if this is an edit because user might have removed them intentially before on create entry.
        final DateTime? dateInUtc = hasDefaults == false || isEdit
            ? null
            : HelperFunctions.convertDefaultsToUtc(
                defaultDate: defaultDate,
                defaultTime: TimeOfDay(hour: 0, minute: 0), // * This field should not have any time data.
                timezone: timezone,
              );

        // Create updated field.
        field = field.copyWith(
          dateData: field.dateData!.copyWith(
            // * Only conduct this if a createdAt does for some reason not exist.
            valueInUtc: field.dateData!.valueInUtc ?? dateInUtc,
            timezone: timezone,
          ),
        );
      }

      // Init potentially missing values.
      if (field.getIsDateAndTimeField) {
        // Parse defaultDate and defaultTime if they are present.
        final DateTime? defaultDate = HelperFunctions.parseDate(value: field.dateAndTimeData?.valueDefaultDate);
        final TimeOfDay? defaultTime = HelperFunctions.parseTimeOfDay(value: field.dateAndTimeData?.valueDefaultTime);
        final String timezone = field.dateAndTimeData!.timezone.isEmpty ? currentTimezone : field.dateAndTimeData!.timezone;

        // * This check is needed because user might want to NOT set a value for this field. So if no defaults
        // * are supplied, leave the field empty.
        final bool hasDefaults = defaultDate != null || defaultTime != null;

        // Access utc of date and timezone.
        final DateTime? dateInUtc = hasDefaults == false || isEdit
            ? null
            : HelperFunctions.convertDefaultsToUtc(
                defaultDate: defaultDate,
                defaultTime: defaultTime,
                timezone: timezone,
              );

        // Create updated field.
        field = field.copyWith(
          dateAndTimeData: field.dateAndTimeData!.copyWith(
            // * Only conduct this if a createdAt does for some reason not exist.
            valueInUtc: field.dateAndTimeData!.valueInUtc ?? dateInUtc,
            timezone: timezone,
          ),
        );
      }

      // Combine Tags if needed.
      if (field.getIsTagsField) {
        // * In case this was is a edit and user intentionally removed tags on entry creation, do not set tags with defaults.
        final bool leaveTagsEmpty = isEdit && existingField == null;

        // * Tags should not be initialized.
        if (leaveTagsEmpty) {
          // Init a clean tags field.
          final Field cleanTagsField = Field.initial(
            fieldId: fieldIdentification.fieldId,
            fieldType: fieldIdentification.fieldType,
          );

          // Add field to list.
          fields.add(cleanTagsField);
          continue;
        }

        // Check if everyone has tags set.
        if (hasBothDefaults && defaultFieldEveryone != null && defaultFieldEveryone.tagsData != null) {
          // Create updated tagsData.
          final TagsData updatedTagsData = field.tagsData!.copyWith(
            tagReferences: [
              ...defaultFieldEveryone.tagsData!.tagReferences,
              ...field.tagsData!.tagReferences,
            ],
          ).removeDuplicates();

          // Create updated field.
          field = field.copyWith(
            // * In case this was is a edit, leave the tags exactly like they are.
            tagsData: isEdit ? null : updatedTagsData,
          );
        }
      }

      // Add field to list.
      fields.add(field);
    }

    // * If this is an edit, retain existing entry data.
    if (isEdit) {
      return existingEntry.copyWith(
        fields: Fields(items: fields),
      );
    }

    // Create entry.
    return Entry.initial().copyWith(
      entryName: defaultEntryName,
      modelEntryReference: modelEntryId,
      entryCreator: entryCreator,
      createdAtTimeZone: currentTimezone,
      editedAtTimeZone: currentTimezone,
      fields: Fields(items: fields),
    );
  }

  /// Convert an [ModelEntry] object to an [Entry] object suitable for set default mode.
  /// * This will initialize ```null``` fields and keep non ```null``` fields.
  Entry initDefaultModeEntry({required bool isSelfDefault, required String defaultCurrencyCode, required String participantReference}) {
    // Initi helper variable.
    final List<Field> fields = [];

    // Use specified defaults.
    final Fields? defaultFields = isSelfDefault ? modelEntryPrefs.defaultSelf.fields : modelEntryPrefs.defaultEveryone.fields;
    final String defaultEntryName = isSelfDefault ? modelEntryPrefs.defaultSelf.defaultEntryName : modelEntryPrefs.defaultEveryone.defaultEntryName;

    // Go through field identifications and init null variables.
    for (final FieldIdentification item in fieldIdentifications.items) {
      // Convenience variables.
      final String fieldType = item.fieldType;
      final String fieldId = item.fieldId;
      final Field? defaultField = defaultFields?.getById(fieldId: fieldId);

      // Initialize field if it is null.
      if (defaultField == null) {
        // Init field.
        Field field = Field.initial(
          fieldId: fieldId,
          fieldType: fieldType,
        );

        // Update payment field.
        if (field.getIsPaymentField) {
          field = field.copyWith(
            paymentData: field.paymentData!.copyWith(
              participantReference: participantReference,
              currencyCode: defaultCurrencyCode,
            ),
          );
        }

        // Set defaultCurrencyCode for money fields.
        if (field.getIsMoneyField) {
          field = field.copyWith(
            moneyData: field.moneyData!.copyWith(
              currencyCode: defaultCurrencyCode,
            ),
          );
        }

        // Add to fields.
        fields.add(field);
        continue;
      }

      // If index was found, add already initialized field.
      fields.add(defaultField);
    }

    return Entry.initial().copyWith(
      // * If both self and everyone does not have a default name set, this is an empty String.
      entryName: defaultEntryName,
      fields: Fields(items: fields),
    );
  }

  /// Convert an [ModelEntry] object to an [Entry] object using provided defaults.
  /// * This will initialize ```null``` fields and keep non ```null``` fields.
  Entry initImportMatchModeEntry({required String participantReference, required String currentTimezone}) {
    // Initi helper variable.
    final List<Field> fields = [];

    // Access now.
    final DateTime nowDate = DateTime.now();
    final String nowDateAsString = DateFormat('yyyy-MM-dd').format(nowDate);

    final TimeOfDay nowTime = TimeOfDay.now();
    final String nowTimeString = HelperFunctions.formatTimeOfDayTo24Hour(timeOfDay: nowTime);

    // Go through field identifications and init null variables.
    for (final FieldIdentification item in fieldIdentifications.items) {
      // Convenience variables.
      final String fieldType = item.fieldType;
      final String fieldId = item.fieldId;
      final Field? importMatchField = importSpecifications?.fields.getById(fieldId: fieldId);

      // Initialize field if it is null.
      if (importMatchField == null) {
        // Init field.
        Field field = Field.initial(
          fieldId: fieldId,
          fieldType: fieldType,
        );

        // Update payment field.
        if (field.getIsPaymentField) {
          // Convenience variables.
          final bool hasDateDefault = field.paymentData!.paymentDateDefaultDate != null && field.paymentData!.paymentDateDefaultDate!.isNotEmpty;
          final bool hasDateTime = field.paymentData!.paymentDateDefaultTime != null && field.paymentData!.paymentDateDefaultTime!.isNotEmpty;
          final bool hasTimezone = field.paymentData!.paymentDateTimezone.isNotEmpty;

          field = field.copyWith(
            paymentData: field.paymentData!.copyWith(
              participantReference: participantReference,
              paymentDateDefaultDate: hasDateDefault ? field.paymentData!.paymentDateDefaultDate! : nowDateAsString,
              paymentDateDefaultTime: hasDateTime ? field.paymentData!.paymentDateDefaultTime! : nowTimeString,
              paymentDateTimezone: hasTimezone ? field.paymentData!.paymentDateTimezone : currentTimezone,
            ),
          );
        }

        // Update money field.
        if (field.getIsMoneyField) {
          // Convenience variables.
          final bool hasDateDefault = field.moneyData!.defaultDate != null && field.moneyData!.defaultDate!.isNotEmpty;
          final bool hasDateTime = field.moneyData!.defaultTime != null && field.moneyData!.defaultTime!.isNotEmpty;
          final bool hasTimezone = field.moneyData!.timezone.isNotEmpty;

          field = field.copyWith(
            moneyData: field.moneyData!.copyWith(
              defaultDate: hasDateDefault ? field.moneyData!.defaultDate! : nowDateAsString,
              defaultTime: hasDateTime ? field.moneyData!.defaultTime! : nowTimeString,
              timezone: hasTimezone ? field.moneyData!.timezone : currentTimezone,
            ),
          );
        }

        // Update measurement field.
        if (field.getIsMeasurementField) {
          // Convenience variables.
          final bool hasDateDefault = field.measurementData!.createdAtDefaultDate != null && field.measurementData!.createdAtDefaultDate!.isNotEmpty;
          final bool hasDateTime = field.measurementData!.createdAtDefaultTime != null && field.measurementData!.createdAtDefaultTime!.isNotEmpty;
          final bool hasTimezone = field.measurementData!.createdAtTimezone.isNotEmpty;

          field = field.copyWith(
            measurementData: field.measurementData!.copyWith(
              createdAtDefaultDate: hasDateDefault ? field.measurementData!.createdAtDefaultDate! : nowDateAsString,
              createdAtDefaultTime: hasDateTime ? field.measurementData!.createdAtDefaultTime! : nowTimeString,
              createdAtTimezone: hasTimezone ? field.measurementData!.createdAtTimezone : currentTimezone,
            ),
          );
        }

        // Update location field.
        if (field.getIsLocationField) {
          // Convenience variables.
          final bool hasDateDefault = field.locationData!.defaultDate != null && field.locationData!.defaultDate!.isNotEmpty;
          final bool hasDateTime = field.locationData!.defaultTime != null && field.locationData!.defaultTime!.isNotEmpty;
          final bool hasTimezone = field.locationData!.createdAtTimezone.isNotEmpty;

          field = field.copyWith(
            locationData: field.locationData!.copyWith(
              defaultDate: hasDateDefault ? field.locationData!.defaultDate! : nowDateAsString,
              defaultTime: hasDateTime ? field.locationData!.defaultTime! : nowTimeString,
              createdAtTimezone: hasTimezone ? field.locationData!.createdAtTimezone : currentTimezone,
            ),
          );
        }

        // Add to fields.
        fields.add(field);
        continue;
      }

      // If index was found, add already initialized field.
      fields.add(importMatchField);
    }

    return Entry.initial().copyWith(
      entryName: importSpecifications?.entryNameDefault,
      modelEntryReference: modelEntryId,
      fields: Fields(items: fields),
    );
  }

  // #####################################
  // Getters and setters.
  // #####################################

  /// This getter can be used to get an indication about whether or not a default for everyone was set.
  bool get hasDefaultEveryone {
    // User set a default name.
    if (modelEntryPrefs.defaultEveryone.defaultEntryName.isNotEmpty) return true;

    // User set default fields.
    if (modelEntryPrefs.defaultEveryone.fields != null && modelEntryPrefs.defaultEveryone.fields!.items.isNotEmpty) return true;

    return false;
  }

  /// This getter can be used to get an indication about whether or not a default for self was set.
  bool get hasDefaultSelf {
    // User set a default name.
    if (modelEntryPrefs.defaultSelf.defaultEntryName.isNotEmpty) return true;

    // User set default fields.
    if (modelEntryPrefs.defaultSelf.fields != null && modelEntryPrefs.defaultSelf.fields!.items.isNotEmpty) return true;

    return false;
  }

  /// This method can be used to get the subtitle to display in card entry preview.
  /// * if subtitle field was deleted, default will be returned.
  String getSubtitle({required Entry entry}) {
    // Access subtitle to display.
    if (modelEntryPrefs.subtitleFieldId.isEmpty) return labels.entryModelSubtitleFieldNotSet();

    // Access index.
    final int index = entry.fields.items.indexWhere(
      (element) => element.fieldId == modelEntryPrefs.subtitleFieldId,
    );

    // * Previously set subtitle field was deleted, return default.
    if (index == -1) return labels.entryModelSubtitleFieldIsEmpty();

    // Access field.
    final Field field = entry.fields.items[index];

    // Access fieldIdentification.
    final FieldIdentification? fieldIdentification = fieldIdentifications.getById(
      fieldId: field.fieldId,
    );

    // * Error, this should never happen.
    if (fieldIdentification == null) return labels.entryModelSubtitleNotAvailable();

    // Access subtitle.
    final String? subtitle = field.getSubtitle(
      fieldLabel: fieldIdentification.label,
    );

    // * Subtitles are not available for this field.
    if (subtitle == null) return labels.entryModelSubtitleNotAvailable();

    return subtitle;
  }

  /// This method can be used to get the thirdline to display in card entry preview.
  /// * if thirdline field was deleted, default will be returned.
  String getThirdline({required Entry entry}) {
    // Access thirdline to display.
    if (modelEntryPrefs.thirdLineFieldId.isEmpty) return '';

    // Access index.
    final int index = entry.fields.items.indexWhere(
      (element) => element.fieldId == modelEntryPrefs.thirdLineFieldId,
    );

    // * Previously set thirdline field was deleted, return default.
    if (index == -1) return labels.entryModelThirdlineFieldIsEmpty();

    // Access field.
    final Field field = entry.fields.items[index];

    // Access fieldIdentification.
    final FieldIdentification? fieldIdentification = fieldIdentifications.getById(
      fieldId: field.fieldId,
    );

    // * Error, this should never happen.
    if (fieldIdentification == null) return '';

    // Access thirdline.
    final String? thirdline = field.getThirdline(
      fieldLabel: fieldIdentification.label,
    );

    // * Thirdline is not available for this field.
    if (thirdline == null) return labels.entryModelThirdlineNotAvailable();

    return thirdline;
  }

  /// Can be used to set defaults.
  Future<ModelEntryPrefs> setDefaultFields({required Entry entry, required bool isSelfDefault}) async {
    // Create helper.
    List<Field> helper = [];

    // Go through model entry FieldIdentifications and check if provided entry has a default set.
    // Otherwise set defaultField to null.
    for (final FieldIdentification element in fieldIdentifications.items) {
      // Check if field has a default set.
      final Field? field = entry.fields.getById(fieldId: element.fieldId);

      // Do not add fields which do not have default set.
      if (field == null) continue;

      // Add updated field to helper.
      helper.add(field);
    }

    // Create the default fields object.
    final DefaultFields defaultFields = DefaultFields(
      defaultEntryName: entry.entryName,
      fields: Fields(items: helper),
    );

    // Copy relevant value and return prefs.
    return modelEntryPrefs.copyWith(
      defaultSelf: isSelfDefault ? defaultFields : modelEntryPrefs.defaultSelf,
      defaultEveryone: isSelfDefault ? modelEntryPrefs.defaultEveryone : defaultFields,
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```ModelEntry``` object to a ```DbModelEntry``` object.
  DbModelEntry toSchema() {
    return DbModelEntry(
      modelEntryId: modelEntryId,
      entryCreatedAtIsEditable: entryCreatedAtIsEditable,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
      modelEntryCreator: modelEntryCreator,
      modelEntryName: modelEntryName,
      importSpecifications: importSpecifications?.toSchema(),
      fieldIdentifications: fieldIdentifications.toSchema(),
    );
  }

  /// Convert a ```DbModelEntry``` object to a ```ModelEntry``` object.
  static ModelEntry fromSchema({required DbModelEntry schema}) {
    return ModelEntry(
      modelEntryId: schema.modelEntryId,
      entryCreatedAtIsEditable: schema.entryCreatedAtIsEditable,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
      modelEntryName: schema.modelEntryName,
      modelEntryCreator: schema.modelEntryCreator,
      modelEntryPrefs: ModelEntryPrefs.initial(),
      importSpecifications: ImportSpecifications.fromSchema(schema: schema.importSpecifications),
      fieldIdentifications: FieldIdentifications.fromSchema(schema: schema.fieldIdentifications),
    );
  }

  // #####################################
  // Cloud
  // #####################################

  /// Encode an ```ModelEntry``` object to a ```JSON``` suitable for cloud storage.
  Map<String, dynamic> toCloudObject() {
    return {
      'model_entry_name': modelEntryName,
      'entry_created_at_is_editable': entryCreatedAtIsEditable,
      'model_entry_creator': modelEntryCreator,
      'field_identifications': fieldIdentifications.toDocument(),
    };
  }

  /// Decode an ```ModelEntry``` object from JSON provided by cloud service.
  static ModelEntry fromCloudObject(data) {
    return ModelEntry(
      modelEntryId: data["_id"],
      modelEntryName: data["model_entry_name"],
      entryCreatedAtIsEditable: data["entry_created_at_is_editable"],
      createdAtInUtc: DateTime.parse(data["created_at_in_utc"]),
      editedAtInUtc: DateTime.parse(data["edited_at_in_utc"]),
      modelEntryCreator: data["creator"],
      importSpecifications: null,
      fieldIdentifications: FieldIdentifications.fromDocument(
        document: data["field_identifications"],
        entryModelId: data["_id"],
      ),
      modelEntryPrefs: ModelEntryPrefs.fromCloudObject(data),
    );
  }

  // #####################################
  // Copy With
  // #####################################

  ModelEntry copyWith({
    String? modelEntryId,
    bool? entryCreatedAtIsEditable,
    DateTime? createdAtInUtc,
    DateTime? editedAtInUtc,
    String? modelEntryCreator,
    String? modelEntryName,
    FieldIdentifications? fieldIdentifications,
    ModelEntryPrefs? modelEntryPrefs,
    ImportSpecifications? importSpecifications,
  }) {
    return ModelEntry(
      modelEntryId: modelEntryId ?? this.modelEntryId,
      entryCreatedAtIsEditable: entryCreatedAtIsEditable ?? this.entryCreatedAtIsEditable,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
      modelEntryCreator: modelEntryCreator ?? this.modelEntryCreator,
      modelEntryName: modelEntryName ?? this.modelEntryName,
      fieldIdentifications: fieldIdentifications ?? this.fieldIdentifications,
      modelEntryPrefs: modelEntryPrefs ?? this.modelEntryPrefs,
      importSpecifications: importSpecifications ?? this.importSpecifications,
    );
  }
}
