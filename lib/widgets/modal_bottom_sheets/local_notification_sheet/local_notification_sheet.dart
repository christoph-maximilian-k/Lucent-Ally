import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import 'cubit/local_notification_cubit.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_input_tile.dart';
import '/widgets/customs/custom_cupertino_picker.dart';
import '/widgets/customs/custom_header.dart';
import '/widgets/customs/custom_notifications_tile.dart';

class LocalNotificationSheet extends StatefulWidget {
  final int initialRepeatItem;

  const LocalNotificationSheet({
    super.key,
    this.initialRepeatItem = 0,
  });

  @override
  State<LocalNotificationSheet> createState() => _LocalNotificationSheetState();
}

class _LocalNotificationSheetState extends State<LocalNotificationSheet> {
  // Create controllers.
  late FixedExtentScrollController repeatItemsController;

  late Timer timer;

  @override
  void initState() {
    // * It seems like best practice is to write code after super.initState() in initState.
    super.initState();
    repeatItemsController = FixedExtentScrollController(initialItem: widget.initialRepeatItem);
    timer = Timer.periodic(
      const Duration(milliseconds: 900),
      (final Timer timer) => context.read<LocalNotificationCubit>().updateTime(),
    );
  }

  @override
  void dispose() {
    // * It seems like best practice is to write code before super.dispose() in dispose.
    repeatItemsController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalNotificationCubit, LocalNotificationState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == LocalNotificationStatus.close && current.status == LocalNotificationStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        if (state.status == LocalNotificationStatus.close) {
          // * Close the sheet with true to let previous screen know that user set a notification.
          context.read<LocalNotificationCubit>().closeSheet(context: context, notificationSet: true);
        }
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != LocalNotificationStatus.close,
      builder: (context, state) {
        // State variables.
        final bool pageHasError = state.status == LocalNotificationStatus.pageHasError;
        final bool pageIsLoading = state.status == LocalNotificationStatus.pageIsLoading;
        final bool loading = state.status == LocalNotificationStatus.loading;

        return CustomBasePage(
          isModalSheet: true,
          // Page loading.
          pageIsLoading: pageIsLoading,
          // Page Failure.
          pageHasError: pageHasError,
          pageFailure: state.pageFailure,
          pageErrorButtonLabel: labels.basicLabelsClose(),
          onPageErrorButtonPressed: () => context.read<LocalNotificationCubit>().closeSheet(
                context: context,
                notificationSet: false,
              ),
          // Common Failure.
          failure: state.failure,
          onDismissFailure: () => context.read<LocalNotificationCubit>().dismissFailure(),
          // On Pop Route.
          onHorizontalPopRoute: () => context.read<LocalNotificationCubit>().closeSheet(
                context: context,
                notificationSet: false,
              ),
          // Close while page loading.
          onCloseWhilePageLoadingButtonPressed: () => context.read<LocalNotificationCubit>().closeSheet(
                context: context,
                notificationSet: false,
              ),
          // Leading Icon Button
          leadingIconButtonIcon: AppIcons.back,
          onLeadingIconButtonPressed: () => context.read<LocalNotificationCubit>().closeSheet(
                context: context,
                notificationSet: false,
              ),
          // Floating Action Bar.
          floatingActionBarDisabled: state.isDelete,
          actionBarIsLoading: loading,
          floatingActionBarIcon: AppIcons.ready,
          floatingActionBarLabel: labels.setNotificationSheetSaveNotificationLabel(),
          onFloatingActionBarPressed: () => context.read<LocalNotificationCubit>().setNotification(
                context: context,
              ),
          // Content.
          content: [
            // * Show set notification content.
            if (state.isDelete == false)
              _contentBuilderSetNotification(
                context: context,
                repeatItemsController: repeatItemsController,
                state: state,
              ),
            // * Show delete notification content.
            if (state.isDelete)
              _contentBuilderDeleteNotification(
                context: context,
                state: state,
              ),
          ],
        );
      },
    );
  }
}

// Show set notification content.
Widget _contentBuilderSetNotification({
  required BuildContext context,
  required LocalNotificationState state,
  required FixedExtentScrollController repeatItemsController,
}) {
  return Column(
    children: [
      CustomHeader(
        icon: AppIcons.notification,
        title: labels.setNotification(),
        displayAsColumn: false,
      ),
      const SizedBox(height: 10.0),
      // * DateTime Picker.
      SizedBox(
        height: 190.0,
        child: Builder(
          builder: (context) {
            // * Keys are needed because otherwise exception statePickerMode cannot change will be thrown.
            // * This is also why Builder and two widgets are necessary.

            // Is initial date after minimum date?
            // * This is needed because exception init date is before minimum date might be thrown otherwise.
            final bool isBefore = state.notificationDateTimeInLocal.isBefore(state.minimumDateTimeInLocal);

            // * return a shrinked box.
            if (isBefore) return const SizedBox.shrink();

            // * Return date picker.
            return Card(
              key: const ValueKey('date_time'),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
                    horizontalTitleGap: 5.0,
                    leading: Icon(
                      AppIcons.clock,
                      color: Theme.of(context).primaryIconTheme.color,
                      size: Theme.of(context).primaryIconTheme.size,
                    ),
                    title: Text(
                      labels.setNotificationSheetOnLabel(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                    width: 250.0,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      child: CupertinoDatePicker(
                        // * This key needs to change if minimum date time changes to trigger internal setStates.
                        key: state.datePickerKey,
                        dateOrder: DatePickerDateOrder.ymd,
                        initialDateTime: state.notificationDateTimeInLocal,
                        minimumDate: state.minimumDateTimeInLocal,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        use24hFormat: true,
                        onDateTimeChanged: (final DateTime value) => context.read<LocalNotificationCubit>().onNotificationDateTimeChanged(
                              dateTime: value,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // * Repeat decision.
      if (state.repeatPickerItems.items.isNotEmpty)
        SizedBox(
          height: 190.0,
          child: Card(
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
                  horizontalTitleGap: 5.0,
                  leading: Icon(
                    AppIcons.repeat,
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size,
                  ),
                  title: Text(
                    labels.setNotificationSheetRepeatLabel(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                CustomCupertinoPicker(
                  // * Dimensions.
                  height: 120.0,
                  // * Data.
                  pickerItems: state.repeatPickerItems,
                  // * ScrollController.
                  fixedExtentScrollController: repeatItemsController,
                  // * Wheel methods.
                  onSelectedItemChanged: (final int index, _) => context.read<LocalNotificationCubit>().updateSelectRepeatItem(
                        index: index,
                      ),
                ),
              ],
            ),
          ),
        ),
      CustomInputTile(
        textFieldKey: const ValueKey('notification_title'),
        icon: AppIcons.names,
        title: labels.setNotificationSheetNotificationTitle(),
        initialData: state.notificationTitle,
        suffixIcon: AppIcons.clear,
        suffixPressed: (final TextEditingController controller) => context.read<LocalNotificationCubit>().notificationTitleChanged(
              value: '',
              controller: controller,
            ),
        onChanged: (final String value, final TextEditingController controller) => context.read<LocalNotificationCubit>().notificationTitleChanged(
              value: value,
              controller: controller,
            ),
      ),
      CustomInputTile(
        textFieldKey: const ValueKey('notification_body'),
        icon: AppIcons.names,
        title: labels.setNotificationSheetNotificationBody(),
        initialData: state.notificationMessage,
        suffixIcon: AppIcons.clear,
        suffixPressed: (final TextEditingController controller) => context.read<LocalNotificationCubit>().notificationBodyChanged(
              value: '',
              controller: controller,
            ),
        onChanged: (final String value, final TextEditingController controller) => context.read<LocalNotificationCubit>().notificationBodyChanged(
              value: value.trim(),
              controller: controller,
            ),
      ),
      Card(
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0, bottom: 8.0),
              horizontalTitleGap: 5.0,
              leading: Icon(
                AppIcons.notification,
                color: Theme.of(context).primaryIconTheme.color,
                size: Theme.of(context).primaryIconTheme.size,
              ),
              title: Text(
                labels.setNotificationSheetNextNotificationLabel(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        labels.setNotificationSheetNextNotificationOnTheLabel(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        // * This does not need to be translated it is just a spaceholder.
                        '(',
                        style: TextStyle(
                          color: Colors.transparent,
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.getDateAsString,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        labels.setNotificationSheetNextNotificationDateFormatLabel(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        labels.setNotificationSheetNextNotificationAtLabel(time: state.getTimeAsString),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        // * This does not need to be translated it is just a spaceholder.
                        '(',
                        style: TextStyle(
                          color: Colors.transparent,
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Show delete notification content.
Widget _contentBuilderDeleteNotification({
  required BuildContext context,
  required LocalNotificationState state,
}) {
  return Column(
    children: [
      CustomHeader(
        icon: AppIcons.notification,
        title: labels.notifications(),
        displayAsColumn: false,
      ),
      if (state.getGroupNotifications.isEmpty && state.getEntryNotifications.isEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
          child: Text(
            labels.noNotificationsSet(),
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
      if (state.getGroupNotifications.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: CustomNotificationsTile(
            height: double.infinity,
            title: labels.groupNotifications(),
            pendingNotifications: state.getGroupNotifications,
            onDeleteNotification: (final PendingNotificationRequest request, final int index) => context.read<LocalNotificationCubit>().onDeleteNotification(
                  request: request,
                  index: index,
                  context: context,
                ),
            onNotificationSelected: (final PendingNotificationRequest request, final int index) => context.read<LocalNotificationCubit>().onNotificationSelected(
                  request: request,
                  index: index,
                  context: context,
                ),
          ),
        ),
      if (state.getEntryNotifications.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CustomNotificationsTile(
            height: double.infinity,
            title: labels.entryNotifications(),
            pendingNotifications: state.getEntryNotifications,
            onDeleteNotification: (final PendingNotificationRequest request, final int index) => context.read<LocalNotificationCubit>().onDeleteNotification(
                  request: request,
                  index: index,
                  context: context,
                ),
            onNotificationSelected: (final PendingNotificationRequest request, final int index) => context.read<LocalNotificationCubit>().onNotificationSelected(
                  request: request,
                  index: index,
                  context: context,
                ),
          ),
        ),
    ],
  );
}
