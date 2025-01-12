import 'package:flutter/material.dart';

// Models.
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_text_button.dart';

class CustomGroupSelector extends StatelessWidget {
  // Indications.
  final String title;
  final IconData icon;

  // Groups Chips.
  final Group? requiredGroup;
  final Groups groupsChips;
  final Function(Group) onChipRemoved;

  // Create New Group Button.
  final String createNewGroupButtonLabel;
  final Function() onCreateNewGroupPressed;

  // Existing Group Picker.
  final bool showExistingGroupButton;
  final String pickExistingGroupButtonLabel;
  final Function() onPickExistingGroupPressed;

  const CustomGroupSelector({
    super.key,
    // Indications.
    required this.title,
    required this.icon,
    // Groups Chips.
    this.requiredGroup,
    required this.groupsChips,
    required this.onChipRemoved,
    // Create New Group Button.
    required this.createNewGroupButtonLabel,
    required this.onCreateNewGroupPressed,
    // Existing Group Picker.
    required this.showExistingGroupButton,
    required this.pickExistingGroupButtonLabel,
    required this.onPickExistingGroupPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // * Indications.
          ListTile(
            horizontalTitleGap: 0.0,
            leading: Icon(
              icon,
              color: Theme.of(context).primaryIconTheme.color,
              size: Theme.of(context).primaryIconTheme.size,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // * Groups Chips.
          if (groupsChips.items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: List.generate(
                  groupsChips.items.length,
                  (index) {
                    // Helper variables.
                    final Group currentGroup = groupsChips.items[index];
                    final bool isRemoveable = requiredGroup == null || requiredGroup!.groupId != currentGroup.groupId;

                    return Chip(
                      key: UniqueKey(),
                      label: Text(
                        currentGroup.groupName,
                      ),
                      onDeleted: isRemoveable ? () => onChipRemoved(currentGroup) : null,
                    );
                  },
                ),
              ),
            ),
          // * Create New Group Button.
          CustomElevatedButton(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            label: createNewGroupButtonLabel,
            onPressed: onCreateNewGroupPressed,
          ),
          // * Existing Group Picker.
          if (showExistingGroupButton)
            CustomTextButton(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              onPressed: onPickExistingGroupPressed,
              label: pickExistingGroupButtonLabel,
            ),
        ],
      ),
    );
  }
}
