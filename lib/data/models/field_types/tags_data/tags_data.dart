import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/tags_data/schemas/db_tags_data.dart';

class TagsData extends Equatable {
  final List<String> tagReferences;
  final String? importReference;

  const TagsData({
    required this.tagReferences,
    required this.importReference,
  });

  @override
  List<Object?> get props => [tagReferences, importReference];

  /// Initialize a new ```TagData``` object.
  factory TagsData.initial() {
    return TagsData(
      tagReferences: const [],
      importReference: '',
    );
  }

  /// This method can be used to validate a tag.
  /// * Returns ```null``` if ```value``` is invalid (RegExp is not matched).
  static String? validateTag({required String value}) {
    // Convert tag to lower case.
    String cleanedTag = value.toLowerCase();

    // Trim it.
    cleanedTag = cleanedTag.trim();

    // Make sure that tag is of pattern that allows only for lower case letters, digits and dash.
    // A dash has to be followed by a letter or digit
    // Dashes are prohibitied in the beginning and the end of the tag.
    final bool isValid = RegExp(r'^[a-z0-9%=~&°§äöüïëÿẍ]+(?: [a-z0-9%=~&°§äöüïëÿẍ]+)*$').hasMatch(cleanedTag);

    // Get tag length.
    final int length = cleanedTag.length;

    // Make sure tag is not to long.
    if (length > 40) return null;

    // * Invalid tag.
    if (isValid == false) return null;

    return cleanedTag;
  }

  /// This method can be used to indicate if this field should be include from being saved to local storage.
  static bool includeField({required TagsData? tagsData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (tagsData == null) return false;

    // Convenience variables.
    final bool hasData = tagsData.tagReferences.isNotEmpty;

    final bool hasRef = tagsData.importReference != null && tagsData.importReference!.trim().isNotEmpty;

    // * User is in set default mode.
    if (isDefault) {
      // User set a default value.
      if (hasData) return true;

      return false;
    }

    // * User is in import mode.
    if (isImport) {
      // User set a import reference.
      if (hasRef) return true;

      // * User might also have set a default value but this is optional so it wont be checked.

      return false;
    }

    // * User is in normal set entry mode.

    // Include field if value is set.
    if (hasData) return true;

    return false;
  }

  /// This method can be used to remove duplicate tags.
  TagsData removeDuplicates() {
    // Remove duplicates using a Set
    final List<String> uniqueList = tagReferences.toSet().toList();

    return TagsData(
      tagReferences: uniqueList,
      importReference: importReference,
    );
  }

  /// This method can be used to add a ```TagReference``` to ```tagReferences```.
  TagsData add({required String tagId}) {
    return TagsData(
      tagReferences: [...tagReferences, tagId],
      importReference: importReference,
    );
  }

  /// This method can be used to remove a ```tagId``` from ```tagReferences```.
  TagsData remove({required String tagId}) {
    // Init helper lists.
    List<String> referenceHelper = [];

    // Go through references.
    for (final String item in tagReferences) {
      // * Exclude specified tag.
      if (item == tagId) continue;

      referenceHelper.add(item);
    }

    return TagsData(
      tagReferences: referenceHelper,
      importReference: importReference,
    );
  }

  // -------------------------------------
  // ------------ Statistics -------------
  // -------------------------------------

  // -------------------------------------
  // Bar Chart Instructions
  // -------------------------------------

  /// Bar Chart identification to number of entries in a category.
  /// ```dart
  /// static const String barChartEntriesByTag = 'entries_by_tag';
  /// ```
  static const String barChartEntriesByTag = 'entries_by_tag';

  // -------------------------------------
  // Pie Chart Instructions
  // -------------------------------------

  /// Pie Chart identification to share of entries in a category.
  /// ```dart
  /// static const String pieChartEntriesShareByTag = 'entries_share_by_tag';
  /// ```
  static const String pieChartEntriesShareByTag = 'entries_share_by_tag';

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```TagsData``` object to a ```DbTagsData``` object.
  /// * This will only encode the tag references.
  DbTagsData toSchema() {
    return DbTagsData(
      tagReferences: tagReferences,
      importReference: importReference,
    );
  }

  /// Convert a ```DbTagsData``` object to a ```TagsData``` object.
  /// * Only loads references. The actual ```tags``` have to be accessed seperately.
  static TagsData? fromSchema({required DbTagsData? schema}) {
    // Do null check.
    if (schema == null) return null;

    return TagsData(
      tagReferences: schema.tagReferences!,
      importReference: schema.importReference,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Encode a ```TagsData``` object to JSON.
  /// * This will only encode the tag references.
  Map<String, dynamic> toCloudObject() {
    return {
      'tag_references': tagReferences,
    };
  }

  /// Decode a ```TagsData``` object from JSON.
  /// ```dart
  /// return TagsData(
  ///  tagReferences: List<String>.from(document['tag_references']),
  /// );
  /// ```
  static TagsData fromCloudObject(document) {
    return TagsData(
      tagReferences: List<String>.from(document['tag_references']),
      importReference: null,
    );
  }

  TagsData copyWith({
    List<String>? tagReferences,
    String? importReference,
  }) {
    return TagsData(
      tagReferences: tagReferences ?? this.tagReferences,
      importReference: importReference ?? this.importReference,
    );
  }
}
