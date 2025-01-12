import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/payment_data/share_reference.dart';
import '/data/models/members/members.dart';
import '/data/models/members/member.dart';
import '/data/models/tags/tag.dart';
import '/data/models/exchange_rates/exchange_rate.dart';

// Widgets.
import '/widgets/customs/custom_notifications_tile.dart';
import '/widgets/customs/custom_horizontal_divider.dart';
import '/widgets/cards/card_display_tags.dart';
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_text_button.dart';

class CardDisplayExpense extends StatefulWidget {
  // Indications.
  final IconData icon;
  final String title;

  // Trailing.
  final Function()? onMorePressed;

  // Members.
  final Function() getMembersFuture;

  // Tags.
  final Function() getTagsFuture;
  final Function(Tag) onTabTag;

  // ExchangeRate
  final String defaultCurrency;
  final Function() getExchangeRateFuture;
  final Function() onSetCustomExchangeRate;

  // Data.
  final PaymentData paymentData;

  // Info Message.
  final String infoMessage;

  // Pending Notifications.
  final List<PendingNotificationRequest> pendingNotifications;
  final bool pendingNotificationsLoading;
  final Function(PendingNotificationRequest, int)? onNotificationSelected;
  final Function(PendingNotificationRequest, int)? onDeleteNotification;

  const CardDisplayExpense({
    super.key,
    // Indications.
    required this.icon,
    required this.title,
    // Trailing.
    this.onMorePressed,
    // Members.
    required this.getExchangeRateFuture,
    // Tags.
    required this.getTagsFuture,
    required this.onTabTag,
    // ExchangeRate.
    required this.defaultCurrency,
    required this.getMembersFuture,
    required this.onSetCustomExchangeRate,
    // Data.
    required this.paymentData,
    // Info Message.
    this.infoMessage = '',
    // Pending Notifications.
    this.pendingNotifications = const [],
    this.pendingNotificationsLoading = false,
    this.onNotificationSelected,
    this.onDeleteNotification,
  });

  @override
  State<CardDisplayExpense> createState() => _CardDisplayExpenseState();
}

class _CardDisplayExpenseState extends State<CardDisplayExpense> {
  late Future<Members?> _membersFuture;
  late Future<Map<String, dynamic>> _dataFuture;

  /// This function can be used to retrigger getting exchange rates.
  void _retriggerGetExchangeRate() {
    // Update the future and trigger a rebuild.
    setState(() {
      _dataFuture = widget.getExchangeRateFuture();
    });
  }

  /// This function can be used to retrigger getting members.
  void _retriggerGetMembers() {
    // Update the future and trigger a rebuild.
    setState(() {
      _membersFuture = widget.getMembersFuture();
    });
  }

  @override
  void initState() {
    super.initState();
    _dataFuture = widget.getExchangeRateFuture();
    _membersFuture = widget.getMembersFuture();
  }

  @override
  void didUpdateWidget(covariant CardDisplayExpense oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Convenience variables.
    final bool currencyChanged = widget.paymentData.currencyCode != oldWidget.paymentData.currencyCode;
    final bool dateChanged = widget.paymentData.paymentDateInUtc != oldWidget.paymentData.paymentDateInUtc;
    final bool defaultCurrencyChanged = widget.defaultCurrency != oldWidget.defaultCurrency;
    final bool customExchangeRatesChanged = widget.paymentData.customExchangeRates != oldWidget.paymentData.customExchangeRates;

    // Get exchange rate again.
    if (currencyChanged || defaultCurrencyChanged || customExchangeRatesChanged || dateChanged) {
      // Perform tasks when the data changes.
      _dataFuture = widget.getExchangeRateFuture();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final bool showTags = widget.paymentData.tagsData.tagReferences.isNotEmpty;

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
          FutureBuilder<Members?>(
            future: _membersFuture,
            builder: (context, snapshot) {
              // Show loading indication.
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: CustomLoadingSpinner(),
                );
              }

              // Convenience variables.
              final Members? members = snapshot.data;

              // Show failure.
              final bool failure = members == null || members.items.isEmpty;

              // Show failure.
              if (failure) {
                return Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0, top: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        labels.failedToAccessMembers(),
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10.0),
                      CustomTextButton(
                        isOutlined: true,
                        label: labels.basicLabelsTryAgain(),
                        onPressed: () => _retriggerGetMembers(),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                );
              }

              // Access the member.
              Member? paidBy = members.getById(
                memberId: widget.paymentData.paidById,
              );

              // Member is unknown.
              paidBy ??= Member.unknownMember(memberId: widget.paymentData.paidById);

              return Column(
                children: [
                  // * Expense.
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            labels.totalAmount(),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.paymentData.total} ${widget.paymentData.currencyCode}',
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  if (widget.defaultCurrency.isNotEmpty && widget.defaultCurrency != widget.paymentData.currencyCode)
                    FutureBuilder<Map<String, dynamic>>(
                      future: _dataFuture,
                      builder: (context, snapshot) {
                        // Show loading indication.
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(
                            height: 110.0,
                            child: CustomLoadingSpinner(
                              loadingMessage: labels.loadingMessageExchangeRate(
                                fromCurrencyCode: widget.paymentData.currencyCode,
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
                                    fromCurrencyCode: widget.paymentData.currencyCode,
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
                                    fromCurrencyCode: widget.paymentData.currencyCode,
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
                                  '${widget.paymentData.calculateConvertedTotal(
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
                  const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 10.0, marginBottom: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100.0,
                          child: Text(
                            labels.paidBy(),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            paidBy.memberName,
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  if (widget.paymentData.isCompensated)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
                        child: Text(
                          labels.displayIsCompensated(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                  const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 10.0, marginBottom: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          labels.expenseDate(),
                          maxLines: 2,
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Text(
                          widget.paymentData.paymentDateInUtc == null
                              ? ''
                              : labels.basicLabelsDateTimeAndTimezone(
                                  date: widget.paymentData.getCreatedAt(preserveUtc: true, date: true, time: true),
                                  timezone: widget.paymentData.getCreatedAtTimezone(preserveUtc: true),
                                ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ),
                  const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 10.0, marginBottom: 10.0),
                  Center(
                    child: Text(
                      labels.expenseDistribution(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  ...List<Widget>.generate(
                    widget.paymentData.shareReferences.items.length,
                    (index) {
                      // Access Share.
                      final ShareReference shareReference = widget.paymentData.shareReferences.items[index];

                      // Access the member.
                      Member? member = members.getById(
                        memberId: shareReference.id,
                      );

                      // Member is unknown.
                      member ??= Member.unknownMember(memberId: shareReference.id);

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 120.0,
                              child: Text(
                                member.memberName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                shareReference.valueAsDouble.toStringAsFixed(2),
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                          ],
                        ),
                      );
                    },
                  ),
                  // * Tags.
                  if (showTags)
                    Column(
                      children: [
                        const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 10.0, marginBottom: 10.0),
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
                          tagsData: widget.paymentData.tagsData,
                          getTagsFuture: widget.getTagsFuture,
                          onTabTag: (final Tag tag) => widget.onTabTag(tag),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10.0),
                  if (widget.pendingNotifications.isNotEmpty)
                    CustomNotificationsTile(
                      title: labels.customNotificationsTileTitle(),
                      pendingNotifications: widget.pendingNotifications,
                      pendingNotificationsLoading: widget.pendingNotificationsLoading,
                      onNotificationSelected: widget.onNotificationSelected,
                      onDeleteNotification: widget.onDeleteNotification,
                    ),
                  Visibility(
                    visible: widget.infoMessage.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                      child: Text(
                        widget.infoMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
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
