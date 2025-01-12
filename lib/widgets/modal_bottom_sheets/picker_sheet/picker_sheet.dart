import 'dart:io' show Platform;

import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/picker_items/picker_items.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_cupertino_picker.dart';
import '/widgets/customs/custom_text_button.dart';

class PickerSheet extends StatefulWidget {
  final double? height;
  final String? title;
  final int initialItem;
  final double? itemExtend;
  final PickerItems pickerItems;
  final String? staticInfoMessage;

  final bool showSecondButton;
  final String? secondButtonLabel;
  final Function(BuildContext)? secondButtonCallback;

  const PickerSheet({
    super.key,
    this.height,
    this.title,
    this.initialItem = 0,
    this.itemExtend,
    required this.pickerItems,
    this.staticInfoMessage,
    this.showSecondButton = false,
    this.secondButtonLabel,
    this.secondButtonCallback,
  });

  @override
  State<PickerSheet> createState() => _PickerSheetState();
}

class _PickerSheetState extends State<PickerSheet> {
  // Create FixedExtentScrollController.
  late FixedExtentScrollController fixedExtentScrollController;

  // Currently selected index.
  late int selectedIndex = widget.initialItem;
  late String infoMessage = widget.pickerItems.items[selectedIndex].infoMessage;

  @override
  void initState() {
    fixedExtentScrollController = FixedExtentScrollController(initialItem: widget.initialItem);
    super.initState();
  }

  @override
  void dispose() {
    fixedExtentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size.
    final double height = MediaQuery.of(context).size.height;

    final bool displayStaticInfoMessage = widget.staticInfoMessage != null && widget.staticInfoMessage!.isNotEmpty;

    return GestureDetector(
      onHorizontalDragStart: (final DragStartDetails details) {
        // * User swiped to close.
        if (details.globalPosition.dx < 20.0) {
          Navigator.of(context).pop(null);
        }
      },
      child: SizedBox(
        height: widget.height != null ? widget.height! : height * 0.5,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            Expanded(
              child: CustomCupertinoPicker(
                // * Dimensions.
                height: 100.0,
                // * Data.
                pickerItems: widget.pickerItems,
                // * In this case supply a fixedExtentScrollController from parent because
                // * on group creation it is needed.
                fixedExtentScrollController: fixedExtentScrollController,
                // * Wheel methods.
                onSelectedItemChanged: (final int index, _) {
                  setState(() {
                    selectedIndex = index;
                    infoMessage = widget.pickerItems.items[index].infoMessage;
                  });
                },
              ),
            ),
            // Info message.
            if (infoMessage.isNotEmpty || displayStaticInfoMessage)
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  displayStaticInfoMessage ? widget.staticInfoMessage! : infoMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            CustomElevatedButton(
              margin: const EdgeInsets.all(15.0),
              label: labels.basicLabelsChoose(),
              onPressed: () => Navigator.of(context).pop(selectedIndex),
            ),
            if (widget.showSecondButton)
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: CustomTextButton(
                  label: widget.secondButtonLabel!,
                  onPressed: () => widget.secondButtonCallback!(context),
                ),
              ),
            if (Platform.isIOS) const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
