import 'package:equatable/equatable.dart';

// Schemas.
import 'schemas/db_file_item.dart';

// Models.
import 'file_item.dart';

class Files extends Equatable {
  final List<FileItem> items;

  const Files({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new `Files` object.
  factory Files.initial() {
    return const Files(
      items: [],
    );
  }

  /// Indicates if files is not empty and first item has bytes present.
  bool get getFirstItemHasBytes {
    if (items.isEmpty) return false;
    if (items.first.bytes == null || items.first.bytes!.isEmpty) false;
    return true;
  }

  /// Indicates if any `fileItem.bytes` is `null` or `bytes!.isEmpty`.
  bool get getInvalidFilesExists {
    return items.any((element) {
      if (element.bytes == null) return true;
      if (element.bytes!.isEmpty) return true;
      return false;
    });
  }

  /// This method can be used to check for dupliactes.
  /// * Returns `null` if hash was not found.
  FileItem? findFileByHash({required FileItem fileItem}) {
    for (final FileItem item in items) {
      if (fileItem.hash == item.hash) return item;
    }

    return null;
  }

  /// Get an `FileItem` by its id.
  /// * Returns `null` if id was not found.
  FileItem? byId({required FileItem fileItem}) {
    for (FileItem item in items) {
      if (item.id == fileItem.id) return item;
    }

    return null;
  }

  /// This method can be used to identify which files of [items] are not in [other].
  Files notIn({required Files other}) {
    // Create helper list.
    List<FileItem> list = [];

    for (final FileItem fileItem in items) {
      // Get file by id.
      final FileItem? item = other.byId(fileItem: fileItem);

      // * File is in other.
      if (item != null) continue;

      // * Add file.
      list.add(fileItem);
    }

    return Files(items: list);
  }

  /// This method can be used to identify which files of [items] are in [other].
  Files isIn({required Files other}) {
    // Create helper list.
    List<FileItem> list = [];

    for (final FileItem fileItem in items) {
      // Get file by id.
      final FileItem? item = other.byId(fileItem: fileItem);

      // * File is not in other.
      if (item == null) continue;

      // * Add file.
      list.add(fileItem);
    }

    return Files(items: list);
  }

  /// Helper method to join two `Files` objects.
  Files join({required Files other}) {
    // If other is empty, no new item has to be added.
    if (other.items.isEmpty) return this;

    // Init helper list.
    List<FileItem> list = [];

    // Go through state list.
    for (final FileItem item in items) {
      list.add(item);
    }

    // Go through other list.
    for (final FileItem item in other.items) {
      list.add(item);
    }

    return Files(items: list);
  }

  /// Helper method to add an [FileItem] to [items].
  Files add({required FileItem fileItem}) {
    return Files(
      items: [...items, fileItem],
    );
  }

  /// Helper method to remove an [FileItem] from [items].
  Files remove({required int index}) {
    // Initialize list.
    List<FileItem> updatedList = [];

    // Add current items to new list.
    for (FileItem fileItem in items) {
      updatedList.add(fileItem);
    }

    updatedList.removeAt(index);

    return Files(items: updatedList);
  }

  /// Helper method to update an [FileItem].
  Files update({required FileItem updatedFileItem}) {
    // Initialize list.
    List<FileItem> updatedList = [];

    // Add current items to new list.
    for (FileItem item in items) {
      if (item.id == updatedFileItem.id) {
        updatedList.add(updatedFileItem);
        continue;
      }

      updatedList.add(item);
    }

    return Files(items: updatedList);
  }

  /// Helper method to put an [FileItem].
  Files put({required FileItem fileItem}) {
    // Initialize list.
    List<FileItem> updatedList = [];

    bool flag = false;

    // Add current items to new list.
    for (FileItem item in items) {
      if (item.id == fileItem.id) {
        updatedList.add(fileItem);

        // Update flag that indicates that item existed.
        flag = true;

        continue;
      }

      updatedList.add(item);
    }

    // Item was not found, add it.
    if (flag == false) updatedList.add(fileItem);

    return Files(items: updatedList);
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```Files``` object to a ```DbFiles``` object.
  List<DbFileItem> toSchema() {
    // Init helper.
    List<DbFileItem> helper = [];

    // Go through FileItems and convert.
    for (final FileItem fileItem in items) {
      // Convert item.
      final DbFileItem dbFileItem = fileItem.toSchema();

      // Add to helper.
      helper.add(dbFileItem);
    }

    return helper;
  }

  /// Convert a ```DbFiles``` object to a ```Files``` object.
  static Files? fromSchema({required List<DbFileItem>? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Initialize helper.
    List<FileItem> helper = [];

    // Go through files and convert.
    for (final DbFileItem element in schema) {
      // Parse FileItem.
      final FileItem fileItem = FileItem.fromSchema(schema: element);

      // Add to list.
      helper.add(fileItem);
    }

    // Return files.
    return Files(items: helper);
  }

  // ######################################
  // Copy With
  // ######################################

  Files copyWith({
    List<FileItem>? items,
  }) {
    return Files(
      items: items ?? this.items,
    );
  }
}
