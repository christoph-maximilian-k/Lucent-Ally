import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// Widgets.
import '/widgets/customs/custom_text_field.dart';

class TextFieldSheet extends StatefulWidget {
  final TextInputType textInputType;
  final String? title;
  final String? infoMessage;
  final String hint;
  final String initialValue;
  final bool autocorrect;
  final bool canObscure;

  const TextFieldSheet({
    this.textInputType = TextInputType.text,
    this.hint = '',
    this.initialValue = '',
    this.title,
    this.infoMessage,
    this.autocorrect = true,
    this.canObscure = false,
    super.key,
  });

  @override
  State<TextFieldSheet> createState() => _TextFieldSheetState();
}

class _TextFieldSheetState extends State<TextFieldSheet> {
  // Init state variable.
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    // * Access bottom insets to ensures that text field is moved up if keyboard is visible.
    final double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.85,
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
            child: CustomTextField(
              textInputType: widget.textInputType,
              shouldRequestFocus: true,
              hint: widget.hint,
              obscure: widget.canObscure == false ? false : obscure,
              textFieldTrailingIcon: widget.canObscure == false
                  ? null
                  : obscure
                      ? AppIcons.visible
                      : AppIcons.hidden,
              onTextFieldTrailingIconPressed: (_) {
                setState(() {
                  obscure = !obscure;
                });
              },
              autocorrect: widget.autocorrect,
              initialData: widget.initialValue,
              onSubmitted: (final String value, final TextEditingController controller) => Navigator.of(context).pop(
                value.trim(),
              ),
            ),
          ),
          // Info message.
          if (widget.infoMessage != null)
            Container(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0, bottom: 20.0),
              child: Text(
                widget.infoMessage!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
        ],
      ),
    );
  }
}
