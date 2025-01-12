import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// User with Settings and Labels.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_horizontal_divider.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final String initialData;
  final double? textFieldHeight;
  final bool autocorrect;

  // Controller.
  final TextEditingController? textEditingController;

  final int? maxLines;

  final bool enabled;
  final bool obscure;
  final bool shouldRequestFocus;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  final BoxDecoration? decoration;

  final Function(String value, TextEditingController controller)? onSubmitted;
  final Function(String, TextEditingController)? onChanged;

  final IconData? suffixIconData;
  final Color? suffixIconColor;
  final Function(TextEditingController)? onSuffixIconPressed;

  final Widget? textFieldLeadingWidget;
  final Function(TextEditingController)? onTextFieldLeadingPressed;

  final IconData? textFieldTrailingIcon;
  final String? textFieldTrailingIconTooltip;
  final Function(TextEditingController)? onTextFieldTrailingIconPressed;

  // * Input Suggestions.
  final bool showSuggestions;
  final List<String> suggestions;
  final Function(TextEditingController, String, int)? onSuggestionTap;

  const CustomTextField({
    super.key,
    this.hint,
    this.initialData = '',
    this.autocorrect = true,
    this.textEditingController,
    this.textFieldHeight,
    this.maxLines,
    this.enabled = true,
    this.obscure = false,
    this.onSubmitted,
    this.textInputType,
    this.textInputAction,
    this.decoration,
    this.onChanged,
    this.suffixIconData,
    this.suffixIconColor,
    this.onSuffixIconPressed,
    this.textFieldLeadingWidget,
    this.onTextFieldLeadingPressed,
    this.textFieldTrailingIcon,
    this.textFieldTrailingIconTooltip,
    this.onTextFieldTrailingIconPressed,
    this.showSuggestions = false,
    this.suggestions = const [],
    this.onSuggestionTap,
    this.shouldRequestFocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Convenience variables.
  late TextEditingController localController;
  final FocusNode focusNode = FocusNode();

  // This variable saves the current text locally.
  String text = '';

  @override
  void initState() {
    // In case a controller was supplied from parent, use it, otherwise create a new one.
    localController = widget.textEditingController ?? TextEditingController();

    // Set initial data to controller.
    // * Only if not supplied from parent.
    if (widget.textEditingController == null) localController.text = widget.initialData;

    // Let textField request focus if indicated.
    if (widget.shouldRequestFocus) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        FocusScope.of(context).requestFocus(focusNode);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of controller.
    // * Only if not from parent.
    if (widget.textEditingController == null) localController.dispose();

    // Dispose focus node.
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sort suggestions.
    if (widget.suggestions.isNotEmpty) {
      widget.suggestions.sort((a, b) {
        // Check if both start with query
        bool startsWithA = a.startsWith(text);
        bool startsWithB = b.startsWith(text);

        // Sort by startsWith (prefer those that start with query)
        if (startsWithA && !startsWithB) {
          return -1; // a before b
        } else if (!startsWithA && startsWithB) {
          return 1; // b before a
        } else {
          // If both start with query or neither, sort alphabetically
          return a.compareTo(b);
        }
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showSuggestions && text.isNotEmpty)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.hintStyle!.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: widget.suggestions.isEmpty
                ? SizedBox(
                    height: 150.0,
                    child: Center(
                      child: Text(
                        labels.customTextFieldNoSuggestionsFound(),
                        style: TextStyle(
                          color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                          fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                        ),
                      ),
                    ),
                  )
                : Container(
                    constraints: const BoxConstraints(maxHeight: 150.0, minHeight: 150.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: widget.suggestions.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        // Convenience variables.
                        final String currentSuggestion = widget.suggestions[index];

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            onTap: () {
                              // * Reset local text. This is required for suggestions.
                              setState(() {
                                text = '';
                              });

                              // * Do nothing else in this case.
                              if (widget.onSuggestionTap == null) return;

                              // * Trigger onChanged.
                              widget.onSuggestionTap!(localController, currentSuggestion, index);
                            },
                            child: SizedBox(
                              height: 40.0,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  currentSuggestion,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                    fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const CustomHorizontalDivider(marginLeft: 25.0, marginRight: 25.0),
                    ),
                  ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.textFieldLeadingWidget != null)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: widget.onTextFieldLeadingPressed == null ? () {} : () => widget.onTextFieldLeadingPressed!(localController),
                  child: widget.textFieldLeadingWidget!,
                ),
              ),
            Expanded(
              child: SizedBox(
                height: widget.textFieldHeight,
                child: CupertinoTextField(
                  enabled: widget.enabled,
                  obscureText: widget.obscure,
                  textAlign: TextAlign.left,
                  keyboardType: widget.textInputType,
                  controller: localController,
                  focusNode: focusNode,
                  placeholder: widget.hint,
                  maxLines: widget.obscure ? 1 : widget.maxLines,
                  autocorrect: widget.autocorrect,
                  textInputAction: widget.textInputAction,
                  placeholderStyle: TextStyle(
                    backgroundColor: Theme.of(context).inputDecorationTheme.hintStyle!.backgroundColor,
                    decoration: Theme.of(context).inputDecorationTheme.hintStyle!.decoration,
                    color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                    fontSize: Theme.of(context).inputDecorationTheme.hintStyle!.fontSize,
                  ),
                  style: Theme.of(context).inputDecorationTheme.hintStyle!,
                  decoration: widget.decoration ??
                      BoxDecoration(
                        border: Border.all(
                          width: Theme.of(context).inputDecorationTheme.border!.borderSide.width,
                          color: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
                        ),
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).inputDecorationTheme.hintStyle!.backgroundColor,
                      ),
                  suffix: widget.suffixIconData != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0, right: 10.0),
                          child: GestureDetector(
                            onTap: widget.onSuffixIconPressed != null ? () => widget.onSuffixIconPressed!(localController) : () {},
                            child: Icon(
                              widget.suffixIconData,
                              size: Theme.of(context).iconTheme.size,
                              color: widget.suffixIconColor ?? Theme.of(context).inputDecorationTheme.iconColor,
                            ),
                          ),
                        )
                      : null,
                  onSubmitted: (String value) {
                    // * Reset local text. This is required for suggestions.
                    setState(() {
                      text = '';
                    });

                    // * Do nothing else in this case.
                    if (widget.onSubmitted == null) return;

                    // * Trigger onSubmitted.
                    widget.onSubmitted!(value, localController);
                  },
                  onChanged: (String value) {
                    // * Update local text. This is required for suggestions.
                    setState(() {
                      text = value;
                    });

                    // * Do nothing else in this case.
                    if (widget.onChanged == null) return;

                    // * Trigger onChanged.
                    widget.onChanged!(value, localController);
                  },
                ),
              ),
            ),
            if (widget.textFieldTrailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: IconButton(
                  icon: Icon(
                    widget.textFieldTrailingIcon,
                    size: Theme.of(context).primaryIconTheme.size,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  tooltip: widget.textFieldTrailingIconTooltip,
                  onPressed: widget.onTextFieldTrailingIconPressed == null ? () {} : () => widget.onTextFieldTrailingIconPressed!(localController),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
