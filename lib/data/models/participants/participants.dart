import 'package:equatable/equatable.dart';

// Schemas.
import '/data/models/participants/schemas/db_participant.dart';

// Models.
import '/data/models/participants/participant.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

class Participants extends Equatable {
  final List<Participant> items;

  const Participants({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  /// Initialize a new [Participants] object.
  factory Participants.initial() {
    return const Participants(
      items: [],
    );
  }

  /// This getter can be used to access [Participants] sorted alphabetically.
  /// * names get compared in lower case
  Participants get sortAtoZ {
    // Copy current items.
    final Participants sorted = Participants(
      items: items,
    );

    // Sort groups.
    sorted.items.sort(
      (a, b) => a.participantName.toLowerCase().compareTo(b.participantName.toLowerCase()),
    );

    return sorted;
  }

  /// This method can be used to turn Participants into PickerItems.
  /// * Items are sorted from a to z.
  PickerItems toPickerItems() {
    // Init helper list.
    List<PickerItem> list = [];

    for (final Participant participant in items) {
      // Create ChipItem.
      final PickerItem pickerItem = PickerItem(
        id: participant.participantId,
        label: participant.participantName,
      );

      // Add item to list.
      list.add(pickerItem);
    }

    // Create sorted ChipsItems object.
    final PickerItems pickerItems = PickerItems(
      items: list,
    ).sortAtoZ;

    return pickerItems;
  }

  /// This method can be used to check if a participant exists.
  bool participantExists({required Participant participant}) {
    for (final Participant item in items) {
      if (item.participantId == participant.participantId) return true;
    }

    return false;
  }

  /// This method can be used to access a participant by its id.
  /// * returns ```null``` if this ```id``` was not found or ```id.isEmpty == true```
  Future<Participant?> byId({required String participantId}) async {
    // Performance enhance.
    if (participantId.isEmpty) return null;

    for (final Participant participant in items) {
      if (participant.participantId == participantId) return participant;
    }

    return null;
  }

  /// This method can be used to add a participant to ```items```.
  Participants add({required Participant participant}) {
    // Init helper list.
    List<Participant> participants = [];

    // Go through items and add relevant data.
    for (final Participant item in items) {
      participants.add(item);
    }

    // Add specified participant.
    participants.add(participant);

    return Participants(
      items: participants,
    );
  }

  /// This method can be used to update a ```Participant``` in ```items```.
  /// * Returns ```null``` if ```participantId``` was not found in ```items```.
  Participants? update({required Participant updatedParticipant}) {
    // Init helpers.
    List<Participant> helper = [];
    bool idFound = false;

    // Go through items and add relevant data.
    for (final Participant item in items) {
      // * insert specified group.
      if (item.participantId == updatedParticipant.participantId) {
        // Add updated object.
        helper.add(updatedParticipant);

        // Notify flag.
        idFound = true;

        continue;
      }

      helper.add(item);
    }

    // Return error if update was conducted on an id that does not exist in items.
    if (idFound == false) return null;

    return Participants(items: helper);
  }

  /// This method can be used to remove a participant from ```items```.
  Participants remove({required Participant participant}) {
    // Init helper list.
    List<Participant> participants = [];

    // Go through items and add relevant data.
    for (final Participant item in items) {
      // * exclude specified participant.
      if (item.participantId == participant.participantId) continue;

      participants.add(item);
    }

    return Participants(
      items: participants,
    );
  }

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```DbParticipants``` object to a ```Participants``` object.
  static Participants fromSchema({required List<DbParticipant> schema}) {
    // Helper.
    List<Participant> helper = [];

    for (final DbParticipant dbParticipant in schema) {
      // Convert from schema.
      final Participant participant = Participant.fromSchema(schema: dbParticipant);

      // Add to helper.
      helper.add(participant);
    }

    return Participants(items: helper);
  }

  // --------------------------------------
  // - Cloud
  // --------------------------------------

  /// Convert a ```Participants``` object from JSON.
  static Participants fromCloudObject(documents) {
    // Initialize list.
    List<Participant> helper = [];

    // Add data to list.
    for (final dynamic document in documents) {
      // Add member.
      helper.add(Participant.fromCloudObject(document));
    }

    return Participants(
      items: helper,
    );
  }

  // --------------------------------------
  // ------------ CopyWith ----------------
  // --------------------------------------

  Participants copyWith({
    List<Participant>? items,
  }) {
    return Participants(
      items: items ?? this.items,
    );
  }
}
