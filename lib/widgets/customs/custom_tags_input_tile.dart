import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/tags/tag.dart';

// Widgets.
import '/widgets/customs/custom_text_field.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/cards/card_display_tags.dart';

class CustomTagsInputTile extends StatefulWidget {
  // Indications.
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final bool hideIndications;
  final bool hideCard;
  final bool requiredField;

  // Data.
  final TagsData tagsData;

  // Chips.
  final Function(Tag, int)? onTagRemoved;
  final Function()? getTagsFuture;

  // Text Field.
  final Key? textFieldTagKey;
  final int? maxLines;
  final TextInputType textInputType;
  final bool shouldRequestFocus;
  final String initialData;
  final Function(String, TextEditingController) onTagChanged;
  final Function(String, TextEditingController) onTagSubmitted;
  final bool obscure;
  final String? hint;
  final List<String> tagsSuggestions;
  final Function(TextEditingController, String, int) onSuggestionTap;

  // Suffix Icon.
  final IconData? suffixIcon;
  final Function(TextEditingController)? suffixPressed;

  // TextField leading.
  final Widget? textFieldLeadingWidget;
  final Function(TextEditingController)? onTextFieldLeadingPressed;

  // TextField trailing.
  final IconData? textFieldTrailingIcon;
  final String? textFieldTrailingIconTooltip;
  final Function(TextEditingController)? onTextFieldTrailingIconPressed;

  // Trailing Icon.
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function(TextEditingController)? onTrailingIconPressed;

  // Info Message.
  final String infoMessage;

  // Button.
  final String? buttonLabel;
  final Function()? onButtonPressed;

  // First Switch
  final String switchLabelFirst;
  final bool valueFirstSwitch;
  final Function(bool)? onFirstSwitchChanged;

  // Second Switch
  final String switchLabelSecond;
  final bool valueSecondSwitch;
  final Function(bool)? onSecondSwitchChanged;

  const CustomTagsInputTile({
    super.key,
    // Indications.
    this.icon,
    this.title,
    this.subtitle,
    this.hideIndications = false,
    this.hideCard = false,
    this.requiredField = false,
    // Data.
    required this.tagsData,
    // Chips.
    required this.onTagRemoved,
    required this.getTagsFuture,
    // Text Field.
    this.textFieldTagKey,
    this.maxLines,
    this.textInputType = TextInputType.text,
    this.shouldRequestFocus = false,
    this.initialData = '',
    required this.onTagChanged,
    required this.onTagSubmitted,
    this.obscure = false,
    this.hint,
    required this.tagsSuggestions,
    required this.onSuggestionTap,
    // Suffix Icon.
    this.suffixIcon,
    this.suffixPressed,
    // TextField leading.
    this.textFieldLeadingWidget,
    this.onTextFieldLeadingPressed,
    // TextField trailing.
    this.textFieldTrailingIcon,
    this.textFieldTrailingIconTooltip,
    this.onTextFieldTrailingIconPressed,
    // Trailing Icon.
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    this.onTrailingIconPressed,
    // Info Message.
    this.infoMessage = '',
    // Button.
    this.buttonLabel,
    this.onButtonPressed,
    // First Switch.
    this.switchLabelFirst = '',
    this.valueFirstSwitch = false,
    this.onFirstSwitchChanged,
    // Second Switch.
    this.switchLabelSecond = '',
    this.valueSecondSwitch = false,
    this.onSecondSwitchChanged,
  });

  @override
  State<CustomTagsInputTile> createState() => _CustomTagsInputTileState();
}

class _CustomTagsInputTileState extends State<CustomTagsInputTile> {
  // Create controller.
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // Set initial data to controller.
    textEditingController.text = widget.initialData;

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of controller.
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.hideCard ? 0.0 : null,
      color: widget.hideCard ? Colors.transparent : null,
      child: Column(
        children: [
          if (widget.hideIndications == false)
            Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
                  horizontalTitleGap: 5.0,
                  leading: Icon(
                    widget.icon,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size,
                  ),
                  title: Text(
                    widget.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: widget.subtitle != null
                      ? Text(
                          widget.subtitle!,
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      : null,
                  trailing: widget.onTrailingIconPressed != null
                      ? IconButton(
                          icon: Icon(
                            widget.trailingIcon,
                            color: widget.trailingIconColor,
                            size: Theme.of(context).primaryIconTheme.size,
                          ),
                          onPressed: () => widget.onTrailingIconPressed!(textEditingController),
                          tooltip: widget.trailingIconTooltip,
                        )
                      : null,
                ),
                if (widget.requiredField)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 15.0),
                      child: Text(
                        labels.basicLabelsAValueIsRequired(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: CustomTextField(
              key: widget.textFieldTagKey,
              textEditingController: textEditingController,
              maxLines: widget.maxLines,
              shouldRequestFocus: widget.shouldRequestFocus,
              initialData: widget.initialData,
              hint: widget.hint,
              obscure: widget.obscure,
              textInputType: widget.textInputType,
              suffixIconData: widget.suffixIcon,
              onSuffixIconPressed: widget.suffixPressed,
              textFieldLeadingWidget: widget.textFieldLeadingWidget,
              onTextFieldLeadingPressed: widget.onTextFieldLeadingPressed,
              textFieldTrailingIcon: widget.textFieldTrailingIcon,
              textFieldTrailingIconTooltip: widget.textFieldTrailingIconTooltip,
              onTextFieldTrailingIconPressed: (final TextEditingController controller) => widget.onTextFieldTrailingIconPressed == null ? () {} : widget.onTextFieldTrailingIconPressed!(controller),
              onSubmitted: widget.onTagSubmitted,
              onChanged: widget.onTagChanged,
              showSuggestions: true,
              suggestions: widget.tagsSuggestions,
              onSuggestionTap: (final TextEditingController controller, final String value, final int index) => widget.onSuggestionTap(controller, value, index),
            ),
          ),
          if (widget.getTagsFuture != null && widget.tagsData.tagReferences.isNotEmpty)
            CardDisplayTags(
              showIndications: false,
              showCard: false,
              getTagsFuture: widget.getTagsFuture!,
              tagsData: widget.tagsData,
              onDeleted: (final Tag tag, final int index) => widget.onTagRemoved!(tag, index),
            ),
          Visibility(
            visible: widget.infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 15.0),
              child: Text(
                widget.infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
          if (widget.buttonLabel != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDropDownButton(
                label: widget.buttonLabel!,
                onTap: widget.onButtonPressed!,
              ),
            ),
          Visibility(
            visible: widget.switchLabelFirst.isNotEmpty,
            child: CustomSwitchListTile(
              padding: EdgeInsets.only(top: 15.0, left: 20.0, bottom: widget.switchLabelSecond.isNotEmpty ? 0.0 : 10.0),
              key: UniqueKey(),
              title: widget.switchLabelFirst,
              value: widget.valueFirstSwitch,
              onChanged: widget.onFirstSwitchChanged,
            ),
          ),
          Visibility(
            visible: widget.switchLabelSecond.isNotEmpty,
            child: CustomSwitchListTile(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              key: UniqueKey(),
              title: widget.switchLabelSecond,
              value: widget.valueSecondSwitch,
              onChanged: widget.onSecondSwitchChanged,
            ),
          ),
          const SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
