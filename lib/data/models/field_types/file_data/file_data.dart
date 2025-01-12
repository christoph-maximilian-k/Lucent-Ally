import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/file_data/schemas/db_file_data.dart';

// Models.
import '/data/models/files/files.dart';
import '/data/models/field_types/tags_data/tags_data.dart';

class FileData extends Equatable {
  final Files files;
  final TagsData tagsData;

  const FileData({
    required this.files,
    required this.tagsData,
  });

  @override
  List<Object> get props => [files, tagsData];

  /// Initialize a new `FileData` object.
  factory FileData.initial() {
    return FileData(
      files: Files.initial(),
      tagsData: TagsData.initial(),
    );
  }

  /// This method can be used to indicate if this field should be include from being saved to local storage.
  static bool includeField({required FileData? fileData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (fileData == null) return false;

    // Convenience variables.
    final bool hasData = fileData.files.items.isNotEmpty;

    // * User is in set default mode.
    // ! Currently defaults cannot be set for files.
    if (isDefault) return false;

    // * User is in import mode.
    // ! Currently files cannot be imported.
    if (isImport) return false;

    // * User is in normal set entry mode.

    // Include field if value is set.
    if (hasData) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue() {
    return null;
  }

  /// This method can be used to access the display value for the subtitle in a CardEntryPreview.
  /// * returns ```null``` because files should not be available to be set as a subtitle.
  String? getSubtitle({required String fieldLabel}) {
    return null;
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` because files should not be available to be set as a thirdline.
  String? getThirdline({required String fieldLabel}) {
    return null;
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```FileData``` object to a ```DbFileData``` object.
  DbFileData toSchema() {
    return DbFileData(
      value: files.toSchema(),
      tagsData: tagsData.toSchema(),
    );
  }

  /// Convert a ```DbFileData``` object to a ```FileData``` object.
  static FileData? fromSchema({required DbFileData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Convert Files.
    final Files? value = Files.fromSchema(schema: schema.value);
    if (value == null) return null;

    return FileData(
      files: value,
      tagsData: TagsData.fromSchema(schema: schema.tagsData)!,
    );
  }

  // #####################################
  // Copy With
  // #####################################

  FileData copyWith({
    Files? files,
    TagsData? tagsData,
  }) {
    return FileData(
      files: files ?? this.files,
      tagsData: tagsData ?? this.tagsData,
    );
  }
}
