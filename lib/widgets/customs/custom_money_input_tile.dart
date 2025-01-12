import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/tags/tag.dart';

// Widgets.
import '/widgets/customs/custom_text_field.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_tags_input_tile.dart';
import '/widgets/customs/custom_date_time_zone.dart.dart';

class CustomMoneyInputTile extends StatefulWidget {
  // Indications.
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool hideCard;
  final double? textFieldHeight;
  final bool requiredField;
  final String defaultCurrencyCode;
  final bool isImportMatch;
  final bool isDefault;

  final MoneyData moneyData;

  // Date.
  final String dateButtonLabel;
  final Function() onChooseDate;

  // Time.
  final String timeButtonLabel;
  final Function() onChooseTime;

  // Timezone.
  final String timezoneButtonLabel;
  final Function() onChooseTimezone;

  // Text Field.
  final Key? textFieldKey;
  final TextInputType textInputType;
  final bool shouldRequestFocus;
  final String initialData;
  final Function(String, TextEditingController)? onChanged;
  final Function(String value, TextEditingController controller)? onSubmitted;
  final String? hint;

  // Custom exchange rate.
  final String currentCurrency;
  final String customExchangeRateInfoMessage;
  final String customExchangeRateButtonLabel;
  final Function() onPressedDeleteCustomExchangeRate;
  final Function() onPressedCustomExchangeRateButton;
  final String? customExchangeRateDatapointLabel;
  final String? customExchangeRateDatapointInfoMessage;
  final Function()? onPressedCustomExchangeRateDatapoint;

  // Exchange rate defaults.
  final String labelSetExchangeRateDefaults;
  final Function() onPressedSetExchangeRateDefaultsButton;
  final Function(ExchangeRate) onDeleteDefaultExchangeRate;

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
  final IconData trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function(TextEditingController) onTrailingIconPressed;

  // Info Message.
  final String infoMessage;

  // Currency Button.
  final String currencyButtonLabel;
  final Function() onCurrencyButtonPressed;

  // First Switch
  final String switchLabelFirst;
  final bool valueFirstSwitch;
  final Function(bool)? onFirstSwitchChanged;
  final String? firstSwitchInfoMessage;

  // First Button.
  final String? firstButtonLabel;
  final Function()? firstButtonOnPressed;

  // Second Button.
  final String? secondButtonLabel;
  final Function()? secondButtonOnPressed;

  // Tags.
  final Function() getTagsFuture;
  final Function(Tag, int) onTagRemoved;
  final Function(String, TextEditingController) onTagChanged;
  final Function(String, TextEditingController) onTagSubmitted;
  final List<String> tagsSuggestions;
  final Function(TextEditingController, String, int) onSuggestionTap;

  final String? chooseTagsDatapointLabel;
  final Function()? onChooseTagsDatapoint;

  // Match Expense Date with datapoint button.
  final String? labelOnPressedChooseMoneyDataDateDatapoint;
  final Function()? onPressedChooseMoneyDataDateDatapoint;

  const CustomMoneyInputTile({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    required this.moneyData,
    required this.isDefault,
    this.subtitle,
    this.hideCard = false,
    this.requiredField = false,
    required this.defaultCurrencyCode,
    required this.isImportMatch,
    // Date.
    required this.dateButtonLabel,
    required this.onChooseDate,
    // Time.
    required this.timeButtonLabel,
    required this.onChooseTime,
    // Timezone.
    required this.timezoneButtonLabel,
    required this.onChooseTimezone,
    // Custom Exchange rate.
    required this.currentCurrency,
    required this.customExchangeRateInfoMessage,
    required this.customExchangeRateButtonLabel,
    required this.onPressedDeleteCustomExchangeRate,
    required this.onPressedCustomExchangeRateButton,
    this.customExchangeRateDatapointLabel,
    this.customExchangeRateDatapointInfoMessage,
    this.onPressedCustomExchangeRateDatapoint,
    // Exchange rate defaults.
    required this.labelSetExchangeRateDefaults,
    required this.onPressedSetExchangeRateDefaultsButton,
    required this.onDeleteDefaultExchangeRate,
    // Text Field.
    this.textFieldKey,
    this.textInputType = TextInputType.text,
    this.shouldRequestFocus = false,
    this.initialData = '',
    this.onChanged,
    this.onSubmitted,
    this.hint,
    this.textFieldHeight,
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
    required this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    required this.onTrailingIconPressed,
    // Info Message.
    this.infoMessage = '',
    // Button.
    required this.currencyButtonLabel,
    required this.onCurrencyButtonPressed,
    // First Switch.
    this.switchLabelFirst = '',
    this.valueFirstSwitch = false,
    this.onFirstSwitchChanged,
    this.firstSwitchInfoMessage,
    // First button label.
    this.firstButtonLabel,
    this.firstButtonOnPressed,
    // Second Button.
    this.secondButtonLabel,
    this.secondButtonOnPressed,
    // Match Expense Date with datapoint button.
    this.labelOnPressedChooseMoneyDataDateDatapoint,
    this.onPressedChooseMoneyDataDateDatapoint,
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
  State<CustomMoneyInputTile> createState() => _CustomMoneyInputTileState();
}

class _CustomMoneyInputTileState extends State<CustomMoneyInputTile> {
  // Create controller.
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // Set initial data to controller.
    controller.text = widget.initialData;

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of controller.
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.hideCard ? 0.0 : null,
      color: widget.hideCard ? Colors.transparent : null,
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
            trailing: IconButton(
              icon: Icon(
                widget.trailingIcon,
                color: widget.trailingIconColor,
                size: Theme.of(context).primaryIconTheme.size,
              ),
              onPressed: () => widget.onTrailingIconPressed(controller),
              tooltip: widget.trailingIconTooltip,
            ),
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
          Builder(
            builder: (context) {
              // ! Ensure that a default currency code is available.
              // * Unless this is a set default. In that case do not access exchange rates.
              if (widget.isDefault == false && widget.defaultCurrencyCode.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Text(
                    labels.defaultCurrencyRequired(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                );
              }

              // * Display content.
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                    child: Text(
                      labels.positiveForIncomeNegativeForExpenses(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150.0,
                        child: CustomTextField(
                          key: widget.textFieldKey,
                          textEditingController: controller,
                          textFieldHeight: widget.textFieldHeight,
                          shouldRequestFocus: widget.shouldRequestFocus,
                          initialData: widget.initialData,
                          hint: widget.hint,
                          textInputType: widget.textInputType,
                          suffixIconData: widget.suffixIcon,
                          onSuffixIconPressed: widget.suffixPressed,
                          textFieldLeadingWidget: widget.textFieldLeadingWidget,
                          onTextFieldLeadingPressed: widget.onTextFieldLeadingPressed,
                          textFieldTrailingIcon: widget.textFieldTrailingIcon,
                          textFieldTrailingIconTooltip: widget.textFieldTrailingIconTooltip,
                          onTextFieldTrailingIconPressed: (final TextEditingController controller) => widget.onTextFieldTrailingIconPressed == null ? () {} : widget.onTextFieldTrailingIconPressed!(controller),
                          onSubmitted: widget.onSubmitted,
                          onChanged: widget.onChanged,
                        ),
                      ),
                      CustomDropDownButton(
                        label: widget.currencyButtonLabel,
                        onTap: () => widget.onCurrencyButtonPressed(),
                      ),
                    ],
                  ),
                  if (widget.isImportMatch == false && widget.isDefault == false && widget.defaultCurrencyCode != widget.currentCurrency)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDropDownButton(
                                label: widget.customExchangeRateButtonLabel,
                                onTap: widget.onPressedCustomExchangeRateButton,
                              ),
                              IconButton(
                                onPressed: widget.onPressedDeleteCustomExchangeRate,
                                icon: Icon(
                                  AppIcons.delete,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0, bottom: 10.0),
                            child: Text(
                              widget.customExchangeRateInfoMessage,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (widget.isDefault || widget.moneyData.customExchangeRates.items.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
                      child: Column(
                        children: [
                          if (widget.isDefault)
                            Padding(
                              padding: widget.moneyData.customExchangeRates.items.isNotEmpty ? EdgeInsets.only(bottom: 20.0) : EdgeInsets.only(bottom: 0.0),
                              child: CustomDropDownButton(
                                isOutlined: true,
                                label: widget.labelSetExchangeRateDefaults,
                                onTap: widget.onPressedSetExchangeRateDefaultsButton,
                              ),
                            ),
                          if (widget.moneyData.customExchangeRates.items.isNotEmpty)
                            Text(
                              labels.customExchangeRates(isDefault: widget.isDefault),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          if (widget.moneyData.customExchangeRates.items.isNotEmpty)
                            Container(
                              height: 55.0,
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 4.0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.moneyData.customExchangeRates.items.length,
                                itemBuilder: (context, index) {
                                  // Convenience variables.
                                  final String fromCurrencyCode = widget.moneyData.customExchangeRates.items[index].fromCurrencyCode;
                                  final String toCurrencyCode = widget.moneyData.customExchangeRates.items[index].toCurrencyCode;
                                  final String exchangeRate = widget.moneyData.customExchangeRates.items[index].exchangeRate.toString();

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Chip(
                                      label: Text(
                                        labels.defaultExchangeRatesChipLabel(
                                          exchangeRate: exchangeRate,
                                          fromCurrency: fromCurrencyCode,
                                          toCurrency: toCurrencyCode,
                                        ),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.labelSmall,
                                      ),
                                      onDeleted: () => widget.onDeleteDefaultExchangeRate(widget.moneyData.customExchangeRates.items[index]),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (widget.firstButtonLabel != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
                      child: CustomDropDownButton(
                        label: widget.firstButtonLabel!,
                        onTap: widget.firstButtonOnPressed!,
                      ),
                    ),
                  if (widget.secondButtonLabel != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0, bottom: 8.0),
                      child: CustomDropDownButton(
                        label: widget.secondButtonLabel!,
                        onTap: widget.secondButtonOnPressed!,
                      ),
                    ),
                  if (widget.customExchangeRateDatapointLabel != null)
                    Column(
                      children: [
                        CustomDropDownButton(
                          label: widget.customExchangeRateDatapointLabel!,
                          onTap: widget.onPressedCustomExchangeRateDatapoint!,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                          child: Text(
                            widget.customExchangeRateDatapointInfoMessage!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 30.0),
                  Text(
                    labels.basicLabelsDate(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20.0),
                  CustomDateTimeZone(
                    // Date.
                    dateButtonLabel: widget.dateButtonLabel,
                    dateButtonSublabel: widget.moneyData.createdAtInUtc == null || widget.moneyData.timezone.isEmpty ? null : labels.dateOnlyFormat(),
                    onPressedDate: () => widget.onChooseDate(),
                    // Time.
                    timeButtonLabel: widget.timeButtonLabel,
                    onPressedTime: widget.onChooseTime,
                    // Timezone.
                    timezoneButtonLabel: widget.timezoneButtonLabel,
                    onPressedTimezone: () => widget.onChooseTimezone(),
                  ),
                  // * User is in import match mode. Display connect payment date with datapoint button.
                  if (widget.isImportMatch)
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                      child: CustomDropDownButton(
                        label: widget.labelOnPressedChooseMoneyDataDateDatapoint!,
                        onTap: () => widget.onPressedChooseMoneyDataDateDatapoint!(),
                      ),
                    ),
                  const SizedBox(height: 10.0),
                  Text(
                    labels.basicLabelsTags(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomTagsInputTile(
                      hideIndications: true,
                      hideCard: true,
                      getTagsFuture: widget.getTagsFuture,
                      tagsData: widget.moneyData.tagsData,
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
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                      child: Text(
                        widget.infoMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.switchLabelFirst.isNotEmpty,
                    child: CustomSwitchListTile(
                      padding: const EdgeInsets.only(top: 15.0, left: 20.0, bottom: 15.0, right: 15.0),
                      key: UniqueKey(),
                      title: widget.switchLabelFirst,
                      value: widget.valueFirstSwitch,
                      onChanged: widget.onFirstSwitchChanged,
                      infoMessage: widget.firstSwitchInfoMessage,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
