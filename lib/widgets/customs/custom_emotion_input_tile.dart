import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/emotion_data/emotion_item.dart';

// Widgets.
import '/widgets/customs/custom_drop_down_button.dart';

class CustomEmotionInputTile extends StatelessWidget {
  // Indications.
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool hideCard;
  final bool requiredField;

  // Data.
  final EmotionData emotionData;

  // Choose Category button.
  final String addEmotionButtonLabel;
  final Function() onAddEmotion;

  // Chips.
  final Function(EmotionItem, int) onEmotionRemoved;

  // Trailing Icon.
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function()? onTrailingIconPressed;

  // Additional buttons.
  final String? firstValueButtonLabel;
  final Function()? onFirstValueButtonPressed;

  final String? secondValueButtonLabel;
  final Function()? onSecondValueButtonPressed;

  final String? thirdValueButtonLabel;
  final Function()? onThirdValueButtonPressed;

  // Info Message.
  final String infoMessage;

  const CustomEmotionInputTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    this.subtitle,
    this.hideCard = false,
    this.requiredField = false,
    // Data.
    required this.emotionData,
    // Choose Category button.
    required this.addEmotionButtonLabel,
    required this.onAddEmotion,
    // Chips.
    required this.onEmotionRemoved,
    // Trailing Icon.
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    this.onTrailingIconPressed,
    // Additional buttons.
    this.firstValueButtonLabel,
    this.onFirstValueButtonPressed,
    this.secondValueButtonLabel,
    this.onSecondValueButtonPressed,
    this.thirdValueButtonLabel,
    this.onThirdValueButtonPressed,
    // Info Message.
    this.infoMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    // Access translated emotions.
    final Map<String, String> translatedEmotions = EmotionData.emotionsByTypeAndLanguage();
    
    return Card(
      elevation: hideCard ? 0.0 : null,
      color: hideCard ? Colors.transparent : null,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0),
            horizontalTitleGap: 5.0,
            leading: Icon(
              icon,
              color: Theme.of(context).primaryIconTheme.color,
              size: Theme.of(context).primaryIconTheme.size,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                : null,
            trailing: trailingIcon != null
                ? IconButton(
                    icon: Icon(
                      trailingIcon,
                      color: trailingIconColor,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    onPressed: onTrailingIconPressed,
                    tooltip: trailingIconTooltip,
                  )
                : null,
          ),
          if (requiredField)
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
          if (requiredField == false) const SizedBox(height: 10.0),
          // * Add emotion button.
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: CustomDropDownButton(
              label: addEmotionButtonLabel,
              onTap: onAddEmotion,
            ),
          ),
          const SizedBox(height: 10.0),
          Visibility(
            visible: emotionData.emotions.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: List.generate(
                  emotionData.emotions.length,
                  (index) {
                    // Helper variables.
                    final EmotionItem emotionItem = emotionData.emotions[index];

                    final String translatedEmotion = translatedEmotions[emotionItem.emotion] ?? '';

                    return Chip(
                      key: UniqueKey(),
                      label: Text(
                        '$translatedEmotion · ${emotionItem.intensity}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      onDeleted: () => onEmotionRemoved(emotionItem, index),
                    );
                  },
                ),
              ),
            ),
          ),
          if (firstValueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 15.0),
              child: CustomDropDownButton(
                label: firstValueButtonLabel!,
                onTap: onFirstValueButtonPressed!,
              ),
            ),
          if (secondValueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 15.0),
              child: CustomDropDownButton(
                label: secondValueButtonLabel!,
                onTap: onSecondValueButtonPressed!,
              ),
            ),
          if (thirdValueButtonLabel != null)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 15.0),
              child: CustomDropDownButton(
                label: thirdValueButtonLabel!,
                onTap: onThirdValueButtonPressed!,
              ),
            ),
          const SizedBox(height: 20.0),
          // * Info Message.
          Visibility(
            visible: infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
