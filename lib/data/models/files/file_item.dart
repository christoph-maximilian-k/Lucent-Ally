import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Schemas.
import 'schemas/db_file_item.dart';

class FileItem extends Equatable {
  final String id;

  final String relativePath;

  final DateTime createdAtInUtc;
  final DateTime lastModifiedInUtc;

  /// This can be used to check for duplicate files.
  final String hash;

  /// The file type, like "jpg", "png", "pdf", ....
  final String type;

  /// The file size before encryption.
  final int sizeInBytes;

  /// The width of a media file.
  final int? mediaWidth;

  /// The height of a media file.
  final int? mediaHeight;

  /// The duration of media files.
  final double? duration;

  final String title;
  final String caption;

  /// This holds the decrypted bytes.
  final Uint8List? bytes;

  const FileItem({
    required this.id,
    required this.relativePath,
    required this.createdAtInUtc,
    required this.lastModifiedInUtc,
    required this.hash,
    required this.type,
    required this.sizeInBytes,
    required this.mediaWidth,
    required this.mediaHeight,
    required this.duration,
    required this.title,
    required this.caption,
    required this.bytes,
  });

  /// Initialize a new ```FileItem``` object.
  factory FileItem.initial() {
    // Access now.
    final DateTime now = DateTime.now().toUtc();

    return FileItem(
      id: const Uuid().v4(),
      relativePath: '',
      createdAtInUtc: now,
      lastModifiedInUtc: now,
      hash: '',
      type: '',
      sizeInBytes: 0,
      mediaWidth: null,
      mediaHeight: null,
      duration: null,
      title: '',
      caption: '',
      bytes: null,
    );
  }

  @override
  List<Object?> get props => [id, relativePath, hash, type, createdAtInUtc, lastModifiedInUtc, sizeInBytes, mediaWidth, mediaHeight, duration, title, caption, bytes];

  /// This can be used to access the correct MimeType of an extension.
  /// * Returns `null` if extension was not found.
  static String? getMimeType({required String extension}) {
    // Define a map of common file extensions and their MIME types.
    const Map<String, String> mimeTypes = {
      'png': 'image/png',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'gif': 'image/gif',
      'bmp': 'image/bmp',
      'webp': 'image/webp',
      'svg': 'image/svg+xml',
      'pdf': 'application/pdf',
      'txt': 'text/plain',
      'html': 'text/html',
      'htm': 'text/html',
      'json': 'application/json',
      'xml': 'application/xml',
      'mp3': 'audio/mpeg',
      'wav': 'audio/wav',
      'mp4': 'video/mp4',
      'mov': 'video/quicktime',
      'avi': 'video/x-msvideo',
      'zip': 'application/zip',
      'rar': 'application/vnd.rar',
      'tar': 'application/x-tar',
      '7z': 'application/x-7z-compressed',
      'doc': 'application/msword',
      'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'application/vnd.ms-excel',
      'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'csv': 'text/csv',
    };

    // Convert the extension to lowercase to ensure case-insensitive matching.
    final lowerExtension = extension.toLowerCase();

    // Return the matching MIME type, or null if not found.
    return mimeTypes[lowerExtension];
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```FileItem``` object to a ```DbFileItem``` object.
  DbFileItem toSchema() {
    return DbFileItem(
      id: id,
      relativePath: relativePath,
      hash: hash,
      type: type,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      lastModifiedInUtc: lastModifiedInUtc.millisecondsSinceEpoch,
      sizeInBytes: sizeInBytes,
      mediaWidth: mediaWidth,
      mediaHeight: mediaHeight,
      duration: duration,
      title: title,
      caption: caption,
    );
  }

  /// Convert a ```DbFileItem``` object to a ```FileItem``` object.
  /// * Does not retrieve the actual image bytes from file because those should only get loaded on demand.
  static FileItem fromSchema({required DbFileItem schema}) {
    return FileItem(
      id: schema.id!,
      relativePath: schema.relativePath!,
      hash: schema.hash!,
      type: schema.type!,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc!, isUtc: true),
      lastModifiedInUtc: DateTime.fromMillisecondsSinceEpoch(schema.lastModifiedInUtc!, isUtc: true),
      sizeInBytes: schema.sizeInBytes!,
      mediaWidth: schema.mediaWidth,
      mediaHeight: schema.mediaHeight,
      duration: schema.duration,
      title: schema.title ?? '',
      caption: schema.caption ?? '',
      bytes: null,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  FileItem copyWith({
    String? id,
    String? relativePath,
    DateTime? createdAtInUtc,
    DateTime? lastModifiedInUtc,
    String? hash,
    String? type,
    int? sizeInBytes,
    int? mediaWidth,
    int? mediaHeight,
    double? duration,
    String? title,
    String? caption,
    Uint8List? bytes,
  }) {
    return FileItem(
      id: id ?? this.id,
      relativePath: relativePath ?? this.relativePath,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      lastModifiedInUtc: lastModifiedInUtc ?? this.lastModifiedInUtc,
      hash: hash ?? this.hash,
      type: type ?? this.type,
      sizeInBytes: sizeInBytes ?? this.sizeInBytes,
      mediaWidth: mediaWidth ?? this.mediaWidth,
      mediaHeight: mediaHeight ?? this.mediaHeight,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      caption: caption ?? this.caption,
      bytes: bytes ?? this.bytes,
    );
  }
}
