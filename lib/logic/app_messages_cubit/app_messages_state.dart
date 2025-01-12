part of 'app_messages_cubit.dart';

enum AppMessagesStatus { waiting, showNotification }

class AppMessagesState extends Equatable {
  final String notificationMessage;

  final AppMessagesStatus status;

  const AppMessagesState({
    required this.notificationMessage,
    required this.status,
  });

  /// Initialize a new [AppMessagesState] object.
  /// ```dart
  /// return const AppMessagesState(
  ///  notificationMessage: '',
  ///  status: AppMessagesStatus.waiting,
  /// );
  /// ```
  factory AppMessagesState.initial() {
    return const AppMessagesState(
      notificationMessage: '',
      status: AppMessagesStatus.waiting,
    );
  }

  @override
  List<Object> get props => [notificationMessage, status];

  AppMessagesState copyWith({
    String? notificationMessage,
    AppMessagesStatus? status,
  }) {
    return AppMessagesState(
      notificationMessage: notificationMessage ?? this.notificationMessage,
      status: status ?? this.status,
    );
  }
}
