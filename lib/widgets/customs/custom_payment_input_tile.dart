import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/members/members.dart';
import '/data/models/members/member.dart';
import '/data/models/tags/tag.dart';
import '/data/models/field_types/payment_data/share_reference.dart';
import '/data/models/references/member_to_import_reference/member_to_import_reference.dart';

// Widgets.
import '/widgets/customs/custom_text_field.dart';
import '/widgets/customs/custom_horizontal_divider.dart';
import '/widgets/customs/custom_switch_list_tile.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_tags_input_tile.dart';
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_date_time_zone.dart.dart';

class CustomPaymentInputTile extends StatefulWidget {
  // Indications.
  final bool isLoading;
  final bool hasFailure;
  final bool requiredField;

  final bool isDefault;
  final String isDefaultInfoMessage;

  final bool isImportMatch;

  final IconData icon;
  final String title;
  final String? subtitle;

  // Custom exchange rate.
  final String defaultCurrencyCode;
  final String currentCurrency;
  final String customExchangeRateInfoMessage;
  final String customExchangeRateButtonLabel;
  final Function() onPressedDeleteCustomExchangeRate;
  final Function() onPressedCustomExchangeRateButton;
  final String? customExchangeRateDatapointLabel;
  final String? customExchangeRateDatapointInfoMessage;
  final Function()? onPressedCustomExchangeRateDatapoint;

  // Trailing Icon.
  final IconData trailingIcon;
  final Color? trailingIconColor;
  final String? trailingIconTooltip;
  final Function(TextEditingController) onTrailingIconPressed;

  // Data.
  final PaymentData expenseData;
  final Function(String, TextEditingController) onTotalAmountChanged;
  final Function onSelectCurrency;

  final String paidByButtonLabel;
  final Function() selectPaidBy;

  final Function(bool) onIsCompensatedChanged;

  final Function(bool) onDistributeEquallyChanged;
  final Function(String, TextEditingController, String) onMemberValueChanged;
  final Function(bool?, String) onMemberSelected;

  // Payment date.
  final String dateButtonLabel;
  final Function() onChooseExpenseDate;

  // Payment time.
  final String timeButtonLabel;
  final Function() onChooseTime;

  // Timezone.
  final String timezoneButtonLabel;
  final Function() onChooseTimezone;

  // Total amount buttons.
  final String? totalAmountFirstButtonLabel;
  final Function()? onPressedTotalAmountFirstButton;

  final String? totalAmountSecondButtonLabel;
  final Function()? onPressedTotalAmountSecondButton;

  // Is compensated button.
  final String? isCompensatedButtonLabel;
  final Function()? onPressedIsCompensatedButton;

  // Add member button.
  final Function(Member)? onChooseMemberDatapointPressed;

  // Add Member button.
  final Function()? onPressedAddMember;

  // On Change force missing member value import.
  final Function(bool)? onChangeForceMissingMemberValueImport;

  // Match Expense Date with datapoint button.
  final String? labelOnPressedChooseExpenseDataDatapoint;
  final Function()? onPressedChooseExpenseDataDatapoint;

  // Tags.
  final Function() getTagsFuture;
  final Function(Tag, int) onTagRemoved;
  final Function(String, TextEditingController) onTagChanged;
  final Function(String, TextEditingController) onTagSubmitted;
  final List<String> tagsSuggestions;
  final Function(TextEditingController, String, int) onSuggestionTap;

  final String? chooseTagsDatapointLabel;
  final Function()? onChooseTagsDatapoint;

  // Info Message.
  final String infoMessage;

  const CustomPaymentInputTile({
    super.key,
    // Indications.
    required this.isLoading,
    required this.hasFailure,
    required this.isDefault,
    required this.isDefaultInfoMessage,
    required this.icon,
    required this.title,
    required this.isImportMatch,
    this.subtitle,
    this.requiredField = false,
    // Custom Exchange rate.
    required this.defaultCurrencyCode,
    required this.currentCurrency,
    required this.customExchangeRateInfoMessage,
    required this.customExchangeRateButtonLabel,
    required this.onPressedDeleteCustomExchangeRate,
    required this.onPressedCustomExchangeRateButton,
    this.customExchangeRateDatapointLabel,
    this.customExchangeRateDatapointInfoMessage,
    this.onPressedCustomExchangeRateDatapoint,
    // Trailing Icon.
    required this.trailingIcon,
    this.trailingIconColor,
    this.trailingIconTooltip,
    required this.onTrailingIconPressed,
    // Data.
    required this.expenseData,
    required this.onTotalAmountChanged,
    required this.onSelectCurrency,
    required this.onIsCompensatedChanged,
    required this.onDistributeEquallyChanged,
    required this.onMemberValueChanged,
    required this.onMemberSelected,
    required this.dateButtonLabel,
    required this.onChooseExpenseDate,
    required this.onChooseTime,
    required this.timeButtonLabel,
    required this.onChooseTimezone,
    required this.timezoneButtonLabel,
    required this.paidByButtonLabel,
    required this.selectPaidBy,
    // Total amount buttons.
    this.totalAmountFirstButtonLabel,
    this.onPressedTotalAmountFirstButton,
    this.totalAmountSecondButtonLabel,
    this.onPressedTotalAmountSecondButton,
    // Is compensated button.
    this.isCompensatedButtonLabel,
    this.onPressedIsCompensatedButton,
    // Add member button.
    this.onChooseMemberDatapointPressed,
    // Add Member button.
    this.onPressedAddMember,
    // Force missing member value import.
    this.onChangeForceMissingMemberValueImport,
    // Match Expense Date with datapoint button.
    this.labelOnPressedChooseExpenseDataDatapoint,
    this.onPressedChooseExpenseDataDatapoint,
    // Tags.
    required this.getTagsFuture,
    required this.onTagRemoved,
    required this.onTagChanged,
    required this.onTagSubmitted,
    required this.tagsSuggestions,
    required this.onSuggestionTap,
    this.chooseTagsDatapointLabel,
    this.onChooseTagsDatapoint,
    // Info Message.
    this.infoMessage = '',
  });

  @override
  State<CustomPaymentInputTile> createState() => _CustomPaymentInputTileState();
}

class _CustomPaymentInputTileState extends State<CustomPaymentInputTile> {
  // Create Controller.
  final TextEditingController totalPaidController = TextEditingController();

  @override
  void initState() {
    // Set initial data to controller.
    totalPaidController.text = widget.expenseData.total;

    super.initState();
  }

  @override
  void dispose() {
    // Dispose of controller.
    totalPaidController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access state data.
    final double width = MediaQuery.of(context).size.width;

    final String currency = widget.expenseData.currencyCode.isEmpty ? labels.currency() : widget.expenseData.currencyCode;

    final bool hasSelectedMember = widget.expenseData.shareReferences.items.isNotEmpty;

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
              trailing: IconButton(
                icon: Icon(
                  widget.trailingIcon,
                  color: widget.trailingIconColor,
                  size: Theme.of(context).primaryIconTheme.size,
                ),
                onPressed: () => widget.onTrailingIconPressed(totalPaidController),
                tooltip: widget.trailingIconTooltip,
              ),
            ),
            if (widget.isDefault)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0, top: 10.0),
                child: Text(
                  widget.isDefaultInfoMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            if (widget.isDefault == false)
              Column(
                children: [
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
                      // Show loading indication.
                      if (widget.isLoading) {
                        return const SizedBox(
                          height: 80.0,
                          width: 80.0,
                          child: CustomLoadingSpinner(),
                        );
                      }

                      // Show failure.
                      if (widget.hasFailure) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0),
                          child: Text(
                            labels.basicLabelsGenericError(),
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      // ! Ensure that a default currency code is available.
                      if (widget.defaultCurrencyCode.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                          child: Text(
                            labels.defaultCurrencyRequired(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        );
                      }

                      // Convenience variables.
                      final Members members = widget.expenseData.members;
                      final int numberOfMembers = members.items.length;
                      final bool hasMembers = members.items.isNotEmpty;

                      // * This only occures if this is an initial expense creation and group has no participant
                      // * assigned or group cannot be accessed. In this case shared expense cannot be calculated.
                      // * This is for example the case if a user creates an entry without an expense and later on
                      // * edits the entry to add an expense.
                      if (hasMembers == false) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 50.0, bottom: 10.0),
                          child: Text(
                            labels.participantRequired(isImportMatch: widget.isImportMatch),
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 150.0,
                                  child: CustomTextField(
                                    key: const ValueKey('total_amount'),
                                    maxLines: 1,
                                    textEditingController: totalPaidController,
                                    initialData: widget.expenseData.total,
                                    hint: labels.expenseTotalAmount(),
                                    textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                    onChanged: (final String value, final TextEditingController localController) => widget.onTotalAmountChanged(value, localController),
                                  ),
                                ),
                                CustomDropDownButton(
                                  label: currency,
                                  onTap: () => widget.onSelectCurrency(),
                                ),
                              ],
                            ),
                          ),
                          // * Custom exchange rate.
                          if (widget.isImportMatch == false && widget.defaultCurrencyCode != widget.currentCurrency)
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
                          if (widget.totalAmountFirstButtonLabel != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
                              child: CustomDropDownButton(
                                label: widget.totalAmountFirstButtonLabel!,
                                onTap: widget.onPressedTotalAmountFirstButton!,
                              ),
                            ),
                          if (widget.totalAmountSecondButtonLabel != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0, bottom: 8.0),
                              child: CustomDropDownButton(
                                label: widget.totalAmountSecondButtonLabel!,
                                onTap: widget.onPressedTotalAmountSecondButton!,
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
                          const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 20.0, marginBottom: 20.0),
                          Text(
                            labels.expenseInputPaidBy(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Container(
                            width: width * 0.8,
                            height: 50.0,
                            margin: const EdgeInsets.all(5.0),
                            child: CustomDropDownButton(
                              label: widget.paidByButtonLabel,
                              onTap: widget.selectPaidBy,
                            ),
                          ),
                          CustomSwitchListTile(
                            padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0),
                            title: labels.expenseIsCompensated(),
                            value: widget.expenseData.isCompensated,
                            onChanged: (final bool value) => widget.onIsCompensatedChanged(value),
                          ),
                          if (widget.isCompensatedButtonLabel != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0, bottom: 15.0),
                              child: CustomDropDownButton(
                                label: widget.isCompensatedButtonLabel!,
                                onTap: widget.onPressedIsCompensatedButton!,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                            child: Text(
                              labels.infoExpenseIsCompensated(),
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 5.0, marginBottom: 20.0),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                labels.expenseFor(),
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              if (hasMembers && widget.isImportMatch)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: IconButton(
                                      icon: const Icon(
                                        AppIcons.add,
                                      ),
                                      onPressed: () => widget.onPressedAddMember!(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Builder(
                            builder: (context) {
                              // User is in import mode, show adjusted UI.
                              if (widget.isImportMatch) {
                                // A Participant is available. Show members and let user connect them to datapoints or add more members.
                                return Column(
                                  children: [
                                    const SizedBox(height: 15.0),
                                    ...List<Widget>.generate(
                                      numberOfMembers,
                                      (final int index) {
                                        // Access member.
                                        final Member member = members.items[index];

                                        // Access relevant import reference.
                                        final MemberToImportReference? importReference = widget.expenseData.importReferencesMembers?.getByMemberId(
                                          memberId: member.memberId,
                                        );

                                        // Create display value.
                                        final String displayValue = importReference == null ? member.memberName : '${member.memberName} • ${importReference.importReference}';

                                        return Padding(
                                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                          child: CustomDropDownButton(
                                            label: displayValue,
                                            onTap: () => widget.onChooseMemberDatapointPressed!(member),
                                          ),
                                        );
                                      },
                                    ),
                                    CustomSwitchListTile(
                                      padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 20.0),
                                      title: labels.basicLabelsReplaceMissingValues(),
                                      value: widget.expenseData.importReferenceForceMemberValueImport,
                                      onChanged: (final bool value) => widget.onChangeForceMissingMemberValueImport!(value),
                                      infoMessage: labels.basicLabelsInfoMessageForceMemberValueImport(),
                                    ),
                                  ],
                                );
                              }

                              // Not in import match mode, show default UI.
                              return Column(
                                children: [
                                  CustomSwitchListTile(
                                    padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0, top: 10.0),
                                    title: labels.expenseDistributeEqually(),
                                    value: widget.expenseData.distributeEqually,
                                    onChanged: (final bool value) => widget.onDistributeEquallyChanged(value),
                                  ),
                                  Text(
                                    hasSelectedMember == false ? labels.basicLabelsNoMemberSelected() : '',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  ...List<Widget>.generate(
                                    numberOfMembers,
                                    (final int index) {
                                      // Access member.
                                      final Member member = members.items[index];

                                      // Access share.
                                      final ShareReference? shareReference = widget.expenseData.shareReferences.getById(id: member.memberId);

                                      // Is this share selected?
                                      final bool isSelected = shareReference != null;

                                      final String amount = isSelected && shareReference.value.isNotEmpty ? shareReference.valueAsDouble.toStringAsFixed(2) : '0.00';

                                      return Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: isSelected,
                                              onChanged: (value) => widget.onMemberSelected(value, member.memberId),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Expanded(
                                              child: Text(
                                                member.memberName,
                                                style: Theme.of(context).textTheme.displaySmall,
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                            SizedBox(
                                              width: 110.0,
                                              child: widget.expenseData.distributeEqually || isSelected == false
                                                  ? Text(
                                                      amount.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: Theme.of(context).textTheme.labelSmall,
                                                    )
                                                  : CustomTextField(
                                                      maxLines: 1,
                                                      initialData: amount,
                                                      textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                                      onChanged: (value, controller) => widget.onMemberValueChanged(value, controller, member.memberId),
                                                    ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 10.0, marginBottom: 20.0),
                          Text(
                            labels.expenseExpenseDate(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 30.0),
                          CustomDateTimeZone(
                            // Date.
                            dateButtonLabel: widget.dateButtonLabel,
                            dateButtonSublabel: widget.expenseData.paymentDateInUtc == null || widget.expenseData.paymentDateTimezone.isEmpty ? null : labels.dateOnlyFormat(),
                            onPressedDate: () => widget.onChooseExpenseDate(),
                            // Time.
                            timeButtonLabel: widget.timeButtonLabel,
                            onPressedTime: () => widget.onChooseTime(),
                            // Timezone.
                            timezoneButtonLabel: widget.timezoneButtonLabel,
                            onPressedTimezone: () => widget.onChooseTimezone(),
                          ),
                          // * User is in import match mode. Display connect payment date with datapoint button.
                          if (widget.isImportMatch)
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: CustomDropDownButton(
                                label: widget.labelOnPressedChooseExpenseDataDatapoint!,
                                onTap: () => widget.onPressedChooseExpenseDataDatapoint!(),
                              ),
                            ),
                          const SizedBox(height: 10.0),
                          const CustomHorizontalDivider(marginLeft: 20.0, marginRight: 20.0, marginTop: 10.0, marginBottom: 20.0),
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
                              tagsData: widget.expenseData.tagsData,
                              tagsSuggestions: widget.tagsSuggestions,
                              onTagChanged: (value, controller) => widget.onTagChanged(value, controller),
                              onTagSubmitted: (value, controller) => widget.onTagSubmitted(value, controller),
                              onSuggestionTap: (controller, value, index) => widget.onSuggestionTap(controller, value, index),
                              onTagRemoved: (tag, index) => widget.onTagRemoved(tag, index),
                              buttonLabel: widget.chooseTagsDatapointLabel,
                              onButtonPressed: widget.onChooseTagsDatapoint,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      );
                    },
                  ),
                  // * Info Message.
                  Visibility(
                    visible: widget.infoMessage.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                      child: Text(
                        widget.infoMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
