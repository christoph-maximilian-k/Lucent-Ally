import 'dart:typed_data';
import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

// Models.
import '/data/models/files/file_item.dart';
import '/data/models/failure.dart';

class FileRepository {
  /// Method which lets user select an image from the device gallery.
  /// * Should be used in a try catch block.
  /// * Returns `null` if no image was chosen.
  Future<FileItem?> selectImageFromDevice({required String entryId, required String fieldId}) async {
    // Ensure that entryId and fieldId are valid.
    if (entryId.isEmpty || fieldId.isEmpty) throw Failure.genericError();

    // Get image from device.
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    // No image was chosen.
    if (pickedImage == null) return null;

    // Invalid file.
    if (pickedImage.path.isEmpty) throw Failure.invalidImage();

    // Read the bytes of the selected image.
    final Uint8List bytes = await pickedImage.readAsBytes();

    // Generate a SHA-256 hash of the image bytes using Pointy Castle.
    final SHA256Digest sha256 = SHA256Digest();
    final Uint8List hash = sha256.process(bytes);

    // Convert hash to a hex string.
    final String hashString = hash.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

    // Get image properties.
    final int sizeInBytes = bytes.lengthInBytes;

    // Load the image to get its dimensions.
    final Completer<ImageInfo> completer = Completer<ImageInfo>();
    final Image image = Image.memory(bytes);

    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        // Complete the completer when the image has loaded.
        completer.complete(imageInfo);
      }),
    );

    // Wait for the image to load and get its dimensions.
    final ImageInfo imageInfo = await completer.future;

    // Get the dimensions.
    final int mediaWidth = imageInfo.image.width;
    final int mediaHeight = imageInfo.image.height;

    // Get last modified which seems to be the created at.
    final DateTime lastModified = await pickedImage.lastModified();

    // Access the file type.
    final String fileType = path.extension(pickedImage.path).replaceFirst('.', '');

    // Assuming the `FileItem` constructor has appropriate fields.
    FileItem fileItem = FileItem.initial().copyWith(
      hash: hashString, // Use the hex string of the hash.
      createdAtInUtc: DateTime.now().toUtc(),
      lastModifiedInUtc: lastModified.toUtc(),
      type: fileType,
      sizeInBytes: sizeInBytes,
      mediaWidth: mediaWidth,
      mediaHeight: mediaHeight,
      bytes: bytes,
    );

    // Create relative path.
    final String relativePath = 'entries/$entryId/fields/$fieldId/images/${fileItem.id}.${fileItem.type}';

    // Set relative path to fileItem.
    fileItem = fileItem.copyWith(
      relativePath: relativePath,
    );

    return fileItem;
  }

  /// Method which lets user select a file from the file storage.
  /// * Should be used in a try catch block.
  /// * Returns `null` if no file was chosen.
  Future<FileItem?> selectFileFromDevice({required String entryId, required String fieldId, List<String> restrictFilesTo = const []}) async {
    // Ensure that entryId and fieldId are valid.
    if (entryId.isEmpty || fieldId.isEmpty) throw Failure.genericError();

    // Let user pick a file.
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: restrictFilesTo.isEmpty ? ['csv', 'pdf', 'txt', 'doc', 'docx', 'xls', 'xlsx', 'json', 'xml'] : restrictFilesTo,
      allowMultiple: false,
    );

    // User did not pick a file.
    if (result == null) return null;

    // Get the file.
    final XFile pickedFile = result.files.first.xFile;

    // Invalid file.
    if (pickedFile.path.isEmpty) throw Failure.invalidFile();

    // Read the bytes of the selected image.
    final Uint8List bytes = await pickedFile.readAsBytes();

    // Generate a SHA-256 hash of the image bytes using Pointy Castle.
    final SHA256Digest sha256 = SHA256Digest();
    final Uint8List hash = sha256.process(bytes);

    // Convert hash to a hex string.
    final String hashString = hash.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

    // Get file size.
    final int sizeInBytes = bytes.lengthInBytes;

    // Get last modified which seems to be the created at.
    final DateTime lastModified = await pickedFile.lastModified();

    // Access the file type.
    final String fileType = path.extension(pickedFile.path).replaceFirst('.', '');

    // Access the file name (without extension).
    final String fileName = pickedFile.name.replaceFirst(RegExp(r'\.[^\.]+$'), '');

    // Create file item.
    FileItem fileItem = FileItem.initial().copyWith(
      hash: hashString, // Use the hex string of the hash.
      createdAtInUtc: DateTime.now().toUtc(),
      lastModifiedInUtc: lastModified.toUtc(),
      title: fileName,
      type: fileType,
      sizeInBytes: sizeInBytes,
      bytes: bytes,
    );

    // Create relative path.
    final String relativePath = 'entries/$entryId/fields/$fieldId/files/${fileItem.id}.${fileItem.type}';

    // Set relative path to imageItem.
    fileItem = fileItem.copyWith(
      relativePath: relativePath,
    );

    return fileItem;
  }
}
