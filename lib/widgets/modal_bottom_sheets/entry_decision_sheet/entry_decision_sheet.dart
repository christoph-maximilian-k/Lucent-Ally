import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Labels.
import '/main.dart';

// Cubit.
import 'cubit/entry_decision_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_elevated_button.dart';
import '/widgets/customs/custom_text_button.dart';
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_cupertino_picker.dart';

class EntryDecisionSheet extends StatefulWidget {
  const EntryDecisionSheet({super.key});

  @override
  State<EntryDecisionSheet> createState() => _EntryDecisionSheetState();
}

class _EntryDecisionSheetState extends State<EntryDecisionSheet> {
  // Variables.
  final FixedExtentScrollController fixedExtentScrollController = FixedExtentScrollController();

  @override
  void dispose() {
    fixedExtentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size.
    final Size size = MediaQuery.of(context).size;

    return BlocConsumer<EntryDecisionSheetCubit, EntryDecisionSheetState>(
      listener: (context, state) {
        // * If a new entry model was created, move scroll weel to created item.
        if (state.status == EntryDecisionSheetStatus.updateScrollWeel) {
          context.read<EntryDecisionSheetCubit>().jumpToScrollWeelItem(
                fixedExtentScrollController: fixedExtentScrollController,
              );
        }

        // * Show a create entry sheet directly.
        if (state.status == EntryDecisionSheetStatus.showCreateEntrySheet) {
          if (state.isShared == false) context.read<EntryDecisionSheetCubit>().showCreateLocalEntrySheet(context: context);
          if (state.isShared) context.read<EntryDecisionSheetCubit>().showCreateSharedEntrySheet(context: context);
        }
      },
      // * Do not rebuild sheet if a create entry sheet should be shown.
      buildWhen: (previous, current) => current.status != EntryDecisionSheetStatus.showCreateEntrySheet,
      builder: (context, state) {
        // Convenience variables.
        final bool pageIsLoading = state.status == EntryDecisionSheetStatus.pageIsLoading;

        final int numberOfModels = state.entryModels.items.length;
        final String entryModelName = state.selectedEntryModel.modelEntryName;

        return GestureDetector(
          onHorizontalDragStart: (final DragStartDetails details) {
            // * Enable swipe to close sheet.
            if (details.globalPosition.dx < 20.0 && pageIsLoading == false) {
              Navigator.of(context).pop();
            }
          },
          child: SizedBox(
            height: size.height * 0.5,
            width: double.infinity,
            child: pageIsLoading
                ? const Center(
                    child: CustomLoadingSpinner(),
                  )
                : Column(
                    children: [
                      Text(
                        labels.entryDecisionSheetSelectModelEntryTitle(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Expanded(
                        child: numberOfModels == 0
                            ? Center(
                                child: Text(
                                  labels.entryDecisionSheetNoModelsCreated(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              )
                            : CustomCupertinoPicker(
                                // * Data.
                                modelEntries: state.entryModels,
                                // * ScrollController.
                                fixedExtentScrollController: fixedExtentScrollController,
                                // * Wheel methods.
                                onSelectedItemChanged: (final int index, _) => context.read<EntryDecisionSheetCubit>().updateSelectedModelEntry(
                                      index: index,
                                    ),
                              ),
                      ),
                      if (numberOfModels != 0)
                        CustomElevatedButton(
                          margin: const EdgeInsets.all(15.0),
                          label: labels.entryDecisionSheetAddEntryModelButtonLabel(entryModelName: entryModelName),
                          onPressed: () {
                            if (state.isShared == false) context.read<EntryDecisionSheetCubit>().showCreateLocalEntrySheet(context: context);
                            if (state.isShared) context.read<EntryDecisionSheetCubit>().showCreateSharedEntrySheet(context: context);
                          },
                        ),
                      if (state.fromGroup.isRestrictedToCommon == false)
                        CustomTextButton(
                          margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 25.0),
                          label: labels.entryDecisionSheetCreateModelButtonLabel(),
                          onPressed: () {
                            // * User is in local mode.
                            if (state.isShared == false) {
                              context.read<EntryDecisionSheetCubit>().showCreateLocalModelEntrySheet(
                                    context: context,
                                  );
                            }

                            // * User is in shared mode.
                            if (state.isShared) {
                              context.read<EntryDecisionSheetCubit>().showCreateSharedModelEntrySheet(
                                    context: context,
                                  );
                            }
                          },
                        ),
                      if (Platform.isIOS) const SizedBox(height: 25.0),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
