part of 'settings_sheet_cubit.dart';

enum SettingsSheetStatus { pageIsLoading, pageHasError, loading, waiting, failure, close }

class SettingsSheetState extends Equatable {
  final User initialUser;
  final User user;

  final Failure pageFailure;

  final Failure failure;
  final SettingsSheetStatus status;

  const SettingsSheetState({
    required this.initialUser,
    required this.user,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  /// Initialize a new `SettingsSheetState` object.
  factory SettingsSheetState.initial() {
    // Initialize a common settings. This enables compareability.
    final User user = User.initial();

    return SettingsSheetState(
      initialUser: user,
      user: user,
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: SettingsSheetStatus.pageIsLoading,
    );
  }

  @override
  List<Object> get props => [initialUser, user, pageFailure, failure, status];

  SettingsSheetState copyWith({
    User? initialUser,
    User? user,
    Failure? pageFailure,
    Failure? failure,
    SettingsSheetStatus? status,
  }) {
    return SettingsSheetState(
      initialUser: initialUser ?? this.initialUser,
      user: user ?? this.user,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
