import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Labels.
import '/main.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/password_generator/password_generator.dart';
import '/data/models/users/user.dart';

part 'password_generator_state.dart';

class PasswordGeneratorCubit extends Cubit<PasswordGeneratorState> {
  final LocalStorageCubit _localStorageCubit;
  final AppMessagesCubit _appMessagesCubit;

  PasswordGeneratorCubit({
    required LocalStorageCubit localStorageCubit,
    required AppMessagesCubit appMessagesCubit,
  })  : _localStorageCubit = localStorageCubit,
        _appMessagesCubit = appMessagesCubit,
        super(PasswordGeneratorState.initial());

  /// Initialize state.
  /// * used to signal that state data has to be transfered from local storage cubit once it is available
  Future<void> initialize() async {
    // * Necessary to avoid UI delay.
    await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

    // Access passwordGenerator of localStorageCubit.
    final PasswordGenerator passwordGenerator = _localStorageCubit.state.user.passwordGenerator;

    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      initialPasswordGenerator: passwordGenerator,
      passwordGenerator: passwordGenerator,
    ));

    // Create random password.
    final String generatedPassword = createPassword();

    // * Necessary to give state time to update.
    await Future.delayed(const Duration(milliseconds: 250));

    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      generatedPassword: generatedPassword,
      status: PasswordGeneratorStatus.waiting,
    ));
  }

  /// This method gets invoked if user wants to dismiss a failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: PasswordGeneratorStatus.waiting,
    ));
  }

  /// This method can be used to copy a generated password to clipboard.
  Future<void> copyPassword({required BuildContext context}) async {
    try {
      // Set data to clipboard.
      await Clipboard.setData(ClipboardData(text: state.generatedPassword));

      // Display notification.
      _appMessagesCubit.showNotification(
        message: labels.passwordGeneratorPasswordCopiedNotification(),
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('PasswordGeneratorCubit --> copyToClipboard() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: failure,
        status: PasswordGeneratorStatus.failure,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('PasswordGeneratorCubit --> copyToClipboard() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        failure: Failure.genericError(),
        status: PasswordGeneratorStatus.failure,
      ));
    }
  }

  /// This method can be used to create a new state password.
  void rerollGeneratedPassword() {
    // Create random password.
    final String generatedPassword = createPassword();

    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      generatedPassword: generatedPassword,
    ));
  }

  /// This method can be used to update password length.
  void updatePasswordLength({required int length}) {
    // Create PasswordGenerator object.
    final PasswordGenerator passwordGenerator = state.passwordGenerator.copyWith(
      passwordLength: length,
    );

    // Only emit state if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      passwordGenerator: passwordGenerator,
    ));
  }

  /// This method can be used to update options lower case letters.
  void lowerCaseChanged() {
    // At least one option has to be selected.
    if (state.passwordGenerator.getOptionCanChange == false && state.passwordGenerator.usesLowerCase) return;

    // Create PasswordGenerator object.
    final PasswordGenerator passwordGenerator = state.passwordGenerator.copyWith(
      usesLowerCase: !state.passwordGenerator.usesLowerCase,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      passwordGenerator: passwordGenerator,
    ));

    // Create random password.
    final String generatedPassword = createPassword();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      generatedPassword: generatedPassword,
    ));
  }

  /// This method can be used to update options upper case letters.
  void upperCaseChanged() {
    // At least one option has to be selected.
    if (state.passwordGenerator.getOptionCanChange == false && state.passwordGenerator.usesUpperCase) return;

    // Create PasswordGenerator object.
    final PasswordGenerator passwordGenerator = state.passwordGenerator.copyWith(
      usesUpperCase: !state.passwordGenerator.usesUpperCase,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      passwordGenerator: passwordGenerator,
    ));

    // Create random password.
    final String generatedPassword = createPassword();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      generatedPassword: generatedPassword,
    ));
  }

  /// This method can be used to update options numbers.
  void numbersChanged() {
    // At least one option has to be selected.
    if (state.passwordGenerator.getOptionCanChange == false && state.passwordGenerator.usesNumbers) return;

    // Create PasswordGenerator object.
    final PasswordGenerator passwordGenerator = state.passwordGenerator.copyWith(
      usesNumbers: !state.passwordGenerator.usesNumbers,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      passwordGenerator: passwordGenerator,
    ));

    // Create random password.
    final String generatedPassword = createPassword();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      generatedPassword: generatedPassword,
    ));
  }

  /// This method can be used to update options symbols.
  void symbolsChanged() {
    // At least one option has to be selected.
    if (state.passwordGenerator.getOptionCanChange == false && state.passwordGenerator.usesSymbols) return;

    // Create PasswordGenerator object.
    final PasswordGenerator passwordGenerator = state.passwordGenerator.copyWith(
      usesSymbols: !state.passwordGenerator.usesSymbols,
    );

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      passwordGenerator: passwordGenerator,
    ));

    // Create random password.
    final String generatedPassword = createPassword();

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      generatedPassword: generatedPassword,
    ));
  }

  /// This mehod can be used to create a random password.
  String createPassword() {
    // Initialize password.
    String password = '';

    // Create password.
    for (int i = 0; i < state.passwordGenerator.passwordLength; i++) {
      // Access random index of specified list.
      final int randomIndex = Random().nextInt(state.passwordGenerator.getCharacterList.length);

      // Access char at index.
      final String randomString = state.passwordGenerator.getCharacterList[randomIndex];

      // Connotate password.
      password = password + randomString;
    }

    // Init helper var.
    String breakWord = '';

    // Get rid of soft line breaks.
    // * This is done because softWrap will break lines in unwated places.
    for (final int element in password.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }

    return breakWord;
  }

  /// This method will be triggered if user closes PasswordGeneratorSheet.
  Future<void> closeSheet() async {
    try {
      // Only do database update if passwordGenerator was edited.
      if (state.passwordGenerator != state.initialPasswordGenerator) {
        // Create updated user object.
        final User updatedUser = user.copyWith(
          passwordGenerator: state.passwordGenerator,
        );

        // Put passwordGenerator into store.
        await _localStorageCubit.state.database!.writeTxn(() async {
          await _localStorageCubit.updateLocalUser(
            updatedUser: updatedUser,
          );
        });
      }

      // Only emit states if cubit is still open.
      if (isClosed) return;

      /// Update initial with edited password generator to be able to compare them again on next instance.
      emit(state.copyWith(
        initialPasswordGenerator: state.passwordGenerator,
        failure: Failure.initial(),
        status: PasswordGeneratorStatus.close,
      ));
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('PasswordGeneratorCubit --> closeSheet() --> failure: ${failure.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: failure,
        status: PasswordGeneratorStatus.failure,
      ));
    } catch (exception) {
      // Output debug messages.
      debugPrint('PasswordGeneratorCubit --> closeSheet() --> exception: ${exception.toString()}');

      // Only emit new states if cubit is open.
      if (isClosed) return;

      emit(state.copyWith(
        failure: Failure.genericError(),
        status: PasswordGeneratorStatus.failure,
      ));
    }
  }
}
