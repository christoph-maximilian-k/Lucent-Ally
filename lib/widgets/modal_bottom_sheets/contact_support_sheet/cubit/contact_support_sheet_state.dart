part of 'contact_support_sheet_cubit.dart';

enum ContactSupportSheetStatus { pageHasError, pageIsLoading, waiting, failure, close }

class ContactSupportSheetState extends Equatable {
  final String supportEmail;
  final String platform;
  final String buildNumber;
  final String version;

  final Failure failure;

  final Failure pageFailure;
  final ContactSupportSheetStatus status;

  const ContactSupportSheetState({
    required this.supportEmail,
    required this.platform,
    required this.buildNumber,
    required this.version,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [supportEmail, platform, buildNumber, version, failure, pageFailure, status];

  /// Initialize a new ```ContactSupportSheetState``` object.
  factory ContactSupportSheetState.initial() {
    return ContactSupportSheetState(
      supportEmail: '',
      platform: '',
      buildNumber: '',
      version: '',
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: ContactSupportSheetStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  ContactSupportSheetState copyWith({
    String? supportEmail,
    String? platform,
    String? buildNumber,
    String? version,
    Failure? failure,
    Failure? pageFailure,
    ContactSupportSheetStatus? status,
  }) {
    return ContactSupportSheetState(
      supportEmail: supportEmail ?? this.supportEmail,
      platform: platform ?? this.platform,
      buildNumber: buildNumber ?? this.buildNumber,
      version: version ?? this.version,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
