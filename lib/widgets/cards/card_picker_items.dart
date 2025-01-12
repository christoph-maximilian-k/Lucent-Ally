import 'package:flutter/material.dart';

// Models.
import '/data/models/picker_items/picker_item.dart';
import '/data/models/picker_items/picker_items.dart';

// Widgets.
import '/widgets/customs/custom_cupertino_picker.dart';

class CardPickerItems extends StatelessWidget {
  final String? title;

  final double pickerHeight;
  final double pickerWidth;
  final double itemExtend;
  final FixedExtentScrollController scrollController;

  final PickerItems pickerItems;
  final Function(PickerItem) onSelectedItemChanged;

  final String? infoMessage;

  const CardPickerItems({
    super.key,
    this.title,
    required this.pickerHeight,
    required this.pickerWidth,
    required this.itemExtend,
    required this.scrollController,
    required this.pickerItems,
    required this.onSelectedItemChanged,
    required this.infoMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (title != null)
              Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            CustomCupertinoPicker(
              // * Dimensions.
              height: pickerHeight,
              width: pickerWidth,
              // * Data.
              pickerItems: pickerItems,
              // * ScrollController.
              fixedExtentScrollController: scrollController,
              // * Wheel methods.
              onSelectedItemChanged: (final int index, _) => onSelectedItemChanged(pickerItems.items[index]),
            ),

            // * Info message for add policy.
            if (infoMessage != null)
              Container(
                height: 55.0,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  infoMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
