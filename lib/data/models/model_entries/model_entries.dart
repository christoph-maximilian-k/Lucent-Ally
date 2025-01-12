import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/model_entries/schemas/db_model_entry.dart';

// User and Settings.
import '/main.dart';

// Models.
import 'model_entry.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/field_identifications/field_identifications.dart';

import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class ModelEntries extends Equatable {
  final List<ModelEntry> items;

  const ModelEntries({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new [ModelEntries] object.
  factory ModelEntries.initial() {
    return const ModelEntries(
      items: [],
    );
  }

  /// Helper method to check if an [ModelEntry] of name is in [items].
  bool getModelNameExists({required String modelName}) {
    for (final ModelEntry entryModel in items) {
      if (entryModel.modelEntryName.toLowerCase() == modelName.toLowerCase()) return true;
    }
    return false;
  }

  /// Helper method to access the [ModelEntry] of a given entry model key.
  /// * returns null if the entryModelKey was not found
  ModelEntry? getById({required String id}) {
    for (final ModelEntry entryModel in items) {
      if (entryModel.modelEntryId == id) return entryModel;
    }
    return null;
  }

  /// This method can be used to access a FieldIdentification by id.
  /// * Returns null if the ```fieldId``` was not found.
  FieldIdentification? getFieldIdentificationById({required String fieldId}) {
    for (final ModelEntry item in items) {
      for (final FieldIdentification fieldIdentification in item.fieldIdentifications.items) {
        if (fieldIdentification.fieldId == fieldId) return fieldIdentification;
      }
    }

    return null;
  }

  /// Helper method to access name of an entry model by key.
  /// * returns null if the entryModelKey was not found
  String? getEntryModelNameByKey({required String? entryModelKey}) {
    for (final ModelEntry entryModel in items) {
      if (entryModel.modelEntryId == entryModelKey) return entryModel.modelEntryName;
    }
    return null;
  }

  /// This method can be used to access ```FieldIdentifications``` of current ```items```.
  Future<FieldIdentifications> get getFieldIdentifications async {
    // Init helper list.
    List<FieldIdentification> list = [];
    List<String> ids = [];

    for (final ModelEntry item in items) {
      for (final FieldIdentification fieldIdentification in item.fieldIdentifications.items) {
        // * Already in list, skip.
        if (ids.contains(fieldIdentification.fieldId)) continue;

        list.add(fieldIdentification);
        ids.add(fieldIdentification.fieldId);
      }
    }

    return FieldIdentifications(
      items: list,
    );
  }

  /// This method can be used to access ```FieldIdentifications``` specified in ```fieldIds```.
  /// * If a ```fieldId``` is not found, it will be skipped.
  Future<FieldIdentifications> getFieldIdentificationsBatch({required List<String> fieldIds}) async {
    // Init helper list.
    List<FieldIdentification> list = [];

    // Access all FieldIdentifications.
    final FieldIdentifications fieldIdentifications = await getFieldIdentifications;

    for (final String fieldId in fieldIds) {
      // Access fieldIdentification.
      final FieldIdentification? fieldIdentification = fieldIdentifications.getById(fieldId: fieldId);

      // Not found, continue with next item.
      if (fieldIdentification == null) continue;

      // Add to list.
      list.add(fieldIdentification);
    }

    return FieldIdentifications(
      items: list,
    );
  }

  /// This getter can be used to access ```ModelEntries``` created by current user.
  Future<ModelEntries> get getCreatedByCurrentUser async {
    // Init helper.
    List<ModelEntry> helper = [];

    for (final ModelEntry modelEntry in items) {
      if (modelEntry.modelEntryCreator == user.userId) helper.add(modelEntry);
    }

    return ModelEntries(items: helper);
  }

  /// This getter can be used to access [ModelEntries] sorted alphabetically.
  ModelEntries get sortAtoZ {
    // To not modify unmodifiable list.
    if (items.isEmpty) return this;

    // Copy current items.
    final ModelEntries sorted = ModelEntries(items: items);

    // Sort items.
    sorted.items.sort(
      (a, b) => a.modelEntryName.toLowerCase().compareTo(b.modelEntryName.toLowerCase()),
    );

    return sorted;
  }

  /// This getter can be used to access ```ids``` of ```items```.
  List<String> get getIds {
    // Init helper.
    List<String> helper = [];

    for (final ModelEntry item in items) {
      if (helper.contains(item.modelEntryId) == false) helper.add(item.modelEntryId);
    }

    return helper;
  }

  /// This method can be used to access ```ModelEntires``` in references.
  /// * Returns `ModelEntries.initial()` if `references.isEmpty`.
  Future<ModelEntries> getReferencedModelEntries({required List<String> references, required bool includeDeleted}) async {

    // No references supplied.
    if(references.isEmpty) return ModelEntries.initial();

    // Init helper.
    List<ModelEntry> helper = [];

    if (includeDeleted) {
      for (final String item in references) {
        final ModelEntry? modelEntry = getById(id: item);

        // ModelEntry is not available anymore.
        if (modelEntry == null) {
          final ModelEntry unavailable = ModelEntry.initial().copyWith(
            modelEntryId: item,
            modelEntryName: labels.deletedModelEntry(),
          );

          helper.add(unavailable);
          continue;
        }

        helper.add(modelEntry);
      }

      return ModelEntries(items: helper);
    }

    for (final ModelEntry modelEntry in items) {
      if (references.contains(modelEntry.modelEntryId)) helper.add(modelEntry);
    }

    return ModelEntries(items: helper);
  }

  /// This method can be used to access [ModelEntries] sorted alphabetically and excluding specified [ModelEntry].
  /// * sorts by name
  ModelEntries getSortedEntryModelsExcludingKey({required String entryModelKey}) {
    // Helper list.
    final List<ModelEntry> list = [];

    for (final ModelEntry entryModel in items) {
      if (entryModel.modelEntryId == entryModelKey) continue;

      // Add to list.
      list.add(entryModel);
    }

    // Sort list.
    list.sort(
      (a, b) => a.modelEntryName.toLowerCase().compareTo(b.modelEntryName.toLowerCase()),
    );

    return ModelEntries(items: list);
  }

  /// Convert [ModelEntries] to [PickerItems].
  /// * ```id = entryModel.recordKey```
  /// * ```label = entryModel.name```
  PickerItems toPickerItems() {
    // Helper list.
    List<PickerItem> list = [];

    for (final ModelEntry entryModel in items) {
      // Create PickerItem.
      final PickerItem pickerItem = PickerItem(
        id: entryModel.modelEntryId,
        label: entryModel.modelEntryName,
      );

      // Add item to list.
      list.add(pickerItem);
    }

    return PickerItems(items: list);
  }

  /// This method can be used to add ```ModelEntries``` to ```items```.
  /// * ```ModelEntry``` will only be added if it does not already exist ensuring a unique list.
  Future<ModelEntries> addUniqueModelEntries({required ModelEntries modelEntries}) async {
    // Init helper.
    ModelEntries addedModelEntries = ModelEntries(
      items: [...items],
    );

    for (final ModelEntry modelEntry in modelEntries.items) {
      // Check if ModelEntry already exists.
      final ModelEntry? accessedModelEntry = addedModelEntries.getById(
        id: modelEntry.modelEntryId,
      );

      if (accessedModelEntry == null) {
        addedModelEntries = ModelEntries(
          items: [...addedModelEntries.items, modelEntry],
        );
      }
    }

    return addedModelEntries;
  }

  /// This method can be used to add an ```EntryModel``` to ```items```.
  ModelEntries add({required ModelEntry modelEntry}) {
    return ModelEntries(
      items: [...items, modelEntry],
    );
  }

  /// This method can be used to remove a ```ModelEntry``` from ```items```.
  ModelEntries remove({required String modelEntryId}) {
    // Initialize helpers.
    final List<ModelEntry> helper = [];

    // Copy list.
    for (final ModelEntry item in items) {
      // Exclude this ModelEntry.
      if (item.modelEntryId == modelEntryId) continue;

      helper.add(item);
    }

    return ModelEntries(items: helper);
  }

  /// This method can be used to put a ```ModelEntry``` in ```items```.
  ModelEntries put({required ModelEntry modelEntry}) {
    // Initialize helpers.
    final List<ModelEntry> helper = [];
    bool idFound = false;

    // Copy list.
    for (final ModelEntry item in items) {
      // Exclude old model entry, add new one.
      if (item.modelEntryId == modelEntry.modelEntryId) {
        // Add updated object.
        helper.add(modelEntry);

        // Notify flag.
        idFound = true;

        continue;
      }

      helper.add(item);
    }

    // In case id was not found, add object.
    if (idFound == false) helper.add(modelEntry);

    return ModelEntries(items: helper);
  }

  /// This method can be used to update a ```ModelEntry``` in ```items```.
  /// * Returns ```null``` if ```modelEntryId``` was not found in ```items```.
  ModelEntries? update({required ModelEntry modelEntry}) {
    // Initialize helpers.
    final List<ModelEntry> helper = [];
    bool idFound = false;

    // Copy list.
    for (final ModelEntry item in items) {
      // Exclude old model entry, add new one.
      if (item.modelEntryId == modelEntry.modelEntryId) {
        // Add updated object.
        helper.add(modelEntry);

        // Notify flag.
        idFound = true;

        continue;
      }

      helper.add(item);
    }

    // Return error if update was conducted on an id that does not exist in items.
    if (idFound == false) return null;

    return ModelEntries(items: helper);
  }

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```DbModelEntries``` object to a ```ModelEntries``` object.
  static ModelEntries fromSchema({required List<DbModelEntry> schema}) {
    // Helper.
    List<ModelEntry> helper = [];

    for (final DbModelEntry dbModelEntry in schema) {
      final ModelEntry modelEntry = ModelEntry.fromSchema(schema: dbModelEntry);

      helper.add(modelEntry);
    }

    return ModelEntries(items: helper);
  }

  // --------------------------------------
  // ------------ Cloud -------------------
  // --------------------------------------

  /// This method can be used to decode ```EntryModels``` from request JSON.
  static ModelEntries fromCloudObject(data) {
    // Init helper.
    List<ModelEntry> referencedEntryModels = [];

    // Go through returned EntryModels and convert them to local objects.
    for (final dynamic entryModel in data) {
      // Create the entry.
      final ModelEntry newEntry = ModelEntry.fromCloudObject(entryModel);

      referencedEntryModels.add(newEntry);
    }

    return ModelEntries(
      items: referencedEntryModels,
    );
  }

  ModelEntries copyWith({
    List<ModelEntry>? items,
  }) {
    return ModelEntries(
      items: items ?? this.items,
    );
  }
}
