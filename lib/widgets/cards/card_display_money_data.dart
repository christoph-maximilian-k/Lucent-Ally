import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// User with Settings and labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/chip_items/chip_items.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/tags/tag.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_notifications_tile.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_horizontal_divider.dart';
import '/widgets/customs/custom_text_button.dart';
import '/widgets/cards/card_display_tags.dart';

class CardDisplayMoneyData extends StatefulWidget {
  // Indications.
  final IconData icon;
  final String title;

  // Data.
  final MoneyData moneyData;
  final DateTime entryCreatedAtInUtc;

  // Trailing.
  final Function()? onMorePressed;

  // ExchangeRate
  final String defaultCurrency;
  final Function() getExchangeRateFuture;
  final Function() onSetCustomExchangeRate;

  // Thirdline.
  final String? thirdline;
  final String? thirdlineTitle;

  // First Trailing Icon Button.
  final IconData? firstTrailingIcon;
  final String? firstTrailingIconTooltip;
  final Function()? firstTrailingOnPressed;

  // Second Trailing Icon Button.
  final IconData? secondTrailingIcon;
  final Function()? secondTrailingOnPressed;
  final String secondTrailingTooltip;

  // Chip Items.
  final ChipItems? chipItems;

  // Switch.
  final String switchLabel;
  final bool valueSwitch;
  final Function(bool)? onSwitchChanged;

  // Drop down button.
  final String? dropDownLabel;
  final Function()? onDropDownPressed;

  // Info Message.
  final String infoMessage;

  // Pending Notifications.
  final List<PendingNotificationRequest> pendingNotifications;
  final bool pendingNotificationsLoading;
  final Function(PendingNotificationRequest, int)? onNotificationSelected;
  final Function(PendingNotificationRequest, int)? onDeleteNotification;

  // Tags.
  final Function() getTagsFuture;
  final Function(Tag) onTabTag;

  const CardDisplayMoneyData({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    // Data.
    required this.moneyData,
    required this.entryCreatedAtInUtc,
    // ExchangeRate.
    required this.defaultCurrency,
    required this.getExchangeRateFuture,
    required this.onSetCustomExchangeRate,
    // Trailing.
    this.onMorePressed,
    // Thirdline.
    this.thirdline,
    this.thirdlineTitle,
    // First Trailing Icon Button.
    this.firstTrailingIcon,
    this.firstTrailingIconTooltip,
    this.firstTrailingOnPressed,
    // Second Trailing Icon Button.
    this.secondTrailingIcon,
    this.secondTrailingOnPressed,
    this.secondTrailingTooltip = '',
    // ChipItems.
    this.chipItems,
    // Switch.
    this.infoMessage = '',
    // Drop down button.
    this.dropDownLabel,
    this.onDropDownPressed,
    // Info Message.
    this.switchLabel = '',
    this.valueSwitch = false,
    this.onSwitchChanged,
    // Pending Notifications.
    this.pendingNotifications = const [],
    this.pendingNotificationsLoading = false,
    this.onNotificationSelected,
    this.onDeleteNotification,
    // Tags.
    required this.getTagsFuture,
    required this.onTabTag,
  });

  @override
  State<CardDisplayMoneyData> createState() => _CardDisplayMoneyDataState();
}

class _CardDisplayMoneyDataState extends State<CardDisplayMoneyData> {
  late Future<Map<String, dynamic>> _dataFuture;

  /// This function can be used to retrigger getting exchange rates.
  void _retriggerGetExchangeRate() {
    // Update the future and trigger a rebuild.
    setState(() {
      _dataFuture = widget.getExchangeRateFuture();
    });
  }

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.getExchangeRateFuture();
  }

  @override
  void didUpdateWidget(covariant CardDisplayMoneyData oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Convenience variables.
    final bool currencyChanged = widget.moneyData.currencyCode != oldWidget.moneyData.currencyCode;
    final bool dateChanged = widget.entryCreatedAtInUtc != oldWidget.entryCreatedAtInUtc;
    final bool defaultCurrencyChanged = widget.defaultCurrency != oldWidget.defaultCurrency;
    final bool customExchangeRatesChanged = widget.moneyData.customExchangeRates != oldWidget.moneyData.customExchangeRates;

    // Get exchange rate again.
    if (currencyChanged || defaultCurrencyChanged || customExchangeRatesChanged || dateChanged) {
      // Perform tasks when the data changes.
      _dataFuture = widget.getExchangeRateFuture();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final bool showTags = widget.moneyData.tagsData.tagReferences.isNotEmpty;

    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0),
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
            trailing: widget.onMorePressed != null
                ? IconButton(
                    icon: Icon(
                      AppIcons.moreOptions,
                      color: Theme.of(context).iconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    onPressed: widget.onMorePressed,
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 4.0, bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    '${widget.moneyData.getFormattedNumber} ${widget.moneyData.currencyCode}',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                if (widget.firstTrailingIcon != null)
                  IconButton(
                    icon: Icon(
                      widget.firstTrailingIcon,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    tooltip: widget.firstTrailingIconTooltip,
                    onPressed: widget.firstTrailingOnPressed,
                  ),
                const SizedBox(width: 5.0),
                IconButton(
                  icon: Icon(
                    widget.secondTrailingIcon,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size,
                  ),
                  tooltip: widget.secondTrailingTooltip,
                  onPressed: widget.secondTrailingOnPressed,
                ),
              ],
            ),
          ),
          if (widget.thirdline != null && widget.thirdline!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 4.0, bottom: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  const CustomHorizontalDivider(),
                  const SizedBox(height: 20.0),
                  Text(
                    widget.thirdlineTitle!,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      SelectableText(
                        widget.thirdline!,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          if (widget.defaultCurrency.isNotEmpty && widget.defaultCurrency != widget.moneyData.currencyCode)
            FutureBuilder<Map<String, dynamic>>(
              future: _dataFuture,
              builder: (context, snapshot) {
                // Show loading indication.
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 110.0,
                    child: CustomLoadingSpinner(
                      loadingMessage: labels.loadingMessageExchangeRate(
                        fromCurrencyCode: widget.moneyData.currencyCode,
                        toCurrencyCode: widget.defaultCurrency,
                      ),
                    ),
                  );
                }

                // Convenience variables.
                final Map<String, dynamic>? exchangeRateMap = snapshot.data;

                // Show failure.
                // * Also show failure on initial. This should not occur, but better save then sorry.
                final bool failure = exchangeRateMap == null ? true : exchangeRateMap['status'] == ExchangeRate.exchangeRateStatusFailure || exchangeRateMap['status'] == ExchangeRate.exchangeRateStatusInitial;

                // Show failure.
                if (failure) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0, top: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          labels.failedToAccessExchangeRate(
                            fromCurrencyCode: widget.moneyData.currencyCode,
                            toCurrencyCode: widget.defaultCurrency,
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        CustomTextButton(
                          isOutlined: true,
                          label: labels.basicLabelsTryAgain(),
                          onPressed: () => _retriggerGetExchangeRate(),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  );
                }

                // Convenience variables.
                final bool notFound = exchangeRateMap['status'] == ExchangeRate.exchangeRateStatusNotFoundCloud;
                final bool inFuture = exchangeRateMap['status'] == ExchangeRate.exchangeRateStatusInFuture;

                // Exchange rate was not found in the cloud.
                // * User needs to set a custom one.
                if (notFound || inFuture) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          labels.customExchangeRateRequired(
                            inFuture: inFuture,
                            fromCurrencyCode: widget.moneyData.currencyCode,
                            toCurrencyCode: widget.defaultCurrency,
                          ),
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15.0),
                        CustomTextButton(
                          isOutlined: true,
                          label: labels.basicLabelsSetCustomExchangeRate(
                            value: null,
                            defaultCurrency: widget.defaultCurrency,
                          ),
                          onPressed: widget.onSetCustomExchangeRate,
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          labels.totalConverted(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          // * If a custom one was set, it has priority.
                          '${widget.moneyData.calculateConvertedTotal(
                                exchangeRateToDefault: exchangeRateMap['exchange_rate'],
                              ).toStringAsFixed(2)} ${widget.defaultCurrency}',
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                );
              },
            ),
          Text(
            labels.basicLabelsDate(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20.0),
          Text(
            widget.moneyData.createdAtInUtc == null
                ? ''
                : labels.basicLabelsDateTimeAndTimezone(
                    date: widget.moneyData.getCreatedAt(preserveUtc: true, date: true, time: true),
                    timezone: widget.moneyData.getTimezone(preserveUtc: true),
                  ),
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          if (widget.chipItems != null && widget.chipItems!.items.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 40.0,
                margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                child: Row(
                  children: widget.chipItems!.isLoading
                      ? [
                          const CustomLoadingSpinner(
                            paddingBottom: 5.0,
                          )
                        ]
                      : List<Widget>.generate(
                          widget.chipItems!.items.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: GestureDetector(
                              onTap: widget.chipItems!.items[index].onPressed,
                              child: Chip(
                                label: Text(
                                  widget.chipItems!.items[index].label,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          // * Tags.
          if (showTags)
            Column(
              children: [
                Center(
                  child: Text(
                    labels.basicLabelsTags(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                CardDisplayTags(
                  icon: widget.icon,
                  title: widget.title,
                  showCard: false,
                  showIndications: false,
                  tagsData: widget.moneyData.tagsData,
                  getTagsFuture: widget.getTagsFuture,
                  onTabTag: (final Tag tag) => widget.onTabTag(tag),
                ),
              ],
            ),
          if (widget.pendingNotifications.isNotEmpty)
            CustomNotificationsTile(
              title: labels.customNotificationsTileTitle(),
              pendingNotifications: widget.pendingNotifications,
              pendingNotificationsLoading: widget.pendingNotificationsLoading,
              onNotificationSelected: widget.onNotificationSelected,
              onDeleteNotification: widget.onDeleteNotification,
            ),
          if (widget.dropDownLabel != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: CustomDropDownButton(
                label: widget.dropDownLabel!,
                onTap: widget.onDropDownPressed!,
                maxWidth: 200.0,
              ),
            ),
          if (widget.switchLabel.isNotEmpty)
            CustomSwitchListTile(
              padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 20.0),
              key: UniqueKey(),
              title: widget.switchLabel,
              value: widget.valueSwitch,
              onChanged: widget.onSwitchChanged,
            ),
          Visibility(
            visible: widget.infoMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
              child: Text(
                widget.infoMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
