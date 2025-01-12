import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Widgets.
import '/widgets/customs/custom_notification.dart';

part 'app_messages_state.dart';

class AppMessagesCubit extends Cubit<AppMessagesState> {
  AppMessagesCubit() : super(AppMessagesState.initial());

  /// This method can be used trigger [AppMessagesCubit] listener to show a notificaton.
  void showNotification({required String message}) {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      notificationMessage: message,
      status: AppMessagesStatus.showNotification,
    ));
  }

  /// This method can be used to display a Notification Overlay.
  /// * should only be triggered through a listener.
  void displayNotificationOverlay({required BuildContext context, required int durationInSeconds}) async {
    // Access overlay state.
    final OverlayState overlayState = Overlay.of(context);

    // Create OverlayEntry.
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (final BuildContext context) {
        return Positioned(
          top: 15.0,
          left: 10.0,
          right: 10.0,
          child: CustomNotification(
            notification: state.notificationMessage,
          ),
        );
      },
    );

    // Display notification.
    overlayState.insert(overlayEntry);

    // Wait specified time.
    await Future.delayed(Duration(seconds: durationInSeconds));

    // Remove overlay.
    overlayEntry.remove();

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // * Do not reset notificationMessage here because this will result in situations where
    // * an empty notification will be shown.
    emit(state.copyWith(
      status: AppMessagesStatus.waiting,
    ));
  }
}
