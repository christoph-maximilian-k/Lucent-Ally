part of 'initial_screen_cubit.dart';

enum InitialScreenStatus { pageIsLoading, pageHasError, waiting, failure, success }

class InitialScreenState extends Equatable {
  final bool firstAppLaunch;

  final Failure failure;

  final Failure pageFailure;
  final InitialScreenStatus status;

  const InitialScreenState({
    required this.firstAppLaunch,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  /// Initialize a new ```InitialScreenState``` object.
  factory InitialScreenState.initial() {
    return InitialScreenState(
      firstAppLaunch: false,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: InitialScreenStatus.pageIsLoading,
    );
  }

  @override
  List<Object> get props => [firstAppLaunch, failure, pageFailure, status];

  InitialScreenState copyWith({
    bool? firstAppLaunch,
    Failure? failure,
    Failure? pageFailure,
    InitialScreenStatus? status,
  }) {
    return InitialScreenState(
      firstAppLaunch: firstAppLaunch ?? this.firstAppLaunch,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
