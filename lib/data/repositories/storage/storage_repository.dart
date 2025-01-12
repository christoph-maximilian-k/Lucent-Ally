import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:image_picker/image_picker.dart';

// Schemas.
import '/data/models/users/schemas/db_user.dart';
import '/data/models/model_entries/schemas/db_model_entry.dart';
import '/data/models/entries/schemas/db_entry.dart';
import '/data/models/references/group_to_entry/schemas/db_group_to_entry.dart';
import '/data/models/references/participant_to_member/schemas/db_participant_to_member.dart';
import '/data/models/references/recent_entries/schemas/db_recent_entry.dart';
import '/data/models/groups/schemas/db_group.dart';
import '/data/models/tags/schemas/db_tag.dart';
import '/data/models/members/schemas/db_member.dart';
import '/data/models/participants/schemas/db_participant.dart';
import '/data/models/exchange_rates/schemas/db_exchange_rate.dart';
import '/data/models/model_entry_prefs/schemas/db_model_entry_prefs.dart';
import '/data/models/group_prefs/schemas/db_group_prefs.dart';

// User with Settings and labels.
import '/main.dart';

// Models.
import '/data/models/failure.dart';

class StorageRepository {
  /// This method can be used to access the base directory.
  /// * Should be used inside a try catch block.
  /// ```dart
  /// final Directory directory = Directory('${dir.path}/$userId/');
  /// ```
  Future<Directory> getBaseDirectory({required String userId}) async {
    // Get the Application documents directory.
    final Directory dir = await getApplicationDocumentsDirectory();

    // Join directory.
    final Directory directory = Directory('${dir.path}/$userId/');

    return directory;
  }

  /// This method can be used to open a database.
  /// * Should be used in a try catch block.
  Future<Isar> openDatabase({required String directoryPath, required String databaseName}) async {
    // Open a new isar store.
    final Isar isar = await Isar.open(
      directory: directoryPath,
      name: databaseName,
      compactOnLaunch: const CompactCondition(minRatio: 2.0),
      inspector: false,
      [
        DbUserSchema,
        DbGroupSchema,
        DbModelEntrySchema,
        DbEntrySchema,
        DbGroupToEntrySchema,
        DbParticipantToMemberSchema,
        DbTagSchema,
        DbParticipantSchema,
        DbMemberSchema,
        DbExchangeRateSchema,
        DbRecentEntrySchema,
        DbModelEntryPrefsSchema,
        DbGroupPrefsSchema,
      ],
    );

    return isar;
  }

  /// This method can be used to create a new object in specified store.
  /// * Should be used in a try catch block.
  /// * Fails if db is null.
  /// * Fails if ```collectionName``` does not exist.
  /// * Fails if specified schema id already exists.
  Future<int> create({required Isar? db, required String collectionName, required dynamic schema, required Failure shouldThrow}) async {
    try {
      // Do null check.
      if (db == null) throw Failure.databaseIsNull();

      // Access desired collection.
      final IsarCollection collection = await _getCollection(
        db: db,
        collectionName: collectionName,
      );

      // Make sure this id does not already exist.
      // * This is needed because isar only knows put. Meaning that if for some reason an id already exists
      // * it will be overwritten, which is not desireable in a create function.
      final dynamic exists = await collection.get(schema.isarId);

      // Make sure the object does not already exist.
      if (exists != null) throw Failure.failureStorageObjectExists();

      // Create the object.
      final int id = await collection.put(schema);

      return id;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('StorageRepository --> create() --> failure: ${failure.toString()}');

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('StorageRepository --> create() --> exception: ${exception.toString()}');

      throw shouldThrow;
    }
  }

  /// This method can be used to update an object in specified store.
  /// * Should be used in a try catch block.
  /// * Fails if db is null.
  /// * Fails if ```collectionName``` does not exist.
  /// * Fails if specified schema id does not exist.
  Future<int> update({required Isar? db, required String collectionName, required dynamic schema, required Failure shouldThrow}) async {
    try {
      // Do null check.
      if (db == null) throw Failure.databaseIsNull();

      // Access desired collection.
      final IsarCollection collection = await _getCollection(
        db: db,
        collectionName: collectionName,
      );

      // Make sure this id does already exist.
      // * This is needed because isar only knows put. Updates should only be performed on existing ids.
      final dynamic exists = await collection.get(schema.isarId);

      // Make sure the object exists.
      if (exists == null) throw Failure.failureStorageObjectDoesNotExist();

      // Update the object.
      final int id = await collection.put(schema);

      return id;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('StorageRepository --> update() --> failure: ${failure.toString()}');

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('StorageRepository --> update() --> exception: ${exception.toString()}');

      throw shouldThrow;
    }
  }

  /// This method can be used to delete an object in specified store.
  /// * Should be used in a try catch block.
  /// * Success is indicated if specified id does not exist.
  /// * Fails if delete fails.
  /// * Fails if db is null.
  /// * Fails if ```collectionName``` does not exist.
  Future<void> delete({required Isar? db, required String collectionName, required dynamic schema, required Failure shouldThrow}) async {
    try {
      // Do null check.
      if (db == null) throw Failure.databaseIsNull();

      // Access desired collection.
      final IsarCollection collection = await _getCollection(
        db: db,
        collectionName: collectionName,
      );

      // Check if this id exists.
      final dynamic exists = await collection.get(schema.isarId);

      // This id does not exist and therefore cannot be deleted. Return true because non-existing equals deleted.
      if (exists == null) return;

      // Delete the object.
      final bool success = await collection.delete(schema.isarId);

      // * Failed to delete record.
      if (success == false) throw shouldThrow;

      return;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('StorageRepository --> delete() --> failure: ${failure.toString()}');

      rethrow;
    } catch (exception) {
      // Output debug message.
      debugPrint('StorageRepository --> delete() --> exception: ${exception.toString()}');

      throw shouldThrow;
    }
  }

  /// This method can be used to get an object by its id from specified collection.
  /// * Should be used in a try catch block.
  Future<dynamic> getById({required Isar? db, required String collectionName, required int id}) async {
    // Do null check.
    if (db == null) throw Failure.databaseIsNull();

    // Access desired collection.
    final IsarCollection collection = await _getCollection(
      db: db,
      collectionName: collectionName,
    );

    // Get the object by its id.
    final dynamic object = await collection.get(id);

    return object;
  }

  // #############################
  // Files
  // #############################

  /// This method can be used to put a file into local storage.
  Future<void> putFile({required XFile xFile}) async {
    // Create the File.
    final File initialFile = File(xFile.path);

    // Check if this file already exists.
    final bool fileExists = await initialFile.exists();

    // Return the file if it already exists, output debug indication.
    if (fileExists) {
      // Output debug message.
      debugPrint('StorageRepository --> putFile() --> File exists, overwrite file contents.');

      // Update the file.
      // * Read the contents of the XFile as bytes and write it to the local file.
      final List<int> bytes = await xFile.readAsBytes();

      // Write as bytes.
      await initialFile.writeAsBytes(bytes);

      return;
    }

    // Create File.
    await initialFile.create(recursive: true);

    // Update the file.
    // * Read the contents of the XFile as bytes and write it to the new local file.
    final List<int> bytes = await xFile.readAsBytes();

    // Write as bytes.
    await initialFile.writeAsBytes(bytes);
  }

  /// This method can be used to delete a file from directory.
  /// * Should be used inside a try catch block.
  Future<void> deleteFile({required String filePath}) async {
    // Create initial file.
    final File file = File(filePath);

    // Check if this file exists.
    final bool fileExists = await file.exists();

    // File does not exist, which is equal to success.
    if (fileExists == false) return;

    // The file exists, delete it.
    await file.delete();
  }

  /// This method can be used to delete any empty directory that is discovered.
  /// * Should be used in a try catch block.
  Future<void> deleteAllEmptyDirectories() async {
    // Get the Application documents directory.
    final Directory dir = await getBaseDirectory(userId: user.userId);

    // Recursively list all files and directories
    dir.listSync(recursive: true).forEach((entity) async {
      if (entity is Directory) {
        // Check if directory is empty.
        final bool isEmpty = entity.listSync().isEmpty;

        // If the directory is empty, delete it.
        if (isEmpty) await entity.delete();
      }
    });
  }

  /// This method can be used to delete specified directory.
  /// * Should be used in a try catch block.
  Future<void> deleteDirectory({required String directoryPath}) async {
    // Check if this directory exists.
    final bool directoryExists = await Directory(directoryPath).exists();

    // If file does not exist, no delete is needed.
    if (directoryExists == false) return;

    // Directory exists, delete it.
    await Directory(directoryPath).delete(recursive: true);
  }

  /// This method can be used to access all files of a given folder.
  /// * This opens any sub directories and accesses its contents.
  Future<dynamic> loadFilesOfFolderRecursively({required String folderPath, required bool onlyPaths}) async {
    // Create a Directory instance for the specified folder.
    final Directory folder = Directory(folderPath);

    // Check if the folder exists.
    final bool folderExists = await folder.exists();

    // Folder does not exist.
    if (folderExists == false) {
      // Output debug message.
      debugPrint('StorageRepository --> loadFilesOfFolderRecursively() --> Folder does not exist at path: $folderPath');

      // Return an empty list if the folder does not exist.
      return onlyPaths ? <String>[] : <File>[];
    }

    // Helper that stores all files.
    final List<File> files = [];
    final List<String> filePaths = [];

    // Recursively list all files and directories
    folder.listSync(recursive: true).forEach((entity) {
      if (entity is File) {
        // Only paths were requested.
        if (onlyPaths) filePaths.add(entity.path);

        // Files were requested.
        if (onlyPaths == false) files.add(entity);
      }
    });

    // Only the paths are requested.
    if (onlyPaths) return filePaths;

    return files;
  }

  /// This method can be used to access the bytes of a file.
  /// * Returns ```null``` on error.
  Future<Uint8List?> getFileBytes({required String filePath}) async {
    try {
      // Helper.
      final File file = File(filePath);

      // Read the file.
      final Uint8List bytes = await file.readAsBytes();

      return bytes;
    } catch (error) {
      // Output debug message.
      debugPrint('StorageRepository --> getFileBytes() --> Exception: ${error.toString()}');
      return null;
    }
  }

  // #############################
  // Private
  // #############################

  /// This method can be used to access currently relevant collection.
  /// * Should be used in a try catch block.
  /// * Fails if ```collectionName``` does not exist.
  Future<IsarCollection> _getCollection({required Isar db, required String collectionName}) async {
    // Init collection.
    IsarCollection? collection;

    if (collectionName == DbUser.collectionName) collection = db.collection<DbUser>();
    if (collectionName == DbGroup.collectionName) collection = db.collection<DbGroup>();
    if (collectionName == DbModelEntry.collectionName) collection = db.collection<DbModelEntry>();
    if (collectionName == DbEntry.collectionName) collection = db.collection<DbEntry>();
    if (collectionName == DbGroupToEntry.collectionName) collection = db.collection<DbGroupToEntry>();
    if (collectionName == DbParticipantToMember.collectionName) collection = db.collection<DbParticipantToMember>();
    if (collectionName == DbTag.collectionName) collection = db.collection<DbTag>();
    if (collectionName == DbMember.collectionName) collection = db.collection<DbMember>();
    if (collectionName == DbParticipant.collectionName) collection = db.collection<DbParticipant>();
    if (collectionName == DbExchangeRate.collectionName) collection = db.collection<DbExchangeRate>();
    if (collectionName == DbRecentEntry.collectionName) collection = db.collection<DbRecentEntry>();
    if (collectionName == DbModelEntryPrefs.collectionName) collection = db.collection<DbModelEntryPrefs>();
    if (collectionName == DbGroupPrefs.collectionName) collection = db.collection<DbGroupPrefs>();

    // Check that collection was initialized.
    // * An unknown collection was called if collection == null.
    if (collection == null) throw Failure.failureStorageUnknownCollection();

    return collection;
  }
}
