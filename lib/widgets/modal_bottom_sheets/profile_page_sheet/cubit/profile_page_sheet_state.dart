part of 'profile_page_sheet_cubit.dart';

enum ProfilePageSheetStatus {
  pageIsLoading,
  pageHasError,
  waiting,
  loading,
  failure,
  close,
}

class ProfilePageSheetState extends Equatable {
  final FileItem? avatar;

  final Failure failure;
  final ProfilePageSheetStatus status;

  final Failure pageFailure;

  const ProfilePageSheetState({
    required this.avatar,
    required this.failure,
    required this.status,
    required this.pageFailure,
  });

  @override
  List<Object?> get props => [avatar, failure, status, pageFailure];

  /// Initialize a new [ProfilePageSheetState] object.
  factory ProfilePageSheetState.initial() {
    return ProfilePageSheetState(
      avatar: null,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: ProfilePageSheetStatus.pageIsLoading,
    );
  }

  ProfilePageSheetState copyWith({
    FileItem? avatar,
    Failure? failure,
    ProfilePageSheetStatus? status,
    Failure? pageFailure,
  }) {
    return ProfilePageSheetState(
      avatar: avatar ?? this.avatar,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      pageFailure: pageFailure ?? this.pageFailure,
    );
  }
}
