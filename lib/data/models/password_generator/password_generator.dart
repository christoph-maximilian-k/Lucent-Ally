import 'package:equatable/equatable.dart';

// Config.
import '/config/alphabets.dart';

// Schemas.
import '/data/models/password_generator/schemas/db_password_generator.dart';

class PasswordGenerator extends Equatable {
  final bool usesLowerCase;
  final bool usesUpperCase;
  final bool usesSymbols;
  final bool usesNumbers;

  final int minPasswordLength;
  final int maxPasswordLength;
  final int passwordLength;

  const PasswordGenerator({
    required this.usesLowerCase,
    required this.usesUpperCase,
    required this.usesSymbols,
    required this.usesNumbers,
    required this.minPasswordLength,
    required this.maxPasswordLength,
    required this.passwordLength,
  });

  /// Initialize a new [PasswordGenerator] object.
  factory PasswordGenerator.initial() {
    return const PasswordGenerator(
      usesLowerCase: true,
      usesUpperCase: true,
      usesSymbols: true,
      usesNumbers: true,
      minPasswordLength: 4,
      maxPasswordLength: 40,
      passwordLength: 12,
    );
  }

  @override
  List<Object> get props => [usesLowerCase, usesUpperCase, usesSymbols, usesNumbers, minPasswordLength, maxPasswordLength, passwordLength];

  /// This getter indicates if at least one option is selected.
  bool get getOptionCanChange {
    // Helper list.
    final List<bool> values = [usesLowerCase, usesUpperCase, usesNumbers, usesSymbols];

    // Check if more then 1 option was selected.
    if (values.where((x) => x == true).length > 1) return true;

    return false;
  }

  /// This getter returns current character list depending on options selected.
  List<String> get getCharacterList {
    // Create character list.
    List<String> characterList = [];

    // Lower case option was selected.
    if (usesLowerCase) characterList = characterList + Alphabets.lowerCaseLatinLetters;

    // Upper case option was selected.
    if (usesUpperCase) characterList = characterList + Alphabets.upperCaseLatinLetters;

    // Numbers option was selected.
    if (usesNumbers) characterList = characterList + Alphabets.numbers;

    // Symbols option was selected.
    if (usesSymbols) characterList = characterList + Alphabets.symbols;

    return characterList;
  }

  // --------------------------------------
  // ------------ Database ----------------
  // --------------------------------------

  /// Convert a ```PasswordGenerator``` object to a ```DbPasswordGenerator``` object.
  DbPasswordGenerator toSchema() {
    return DbPasswordGenerator(
      usesLowerCase: usesLowerCase,
      usesUpperCase: usesUpperCase,
      usesSymbols: usesSymbols,
      usesNumbers: usesNumbers,
      minPasswordLength: minPasswordLength,
      maxPasswordLength: maxPasswordLength,
      passwordLength: passwordLength,
    );
  }

  /// Convert a ```DbPasswordGenerator``` object to a ```PasswordGenerator``` object.
  static PasswordGenerator fromSchema({required DbPasswordGenerator schema}) {
    return PasswordGenerator(
      usesLowerCase: schema.usesLowerCase!,
      usesUpperCase: schema.usesUpperCase!,
      usesSymbols: schema.usesSymbols!,
      usesNumbers: schema.usesNumbers!,
      minPasswordLength: schema.minPasswordLength!,
      maxPasswordLength: schema.maxPasswordLength!,
      passwordLength: schema.passwordLength!,
    );
  }

  PasswordGenerator copyWith({
    bool? usesLowerCase,
    bool? usesUpperCase,
    bool? usesSymbols,
    bool? usesNumbers,
    int? minPasswordLength,
    int? maxPasswordLength,
    int? passwordLength,
  }) {
    return PasswordGenerator(
      usesLowerCase: usesLowerCase ?? this.usesLowerCase,
      usesUpperCase: usesUpperCase ?? this.usesUpperCase,
      usesSymbols: usesSymbols ?? this.usesSymbols,
      usesNumbers: usesNumbers ?? this.usesNumbers,
      minPasswordLength: minPasswordLength ?? this.minPasswordLength,
      maxPasswordLength: maxPasswordLength ?? this.maxPasswordLength,
      passwordLength: passwordLength ?? this.passwordLength,
    );
  }
}
