import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/fields/field.dart';

// Cubit.
import 'cubit/create_model_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_input_tile.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/cards/card_display_text.dart';

class CreateModelSheet extends StatelessWidget {
  const CreateModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateModelCubit, CreateModelState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == CreateModelStatus.close && current.status == CreateModelStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == CreateModelStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != CreateModelStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == CreateModelStatus.pageIsLoading;
        final bool pageHasError = state.status == CreateModelStatus.pageHasError;
        final bool loading = state.status == CreateModelStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          onBasePageTap: () => FocusScope.of(context).unfocus(),
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<CreateModelCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<CreateModelCubit>().dismissFailure(),
          // On horizontal pop route.
          onHorizontalPopRoute: () => context.read<CreateModelCubit>().confirmCloseSheet(context: context),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<CreateModelCubit>().closeSheet(),
          // Corner close button.
          onCornerClosePressed: () => context.read<CreateModelCubit>().confirmCloseSheet(context: context),
          // Leading Icon Button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<CreateModelCubit>().confirmCloseSheet(context: context),
          // First Trailing Icon Button.
          firstTrailingIconButtonIcon: AppIcons.add,
          onFirstTrailingIconButtonPressed: () => context.read<CreateModelCubit>().addFieldToModel(context: context),
          // Main Button.
          actionBarIsLoading: loading,
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.createModelSheetActionbarLabel(isEdit: state.isEdit),
          onFloatingActionBarPressed: () {
            if (state.isEdit) {
              if (state.isShared == false) context.read<CreateModelCubit>().editLocalModelEntry(context: context);
              if (state.isShared) context.read<CreateModelCubit>().editSharedModelEntry(context: context);

              return;
            }

            if (state.isShared == false) context.read<CreateModelCubit>().createLocalModelEntry(context: context);
            if (state.isShared) context.read<CreateModelCubit>().createSharedModelEntry(context: context);
          },
          // Content.
          content: [
            CustomHeader(
              icon: AppIcons.entryModels,
              title: labels.createModelSheetTitle(isShared: state.isShared, isEdit: state.isEdit),
              displayAsColumn: false,
            ),
            const SizedBox(height: 15.0),
            // * Entry Model Name.
            CustomInputTile(
              textFieldKey: const ValueKey('entry_model_name'),
              icon: AppIcons.names,
              shouldRequestFocus: state.isEdit ? false : true,
              title: labels.createModelSheetName(),
              initialData: state.entryModel.modelEntryName,
              suffixIcon: AppIcons.clear,
              suffixPressed: (final TextEditingController controller) => context.read<CreateModelCubit>().modelNameChanged(
                    value: '',
                    controller: controller,
                  ),
              onChanged: (final String value, final TextEditingController controller) => context.read<CreateModelCubit>().modelNameChanged(
                    value: value.trim(),
                    controller: controller,
                  ),
            ),
            // * Entry Name Reminder.
            CardDisplayText(
              key: const ValueKey('entry_name'),
              icon: Field.getIconDataByFieldType(fieldType: Field.fieldTypeText),
              title: labels.createModelSheetEntryName(),
              infoMessage: labels.createModelSheetEntryNameInfoMessage(),
            ),
            // * Entry Created at Reminder.
            CardDisplayText(
              key: const ValueKey('created_at'),
              icon: AppIcons.createdAt,
              title: labels.createModelSheetCreatedAt(),
              infoMessage: labels.createModelSheetCreatedAtInfoMessage(isImportMatch: state.isImportMatch),
              // Switch.
              switchLabel: labels.basicLabelsIsEditable(),
              valueSwitch: state.entryModel.entryCreatedAtIsEditable,
              onSwitchChanged: (final bool value) => context.read<CreateModelCubit>().onCreatedAtIsEditableChanged(),
            ),
            // * Empty Fields Indicator.
            if (state.entryModel.fieldIdentifications.items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  labels.createModelSheetEmptyLabelsInfoMessage(),
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            // * Fields.
            if (state.entryModel.fieldIdentifications.items.isNotEmpty)
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                buildDefaultDragHandles: false,
                proxyDecorator: (child, index, animation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget? child) {
                      return child != null
                          ? Transform.scale(
                              scale: 0.95,
                              child: child,
                            )
                          : Center(
                              child: SizedBox(
                                child: Text(
                                  labels.createModelSheetNullWidget(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            );
                    },
                    child: child,
                  );
                },
                onReorder: (oldIndex, newIndex) => context.read<CreateModelCubit>().onReorder(
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
                children: List<Widget>.generate(
                  state.entryModel.fieldIdentifications.items.length,
                  (index) {
                    // Convenience variables.
                    final FieldIdentification field = state.entryModel.fieldIdentifications.items[index];
                    final String fieldId = field.fieldId;

                    final String hint = Field.getHintByType(fieldType: field.fieldType);
                    final IconData iconData = Field.getIconDataByFieldType(fieldType: field.fieldType);

                    final bool shouldRequestFocus = state.focusedField == index;
                    final bool shouldAnimate = state.shouldAnimate[index];

                    final ValueKey widgetKey = ValueKey(fieldId);
                    final ValueKey textFieldKey = ValueKey(fieldId);

                    final String translatedFieldType = Field.fieldsByTypeAndLanguage()[field.fieldType]!;

                    return AnimatedOpacity(
                      key: widgetKey,
                      duration: Duration(milliseconds: state.animationDurationInMilliSeconds),
                      opacity: shouldAnimate ? 0.0 : 1.0,
                      curve: Curves.linear,
                      child: ReorderableDelayedDragStartListener(
                        index: index,
                        child: CustomInputTile(
                          // * This key needs to be consistent because textField unfocuses if key changes.
                          textFieldKey: textFieldKey,
                          showIsDraggableHandle: true,
                          icon: iconData,
                          title: labels.createModelSheetFieldName(fieldType: translatedFieldType),
                          hint: hint,
                          initialData: field.label,
                          shouldRequestFocus: shouldRequestFocus,
                          onChanged: (final String value, final TextEditingController controller) => context.read<CreateModelCubit>().fieldLabelChanged(
                                index: index,
                                value: value.trim(),
                                controller: controller,
                              ),
                          // Trailing.
                          trailingIcon: AppIcons.delete,
                          trailingIconColor: Theme.of(context).colorScheme.error,
                          trailingIconTooltip: labels.createModelSheetRemoveField(),
                          onTrailingIconPressed: (_, __) => context.read<CreateModelCubit>().removeFieldFromModel(
                                fieldId: fieldId,
                                index: index,
                              ),
                          // Suffix.
                          suffixIcon: AppIcons.clear,
                          suffixPressed: (final TextEditingController controller) => context.read<CreateModelCubit>().fieldLabelChanged(
                                index: index,
                                value: '',
                                controller: controller,
                              ),
                          // First Switch.
                          switchLabelFirst: labels.createModelSheetRequired(),
                          valueFirstSwitch: field.required,
                          onFirstSwitchChanged: (final bool value) => context.read<CreateModelCubit>().requiredChanged(
                                index: index,
                                value: value,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
