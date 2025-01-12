import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucent_ally/widgets/customs/custom_date_time_zone.dart.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Models.
import '/data/models/field_types/emotion_data/emotion_data.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/add_emotion_sheet/cubit/add_emotion_sheet_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_drop_down_button.dart';
import '/widgets/customs/custom_square_button.dart';

class AddEmotionSheet extends StatelessWidget {
  const AddEmotionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Access size.
    final double height = MediaQuery.of(context).size.height;

    return BlocConsumer<AddEmotionSheetCubit, AddEmotionSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == AddEmotionSheetStatus.close && current.status == AddEmotionSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == AddEmotionSheetStatus.close) Navigator.of(context).pop();

        // * Show emotions
        if (state.status == AddEmotionSheetStatus.showEmotions) context.read<AddEmotionSheetCubit>().showEmotions(context: context);
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != AddEmotionSheetStatus.close,
      builder: (context, state) {
        final bool pageIsLoading = state.status == AddEmotionSheetStatus.pageIsLoading;
        final bool pageHasError = state.status == AddEmotionSheetStatus.pageHasError;

        // Access translated label.
        final String translatedEmotion = state.emotionItem.emotion.isEmpty ? '' : EmotionData.emotionsByTypeAndLanguage()[state.emotionItem.emotion]!;

        return SizedBox(
          height: height * 0.5,
          child: CustomBasePage(
            isModalSheet: true,
            isScrollable: true,
            pageIsLoading: pageIsLoading,
            // Page Failure.
            pageHasError: pageHasError,
            pageFailure: state.pageFailure,
            pageErrorButtonLabel: labels.basicLabelsClose(),
            onPageErrorButtonPressed: () => context.read<AddEmotionSheetCubit>().closeSheet(),
            // Common Failure.
            failure: state.failure,
            onDismissFailure: () => context.read<AddEmotionSheetCubit>().onDismissFailure(),
            // On swipe to close.
            onHorizontalPopRoute: () => context.read<AddEmotionSheetCubit>().closeSheet(),
            // On close while loading.
            onCloseWhilePageLoadingButtonPressed: () => context.read<AddEmotionSheetCubit>().closeSheet(),
            // Floating Action Bar.
            floatingActionBarIcon: AppIcons.ready,
            floatingActionBarLabel: labels.basicLabelsReady(),
            onFloatingActionBarPressed: () => context.read<AddEmotionSheetCubit>().onAddEmotionItem(
                  context: context,
                ),
            // Content.
            content: [
              // * Choose intensity picker.
              Text(
                labels.chooseEmotion(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20.0),
              // * Choose Emotion button.
              CustomDropDownButton(
                isOutlined: true,
                label: labels.chooseEmotionButtonLabel(emotion: translatedEmotion),
                onTap: () => context.read<AddEmotionSheetCubit>().showEmotions(
                      context: context,
                    ),
              ),
              const SizedBox(height: 20.0),
              // * Choose intensity picker.
              Text(
                labels.chooseIntensity(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomSquareButton(
                    label: '1',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 1),
                    borderColor: state.emotionItem.intensity.toString() == '1' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '2',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 2),
                    borderColor: state.emotionItem.intensity.toString() == '2' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '3',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 3),
                    borderColor: state.emotionItem.intensity.toString() == '3' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '4',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 4),
                    borderColor: state.emotionItem.intensity.toString() == '4' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '5',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 5),
                    borderColor: state.emotionItem.intensity.toString() == '5' ? Colors.green : Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomSquareButton(
                    label: '6',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 6),
                    borderColor: state.emotionItem.intensity.toString() == '6' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '7',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 7),
                    borderColor: state.emotionItem.intensity.toString() == '7' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '8',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 8),
                    borderColor: state.emotionItem.intensity.toString() == '8' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '9',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 9),
                    borderColor: state.emotionItem.intensity.toString() == '9' ? Colors.green : Colors.grey,
                  ),
                  CustomSquareButton(
                    label: '10',
                    onPressed: () => context.read<AddEmotionSheetCubit>().onIntensityChosen(value: 10),
                    borderColor: state.emotionItem.intensity.toString() == '10' ? Colors.green : Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // * Choose occurrence picker.
              Text(
                labels.chooseOccurrence(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20.0),
              // * Choose Occurrance button.
              CustomDateTimeZone(
                dateButtonLabel: labels.chooseOccurrenceButtonLabel(
                  occurrence: state.emotionItem.occurrenceInUtc == null ? '' : state.emotionItem.getOccurence(preserveUtc: true),
                ),
                onPressedDate: () => context.read<AddEmotionSheetCubit>().onChooseOccurrance(context: context),
                timezoneButtonLabel: state.emotionItem.occurrenceInUtc == null ? '' : state.emotionItem.getOccurenceTimezone(preserveUtc: true),
                onPressedTimezone: () => context.read<AddEmotionSheetCubit>().chooseTimeZone(context: context),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }
}
