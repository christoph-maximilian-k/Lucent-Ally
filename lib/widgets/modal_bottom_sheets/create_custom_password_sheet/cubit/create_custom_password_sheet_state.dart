part of 'create_custom_password_sheet_cubit.dart';

enum CreateCustomPasswordSheetStatus {
  pageIsLoading,
  pageHasError,
  loading,
  failure,
  waiting,
  close,
}

class CreateCustomPasswordSheetState extends Equatable {
  final bool passwordExists;
  final bool isAuthenticated;

  final String newPassword;
  final String authPassword;
  final String updatePassword;

  final bool obscure;

  final Failure failure;
  final Failure pageFailure;
  final CreateCustomPasswordSheetStatus status;

  const CreateCustomPasswordSheetState({
    required this.passwordExists,
    required this.isAuthenticated,
    required this.newPassword,
    required this.authPassword,
    required this.updatePassword,
    required this.obscure,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [
        passwordExists,
        isAuthenticated,
        newPassword,
        authPassword,
        updatePassword,
        obscure,
        failure,
        pageFailure,
        status,
      ];

  /// Initialize a new ```CreateCustomPasswordSheetState``` object.
  factory CreateCustomPasswordSheetState.initial() {
    return CreateCustomPasswordSheetState(
      passwordExists: true,
      isAuthenticated: false,
      newPassword: '',
      authPassword: '',
      updatePassword: '',
      obscure: true,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: CreateCustomPasswordSheetStatus.pageIsLoading,
    );
  }

  CreateCustomPasswordSheetState copyWith({
    bool? passwordExists,
    bool? isAuthenticated,
    String? newPassword,
    String? authPassword,
    String? updatePassword,
    bool? obscure,
    Failure? failure,
    Failure? pageFailure,
    CreateCustomPasswordSheetStatus? status,
  }) {
    return CreateCustomPasswordSheetState(
      passwordExists: passwordExists ?? this.passwordExists,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      newPassword: newPassword ?? this.newPassword,
      authPassword: authPassword ?? this.authPassword,
      updatePassword: updatePassword ?? this.updatePassword,
      obscure: obscure ?? this.obscure,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
