import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// User with Settings and Labels.
import '/main.dart';

// Schemas.
import '/data/models/groups/schemas/db_group.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';
import '/data/models/group_prefs/group_prefs.dart';
import '/data/models/invite_specs/invite_specs.dart';

class Group extends Equatable {
  final String groupId;
  final String groupType;

  /// This indicates whether or not app password is needed to view this group or its entries.
  final bool isProtected;

  /// This indicates whether or not entries in a group should be encrypted.
  final bool isEncrypted;

  final DateTime createdAtInUtc;
  final DateTime editedAtInUtc;

  final String groupName;
  final String groupDescription;

  final String groupCreator;

  /// This can be used to indicate if new entries/subgroups can be added or not.
  final bool isLocked;

  /// This variable references ```ModelEntries``` available to everyone in this group.
  final List<String> commonModelEntries;

  /// This variable indicates if users can only add ```ModelEntries``` defined in ```commonModelEntries```.
  final bool isRestrictedToCommon;

  /// A reference to the initial group in a group to subgroup path.
  final String rootGroupReference;

  /// A reference to the last group in a group to subgroup path.
  final String parentGroupReference;

  final String participantReference;

  final String defaultCurrencyCode;

  final GroupPrefs groupPrefs;

  // --------- Shared group ---------
  final String accessPin;
  final String alias;
  final InviteSpecs inviteSpecs;

  final String editPolicy;
  final List<String> editPermissions;

  final String deletePolicy;
  final List<String> deletePermissions;

  final String subgroupAddPolicy;
  final List<String> subgroupAddPermissions;

  final String entryAddPolicy;
  final List<String> entryAddPermissions;

  final String entryEditPolicy;
  final List<String> entryEditPermissions;

  final String entryDeletePolicy;
  final List<String> entryDeletePermissions;

  const Group({
    required this.groupId,
    required this.groupType,
    required this.isProtected,
    required this.isEncrypted,
    required this.createdAtInUtc,
    required this.editedAtInUtc,
    required this.groupName,
    required this.groupDescription,
    required this.groupCreator,
    required this.rootGroupReference,
    required this.parentGroupReference,
    required this.isLocked,
    required this.commonModelEntries,
    required this.isRestrictedToCommon,
    required this.participantReference,
    required this.defaultCurrencyCode,
    required this.groupPrefs,
    // --------- Shared group ---------
    required this.accessPin,
    required this.alias,
    required this.inviteSpecs,
    required this.editPolicy,
    required this.editPermissions,
    required this.deletePolicy,
    required this.deletePermissions,
    required this.subgroupAddPolicy,
    required this.subgroupAddPermissions,
    required this.entryAddPolicy,
    required this.entryAddPermissions,
    required this.entryEditPolicy,
    required this.entryEditPermissions,
    required this.entryDeletePolicy,
    required this.entryDeletePermissions,
  });

  // #################################################
  // Reference types
  // #################################################

  /// Reference identification: group.
  /// ```dart
  /// static const String referenceType = 'group';
  /// ```
  static const String referenceTypeGroup = 'group';

  /// Reference identification: subgroup.
  /// ```dart
  /// static const String referenceTypeSubgroup = 'subgroup';
  /// ```
  static const String referenceTypeSubgroup = 'subgroup';

  // #################################################
  // Group types
  // #################################################

  /// Identification for group type: local_group.
  /// ```dart
  /// static const String groupTypeLocal = 'local_group';
  /// ```
  static const String groupTypeLocal = 'local_group';

  /// Identification for group type: local_subgroup.
  /// ```dart
  /// static const String groupTypeLocalSub = 'local_subgroup';
  /// ```
  static const String groupTypeLocalSub = 'local_subgroup';

  /// Identification for group type: shared_group.
  /// ```dart
  /// static const String groupTypeShared = 'shared_group';
  /// ```
  static const String groupTypeShared = 'shared_group';

  /// Identification for group type: shared_subgroup.
  /// ```dart
  /// static const String groupTypeSharedSub = 'shared_subgroup';
  /// ```
  static const String groupTypeSharedSub = 'shared_subgroup';

  // #################################################
  // Sort types
  // #################################################

  /// Identification for alphabetical sorting.
  /// ```dart
  /// static const String sortAtoZ = 'sort_a_to_z';
  /// ```
  static const String sortAtoZ = 'sort_a_to_z';

  /// Identification for sorting by most recent first.
  /// ```dart
  /// static const String sortByMostRecent = 'sort_by_most_recent';
  /// ```
  static const String sortByMostRecent = 'sort_by_most_recent';

  // #################################################
  // Display types
  // #################################################

  /// Identification for displaying subgroups in a horizontal list.
  /// ```dart
  /// static const String horizontal = 'horizontal';
  /// ```
  static const String horizontal = 'horizontal';

  /// Identification for displaying subgroups in a vertical list.
  /// ```dart
  /// static const String vertical = 'vertical';
  /// ```
  static const String vertical = 'vertical';

  // #################################################
  // # Add, Edit and Remove policies
  // #################################################

  /// Identification for policy: root_group_owner.
  /// ```dart
  /// static const String policyRootGroupOwner = 'root_group_owner';
  /// ```
  static const String permissionRootGroupOwner = 'root_group_owner';

  /// Identification for policy: group_creator.
  /// ```dart
  /// static const String permissionGroupCreator = 'group_creator';
  /// ```
  static const String permissionGroupCreator = 'group_creator';

  /// Identification for policy: entry_creator.
  /// ```dart
  /// static const String permissionEntryCreator = 'entry_creator';
  /// ```
  static const String permissionEntryCreator = 'entry_creator';

  /// Identification for policy: everyone.
  /// ```dart
  /// static const String permissionEveryone = 'everyone';
  /// ```
  static const String permissionEveryone = 'everyone';

  /// Identification for policy: none.
  /// ```dart
  /// static const String permissionNone = 'none';
  /// ```
  static const String permissionNone = 'none';

  // TODO: Group permission restricted (new_feature).
  /// Identification for policy: restricted.
  /// ```dart
  /// static const String permissionRestricted = 'restricted';
  /// ```
  static const String permissionRestricted = 'restricted';

  /// Get ```PickerItems``` for entry permissions.
  /// * ```id = policy```
  /// * Set ```includeNone``` to ```false``` if policy ```permissionNone``` should not be displayed.
  /// * Set ```includeEntryCreator``` to ```false``` if policy ```permissionEntryCreator``` should not be displayed.
  /// * Set ```userIsRootGroupCreator``` to ```true``` to not display ```permissionGroupCreator``` and to change the label of ```permissionRootGroupOwner```.
  static PickerItems permissionsAsPickerItems({required bool includeNone, required bool includeEntryCreator, required bool userIsRootGroupCreator}) {
    // Create items.
    final List<PickerItem> items = [
      PickerItem(
        id: permissionRootGroupOwner,
        label: userIsRootGroupCreator ? labels.basicLabelsGroupCreator() : labels.basicLabelsRootGroupOwner(),
      ),
      if (userIsRootGroupCreator == false)
        PickerItem(
          id: permissionGroupCreator,
          label: labels.basicLabelsGroupCreator(),
        ),
      if (includeEntryCreator)
        PickerItem(
          id: permissionEntryCreator,
          label: labels.basicLabelsEntryCreator(),
        ),
      PickerItem(
        id: permissionEveryone,
        label: labels.basicLabelsEveryone(),
      ),
      if (includeNone)
        PickerItem(
          id: permissionNone,
          label: labels.basicLabelsNone(),
        ),
    ];

    return PickerItems(items: items);
  }

  /// Get [PickerItems] for all group types.
  /// * id = groupType
  /// * translates labels
  static PickerItems groupTypesAsPickerItems() {
    // Create items.
    final List<PickerItem> items = [
      PickerItem(
        id: groupTypeLocal,
        label: labels.basicLabelsLocalGroups(),
        infoMessage: labels.groupTypeLocalGroupInfoMessage(),
      ),
      PickerItem(
        id: groupTypeShared,
        label: labels.basicLabelsSharedGroups(),
        infoMessage: labels.groupTypeSharedGroupInfoMessage(),
      ),
    ];

    return PickerItems(items: items);
  }

  @override
  List<Object?> get props => [
        groupId,
        groupType,
        isProtected,
        isEncrypted,
        createdAtInUtc,
        editedAtInUtc,
        groupName,
        groupDescription,
        groupCreator,
        parentGroupReference,
        isLocked,
        commonModelEntries,
        isRestrictedToCommon,
        participantReference,
        defaultCurrencyCode,
        groupPrefs,
        // --------- Shared group ---------
        accessPin,
        alias,
        inviteSpecs,
        editPolicy,
        editPermissions,
        deletePolicy,
        deletePermissions,
        subgroupAddPolicy,
        subgroupAddPermissions,
        entryAddPolicy,
        entryAddPermissions,
        entryEditPolicy,
        entryEditPermissions,
        entryDeletePolicy,
        entryDeletePermissions,
      ];

  /// Initialize a new ```Group``` object.
  factory Group.initial() {
    // Init now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    return Group(
      groupId: const Uuid().v4(),
      groupType: groupTypeLocal,
      isProtected: false,
      isEncrypted: false,
      createdAtInUtc: nowInUtc,
      editedAtInUtc: nowInUtc,
      groupName: '',
      groupDescription: '',
      groupCreator: '',
      rootGroupReference: '',
      parentGroupReference: '',
      isLocked: false,
      commonModelEntries: const [],
      isRestrictedToCommon: false,
      participantReference: '',
      defaultCurrencyCode: '',
      groupPrefs: GroupPrefs.initial(),
      // --------- Shared group ---------
      accessPin: '',
      alias: '',
      inviteSpecs: InviteSpecs.initial(),
      editPolicy: permissionRootGroupOwner,
      editPermissions: const [],
      deletePolicy: permissionRootGroupOwner,
      deletePermissions: const [],
      subgroupAddPolicy: permissionRootGroupOwner,
      subgroupAddPermissions: const [],
      entryAddPolicy: permissionRootGroupOwner,
      entryAddPermissions: const [],
      entryEditPolicy: permissionRootGroupOwner,
      entryEditPermissions: const [],
      entryDeletePolicy: permissionRootGroupOwner,
      entryDeletePermissions: const [],
    );
  }

  /// This getter can be used to access created at in readable format.
  String get getCreatedAt {
    // Convert to local.
    final DateTime converted = createdAtInUtc.toLocal();

    return '${DateFormat("yyyy-MM-dd").format(converted)} ${labels.basicLabelsAt()} ${DateFormat("HH:mm").format(converted)}';
  }

  /// This getter can be used to access edited at in readable format.
  String get getEditedAt {
    // Convert to local.
    final DateTime converted = editedAtInUtc.toLocal();

    return '${DateFormat("yyyy-MM-dd").format(converted)} ${labels.basicLabelsAt()} ${DateFormat("HH:mm").format(converted)}';
  }

  /// This getter indicates if this is a local group type.
  bool get getIsLocalGroupType {
    if (groupType == groupTypeLocal) return true;
    return false;
  }

  /// This getter indicates if this is a local subgroup type.
  bool get getIsLocalSubgroupType {
    if (groupType == groupTypeLocalSub) return true;
    return false;
  }

  /// This getter indicates if this is a shared group type.
  bool get getIsSharedGroupType {
    if (groupType == groupTypeShared) return true;
    return false;
  }

  /// This getter indicates if this is a shared subgroup type.
  bool get getIsSharedSubgroupType {
    if (groupType == groupTypeSharedSub) return true;
    return false;
  }

  /// This getter can be used to check if current user is the group creator.
  bool get getUserIsGroupCreator {
    if (user.userId == groupCreator) return true;
    return false;
  }

  /// This getter can be used to return the correct label for a chosen subgroup add policy.
  String get getSubgroupAddPolicyInfoMessage {
    if (subgroupAddPolicy == permissionRootGroupOwner) return labels.rootGroupCreatorAddSubgroupPolicyInfoMessage();
    if (subgroupAddPolicy == permissionGroupCreator) return labels.groupCreaterAddSubgroupPolicyInfoMessage();
    if (subgroupAddPolicy == permissionEveryone) return labels.groupEveryoneAddSubgroupPolicyInfoMessage();
    if (subgroupAddPolicy == permissionNone) return labels.groupNoneAddSubgroupPolicyInfoMessage();
    if (subgroupAddPolicy == permissionRestricted) return labels.groupPermittedUserAddSubgroupPolicyInfoMessage();

    // Crash app if none of the above were selected.
    throw Failure.genericError();
  }

  /// This getter can be used to return the correct label for a chosen entry add policy.
  String get getEntryAddPolicyInfoMessage {
    if (entryAddPolicy == permissionRootGroupOwner) return labels.rootGroupCreatorAddEntryPolicyInfoMessage();
    if (entryAddPolicy == permissionGroupCreator) return labels.groupCreaterAddEntryPolicyInfoMessage();
    if (entryAddPolicy == permissionEveryone) return labels.groupEveryoneAddEntryPolicyInfoMessage();
    if (entryAddPolicy == permissionNone) return labels.groupNoneAddEntryPolicyInfoMessage();
    if (entryAddPolicy == permissionRestricted) return labels.groupPermittedUserAddEntryPolicyInfoMessage();

    // Crash app if none of the above were selected.
    throw Failure.genericError();
  }

  /// This getter can be used to return the correct label for a chosen entry edit policy.
  String get getEntryEditPolicyInfoMessage {
    if (entryEditPolicy == permissionRootGroupOwner) return labels.rootGroupCreatorEditPolicyInfoMessage();
    if (entryEditPolicy == permissionGroupCreator) return labels.groupCreaterEditPolicyInfoMessage();
    if (entryEditPolicy == permissionEntryCreator) return labels.entryCreatorEditPolicyInfoMessage();
    if (entryEditPolicy == permissionEveryone) return labels.groupEveryoneEditPolicyInfoMessage();
    if (entryEditPolicy == permissionNone) return labels.groupNoneEditPolicyInfoMessage();
    if (entryEditPolicy == permissionRestricted) return labels.groupPermittedUserEditPolicyInfoMessage();

    // Crash app if none of the above were selected.
    throw Failure.genericError();
  }

  /// This getter can be used to return the correct label for a chosen entry delete policy.
  String get getEntryDeletePolicyInfoMessage {
    if (entryDeletePolicy == permissionRootGroupOwner) return labels.rootGroupCreatorDeletePolicyInfoMessage();
    if (entryDeletePolicy == permissionGroupCreator) return labels.groupCreaterDeletePolicyInfoMessage();
    if (entryDeletePolicy == permissionEntryCreator) return labels.entryCreatorDeletePolicyInfoMessage();
    if (entryDeletePolicy == permissionEveryone) return labels.groupEveryoneDeletePolicyInfoMessage();
    if (entryDeletePolicy == permissionNone) return labels.groupNoneDeletePolicyInfoMessage();
    if (entryDeletePolicy == permissionRestricted) return labels.groupPermittedUserDeletePolicyInfoMessage();

    // Crash app if none of the above were selected.
    throw Failure.genericError();
  }

  /// This getter can be used to return the correct label for a chosen shared group edit policy.
  String get getSharedGroupEditPolicyInfoMessage {
    if (editPolicy == permissionRootGroupOwner) return labels.rootGroupCreatorEditSubgroupPolicyInfoMessage();
    if (editPolicy == permissionGroupCreator) return labels.groupCreaterEditSubgroupPolicyInfoMessage();
    if (editPolicy == permissionEveryone) return labels.groupEveryoneEditSubgroupPolicyInfoMessage();
    if (editPolicy == permissionNone) return labels.groupNoneEditSubgroupPolicyInfoMessage();
    if (editPolicy == permissionRestricted) return labels.groupPermittedUserEditSubgroupPolicyInfoMessage();

    // Crash app if none of the above were selected.
    throw Failure.genericError();
  }

  /// This getter can be used to return the correct label for a chosen group delete policy.
  String get getSharedGroupDeletePolicyInfoMessage {
    if (deletePolicy == permissionRootGroupOwner) return labels.rootGroupCreatorDeleteSubgroupPolicyInfoMessage();
    if (deletePolicy == permissionGroupCreator) return labels.groupCreaterDeleteSubgroupPolicyInfoMessage();
    if (deletePolicy == permissionEveryone) return labels.groupEveryoneDeleteSubgroupPolicyInfoMessage();
    if (deletePolicy == permissionNone) return labels.groupNoneDeleteSubgroupPolicyInfoMessage();
    if (deletePolicy == permissionRestricted) return labels.groupPermittedUserDeleteSubgroupPolicyInfoMessage();

    // Crash app if none of the above were selected.
    throw Failure.genericError();
  }

  /// This getter can be used to return labels for the different group types.
  /// * Returns ```""``` on unknown group type.
  String get getGroupTypeLabel {
    if (groupType == groupTypeLocal) return labels.groupTypeLocalGroup();
    if (groupType == groupTypeLocalSub) return labels.groupTypeLocalSubgroup();
    if (groupType == groupTypeShared) return labels.groupTypeSharedGroup();
    if (groupType == groupTypeSharedSub) return labels.groupTypeSharedSubgroup();

    return '';
  }

  /// This getter can be used to access the correct group reference type.
  /// * Returns an empty String if ```groupType``` is unknown.
  String get getReferenceType {
    if (groupType == groupTypeLocal || groupType == groupTypeShared) return referenceTypeGroup;
    if (groupType == groupTypeLocalSub || groupType == groupTypeSharedSub) return referenceTypeSubgroup;

    return '';
  }

  /// This method can be used to determine if current user has edit permissions for selected group.
  bool userHasGroupEditPermissions({required bool isShared, required String topLevelGroupOwner}) {
    // * User always has edit permission for local groups.
    if (isShared == false) return true;

    // Convenience variables.
    final bool currentUserIsRootGroupOwner = topLevelGroupOwner == user.userId;
    final bool currentUserIsGroupCreator = groupCreator == user.userId;

    // * Only the root group owner can edit this group.
    if (editPolicy == permissionRootGroupOwner) {
      if (currentUserIsRootGroupOwner) return true;
    }

    // * Only the group creator can edit this group.
    if (editPolicy == permissionGroupCreator) {
      if (currentUserIsGroupCreator) return true;
    }

    // * Everyone can edit this group.
    if (editPolicy == permissionEveryone) return true;

    // * No one can edit this group.
    if (editPolicy == permissionNone) return false;

    // * Only selected users can this group.
    if (editPolicy == permissionRestricted) {
      if (editPermissions.contains(user.userId)) return true;
    }

    return false;
  }

  /// This method can be used to determine if current user has delete permission for selected group.
  bool userHasGroupDeletePermissions({required bool isShared, required String topLevelGroupOwner}) {
    // * User always has delete permission for local groups.
    if (isShared == false) return true;

    // Convenience variables.
    final bool currentUserIsRootGroupOwner = topLevelGroupOwner == user.userId;
    final bool currentUserIsGroupCreator = groupCreator == user.userId;

    // * Only the root group owner can delete selected group.
    if (deletePolicy == permissionRootGroupOwner) {
      if (currentUserIsRootGroupOwner) return true;
    }

    // * Only the group creator can delete selected group.
    if (deletePolicy == permissionGroupCreator) {
      if (currentUserIsGroupCreator) return true;
    }

    // * Everyone can delete selected group.
    if (deletePolicy == permissionEveryone) return true;

    // * No one can delete selected group.
    if (deletePolicy == permissionNone) return false;

    // * Only selected users can selected group.
    if (deletePolicy == permissionRestricted) {
      if (deletePermissions.contains(user.userId)) return true;
    }

    return false;
  }

  /// This method can be used to determine if current user has subgroup add permissions.
  bool userHasSubgroupAddPermissions({required bool isShared, required String topLevelGroupOwner}) {
    // * User always has add permission for local groups.
    if (isShared == false) return true;

    // Convenience variables.
    final bool currentUserIsRootGroupOwner = topLevelGroupOwner == user.userId;
    final bool currentUserIsGroupCreator = groupCreator == user.userId;

    // * Only the root group owner can add subgroups.
    if (subgroupAddPolicy == permissionRootGroupOwner) {
      if (currentUserIsRootGroupOwner) return true;
    }

    // * Only the group creator can add subgroups.
    if (subgroupAddPolicy == permissionGroupCreator) {
      if (currentUserIsGroupCreator) return true;
    }

    // * Everyone can add subgroups.
    if (subgroupAddPolicy == permissionEveryone) return true;

    // * No one can add subgroups.
    if (subgroupAddPolicy == permissionNone) return false;

    // * Only selected users can add.
    if (subgroupAddPolicy == permissionRestricted) {
      if (subgroupAddPermissions.contains(user.userId)) return true;
    }

    return false;
  }

  /// This method can be used to determine if current user has entry add permissions.
  bool userHasEntryAddPermissions({required bool isShared, required String topLevelGroupOwner}) {
    // * User always has add permission for local groups.
    if (isShared == false) return true;

    // Convenience variables.
    final bool currentUserIsRootGroupOwner = topLevelGroupOwner == user.userId;
    final bool currentUserIsGroupCreator = groupCreator == user.userId;

    // * Only the root group owner can add entries.
    if (entryAddPolicy == permissionRootGroupOwner) {
      if (currentUserIsRootGroupOwner) return true;
    }

    // * Only the group creator can add entries.
    if (entryAddPolicy == permissionGroupCreator) {
      if (currentUserIsGroupCreator) return true;
    }

    // * Everyone can add entries.
    if (entryAddPolicy == permissionEveryone) return true;

    // * No one can add entries.
    if (entryAddPolicy == permissionNone) return false;

    // * Only selected users can add.
    if (entryAddPolicy == permissionRestricted) {
      if (entryAddPermissions.contains(user.userId)) return true;
    }

    return false;
  }

  /// This method can be used to determine if current user has edit permissions for specified entry.
  bool userHasEntryEditPermissions({required bool isShared, required String entryCreator, required String topLevelGroupOwner}) {
    // * User always has add permission for local groups.
    if (isShared == false) return true;

    // Convenience variables.
    final bool currentUserIsRootGroupOwner = topLevelGroupOwner == user.userId;
    final bool currentUserIsGroupCreator = groupCreator == user.userId;
    final bool currentUserIsEntryCreator = entryCreator == user.userId;

    // * Only the root group owner can edit entries.
    if (entryEditPolicy == permissionRootGroupOwner) {
      if (currentUserIsRootGroupOwner) return true;
    }

    // * Only the group creator can edit entries.
    if (entryEditPolicy == permissionGroupCreator) {
      if (currentUserIsGroupCreator) return true;
    }

    // * Only the entry creator can edit entries.
    if (entryEditPolicy == permissionEntryCreator) {
      if (currentUserIsEntryCreator) return true;
    }

    // * Everyone can edit entries.
    if (entryEditPolicy == permissionEveryone) return true;

    // * No one can edit entries.
    if (entryEditPolicy == permissionNone) return false;

    // * Only selected users can edit.
    if (entryEditPolicy == permissionRestricted) {
      if (entryEditPermissions.contains(user.userId)) return true;
    }

    return false;
  }

  /// This method can be used to determine if current user has delete permission for specified entry.
  bool userHasEntryDeletePermissions({required bool isShared, required String entryCreator, required String topLevelGroupOwner}) {
    // * User always has delete permission for local groups.
    if (isShared == false) return true;

    // Convenience variables.
    final bool currentUserIsRootGroupOwner = topLevelGroupOwner == user.userId;
    final bool currentUserIsGroupCreator = groupCreator == user.userId;
    final bool currentUserIsEntryCreator = entryCreator == user.userId;

    // * Only the root group owner can delete entries.
    if (entryDeletePolicy == permissionRootGroupOwner) {
      if (currentUserIsRootGroupOwner) return true;
    }

    // * Only the group creator can delete entries.
    if (entryDeletePolicy == permissionGroupCreator) {
      if (currentUserIsGroupCreator) return true;
    }

    // * Only the entry creator can delete entries.
    if (entryDeletePolicy == permissionEntryCreator) {
      if (currentUserIsEntryCreator) return true;
    }

    // * Everyone can delete entries.
    if (entryDeletePolicy == permissionEveryone) return true;

    // * No one can delete entries.
    if (entryDeletePolicy == permissionNone) return false;

    // * Only selected users can delete.
    if (entryDeletePolicy == permissionRestricted) {
      if (entryDeletePermissions.contains(user.userId)) return true;
    }

    return false;
  }

  // #################################################
  // Database
  // #################################################

  /// Convert a ```Group``` object to a ```DbGroup``` object.
  DbGroup toSchema() {
    return DbGroup(
      groupId: groupId,
      groupType: groupType,
      isProtected: isProtected,
      isEncrypted: isEncrypted,
      createdAtInUtc: createdAtInUtc.millisecondsSinceEpoch,
      editedAtInUtc: editedAtInUtc.millisecondsSinceEpoch,
      groupName: groupName,
      groupDescription: groupDescription,
      groupCreator: groupCreator,
      isLocked: isLocked,
      commonModelEntries: commonModelEntries,
      isRestrictedToCommon: isRestrictedToCommon,
      rootGroupReference: rootGroupReference,
      parentGroupReference: parentGroupReference,
      participantReference: participantReference,
      defaultCurrencyCode: defaultCurrencyCode,
    );
  }

  /// Convert a ```DbGroup``` object to a ```Group``` object.
  static Group fromSchema({required DbGroup schema}) {
    return Group.initial().copyWith(
      groupId: schema.groupId,
      groupType: schema.groupType,
      isProtected: schema.isProtected,
      isEncrypted: schema.isEncrypted,
      createdAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.createdAtInUtc, isUtc: true),
      editedAtInUtc: DateTime.fromMillisecondsSinceEpoch(schema.editedAtInUtc, isUtc: true),
      groupName: schema.groupName,
      groupDescription: schema.groupDescription,
      groupCreator: schema.groupCreator,
      rootGroupReference: schema.rootGroupReference,
      parentGroupReference: schema.parentGroupReference,
      isLocked: schema.isLocked,
      commonModelEntries: schema.commonModelEntries,
      isRestrictedToCommon: schema.isRestrictedToCommon,
      participantReference: schema.participantReference,
      defaultCurrencyCode: schema.defaultCurrencyCode,
    );
  }

  // #################################################
  // Cloud
  // #################################################

  /// Encode a ```Group``` object to JSON suitable for cloud storage.
  Map<String, dynamic> toCloudObject() {
    return {
      'group_name': groupName,
      'group_description': groupDescription,
      'is_protected': isProtected,
      'group_type': groupType,
      'group_creator': groupCreator,
      'is_locked': isLocked,
      'common_model_entries': commonModelEntries,
      'is_restricted_to_common': isRestrictedToCommon,
      'default_currency_code': defaultCurrencyCode,
      'edit_policy': editPolicy,
      'edit_permissions': editPermissions,
      'delete_policy': deletePolicy,
      'delete_permissions': deletePermissions,
      'subgroup_add_policy': subgroupAddPolicy,
      'subgroup_add_permissions': subgroupAddPermissions,
      'entry_add_permissions': entryAddPermissions,
      'entry_add_policy': entryAddPolicy,
      'entry_edit_permissions': editPermissions,
      'entry_edit_policy': entryEditPolicy,
      'entry_delete_policy': entryDeletePolicy,
      'entry_delete_permissions': entryDeletePermissions,
      'participant_reference': participantReference,
      'root_group_reference': rootGroupReference,
      'parent_group_reference': parentGroupReference,
      'access_pin': accessPin,
      'invite_specs': inviteSpecs.toCloudObject(),
    };
  }

  /// Decode a ```Group``` object from JSON provided by cloud service.
  static Group fromCloudObject(data) {
    return Group(
      groupId: data["_id"],
      groupType: data["group_type"],
      isProtected: data["is_protected"],
      isEncrypted: false, // * Cloud objects are not locally encrypted.
      groupName: data["group_name"],
      groupDescription: data["group_description"],
      groupCreator: data["group_creator"],
      isLocked: data["is_locked"],
      commonModelEntries: data["common_model_entries"] == null ? const [] : List<String>.from(data["common_model_entries"]),
      isRestrictedToCommon: data["is_restricted_to_common"],
      defaultCurrencyCode: data["default_currency_code"],
      createdAtInUtc: DateTime.parse(data["created_at_in_utc"]),
      editedAtInUtc: DateTime.parse(data["edited_at_in_utc"]),
      rootGroupReference: data["root_group_reference"],
      parentGroupReference: data["parent_group_reference"],
      participantReference: data["participant_reference"],
      groupPrefs: GroupPrefs.fromCloudObject(data),
      accessPin: data["access_pin"] ?? '',
      alias: data["alias"],
      editPolicy: data["edit_policy"],
      editPermissions: data["edit_permissions"] == null ? const [] : List<String>.from(data["edit_permissions"]),
      deletePolicy: data["delete_policy"],
      deletePermissions: data["delete_permissions"] == null ? const [] : List<String>.from(data["delete_permissions"]),
      subgroupAddPolicy: data["subgroup_add_policy"],
      subgroupAddPermissions: data["subgroup_add_permissions"] == null ? const [] : List<String>.from(data["subgroup_add_permissions"]),
      entryAddPolicy: data["entry_add_policy"],
      entryAddPermissions: data["entry_add_permissions"] == null ? const [] : List<String>.from(data["entry_add_permissions"]),
      entryEditPolicy: data["entry_edit_policy"],
      entryEditPermissions: data["entry_edit_permissions"] == null ? const [] : List<String>.from(data["entry_edit_permissions"]),
      entryDeletePolicy: data["entry_delete_policy"],
      entryDeletePermissions: data["entry_delete_permissions"] == null ? const [] : List<String>.from(data["entry_delete_permissions"]),
      inviteSpecs: InviteSpecs.fromCloudObject(data["invite_specs"]),
    );
  }

  // #################################################
  // CopyWith
  // #################################################

  Group copyWith({
    String? groupId,
    String? groupType,
    bool? isProtected,
    bool? isEncrypted,
    DateTime? createdAtInUtc,
    DateTime? editedAtInUtc,
    String? groupName,
    String? groupDescription,
    String? groupCreator,
    bool? isLocked,
    List<String>? commonModelEntries,
    bool? isRestrictedToCommon,
    String? rootGroupReference,
    String? parentGroupReference,
    String? participantReference,
    String? defaultCurrencyCode,
    GroupPrefs? groupPrefs,
    String? accessPin,
    String? alias,
    InviteSpecs? inviteSpecs,
    String? editPolicy,
    List<String>? editPermissions,
    String? deletePolicy,
    List<String>? deletePermissions,
    String? subgroupAddPolicy,
    List<String>? subgroupAddPermissions,
    String? entryAddPolicy,
    List<String>? entryAddPermissions,
    String? entryEditPolicy,
    List<String>? entryEditPermissions,
    String? entryDeletePolicy,
    List<String>? entryDeletePermissions,
  }) {
    return Group(
      groupId: groupId ?? this.groupId,
      groupType: groupType ?? this.groupType,
      isProtected: isProtected ?? this.isProtected,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      createdAtInUtc: createdAtInUtc ?? this.createdAtInUtc,
      editedAtInUtc: editedAtInUtc ?? this.editedAtInUtc,
      groupName: groupName ?? this.groupName,
      groupDescription: groupDescription ?? this.groupDescription,
      groupCreator: groupCreator ?? this.groupCreator,
      isLocked: isLocked ?? this.isLocked,
      commonModelEntries: commonModelEntries ?? this.commonModelEntries,
      isRestrictedToCommon: isRestrictedToCommon ?? this.isRestrictedToCommon,
      rootGroupReference: rootGroupReference ?? this.rootGroupReference,
      parentGroupReference: parentGroupReference ?? this.parentGroupReference,
      participantReference: participantReference ?? this.participantReference,
      defaultCurrencyCode: defaultCurrencyCode ?? this.defaultCurrencyCode,
      groupPrefs: groupPrefs ?? this.groupPrefs,
      accessPin: accessPin ?? this.accessPin,
      alias: alias ?? this.alias,
      inviteSpecs: inviteSpecs ?? this.inviteSpecs,
      editPolicy: editPolicy ?? this.editPolicy,
      editPermissions: editPermissions ?? this.editPermissions,
      deletePolicy: deletePolicy ?? this.deletePolicy,
      deletePermissions: deletePermissions ?? this.deletePermissions,
      subgroupAddPolicy: subgroupAddPolicy ?? this.subgroupAddPolicy,
      subgroupAddPermissions: subgroupAddPermissions ?? this.subgroupAddPermissions,
      entryAddPolicy: entryAddPolicy ?? this.entryAddPolicy,
      entryAddPermissions: entryAddPermissions ?? this.entryAddPermissions,
      entryEditPolicy: entryEditPolicy ?? this.entryEditPolicy,
      entryEditPermissions: entryEditPermissions ?? this.entryEditPermissions,
      entryDeletePolicy: entryDeletePolicy ?? this.entryDeletePolicy,
      entryDeletePermissions: entryDeletePermissions ?? this.entryDeletePermissions,
    );
  }
}
