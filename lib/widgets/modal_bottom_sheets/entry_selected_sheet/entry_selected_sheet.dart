import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Config.
import '/config/app_icons.dart';

// User with Settings and Labels.
import '/main.dart';

// Models.
import '/data/models/fields/field.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/chip_items/chip_item.dart';
import '/data/models/chip_items/chip_items.dart';
import '/data/models/field_types/password_data/password_data.dart';
import '/data/models/field_types/date_data/date_data.dart';
import '/data/models/field_types/date_and_time_data/date_and_time_data.dart';
import '/data/models/field_types/time_data/time_data.dart';
import '/data/models/field_types/phone_data/phone_data.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/website_data/website_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/field_types/image_data/image_data.dart';
import '/data/models/files/file_item.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/tags/tag.dart';
import '/data/models/field_types/file_data/file_data.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/entry_selected_sheet/cubit/entry_selected_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/cards/card_display_text.dart';
import '/widgets/cards/card_display_location.dart';
import '/widgets/cards/card_display_files.dart';
import '/widgets/cards/card_display_expense.dart';
import '/widgets/cards/card_display_tags.dart';
import '/widgets/cards/card_display_emotion_data.dart';
import '/widgets/cards/card_display_avatar_image.dart';
import '/widgets/cards/card_display_money_data.dart';

class EntrySelectedSheet extends StatelessWidget {
  const EntrySelectedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EntrySelectedSheetCubit, EntrySelectedSheetState>(
      listener: (context, state) async {
        // * A close sheet state was triggerd.
        if (state.status == EntrySelectedSheetStatus.close) Navigator.of(context).pop();

        // * User wants to set a notification.
        if (state.status == EntrySelectedSheetStatus.setNotification) {
          context.read<EntrySelectedSheetCubit>().setNotification(context: context);
        }

        // * A request for pending local notifications was triggered.
        if (state.loadNotificationsStatus == LoadNotificationsStatus.reloadPendingNotifications) {
          context.read<EntrySelectedSheetCubit>().reloadLocalNotifications();
        }
      },
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == EntrySelectedSheetStatus.close && current.status == EntrySelectedSheetStatus.close) return false;

        return true;
      },
      builder: (context, state) {
        // State variables.
        final bool pageHasError = state.status == EntrySelectedSheetStatus.pageHasError;
        final bool loading = state.status == EntrySelectedSheetStatus.loading;
        final bool pageIsLoading = state.status == EntrySelectedSheetStatus.pageIsLoading;
        final bool chipsLoading = state.status == EntrySelectedSheetStatus.chipsLoading;

        final bool localNotificationsLoading = state.loadNotificationsStatus == LoadNotificationsStatus.loading || state.loadNotificationsStatus == LoadNotificationsStatus.reloadPendingNotifications;

        final bool userHasEditPermission = state.fromGroup.userHasEntryEditPermissions(
          entryCreator: state.entry.entryCreator,
          topLevelGroupOwner: state.topLevelGroup.groupCreator,
          isShared: state.isShared,
        );

        final bool userHasDeletePermission = state.fromGroup.userHasEntryDeletePermissions(
          entryCreator: state.entry.entryCreator,
          topLevelGroupOwner: state.topLevelGroup.groupCreator,
          isShared: state.isShared,
        );

        return CustomBasePage(
          // Page view.
          isPageView: true,
          // Modal Sheet.
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<EntrySelectedSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<EntrySelectedSheetCubit>().dismissFailure(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<EntrySelectedSheetCubit>().closeSheet(),
          // On pop route.
          onHorizontalPopRoute: () => context.read<EntrySelectedSheetCubit>().closeSheet(),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<EntrySelectedSheetCubit>().closeSheet(),
          // First Trailing Icon Button.
          firstTrailingIconButtonIcon: userHasDeletePermission ? AppIcons.moreOptions : null,
          onFirstTrailingIconButtonPressed: () => context.read<EntrySelectedSheetCubit>().onEntryOptionsPressed(context: context),
          // Floating Action Bar.
          floatingActionBarDisabled: state.isShared == true && userHasEditPermission == false,
          actionBarIsLoading: loading,
          loadingMessage: state.loadingMessage,
          floatingActionBarIcon: AppIcons.edit,
          floatingActionBarLabel: labels.entrySelectedSheetFloatingButtonLabel(),
          onFloatingActionBarPressed: () {
            // * User wants to edit a local entry.
            if (state.isShared == false) {
              context.read<EntrySelectedSheetCubit>().editLocalEntry(
                    context: context,
                  );
            }

            // * User wants to edit a shared entry.
            if (state.isShared) {
              // Make sure only those with correct permission can delete.
              if (userHasEditPermission == false) return;

              context.read<EntrySelectedSheetCubit>().editSharedEntry(
                    context: context,
                  );
            }
          },
          // Content.
          content: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: state.entry.entryName,
                          notification: labels.basicLabelsEntryNameCopied(),
                        ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        state.entry.entryName,
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    labels.entrySelectedSheetCreatedAt(
                      modelName: state.entryModel.modelEntryName,
                      date: state.entry.getCreatedAt(preserveUtc: false, date: true, time: true),
                      timezone: state.entry.getCreatedAtTimezone(preserveUtc: false),
                    ),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            ...List<Widget>.generate(
              state.entryModel.fieldIdentifications.items.length,
              (index) {
                // * FieldIdentifications is source of truth. This is done in order to enable deletion of
                // * fields without checking if they are used. In that case the entry still has the
                // * old data saved but it is not displayed.

                // Convenience variables.
                final FieldIdentification fieldIdentification = state.entryModel.fieldIdentifications.items[index];
                final String fieldType = fieldIdentification.fieldType;
                final String fieldId = fieldIdentification.fieldId;
                final String fieldLabel = fieldIdentification.label;

                // Access field index.
                final int fieldIndex = state.entry.fields.items.indexWhere(
                  (element) => element.fieldId == fieldId,
                );

                // * If field was not set by user or it was deleted, return shrinked box.
                if (fieldIndex == -1) return const SizedBox.shrink();

                // Access current field.
                final Field field = state.entry.fields.items[fieldIndex];
                final bool currentChipsAreLoading = state.currentLoadingChipsIndex == fieldIndex;

                // Variables that indicate which data should get rendered.
                final bool renderTextData = field.fieldType == Field.fieldTypeText && field.textData != null && field.textData!.value.isNotEmpty;
                final bool renderPasswordData = field.fieldType == Field.fieldTypePassword && field.passwordData != null && field.passwordData!.value.isNotEmpty;
                final bool renderDateData = field.fieldType == Field.fieldTypeDate && field.dateData != null && field.dateData!.valueInUtc != null;
                final bool renderPhoneData = field.fieldType == Field.fieldTypePhone && field.phoneData != null && field.phoneData!.value.isNotEmpty;
                final bool renderNumberData = field.fieldType == Field.fieldTypeNumber && field.numberData != null && field.numberData!.value.isNotEmpty;
                final bool renderTimeData = field.fieldType == Field.fieldTypeTimeOfDay && field.timeData != null && field.timeData!.value != null;
                final bool renderEmailData = field.fieldType == Field.fieldTypeEmail && field.emailData != null && field.emailData!.value.isNotEmpty;
                final bool renderWebsiteData = field.fieldType == Field.fieldTypeWebsite && field.websiteData != null && field.websiteData!.value.isNotEmpty;
                final bool renderUsernameData = field.fieldType == Field.fieldTypeUsername && field.usernameData != null && field.usernameData!.value.isNotEmpty;
                final bool renderDateAndTimeData = field.fieldType == Field.fieldTypeDateAndTime && field.dateAndTimeData != null && field.dateAndTimeData!.valueInUtc != null;
                final bool renderLocationData = field.fieldType == Field.fieldTypeLocation && field.locationData != null && field.locationData!.longitude.isNotEmpty && field.locationData!.latitude.isNotEmpty;
                final bool renderImageData = field.fieldType == Field.fieldTypeImages && field.imageData != null && field.imageData!.images.getFirstItemHasBytes;
                final bool renderFilesData = field.getIsFilesField && field.fileData != null && field.fileData!.files.getFirstItemHasBytes;
                final bool renderMoneyData = field.fieldType == Field.fieldTypeMoney && field.moneyData != null && field.moneyData!.value.isNotEmpty;
                final bool renderPaymentData = field.fieldType == Field.fieldTypePayment && field.paymentData != null && field.paymentData!.total.isNotEmpty;
                final bool renderDateOfBirthData = field.fieldType == Field.fieldTypeDateOfBirth && field.dateOfBirthData != null && field.dateOfBirthData!.value != null;
                final bool renderTagsData = field.fieldType == Field.fieldTypeTags && field.tagsData != null && field.tagsData!.tagReferences.isNotEmpty;
                final bool renderMeasurementData = field.fieldType == Field.fieldTypeMeasurement && field.measurementData != null && field.measurementData!.category.isNotEmpty && field.measurementData!.unit.isNotEmpty;
                final bool renderEmotionData = field.fieldType == Field.fieldTypeEmotion && field.emotionData != null && field.emotionData!.emotions.isNotEmpty;
                final bool renderAvatarImageData = field.fieldType == Field.fieldTypeAvatarImage && field.avatarImageData != null;
                final bool renderBooleanData = field.fieldType == Field.fieldTypeBoolean && field.booleanData != null;

                // Access Pending notifications of this field.
                final List<PendingNotificationRequest> pendingNotifications = state.getPendingNotificationsOfField(
                  fieldId: fieldId,
                );

                // * Render Boolean Data.
                if (renderBooleanData) {
                  // Convenience variable to avoid having to use ! operator.
                  final BooleanData booleanData = field.booleanData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: labels.booleanSwitchLabel(value: booleanData.value),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                          excludeCopyOption: true,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render AvatarImage Data.
                if (renderAvatarImageData) {
                  // Convenience variable to avoid having to use ! operator.
                  final AvatarImageData avatarImageData = field.avatarImageData!;

                  return CardDisplayAvatarImage(
                    title: fieldIdentification.label,
                    loadingMessage: state.fromGroup.isEncrypted ? labels.decryptingImage() : '',
                    fileItemFuture: () => context.read<EntrySelectedSheetCubit>().loadFileItem(fileItem: avatarImageData.image),
                    avatarImageData: avatarImageData,
                    onTabFile: (final FileItem imageItem, final int index) => context.read<EntrySelectedSheetCubit>().onTabFile(
                          context: context,
                          files: avatarImageData.toFiles(),
                          index: index,
                          isFiles: false,
                        ),
                    onLongPressFile: (final FileItem fileItem, final int index) => context.read<EntrySelectedSheetCubit>().shareFile(
                          fileItem: fileItem,
                          isFile: false,
                        ),
                  );
                }

                // * Render Emotion data.
                if (renderEmotionData) {
                  // Convenience variable to avoid having to use ! operator.
                  final EmotionData emotionData = field.emotionData!;

                  return CardDisplayEmotionData(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    chipItems: emotionData.toChipItems(
                      isLoading: false,
                    ),
                  );
                }

                // * Render Measurement data.
                if (renderMeasurementData) {
                  // Convenience variable to avoid having to use ! operator.
                  final MeasurementData measurementData = field.measurementData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: measurementData.getValue,
                    secondTrailingIcon: AppIcons.copy,
                    dateLabel: measurementData.createdAtInUtc == null
                        ? ''
                        : labels.basicLabelsDateTimeAndTimezone(
                            date: measurementData.getCreatedAt(preserveUtc: true, date: true, time: true),
                            timezone: measurementData.getCreatedAtTimezone(preserveUtc: true),
                          ),
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: measurementData.getValue,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render Tags data.
                if (renderTagsData) {
                  // Convenience variable to avoid having to use ! operator.
                  final TagsData tagsData = field.tagsData!;

                  return CardDisplayTags(
                    icon: AppIcons.fieldTypeTags,
                    title: fieldIdentification.label,
                    tagsData: tagsData,
                    // * Tags.
                    getTagsFuture: () => context.read<EntrySelectedSheetCubit>().loadReferencedTags(
                          tagsData: tagsData,
                          field: field,
                        ),
                    onTabTag: (final Tag tag) => context.read<EntrySelectedSheetCubit>().onTabTag(
                          context: context,
                          tag: tag,
                        ),
                  );
                }

                // * Render payment data.
                if (renderPaymentData) {
                  // Convenience variable to avoid having to use ! operator.
                  final PaymentData paymentData = field.paymentData!;

                  return CardDisplayExpense(
                    key: ValueKey(fieldId), // * This is needed like this to prevent unwanted rebuilds.
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    paymentData: paymentData,
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    // * Get members.
                    getMembersFuture: () => context.read<EntrySelectedSheetCubit>().loadReferencedMembers(paymentData: paymentData),
                    // * Exchange rate.
                    defaultCurrency: state.fromGroup.defaultCurrencyCode,
                    getExchangeRateFuture: () => context.read<EntrySelectedSheetCubit>().getExchangeRate(
                          customExchangeRates: paymentData.customExchangeRates,
                          exchangeRateDateInUtc: paymentData.paymentDateInUtc!,
                          fromCurrencyCode: paymentData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                        ),
                    onSetCustomExchangeRate: () => context.read<EntrySelectedSheetCubit>().onSetCustomExchangeRate(
                          fromCurrencyCode: paymentData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                          customExchangeRates: paymentData.customExchangeRates,
                          field: field,
                          context: context,
                        ),
                    // * Tags.
                    getTagsFuture: () => context.read<EntrySelectedSheetCubit>().loadReferencedTags(
                          tagsData: paymentData.tagsData,
                          field: field,
                        ),
                    onTabTag: (final Tag tag) => context.read<EntrySelectedSheetCubit>().onTabTag(
                          context: context,
                          tag: tag,
                        ),
                    // * Notifications.
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render money data.
                if (renderMoneyData) {
                  // Convenience variable to avoid having to use ! operator.
                  final MoneyData moneyData = field.moneyData!;

                  return CardDisplayMoneyData(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    moneyData: moneyData,
                    entryCreatedAtInUtc: state.entry.createdAtInUtc,
                    defaultCurrency: state.fromGroup.defaultCurrencyCode,
                    getExchangeRateFuture: () => context.read<EntrySelectedSheetCubit>().getExchangeRate(
                          customExchangeRates: moneyData.customExchangeRates,
                          exchangeRateDateInUtc: moneyData.createdAtInUtc!,
                          fromCurrencyCode: moneyData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                        ),
                    onSetCustomExchangeRate: () => context.read<EntrySelectedSheetCubit>().onSetCustomExchangeRate(
                          fromCurrencyCode: moneyData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                          customExchangeRates: moneyData.customExchangeRates,
                          field: field,
                          context: context,
                        ),
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: moneyData.getFormattedNumber,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    // * Tags.
                    getTagsFuture: () => context.read<EntrySelectedSheetCubit>().loadReferencedTags(
                          tagsData: moneyData.tagsData,
                          field: field,
                        ),
                    onTabTag: (final Tag tag) => context.read<EntrySelectedSheetCubit>().onTabTag(
                          context: context,
                          tag: tag,
                        ),
                    // * Notifications.
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render image data.
                if (renderImageData) {
                  // Convenience variable to avoid having to use ! operator.
                  final ImageData imageData = field.imageData!;

                  return CardDisplayFiles(
                    title: fieldIdentification.label,
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    fileItemFuture: (final FileItem fileItem, final int index) => context.read<EntrySelectedSheetCubit>().loadFileItem(fileItem: fileItem),
                    isImages: true,
                    loadingMessage: state.fromGroup.isEncrypted ? labels.decryptingImage() : '',
                    files: imageData.images,
                    onTapFile: (final FileItem imageItem, final int index) => context.read<EntrySelectedSheetCubit>().onTabFile(
                          context: context,
                          files: imageData.images,
                          index: index,
                          isFiles: false,
                        ),
                    onLongPressFile: (final FileItem fileItem, final int index) => context.read<EntrySelectedSheetCubit>().shareFile(
                          fileItem: fileItem,
                          isFile: false,
                        ),
                    // Tags.
                    tagsData: imageData.tagsData,
                    getTagsFuture: () => context.read<EntrySelectedSheetCubit>().loadReferencedTags(
                          tagsData: imageData.tagsData,
                          field: field,
                        ),
                    onTabTag: (final Tag tag) => context.read<EntrySelectedSheetCubit>().onTabTag(
                          context: context,
                          tag: tag,
                        ),
                  );
                }

                // * Render file data.
                if (renderFilesData) {
                  // Convenience variable to avoid having to use ! operator.
                  final FileData fileData = field.fileData!;

                  return CardDisplayFiles(
                    title: fieldIdentification.label,
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    fileItemFuture: (final FileItem fileItem, final int index) => context.read<EntrySelectedSheetCubit>().loadFileItem(
                          fileItem: fileItem,
                        ),
                    isImages: false,
                    loadingMessage: state.fromGroup.isEncrypted ? labels.decryptingFile() : '',
                    files: fileData.files,
                    onTapFile: (final FileItem imageItem, final int index) => context.read<EntrySelectedSheetCubit>().onTabFile(
                          context: context,
                          files: fileData.files,
                          index: index,
                          isFiles: true,
                        ),
                    onLongPressFile: (final FileItem fileItem, final int index) => context.read<EntrySelectedSheetCubit>().shareFile(
                          fileItem: fileItem,
                          isFile: false,
                        ),
                    // Tags.
                    tagsData: fileData.tagsData,
                    getTagsFuture: () => context.read<EntrySelectedSheetCubit>().loadReferencedTags(
                          tagsData: fileData.tagsData,
                          field: field,
                        ),
                    onTabTag: (final Tag tag) => context.read<EntrySelectedSheetCubit>().onTabTag(
                          context: context,
                          tag: tag,
                        ),
                  );
                }

                // * Render location data.
                if (renderLocationData) {
                  // Convenience variable to avoid having to use ! operator.
                  final LocationData locationData = field.locationData!;

                  // * Render location data.
                  return CardDisplayLocation(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    locationData: locationData,
                    // * Latitude.
                    latitudeLabel: labels.entrySelectedSheetLatitude(),
                    latitude: locationData.latitude,
                    latitudeIcon: AppIcons.copy,
                    onLatitudeIconPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: locationData.latitude,
                          notification: labels.entrySelectedSheetCopyLatitude(),
                        ),
                    // * Tags.
                    getTagsFuture: () => context.read<EntrySelectedSheetCubit>().loadReferencedTags(
                          tagsData: locationData.tagsData,
                          field: field,
                        ),
                    onTabTag: (final Tag tag) => context.read<EntrySelectedSheetCubit>().onTabTag(
                          context: context,
                          tag: tag,
                        ),
                    // * Longitude.
                    longitudeLabel: labels.entrySelectedSheetLongitude(),
                    longitude: locationData.longitude,
                    longitudeIcon: AppIcons.copy,
                    onLongitudeIconPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: locationData.longitude,
                          notification: labels.entrySelectedSheetCopyLongitude(),
                        ),
                  );
                }

                // * Render password data.
                if (renderPasswordData) {
                  // Convenience variable to avoid having to use ! operator.
                  final PasswordData passwordData = field.passwordData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: passwordData.getObscuredValue,
                    firstTrailingIcon: passwordData.obscure ? AppIcons.visible : AppIcons.hidden,
                    firstTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().obscuredChanged(field: field),
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: passwordData.value,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render Date data.
                if (renderDateOfBirthData) {
                  // Convenience variable to avoid having to use ! operator.
                  final DateOfBirthData dateOfBirthData = field.dateOfBirthData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: labels.dateOfBirthDataDateAndTime(
                      date: dateOfBirthData.getFormattedDate,
                      time: dateOfBirthData.getFormattedTime,
                    ),
                    chipItems: dateOfBirthData.additionalIndications(),
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: dateOfBirthData.getFormattedDate,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render Date data.
                if (renderDateData) {
                  // Convenience variable to avoid having to use ! operator.
                  final DateData dateData = field.dateData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: dateData.valueInUtc == null
                        ? ''
                        : labels.basicLabelsDateTimeAndTimezone(
                            date: dateData.getCreatedAt(preserveUtc: true),
                            timezone: dateData.getCreatedAtTimezone(preserveUtc: true),
                          ),
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: field.getCopyValue!,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render DateAndTime data.
                if (renderDateAndTimeData) {
                  // Convenience variable to avoid having to use ! operator.
                  final DateAndTimeData dateAndTimeData = field.dateAndTimeData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: dateAndTimeData.valueInUtc == null
                        ? ''
                        : labels.basicLabelsDateTimeAndTimezone(
                            date: dateAndTimeData.getCreatedAt(preserveUtc: true, date: true, time: true),
                            timezone: dateAndTimeData.getCreatedAtTimezone(preserveUtc: true),
                          ),
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: field.getCopyValue!,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render Number data.
                if (renderNumberData) {
                  // Convenience variable to avoid having to use ! operator.
                  final NumberData numberData = field.numberData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: numberData.getFormattedNumber,
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: numberData.getFormattedNumber,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    chipItems: userHasEditPermission == false
                        ? null
                        : ChipItems(
                            isLoading: chipsLoading && currentChipsAreLoading,
                            items: [
                              ChipItem.initial().copyWith(
                                label: labels.entrySelectedQuickActionAdd(value: field.numberData!.getQuickActionValue),
                                onPressed: () => context.read<EntrySelectedSheetCubit>().quickNumberAction(
                                      context: context,
                                      field: field,
                                      index: fieldIndex,
                                      action: NumberData.quickNumberActionAdd,
                                    ),
                              ),
                              ChipItem.initial().copyWith(
                                label: labels.entrySelectedQuickActionSubtract(value: field.numberData!.getQuickActionValue),
                                onPressed: () => context.read<EntrySelectedSheetCubit>().quickNumberAction(
                                      context: context,
                                      field: field,
                                      index: fieldIndex,
                                      action: NumberData.quickNumberActionSubtract,
                                    ),
                              ),
                              ChipItem.initial().copyWith(
                                label: labels.entrySelectedQuickActionInvert(),
                                onPressed: () => context.read<EntrySelectedSheetCubit>().quickNumberAction(
                                      context: context,
                                      field: field,
                                      index: fieldIndex,
                                      action: NumberData.quickNumberActionInvert,
                                    ),
                              ),
                            ],
                          ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render Time data.
                if (renderTimeData) {
                  // Convenience variable to avoid having to use ! operator.
                  final TimeData timeData = field.timeData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: timeData.getFormattedTime,
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: timeData.getFormattedTime,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render phone data.
                if (renderPhoneData) {
                  // Convenience variable to avoid having to use ! operator.
                  final PhoneData phoneData = field.phoneData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: '${phoneData.internationalPrefix} ${phoneData.value}',
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: phoneData.value,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render email data.
                if (renderEmailData) {
                  // Convenience variable to avoid having to use ! operator.
                  final EmailData emailData = field.emailData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: emailData.value,
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: emailData.value,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render website data.
                if (renderWebsiteData) {
                  // Convenience variable to avoid having to use ! operator.
                  final WebsiteData websiteData = field.websiteData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: websiteData.value,
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: websiteData.value,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render username data.
                if (renderUsernameData) {
                  // Convenience variable to avoid having to use ! operator.
                  final UsernameData usernameData = field.usernameData!;

                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: usernameData.value,
                    thirdline: usernameData.service,
                    thirdlineTitle: labels.usedForService(),
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: usernameData.value,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render text data.
                if (renderTextData) {
                  return CardDisplayText(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldIdentification.label,
                    subtitle: field.textData!.value,
                    secondTrailingIcon: AppIcons.copy,
                    secondTrailingOnPressed: () => context.read<EntrySelectedSheetCubit>().copyToClipboard(
                          context: context,
                          data: field.textData!.value,
                          notification: labels.entrySelectedSheetCopyWith(fieldLabel: fieldLabel),
                        ),
                    onMorePressed: () => context.read<EntrySelectedSheetCubit>().onFieldOptionsPressed(
                          context: context,
                          fieldIdentification: fieldIdentification,
                          field: field,
                        ),
                    pendingNotifications: pendingNotifications,
                    pendingNotificationsLoading: localNotificationsLoading,
                    onNotificationSelected: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().onNotificationSelected(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                    onDeleteNotification: (final PendingNotificationRequest notification, final int index) => context.read<EntrySelectedSheetCubit>().deleteNotification(
                          context: context,
                          notification: notification,
                          index: index,
                        ),
                  );
                }

                // * Render invisible box for unknown render instruction.
                debugPrint('EntrySelectedSheet --> unknown render instruction for fieldType ${fieldIdentification.fieldType} --> render invisible box.');

                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
