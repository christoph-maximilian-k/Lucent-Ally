import 'package:flutter/material.dart';
import 'package:lucent_ally/widgets/customs/custom_date_time_zone.dart.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/tags/tag.dart';

// Widgets.
import '/widgets/customs/custom_text_field.dart';
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_tags_input_tile.dart';

class CustomLocationInputTile extends StatefulWidget {
  // Indications.
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool requiredField;
  final LocationData locationData;

  // Date.
  final String dateButtonLabel;
  final Function() onChooseDate;

  // Time.
  final String timeButtonLabel;
  final Function() onChooseTime;

  // Timezone.
  final String timezoneButtonLabel;
  final Function() onChooseTimezone;

  // Current location.
  final bool isCurrentLocation;

  // Latitude text field.
  final String latitudeLabel;
  final Key? latitudeKey;
  final String latitudeInitialData;
  final IconData? latitudeTrailingIcon;
  final Function(TextEditingController) latitudeTrailingPressed;
  final Function(String, TextEditingController)? latitudeOnChanged;
  final Function(String, TextEditingController)? latitudeOnSubmitted;
  final bool latitudeShouldRequestFocus;

  // Longitude text field.
  final String longitudeLabel;
  final Key? longitudeKey;
  final String longitudeInitialData;
  final IconData? longitudeTrailingIcon;
  final Function(TextEditingController) longitudeTrailingPressed;
  final Function(String, TextEditingController)? longitudeOnChanged;
  final Function(String, TextEditingController)? longitudeOnSubmitted;
  final bool longitudeShouldRequestFocus;

  // Info Message.
  final String infoMessage;

  // Button.
  final String? buttonLabel;
  final Function()? onButtonPressed;

  // Trailing Icon.
  final IconData? trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function(TextEditingController, TextEditingController) onTrailingIconPressed;

  // First additional button.
  final String? firstButtonLabel;
  final Function()? onFirstButtonPressed;

  // Second additional button.
  final String? secondButtonLabel;
  final Function()? onSecondButtonPressed;

  // Tags.
  final Function() getTagsFuture;
  final Function(Tag, int) onTagRemoved;
  final Function(String, TextEditingController) onTagChanged;
  final Function(String, TextEditingController) onTagSubmitted;
  final List<String> tagsSuggestions;
  final Function(TextEditingController, String, int) onSuggestionTap;

  final String? chooseTagsDatapointLabel;
  final Function()? onChooseTagsDatapoint;

  // Match Date with datapoint button.
  final String? labelOnPressedChooseLocationDataDateDatapoint;
  final Function()? onPressedChooseLocationDataDateDatapoint;

  const CustomLocationInputTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    this.subtitle,
    this.requiredField = false,
    required this.locationData,
    // Date.
    required this.dateButtonLabel,
    required this.onChooseDate,
    // Time.
    required this.timeButtonLabel,
    required this.onChooseTime,
    // Timezone.
    required this.timezoneButtonLabel,
    required this.onChooseTimezone,
    // Current location.
    required this.isCurrentLocation,
    // Latitude.
    required this.latitudeLabel,
    this.latitudeKey,
    required this.latitudeInitialData,
    this.latitudeTrailingIcon,
    required this.latitudeTrailingPressed,
    this.latitudeOnChanged,
    this.latitudeOnSubmitted,
    this.latitudeShouldRequestFocus = false,
    // Longitude.
    required this.longitudeLabel,
    this.longitudeKey,
    required this.longitudeInitialData,
    this.longitudeTrailingIcon,
    required this.longitudeTrailingPressed,
    this.longitudeOnChanged,
    this.longitudeOnSubmitted,
    this.longitudeShouldRequestFocus = false,
    // Info Message.
    this.infoMessage = '',
    // Button.
    this.buttonLabel,
    this.onButtonPressed,
    // Trailing Icon.
    this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    required this.onTrailingIconPressed,
    // First additional button.
    this.firstButtonLabel,
    this.onFirstButtonPressed,
    // Second additional button.
    this.secondButtonLabel,
    this.onSecondButtonPressed,
    // Match Date with datapoint button.
    this.labelOnPressedChooseLocationDataDateDatapoint,
    this.onPressedChooseLocationDataDateDatapoint,
    // Tags.
    required this.getTagsFuture,
    required this.onTagRemoved,
    required this.onTagChanged,
    required this.onTagSubmitted,
    required this.tagsSuggestions,
    required this.onSuggestionTap,
    this.chooseTagsDatapointLabel,
    this.onChooseTagsDatapoint,
  });

  @override
  State<CustomLocationInputTile> createState() => _CustomLocationInputTileState();
}

class _CustomLocationInputTileState extends State<CustomLocationInputTile> {
  // Init TextEditingControllers.
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  @override
  void initState() {
    // Set initial data to controllers.
    latitudeController.text = widget.latitudeInitialData;
    longitudeController.text = widget.longitudeInitialData;

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of controllers.
    latitudeController.dispose();
    longitudeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Card(
        child: Column(
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
                      onPressed: () => widget.onTrailingIconPressed(latitudeController, longitudeController),
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
            // * Latitude.
            Padding(
              padding: EdgeInsets.only(left: 4.0, right: 4.0, top: widget.requiredField ? 0.0 : 10.0, bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 4.0),
                    width: 80,
                    child: Text(
                      widget.latitudeLabel,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Expanded(
                    child: widget.isCurrentLocation == false
                        ? CustomTextField(
                            key: widget.latitudeKey,
                            maxLines: 1,
                            textEditingController: latitudeController,
                            shouldRequestFocus: widget.latitudeShouldRequestFocus,
                            initialData: widget.latitudeInitialData,
                            textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                            textFieldTrailingIcon: widget.latitudeTrailingIcon,
                            onTextFieldTrailingIconPressed: (final TextEditingController localLatitudeContontroller) => widget.latitudeTrailingPressed(localLatitudeContontroller),
                            onSubmitted: widget.latitudeOnSubmitted,
                            onChanged: widget.latitudeOnChanged,
                          )
                        : SelectableText(
                            widget.latitudeInitialData,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                  ),
                ],
              ),
            ),
            // * Longitude.
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 15.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 4.0),
                    width: 80,
                    child: Text(
                      widget.longitudeLabel,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Expanded(
                    child: widget.isCurrentLocation == false
                        ? CustomTextField(
                            key: widget.longitudeKey,
                            textEditingController: longitudeController,
                            maxLines: 1,
                            shouldRequestFocus: widget.longitudeShouldRequestFocus,
                            initialData: widget.longitudeInitialData,
                            textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                            textFieldTrailingIcon: widget.longitudeTrailingIcon,
                            onTextFieldTrailingIconPressed: (final TextEditingController localLongitudeController) => widget.longitudeTrailingPressed(localLongitudeController),
                            onSubmitted: widget.longitudeOnSubmitted,
                            onChanged: widget.longitudeOnChanged,
                          )
                        : SelectableText(
                            widget.longitudeInitialData,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                  ),
                ],
              ),
            ),
            if (widget.buttonLabel != null)
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0, top: 15.0),
                child: CustomElevatedButton(
                  onPressed: widget.onButtonPressed,
                  label: widget.buttonLabel!,
                ),
              ),
            if (widget.firstButtonLabel != null)
              Container(
                margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: CustomDropDownButton(
                  label: widget.firstButtonLabel!,
                  onTap: widget.onFirstButtonPressed!,
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
            const SizedBox(height: 10.0),
            Text(
              labels.basicLabelsDate(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20.0),
            // * Location date.
            CustomDateTimeZone(
              // Date.
              dateButtonLabel: widget.dateButtonLabel,
              dateButtonSublabel: widget.locationData.createdAtInUtc == null || widget.locationData.createdAtTimezone.isEmpty ? null : labels.dateOnlyFormat(),
              onPressedDate: () => widget.onChooseDate(),
              // Time.
              timeButtonLabel: widget.timeButtonLabel,
              onPressedTime: () => widget.onChooseTime(),
              // Timezone.
              timezoneButtonLabel: widget.timezoneButtonLabel,
              onPressedTimezone: () => widget.onChooseTimezone(),
            ),
            // * User is in import match mode. Display connect payment date with datapoint button.
            if (widget.labelOnPressedChooseLocationDataDateDatapoint != null)
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CustomDropDownButton(
                  label: widget.labelOnPressedChooseLocationDataDateDatapoint!,
                  onTap: () => widget.onPressedChooseLocationDataDateDatapoint!(),
                ),
              ),
            const SizedBox(height: 15.0),
            Text(
              labels.basicLabelsTags(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomTagsInputTile(
                hideIndications: true,
                hideCard: true,
                getTagsFuture: widget.getTagsFuture,
                tagsData: widget.locationData.tagsData,
                tagsSuggestions: widget.tagsSuggestions,
                onTagChanged: (value, controller) => widget.onTagChanged(value, controller),
                onTagSubmitted: (value, controller) => widget.onTagSubmitted(value, controller),
                onSuggestionTap: (controller, value, index) => widget.onSuggestionTap(controller, value, index),
                onTagRemoved: (tag, index) => widget.onTagRemoved(tag, index),
                buttonLabel: widget.chooseTagsDatapointLabel,
                onButtonPressed: widget.onChooseTagsDatapoint,
              ),
            ),
            Visibility(
              visible: widget.infoMessage.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.infoMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
