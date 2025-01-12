import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/field_types/avatar_image_data/schemas/db_avatar_image_data.dart';

// Models.
import '../../files/file_item.dart';
import '../../files/files.dart';

class AvatarImageData extends Equatable {
  final FileItem? image;

  const AvatarImageData({
    required this.image,
  });

  /// Initialize a new ```AvatarImageData``` object.
  factory AvatarImageData.initial() {
    return AvatarImageData(
      image: null,
    );
  }

  @override
  List<Object?> get props => [image];

  /// This method can be used to indicate if this field should be include from being saved to local storage.
  static bool includeField({required AvatarImageData? avatarImageData, required bool isDefault, required bool isImport}) {
    // Always exclude if null.
    if (avatarImageData == null) return false;

    // Convenience variables.
    final bool hasData = avatarImageData.image != null;

    // * User is in set default mode.
    // ! Currently defaults cannot be set for AvatarImage.
    if (isDefault) return false;

    // * User is in import mode.
    // ! Currently a AvatarImage cannot be imported.
    if (isImport) return false;

    // * User is in normal set entry mode.

    // Include field if value is set.
    if (hasData) return true;

    return false;
  }

  /// This method can be used to access the value in copy format.
  static String? getCopyValue({required AvatarImageData? avatarImageData}) {
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

  /// Indicates if whether or not a image is present.
  bool get getHasImage {
    if (image == null) return false;
    if (image!.bytes == null) return false;
    if (image!.bytes!.isEmpty) return false;
    return true;
  }

  /// This method can be used to turn ImageItem into Images.
  Files toFiles() {
    return Files(
      items: image == null ? [] : [image!],
    );
  }

  // ######################################
  // Pie Chart Instructions
  // ######################################

  /// Pie Chart identification to display shares of which images have an image set and which have not.
  /// ```dart
  /// static const String pieChartHasImageDistribution = 'image_exists';
  /// ```
  static const String pieChartHasImageDistribution = 'image_exists';

  /// Pie Chart identification to display shares of which images have a title set and which have not.
  /// ```dart
  /// static const String pieChartHasImageDistribution = 'title_exists';
  /// ```
  static const String pieChartHasTitleDistribution = 'title_exists';

  /// Pie Chart identification to display shares of which images have a text set and which have not.
  /// ```dart
  /// static const String pieChartHasImageDistribution = 'text_exists';
  /// ```
  static const String pieChartHasTextDistribution = 'text_exists';

  // ######################################
  // Database
  // ######################################

  /// Convert a ```AvatarImageData``` object to a ```DbAvatarImageData``` object.
  DbAvatarImageData toSchema() {
    return DbAvatarImageData(
      image: image!.toSchema(),
    );
  }

  /// Convert a ```DbAvatarImageData``` object to a ```AvatarImageData``` object.
  static AvatarImageData? fromSchema({required DbAvatarImageData? schema}) {
    // Do null check.
    if (schema == null) return null;
    if (schema.image == null) return null;

    // Convert Image.
    final FileItem value = FileItem.fromSchema(schema: schema.image!);

    return AvatarImageData(
      image: value,
    );
  }

  // ######################################
  // Copy With
  // ######################################

  AvatarImageData copyWith({
    FileItem? image,
  }) {
    return AvatarImageData(
      image: image ?? this.image,
    );
  }
}
