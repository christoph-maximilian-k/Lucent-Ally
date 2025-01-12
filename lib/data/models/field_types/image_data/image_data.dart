import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/image_data/schemas/db_image_data.dart';

// Models.
import '/data/models/files/files.dart';
import '/data/models/field_types/tags_data/tags_data.dart';

class ImageData extends Equatable {
  final Files images;
  final TagsData tagsData;

  const ImageData({
    required this.images,
    required this.tagsData,
  });

  @override
  List<Object> get props => [images, tagsData];

  /// Initialize a new `ImageData` object.
  factory ImageData.initial() {
    return ImageData(
      images: Files.initial(),
      tagsData: TagsData.initial(),
    );
  }

  /// This method can be used to indicate if this field should be include from being saved to local storage.
  static bool includeField({required ImageData? imageData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (imageData == null) return false;

    // Convenience variables.
    final bool hasData = imageData.images.items.isNotEmpty;

    // * User is in set default mode.
    // ! Currently defaults cannot be set for images.
    if (isDefault) return false;

    // * User is in import mode.
    // ! Currently images cannot be imported.
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
  /// * returns ```null``` because images should not be available to be set as a subtitle.
  String? getSubtitle({required String fieldLabel}) {
    return null;
  }

  /// This method can be used to access the display value for the thirdline in a CardEntryPreview.
  /// * returns ```null``` because images should not be available to be set as a thirdline.
  String? getThirdline({required String fieldLabel}) {
    return null;
  }

  // #####################################
  // Database
  // #####################################

  /// Convert a ```ImageData``` object to a ```DbImageData``` object.
  DbImageData toSchema() {
    return DbImageData(
      images: images.toSchema(),
      tagsData: tagsData.toSchema(),
    );
  }

  /// Convert a ```DbImageData``` object to a ```ImageData``` object.
  static ImageData? fromSchema({required DbImageData? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Convert Images.
    final Files? value = Files.fromSchema(schema: schema.images);
    if (value == null) return null;

    return ImageData(
      images: value,
      tagsData: TagsData.fromSchema(schema: schema.tagsData)!,
    );
  }

  // #####################################
  // Copy With
  // #####################################

  ImageData copyWith({
    Files? images,
    TagsData? tagsData,
  }) {
    return ImageData(
      images: images ?? this.images,
      tagsData: tagsData ?? this.tagsData,
    );
  }
}
