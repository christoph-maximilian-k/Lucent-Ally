part of 'accept_cookies_sheet_cubit.dart';

enum AcceptCookiesSheetStatus { pageHasError, pageIsLoading, loading, failure, waiting, close, accept }

class AcceptCookiesSheetState extends Equatable {
  final String privacyPolicy;

  final Failure failure;

  final Failure pageFailure;
  final AcceptCookiesSheetStatus status;

  const AcceptCookiesSheetState({
    required this.privacyPolicy,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [privacyPolicy, failure, pageFailure, status];

  /// Initialize a new ```AcceptCookiesSheetState``` object.
  factory AcceptCookiesSheetState.initial() {
    return AcceptCookiesSheetState(
      privacyPolicy: '',
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: AcceptCookiesSheetStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  AcceptCookiesSheetState copyWith({
    String? privacyPolicy,
    Failure? failure,
    Failure? pageFailure,
    AcceptCookiesSheetStatus? status,
  }) {
    return AcceptCookiesSheetState(
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
