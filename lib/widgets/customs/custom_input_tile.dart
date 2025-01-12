import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// User with Settings and labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_text_field.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_horizontal_divider.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_text_button.dart';

class CustomInputTile extends StatefulWidget {
  // Indications.
  final bool showIsDraggableHandle;
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool hideCard;
  final double? textFieldHeight;
  final bool required;

  // Password generator.
  final bool showPasswordGeneratorFunctions;
  final Function(TextEditingController)? generatePassword;
  final Function()? showPasswordGenerator;

  // Text Field.
  final bool showTextField;
  final Key? textFieldKey;
  final int? maxLines;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final bool shouldRequestFocus;
  final String initialData;
  final Function(String, TextEditingController)? onChanged;
  final Function(String value, TextEditingController controller)? onSubmitted;
  final bool obscure;
  final String? hint;

  // Optional value.
  final String? optionalValueTitle;
  final String? initialOptionalValue;
  final Function(String, TextEditingController)? onChangedOptionalValue;
  final String? optionalValueInfoMessage;
  final IconData? optionalTrailingIcon;
  final Function(TextEditingController)? onOptionalTrailingPressed;

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
  final Function(TextEditingController, TextEditingController)? onTrailingIconPressed;

  // Info Message.
  final String infoMessage;

  // Button.
  final String? buttonLabel;
  final Function()? onButtonPressed;

  // Second Button.
  final String? secondButtonLabel;
  final Function()? onSecondButtonPressed;

  // First Switch
  final String switchLabelFirst;
  final bool valueFirstSwitch;
  final Function(bool)? onFirstSwitchChanged;
  final String? firstSwitchInfoMessage;

  // Second Switch
  final String switchLabelSecond;
  final bool valueSecondSwitch;
  final Function(bool)? onSecondSwitchChanged;

  // Suggestions.
  final bool? showSuggestions;
  final List<String>? suggestions;
  final Function(TextEditingController, String, int)? onSuggestionTap;

  const CustomInputTile({
    super.key,
    // Indications.
    this.showIsDraggableHandle = false,
    required this.icon,
    required this.title,
    this.subtitle,
    this.hideCard = false,
    this.required = false,
    // Password generator functions.
    this.showPasswordGeneratorFunctions = false,
    this.generatePassword,
    this.showPasswordGenerator,
    // Text Field.
    this.showTextField = true,
    this.textFieldKey,
    this.maxLines,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.shouldRequestFocus = false,
    this.initialData = '',
    this.onChanged,
    this.onSubmitted,
    this.obscure = false,
    this.hint,
    this.textFieldHeight,
    // Optional value.
    this.optionalValueTitle,
    this.initialOptionalValue,
    this.onChangedOptionalValue,
    this.optionalValueInfoMessage,
    this.optionalTrailingIcon,
    this.onOptionalTrailingPressed,
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
    // Second Button.
    this.secondButtonLabel,
    this.onSecondButtonPressed,
    // First Switch.
    this.switchLabelFirst = '',
    this.valueFirstSwitch = false,
    this.onFirstSwitchChanged,
    this.firstSwitchInfoMessage,
    // Second Switch.
    this.switchLabelSecond = '',
    this.valueSecondSwitch = false,
    this.onSecondSwitchChanged,
    // Suggestions.
    this.showSuggestions,
    this.suggestions,
    this.onSuggestionTap,
  });

  @override
  State<CustomInputTile> createState() => _CustomInputTileState();
}

class _CustomInputTileState extends State<CustomInputTile> {
  // Convenience variables.
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController optionalTextEditingController = TextEditingController();

  @override
  void initState() {
    // Set initial data to controller.
    textEditingController.text = widget.initialData;
    if (widget.initialOptionalValue != null) optionalTextEditingController.text = widget.initialOptionalValue!;

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of controller.
    textEditingController.dispose();
    optionalTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.hideCard ? 0.0 : null,
      color: widget.hideCard ? Colors.transparent : null,
      child: Column(
        children: [
          if (widget.showIsDraggableHandle)
            Container(
              height: 20.0,
              padding: const EdgeInsets.only(top: 10.0),
              child: const Icon(
                AppIcons.draggable,
                size: 25.0,
              ),
            ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 16.0, right: 4.0, bottom: widget.required ? 0.0 : 8.0),
            horizontalTitleGap: 5.0,
            leading: Icon(
              widget.icon,
              color: Theme.of(context).primaryIconTheme.color,
              size: Theme.of(context).primaryIconTheme.size,
            ),
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: widget.subtitle != null
                ? Text(
                    widget.subtitle!,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                : null,
            trailing: widget.trailingIcon != null
                ? IconButton(
                    icon: Icon(
                      widget.trailingIcon,
                      color: widget.trailingIconColor,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    onPressed: widget.onTrailingIconPressed == null ? () {} : () => widget.onTrailingIconPressed!(textEditingController, optionalTextEditingController),
                    tooltip: widget.trailingIconTooltip,
                  )
                : null,
          ),
          if (widget.required)
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
          if (widget.showTextField)
            Padding(
              padding: widget.switchLabelFirst.isNotEmpty ? EdgeInsets.only(left: 20.0, right: widget.textFieldTrailingIcon != null ? 4.0 : 20.0) : EdgeInsets.only(left: 20.0, right: widget.textFieldTrailingIcon != null ? 4.0 : 20.0, bottom: 15.0),
              child: CustomTextField(
                key: widget.textFieldKey,
                textEditingController: textEditingController,
                textFieldHeight: widget.textFieldHeight,
                maxLines: widget.maxLines,
                shouldRequestFocus: widget.shouldRequestFocus,
                initialData: widget.initialData,
                hint: widget.hint,
                obscure: widget.obscure,
                textInputType: widget.textInputType,
                textInputAction: widget.textInputAction,
                suffixIconData: widget.suffixIcon,
                onSuffixIconPressed: widget.suffixPressed,
                textFieldLeadingWidget: widget.textFieldLeadingWidget,
                onTextFieldLeadingPressed: widget.onTextFieldLeadingPressed,
                textFieldTrailingIcon: widget.textFieldTrailingIcon,
                textFieldTrailingIconTooltip: widget.textFieldTrailingIconTooltip,
                onTextFieldTrailingIconPressed: (final TextEditingController controller) => widget.onTextFieldTrailingIconPressed == null ? () {} : widget.onTextFieldTrailingIconPressed!(controller),
                onSubmitted: widget.onSubmitted,
                onChanged: widget.onChanged,
                showSuggestions: widget.showSuggestions ?? false,
                suggestions: widget.suggestions ?? const [],
                onSuggestionTap: widget.onSuggestionTap,
              ),
            ),
          if (widget.showPasswordGeneratorFunctions)
            Container(
              height: 60.0,
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 42.0,
                      maxHeight: 42.0,
                      minWidth: 150.0,
                      maxWidth: MediaQuery.of(context).size.width * 0.42,
                    ),
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CustomTextButton(
                      isOutlined: true,
                      label: labels.passwordGeneratorGeneratePassword(),
                      onPressed: () => widget.generatePassword!(textEditingController),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    height: 42.0,
                    width: MediaQuery.of(context).size.width * 0.42,
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CustomTextButton(
                      isOutlined: true,
                      label: labels.passwordGenerator(),
                      onPressed: () => widget.showPasswordGenerator!(),
                    ),
                  ),
                ],
              ),
            ),
          if (widget.optionalValueTitle != null)
            Column(
              children: [
                const SizedBox(height: 15.0),
                const CustomHorizontalDivider(marginLeft: 25.0, marginRight: 25.0),
                const SizedBox(height: 15.0),
                Text(
                  widget.optionalValueTitle!,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 3.0),
                  child: CustomTextField(
                    initialData: widget.initialOptionalValue!,
                    onChanged: widget.onChangedOptionalValue,
                    textEditingController: optionalTextEditingController,
                    maxLines: 1,
                    textFieldTrailingIcon: widget.optionalTrailingIcon,
                    onTextFieldTrailingIconPressed: (final TextEditingController optionalController) => widget.onOptionalTrailingPressed == null ? () {} : widget.onOptionalTrailingPressed!(optionalController),
                  ),
                ),
                const SizedBox(height: 15.0),
                if (widget.optionalValueInfoMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0, top: 5.0),
                    child: Text(
                      widget.optionalValueInfoMessage!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
              ],
            ),
          Visibility(
            visible: widget.infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 25.0),
              child: Text(
                widget.infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
          if (widget.buttonLabel != null)
            Container(
              margin: EdgeInsets.only(bottom: 10.0, top: widget.showTextField ? 15.0 : 0.0),
              child: CustomDropDownButton(
                label: widget.buttonLabel!,
                onTap: widget.onButtonPressed!,
              ),
            ),
          if (widget.secondButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 15.0),
              child: CustomDropDownButton(
                label: widget.secondButtonLabel!,
                onTap: widget.onSecondButtonPressed!,
              ),
            ),
          Visibility(
            visible: widget.switchLabelFirst.isNotEmpty,
            child: CustomSwitchListTile(
              padding: EdgeInsets.only(top: 15.0, right: 15.0, left: 20.0, bottom: widget.switchLabelSecond.isNotEmpty ? 0.0 : 10.0),
              key: UniqueKey(),
              title: widget.switchLabelFirst,
              value: widget.valueFirstSwitch,
              onChanged: widget.onFirstSwitchChanged,
              infoMessage: widget.firstSwitchInfoMessage,
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
        ],
      ),
    );
  }
}
