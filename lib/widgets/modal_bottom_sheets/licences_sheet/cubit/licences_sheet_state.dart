part of 'licences_sheet_cubit.dart';

enum LicencesSheetStatus { pageHasError, pageIsLoading, loading, failure, waiting, close }

class LicencesSheetState extends Equatable {
  final Licences licences;

  final Failure failure;

  final Failure pageFailure;
  final LicencesSheetStatus status;

  const LicencesSheetState({
    required this.licences,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [licences, failure, pageFailure, status];

  /// Initialize a new ```LicencesSheetState``` object.
  factory LicencesSheetState.initial() {
    return LicencesSheetState(
      licences: Licences.initial(),
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: LicencesSheetStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  LicencesSheetState copyWith({
    Licences? licences,
    Failure? failure,
    Failure? pageFailure,
    LicencesSheetStatus? status,
  }) {
    return LicencesSheetState(
      licences: licences ?? this.licences,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
