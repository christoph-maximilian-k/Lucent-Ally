import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';
import '/config/country_specification.dart';

// Models.
import '/data/models/fields/field.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/field_types/password_data/password_data.dart';
import '/data/models/field_types/phone_data/phone_data.dart';
import '/data/models/field_types/date_data/date_data.dart';
import '/data/models/field_types/date_and_time_data/date_and_time_data.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/field_types/time_data/time_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/website_data/website_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/field_types/image_data/image_data.dart';
import '/data/models/files/file_item.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/tags/tag.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/emotion_data/emotion_item.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/files/files.dart';
import '/data/models/import_specifications/import_specifications.dart';
import '/data/models/members/member.dart';
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/field_types/file_data/file_data.dart';

// Cubits.
import 'cubit/entry_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_input_tile.dart';
import '/widgets/customs/custom_date_input_tile.dart';
import '/widgets/customs/custom_time_input_tile.dart';
import '/widgets/customs/custom_location_input_tile.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/customs/custom_files_input_tile.dart';
import '/widgets/customs/custom_payment_input_tile.dart';
import '/widgets/customs/custom_tags_input_tile.dart';
import '/widgets/customs/custom_emotion_input_tile.dart';
import '/widgets/customs/custom_measurement_input_tile.dart';
import '/widgets/customs/custom_money_input_tile.dart';

class EntrySheet extends StatefulWidget {
  const EntrySheet({super.key});

  @override
  State<EntrySheet> createState() => _EntrySheetState();
}

class _EntrySheetState extends State<EntrySheet> {
  // Get access to focus scope throughout widget.
  late FocusScopeNode node;

  @override
  void initState() {
    super.initState();

    // Init the node.
    node = FocusScopeNode();
  }

  @override
  void dispose() {
    // Remove focus scope.
    node.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EntrySheetCubit, EntrySheetState>(
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == EntrySheetStatus.close) Navigator.of(context).pop();
      },
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == EntrySheetStatus.close && current.status == EntrySheetStatus.close) return false;

        return true;
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != EntrySheetStatus.close,
      builder: (context, state) {
        // Cubit states.
        final bool pageIsLoading = state.status == EntrySheetStatus.pageIsLoading;
        final bool pageHasError = state.status == EntrySheetStatus.pageHasError;
        final bool loading = state.status == EntrySheetStatus.loading;

        return CustomBasePage(
          // State.
          isModalSheet: true,
          // Focus scope.
          focusScopeNode: node,
          // On Base page tap.
          onBasePageTap: () => node.unfocus(),
          // Page loading.
          pageIsLoading: pageIsLoading,
          pageIsLoadingMessage: state.pageLoadingMessage,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<EntrySheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<EntrySheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<EntrySheetCubit>().confirmCloseSheet(context: context),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<EntrySheetCubit>().closeSheet(),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<EntrySheetCubit>().confirmCloseSheet(context: context),
          // Top right close IconButton.
          onCornerClosePressed: () => context.read<EntrySheetCubit>().confirmCloseSheet(context: context),
          // Floating Action Bar.
          actionBarIsLoading: loading,
          loadingMessage: state.loadingMessage,
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.entrySheetFloatingActionBarLabel(isEdit: state.isEdit),
          onFloatingActionBarPressed: () async {
            // * User wants to fix exchange rate issues.
            if (state.isSetExchangeRate) {
              context.read<EntrySheetCubit>().validateExchangeRateFix();
              return;
            }

            // * User wants to create an import template.
            if (state.isImportMatch) {
              context.read<EntrySheetCubit>().setLocalImportTemplate();
              return;
            }

            // * User wants to create a new entry, create new defaults or create a new import template.
            if (state.isEdit == false) {
              // * User wants to set defaults.
              if (state.isDefault) {
                if (state.isShared == false && state.isSelfDefault) context.read<EntrySheetCubit>().setLocalDefaultForSelf();
                if (state.isShared && state.isSelfDefault) context.read<EntrySheetCubit>().setSharedDefaultForSelf();
                if (state.isShared && state.isSelfDefault == false) context.read<EntrySheetCubit>().setSharedDefaultForEveryone();

                return;
              }

              if (state.isShared == false) context.read<EntrySheetCubit>().createLocalEntry(context: context, notification: labels.entrySheetEntryCreatedNotification(entryModelName: state.entryModel.modelEntryName));
              if (state.isShared) context.read<EntrySheetCubit>().createSharedEntry(context: context, notification: labels.entrySheetEntryCreatedNotification(entryModelName: state.entryModel.modelEntryName));

              return;
            }

            // * User wants to edit an existing entry, edit defaults or edit import template.
            if (state.isEdit) {
              // * User wants to edit defaults.
              if (state.isDefault) {
                if (state.isShared == false && state.isSelfDefault) context.read<EntrySheetCubit>().setLocalDefaultForSelf();
                if (state.isShared && state.isSelfDefault) context.read<EntrySheetCubit>().setSharedDefaultForSelf();
                if (state.isShared && state.isSelfDefault == false) context.read<EntrySheetCubit>().setSharedDefaultForEveryone();

                return;
              }

              if (state.isShared == false) context.read<EntrySheetCubit>().editLocalEntry(context: context);
              if (state.isShared) context.read<EntrySheetCubit>().editSharedEntry(context: context);

              return;
            }
          },
          // Content.
          content: [
            CustomHeader(
              icon: AppIcons.entries,
              title: labels.entrySheetTitle(
                isDefault: state.isDefault,
                isEdit: state.isEdit,
                entryModelName: state.entryModel.modelEntryName,
              ),
              displayAsColumn: false,
            ),
            // * If this is a import match, show info message.
            if (state.isImportMatch)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  labels.entrySheetImportMatchInfoMessage(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            // * Entry Name.
            CustomInputTile(
              textFieldKey: const ValueKey('entry_name'),
              icon: AppIcons.names,
              shouldRequestFocus: state.getEntryNameFieldShouldRequestFocus,
              title: labels.entrySheetEntryName(),
              initialData: state.entry.entryName,
              infoMessage: state.fromGroup.isEncrypted ? labels.entryNameisNotEncryptedInfoMessage() : '',
              required: state.isDefault ? false : true,
              // Trailing Icon.
              trailingIcon: AppIcons.delete,
              trailingIconColor: Theme.of(context).colorScheme.error,
              onTrailingIconPressed: (final TextEditingController controller, _) => context.read<EntrySheetCubit>().deleteEntryName(
                    textEditingController: controller,
                  ),
              // On changed.
              onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().entryNameChanged(
                    value: value.trim(),
                    controller: controller,
                  ),
              // Button.
              buttonLabel: state.isImportMatch
                  ? labels.basicLabelsMatchWithDatapoint(
                      datapoint: state.entryModel.importSpecifications!.entryNameInstruction,
                    )
                  : null,
              onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToEntryName(
                    context: context,
                  ),
            ),
            // * Entry Created at.
            if (state.isDefault == false && state.entryModel.entryCreatedAtIsEditable)
              state.isImportMatch
                  ? CustomInputTile(
                      icon: AppIcons.createdAt,
                      title: labels.entrySheetCreatedAt(),
                      showTextField: false,
                      // Trailing icon.
                      trailingIcon: AppIcons.delete,
                      trailingIconColor: Theme.of(context).colorScheme.error,
                      onTrailingIconPressed: (_, __) => context.read<EntrySheetCubit>().disconnectImportDatapointFromCreatedAt(),
                      // Button.
                      buttonLabel: state.isImportMatch
                          ? labels.basicLabelsMatchWithDatapoint(
                              datapoint: state.entryModel.importSpecifications!.createdAtInstruction,
                            )
                          : null,
                      onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToCreatedAt(
                            context: context,
                          ),
                    )
                  : CustomDateInputTile(
                      icon: AppIcons.createdAt,
                      title: labels.entrySheetCreatedAt(),
                      // Date.
                      buttonLabel: state.entry.getCreatedAt(preserveUtc: true, date: true, time: false),
                      onChooseDate: () => context.read<EntrySheetCubit>().onCreatedAtEdited(context: context, node: node),
                      // Time.
                      timeButtonLabel: state.entry.getCreatedAt(preserveUtc: true, date: false, time: true),
                      onChooseTime: () => context.read<EntrySheetCubit>().onChooseCreatedAtTime(context: context, node: node),
                      // Time zone button.
                      timeZoneButtonLabel: state.entry.createdAtTimeZone.isEmpty ? labels.basicLabelsChooseTimezone() : state.entry.createdAtTimeZone,
                      onTimeZoneButtonPressed: () => context.read<EntrySheetCubit>().chooseTimeZone(context: context, initialTimezone: state.entry.createdAtTimeZone, field: null),
                    ),
            // * Fields.
            ...List<Widget>.generate(
              state.entryModel.fieldIdentifications.items.length,
              (index) {
                // * FieldIdentifications is source of truth. This is done in order to enable deletion of
                // * fields without checking if they are used. In that case the entry still has the
                // * old data saved but it is not displayed. Next time user edits that entry, that deleted field will be removed.

                // Convenience variables.
                final FieldIdentification fieldIdentification = state.entryModel.fieldIdentifications.items[index];

                final String fieldType = fieldIdentification.fieldType;
                final String fieldId = fieldIdentification.fieldId;
                final String fieldName = fieldIdentification.label;
                final bool fieldRequired = fieldIdentification.required;

                // Get current field.
                final Field? field = state.entry.fields.getById(fieldId: fieldId);

                // * If field was deleted, return shrinked box.
                if (field == null) return const SizedBox.shrink();

                // * Display a shrinked box if this is a exchange rate set and field type does not need a exchange rate.
                if (state.isSetExchangeRate) {
                  if (field.getIsMoneyField == false && field.getIsPaymentField == false) return const SizedBox.shrink();
                }

                // * Display Boolean data input tile.
                if (field.getIsBooleanField) {
                  // Convenience variable to avoid having to use ! operator.
                  final BooleanData booleanData = field.booleanData!;

                  // * Display input field.
                  return CustomInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    showTextField: false,
                    required: state.isDefault ? false : fieldRequired,
                    // Trailing icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (_, __) => context.read<EntrySheetCubit>().resetBooleanData(
                          field: field,
                        ),
                    // Value.
                    buttonLabel: labels.booleanSwitchLabel(value: booleanData.value),
                    onButtonPressed: () => context.read<EntrySheetCubit>().onChangeBooleanData(
                          context: context,
                          field: field,
                        ),
                    // Value button.
                    secondButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: booleanData.importReference,
                          )
                        : null,
                    onSecondButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display avatar image input tile.
                if (field.getIsAvatarImageField) {
                  // Do not show input tile in import mode.
                  if (state.isImportMatch) return const SizedBox.shrink();

                  // Convenience variable to avoid having to use ! operator.
                  final AvatarImageData avatarImageData = field.avatarImageData!;

                  // Indicates if user edits an image.
                  final bool isImageEdit = avatarImageData.getHasImage;

                  // Create Images.
                  final Files images = avatarImageData.toFiles();

                  return CustomFilesInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    isDefault: state.isDefault,
                    requiredField: state.isDefault ? false : fieldRequired,
                    isDefaultInfoMessage: labels.basicLabelsDefaultNotAvailable(),
                    isImages: false,
                    isAvatarImage: true,
                    isFiles: false,
                    topInfoMessage: isImageEdit ? labels.entrySheetLabelFilesTitleAndCaptionInfoMessage(isImage: true) : '',
                    showFileDetailsIndications: true,
                    infoMessage: state.fromGroup.isEncrypted ? labels.fileValuesNotEncryptedInfoMessage() : '',
                    noFileAvailableMessage: labels.basicLabelsNoImageSelected(),
                    // File future.
                    fileItemFuture: (final FileItem fileItem, final int index) => context.read<EntrySheetCubit>().loadFileItem(fileItem: fileItem),
                    // Data.
                    files: images,
                    // On file tap.
                    onFileTap: (final FileItem fileItem, final int index) => context.read<EntrySheetCubit>().onFileTab(
                          context: context,
                          initialField: field,
                          fileItem: fileItem,
                        ),
                    // Choose files.
                    buttonLabel: labels.entrySheetLabelChooseAvatarImageButtonLabel(isEdit: isImageEdit),
                    onButtonPressed: () => context.read<EntrySheetCubit>().showAddFilesSheet(
                          initialField: field,
                          context: context,
                        ),
                  );
                }

                // * Display emotion input tile.
                if (field.getIsEmotionField) {
                  // Convenience variable to avoid having to use ! operator.
                  final EmotionData emotionData = field.emotionData!;

                  return CustomEmotionInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    emotionData: emotionData,
                    requiredField: state.isDefault ? false : fieldRequired,
                    // Trailing icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: () => context.read<EntrySheetCubit>().clearEmotionData(
                          field: field,
                        ),
                    // * Emotion button.
                    addEmotionButtonLabel: labels.addEmotionButtonLabel(),
                    onAddEmotion: () => context.read<EntrySheetCubit>().onAddEmotion(
                          context: context,
                          field: field,
                        ),
                    // * On emotion removed.
                    onEmotionRemoved: (final EmotionItem emotionItem, final int index) => context.read<EntrySheetCubit>().onRemoveEmotion(
                          emotionItem: emotionItem,
                          field: field,
                        ),
                    // * First value button.
                    firstValueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchEmotionWithDatapoint(
                            datapoint: emotionData.importReferenceEmotion,
                          )
                        : null,
                    onFirstValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceEmotion,
                          memberId: null,
                        ),
                    // * Second value button.
                    secondValueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchIntensityWithDatapoint(
                            datapoint: emotionData.importReferenceIntensity,
                          )
                        : null,
                    onSecondValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceIntensity,
                          memberId: null,
                        ),
                    // * Third value button.
                    thirdValueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchOccurrenceWithDatapoint(
                            datapoint: emotionData.importReferenceOccurrence,
                          )
                        : null,
                    onThirdValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceOccurrence,
                          memberId: null,
                        ),
                    // * Info message.
                    infoMessage: state.isImportMatch ? labels.infoMessageListRequired() : '',
                  );
                }

                // * Display measurement input tile.
                if (field.getIsMeasurementField) {
                  // Convenience variable to avoid having to use ! operator.
                  final MeasurementData measurementData = field.measurementData!;

                  // Access category button label.
                  final String translatedCategory = measurementData.category.isEmpty ? '' : MeasurementData.categoriesByTypeAndLanguage()[measurementData.category]!;

                  return CustomMeasurementInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    measurementData: measurementData,
                    requiredField: state.isDefault ? false : fieldRequired,
                    // * Reset field button.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: () => context.read<EntrySheetCubit>().resetMeasurementField(
                          field: field,
                        ),
                    // * Category button.
                    chooseCategoryButtonLabel: labels.chooseMeasurementCategory(
                      category: translatedCategory,
                    ),
                    onChooseCategory: () => context.read<EntrySheetCubit>().chooseMeasurementCategory(
                          context: context,
                          field: field,
                        ),
                    // * Value input.
                    textFieldKey: const ValueKey('measurement_value'),
                    textInputType: TextInputType.number,
                    initialData: measurementData.value.toString(),
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().onMeasureValueChanged(
                          field: field,
                          controller: controller,
                          value: value,
                        ),
                    // * Unit picker.
                    chooseUnitButtonLabel: labels.chooseMeasurementUnit(
                      unit: measurementData.unit,
                    ),
                    onChooseUnit: () => context.read<EntrySheetCubit>().chooseMeasurementUnit(
                          context: context,
                          field: field,
                        ),
                    // * Measurement date.
                    dateButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsDateDefault(
                            date: measurementData.createdAtDefaultDate,
                          )
                        : measurementData.createdAtInUtc == null || measurementData.createdAtTimezone.isEmpty
                            ? labels.basicLabelsDate()
                            : measurementData.getCreatedAt(preserveUtc: true, date: true, time: false),
                    onChooseDate: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseDateDefault(context: context, initialDate: measurementData.createdAtDefaultDate, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChooseMeasurementDate(context: context, field: field);
                    },
                    labelOnPressedChooseMeasurementDataDateDatapoint: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: measurementData.importReferenceDate,
                          )
                        : null,
                    onPressedChooseMeasurementDataDateDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceDate,
                          memberId: null,
                        ),
                    // * Measurement time.
                    timeButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimeDefault(
                            time: measurementData.createdAtDefaultTime,
                          )
                        : measurementData.createdAtInUtc == null || measurementData.createdAtTimezone.isEmpty
                            ? labels.basicLabelsTime()
                            : measurementData.getCreatedAt(preserveUtc: true, date: false, time: true),
                    onChooseTime: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseTimeDefault(context: context, initialTime: measurementData.createdAtDefaultTime, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChooseMeasurementTime(context: context, field: field);
                    },
                    // * Measurement timezone.
                    timezoneButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimezoneDefault(
                            timezone: measurementData.createdAtTimezone,
                          )
                        : measurementData.createdAtInUtc == null || measurementData.createdAtTimezone.isEmpty
                            ? labels.basicLabelsChooseTimezone()
                            : measurementData.getCreatedAtTimezone(preserveUtc: true),
                    onChooseTimezone: () => context.read<EntrySheetCubit>().chooseTimeZone(context: context, initialTimezone: measurementData.createdAtTimezone, field: field),
                    // * First value button.
                    firstValueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchCategoryWithDatapoint(
                            datapoint: measurementData.importReferenceCategory,
                          )
                        : null,
                    onFirstValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceCategory,
                          memberId: null,
                        ),
                    // * Second value button.
                    secondValueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchUnitWithDatapoint(
                            datapoint: measurementData.importReferenceUnit,
                          )
                        : null,
                    onSecondValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceUnit,
                          memberId: null,
                        ),
                    // * Third value button.
                    thirdValueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchValueWithDatapoint(
                            datapoint: measurementData.importReferenceValue,
                          )
                        : null,
                    onThirdValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                    // * Let user choose if parameters can be changed. This is only relevant for defaults.
                    canChangeParametersLabel: state.isDefault ? labels.basicLabelsCanChangeParameters() : null,
                    onChangeCanChangeParameters: state.isDefault
                        ? (final bool value) => context.read<EntrySheetCubit>().onChangeCanChangeParameters(
                              field: field,
                            )
                        : null,
                    canChangeParametersValue: field.canChangeParameters,
                    infoMessage: state.isDefault ? labels.canChangeUnits(canChangeParameters: field.canChangeParameters) : '',
                  );
                }

                // * Display tags input field.
                if (field.getIsTagsField) {
                  // Convenience variable to avoid having to use ! operator.
                  final TagsData tagsData = field.tagsData!;

                  return CustomTagsInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    infoMessage: state.fromGroup.isEncrypted ? labels.tagsNotEncryptedInfoMessage() : '',
                    tagsData: tagsData,
                    textFieldTagKey: ValueKey(fieldId),
                    requiredField: state.isDefault ? false : fieldRequired,
                    // Trailing icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().resetTagsData(
                          controller: controller,
                          field: field,
                        ),
                    // Data.
                    onTagChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagValueChanged(
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagSubmitted: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    getTagsFuture: () => context.read<EntrySheetCubit>().loadReferencedTags(
                          tagsData: tagsData,
                          field: field,
                        ),
                    onTagRemoved: (final Tag tag, final int index) => context.read<EntrySheetCubit>().removeTag(
                          context: context,
                          field: field,
                          tag: tag,
                        ),
                    // * Button.
                    buttonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: field.tagsData!.importReference,
                          )
                        : null,
                    onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                    // Suggestions.
                    tagsSuggestions: state.tagsSuggestions.getLabels,
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                  );
                }

                // * Display payment input field.
                if (field.getIsPaymentField) {
                  // Convenience variable to avoid having to use ! operator.
                  final PaymentData paymentData = field.paymentData!;

                  final int paidByIndex = paymentData.members.items.indexWhere(
                    (element) => element.memberId == paymentData.paidById,
                  );

                  final String paidByName = paidByIndex == -1 ? labels.basicLabelsChoose() : paymentData.members.items[paidByIndex].memberName;

                  // Access relevant csutom ExchangeRate.
                  final ExchangeRate? customExchangeRate = paymentData.customExchangeRates.findMatchingExchangeRate(
                    fromCurrencyCode: paymentData.currencyCode,
                    toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                  );

                  return CustomPaymentInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    isDefault: state.isDefault,
                    isDefaultInfoMessage: labels.basicLabelsDefaultNotAvailable(),
                    isImportMatch: state.isImportMatch,
                    requiredField: state.isDefault ? false : fieldRequired,
                    isLoading: false,
                    hasFailure: false,
                    infoMessage: state.fromGroup.isEncrypted ? labels.tagsNotEncryptedInfoMessage() : '',
                    expenseData: paymentData,
                    // Exchange rate.
                    defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
                    currentCurrency: paymentData.currencyCode,
                    customExchangeRateInfoMessage: labels.infoMessageCustomExchangeRate(isDefault: state.isDefault),
                    customExchangeRateButtonLabel: labels.basicLabelsSetCustomExchangeRate(
                      value: customExchangeRate?.exchangeRate.toString(),
                      defaultCurrency: state.fromGroup.defaultCurrencyCode,
                    ),
                    onPressedDeleteCustomExchangeRate: () => context.read<EntrySheetCubit>().deleteCustomExchangeRate(
                          field: field,
                          fromCurrencyCode: paymentData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                          customExchangeRates: paymentData.customExchangeRates,
                        ),
                    onPressedCustomExchangeRateButton: () => context.read<EntrySheetCubit>().setCustomExchangeRate(
                          fromCurrencyCode: paymentData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                          customExchangeRates: paymentData.customExchangeRates,
                          field: field,
                          context: context,
                        ),
                    customExchangeRateDatapointLabel: state.isImportMatch
                        ? labels.basicLabelsMatchCustomExchangeRateWithDatapoint(
                            datapoint: paymentData.importReferenceExchangeRate,
                          )
                        : null,
                    customExchangeRateDatapointInfoMessage: state.isImportMatch ? labels.basicLabelsImportCustomExchangeRate() : null,
                    onPressedCustomExchangeRateDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceCustomExchangeRate,
                          memberId: null,
                        ),
                    // Trailing Icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().resetPaymentData(
                          field: field,
                          controller: controller,
                        ),
                    // Total amount.
                    onTotalAmountChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().onTotalAmountChanged(
                          field: field,
                          value: value,
                          controller: controller,
                          fieldName: fieldName,
                        ),
                    onSelectCurrency: () => context.read<EntrySheetCubit>().onSelectExpenseCurrency(
                          context: context,
                          field: field,
                        ),
                    totalAmountFirstButtonLabel: state.isImportMatch
                        ? labels.basicLabelsConnectValueWithDatapoint(
                            datapoint: paymentData.importReferenceTotalValue,
                          )
                        : null,
                    onPressedTotalAmountFirstButton: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                    totalAmountSecondButtonLabel: state.isImportMatch
                        ? labels.basicLabelsConnectCurrencyWithDatapoint(
                            datapoint: paymentData.importReferenceTotalCurrency,
                          )
                        : null,
                    onPressedTotalAmountSecondButton: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceCurrency,
                          memberId: null,
                        ),
                    // Paid by.
                    paidByButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: paymentData.importReferencePaidById,
                          )
                        : paidByName,
                    selectPaidBy: state.isImportMatch
                        ? () => context.read<EntrySheetCubit>().matchDatapointToField(
                              field: field,
                              context: context,
                              objectReference: ImportSpecifications.objectReferencePaidBy,
                              memberId: null,
                            )
                        : () => context.read<EntrySheetCubit>().onSelectPaidBy(
                              context: context,
                              field: field,
                              paidByIndex: paidByIndex,
                              members: paymentData.members,
                            ),
                    // Is compensated.
                    onIsCompensatedChanged: (final bool value) => context.read<EntrySheetCubit>().onIsCompensatedChanged(
                          context: context,
                          field: field,
                          value: value,
                        ),
                    isCompensatedButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: paymentData.importReferenceIsCompensated,
                          )
                        : null,
                    onPressedIsCompensatedButton: state.isImportMatch
                        ? () => context.read<EntrySheetCubit>().matchDatapointToField(
                              field: field,
                              context: context,
                              objectReference: ImportSpecifications.objectReferenceIsCompensated,
                              memberId: null,
                            )
                        : null,
                    // * Distribution import match mode.
                    onPressedAddMember: () => context.read<EntrySheetCubit>().addMember(
                          context: context,
                          field: field,
                        ),
                    onChooseMemberDatapointPressed: (final Member member) => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceMember,
                          memberId: member.memberId,
                        ),
                    onChangeForceMissingMemberValueImport: (final bool value) => context.read<EntrySheetCubit>().onChangeForceMissingMemberValueImport(
                          field: field,
                        ),
                    // * Distribution other modes.
                    onDistributeEquallyChanged: (final bool value) => context.read<EntrySheetCubit>().onDistributeEquallyChanged(
                          context: context,
                          field: field,
                          value: value,
                          fieldName: fieldName,
                        ),
                    onMemberSelected: (final bool? value, final String memberId) => context.read<EntrySheetCubit>().onMemberSelected(
                          field: field,
                          isSelected: value,
                          memberId: memberId,
                        ),
                    onMemberValueChanged: (final String value, final TextEditingController controller, final String memberId) => context.read<EntrySheetCubit>().onMemberValueChanged(
                          field: field,
                          value: value,
                          controller: controller,
                          memberId: memberId,
                        ),
                    // Payment date.
                    dateButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsDateDefault(
                            date: paymentData.paymentDateDefaultDate,
                          )
                        : paymentData.paymentDateInUtc == null || paymentData.paymentDateTimezone.isEmpty
                            ? labels.basicLabelsDate()
                            : paymentData.getCreatedAt(preserveUtc: true, date: true, time: false),
                    onChooseExpenseDate: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseDateDefault(context: context, initialDate: paymentData.paymentDateDefaultDate, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChoosePaymentDate(context: context, field: field);
                    },
                    labelOnPressedChooseExpenseDataDatapoint: labels.basicLabelsMatchWithDatapoint(
                      datapoint: paymentData.importReferencePaymentDate,
                    ),
                    onPressedChooseExpenseDataDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceDate,
                          memberId: null,
                        ),
                    // Payment time.
                    timeButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimeDefault(
                            time: paymentData.paymentDateDefaultTime,
                          )
                        : paymentData.paymentDateInUtc == null || paymentData.paymentDateTimezone.isEmpty
                            ? labels.basicLabelsTime()
                            : paymentData.getCreatedAt(preserveUtc: true, date: false, time: true),
                    onChooseTime: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseTimeDefault(context: context, initialTime: paymentData.paymentDateDefaultTime, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChoosePaymentTime(context: context, field: field);
                    },
                    // Payment date timezone.
                    timezoneButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimezoneDefault(
                            timezone: paymentData.paymentDateTimezone,
                          )
                        : paymentData.paymentDateTimezone.isEmpty
                            ? labels.basicLabelsChooseTimezone()
                            : paymentData.getCreatedAtTimezone(preserveUtc: true),
                    onChooseTimezone: () => context.read<EntrySheetCubit>().chooseTimeZone(context: context, initialTimezone: paymentData.paymentDateTimezone, field: field),
                    // Tags.
                    chooseTagsDatapointLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: paymentData.importReferenceTags,
                          )
                        : null,
                    onChooseTagsDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceTags,
                          memberId: null,
                        ),
                    tagsSuggestions: state.tagsSuggestions.getLabels,
                    getTagsFuture: () => context.read<EntrySheetCubit>().loadReferencedTags(
                          tagsData: paymentData.tagsData,
                          field: field,
                        ),
                    onTagChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagValueChanged(
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagSubmitted: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagRemoved: (final Tag tag, final int index) => context.read<EntrySheetCubit>().removeTag(
                          context: context,
                          field: field,
                          tag: tag,
                        ),
                  );
                }

                // * Display image input field.
                if (field.getIsImagesField) {
                  // Do not show input tile in import mode.
                  if (state.isImportMatch) return const SizedBox.shrink();

                  // Convenience variable to avoid having to use ! operator.
                  final ImageData imageData = field.imageData!;

                  // Indicates if user edits images.
                  final bool isEdit = imageData.images.getFirstItemHasBytes;

                  return CustomFilesInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    isDefault: state.isDefault,
                    isDefaultInfoMessage: labels.basicLabelsDefaultNotAvailable(),
                    requiredField: state.isDefault ? false : fieldRequired,
                    isImages: true,
                    isAvatarImage: false,
                    isFiles: false,
                    showFileDetailsIndications: true,
                    topInfoMessage: isEdit ? labels.entrySheetLabelFilesTitleAndCaptionInfoMessage(isImage: true) : '',
                    infoMessage: state.fromGroup.isEncrypted ? labels.fileValuesNotEncryptedInfoMessage() : '',
                    noFileAvailableMessage: labels.basicLabelsNoImagesSelected(),
                    // Data.
                    files: imageData.images,
                    // File future.
                    fileItemFuture: (final FileItem fileItem, final int index) => context.read<EntrySheetCubit>().loadFileItem(fileItem: fileItem),
                    // On file tap.
                    onFileTap: (final FileItem fileItem, final int index) => context.read<EntrySheetCubit>().onFileTab(
                          context: context,
                          initialField: field,
                          fileItem: fileItem,
                        ),
                    // Choose files.
                    buttonLabel: labels.entrySheetLabelChooseFilesButtonLabel(isEdit: isEdit, isImage: true),
                    onButtonPressed: () => context.read<EntrySheetCubit>().showAddFilesSheet(
                          initialField: field,
                          context: context,
                        ),
                    // Tags.
                    tagsData: imageData.tagsData,
                    tagsSuggestions: state.tagsSuggestions.getLabels,
                    getTagsFuture: () => context.read<EntrySheetCubit>().loadReferencedTags(
                          tagsData: imageData.tagsData,
                          field: field,
                        ),
                    onTagChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagValueChanged(
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagSubmitted: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagRemoved: (final Tag tag, final int index) => context.read<EntrySheetCubit>().removeTag(
                          context: context,
                          field: field,
                          tag: tag,
                        ),
                  );
                }

                // * Display file input field.
                if (field.getIsFilesField) {
                  // Do not show input tile in import mode.
                  if (state.isImportMatch) return const SizedBox.shrink();

                  // Convenience variable to avoid having to use ! operator.
                  final FileData fileData = field.fileData!;

                  // Indicates if user edits images.
                  final bool isEdit = fileData.files.getFirstItemHasBytes;

                  return CustomFilesInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    isDefault: state.isDefault,
                    isDefaultInfoMessage: labels.basicLabelsDefaultNotAvailable(),
                    requiredField: state.isDefault ? false : fieldRequired,
                    isImages: false,
                    isAvatarImage: false,
                    isFiles: true,
                    showFileDetailsIndications: true,
                    topInfoMessage: isEdit ? labels.entrySheetLabelFilesTitleAndCaptionInfoMessage(isImage: false) : '',
                    infoMessage: state.fromGroup.isEncrypted ? labels.fileValuesNotEncryptedInfoMessage() : '',
                    noFileAvailableMessage: labels.basicLabelsNoFilesSelected(),
                    // Data.
                    files: fileData.files,
                    // File future.
                    fileItemFuture: (final FileItem fileItem, final int index) => context.read<EntrySheetCubit>().loadFileItem(fileItem: fileItem),
                    // On file tap.
                    onFileTap: (final FileItem fileItem, final int index) => context.read<EntrySheetCubit>().onFileTab(
                          context: context,
                          initialField: field,
                          fileItem: fileItem,
                        ),
                    // Choose files.
                    buttonLabel: labels.entrySheetLabelChooseFilesButtonLabel(isEdit: isEdit, isImage: false),
                    onButtonPressed: () => context.read<EntrySheetCubit>().showAddFilesSheet(
                          initialField: field,
                          context: context,
                        ),
                    // Tags.
                    tagsData: fileData.tagsData,
                    tagsSuggestions: state.tagsSuggestions.getLabels,
                    getTagsFuture: () => context.read<EntrySheetCubit>().loadReferencedTags(
                          tagsData: fileData.tagsData,
                          field: field,
                        ),
                    onTagChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagValueChanged(
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagSubmitted: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagRemoved: (final Tag tag, final int index) => context.read<EntrySheetCubit>().removeTag(
                          context: context,
                          field: field,
                          tag: tag,
                        ),
                  );
                }

                // * Display location input field.
                if (field.getIsLocationField) {
                  // Convenience variable to avoid having to use ! operator.
                  final LocationData locationData = field.locationData!;

                  return CustomLocationInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    requiredField: state.isDefault ? false : fieldRequired,
                    locationData: locationData,
                    // Current location.
                    isCurrentLocation: state.isCurrentLocation,
                    // Clear location.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController latitudeController, final TextEditingController longitudeController) => context.read<EntrySheetCubit>().resetLocationField(
                          field: field,
                          latitudeController: latitudeController,
                          longitudeController: longitudeController,
                        ),
                    // * Location date.
                    dateButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsDateDefault(
                            date: locationData.defaultDate,
                          )
                        : locationData.createdAtInUtc == null || locationData.createdAtTimezone.isEmpty
                            ? labels.basicLabelsDate()
                            : locationData.getCreatedAt(preserveUtc: true, date: true, time: false),
                    onChooseDate: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseDateDefault(context: context, initialDate: locationData.defaultDate, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChooseLocationDate(context: context, field: field);
                    },
                    labelOnPressedChooseLocationDataDateDatapoint: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: locationData.importReferenceDate,
                          )
                        : null,
                    onPressedChooseLocationDataDateDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceDate,
                          memberId: null,
                        ),
                    // * Location time.
                    timeButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimeDefault(
                            time: locationData.defaultTime,
                          )
                        : locationData.createdAtInUtc == null || locationData.createdAtTimezone.isEmpty
                            ? labels.basicLabelsTime()
                            : locationData.getCreatedAt(preserveUtc: true, date: false, time: true),
                    onChooseTime: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseTimeDefault(context: context, initialTime: locationData.defaultTime, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChooseLocationTime(context: context, field: field);
                    },
                    // * Location timezone.
                    timezoneButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimezoneDefault(
                            timezone: locationData.createdAtTimezone,
                          )
                        : locationData.createdAtTimezone.isEmpty
                            ? labels.basicLabelsChooseTimezone()
                            : locationData.getCreatedAtTimezone(preserveUtc: true),
                    onChooseTimezone: () => context.read<EntrySheetCubit>().chooseTimeZone(context: context, initialTimezone: locationData.createdAtTimezone, field: field),
                    // Manual location latitude.
                    latitudeInitialData: locationData.latitude,
                    latitudeLabel: labels.entrySheetLabelLatitude(),
                    latitudeOnChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().latitudeValueChanged(
                          field: field,
                          controller: controller,
                          value: value,
                        ),
                    latitudeTrailingIcon: AppIcons.clear,
                    latitudeTrailingPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().clearLatitude(
                          field: field,
                          controller: controller,
                        ),
                    // Manual location longitude.
                    longitudeInitialData: locationData.longitude,
                    longitudeLabel: labels.entrySheetLabelLongitude(),
                    longitudeOnChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().longitudeValueChanged(
                          field: field,
                          controller: controller,
                          value: value,
                        ),
                    longitudeTrailingIcon: AppIcons.clear,
                    longitudeTrailingPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().clearLongitude(
                          field: field,
                          controller: controller,
                        ),
                    // Current location.
                    buttonLabel: labels.entrySheetLabelCurrentLocation(),
                    onButtonPressed: () => context.read<EntrySheetCubit>().getCurrentLocation(
                          field: field,
                        ),
                    // First additional button (used for latitude).
                    firstButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchLatitudeWithDatapoint(
                            datapoint: locationData.importReferenceLatitude,
                          )
                        : null,
                    onFirstButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceLatitude,
                          memberId: null,
                        ),
                    // Second additional button (used for longitude).
                    secondButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchLongitudeWithDatapoint(
                            datapoint: locationData.importReferenceLongitude,
                          )
                        : null,
                    onSecondButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceLongitude,
                          memberId: null,
                        ),
                    // Tags.
                    chooseTagsDatapointLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: locationData.importReferenceTags,
                          )
                        : null,
                    onChooseTagsDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceTags,
                          memberId: null,
                        ),
                    getTagsFuture: () => context.read<EntrySheetCubit>().loadReferencedTags(
                          tagsData: locationData.tagsData,
                          field: field,
                        ),
                    tagsSuggestions: state.tagsSuggestions.getLabels,
                    onTagChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagValueChanged(
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagSubmitted: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagRemoved: (final Tag tag, final int index) => context.read<EntrySheetCubit>().removeTag(
                          context: context,
                          field: field,
                          tag: tag,
                        ),
                  );
                }

                // * Display password input field.
                if (field.getIsPasswordField) {
                  // Convenience variable to avoid having to use ! operator.
                  final PasswordData passwordData = field.passwordData!;

                  return CustomInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    required: state.isDefault ? false : fieldRequired,
                    infoMessage: state.fromGroup.isEncrypted == false ? labels.passwordNotEncryptedWarning() : '',
                    textFieldKey: ValueKey(fieldId),
                    initialData: passwordData.value,
                    obscure: passwordData.obscure,
                    // Password generator functions.
                    showPasswordGeneratorFunctions: true,
                    generatePassword: (final TextEditingController controller) => context.read<EntrySheetCubit>().generatePassword(
                          context: context,
                          field: field,
                          controller: controller,
                          notification: labels.entrySheetPasswordGeneratedNotification(),
                          node: node,
                        ),
                    showPasswordGenerator: () => context.read<EntrySheetCubit>().showPasswordGeneratorSheet(context: context),
                    // Trailing Icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, _) => context.read<EntrySheetCubit>().resetPasswordData(
                          field: field,
                          textEditingController: controller,
                        ),
                    // Text field Trailing Icon.
                    textFieldTrailingIcon: passwordData.obscure ? AppIcons.visible : AppIcons.hidden,
                    onTextFieldTrailingIconPressed: (_) => context.read<EntrySheetCubit>().obscuredChanged(
                          field: field,
                        ),
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().passwordValueChanged(
                          field: field,
                          // * For passwords to not trim value.
                          value: value,
                        ),
                    // Value button.
                    buttonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: passwordData.importReference,
                          )
                        : null,
                    onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display phone input field.
                if (field.getIsPhoneField) {
                  // Convenience variable to avoid having to use ! operator.
                  final PhoneData phoneData = field.phoneData!;

                  // Get index of relevant country specification.
                  final int countryIndex = phoneData.internationalPrefix.isEmpty
                      ? -1
                      : CountrySpecification.countrySpecifications.indexWhere(
                          (element) => element.internationalPhonePrefix == phoneData.internationalPrefix,
                        );

                  // Access relevant flag.
                  // *If no country Code has been supplied or found, render placeholder.
                  final Image? flag = countryIndex == -1
                      ? Image.asset(
                          'assets/images/placeholder.png',
                        )
                      : CountrySpecification.countrySpecifications[countryIndex].flag;

                  return CustomInputTile(
                    textInputType: TextInputType.phone,
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    required: state.isDefault ? false : fieldRequired,
                    textFieldKey: ValueKey(fieldId),
                    initialData: phoneData.value,
                    textFieldLeadingWidget: SizedBox(
                      height: 35.0,
                      width: 35.0,
                      child: flag,
                    ),
                    onTextFieldLeadingPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().onFlagPressed(
                          context: context,
                          field: field,
                          controller: controller,
                        ),
                    // Trailing Icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, _) => context.read<EntrySheetCubit>().resetPhoneData(
                          field: field,
                          textEditingController: controller,
                        ),
                    // Text field Trailing Icon.
                    textFieldTrailingIcon: AppIcons.clear,
                    onTextFieldTrailingIconPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().clearPhoneValue(
                          field: field,
                          controller: controller,
                        ),
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().phoneValueChanged(
                          field: field,
                          value: value.trim(),
                        ),
                    // Suggestions.
                    showSuggestions: state.isShared == false && state.fromGroup.isEncrypted == false,
                    suggestions: state.phoneSuggestionsLabels,
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().phoneSuggestionSelected(
                          context: context,
                          field: field,
                          value: value,
                          index: index,
                          controller: controller,
                        ),
                    // Button.
                    buttonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchPhoneWithDatapoint(
                            datapoint: phoneData.importReference,
                          )
                        : null,
                    onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                    // Value second button.
                    secondButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchInternationalPrefixWithDatapoint(
                            datapoint: phoneData.importReferenceInternationalPrefix,
                          )
                        : null,
                    onSecondButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceOptionalValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display date of birth input field.
                if (field.getIsDateOfBirthField) {
                  // Convenience variable to avoid having to use ! operator.
                  final DateOfBirthData dateOfBirthData = field.dateOfBirthData!;

                  return CustomDateInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    requiredField: state.isDefault ? false : fieldRequired,
                    // Switch.
                    onSwitchChanged: state.isDefault || dateOfBirthData.showAutoNotificationChoice == true
                        ? (final bool value) => context.read<EntrySheetCubit>().onAutoNotificationChanged(
                              field: field,
                            )
                        : null,
                    switchTitle: labels.basicLabelsAutomaticNotification(),
                    switchValue: dateOfBirthData.autoNotification,
                    // Notification input.
                    textFieldKey: ValueKey(fieldId),
                    initialInputData: dateOfBirthData.notificationTitle,
                    inputHint: labels.entrySheetNotificationTitle(),
                    onInputChanged: state.isImportMatch
                        ? null
                        : (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().onBirthdayNotificationTitleChanged(
                              field: field,
                              value: value,
                              controller: controller,
                            ),
                    // Clear current date.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: () => context.read<EntrySheetCubit>().resetDateOfBirthData(
                          field: field,
                        ),
                    // Date button.
                    buttonLabel: dateOfBirthData.value == null ? labels.basicLabelsDate() : dateOfBirthData.getFormattedDate,
                    onChooseDate: () => context.read<EntrySheetCubit>().onDateOfBirthChosen(
                          field: field,
                          context: context,
                        ),
                    // Time button.
                    timeButtonLabel: dateOfBirthData.value == null ? labels.basicLabelsTime() : dateOfBirthData.getFormattedTime,
                    onChooseTime: () => context.read<EntrySheetCubit>().onChooseDateOfBirthTime(
                          context: context,
                          field: field,
                          initialDate: dateOfBirthData.value,
                        ),
                    // Button.
                    valueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: dateOfBirthData.importReference,
                          )
                        : null,
                    onValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display date input field.
                if (field.getIsDateField) {
                  // Convenience variable to avoid having to use ! operator.
                  final DateData dateData = field.dateData!;

                  return CustomDateInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    requiredField: state.isDefault ? false : fieldRequired,
                    // Date.
                    buttonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsDateDefault(
                            date: dateData.valueDefaultDate,
                          )
                        : dateData.valueInUtc == null || dateData.timezone.isEmpty
                            ? labels.basicLabelsDate()
                            : dateData.getCreatedAt(preserveUtc: true),
                    onChooseDate: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseDateDefault(context: context, initialDate: dateData.valueDefaultDate, field: field);
                        return;
                      }

                      // * User is not in default mode.
                      context.read<EntrySheetCubit>().onDateChosen(context: context, field: field);
                    },
                    // Timezone.
                    timeZoneButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimezoneDefault(
                            timezone: dateData.timezone,
                          )
                        : dateData.timezone.isEmpty
                            ? labels.basicLabelsChooseTimezone()
                            : dateData.getCreatedAtTimezone(preserveUtc: true),
                    onTimeZoneButtonPressed: () => context.read<EntrySheetCubit>().chooseTimeZone(context: context, initialTimezone: dateData.timezone, field: field),
                    // Clear current date.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: () => context.read<EntrySheetCubit>().resetDateData(
                          field: field,
                        ),
                    // Button.
                    valueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: dateData.importReference,
                          )
                        : null,
                    onValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display dateAndTime input field.
                if (field.getIsDateAndTimeField) {
                  // Convenience variable to avoid having to use ! operator.
                  final DateAndTimeData dateAndTimeData = field.dateAndTimeData!;

                  return CustomDateInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    requiredField: state.isDefault ? false : fieldRequired,
                    // Date.
                    buttonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsDateDefault(
                            date: dateAndTimeData.valueDefaultDate,
                          )
                        : dateAndTimeData.valueInUtc == null || dateAndTimeData.timezone.isEmpty
                            ? labels.basicLabelsDate()
                            : dateAndTimeData.getCreatedAt(preserveUtc: true, date: true, time: false),
                    onChooseDate: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseDateDefault(context: context, initialDate: dateAndTimeData.valueDefaultDate, field: field);
                        return;
                      }

                      // * User is not in default mode.
                      context.read<EntrySheetCubit>().onDateAndTimeDateChosen(context: context, field: field);
                    },
                    // Time.
                    timeButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimeDefault(
                            time: dateAndTimeData.valueDefaultTime,
                          )
                        : dateAndTimeData.valueInUtc == null || dateAndTimeData.timezone.isEmpty
                            ? labels.basicLabelsTime()
                            : dateAndTimeData.getCreatedAt(preserveUtc: true, date: false, time: true),
                    onChooseTime: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseTimeDefault(context: context, initialTime: dateAndTimeData.valueDefaultTime, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onDateAndTimeTimeChosen(context: context, field: field);
                    },
                    // Timezone.
                    timeZoneButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimezoneDefault(
                            timezone: dateAndTimeData.timezone,
                          )
                        : dateAndTimeData.timezone.isEmpty
                            ? labels.basicLabelsChooseTimezone()
                            : dateAndTimeData.getCreatedAtTimezone(preserveUtc: true),
                    onTimeZoneButtonPressed: () => context.read<EntrySheetCubit>().chooseTimeZone(context: context, initialTimezone: dateAndTimeData.timezone, field: field),
                    // Clear current date.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: () => context.read<EntrySheetCubit>().resetDateAndTimeData(
                          field: field,
                        ),
                    // Button.
                    valueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: dateAndTimeData.importReference,
                          )
                        : null,
                    onValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display number input field.
                if (field.getIsNumberField) {
                  // Convenience variable to avoid having to use ! operator.
                  final NumberData numberData = field.numberData!;

                  return CustomInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    required: state.isDefault ? false : fieldRequired,
                    textFieldKey: ValueKey(fieldId),
                    textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    initialData: numberData.value,
                    // Trailing icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, _) => context.read<EntrySheetCubit>().resetNumberData(
                          field: field,
                          controller: controller,
                        ),
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().numberValueChanged(
                          field: field,
                          value: value.trim(),
                          controller: controller,
                        ),
                    // Button.
                    buttonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: numberData.importReference,
                          )
                        : null,
                    onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display money input field.
                if (field.getIsMoneyField) {
                  // Convenience variable to avoid having to use ! operator.
                  final MoneyData moneyData = field.moneyData!;

                  // Access relevant csutom ExchangeRate.
                  final ExchangeRate? customExchangeRate = moneyData.customExchangeRates.findMatchingExchangeRate(
                    fromCurrencyCode: moneyData.currencyCode,
                    toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                  );

                  return CustomMoneyInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    isImportMatch: state.isImportMatch,
                    requiredField: state.isDefault ? false : fieldRequired,
                    textFieldKey: ValueKey(fieldId),
                    textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                    initialData: moneyData.value,
                    moneyData: moneyData,
                    isDefault: state.isDefault,
                    // Money date.
                    dateButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsDateDefault(
                            date: moneyData.defaultDate,
                          )
                        : moneyData.createdAtInUtc == null || moneyData.timezone.isEmpty
                            ? labels.basicLabelsDate()
                            : moneyData.getCreatedAt(preserveUtc: true, date: true, time: false),
                    onChooseDate: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseDateDefault(context: context, initialDate: moneyData.defaultDate, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChooseMoneyDate(context: context, field: field);
                    },

                    labelOnPressedChooseMoneyDataDateDatapoint: labels.basicLabelsMatchWithDatapoint(
                      datapoint: moneyData.importReferenceDate,
                    ),
                    onPressedChooseMoneyDataDateDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceDate,
                          memberId: null,
                        ),
                    // Money time.
                    timeButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimeDefault(
                            time: moneyData.defaultTime,
                          )
                        : moneyData.createdAtInUtc == null || moneyData.timezone.isEmpty
                            ? labels.basicLabelsTime()
                            : moneyData.getCreatedAt(preserveUtc: true, date: false, time: true),
                    onChooseTime: () {
                      // * User is in default or import mode.
                      if (state.isDefault || state.isImportMatch) {
                        context.read<EntrySheetCubit>().onChooseTimeDefault(context: context, initialTime: moneyData.defaultTime, field: field);
                        return;
                      }

                      // * User is in entry mode.
                      context.read<EntrySheetCubit>().onChooseMoneyTime(context: context, field: field);
                    },
                    // Timezone.
                    timezoneButtonLabel: state.isDefault || state.isImportMatch
                        ? labels.basicLabelsTimezoneDefault(
                            timezone: moneyData.timezone,
                          )
                        : moneyData.createdAtInUtc == null || moneyData.timezone.isEmpty
                            ? labels.basicLabelsChooseTimezone()
                            : moneyData.getTimezone(preserveUtc: true),
                    onChooseTimezone: () => context.read<EntrySheetCubit>().chooseTimeZone(context: context, initialTimezone: moneyData.timezone, field: field),
                    // Exchange rate.
                    defaultCurrencyCode: state.fromGroup.defaultCurrencyCode,
                    currentCurrency: moneyData.currencyCode,
                    customExchangeRateInfoMessage: labels.infoMessageCustomExchangeRate(isDefault: state.isDefault),
                    customExchangeRateButtonLabel: labels.basicLabelsSetCustomExchangeRate(
                      value: customExchangeRate?.exchangeRate.toString(),
                      defaultCurrency: state.fromGroup.defaultCurrencyCode,
                    ),
                    onPressedDeleteCustomExchangeRate: () => context.read<EntrySheetCubit>().deleteCustomExchangeRate(
                          field: field,
                          customExchangeRates: moneyData.customExchangeRates,
                          fromCurrencyCode: moneyData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                        ),
                    onPressedCustomExchangeRateButton: () => context.read<EntrySheetCubit>().setCustomExchangeRate(
                          fromCurrencyCode: moneyData.currencyCode,
                          toCurrencyCode: state.fromGroup.defaultCurrencyCode,
                          customExchangeRates: moneyData.customExchangeRates,
                          field: field,
                          context: context,
                        ),
                    // Set exchange rate defaults.
                    labelSetExchangeRateDefaults: labels.setDefaultExchangeRates(),
                    onPressedSetExchangeRateDefaultsButton: () => context.read<EntrySheetCubit>().setDefaultExchangeRates(
                          field: field,
                          context: context,
                        ),
                    onDeleteDefaultExchangeRate: (final ExchangeRate exchangeRate) => context.read<EntrySheetCubit>().removeDefaultExchangeRate(
                          field: field,
                          context: context,
                          exchangeRate: exchangeRate,
                        ),
                    // Import match.
                    customExchangeRateDatapointLabel: state.isImportMatch
                        ? labels.basicLabelsMatchCustomExchangeRateWithDatapoint(
                            datapoint: moneyData.importReferenceExchangeRate,
                          )
                        : null,
                    customExchangeRateDatapointInfoMessage: state.isImportMatch ? labels.basicLabelsImportCustomExchangeRate() : null,
                    onPressedCustomExchangeRateDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceCustomExchangeRate,
                          memberId: null,
                        ),
                    // Trailing icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().resetMoneyField(
                          field: field,
                          controller: controller,
                        ),
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().moneyValueChanged(
                          field: field,
                          value: value.trim(),
                          controller: controller,
                        ),
                    // * Currency.
                    currencyButtonLabel: labels.entrySheetMoneyDataCurrencyButtonLabel(
                      isInit: moneyData.currencyCode.isEmpty,
                      currencyCode: moneyData.currencyCode,
                    ),
                    onCurrencyButtonPressed: () => context.read<EntrySheetCubit>().setMoneyDataCurrency(
                          context: context,
                          field: field,
                        ),
                    // * First button.
                    firstButtonLabel: state.isImportMatch
                        ? labels.basicLabelsConnectValueWithDatapoint(
                            datapoint: moneyData.importReferenceValue,
                          )
                        : null,
                    firstButtonOnPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                    // * Second button.
                    secondButtonLabel: state.isImportMatch
                        ? labels.basicLabelsConnectCurrencyWithDatapoint(
                            datapoint: moneyData.importReferenceCurrency,
                          )
                        : null,
                    secondButtonOnPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceCurrency,
                          memberId: null,
                        ),
                    // * Let user choose if parameters can be changed. This is only relevant for defaults.
                    switchLabelFirst: state.isDefault ? labels.basicLabelsCanChangeParameters() : '',
                    onFirstSwitchChanged: state.isDefault
                        ? (final bool value) => context.read<EntrySheetCubit>().onChangeCanChangeParameters(
                              field: field,
                            )
                        : null,
                    valueFirstSwitch: field.canChangeParameters,
                    firstSwitchInfoMessage: labels.canChangeCurrency(canChangeParameters: field.canChangeParameters),
                    // Tags.
                    chooseTagsDatapointLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: moneyData.importReferenceTags,
                          )
                        : null,
                    onChooseTagsDatapoint: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceTags,
                          memberId: null,
                        ),
                    tagsSuggestions: state.tagsSuggestions.getLabels,
                    getTagsFuture: () => context.read<EntrySheetCubit>().loadReferencedTags(
                          tagsData: moneyData.tagsData,
                          field: field,
                        ),
                    onTagChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagValueChanged(
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagSubmitted: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().tagSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    onTagRemoved: (final Tag tag, final int index) => context.read<EntrySheetCubit>().removeTag(
                          context: context,
                          field: field,
                          tag: tag,
                        ),
                  );
                }

                // * Display time input field.
                if (field.getIsTimeField) {
                  // Convenience variable to avoid having to use ! operator.
                  final TimeData timeData = field.timeData!;

                  return CustomTimeInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    requiredField: state.isDefault ? false : fieldRequired,

                    buttonLabel: timeData.value == null ? labels.entrySheetChooseTimeButtonLabel() : timeData.getFormattedTime,
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: () => context.read<EntrySheetCubit>().resetTimeData(
                          field: field,
                        ),
                    onChooseTime: () => context.read<EntrySheetCubit>().onTimeChosen(
                          context: context,
                          field: field,
                          initialTime: timeData.value,
                        ),
                    // Button.
                    valueButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: timeData.importReference,
                          )
                        : null,
                    onValueButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display email input field.
                if (field.getIsEmailField) {
                  // Convenience variable to avoid having to use ! operator.
                  final EmailData emailData = field.emailData!;

                  return CustomInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    required: state.isDefault ? false : fieldRequired,
                    textFieldKey: ValueKey(fieldId),
                    initialData: emailData.value,
                    buttonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: emailData.importReference,
                          )
                        : null,
                    onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                    // Trailing Icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, _) => context.read<EntrySheetCubit>().resetEmailData(
                          field: field,
                          textEditingController: controller,
                        ),
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().emailValueChanged(
                          field: field,
                          value: value.trim(),
                          controller: controller,
                        ),
                    // Suggestions.
                    showSuggestions: state.isShared == false && state.fromGroup.isEncrypted == false,
                    suggestions: state.textSuggestions,
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().emailSuggestionSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                  );
                }

                // * Display website input field.
                if (field.getIsWebsiteField) {
                  // Convenience variable to avoid having to use ! operator.
                  final WebsiteData websiteData = field.websiteData!;

                  return CustomInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    required: state.isDefault ? false : fieldRequired,
                    textFieldKey: ValueKey(fieldId),
                    initialData: websiteData.value,
                    // Trailing Icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, _) => context.read<EntrySheetCubit>().resetWebsiteData(
                          field: field,
                          textEditingController: controller,
                        ),
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().websiteValueChanged(
                          field: field,
                          value: value.trim(),
                          controller: controller,
                        ),
                    // Suggestions.
                    showSuggestions: state.isShared == false && state.fromGroup.isEncrypted == false,
                    suggestions: state.textSuggestions,
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().websiteSuggestionSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                    // Value button.
                    buttonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchWithDatapoint(
                            datapoint: websiteData.importReference,
                          )
                        : null,
                    onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                  );
                }

                // * Display username input field.
                if (field.getIsUsernameField) {
                  // Convenience variable to avoid having to use ! operator.
                  final UsernameData usernameData = field.usernameData!;

                  return CustomInputTile(
                    icon: Field.getIconDataByFieldType(fieldType: fieldType),
                    title: fieldName,
                    required: state.isDefault ? false : fieldRequired,
                    textFieldKey: ValueKey(fieldId),
                    initialData: usernameData.value,
                    // Trailing Icon.
                    trailingIcon: AppIcons.delete,
                    trailingIconColor: Theme.of(context).colorScheme.error,
                    onTrailingIconPressed: (final TextEditingController controller, final TextEditingController optionalController) => context.read<EntrySheetCubit>().resetUsernameData(
                          field: field,
                          textEditingController: controller,
                          optionalTextEditingController: optionalController,
                        ),
                    // Text field Trailing Icon.
                    textFieldTrailingIcon: AppIcons.clear,
                    onTextFieldTrailingIconPressed: (final TextEditingController controller) => context.read<EntrySheetCubit>().clearUsernameValue(
                          field: field,
                          controller: controller,
                        ),
                    // On changed.
                    onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().usernameValueChanged(
                          field: field,
                          value: value.trim(),
                          controller: controller,
                        ),
                    // Value button.
                    buttonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchUsernameWithDatapoint(
                            datapoint: usernameData.importReferenceValue,
                          )
                        : null,
                    onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceValue,
                          memberId: null,
                        ),
                    // Optional value.
                    optionalValueTitle: labels.basicLabelsServiceOptional(),
                    initialOptionalValue: usernameData.service,
                    optionalValueInfoMessage: labels.usernameServiceInfoMessage(),
                    onChangedOptionalValue: (final String value, final TextEditingController optionalController) => context.read<EntrySheetCubit>().usernameServiceChanged(
                          field: field,
                          value: value.trim(),
                          controller: optionalController,
                        ),
                    optionalTrailingIcon: AppIcons.clear,
                    onOptionalTrailingPressed: (final TextEditingController optionalController) => context.read<EntrySheetCubit>().clearUsernameService(
                          field: field,
                          controller: optionalController,
                        ),
                    // Value second button.
                    secondButtonLabel: state.isImportMatch
                        ? labels.basicLabelsMatchUsernameServiceWithDatapoint(
                            datapoint: usernameData.importReferenceOptionalValue,
                          )
                        : null,
                    onSecondButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                          field: field,
                          context: context,
                          objectReference: ImportSpecifications.objectReferenceOptionalValue,
                          memberId: null,
                        ),
                    // Suggestions.
                    showSuggestions: state.isShared == false && state.fromGroup.isEncrypted == false,
                    suggestions: state.textSuggestions,
                    onSuggestionTap: (final TextEditingController controller, final String value, final int index) => context.read<EntrySheetCubit>().usernameSuggestionSelected(
                          context: context,
                          field: field,
                          value: value,
                          controller: controller,
                        ),
                  );
                }

                // * Display text input field.
                return CustomInputTile(
                  icon: Field.getIconDataByFieldType(fieldType: fieldType),
                  title: fieldName,
                  maxLines: user.settings.maxLinesForTextFields,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  textFieldKey: ValueKey(fieldId),
                  initialData: field.textData!.value,
                  required: state.isDefault ? false : fieldRequired,
                  // Button.
                  buttonLabel: state.isImportMatch
                      ? labels.basicLabelsMatchWithDatapoint(
                          datapoint: field.textData!.importReference,
                        )
                      : null,
                  onButtonPressed: () => context.read<EntrySheetCubit>().matchDatapointToField(
                        field: field,
                        context: context,
                        objectReference: ImportSpecifications.objectReferenceValue,
                        memberId: null,
                      ),
                  // Trailing Icon.
                  trailingIcon: AppIcons.delete,
                  trailingIconColor: Theme.of(context).colorScheme.error,
                  onTrailingIconPressed: (final TextEditingController controller, _) => context.read<EntrySheetCubit>().resetTextData(
                        field: field,
                        textEditingController: controller,
                      ),
                  // On changed.
                  onChanged: (final String value, final TextEditingController controller) => context.read<EntrySheetCubit>().textValueChanged(
                        field: field,
                        value: value.trim(),
                      ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
