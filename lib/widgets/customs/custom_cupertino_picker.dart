import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Models.
import '/data/models/groups/groups.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/picker_items/picker_items.dart';

class CustomCupertinoPicker extends StatefulWidget {
  final double? height;
  final double? width;
  final Groups? groups;
  final PickerItems? pickerItems;
  final ModelEntries? modelEntries;

  final FixedExtentScrollController? fixedExtentScrollController;

  final Function(int, FixedExtentScrollController) onSelectedItemChanged;

  const CustomCupertinoPicker({
    super.key,
    this.height,
    this.width,
    this.groups,
    this.pickerItems,
    this.modelEntries,
    this.fixedExtentScrollController,
    required this.onSelectedItemChanged,
  });

  @override
  State<CustomCupertinoPicker> createState() => _CustomCupertinoPickerState();
}

class _CustomCupertinoPickerState extends State<CustomCupertinoPicker> {
  // Convenience variables.
  late FixedExtentScrollController fixedExtentScrollController;

  @override
  void initState() {
    fixedExtentScrollController = widget.fixedExtentScrollController != null ? widget.fixedExtentScrollController! : FixedExtentScrollController();

    super.initState();
  }

  @override
  void dispose() {
    if (widget.fixedExtentScrollController == null) fixedExtentScrollController.dispose();
    super.dispose();
  }

  /// This method can be used to access the correct label depending on supplied data.
  String _getLabel({required int index}) {
    if (widget.groups != null) return widget.groups!.items[index].groupName;
    if (widget.modelEntries != null) return widget.modelEntries!.items[index].modelEntryName;
    if (widget.pickerItems != null) return widget.pickerItems!.items[index].label;
    return '';
  }

  /// This method can be used to access the number of items.
  int _getNumberOfItems() {
    // * Widget was initialized with groups.
    if (widget.groups != null) return widget.groups!.items.length;
    if (widget.modelEntries != null) return widget.modelEntries!.items.length;
    if (widget.pickerItems != null) return widget.pickerItems!.items.length;
    return 0;
  }

  // Check if a color was supplied.
  Color? _getColorById({required int index}) {
    // Not a picker items picker.
    if (widget.pickerItems == null) return null;

    final Color? color = widget.pickerItems!.getColorById(
      id: widget.pickerItems!.items[index].id,
    );

    return color;
  }

  /// This method will be triggerd if user tabs on a scroll wheel item.
  void _onTapScrollWheelItem({required int index}) {
    try {
      setState(() {
        // Select created entry model in picker.
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => fixedExtentScrollController.jumpToItem(index),
        );

        // * Trigger on changed.
        widget.onSelectedItemChanged(index, fixedExtentScrollController);
      });
    } catch (exception) {
      // Output debug messages.
      debugPrint('CustomCupertinoPicker --> _onTapScrollWheelItem() --> exception: ${exception.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size.
    final Size size = MediaQuery.of(context).size;
    final double itemExtend = (size.height * 0.4) / 7.0;
    final int numberOfItems = _getNumberOfItems();

    return SizedBox(
      height: widget.height,
      width: widget.width ?? size.width * 0.8,
      child: CupertinoPicker(
        itemExtent: itemExtend,
        looping: false,
        onSelectedItemChanged: (final int index) => widget.onSelectedItemChanged(index, fixedExtentScrollController),
        scrollController: fixedExtentScrollController,
        diameterRatio: 1.1,
        children: List.generate(
          numberOfItems,
          (index) {
            // Check if a color was supplied.
            final Color? color = _getColorById(index: index);

            return GestureDetector(
              onTap: () => _onTapScrollWheelItem(index: index),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                height: itemExtend,
                width: size.width * 0.7,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (color != null) const Spacer(),
                      Container(
                        padding: color != null ? const EdgeInsets.only(left: 10.0) : null,
                        child: Expanded(
                          child: Text(
                            _getLabel(index: index),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                      if (color != null) const Spacer(),
                      if (color != null)
                        Container(
                          width: 20.0,
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
