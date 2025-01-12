part of 'user_agreement_sheet_cubit.dart';

enum UserAgreementSheetStatus { pageHasError, pageIsLoading, waiting, failure, close }

class UserAgreementSheetState extends Equatable {
  final String userAgreement;

  final Failure pageFailure;

  final Failure failure;
  final UserAgreementSheetStatus status;

  const UserAgreementSheetState({
    required this.userAgreement,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [userAgreement, failure, pageFailure, status];

  /// Initialize a new ```UserAgreementSheetState``` object.
  factory UserAgreementSheetState.initial() {
    return UserAgreementSheetState(
      userAgreement: '',
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: UserAgreementSheetStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  UserAgreementSheetState copyWith({
    String? userAgreement,
    Failure? pageFailure,
    Failure? failure,
    UserAgreementSheetStatus? status,
  }) {
    return UserAgreementSheetState(
      userAgreement: userAgreement ?? this.userAgreement,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
