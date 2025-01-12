import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';

class ReorderSheet extends StatefulWidget {
  final PickerItems initialList;

  const ReorderSheet({
    super.key,
    required this.initialList,
  });

  @override
  State<ReorderSheet> createState() => _ReorderSheetState();
}

class _ReorderSheetState extends State<ReorderSheet> {
  // Init list.
  PickerItems reorderedList = PickerItems.initial();

  @override
  void initState() {
    super.initState();
    reorderedList = reorderedList.join(other: widget.initialList);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.40,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Expanded(
              child: ReorderableListView(
                shrinkWrap: true,
                children: List<Widget>.generate(
                  reorderedList.items.length,
                  (index) {
                    final ValueKey widgetKey = ValueKey(index);

                    return SizedBox(
                      key: widgetKey,
                      width: double.infinity,
                      height: 45.0,
                      child: Card(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                                child: Text(
                                  reorderedList.items[index].label,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  AppIcons.reorder,
                                  color: Theme.of(context).iconTheme.color,
                                  size: Theme.of(context).iconTheme.size,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                onReorder: (oldIndex, newIndex) {
                  // * Do nothing if only one item is in list.
                  // * This is needed because of a bug in the framework widget.
                  if (reorderedList.items.length == 1) return;

                  // Item moved down in list, correct newIndex.
                  // * This is needed because of a bug in the framework widget.
                  if (oldIndex < newIndex) newIndex -= 1;

                  // * Do nothing if indexes are equal because item did not actually move.
                  if (oldIndex == newIndex) return;

                  // Access item which should be moved.
                  final PickerItem item = reorderedList.items[oldIndex];

                  // Initialize list.
                  PickerItems updatedList = reorderedList;

                  updatedList.items.removeAt(oldIndex);

                  updatedList.items.insert(newIndex, item);

                  if (mounted == false) return;

                  setState(() {
                    reorderedList = updatedList;
                  });
                },
              ),
            ),
            CustomElevatedButton(
              margin: const EdgeInsets.only(top: 8.0),
              label: labels.reorderSheetReady(),
              onPressed: () => Navigator.of(context).pop(reorderedList),
            ),
          ],
        ),
      ),
    );
  }
}
