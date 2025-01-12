import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucent_ally/logic/helper_functions/helper_functions.dart';
import 'package:uuid/uuid.dart';

// User with Settings and Labels.
import '/main.dart';

// Schemas.
import '/data/models/entries/schemas/db_entry.dart';

// Models.
import '/data/models/fields/field.dart';
import '/data/models/fields/fields.dart';
import '../files/files.dart';
import '/data/models/references/reference.dart';
import '/data/models/references/references.dart';
import '/data/models/failure.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/tags/tag.dart';

class Entry extends Equatable {
  final String entryId;

  /// Indicates that this entry was stored in the database in an encrypted format.
  ///
  /// This does NOT reflect the current encryption state of the entry (e.g., whether it is currently encrypted or decrypted
  /// in an ```Entries()``` object or in memory).
  ///
  /// Instead, it indicates that encryption was applied during the saving process for this entry.
  final bool isEncrypted;

  final String modelEntryReference;

  final String entryCreator;
  final String entryName;

  final DateTime createdAtInUtc;
  final String createdAtTimeZone;

  final DateTime editedAtInUtc;
  final String editedAtTimeZone;

  final Fields fields;

  const Entry({
    required this.entryId,
    required this.isEncrypted,
    required this.modelEntryReference,
    required this.entryCreator,
    required this.entryName,
    required this.createdAtInUtc,
    required this.createdAtTimeZone,
    required this.editedAtInUtc,
    required this.editedAtTimeZone,
    required this.fields,
  });

  @override
  List<Object?> get props => [
        entryId,
        isEncrypted,
        modelEntryReference,
        entryCreator,
        entryName,
        createdAtInUtc,
        createdAtTimeZone,
        editedAtInUtc,
        editedAtTimeZone,
        fields,
      ];

  /// Initialize a new ```Entry``` object.
  factory Entry.initial() {
    // Init now.
    final DateTime now = DateTime.now().toUtc();

    return Entry(
      entryId: const Uuid().v4(),
      isEncrypted: false,
      modelEntryReference: '',
      entryCreator: '',
      entryName: '',
      createdAtInUtc: now,
      createdAtTimeZone: '',
      editedAtInUtc: now,
      editedAtTimeZone: '',
      fields: Fields.initial(),
    );
  }

  /// This getter can be used to access created at in a readable format.
  String getCreatedAt({required bool preserveUtc, required bool date, required bool time}) {
    // Convert value.
    final DateTime converted = HelperFunctions.convertToTimezone(
      dateTimeInUtc: createdAtInUtc,
      timezone: createdAtTimeZone,
      preserveUtc: preserveUtc,
    );

    if (date && time) return '${DateFormat("yyyy-MM-dd").format(converted)} ${labels.basicLabelsAt()} ${DateFormat("HH:mm").format(converted)}';

    if (date) return DateFormat("yyyy-MM-dd").format(converted);

    return DateFormat("HH:mm").format(converted);
  }

  /// This getter can be used to access timezone in a readable format.
  String getCreatedAtTimezone({required bool preserveUtc}) {
    // If the value was stored in utc, use local timezone.
    if (createdAtTimeZone.isEmpty || createdAtTimeZone == "UTC") {
      // If flag was set, return UTC timezone.
      if (preserveUtc) return "UTC";

      // Try and access local timezone.
      final String? localTimezone = HelperFunctions.getCurrentTimezone();

      // It seems like local timezone could not be accessed.
      if (localTimezone == null || localTimezone.isEmpty) return "UTC";

      return localTimezone;
    }

    // Otherwise return stored timezone.
    return createdAtTimeZone;
  }

  /// This method can be used to check if a entry is tagged with a tag.
  bool isTaggedWith({required Tag tag}) {
    for (final Field field in fields.items) {
      // Only consider relevant fields.
      if (field.getIsPaymentField == false && field.getIsFilesField == false && field.getIsTagsField == false && field.getIsLocationField == false && field.getIsImagesField == false && field.getIsMoneyField == false) {
        continue;
      }

      TagsData? tagsData;

      // Set convenience variable.
      if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;

      // Set convenience variable.
      if (field.getIsMoneyField) tagsData = field.moneyData!.tagsData;

      // Set convenience variable.
      if (field.getIsLocationField) tagsData = field.locationData!.tagsData;

      // Set convenience variable.
      if (field.getIsTagsField) tagsData = field.tagsData!;

      // Set convenience variable.
      if (field.getIsImagesField) tagsData = field.imageData!.tagsData;

      // Set convenience variable.
      if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

      // Ensure null safety.
      if (tagsData == null) continue;

      // Entry is tagged with given tag.
      if (tagsData.tagReferences.contains(tag.tagId)) return true;
    }

    return false;
  }

  /// This method can be used to access all files of an [Entry].
  Files getAllFilesOfEntry({required bool onlyImages}) {
    // Init helper list.
    Files files = Files.initial();

    for (final Field field in fields.items) {
      if (field.getIsImagesField) {
        files = files.join(other: field.imageData!.images);
      }

      if (field.getIsAvatarImageField) {
        files = files.join(other: field.avatarImageData!.toFiles());
      }

      if (onlyImages == false && field.getIsFilesField) {
        files = files.join(other: field.fileData!.files);
      }
    }

    return files;
  }

  /// This method can be used to access all ```Tags``` of an ```Entry``` as ```References```.
  /// * Reference ```recordKey``` is the tag ```recordKey```
  /// * Reference ```parentReference``` is the entry ```fieldId```
  References getAllTagsAsReferences() {
    // Init helper list.
    References references = References.initial();

    for (final Field field in fields.items) {
      // * TagsField.
      if (field.getIsTagsField) {
        // * Go through tags and create references.
        for (final String recordKey in field.tagsData!.tagReferences) {
          // * Create Reference.
          final Reference reference = Reference(
            referenceId: recordKey,
            parentReference: field.fieldId,
            childReference: '',
          );

          // * Add Reference.
          references = references.add(reference: reference);
        }
      }

      // * PaymentField.
      if (field.getIsPaymentField) {
        // * Go through tags and create references.
        for (final String recordKey in field.paymentData!.tagsData.tagReferences) {
          // * Create Reference.
          final Reference reference = Reference(
            referenceId: recordKey,
            parentReference: field.fieldId,
            childReference: '',
          );

          // * Add Reference.
          references = references.add(reference: reference);
        }
      }

      // * MoneyField.
      if (field.getIsMoneyField) {
        // * Go through tags and create references.
        for (final String recordKey in field.moneyData!.tagsData.tagReferences) {
          // * Create Reference.
          final Reference reference = Reference(
            referenceId: recordKey,
            parentReference: field.fieldId,
            childReference: '',
          );

          // * Add Reference.
          references = references.add(reference: reference);
        }
      }

      // * LocationField.
      if (field.getIsLocationField) {
        // * Go through tags and create references.
        for (final String recordKey in field.locationData!.tagsData.tagReferences) {
          // * Create Reference.
          final Reference reference = Reference(
            referenceId: recordKey,
            parentReference: field.fieldId,
            childReference: '',
          );

          // * Add Reference.
          references = references.add(reference: reference);
        }
      }

      // * ImagesField.
      if (field.getIsImagesField) {
        // * Go through tags and create references.
        for (final String recordKey in field.imageData!.tagsData.tagReferences) {
          // * Create Reference.
          final Reference reference = Reference(
            referenceId: recordKey,
            parentReference: field.fieldId,
            childReference: '',
          );

          // * Add Reference.
          references = references.add(reference: reference);
        }
      }

      // * FilesField.
      if (field.getIsFilesField) {
        // * Go through tags and create references.
        for (final String recordKey in field.fileData!.tagsData.tagReferences) {
          // * Create Reference.
          final Reference reference = Reference(
            referenceId: recordKey,
            parentReference: field.fieldId,
            childReference: '',
          );

          // * Add Reference.
          references = references.add(reference: reference);
        }
      }
    }

    return references;
  }

  /// This method can be used to copy the [Images] of an [Entry] with the [Images] of another [Entry].
  Entry copyWithImages({required Entry entry}) {
    // Init entry.
    Entry updatedEntry = this;

    for (final Field field in entry.fields.items) {
      // * Images field.
      if (field.getIsImagesField) {
        // Access field.
        final Field? accessedField = updatedEntry.fields.getById(fieldId: field.fieldId);

        // Field was not found. In theory this should never happen.
        if (accessedField == null) {
          // Output debug message.
          debugPrint('Entry --> fieldTypeImages --> copyWithImages() --> fieldIndex not found.');

          continue;
        }

        // Create updated field.
        final Field updatedField = accessedField.copyWith(
          imageData: field.imageData!,
        );

        // Create updated fields.
        final Fields updatedFields = updatedEntry.fields.updateField(updatedField: updatedField);

        // Update entry.
        updatedEntry = updatedEntry.copyWith(
          fields: updatedFields,
        );
      }

      // * Avatar image field.
      if (field.getIsAvatarImageField) {
        // Access field.
        final Field? accessedField = updatedEntry.fields.getById(fieldId: field.fieldId);

        // Field was not found. In theory this should never happen.
        if (accessedField == null) {
          // Output debug message.
          debugPrint('Entry --> fieldTypeAvatarImage --> copyWithImages() --> fieldIndex not found.');

          continue;
        }

        // Create updated field.
        final Field updatedField = accessedField.copyWith(
          avatarImageData: field.avatarImageData!,
        );

        // Create updated fields.
        final Fields updatedFields = updatedEntry.fields.updateField(updatedField: updatedField);

        // Update entry.
        updatedEntry = updatedEntry.copyWith(
          fields: updatedFields,
        );
      }
    }

    return updatedEntry;
  }

  /// This method indicates if an entry differs from another entry.
  /// * uses sanitize fields on ```entry```
  bool isEqualTo({required Entry entry, required bool isDefault, required bool isImport}) {
    // * This makes initial and final entry compareable.
    final Fields otherEntryFields = entry.fields.sanitizeFields(isDefault: isDefault, isImport: isImport);

    // Create final initial entry.
    final Entry finalOtherEntry = entry.copyWith(
      fields: otherEntryFields,
    );

    if (finalOtherEntry == this) return true;

    return false;
  }

  /// This method can be used to ensure that a cloud entry does not contain fields which are not eligble for cloud storage.
  /// * Should be used in a try catch block.
  void isCloudEligible() {
    for (final Field field in fields.items) {
      if (field.getIsFilesField) throw Failure.imagesCloudStorageUnavailable();
      if (field.getIsImagesField) throw Failure.imagesCloudStorageUnavailable();
      if (field.getIsEntryField) throw Failure.entryReferenceStorageUnavailable();
      if (field.getIsAvatarImageField) throw Failure.avatarImageStorageUnavailable();
    }
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```Entry``` object to a ```DbEntry``` object.
  DbEntry toSchema() {
    return DbEntry(
      entryId: entryId,
      isEncrypted: isEncrypted,
      modelEntryReference: modelEntryReference,
      entryCreator: entryCreator,
      entryName: entryName,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      createdAtTimeZone: createdAtTimeZone,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
      editedAtTimeZone: editedAtTimeZone,
      fields: fields.toSchema(isDefault: false, isImport: false),
      // * Do not encode state variables.
    );
  }

  /// Convert a ```DbEntry``` object to a ```Entry``` object.
  static Entry fromSchema({required DbEntry schema}) {
    return Entry(
      entryId: schema.entryId,
      isEncrypted: schema.isEncrypted,
      modelEntryReference: schema.modelEntryReference,
      entryCreator: schema.entryCreator,
      entryName: schema.entryName,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      createdAtTimeZone: schema.createdAtTimeZone,
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
      editedAtTimeZone: schema.editedAtTimeZone,
      fields: Fields.fromSchema(schema: schema.fields),
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode an ```Entry``` object to JSON suitable for cloud storage.
  Map<String, dynamic> toCloudObject() {
    return {
      'model_entry_reference': modelEntryReference,
      'entry_name': entryName,
      'created_at_in_utc': createdAtInUtc.toIso8601String(),
      'created_at_timezone': createdAtTimeZone,
      'edited_at_in_utc': editedAtInUtc.toIso8601String(),
      'edited_at_timezone': editedAtTimeZone,
      'fields': fields.toCloudObject(isDefault: false, isImport: false),
    };
  }

  /// Decode an ```Entry``` object from JSON provided by cloud service.
  static Entry fromCloudObject(entry) {
    return Entry(
      entryId: entry["entry_id"],
      isEncrypted: false,
      modelEntryReference: entry["model_entry_reference"],
      entryCreator: entry["entry_creator"],
      entryName: entry["entry_name"],
      createdAtInUtc: DateTime.parse(entry["created_at_in_utc"]),
      createdAtTimeZone: entry["created_at_timezone"],
      editedAtInUtc: DateTime.parse(entry["edited_at_in_utc"]),
      editedAtTimeZone: entry["edited_at_timezone"],
      fields: Fields.fromCloudObject(entry["fields"]),
    );
  }

  // ######################################
  // CopyWith
  // ######################################

  Entry copyWith({
    String? entryId,
    bool? isEncrypted,
    String? modelEntryReference,
    String? entryCreator,
    String? entryName,
    DateTime? createdAtInUtc,
    String? createdAtTimeZone,
    DateTime? editedAtInUtc,
    String? editedAtTimeZone,
    Fields? fields,
  }) {
    return Entry(
      entryId: entryId ?? this.entryId,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      modelEntryReference: modelEntryReference ?? this.modelEntryReference,
      entryCreator: entryCreator ?? this.entryCreator,
      entryName: entryName ?? this.entryName,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      createdAtTimeZone: createdAtTimeZone ?? this.createdAtTimeZone,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
      editedAtTimeZone: editedAtTimeZone ?? this.editedAtTimeZone,
      fields: fields ?? this.fields,
    );
  }
}
