import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucent_ally/widgets/customs/custom_text_button.dart';
import 'package:path/path.dart' as p;

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/import_data_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/cards/card_menu_item.dart';
import '/widgets/customs/custom_header.dart';

class ImportDataSheet extends StatelessWidget {
  const ImportDataSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImportDataSheetCubit, ImportDataSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ImportDataSheetStatus.close && current.status == ImportDataSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // A close event was triggerd.
        if (state.status == ImportDataSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (previous, current) => current.status != ImportDataSheetStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageIsLoading = state.status == ImportDataSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == ImportDataSheetStatus.pageHasError;
        final bool loading = state.status == ImportDataSheetStatus.loading;

        return CustomBasePage(
          // State.
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          pageIsLoadingMessage: state.loadingMessage,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<ImportDataSheetCubit>().closeSheet(),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<ImportDataSheetCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<ImportDataSheetCubit>().closeSheet(),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<ImportDataSheetCubit>().closeSheet(),
          // Leading icon button.
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<ImportDataSheetCubit>().closeSheet(),
          // Floating Action Bar.
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.basicLabelsImport(),
          actionBarIsLoading: loading,
          onFloatingActionBarPressed: () => context.read<ImportDataSheetCubit>().conductImport(),
          // Content.
          content: [
            CustomHeader(
              icon: AppIcons.import,
              title: labels.importToGroup(
                groupName: state.group.groupName,
              ),
              displayAsColumn: false,
            ),
            const SizedBox(height: 20.0),
            const Icon(
              AppIcons.first,
              size: 35.0,
            ),
            const SizedBox(height: 20.0),
            CardMenuItem(
              title: state.file == null ? labels.basicLabelsChooseFile() : p.basename(state.file!.path),
              leadingIcon: AppIcons.file,
              infoMessage: labels.chooseFileInfoMessage(),
              onTap: () => context.read<ImportDataSheetCubit>().chooseFile(
                    context: context,
                  ),
            ),
            if (state.csvTable.isNotEmpty)
              CustomTextButton(
                isOutlined: true,
                margin: const EdgeInsets.only(top: 15.0),
                label: labels.showDataSample(),
                onPressed: () => context.read<ImportDataSheetCubit>().showDataSample(context: context),
              ),
            const SizedBox(height: 20.0),
            const Icon(
              AppIcons.second,
              size: 35.0,
            ),
            const SizedBox(height: 20.0),
            CardMenuItem(
              title: state.selectedModelEntry.modelEntryName.isNotEmpty ? state.selectedModelEntry.modelEntryName : labels.matchToModelEntry(),
              leadingIcon: AppIcons.entryModels,
              infoMessage: labels.infoMessageMatchToModelEntry(),
              onTap: () => context.read<ImportDataSheetCubit>().matchWithModelEntry(
                    context: context,
                  ),
            ),
            const SizedBox(height: 20.0),
            const Icon(
              AppIcons.third,
              size: 35.0,
            ),
            const SizedBox(height: 20.0),
            CardMenuItem(
              title: labels.basicLabelsCreateTemplate(isEdit: state.isTemplateEdit),
              leadingIcon: AppIcons.entries,
              infoMessage: labels.infoMessageImportClean(),
              onTap: () => context.read<ImportDataSheetCubit>().matchImportDataToEntry(
                    context: context,
                  ),
            ),
            const SizedBox(height: 20.0),
            const Icon(
              AppIcons.fourth,
              size: 35.0,
            ),
            const SizedBox(height: 20.0),
            CardMenuItem(
              title: labels.setInvalidValueRule(
                rule: state.selectedModelEntry.importSpecifications?.invalidValueRule,
              ),
              leadingIcon: AppIcons.entries,
              infoMessage: labels.infoMessageInvalidValueRule(),
              onTap: () => context.read<ImportDataSheetCubit>().setImportRule(
                    context: context,
                    isInvalidRule: true,
                  ),
            ),
            const SizedBox(height: 20.0),
            CardMenuItem(
              title: labels.setMissingValueRule(
                rule: state.selectedModelEntry.importSpecifications?.missingValueRule,
              ),
              leadingIcon: AppIcons.entries,
              infoMessage: labels.infoMessageMissingValueRule(),
              onTap: () => context.read<ImportDataSheetCubit>().setImportRule(
                    context: context,
                    isInvalidRule: false,
                  ),
            ),
          ],
        );
      },
    );
  }
}
