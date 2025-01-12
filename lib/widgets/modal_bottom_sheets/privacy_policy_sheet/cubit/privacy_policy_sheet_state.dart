part of 'privacy_policy_sheet_cubit.dart';

enum PrivacyPolicySheetStatus { pageHasError, pageIsLoading, loading, failure, waiting, close }

class PrivacyPolicySheetState extends Equatable {
  final String privacyPolicy;

  final Failure failure;

  final Failure pageFailure;
  final PrivacyPolicySheetStatus status;

  const PrivacyPolicySheetState({
    required this.privacyPolicy,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [privacyPolicy, failure, pageFailure, status];

  /// Initialize a new ```PrivacyPolicySheetState``` object.
  factory PrivacyPolicySheetState.initial() {
    return PrivacyPolicySheetState(
      privacyPolicy: '',
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: PrivacyPolicySheetStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  PrivacyPolicySheetState copyWith({
    String? privacyPolicy,
    Failure? failure,
    Failure? pageFailure,
    PrivacyPolicySheetStatus? status,
  }) {
    return PrivacyPolicySheetState(
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
