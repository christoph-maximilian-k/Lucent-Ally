import 'dart:math';

import 'package:equatable/equatable.dart';

// Schemas.
import 'schemas/db_share_reference.dart';

// Models.
import 'share_reference.dart';

class ShareReferences extends Equatable {
  final List<ShareReference> items;

  const ShareReferences({
    required this.items,
  });

  /// Initialize a new ```ShareReferences``` object.
  factory ShareReferences.initial() {
    return const ShareReferences(
      items: [],
    );
  }

  @override
  List<Object> get props => [items];

  /// This getter can be used to get a list of all ```ShareReference.id```.
  List<String> get getIds {
    // Init helper.
    List<String> references = [];

    // Go through references and add relevant data.
    for (final ShareReference item in items) {
      references.add(item.id);
    }

    return references;
  }

  /// This method can be used to access a ```ShareReference``` in ```items``` by its id.
  /// * Returns ```null``` if ```id``` was not found.
  ShareReference? getById({required String id}) {
    for (final ShareReference item in items) {
      if (item.id == id) return item;
    }

    return null;
  }

  /// This method can be used to check if a payment was made only for the paying member.
  bool isSelfPaymentOnly({required String paidById}) {
    for (final ShareReference share in items) {
      if (share.id != paidById) return false;
    }

    return true;
  }

  /// This getter can be used to return a ```ShareReferences``` object where ```values``` set to ```0.0``` were removed.
  ShareReferences get getRemoveZeroShares {
    // Init helper list.
    List<ShareReference> shareReferences = [];

    // Go through references and add relevant data.
    for (final ShareReference item in items) {
      if (item.valueAsDouble == 0.0) continue;
      shareReferences.add(item);
    }

    return ShareReferences(
      items: shareReferences,
    );
  }

  /// This getter can be used to get the combined amount of all shares.
  double get getCombinedSharedAmount {
    // Init helper.
    double combined = 0.0;

    for (final ShareReference item in items) {
      combined = combined + item.valueAsDouble;
    }

    return combined;
  }

  /// This method can be used to get an indication about whether or not a specified ```shareReference``` exists in ```items```.
  bool shareExists({required ShareReference shareReference}) {
    // Go through shareReferences.
    for (final ShareReference item in items) {
      if (item.id == shareReference.id) return true;
    }

    return false;
  }

  /// This method can be used to conduct error corrections that might occur on import.
  ShareReferences conductImportRoundingErrorCorrection({required double difference}) {
    // Filter out members with a value of 0
    final List<ShareReference> validShares = items.where((item) => item.valueAsDouble != 0).toList();

    // Select a random Share.
    final Random random = Random();
    final int randomIndex = random.nextInt(validShares.length);
    final ShareReference selected = validShares[randomIndex];

    // Update selected share.
    final ShareReference updatedShareReference = selected.copyWith(
      value: (selected.valueAsDouble + difference).toString(),
    );

    // Update ShareReferences.
    final ShareReferences updated = updateShareReference(updatedShareReference: updatedShareReference);

    return updated;
  }

  /// This method can be used to add a shareReference to ```items```.
  ShareReferences addShareReference({required ShareReference shareReference}) {
    // Init helper list.
    List<ShareReference> shareReferences = [];

    // Go through references and add relevant data.
    for (final ShareReference item in items) {
      shareReferences.add(item);
    }

    // Add specified shareReference.
    shareReferences.add(shareReference);

    return ShareReferences(
      items: shareReferences,
    );
  }

  /// This method can be used to remove a shareReference from ```items```.
  ShareReferences remove({required String id}) {
    // Init helper list.
    List<ShareReference> shareReferences = [];

    // Go through references and add relevant data.
    for (final ShareReference item in items) {
      // * Exclude specified shareReference.
      if (item.id == id) continue;

      shareReferences.add(item);
    }

    return ShareReferences(
      items: shareReferences,
    );
  }

  /// This method can be used to update a shareReference in ```items```.
  ShareReferences updateShareReference({required ShareReference updatedShareReference}) {
    // Init helper list.
    List<ShareReference> shareReferences = [];

    // Go through references and add relevant data.
    for (final ShareReference item in items) {
      // * insert specified member.
      if (item.id == updatedShareReference.id) {
        shareReferences.add(updatedShareReference);
        continue;
      }

      shareReferences.add(item);
    }

    return ShareReferences(
      items: shareReferences,
    );
  }

  /// This method can be used to create a ```ShareReferences``` object with equal amount distribution.
  ShareReferences equalShareDistribution({required double amount}) {
    // Init helper list.
    List<ShareReference> shareReferences = [];

    // Go through references and add relevant data.
    for (final ShareReference item in items) {
      shareReferences.add(item.copyWith(
        value: amount.toString(),
      ));
    }

    return ShareReferences(
      items: shareReferences,
    );
  }

  // ######################################
  // Database
  // ######################################

  /// Convert a ```ShareReferences``` object to a ```DbShareReferences``` object.
  List<DbShareReference> toSchema() {
    // Init helper.
    List<DbShareReference> helper = [];

    // Populate list with data.
    for (final ShareReference item in items) {
      // Convert object.
      final DbShareReference dbShareReference = item.toSchema();

      // Add to helper.
      helper.add(dbShareReference);
    }

    return helper;
  }

  /// Convert a ```DbShareReferences``` object to a ```ShareReferences``` object.
  static ShareReferences? fromSchema({required List<DbShareReference>? schema}) {
    // Do null check.
    if (schema == null) return null;

    // Initialize helper.
    List<ShareReference> helper = [];

    // Add data to list.
    for (final DbShareReference item in schema) {
      // Convert object.
      final ShareReference shareReference = ShareReference.fromSchema(schema: item);

      // Add to helper.
      helper.add(shareReference);
    }

    return ShareReferences(
      items: helper,
    );
  }

  // ######################################
  // Cloud
  // ######################################

  /// Convert a ```ShareReferences``` object to JSON.
  List<Map<String, dynamic>> toCloudObject() {
    // Initialize list.
    List<Map<String, dynamic>> list = [];

    // Populate list with data.
    for (final ShareReference item in items) {
      list.add(item.toCloudObject());
    }

    return list;
  }

  /// Convert a ```ShareReferences``` object from JSON.
  static ShareReferences fromCloudObject(documents) {
    // Initialize members list.
    List<ShareReference> shareReferences = [];

    // Add data to list.
    for (final Map<String, dynamic> document in documents) {
      // Add share reference.
      shareReferences.add(ShareReference.fromCloudObject(document));
    }

    return ShareReferences(
      items: shareReferences,
    );
  }

  ShareReferences copyWith({
    List<ShareReference>? items,
  }) {
    return ShareReferences(
      items: items ?? this.items,
    );
  }
}
