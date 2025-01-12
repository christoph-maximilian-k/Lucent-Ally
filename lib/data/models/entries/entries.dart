import 'package:equatable/equatable.dart';


// Labels.
import '/main.dart';

// Schemas.
import '/data/models/entries/schemas/db_entry.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';

// Models.
import 'entry.dart';
import '/data/models/fields/field.dart';
import '/data/models/fields/fields.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/charts/bar_chart/items/bar_item.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/charts/bar_chart/instructions/bar_instruction.dart';
import '/data/models/field_types/phone_data/phone_data.dart';

class Entries extends Equatable {
  final List<Entry> items;

  const Entries({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new [Entries] object.
  factory Entries.initial() {
    return const Entries(
      items: [],
    );
  }

  /// This getter can be used to access ```Entries``` sorted alphabetically.
  Entries get sortAtoZ {
    // * It seems like this is needed because otherwise sort function tries to modify an unmodifiable list.
    if (items.isEmpty) return this;

    // Copy current items.
    final Entries sorted = Entries(items: items);

    // Sort items.
    sorted.items.sort(
      (a, b) => a.entryName.toLowerCase().compareTo(b.entryName.toLowerCase()),
    );

    return sorted;
  }

  /// This getter can be used to access ```Entries``` sorted by most recent edited with first.
  Entries get sortByRecentlyEdited {
    // * It seems like this is needed because otherwise sort function tries to modify an unmodifiable list.
    if (items.isEmpty) return this;

    // Copy current items.
    final Entries sorted = Entries(items: items);

    // Sort items.
    sorted.items.sort(
      (a, b) => b.editedAtInUtc.compareTo(a.editedAtInUtc),
    );

    return sorted;
  }

  /// This getter can be used to access ```Entries``` sorted by most recent created with first.
  Entries get sortByRecentlyCreated {
    // * It seems like this is needed because otherwise sort function tries to modify an unmodifiable list.
    if (items.isEmpty) return this;

    // Copy current items.
    final Entries sorted = Entries(items: items);

    // Sort items.
    sorted.items.sort(
      (a, b) => b.createdAtInUtc.compareTo(a.createdAtInUtc),
    );

    return sorted;
  }

  /// This getter can be used to get the number of entries currently in state.
  int get getNumberOfEntriesInState {
    return items.length;
  }

  /// This getter can be used to check if entries contains expense data.
  bool get containsExpenseData {
    for (final Entry item in items) {
      if (item.fields.containsExpenseData) return true;
    }

    return false;
  }

  /// This getter can be used to access unique ids of ```ModelEntries``` in ```items```.
  List<String> get getModelEntriesIds {
    // Helper.
    List<String> modelEntriesIds = [];

    for (final Entry item in items) {
      // Ignore duplicates.
      if (modelEntriesIds.contains(item.modelEntryReference)) continue;

      modelEntriesIds.add(item.modelEntryReference);
    }

    return modelEntriesIds;
  }

  /// This getter can be used to extract email values as list.
  List<String> get getEmailSuggestions {
    // Init helper.
    List<String> suggestions = [];

    for (final Entry item in items) {
      for (final Field field in item.fields.items) {
        // Ignore undesired field types.
        if (field.fieldType != Field.fieldTypeEmail) continue;

        // Make sure field is valid.
        if (field.emailData == null || field.emailData!.value.isEmpty) continue;

        // Avoid duplicates.
        if (suggestions.contains(field.emailData!.value)) continue;

        // Add valid value to helper.
        suggestions.add(field.emailData!.value);
      }
    }

    return suggestions;
  }

  /// This getter can be used to extract username values as list.
  List<String> get getUsernameSuggestions {
    // Init helper.
    List<String> suggestions = [];

    for (final Entry item in items) {
      for (final Field field in item.fields.items) {
        // Ignore undesired field types.
        if (field.fieldType != Field.fieldTypeUsername) continue;

        // Make sure field is valid.
        if (field.usernameData == null || field.usernameData!.value.isEmpty) continue;

        // Avoid duplicates.
        if (suggestions.contains(field.usernameData!.value)) continue;

        // Add valid value to helper.
        suggestions.add(field.usernameData!.value);
      }
    }

    return suggestions;
  }

  /// This getter can be used to extract website values as list.
  List<String> get getWebsiteSuggestions {
    // Init helper.
    List<String> suggestions = [];

    for (final Entry item in items) {
      for (final Field field in item.fields.items) {
        // Ignore undesired field types.
        if (field.fieldType != Field.fieldTypeWebsite) continue;

        // Make sure field is valid.
        if (field.websiteData == null || field.websiteData!.value.isEmpty) continue;

        // Avoid duplicates.
        if (suggestions.contains(field.websiteData!.value)) continue;

        // Add valid value to helper.
        suggestions.add(field.websiteData!.value);
      }
    }

    return suggestions;
  }

  /// This getter can be used to extract phone values as list.
  List<PhoneData> get getPhoneSuggestions {
    // Init helper.
    List<PhoneData> suggestions = [];
    List<String> suggestionsHelper = [];

    for (final Entry item in items) {
      for (final Field field in item.fields.items) {
        // Ignore undesired field types.
        if (field.fieldType != Field.fieldTypePhone) continue;

        // Make sure field is valid.
        if (field.phoneData == null || field.phoneData!.value.isEmpty) continue;

        // Avoid duplicates.
        if (suggestionsHelper.contains(field.phoneData!.value)) continue;

        // Add valid value to helpers
        suggestions.add(field.phoneData!);
        suggestionsHelper.add(field.phoneData!.value);
      }
    }

    return suggestions;
  }

  /// This method can be used to access ```EntryModels``` of current ```items```.
  Future<ModelEntries> getModelEntries({required ModelEntries allEntryModels}) async {
    // Init helper list.
    List<ModelEntry> list = [];
    List<String> ids = [];

    for (final Entry item in items) {
      // * Access entry model.
      final ModelEntry? entryModel = allEntryModels.getById(id: item.modelEntryReference);

      if (entryModel == null) continue;

      if (ids.contains(entryModel.modelEntryId)) continue;

      list.add(entryModel);
      ids.add(entryModel.modelEntryId);
    }

    return ModelEntries(
      items: list,
    );
  }

  /// Access initial selector index.
  /// * returns ```0``` if ```referenceKey.isEmpty``` or ```items.isEmpty```
  /// * returns ```null``` if ```referenceKey``` was not found.
  int? getInitialIndex({required String referenceKey, required bool fieldRequired}) {
    // If no reference has been set, return 0.
    if (referenceKey.isEmpty || items.isEmpty) return 0;

    for (var i = 0; i < items.length; i++) {
      if (items[i].entryId == referenceKey) return fieldRequired == false ? i + 1 : i;
    }

    return null;
  }

  /// This method can be used to access the number of entries tagged with a specific entry model.
  int numberOfEntriesByModel({required String entryModelKey}) {
    // Init helper int.
    int counter = 0;

    for (final Entry entry in items) {
      if (entry.modelEntryReference == entryModelKey) counter++;
    }

    return counter;
  }

  /// This method can be used to get [Entry] connected to specified entry model.
  Future<Entries> getEntriesByEntryModelId({required String id}) async {
    // Initialize helper list.
    final List<Entry> entries = [];

    // Go through data and select relevant data.
    for (final Entry entry in items) {
      // If id is present, add to list.
      if (entry.modelEntryReference == id) {
        entries.add(entry);
      }
    }

    return Entries(items: entries);
  }

  /// This method can be used to get [Fields] of [Entries] connected to specified entry model.
  Future<Fields> getFieldsByEntryModelId({required String id}) async {
    // Initialize helper list.
    final List<Field> fields = [];

    // Go through data and select relevant data.
    for (final Entry entry in items) {
      // If id is present, add to list.
      if (entry.modelEntryReference == id) {
        for (final Field field in entry.fields.items) {
          fields.add(field);
        }
      }
    }

    return Fields(items: fields);
  }

  /// This method can be used to get an ```Entry``` by its id.
  /// * returns ```null``` if ```entryId``` was not found.
  Future<Entry?> getEntryById({required String entryId}) async {
    // Go through data and select relevant data.
    for (final Entry entry in items) {
      if (entry.entryId == entryId) return entry;
    }

    return null;
  }

  /// This method can be used to get a list of entries depending on provided entry ids.
  /// * returns ```Entries.initial()``` if ```entryReferences.isEmpty```
  /// * sorts entries from a to z
  Future<Entries> getEntriesById({required List<String> entryReferences}) async {
    // Initialize helper list.
    final List<Entry> entries = [];

    // Performance improvement for empty references.
    if (entryReferences.isEmpty) return Entries.initial();

    // Go through data and select relevant data.
    for (final Entry entry in items) {
      // * If recordKey is present, add to list.
      if (entryReferences.contains(entry.entryId)) entries.add(entry);
    }

    // Create sorted entries.
    final Entries sorted = Entries(
      items: entries,
    ).sortAtoZ;

    return sorted;
  }

  /// This method can be used to get a list of entries depending on provided entry ids.
  /// * returns all entries if ```entryReferences.isEmpty```
  /// * sorts entries from a to z
  Future<Entries> getEntriesExcludingSpecified({required List<String> entryReferences}) async {
    // Initialize helper list.
    final List<Entry> entries = [];

    // Performance improvement for empty references.
    if (entryReferences.isEmpty) return this;

    // Go through data and select relevant data.
    for (final Entry entry in items) {
      // * If recordKey is present, skip.
      if (entryReferences.contains(entry.entryId)) continue;

      // * Otherwise add to list.
      entries.add(entry);
    }

    // Create sorted entries.
    final Entries sorted = Entries(
      items: entries,
    ).sortAtoZ;

    return sorted;
  }

  /// This method can be used to access [Entries] which have names that start with given rune.
  Future<Entries> getEntriesWhereFirstRuneIsEqual({required int rune}) async {
    // Initialize helper list.
    final List<Entry> entries = [];

    // Go through data and select relevant data.
    for (final Entry entry in items) {
      // If rune is present, add to list.
      if (entry.entryName.runes.first == rune) {
        entries.add(entry);
      }
    }

    return Entries(items: entries);
  }

  /// This method can be used to add ```Entries``` to ```items```.
  /// * ```Entry``` will only be added if it does not already exist ensuring a unique list.
  Future<Entries> addUniqueEntries({required Entries entries, required bool append}) async {
    // Init helper.
    Entries addedEntries = Entries(
      items: [...items],
    );

    for (final Entry entry in entries.items) {
      // Check if entry already exists.
      final Entry? accessedEntry = await addedEntries.getEntryById(entryId: entry.entryId);

      if (accessedEntry == null) {
        addedEntries = Entries(
          items: append ? [...addedEntries.items, entry] : [entry, ...addedEntries.items],
        );
      }
    }

    return addedEntries;
  }

  /// This method can be used to remove an entry from ```items```.
  Entries remove({required String entryId}) {
    // Initialize helper list.
    final List<Entry> entries = [];

    // Go through data and select relevant data.
    for (final Entry item in items) {
      // * Exclude specified entry.
      if (entryId == item.entryId) continue;

      entries.add(item);
    }

    return Entries(items: entries);
  }

  /// This method can be used to add an entry to ```items```.
  Entries add({required Entry entry}) {
    return Entries(
      items: [entry, ...items],
    );
  }

  /// This method can be used to update an entry of ```items```.
  /// * Returns ```null``` if ```entryId``` was not found in ```items```.
  Entries? update({required Entry updatedEntry}) {
    // Initialize helpers.
    final List<Entry> helper = [];
    bool idFound = false;

    // Copy list.
    for (final Entry entry in items) {
      // Exclude old entry, add new one.
      if (entry.entryId == updatedEntry.entryId) {
        // Add updated object.
        helper.add(updatedEntry);

        // Notify flag.
        idFound = true;

        continue;
      }

      helper.add(entry);
    }

    // Return error if update was conducted on an id that does not exist in items.
    if (idFound == false) return null;

    return Entries(items: helper);
  }

  /// This method can be used to set an entry of ```items```.
  /// * Adda `entry` if ```entryId``` is ```null``` otherwise updates.
  Entries set({required Entry entry}) {
    // Initialize helpers.
    final List<Entry> helper = [];
    bool idFound = false;

    // Copy list.
    for (final Entry item in items) {
      // Exclude old entry, add new one.
      if (item.entryId == entry.entryId) {
        // Add updated object.
        helper.add(entry);

        // Notify flag.
        idFound = true;

        continue;
      }

      helper.add(item);
    }

    // Return error if update was conducted on an id that does not exist in items.
    if (idFound == false) helper.add(entry);

    return Entries(items: helper);
  }

  // #############################################
  // Charts
  // #############################################

  /// Chart instruction to calculate the number of entries.
  /// ```dart
  /// static const String chartInstructionNumberOfEntries = 'number_of_entries';
  /// ```
  static const String chartInstructionNumberOfEntries = 'number_of_entries';

  /// This method can be used to create a [BarItem] depending on selected data.
  /// * Returns ```null``` if ```instructionType``` is unknown.
  static Future<BarItems?> createBarItems({required BarInstruction barInstruction, required LocalStorageCubit localStorageCubit, required String groupId}) async {
    // * User wants the number of entries.
    if (barInstruction.instructionType == chartInstructionNumberOfEntries) {
      return await numberOfEntries(
        barInstruction: barInstruction,
        localStorageCubit: localStorageCubit,
        groupId: groupId,
      );
    }

    return null;
  }

  /// This function can be used to access the number of entries.
  static Future<BarItems> numberOfEntries({required BarInstruction barInstruction, required LocalStorageCubit localStorageCubit, required String groupId}) async {
    // Access number of entries.
    final int total = await localStorageCubit.getNumberOfLocalEntriesInLocalGroup(groupId: groupId);

    // Init bar item.
    BarItem barItem = BarItem.initial().copyWith(
      topTitle: labels.entryEntries(),
      bottomTitle: total.toString(),
      yAxisValue: total.toDouble(),
    );

    // Create the bar items object requried by scope.
    return BarItems(
      items: [barItem],
    );
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```DbEntries``` object to a ```Entries``` object.
  static Entries fromSchema({required List<DbEntry> schema}) {
    // Helper.
    List<Entry> helper = [];

    for (final DbEntry dbEntry in schema) {
      final Entry entry = Entry.fromSchema(
        schema: dbEntry,
      );

      helper.add(entry);
    }

    return Entries(items: helper);
  }

  // #####################################
  // Cloud
  // #####################################

  /// This method can be used to decode ```Entries``` from request JSON.
  static Entries fromCloudObject(data) {
    // Init helper.
    List<Entry> entries = [];

    // Go through returned entries and convert them to local objects.
    for (final dynamic entry in data) {
      // Create the entry.
      final Entry newEntry = Entry.fromCloudObject(entry);

      entries.add(newEntry);
    }

    return Entries(
      items: entries,
    );
  }

  Entries copyWith({
    List<Entry>? items,
  }) {
    return Entries(
      items: items ?? this.items,
    );
  }
}
