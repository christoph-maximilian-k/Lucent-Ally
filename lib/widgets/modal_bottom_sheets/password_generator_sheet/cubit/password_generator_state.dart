part of 'password_generator_cubit.dart';

enum PasswordGeneratorStatus { pageIsLoading, pageHasError, initializeData, waiting, loading, failure, close }

class PasswordGeneratorState extends Equatable {
  final String generatedPassword;

  final PasswordGenerator initialPasswordGenerator;
  final PasswordGenerator passwordGenerator;

  final Failure failure;
  final PasswordGeneratorStatus status;

  final Failure pageFailure;

  const PasswordGeneratorState({
    required this.generatedPassword,
    required this.initialPasswordGenerator,
    required this.passwordGenerator,
    required this.failure,
    required this.status,
    required this.pageFailure,
  });

  /// Initialize a new [PasswordGeneratorState] object.
  factory PasswordGeneratorState.initial() {
    // Initialize a common passwordGenerator. This enables compareability.
    final PasswordGenerator passwordGenerator = PasswordGenerator.initial();

    return PasswordGeneratorState(
      generatedPassword: '',
      initialPasswordGenerator: passwordGenerator,
      passwordGenerator: passwordGenerator,
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: PasswordGeneratorStatus.pageIsLoading,
    );
  }

  @override
  List<Object> get props => [generatedPassword, initialPasswordGenerator, passwordGenerator, failure, pageFailure, status];

  PasswordGeneratorState copyWith({
    String? generatedPassword,
    PasswordGenerator? initialPasswordGenerator,
    PasswordGenerator? passwordGenerator,
    Failure? pageFailure,
    Failure? failure,
    PasswordGeneratorStatus? status,
  }) {
    return PasswordGeneratorState(
      generatedPassword: generatedPassword ?? this.generatedPassword,
      initialPasswordGenerator: initialPasswordGenerator ?? this.initialPasswordGenerator,
      passwordGenerator: passwordGenerator ?? this.passwordGenerator,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
