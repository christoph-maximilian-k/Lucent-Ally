import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// User with Settings and Labels.
import '/main.dart';

// Models.
import '/data/models/groups/group.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/model_entries/model_entry.dart';

// Cubits.
import 'cubit/create_group_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_input_tile.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_horizontal_divider.dart';
import '/widgets/cards/card_picker_items.dart';
import '/widgets/customs/custom_text_button.dart';

class CreateGroupSheet extends StatefulWidget {
  final int initialGroupEditPolicyItem;
  final int initialGroupDeletePolicyItem;

  final int initialSubgroupAddPolicyItem;

  final int initialEntryAddPolicyItem;
  final int initialEntryEditPolicyItem;
  final int initialEntryDeletePolicyItem;

  const CreateGroupSheet({
    super.key,
    required this.initialGroupEditPolicyItem,
    required this.initialGroupDeletePolicyItem,
    required this.initialSubgroupAddPolicyItem,
    required this.initialEntryAddPolicyItem,
    required this.initialEntryEditPolicyItem,
    required this.initialEntryDeletePolicyItem,
  });

  @override
  State<CreateGroupSheet> createState() => _CreateGroupSheetState();
}

class _CreateGroupSheetState extends State<CreateGroupSheet> {
  // Variables.
  late FixedExtentScrollController fixedExtentScrollControllerGroupEditPolicy;
  late FixedExtentScrollController fixedExtentScrollControllerGroupDeletePolicy;

  late FixedExtentScrollController fixedExtentScrollControllerSubgroupAddPolicy;

  late FixedExtentScrollController fixedExtentScrollControllerDeletePolicy;
  late FixedExtentScrollController fixedExtentScrollControllerAddPolicy;
  late FixedExtentScrollController fixedExtentScrollControllerEditPolicy;

  late FocusScopeNode node;

  @override
  void initState() {
    super.initState();
    // Group policies.
    fixedExtentScrollControllerGroupEditPolicy = FixedExtentScrollController(
      initialItem: widget.initialGroupEditPolicyItem,
    );

    fixedExtentScrollControllerGroupDeletePolicy = FixedExtentScrollController(
      initialItem: widget.initialGroupDeletePolicyItem,
    );

    // Subgroup policies.
    fixedExtentScrollControllerSubgroupAddPolicy = FixedExtentScrollController(
      initialItem: widget.initialSubgroupAddPolicyItem,
    );

    // Entry policies.
    fixedExtentScrollControllerAddPolicy = FixedExtentScrollController(
      initialItem: widget.initialEntryAddPolicyItem,
    );

    fixedExtentScrollControllerEditPolicy = FixedExtentScrollController(
      initialItem: widget.initialEntryEditPolicyItem,
    );

    fixedExtentScrollControllerDeletePolicy = FixedExtentScrollController(
      initialItem: widget.initialEntryDeletePolicyItem,
    );

    // Init the node.
    node = FocusScopeNode();
  }

  @override
  void dispose() {
    // Group policies.
    fixedExtentScrollControllerGroupEditPolicy.dispose();
    fixedExtentScrollControllerGroupDeletePolicy.dispose();

    // Entry policies.
    fixedExtentScrollControllerAddPolicy.dispose();
    fixedExtentScrollControllerEditPolicy.dispose();
    fixedExtentScrollControllerDeletePolicy.dispose();

    // Subgroup policies.
    fixedExtentScrollControllerSubgroupAddPolicy.dispose();

    // Remove focus scope.
    node.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size.
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double itemExtend = (height * 0.4) / 10.0;

    return BlocConsumer<CreateGroupSheetCubit, CreateGroupSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == CreateGroupSheetStatus.close && current.status == CreateGroupSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == CreateGroupSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != CreateGroupSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == CreateGroupSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == CreateGroupSheetStatus.pageHasError;
        final bool loading = state.status == CreateGroupSheetStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          pageIsLoading: pageIsLoading,
          // Focus node.
          focusScopeNode: node,
          onBasePageTap: () => node.unfocus(),
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.failure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<CreateGroupSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<CreateGroupSheetCubit>().dismissFailure(),
          // Corner close button.
          onCornerClosePressed: () => context.read<CreateGroupSheetCubit>().confirmCloseSheet(context: context),
          // Leading IconButton.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<CreateGroupSheetCubit>().confirmCloseSheet(context: context),
          // Horizontal swipe to close.
          onHorizontalPopRoute: () => context.read<CreateGroupSheetCubit>().confirmCloseSheet(context: context),
          // Loading close button.
          onCloseWhilePageLoadingButtonPressed: () => context.read<CreateGroupSheetCubit>().closeSheet(),
          // Floating Action Bar.
          actionBarIsLoading: loading,
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.addGroupSheetFLoatingActionBarLabel(isEdit: state.isEdit),
          onFloatingActionBarPressed: () {
            // * Trigger edit group.
            if (state.isEdit) {
              if (state.isShared == false) context.read<CreateGroupSheetCubit>().editLocalGroup();
              if (state.isShared) context.read<CreateGroupSheetCubit>().editSharedGroup();

              return;
            }

            // * Trigger create group.
            if (state.isShared == false) context.read<CreateGroupSheetCubit>().createLocalGroup();
            if (state.isShared) context.read<CreateGroupSheetCubit>().createSharedGroup();
          },
          content: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AppIcons.groups,
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                ),
                const SizedBox(width: 10.0),
                Text(
                  labels.createGroupSheetTitle(
                    isShared: state.isShared,
                    isEdit: state.isEdit,
                  ),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // * Groupname.
            CustomInputTile(
              textFieldKey: const ValueKey('group_name'),
              icon: AppIcons.names,
              title: labels.groupName(),
              initialData: state.group.groupName,
              shouldRequestFocus: state.isEdit == false,
              required: true,
              onChanged: (final String value, final TextEditingController controller) => context.read<CreateGroupSheetCubit>().updateGroupName(
                    value: value.trim(),
                    controller: controller,
                  ),
            ),
            // * Protect group.
            // ! This is currently available only in local mode. Shared data is stored in the cloud and protection
            // ! is applied there.
            if (state.showIsProtectedSwitch)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomSwitchListTile(
                        padding: const EdgeInsets.only(left: 5.0),
                        key: const ValueKey('is_protected'),
                        title: labels.addGroupSheetProtectGroup(),
                        value: state.group.isProtected,
                        onChanged: (_) => context.read<CreateGroupSheetCubit>().isProtectedChanged(),
                        infoMessage: labels.addGroupSheetProtectGroupInfoMessage(),
                      ),
                      if (state.showIsEncryptedSwitch)
                        CustomSwitchListTile(
                          padding: const EdgeInsets.only(left: 5.0, top: 25.0),
                          key: const ValueKey('is_encrypted'),
                          title: labels.addGroupSheetEncryptGroup(),
                          value: state.group.isEncrypted,
                          onChanged: (_) => context.read<CreateGroupSheetCubit>().isEncryptedChanged(),
                          infoMessage: labels.addGroupSheetEncryptGroupInfoMessage(),
                        ),
                    ],
                  ),
                ),
              ),
            // * Group description.
            CustomInputTile(
              textFieldKey: const ValueKey('group_description'),
              icon: AppIcons.description,
              title: labels.groupDescription(),
              maxLines: 8,
              initialData: state.group.groupDescription,
              textInputType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onChanged: (final String value, final TextEditingController controller) => context.read<CreateGroupSheetCubit>().updateGroupDescription(
                    value: value.trim(),
                    controller: controller,
                  ),
            ),
            // * Access pin.
            if (state.group.getIsSharedGroupType)
              CustomInputTile(
                textFieldKey: const ValueKey('access_pin'),
                icon: AppIcons.fieldTypePassword,
                title: labels.createSharedGroupSheetAccessPin(),
                initialData: state.group.accessPin,
                infoMessage: labels.createSharedGroupSheetAccessPinInfo(),
                onChanged: (final String value, final TextEditingController controller) => context.read<CreateGroupSheetCubit>().accessPinChanged(
                      value: value.trim(),
                      controller: controller,
                    ),
              ),
            // * Invite link.
            if (state.group.getIsSharedGroupType)
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          labels.groupInviteLink(),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      labels.basicLabelsExpirationDate(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: width * 0.6,
                            child: CustomTextButton(
                              isOutlined: true,
                              label: state.group.inviteSpecs.expirationDateInUtc == null ? labels.setExpirationDate() : state.group.inviteSpecs.getFormattedDate,
                              onPressed: () => context.read<CreateGroupSheetCubit>().setExpirationDate(
                                    context: context,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          IconButton(
                            onPressed: () => context.read<CreateGroupSheetCubit>().removeExpirationDate(),
                            icon: Icon(
                              AppIcons.delete,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Text(
                      labels.basicLabelsUsageLimits(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: width * 0.6,
                            child: CustomTextButton(
                              isOutlined: true,
                              label: state.group.inviteSpecs.usageLimit == null ? labels.setUsageLimitations() : state.group.inviteSpecs.usageLimit.toString(),
                              onPressed: () => context.read<CreateGroupSheetCubit>().setUsageLimitation(
                                    context: context,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          IconButton(
                            onPressed: () => context.read<CreateGroupSheetCubit>().removeUsageLimits(),
                            icon: Icon(
                              AppIcons.delete,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            if (state.group.getIsSharedGroupType || state.group.getIsSharedSubgroupType)
              Column(
                children: [
                  // * Group edit policies. Only relevant for shared subgroups.
                  // * For top level groups this is a constant value.
                  if (state.group.getIsSharedSubgroupType)
                    CardPickerItems(
                      title: labels.createGroupSheetGroupEditPolicy(),
                      pickerHeight: 130.0,
                      pickerWidth: width * 0.8,
                      itemExtend: itemExtend,
                      scrollController: fixedExtentScrollControllerGroupEditPolicy,
                      pickerItems: state.editPolicies,
                      onSelectedItemChanged: (final PickerItem item) => context.read<CreateGroupSheetCubit>().groupEditPermissionChanged(
                            policy: item.id,
                          ),
                      infoMessage: state.group.getSharedGroupEditPolicyInfoMessage,
                    ),
                  // * Group delete policies. Only relevant for shared subgroups.
                  // * For top level groups this is a constant value.
                  if (state.group.getIsSharedSubgroupType)
                    CardPickerItems(
                      title: labels.createGroupSheetGroupDeletePolicy(),
                      pickerHeight: 130.0,
                      pickerWidth: width * 0.8,
                      itemExtend: itemExtend,
                      scrollController: fixedExtentScrollControllerGroupDeletePolicy,
                      pickerItems: state.deletePolicies,
                      onSelectedItemChanged: (final PickerItem item) => context.read<CreateGroupSheetCubit>().groupDeletePermissionChanged(
                            policy: item.id,
                          ),
                      infoMessage: state.group.getSharedGroupDeletePolicyInfoMessage,
                    ),
                  // * Subgroup add policies.
                  CardPickerItems(
                    title: labels.createGroupSheetSubgroupAddPolicy(),
                    pickerHeight: 130.0,
                    pickerWidth: width * 0.8,
                    itemExtend: itemExtend,
                    scrollController: fixedExtentScrollControllerSubgroupAddPolicy,
                    pickerItems: state.subgroupAddPolicies,
                    onSelectedItemChanged: (final PickerItem item) => context.read<CreateGroupSheetCubit>().subgroupAddPermissionChanged(
                          policy: item.id,
                        ),
                    infoMessage: state.group.getSubgroupAddPolicyInfoMessage,
                  ),
                  // * Entry add policies.
                  CardPickerItems(
                    title: labels.createGroupSheetEntryAddPolicy(),
                    pickerHeight: 130.0,
                    pickerWidth: width * 0.8,
                    itemExtend: itemExtend,
                    scrollController: fixedExtentScrollControllerAddPolicy,
                    pickerItems: state.entryAddPolicies,
                    onSelectedItemChanged: (final PickerItem item) => context.read<CreateGroupSheetCubit>().entryAddPermissionChanged(
                          policy: item.id,
                        ),
                    infoMessage: state.group.getEntryAddPolicyInfoMessage,
                  ),
                  // * Entry edit policies. Only show if add policy is not none.
                  // * SizedBox is used to prevent scrollCOntroller from disposing.
                  SizedBox(
                    height: state.group.entryAddPolicy != Group.permissionNone ? null : 0.00,
                    width: state.group.entryAddPolicy != Group.permissionNone ? null : 0.00,
                    child: CardPickerItems(
                      title: labels.createGroupSheetEntryEditPolicy(),
                      pickerHeight: 130.0,
                      pickerWidth: width * 0.8,
                      itemExtend: itemExtend,
                      scrollController: fixedExtentScrollControllerEditPolicy,
                      pickerItems: state.entryEditPolicies,
                      onSelectedItemChanged: (final PickerItem item) => context.read<CreateGroupSheetCubit>().entryEditPermissionChanged(
                            policy: item.id,
                          ),
                      infoMessage: state.group.getEntryEditPolicyInfoMessage,
                    ),
                  ),
                  // * Entry delete policies. Only show if add policy is not none.
                  // * SizedBox is used to prevent scrollCOntroller from disposing.
                  SizedBox(
                    height: state.group.entryAddPolicy != Group.permissionNone ? null : 0.00,
                    width: state.group.entryAddPolicy != Group.permissionNone ? null : 0.00,
                    child: CardPickerItems(
                      title: labels.createGroupSheetEntryDeletePolicy(),
                      pickerHeight: 130.0,
                      pickerWidth: width * 0.8,
                      itemExtend: itemExtend,
                      scrollController: fixedExtentScrollControllerDeletePolicy,
                      pickerItems: state.entryDeletePolicies,
                      onSelectedItemChanged: (final PickerItem item) => context.read<CreateGroupSheetCubit>().entryDeletePermissionChanged(
                            policy: item.id,
                          ),
                      infoMessage: state.group.getEntryDeletePolicyInfoMessage,
                    ),
                  ),
                ],
              ),
            // * Restricted ModelEntries.
            Card(
              child: Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 0.0,
                    leading: Icon(
                      AppIcons.entryModels,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    title: Text(
                      labels.basicLabelsCommonModelEntries(isShared: state.isShared),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CustomDropDownButton(
                          label: labels.basicLabelsAdd(),
                          onTap: () => context.read<CreateGroupSheetCubit>().addCommonModelEntries(
                                context: context,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                          child: Column(
                            children: [
                              // * Display model entries.
                              if (state.commonModelEntries.items.isNotEmpty)
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 250.0,
                                  ),
                                  color: Theme.of(context).colorScheme.surface,
                                  margin: const EdgeInsets.all(10.0),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) => const CustomHorizontalDivider(
                                      marginLeft: 10.0,
                                      marginRight: 10.0,
                                    ),
                                    itemCount: state.commonModelEntries.items.length,
                                    itemBuilder: (context, index) {
                                      final ModelEntry modelEntry = state.commonModelEntries.items[index];

                                      return Container(
                                        height: 50.0,
                                        padding: const EdgeInsets.only(left: 20.0, right: 5.0, bottom: 5.0, top: 5.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                modelEntry.modelEntryName,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.displaySmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: IconButton(
                                                onPressed: () => context.read<CreateGroupSheetCubit>().removeFromCommonModelEntries(
                                                      context: context,
                                                      modelEntry: modelEntry,
                                                    ),
                                                icon: Icon(
                                                  AppIcons.delete,
                                                  color: Theme.of(context).colorScheme.error,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // * Info message Restrictions.
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            labels.createGroupRestrictionsInfoMessage(isShared: state.isShared),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        // * In shared mode let user decide if they want to restrict to common.
                        if (state.isShared)
                          CustomSwitchListTile(
                            title: labels.basicLabelsRestrictToCommon(),
                            value: state.group.isRestrictedToCommon,
                            padding: const EdgeInsets.all(10.0),
                            infoMessage: labels.restrictToCommonInfoMessage(),
                            onChanged: (final bool value) => context.read<CreateGroupSheetCubit>().onIsRestrictedToCommonChanged(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // * Participant.
            Card(
              child: Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 0.0,
                    leading: Icon(
                      AppIcons.participants,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    title: Text(
                      labels.basicLabelsParticipant(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          label: labels.createGroupSheetParticipantButtonLabel(
                            isEdit: state.getIsParticipantEdit,
                            participantName: state.participant.participantName,
                          ),
                          onPressed: () {
                            // User wants to create a new participant.
                            if (state.group.participantReference.isEmpty) {
                              context.read<CreateGroupSheetCubit>().showParticipantChoices(context: context);
                              return;
                            }

                            // User wants to edit a participant.
                            context.read<CreateGroupSheetCubit>().editParticipant(context: context);
                          },
                        ),
                        const SizedBox(height: 25.0),
                        // * Info message participant.
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            labels.createGroupSheetAddParticipantInfoMessage(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // * Default group currency.
            Card(
              child: Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 0.0,
                    leading: Icon(
                      AppIcons.currency,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    title: Text(
                      labels.basicLabelsDefaultCurrency(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    child: Column(
                      children: [
                        CustomDropDownButton(
                          label: state.group.defaultCurrencyCode.isEmpty ? labels.addGroupSheetCurrency() : state.group.defaultCurrencyCode,
                          onTap: () => context.read<CreateGroupSheetCubit>().onSelectCurrency(
                                context: context,
                              ),
                        ),
                        // * Info message currency.
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            labels.addGroupSheetCurrencyInfoMessage(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        if (state.isShared)
                          Column(
                            children: [
                              const SizedBox(height: 15.0),
                              Text(
                                labels.basicLabelsAttention(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                labels.infoMessageDefaultCurrencySharedGroup(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // * Lock group.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomSwitchListTile(
                      padding: const EdgeInsets.only(left: 5.0),
                      key: const ValueKey('is_locked'),
                      title: labels.addGroupSheetLockGroup(),
                      value: state.group.isLocked,
                      onChanged: (_) => context.read<CreateGroupSheetCubit>().isLockedChanged(),
                    ),
                    // * Info message isLocked.
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        labels.addGroupSheetLockGroupInfoMessage(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
