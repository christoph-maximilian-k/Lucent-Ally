import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_identifications/schemas/db_field_identification.dart';
import '/data/models/field_identifications/schemas/db_field_identifications.dart';

// Models.
import 'field_identification.dart';
import '/data/models/fields/field.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class FieldIdentifications extends Equatable {
  final List<FieldIdentification> items;

  const FieldIdentifications({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new ```FieldIdentifications``` object.
  factory FieldIdentifications.initial() {
    return const FieldIdentifications(
      items: [],
    );
  }

  /// This method can be used to access the first data field of specified type.
  /// * Returns an empty String if no field of this type is found.
  String getFirstFieldIdOfType({required String fieldType}) {
    for (final FieldIdentification element in items) {
      if (element.fieldType == fieldType) return element.fieldId;
    }

    return '';
  }

  /// This method can be used to access a [FieldIdentification] by its id.
  /// * returns ```null``` if ```fieldId``` cannot be found
  FieldIdentification? getById({required String fieldId}) {
    for (final FieldIdentification item in items) {
      if (item.fieldId == fieldId) return item;
    }

    return null;
  }

  /// This method can be used to add a ```FieldIdentification``` to ```items```.
  FieldIdentifications add({required FieldIdentification fieldIdentification}) {
    return FieldIdentifications(
      items: [
        ...items,
        fieldIdentification,
      ],
    );
  }

  /// This method can be used to remove a ```FieldIdentification``` object from ```items```.
  FieldIdentifications remove({required String fieldId}) {
    // Init helper.
    List<FieldIdentification> helper = [];

    // Go through items and add relevant data.
    for (final FieldIdentification item in items) {
      // * Exclude specified item.
      if (item.fieldId == fieldId) continue;

      helper.add(item);
    }

    return FieldIdentifications(
      items: helper,
    );
  }

  /// Convert a [FieldIdentifications] object to a [PickerItems] object.
  /// * ```id = fieldIdentification.fieldId```
  /// * ```label = fieldIdentification.label```
  /// * Set ```onlyFieldType``` to a ```Field.fieldType``` to only return this ```fieldType```. This is ignored if ```onlyFieldType == ""```
  /// * Set ```displayAllFieldsOfTypeOption``` to ```true``` to include an option that lets user reset a selected onlyFieldType.
  PickerItems toPickerItems({String onlyFieldType = '', bool displayAllFieldsOfTypeOption = false}) {
    // Helper list.
    List<PickerItem> list = [];

    for (final FieldIdentification item in items) {
      // Exclude item if requested.
      if (onlyFieldType.isNotEmpty && onlyFieldType != item.fieldType) continue;

      // Create PickerItem.
      final PickerItem pickerItem = PickerItem(
        id: item.fieldId,
        label: item.label,
      );

      // Add item to list.
      list.add(pickerItem);
    }

    // Check if a all option should be displayed.
    if (displayAllFieldsOfTypeOption) {
      list = [PickerItem.allFieldsOfType(), ...list];
    }

    return PickerItems(items: list);
  }

  /// This method can be used to access field types of fieldIdentifications as picker items.
  /// * The ```id``` will be set to ```Field.fieldType```.
  /// * The ```label``` will be set to the ```Field.fieldType``` translation.
  /// * The ```preferedTypes``` can be used to ensure that types with highest priority are displayed first.
  PickerItems fieldTypesToPickerItems({List<String> preferedTypes = const []}) {
    // Init helper.
    PickerItems pickerItems = PickerItems.initial();

    for (final FieldIdentification item in items) {
      // Check if type is already part of pickerItems.
      final PickerItem? pickerItem = pickerItems.getById(id: item.fieldType);

      // FieldType found, continue with next item.
      if (pickerItem != null) continue;

      // FieldType not found, initialize and add to list.
      final PickerItem newItem = PickerItem(
        id: item.fieldType,
        label: Field.fieldsByTypeAndLanguage()[item.fieldType]!,
      );

      pickerItems = pickerItems.add(pickerItem: newItem);
    }

    // Prefered types were specified. Sorty by priority.
    if (preferedTypes.isNotEmpty && pickerItems.items.isNotEmpty) {
      // Create a map to store priority values.
      final Map<String, int> priorityMap = {};
      for (int i = 0; i < preferedTypes.length; i++) {
        priorityMap[preferedTypes[i]] = i;
      }

      // Custom sort to ensure preferred items come first by priority.
      pickerItems.items.sort((a, b) {
        final int aPriority = priorityMap.containsKey(a.id) ? priorityMap[a.id]! : preferedTypes.length;
        final int bPriority = priorityMap.containsKey(b.id) ? priorityMap[b.id]! : preferedTypes.length;

        return aPriority.compareTo(bPriority);
      });
    }

    return pickerItems;
  }

  /// Helper method to reorder items according to specifications.
  FieldIdentifications reorder({required int oldIndex, required int newIndex}) {
    // Access field which should be moved.
    final FieldIdentification field = items[oldIndex];

    // Initialize list.
    List<FieldIdentification> updatedList = [];

    // Go through list and add items.
    for (final FieldIdentification fieldIdentification in items) {
      updatedList.add(fieldIdentification);
    }

    updatedList.removeAt(oldIndex);

    updatedList.insert(newIndex, field);

    return FieldIdentifications(
      items: updatedList,
    );
  }

  /// Helper method to copy [items] with updated data and old data.
  /// * for adding - specify ```fieldIdentification```
  /// * for adding at position - specify ```fieldIdentification``` and ```index```
  /// * for removing at position - specify ```index```
  List<FieldIdentification> copyItemsWith({FieldIdentification? fieldIdentification, int? index}) {
    // Initialize list.
    List<FieldIdentification> updatedList = [];

    // Add current items to new list.
    for (final FieldIdentification item in items) {
      updatedList.add(item);
    }

    // Remove item at index.
    if (index != null) updatedList.removeAt(index);

    // Add field to the end of list.
    if (fieldIdentification != null) {
      // If index is provided, insert at index.
      if (index != null) {
        updatedList.insert(index, fieldIdentification);
        return updatedList;
      }

      // Index was not provided, add to end of list.
      updatedList.add(fieldIdentification);
    }

    return updatedList;
  }

  // ####################################
  // Database
  // ####################################

  /// Convert a ```FieldIdentifications``` object to a ```DbFieldIdentifications``` object.
  DbFieldIdentifications toSchema() {
    // Helper.
    List<DbFieldIdentification> helper = [];

    for (final FieldIdentification fieldIdentification in items) {
      // Convert to schema.
      final DbFieldIdentification schema = fieldIdentification.toSchema();

      // Add to helper.
      helper.add(schema);
    }

    return DbFieldIdentifications(items: helper);
  }

  /// Convert a ```DbFieldIdentifications``` object to a ```FieldIdentifications``` object.
  /// * Returns ```FieldIdentifications.initial()``` if ```schema.items == null``` or ```schema.items!.isEmpty```
  static FieldIdentifications fromSchema({required DbFieldIdentifications schema}) {
    // Do null check.
    if (schema.items == null || schema.items!.isEmpty) return FieldIdentifications.initial();

    // Helper.
    List<FieldIdentification> helper = [];

    for (final DbFieldIdentification dbFieldIdentification in schema.items!) {
      // Convert from schema.
      final FieldIdentification fieldIdentification = FieldIdentification.fromSchema(
        schema: dbFieldIdentification,
      );

      // Add to helper.
      helper.add(fieldIdentification);
    }

    return FieldIdentifications(items: helper);
  }

  // ####################################
  // Cloud
  // ####################################

  /// Encode a [FieldIdentifications] object to JSON.
  List<Map<String, dynamic>> toDocument() {
    // Init json list.
    List<Map<String, dynamic>> jsonList = [];

    // Populate jsonList with data.
    for (final FieldIdentification fieldIdentification in items) {
      jsonList.add(fieldIdentification.toDocument());
    }

    return jsonList;
  }

  /// Decode a [FieldIdentifications] object from JSON.
  static FieldIdentifications fromDocument({required List<dynamic> document, required String entryModelId}) {
    // Initialize Fields object.
    List<FieldIdentification> fieldIdentifications = [];

    // Go through list and add converted json to Field objects.
    for (final Map<String, dynamic> fieldIdentification in document) {
      // * Access the FieldIdentification.
      final FieldIdentification identification = FieldIdentification.fromDocument(
        document: fieldIdentification,
        entryModelId: entryModelId,
      );

      fieldIdentifications.add(identification);
    }

    return FieldIdentifications(
      items: fieldIdentifications,
    );
  }

  // ####################################
  // Copy With
  // ####################################

  FieldIdentifications copyWith({
    List<FieldIdentification>? items,
  }) {
    return FieldIdentifications(
      items: items ?? this.items,
    );
  }
}
