part of 'create_default_exchange_rate_cubit.dart';

enum CreateDefaultExchangeRateStatus { pageIsLoading, pageHasError, loading, waiting, close, failure }

class CreateDefaultExchangeRateState extends Equatable {
  final ExchangeRate defaultExchangeRate;

  final Failure pageFailure;
  final Failure failure;

  final CreateDefaultExchangeRateStatus status;

  const CreateDefaultExchangeRateState({
    required this.defaultExchangeRate,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [defaultExchangeRate, pageFailure, failure, status];

  // #############################
  // Initial
  // #############################

  /// Initialize a new `CreateDefaultExchangeRateState` object.
  factory CreateDefaultExchangeRateState.initial() {
    return CreateDefaultExchangeRateState(
      defaultExchangeRate: ExchangeRate.initial(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: CreateDefaultExchangeRateStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  CreateDefaultExchangeRateState copyWith({
    ExchangeRate? defaultExchangeRate,
    Failure? pageFailure,
    Failure? failure,
    CreateDefaultExchangeRateStatus? status,
  }) {
    return CreateDefaultExchangeRateState(
      defaultExchangeRate: defaultExchangeRate ?? this.defaultExchangeRate,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
