import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:lucent_ally/data/models/picker_items/picker_items.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import "package:pointycastle/export.dart";

// Databases.
import 'package:isar/isar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Config.
import '/config/app_durations.dart';
import '/config/country_specification.dart';

// User with Settings and Labels.
import '/main.dart';

// Cubits.
import '/logic/helper_functions/helper_functions.dart';
import '/widgets/modal_bottom_sheets/charts_sheet/cubit/charts_sheet_cubit.dart';
import '/widgets/modal_bottom_sheets/expense_report_sheet/cubit/expense_report_sheet_cubit.dart';

// Screens.
import '/screens/main/main_screen.dart';

// Schemas.
import '/data/models/groups/schemas/db_group.dart';
import '/data/models/model_entries/schemas/db_model_entry.dart';
import '/data/models/entries/schemas/db_entry.dart';
import '/data/models/users/schemas/db_user.dart';
import '/data/models/tags/schemas/db_tag.dart';
import '/data/models/participants/schemas/db_participant.dart';
import '/data/models/references/group_to_entry/schemas/db_group_to_entry.dart';
import '/data/models/members/schemas/db_member.dart';
import '/data/models/references/participant_to_member/schemas/db_participant_to_member.dart';
import '/data/models/references/recent_entries/schemas/db_recent_entry.dart';
import '/data/models/exchange_rates/schemas/db_exchange_rate.dart';
import '/data/models/model_entry_prefs/schemas/db_model_entry_prefs.dart';
import '/data/models/group_prefs/schemas/db_group_prefs.dart';
import '/data/models/field_types/email_data/schemas/db_email_data.dart';
import '/data/models/field_types/phone_data/phone_data.dart';
import '/data/models/field_types/username_data/schemas/db_username_data.dart';
import '/data/models/field_types/website_data/schemas/db_website_data.dart';
import '/data/models/fields/schemas/db_field.dart';
import '/data/models/fields/schemas/db_fields.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/entries/entry.dart';
import '/data/models/entries/entries.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/model_entries/model_entries.dart';
import '/data/models/groups/group.dart';
import '/data/models/groups/groups.dart';
import '/data/models/members/member.dart';
import '/data/models/members/members.dart';
import '/data/models/participants/participant.dart';
import '/data/models/participants/participants.dart';
import '/data/models/users/user.dart';
import '/data/models/tags/tag.dart';
import '/data/models/tags/tags.dart';
import '/data/models/labels/labels.dart';
import '/data/models/compound_keys/compound_key_participant_to_member.dart';
import '/data/models/compound_keys/compound_key_group_to_entry.dart';
import '/data/models/references/participant_to_member/participant_to_member.dart';
import '/data/models/references/group_to_entry/group_to_entry.dart';
import '/data/models/references/recent_entries/recent_entry.dart';
import '/data/models/files/file_item.dart';
import '/data/models/files/files.dart';
import '/data/models/model_entry_prefs/model_entry_prefs.dart';
import '/data/models/group_prefs/group_prefs.dart';
import '/data/models/fields/field.dart';
import '/data/models/field_types/payment_data/payment_data.dart';
import '/data/models/field_types/payment_data/share_reference.dart';
import '/data/models/field_types/payment_data/creditor_debitor.dart';
import '/data/models/field_types/payment_data/creditors_debitors.dart';
import '/data/models/field_types/number_data/number_data.dart';
import '/data/models/charts/bar_chart/items/bar_item.dart';
import '/data/models/charts/bar_chart/items/bar_items.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/charts/pie_chart/items/pie_item.dart';
import '/data/models/charts/pie_chart/items/pie_items.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/charts/line_chart/items/line_item.dart';
import '/data/models/charts/line_chart/items/line_items.dart';
import '/data/models/charts/line_chart/items/line_dot.dart';
import '/data/models/charts/line_chart/items/line_dots.dart';
import '/data/models/field_types/boolean_data/boolean_data.dart';
import '/data/models/field_types/email_data/email_data.dart';
import '/data/models/field_types/username_data/username_data.dart';
import '/data/models/references/field_to_entry/field_to_entry.dart';
import '/data/models/field_types/avatar_image_data/avatar_image_data.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_types/emotion_data/emotion_data.dart';
import '/data/models/field_types/emotion_data/emotion_item.dart';
import '/data/models/field_types/money_data/money_data.dart';
import '/data/models/field_types/tags_data/tags_data.dart';
import '/data/models/field_types/measurement_data/measurement_data.dart';
import '/data/models/charts/chart.dart';
import '/data/models/secrets/secrets.dart';
import '/data/models/field_types/measurement_data/measurements.dart';
import '/data/models/field_types/phone_data/schemas/db_phone_data.dart';
import '/data/models/field_types/date_and_time_data/date_and_time_data.dart';
import '/data/models/field_types/date_data/date_data.dart';
import '/data/models/field_types/location_data/location_data.dart';
import '/data/models/field_types/password_data/password_data.dart';
import '/data/models/field_types/text_data/text_data.dart';
import '/data/models/field_types/time_data/time_data.dart';
import '/data/models/field_types/website_data/website_data.dart';
import '/data/models/fields/fields.dart';
import '/data/models/exchange_rates/exchange_rate.dart';
import '/data/models/exchange_rates/exchange_rates.dart';
import '/data/models/cloud_user/cloud_user.dart';

// Repositories.
import '/data/repositories/storage/storage_repository.dart';
import '/data/repositories/api/api_repository.dart';

part 'local_storage_state.dart';

// ######################################
// Encrypting
// ######################################

/// This method can be used to encrypt values.
/// * Should be used in a try catch block.
/// * Has to be a top level function in order for compute to work (This means that the function has to be outside of the class).
FutureOr<Uint8List> _encryptValue(Map<String, dynamic> map) async {
  // Access passed data from the provided map.
  final String key = map['key']; // Base64-encoded encryption key.

  // Prepare and generate keys.
  final Uint8List keyBytes = base64.decode(key); // Decodes the key into a byte array.
  final Uint8List ivBytes = _generateBytesKey(length: 16);
  final Uint8List saltBytes = _generateBytesKey(length: 16); // ! Do not change the length of this unless the length is also adjusted in _removeSalt()!

  // Convert salt to base64.
  final String salt = base64.encode(saltBytes);

  // Convert plaintext or binary data to bytes.
  late Uint8List plaintextBytes;

  // Check what type of data was provided.
  if (map['data'] is String) {
    // In case of text, add salt.
    final String plaintext = _addSalt(plaintext: map['data'], salt: salt);

    // Update bytes.
    plaintextBytes = utf8.encode(plaintext);
  }

  // In case of file, do not add salt.
  if (map['data'] is Uint8List) {
    plaintextBytes = map['data']; // Expecting Uint8List for file data.
  }

  // Set up AES in CBC mode with PKCS7 padding for chunked encryption.
  final PaddedBlockCipher cipher = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
    ..init(
      true,
      PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(keyBytes), ivBytes),
        null,
      ),
    );

  // Encrypt the data in a single operation, allowing padding to be handled automatically.
  final Uint8List encryptedData = cipher.process(plaintextBytes);

  // Combine IV and encrypted data for final output.
  final Uint8List ivAndCiphertext = Uint8List(ivBytes.length + encryptedData.length)
    ..setRange(0, ivBytes.length, ivBytes)
    ..setRange(ivBytes.length, ivBytes.length + encryptedData.length, encryptedData);

  return ivAndCiphertext;
}

/// This method can be used to decrypt values.
/// * Should be used in a try catch block.
/// * Has to be a top level function in order for compute to work (This means that the function has to be outside of the class).
FutureOr<dynamic> _decryptValue(Map<String, dynamic> map) async {
  // Extract and decode the Base64-encoded key and encrypted data.
  final Uint8List keyBytes = base64.decode(map['key']);
  final Uint8List encryptedBytes = map['bytes'];
  final bool removeSalt = map['remove_salt'];

  // Extract the IV from the beginning of the encrypted data.
  final Uint8List ivBytes = encryptedBytes.sublist(0, 16); // AES IV is 16 bytes.
  final Uint8List ciphertextBytes = encryptedBytes.sublist(16);

  // Set up AES in CBC mode with PKCS7 padding for decryption.
  final PaddedBlockCipher cipher = PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
    ..init(
      false,
      PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(keyBytes), ivBytes),
        null,
      ),
    );

  // Decrypt the data, which will automatically handle padding.
  final Uint8List decryptedBytes = cipher.process(ciphertextBytes);

  // Salt was added and should be removed.
  if (removeSalt) {
    // Convert decrypted bytes to a string and remove the salt.
    final String decryptedText = utf8.decode(decryptedBytes);
    final String plaintext = _removeSalt(plaintext: decryptedText);

    return plaintext;
  }

  // Salt was not added (for example files do not have salt).
  return decryptedBytes;
}

/// This method can be used to add salt.
String _addSalt({required String plaintext, required String salt}) {
  return '$salt$plaintext';
}

/// This method can be used to remove the salt.
String _removeSalt({required String plaintext}) {
  // Assuming salt is a known length or format, extract the actual plaintext.
  return plaintext.substring(24);
}

/// This method can be used to generate a random IV.
/// * For a key use `length = 32`.
/// * For a IV use `length = 16`.
/// * For a salt use `length = 16`.
Uint8List _generateBytesKey({required int length}) {
  // Init random.
  final FortunaRandom random = FortunaRandom()
    ..seed(
      KeyParameter(
        Uint8List.fromList(List<int>.generate(32, (i) => Random.secure().nextInt(256))),
      ),
    );

  // Return iv.
  return random.nextBytes(length);
}

class LocalStorageCubit extends Cubit<LocalStorageState> with HelperFunctions, WidgetsBindingObserver {
  final StorageRepository _storageRepository;
  final ApiRepository _apiRepository;

  LocalStorageCubit({
    required StorageRepository storageRepository,
    required ApiRepository apiRepository,
  })  : _storageRepository = storageRepository,
        _apiRepository = apiRepository,
        super(LocalStorageState.initial()) {
    // Register as App Lifecycle observer when cubit is created.
    WidgetsBinding.instance.addObserver(this);
  }

  /// The route name for deep links.
  /// ```dart
  /// static const String routeNameDeepLinks = '/deep';
  /// ```
  static const String routeNameDeepLinks = '/deep';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// This can be used to do stuff on app lifecycle events.
    /// For now this is not needed.
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint("App is inactive.");
        break;
      case AppLifecycleState.paused:
        debugPrint("App is paused.");
        break;
      case AppLifecycleState.resumed:
        debugPrint("App is resumed.");
        break;
      case AppLifecycleState.detached:
        debugPrint("App is detached.");
        break;
      case AppLifecycleState.hidden:
        debugPrint("App is hidden.");
        break;
    }
  }

  @override
  Future<void> close() {
    // Remove the observer when the cubit is closed.
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  // ######################################
  // Initialization
  // ######################################

  /// This method will be called on app start.
  /// * Should be used in a try catch block.
  /// * Returns an indication about whether or not this was the first time this app starts.
  Future<bool> initialize() async {
    // Init flutter secure storage.
    final FlutterSecureStorage nativeStorage = await initFlutterSecureStoragePackage();

    // Check if this is the first time the app is running.
    // ! Attention this needs to be safed in normal shared prefs not in secure storage because
    // ! this value needs to be cleared if a user uninstalls the app because otherwise
    // ! it is not possible to know if this was a reinstall and that will lead to problems in the current setup.
    final bool firstAppLaunch = sharedPreferences.getString(Secrets.mapKeyFirstAppLaunch) == null ? true : false;

    // Access app language locale.
    final String languageLocale = sharedPreferences.getString(Secrets.mapKeyLanguageLocale) ?? getSupportedSystemLanguageCode();

    // Access auto logout in minutes.
    final int autoLogoutInMinutes = sharedPreferences.getInt(Secrets.mapKeyAutoLogoutInMinutes) ?? 10;

    // Only emit new states if cubit is still open.
    if (isClosed) throw Failure.genericError();

    // * Theme is already accessed on app start in main function of "main.dart".
    final String theme = user.theme;

    // Initialize time zones.
    final PickerItems timezones = await getAllTimezones();

    // Access current users local timezone.
    final String localTimezone = await FlutterTimezone.getLocalTimezone();

    // Ensure that local timezone is available in all timezones, otherwise set to UTC.
    final String timezone = timezones.getById(id: localTimezone, caseSensitive: true)?.id ?? tz.UTC.name;

    // Update the local variable in the timezone package with the current local timezone to ensure access across app.
    tz.setLocalLocation(tz.getLocation(timezone));

    emit(state.copyWith(
      nativeKeyStorage: nativeStorage,
      // * This user update is needed because state.user has the default value set when initialize() is triggered and this copyWith event
      // * will trigger a listen event in main which will reset the theme to the default.
      user: state.user.copyWith(theme: theme),
      timezones: timezones,
      calledFrom: 'LocalStorageCubit --> initialize()',
    ));

    // Access secure storage users json.
    final String? encodedUser = await getValueFromSecureStorage(key: Secrets.mapKeyUser);

    // Does a user exist?
    final bool userExists = encodedUser != null && encodedUser.isNotEmpty;

    // This is the very fist time the app gets installed on this device.
    if (firstAppLaunch && userExists == false) {
      // Initialize app.
      await onFirstAppLaunch(theme: theme, languageLocale: languageLocale, autoLogoutInMinutes: autoLogoutInMinutes);

      // App was installed the very first time.
      return true;
    }

    // User started the app any time after the first time.
    if (firstAppLaunch == false && userExists) {
      // Initialize app.
      await onAppLaunch(theme: theme, encodedUser: encodedUser, languageLocale: languageLocale, autoLogoutInMinutes: autoLogoutInMinutes);

      // Indicate a normal app launch.
      return false;
    }

    // User deleted and re-installed app.
    if (firstAppLaunch && userExists) {
      // Initialize app.
      await onAppReinstall(theme: theme, encodedUser: encodedUser, languageLocale: languageLocale, autoLogoutInMinutes: autoLogoutInMinutes);

      // Even though this was not the very first time this app was installed on this phone, state should be treated as such form this point on.
      return true;
    }

    // Failed to initialize.
    throw Failure.genericError();
  }

  /// This method will be called if this is the first time the app is launched.
  /// * Should be used in a try catch block.
  Future<void> onFirstAppLaunch({required String theme, required String languageLocale, required int autoLogoutInMinutes}) async {
    // Init values.
    final String userId = const Uuid().v4(); // This userId can be used as public identifier.
    final String userIdentity = const Uuid().v4(); // This userIdentity is never public and only known by this user and this device.
    final String deviceIdentity = const Uuid().v4(); // This deviceIdentity is never public.

    // * Ensure that none of these ids are equal.
    if (userId == userIdentity || userId == deviceIdentity || userIdentity == deviceIdentity) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> onFirstAppLaunch() --> Unbelievably Uuid().v4() created an equal id. Try again.');

      throw Failure.genericError();
    }

    // Create a new user object.
    // ----
    // Username is empty here because if the moment arises and multiple users per device
    // are supported either user has already set a username or username will be empty. In the
    // empty case make user choose a name before unlocking the ability to create more users.
    // ----
    final User currentUser = state.user.copyWith(
      userId: userId,
      theme: theme,
      languageLocale: languageLocale,
      autoLogoutInMinutes: autoLogoutInMinutes,
      username: '',
      localGroupsPasswordSet: false,
      tokens: state.user.tokens.copyWith(
        userIdentity: userIdentity,
        deviceIdentity: deviceIdentity,
      ),
      labels: Labels(languageLocale: languageLocale),
    );

    // #############################
    // Put secrets.
    // * Do this before saveing user to ensure that if it fails, creating user can be retried.
    // #############################

    // Delete all values of secure storage.
    // * This is done to remove any potential values that might have been stored in previous versions of the app.
    await deleteAllValuesFromSecureStorage();

    // Create an encryption key.
    // 32 bytes for AES-256
    // * This is the actual key that will be used to encrypt group data later.
    // * This is done to enable change password functionality without having to reencrypt all data.
    // * This also ensures that a suitably secure encryption key is used.
    await putValueToSecureStorage(
      key: Secrets.mapKeyLocalGroupsEncryptionKey,
      value: base64.encode(_generateBytesKey(length: 32)),
    );

    // Put user into secure storage.
    await putUserToSecureStorage(user: currentUser);

    // Set device first_app_launch value.
    // ! It is crucial that shared prefs is used and not native secure storage! Because this value needs to be removed on app delete.
    final bool success = await sharedPreferences.setString(Secrets.mapKeyFirstAppLaunch, 'false');

    // Setting first app launch value failed. Let user try again.
    if (success == false) throw Failure.genericError();

    // Initialize local database.
    final Isar isar = await initializeIsar(userId: currentUser.userId);

    // Initialize logout timer.
    final Timer logoutTimer = Timer(
      Duration(minutes: currentUser.autoLogoutInMinutes),
      () => triggerLogoutEvent(),
    );

    // Create user.
    await isar.writeTxn(() async {
      // * Save user in database.
      await createLocalUser(isar: isar, user: currentUser);
    });

    // An error occurred.
    if (isClosed) throw Failure.genericError();

    // Update state user.
    emit(state.copyWith(
      user: currentUser,
      database: isar,
      logoutTimer: logoutTimer,
      status: LocalStorageStatus.waiting,
      calledFrom: 'onFirstAppLaunch()',
    ));
  }

  /// This method will be called if this is NOT the first time the app is launched.
  /// * Should be used in a try catch block.
  Future<void> onAppLaunch({required String encodedUser, required String theme, required String languageLocale, required int autoLogoutInMinutes}) async {
    // Decode user.
    final Map<String, dynamic> decoded = json.decode(encodedUser);

    // Access secureStorageUser
    final User secureStorageUser = User.fromSecureStorage(
      secureStorageData: decoded,
    );

    // Initialize local database.
    final Isar isar = await initializeIsar(userId: secureStorageUser.userId);

    // Access localStorageUser.
    // * Use isar object not state.database because it is not yet set.
    final User? localStorageUser = await getLocalUserById(isar: isar, userId: secureStorageUser.userId);

    // Failed to access user, try again.
    if (localStorageUser == null) throw Failure.genericError();

    // Update user with prefered values.
    final User currentUser = secureStorageUser.copyWith(
      // Init SharedPreferences variables.
      theme: theme,
      languageLocale: languageLocale,
      autoLogoutInMinutes: autoLogoutInMinutes,
      // Init local storage variables.
      editedAtInUtc: localStorageUser.editedAtInUtc,
      interactedAtInUtc: localStorageUser.interactedAtInUtc,
      settings: localStorageUser.settings,
      passwordGenerator: localStorageUser.passwordGenerator,
      // Init state variables.
      labels: Labels(languageLocale: languageLocale),
    );

    // Initialize logout timer.
    final Timer logoutTimer = Timer(
      Duration(minutes: currentUser.autoLogoutInMinutes),
      () => triggerLogoutEvent(),
    );

    // An error occurred.
    if (isClosed) throw Failure.genericError();

    // Update state user.
    emit(state.copyWith(
      user: currentUser,
      database: isar,
      logoutTimer: logoutTimer,
      status: LocalStorageStatus.waiting,
      calledFrom: 'onAppLaunch()',
    ));
  }

  /// This method will be called if this is a app reinstalled.
  /// * Should be used in a try catch block.
  Future<void> onAppReinstall({required String encodedUser, required String theme, required String languageLocale, required int autoLogoutInMinutes}) async {
    // Decode user.
    final Map<String, dynamic> secureStorageUser = json.decode(encodedUser);

    // Convert to user object.
    final User preservedUser = User.fromSecureStorage(
      secureStorageData: secureStorageUser,
    );

    // Create a new user object partly with preserved data.
    // ----
    // Username is empty here because if the moment arises and multiple users per device
    // are supported either user has already set a username or username will be empty. In the
    // empty case make user choose a name before unlocking the ability to create more users.
    // ----
    final User currentUser = state.user.copyWith(
      userId: preservedUser.userId.isEmpty ? const Uuid().v4() : preservedUser.userId,
      theme: theme,
      languageLocale: languageLocale,
      autoLogoutInMinutes: autoLogoutInMinutes,
      username: preservedUser.username,
      userEmail: preservedUser.userEmail,
      tokens: state.user.tokens.copyWith(
        userIdentity: preservedUser.tokens.userIdentity.isEmpty ? const Uuid().v4() : preservedUser.tokens.userIdentity,
        deviceIdentity: preservedUser.tokens.deviceIdentity.isEmpty ? const Uuid().v4() : preservedUser.tokens.deviceIdentity,
        userPermission: preservedUser.tokens.userPermission,
      ),
      labels: Labels(languageLocale: languageLocale),
    );

    // * Ensure that none of these ids are equal.
    if (currentUser.userId == currentUser.tokens.userIdentity || currentUser.userId == currentUser.tokens.deviceIdentity || currentUser.tokens.userIdentity == currentUser.tokens.deviceIdentity) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> onAppReinstall() --> Unbelievably Uuid().v4() created an equal id. Try again.');

      throw Failure.genericError();
    }

    // Delete all values of secure storage, to enable a clean start.
    await deleteAllValuesFromSecureStorage();

    // #############################
    // Put secrets.
    // * Do this before saveing user to ensure that if it fails, creating user can be retried.
    // #############################

    // Create an encryption key.
    // 32 bytes for AES-256
    // * This is the actual key that will be used to encrypt group data later.
    // * This is done to enable change password functionality without having to reencrypt all data.
    // * This also ensures that a suitably secure encryption key is used.
    await putValueToSecureStorage(
      key: Secrets.mapKeyLocalGroupsEncryptionKey,
      value: base64.encode(_generateBytesKey(length: 32)),
    );

    // Put user into shared prefs.
    await putUserToSecureStorage(user: currentUser);

    // Set device first_app_launch value.
    // ! It is crucial that shared prefs is used and not native secure storage! Because this value needs to be removed on app delete.
    final bool success = await sharedPreferences.setString(Secrets.mapKeyFirstAppLaunch, 'false');

    // Setting first app launch value failed. Let user try again.
    if (success == false) throw Failure.genericError();

    // Initialize local database.
    final Isar isar = await initializeIsar(userId: currentUser.userId);

    // Initialize logout timer.
    final Timer logoutTimer = Timer(
      Duration(minutes: currentUser.autoLogoutInMinutes),
      () => triggerLogoutEvent(),
    );

    // Create user.
    await isar.writeTxn(() async {
      // * Save user in database.
      await createLocalUser(user: currentUser, isar: isar);
    });

    // An error occurred.
    if (isClosed) throw Failure.genericError();

    // Update state user.
    emit(state.copyWith(
      user: currentUser,
      database: isar,
      logoutTimer: logoutTimer,
      status: LocalStorageStatus.waiting,
      calledFrom: 'onAppReinstall()',
    ));
  }

  /// This method can be used to check if this app still meets the requirements for API interaction.
  /// * Should be used in a try catch block.
  Future<void> meetsApiRequirements() async {
    // Access Package info.
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // Access Platform.
    final String platform = getCurrentPlatform();

    // Access build number.
    final String buildNumber = packageInfo.buildNumber;

    // Access version.
    final String version = packageInfo.version;

    // Access installer store.
    final String? store = packageInfo.installerStore;

    // Access build signature.
    final String buildSignature = packageInfo.buildSignature;

    // Create map.
    final Map<String, dynamic> data = {
      'user_id': user.userId,
      'platform': platform,
      'build_number': buildNumber,
      'version': version,
      'store': store,
      'build_signature': buildSignature,
    };

    // * Check build with api.
    await _apiRepository.meetsApiRequirements(
      user: user,
      data: data,
    );
  }

  /// This method will be called if user navigated from a deep link.
  void handleDeepLink({required String deepLink}) {
    // Get access to local storage status.
    final bool isLoggedIn = state.database != null;

    // Extract arguments.
    Map<String, String> arguments = parseDeepLink(deepLink);

    // Only emit states if cubit is open.
    if (isClosed) return;

    // Emit state.
    emit(state.copyWith(
      // Always set last deep link arguments because mainScreen.initialize will check if they exist and trigger a deep
      // link event if that is the case.
      lastDeepLinkArgs: arguments,
      // In case app was available in the background, main screen should be visible and deepLink status can be triggered.
      // Otherwise do not trigger a status change.
      status: isLoggedIn ? LocalStorageStatus.deepLink : null,
      calledFrom: 'handleDeepLink()',
    ));

    // Only emit states if cubit is open.
    if (isClosed) return;

    // Reset local storage state.
    emit(state.copyWith(
      status: LocalStorageStatus.waiting,
      calledFrom: 'handleDeepLink()',
    ));
  }

  // ######################################
  // Auto logout
  // ######################################

  /// This method can be used to reset automatic logout.
  void handleAutoLogout() {
    // Cancel old timer if it exists.
    if (state.logoutTimer != null) state.logoutTimer!.cancel();

    // Create new timer.
    final Timer logoutTimer = Timer(
      Duration(minutes: state.user.autoLogoutInMinutes),
      () => triggerLogoutEvent(),
    );

    // Only emit states if cubit is open.
    if (isClosed) return;

    // Emit new state.
    emit(state.copyWith(
      logoutTimer: logoutTimer,
      calledFrom: 'handleAutoLogout()',
    ));
  }

  /// This method can be used to perform logout.
  Future<void> triggerLogoutEvent() async {
    // Cancel old timer if it exists.
    if (state.logoutTimer != null) state.logoutTimer!.cancel();

    // Create new timer.
    final Timer logoutTimer = Timer(
      Duration(minutes: state.user.autoLogoutInMinutes),
      () => triggerLogoutEvent(),
    );

    // Only emit states if cubit is open.
    if (isClosed) return;

    emit(state.copyWith(
      logoutTimer: logoutTimer,
      status: LocalStorageStatus.logout,
      calledFrom: 'triggerLogoutEvent()',
    ));
  }

  /// This method gets triggered if state is set to logout.
  Future<void> onLogoutEvent({required BuildContext context}) async {
    // On logout event, close protected groups if one is in the foreground.
    if (state.protectedGroupIsShown) {
      Navigator.popUntil(context, (route) {
        return route.settings.name == MainScreen.routeName;
      });
    }

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      // * On logout event decrypted images need to be resetted.
      decryptedImages: Files.initial(),
      // * On logout event user auth is not fresh anymore.
      authIsFresh: false,
      // * Update the protected group is shown variable.
      protectedGroupIsShown: false,
      // * On logout event a recent entries reload is triggered.
      showProtectedEntries: false,
      status: LocalStorageStatus.showProtectedEntriesChanged,
      calledFrom: 'onLogoutEvent()',
    ));

    // Micro service to await state update.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // * Reset state.
    emit(state.copyWith(
      status: LocalStorageStatus.waiting,
      calledFrom: 'onLogoutEvent()',
    ));
  }

  /// This method can be used to update the protected Group is shown value.
  Future<void> updateProtectedGroupIsShown({required bool visible}) async {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      protectedGroupIsShown: visible,
      calledFrom: 'updateProtectedGroupIsShown()',
    ));
  }

  /// This method can be used to update the show protected entries value.
  Future<void> updateShowProtectedRecentEntries({required bool visible}) async {
    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      showProtectedEntries: visible,
      status: LocalStorageStatus.showProtectedEntriesChanged,
      calledFrom: 'updateShowProtectedRecentEntries()',
    ));

    // Micro service to await state update.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    // * Reset state.
    emit(state.copyWith(
      status: LocalStorageStatus.waiting,
      calledFrom: 'updateShowProtectedRecentEntries()',
    ));
  }

  // ######################################
  // State
  // ######################################

  /// This method can be used to set loaded images to local storage state.
  /// * This ensures that images are not reloaded every time an entry is selected.
  Future<void> setImagesToLocalStorageState({required FileItem imageItem}) async {
    // Add unique image item.
    final Files images = state.decryptedImages.put(
      fileItem: imageItem,
    );

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      decryptedImages: images,
      calledFrom: 'setImagesToLocalStorageState()',
    ));
  }

  // ######################################
  // Database
  // ######################################

  /// This method opens local database and updates local storage path.
  /// * Should be used in a try catch block.
  Future<Isar> initializeIsar({required String userId}) async {
    // Get the Application documents directory.
    final Directory dir = await _storageRepository.getBaseDirectory(
      userId: userId,
    );

    // Make sure it exists.
    final Directory directory = await dir.create(recursive: true);

    // Open database.
    final Isar database = await _storageRepository.openDatabase(
      directoryPath: directory.path,
      databaseName: 'user_data',
    );

    return database;
  }

  // ######################################
  // System
  // ######################################

  /// This method can be used to access the current system language code.
  /// * Returns initial (en) on error or if system language is not supported.
  String getSupportedSystemLanguageCode() {
    try {
      // Access system language code.
      final String systemLanguageCode = WidgetsBinding.instance.platformDispatcher.locales.first.languageCode;

      // Check that systemLanguageCode is supported.
      if (User.supportedLanguages.contains(systemLanguageCode)) return systemLanguageCode;

      // System language is not supported, output debug message.
      debugPrint('LocalStorageCubit --> getCurrentSystemLanguageCode() --> system language ($systemLanguageCode) is not supported.');

      // Return initial.
      return User.initial().languageLocale;
    } catch (error) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> getCurrentSystemLanguageCode() --> failed, use Settings.initial().languageLocale');

      // Return initial.
      return User.initial().languageLocale;
    }
  }

  /// This method can be used to get the default currency code based on system settings.
  /// * Returns `USD` as a default if no meaningful assumption can be made.
  Future<String> getAssumedDefaultCurrency() async {
    // Access default currency code based on user locale.
    final CountrySpecification? countrySpecification = CountrySpecification.getCountrySpecificationByLocale(
      locale: WidgetsBinding.instance.platformDispatcher.locale,
    );

    // Set the default currency code based on returned country Specification.
    // * In case none was found, use "USD" as default.
    final String defaultCurrencyCode = countrySpecification?.currencyCode ?? "USD";

    return defaultCurrencyCode;
  }

  /// This method can be used to get the default iso country code based on system settings.
  /// * Returns "" as a default if no meaningful assumption can be made.
  Future<String> getAssumedDefaultIsoCountryCode() async {
    // Access default currency code based on user locale.
    final CountrySpecification? countrySpecification = CountrySpecification.getCountrySpecificationByLocale(
      locale: WidgetsBinding.instance.platformDispatcher.locale,
    );

    // Access the most likely country code.
    final String isoCountryCode = countrySpecification?.isoCountryCode ?? '';

    return isoCountryCode;
  }

  /// This method can be used to get the arguemnts from a deep link.
  /// * Returns ```{}``` on error.
  Map<String, String> parseDeepLink(String queryString) {
    try {
      Map<String, String> result = {};

      // Remove prefix.
      queryString = queryString.replaceFirst(RegExp(r'^.*\?'), '');

      List<String> keyValuePairs = queryString.split('&');

      for (String keyValuePair in keyValuePairs) {
        List<String> parts = keyValuePair.split('=');

        if (parts.length == 2) {
          String key = Uri.decodeQueryComponent(parts[0]);
          String value = Uri.decodeQueryComponent(parts[1]);
          result[key] = value;
        }
      }

      return result;
    } catch (error) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> parseDeepLink() --> failed, use {}');

      // Return initial.
      return {};
    }
  }

  // ######################################
  // Encryption wrappers.
  // ######################################

  /// This is a wrapper around compute and encrypt for easier use of compute.
  /// * Should be used in a try catch block.
  /// * Set `dataType` to either `text` or `file` to ensure that value is correctly encrypted.
  Future<Uint8List> _encryptValueWrapper({String? value, Uint8List? fileBytes, required Secrets secrets}) async {
    // In case both values were supplied throw Failure.
    if (value != null && fileBytes != null) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> _encryptValueWrapper() --> failure because both value and fileBytes are set.');

      // Stop function.
      throw Failure.initial();
    }

    // In case both values are missing throw Failure.
    if (value == null && fileBytes == null) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> _encryptValueWrapper() --> failure because neither value nor fileBytes were set.');

      // Stop function.
      throw Failure.initial();
    }

    // Encrypt desired values.
    final Uint8List encryptedValue = await compute(
      _encryptValue,
      {
        'key': secrets.localGroupsEncryptionKey,
        'data': value ?? fileBytes,
      },
    );

    return encryptedValue;
  }

  /// This is a wrapper around compute and decrypt for easier use of compute.
  /// * Should be used in a try catch block.
  Future<dynamic> _decryptValueWrapper({required Uint8List value, required bool removeSalt, required Secrets secrets}) async {
    // Encrypt desired values.
    final dynamic decryptedValue = await compute(
      _decryptValue,
      {
        'key': secrets.localGroupsEncryptionKey,
        'bytes': value,
        'remove_salt': removeSalt,
      },
    );

    return decryptedValue;
  }

  // ######################################
  // # Shared Preferences
  // ######################################

  /// This method can be used to store a value in SharedPreferences.
  /// * Should be used in a try catch block.
  Future<void> putValueToSharedPreferences({required String key, required dynamic value}) async {
    // Put a String value.
    if (value is String) {
      // Store the groups encryption key.
      await sharedPreferences.setString(
        key,
        value,
      );

      return;
    }

    // Put an Int value.
    if (value is int) {
      // Store the groups encryption key.
      await sharedPreferences.setInt(
        key,
        value,
      );

      return;
    }

    // Put a Boolean value.
    if (value is bool) {
      // Store the groups encryption key.
      await sharedPreferences.setBool(
        key,
        value,
      );

      return;
    }

    throw Failure.genericError();
  }

  // ######################################
  // # Native Key Storage
  // ######################################

  /// This method can be used to init FlutterSecureStorage Package.
  /// * Should be used in a try catch block.
  Future<FlutterSecureStorage> initFlutterSecureStoragePackage() async {
    // Init Android options to use encryptedSharedPreferences.
    // * According to online sources it is more secure to use this option then to not use it.
    // * According to the docs this has to be initialized like this instead of directly in the constructor.
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    // Init the plugin.
    final FlutterSecureStorage storage = FlutterSecureStorage(
      aOptions: getAndroidOptions(),
      iOptions: const IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    );

    return storage;
  }

  /// This method can be used to validate a provided password with app password.
  /// * Should be used in a try catch block.
  Future<void> validateAppPassword({required String password}) async {
    // Make sure password is not empty.
    // * Use trim here to ensure that password cannot be only spaces.
    // * Sometimes it is better to prohibit something...
    if (password.trim().isEmpty) throw Failure.passwordCannotBeEmpty();

    // Make sure password does not exceed 50 chars.
    if (password.length > 50) throw Failure.passwordIsTooLong();

    // Get current failed attempts and last lockout time.
    int failedAttempts = int.parse(await getValueFromSecureStorage(key: Secrets.mapKeyFailedAttempts) ?? '0');
    final String? lockoutTimeString = await getValueFromSecureStorage(key: Secrets.mapKeyLockoutTime);

    // Convert lockout time.
    final DateTime? lockoutTime = lockoutTimeString != null ? DateTime.parse(lockoutTimeString) : null;

    // Access now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    // Check if the lockout period is over and reset attempts if it is.
    if (lockoutTime != null && nowInUtc.isAfter(lockoutTime)) {
      // Reset failed attempts after lockout period.
      failedAttempts = 0;

      // Reset secure storage.
      await deleteValueFromSecureStorage(key: Secrets.mapKeyFailedAttempts);
      await deleteValueFromSecureStorage(key: Secrets.mapKeyLockoutTime);
    }

    // Check if currently in lockout period.
    if (lockoutTime != null && nowInUtc.isBefore(lockoutTime)) throw Failure.lockoutError();

    // Check if user provided the correct password.
    if (password != await getValueFromSecureStorage(key: Secrets.mapKeyAppPassword)) {
      // Increment failed attempts.
      failedAttempts++;

      // Store value in secure storage.
      await putValueToSecureStorage(value: failedAttempts.toString(), key: Secrets.mapKeyFailedAttempts);

      // Lock out if max attempts are reached.
      if (failedAttempts >= 10) {
        // Create new lockout time.
        final DateTime newLockoutTime = nowInUtc.add(const Duration(days: 1));

        // Store value in secure storage.
        await putValueToSecureStorage(value: newLockoutTime.toIso8601String(), key: Secrets.mapKeyLockoutTime);

        // Let user know about lockout.
        throw Failure.lockoutError();
      }

      throw Failure.incorrectPassword();
    }

    // Reset failed attempts on successful login.
    await deleteValueFromSecureStorage(key: Secrets.mapKeyFailedAttempts);
    await deleteValueFromSecureStorage(key: Secrets.mapKeyLockoutTime);

    // * Set indication that user has recently authenticated. That way user does not need to reauthenticate
    // * everytime a protected group is closed. Once logout is triggerd, a reauthentification is needed.

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      authIsFresh: true,
      calledFrom: 'validateAppPassword()',
    ));

    // * Trigger micro service to ensure that state update is respected app wide.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));
  }

  /// This method can be used to set a app password.
  /// * Should be used in a try catch block.
  Future<void> setAppPassword({required String password}) async {
    // Create updated user.
    final User updatedUser = user.copyWith(
      localGroupsPasswordSet: true,
    );

    // Set password.
    // * Do this before saveing updated user to ensure that failure does not result in a failed state loop.
    await putValueToSecureStorage(key: Secrets.mapKeyAppPassword, value: password);

    // Update secure storage.
    // * This method will updade user of lcoal storage state with updated User.
    await putUserToSecureStorage(user: updatedUser);

    // * Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      user: updatedUser,
      calledFrom: 'LocalStorageCubit --> setAppPassword()',
    ));
  }

  /// This method can be used to store a user in secure storage.
  /// * Should be used in a try catch block.
  Future<void> putUserToSecureStorage({required User user}) async {
    // Transform into SharedPreferences object.
    final Map<String, dynamic> secureStorageUser = user.toSecureStorage();

    // Encode list.
    final String encoded = json.encode(secureStorageUser);

    // Save object in secure storage.
    await putValueToSecureStorage(key: Secrets.mapKeyUser, value: encoded);
  }

  /// This method can be used to store a value in native secure storage.
  /// * Should be used in a try catch block.
  Future<void> putValueToSecureStorage({required String key, required String value}) async {
    // Store the groups encryption key.
    await state.nativeKeyStorage!.write(
      key: key,
      value: value,
    );
  }

  /// This method can be used to read a value from native secure storage.
  /// * Should be used in a try catch block.
  /// * Returns `null` if `key` is not found.
  Future<String?> getValueFromSecureStorage({required String key}) async {
    // Read value.
    final String? value = await state.nativeKeyStorage!.read(
      key: key,
    );

    return value;
  }

  /// This method can be used to delete all native key store values.
  /// * Should be used in a try catch block.
  Future<void> deleteAllValuesFromSecureStorage() async => state.nativeKeyStorage!.deleteAll();

  /// This method can be used to delete a value from native key storage.
  /// * Should be used in a try catch block.
  Future<void> deleteValueFromSecureStorage({required String key}) async {
    // Delete value.
    await state.nativeKeyStorage!.delete(
      key: key,
    );
  }

  /// This method can be used to access encryption secrets from secure storage.
  /// * Should be used in a try catch block.
  Future<Secrets> getSecretsFromSecureStorage() async {
    // Read groups encryption key.
    final String? key = await getValueFromSecureStorage(key: Secrets.mapKeyLocalGroupsEncryptionKey);

    // Helper vars.
    final bool keyAccessed = key != null && key.isNotEmpty;

    // Check if all values have been successfully accessed.
    if (keyAccessed == false) throw Failure.failedToAccessSecrets();

    return Secrets(
      localGroupsEncryptionKey: key!,
    );
  }

  // ######################################
  // Local User
  // ######################################

  /// This method can be used to create a new user.
  /// * Should be used in a try catch block.
  /// * If `isar` is set, it will be used. Otherwise state.database will be used.
  Future<User> createLocalUser({required User user, Isar? isar}) async {
    // Encode the user object to corresponding database schema.
    final DbUser schema = user.toSchema();

    // * Decode schema to access initial settings values.
    final User finalUser = User.fromSchema(fromNativeKeystore: state.user, schema: schema);

    await _storageRepository.create(
      db: isar ?? state.database,
      collectionName: DbUser.collectionName,
      schema: schema,
      shouldThrow: Failure.failureToCreateUser(),
    );

    return finalUser;
  }

  /// This method can be used to access a user by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if user was not found.
  /// * If `isar` is set, it will be used. Otherwise state.database will be used.
  Future<User?> getLocalUserById({required String userId, Isar? isar}) async {
    // Transform String id to int id.
    final int id = DbUser.fastHash(userId);

    final DbUser? schema = await _storageRepository.getById(
      db: isar ?? state.database,
      id: id,
      collectionName: DbUser.collectionName,
    ) as DbUser?;

    if (schema == null) return null;

    // Transform from schema.
    final User user = User.fromSchema(fromNativeKeystore: state.user, schema: schema);

    return user;
  }

  /// This method can be used to update an existing ```User``` object.
  /// * Should be used in a try catch block.
  /// * Updates user in localStorageState.
  /// * If `isar` is set, it will be used. Otherwise state.database will be used.
  Future<User> updateLocalUser({required User updatedUser, Isar? isar}) async {
    // Encode the user object to corresponding database schema.
    final DbUser schema = updatedUser.toSchema();

    await _storageRepository.update(
      db: isar ?? state.database,
      collectionName: DbUser.collectionName,
      schema: schema,
      shouldThrow: Failure.failureToUpdateUser(),
    );

    // Only update state if cubit is still open.
    if (isClosed) throw Failure.genericError();

    emit(state.copyWith(
      user: updatedUser,
      calledFrom: 'LocalStorageCubit --> updateLocalUser()',
    ));

    return updatedUser;
  }

  // ######################################
  // Cloud User
  // ######################################

  /// This method can be used to create a ```User``` in the cloud.
  /// * Should be used in a try catch block.
  /// * Updates local user object in localStorageState.
  Future<bool> createCloudUser({bool shouldThrow = true}) async {
    try {
      // * User already exists in cloud. Do nothing.
      if (state.user.isCloudUser) return true;

      // * Create anonymous cloud user.
      final User cloudUser = await _apiRepository.createCloudAnonUser(
        user: state.user,
      );

      // If returned user id differs from local user id, throw error.
      // * This is just a precaution to prevent later fuck ups and ensure that in case
      // * this happens a local implementation is done properly first.
      if (cloudUser.userId != user.userId) throw Failure.genericError();

      // Update the isCloudUser property.
      final User updatedCloudUser = cloudUser.copyWith(
        isCloudUser: true,
      );

      // Set secure storage object.
      await putUserToSecureStorage(user: updatedCloudUser);

      // Only emit new states if cubit is still open.
      if (isClosed) throw Failure.genericError();

      emit(state.copyWith(
        user: updatedCloudUser,
        calledFrom: 'LocalStorageCubit --> createCloudUser()',
      ));

      // * Trigger micro service to ensure that state update is respected app wide.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));

      return true;
    } catch (e) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> createCloudUser() --> exception: ${e.toString()}');

      // In case shouldThrow was set to true, rethrow.
      if (shouldThrow) rethrow;

      return false;
    }
  }

  /// This method can be used to check if a user can still change there username.
  /// * This should be used in a try catch block.
  Future<bool> getSelfUsernameCanChange() async {
    // * Check if this user can still change their username.
    final bool canChange = await _apiRepository.getSelfUsernameCanChange(
      user: state.user,
    );

    return canChange;
  }

  /// This method can be used to change the username.
  /// * Should be used in a try catch bock.
  Future<void> selfChangeUsername({required String username}) async {
    // * Change username.
    await _apiRepository.selfChangeUsername(
      user: state.user,
      username: username,
    );

    // Create updated user.
    final User updatedUser = user.copyWith(
      username: username,
    );

    // Set secure storage object.
    await putUserToSecureStorage(user: updatedUser);

    // Only emit new states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      user: updatedUser,
      calledFrom: 'LocalStorageCubit --> selfChangeUsername()',
    ));
  }

  /// This method can be used to ban a user from a shared group.
  /// * Should be used in a try catch block.
  Future<void> banUserFromSharedGroup({required String bannedUserId, required String rootGroupReference, required String groupId}) async {
    // Conduct query.
    await _apiRepository.banUserFromSharedGroup(
      user: user,
      bannedUserId: bannedUserId,
      rootGroupReference: rootGroupReference,
      groupId: groupId,
    );
  }

  /// This method can be used to revoke a ban from a user.
  /// * Should be used in a try catch block.
  Future<void> revokeBanFromSharedGroup({required String bannedUserId, required String rootGroupReference, required String groupId}) async {
    // Conduct query.
    await _apiRepository.revokeBanFromSharedGroup(
      user: user,
      bannedUserId: bannedUserId,
      rootGroupReference: rootGroupReference,
      groupId: groupId,
    );
  }

  /// This method can be used to access information about whether or not a user is banned from specified group.
  /// * Should be used in a try catch block.
  Future<bool> getUserIsBanned({required String rootGroupReference, required String groupId, required String referencedUserId}) async {
    // Conduct query.
    final bool userIsBanned = await _apiRepository.getUserIsBanned(
      user: user,
      rootGroupReference: rootGroupReference,
      groupId: groupId,
      referencedUserId: referencedUserId,
    );

    return userIsBanned;
  }

  /// This method can be used to access the number of available shared exports of a user.
  /// * Should be used in a try catch block.
  Future<int> getAvailableExports() async {
    // Conduct query.
    final int availableExports = await _apiRepository.getAvailableExports(
      user: user,
    );

    return availableExports;
  }

  /// This method can be used to change the number of available exports.
  /// * Should be used in a try catch block.
  /// * Returns the currently available exports.
  Future<int> decrementAvailableSharedExports({required int amount}) async {
    // Conduct query.
    final int availableExports = await _apiRepository.decrementAvailableSharedExports(
      user: user,
      amount: amount,
    );

    return availableExports;
  }

  /// This method can be used to access a cloud user by id.
  /// * Should be used in a try catch block.
  /// * This method updates cloud user cache in state.
  Future<CloudUser?> getCloudUserById({required String userId}) async {
    // Check if this user is in local cache.
    for (final CloudUser item in state.cloudUsersCache) {
      // User found locally, return item.
      if (item.userId == userId) return item;
    }

    // Conduct cloud query.
    final CloudUser? cloudUser = await _apiRepository.getCloudUserById(
      user: user,
      otherUserId: userId,
    );

    // User found, update cache.
    // * Make sure that self user is not stored in cache. This should not happen but better safe then sorry.
    if (cloudUser != null && cloudUser.userId != user.userId) {
      // Update list.
      final List<CloudUser> updatedCache = [...state.cloudUsersCache, cloudUser];

      // Only emit states if cubit is still open.
      if (isClosed) return cloudUser;

      emit(state.copyWith(
        cloudUsersCache: updatedCache,
        calledFrom: 'LocalStorageCubit --> getCloudUserById()',
      ));

      // * Make sure that state update is conducted before reporting success.
      await Future.delayed(const Duration(milliseconds: AppDurations.microService));
    }

    return cloudUser;
  }

  // ######################################
  // Request ids
  // ######################################

  /// This function can be used to get a unique request id.
  /// * Should be used in a try catch block.
  /// * Checks ```state.cancledRequestIds``` to ensure unique request ids.
  /// * Checks ```state.currentRequestId``` to ensure unique request ids.
  Future<String> getRequestId() async {
    // * This is used to block requests at the api level if needed.
    final String requestId = const Uuid().v4();

    // * These are unlikely to happen but lets make sure.
    if (state.cancledRequestIds.contains(requestId)) throw Failure.genericError();
    if (state.currentRequestId == requestId) throw Failure.genericError();
    if (requestId.isEmpty) throw Failure.genericError();

    // Only emit states if cubit is still open.
    // * In this case throw a failure to ensure parent function stops.
    if (isClosed) throw Failure.genericError();

    emit(state.copyWith(
      currentRequestId: requestId,
      calledFrom: 'getRequestId()',
    ));

    // Emit micro service to make sure state update is respected.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));

    return requestId;
  }

  /// This function can be used to check if a request was cancled by user.
  Future<bool> getWasRequestCancled({required String requestId}) async {
    if (state.cancledRequestIds.contains(requestId)) return true;
    return false;
  }

  /// This function can be used to cancle a request.
  Future<void> cancleRequestLocally() async {
    // Create updated cancled requests list.
    final List<String> updated = [...state.cancledRequestIds, state.currentRequestId];

    // Only emit states if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      currentRequestId: '',
      cancledRequestIds: updated,
      calledFrom: 'cancleRequestLocally()',
    ));

    // Emit micro service to make sure state update is respected.
    await Future.delayed(const Duration(milliseconds: AppDurations.microService));
  }

  // ######################################
  // Files
  // ######################################

  /// This method can be used to create user specific file path.
  /// * Returns `${dir.path}/$userId/groups/$groupId/$relativePath`.
  Future<String> createLocalFilePath({required String groupId, required String relativePath}) async {
    // Get the Application documents directory.
    final Directory dir = await _storageRepository.getBaseDirectory(userId: user.userId);

    // Create file path.
    final String path = '${dir.path}groups/$groupId/$relativePath';

    return path;
  }

  /// This method can be used to access bytes of a file.
  /// * Returns ```null``` on error.
  Future<Uint8List?> getLocalFileBytes({required String filePath, required Secrets? secrets, required bool isEncrypted}) async {
    // Access the bytes of specified file.
    final Uint8List? fileBytes = await _storageRepository.getFileBytes(
      filePath: filePath,
    );

    // An error occurred.
    if (fileBytes == null) return null;

    // Data was not encrypted, return bytes.
    if (isEncrypted == false) return fileBytes;

    // Decrypt bytes.
    final Uint8List decrypted = await _decryptValueWrapper(
      value: fileBytes,
      secrets: secrets!,
      removeSalt: false,
    ) as Uint8List;

    // Decode.
    return decrypted;
  }

  /// This method can be used to put a file into local storage.
  /// * Should be used in a try catch block.
  Future<void> putLocalFile({required String filePath, required Uint8List bytes, required String mimeType, required bool encrypt, required Secrets? secrets}) async {
    // Encrypt data before saveing it.
    if (encrypt) {
      // Encrypt file bytes.
      bytes = await _encryptValueWrapper(
        fileBytes: bytes,
        secrets: secrets!,
      );
    }

    // Create updated file.
    final XFile encryptedFile = XFile.fromData(
      path: filePath,
      bytes,
      mimeType: mimeType,
    );

    // Create File.
    await _storageRepository.putFile(
      xFile: encryptedFile,
    );
  }

  /// This method can be used to delete a file.
  /// * Returns `null` on error.
  Future<bool> deleteLocalFile({required String filePath}) async {
    try {
      // Delete file.
      await _storageRepository.deleteFile(
        filePath: filePath,
      );

      return true;
    } catch (error) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> deleteLocalFile() --> exception: ${error.toString()}');
      return false;
    }
  }

  /// This method can be used to delete any empty directories that are discovered in base directory.
  /// * Should be used in a try catch block.
  Future<void> deleteAllEmptyLocalDirectories() async {
    await _storageRepository.deleteAllEmptyDirectories();
  }

  /// This method can be used to delete all files of an entry.
  /// * Should be used in a try catch block.
  /// * This deletes the specific ```entry``` directory defined by the ```entry.entryId```.
  Future<void> deleteAllLocalFilesOfEntry({required Entry entry, required Group group}) async {
    // Create file path.
    final String directoryPath = await createLocalFilePath(
      groupId: group.groupId,
      relativePath: 'entries/${entry.entryId}/',
    );

    // Delete entry directory.
    await _storageRepository.deleteDirectory(
      directoryPath: directoryPath,
    );
  }

  /// This method can be used to delete all files of a group.
  /// * Should be used in a try catch block.
  /// * This deletes the specific ```group``` directory defined by the ```group.groupId```.
  Future<void> deleteAllLocalFilesOfGroup({required Group group}) async {
    // Create file path.
    final String directoryPath = await createLocalFilePath(
      groupId: group.groupId,
      relativePath: '',
    );

    // Delete entry directory.
    await _storageRepository.deleteDirectory(
      directoryPath: directoryPath,
    );
  }

  /// Load files of folder.
  /// * Should be used in a try catch block.
  Future<dynamic> loadLocalFilesOfFolder({required String folderPath, required bool onlyPaths}) async {
    // Access files.
    final List<dynamic> data = await _storageRepository.loadFilesOfFolderRecursively(
      folderPath: folderPath,
      onlyPaths: onlyPaths,
    );

    return data;
  }

  /// This method can be used to load a local file item into state.
  /// * Returns null on error.
  Future<FileItem?> loadLocalFileItem({required FileItem? fileItem, required Group fromGroup}) async {
    try {
      // If provided fileItem is null, return null.
      // * This means there is a bug somewhere.
      if (fileItem == null) return null;

      // Check if this FileItem has bytes available.
      if (fileItem.bytes != null) {
        // * Update images in local storage state.
        // * This ensures that images wont have to get decrypted again for this session.
        await setImagesToLocalStorageState(
          imageItem: fileItem,
        );

        return fileItem;
      }

      // Check if this file is already decrypted.
      final FileItem? stateFileItem = state.decryptedImages.byId(
        fileItem: fileItem,
      );

      // This fileItem is already available in state.
      if (stateFileItem != null) return stateFileItem;

      // Access secrets.
      final Secrets? secrets = fromGroup.isEncrypted ? await getSecretsFromSecureStorage() : null;

      // Access file path.
      final String filePath = await createLocalFilePath(
        groupId: fromGroup.groupId,
        relativePath: fileItem.relativePath,
      );

      // Read the bytes from local storage.
      final Uint8List? bytes = await getLocalFileBytes(
        filePath: filePath,
        secrets: secrets,
        isEncrypted: fromGroup.isEncrypted,
      );

      // Failed to access bytes.
      if (bytes == null || bytes.isEmpty) return null;

      // Create updated file item.
      final FileItem updatedFileItem = fileItem.copyWith(
        bytes: bytes,
      );

      // * Update images in local storage state.
      // * This ensures that images wont have to get decrypted again for this session.
      await setImagesToLocalStorageState(
        imageItem: updatedFileItem,
      );

      return updatedFileItem;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadLocalFileItem() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadLocalFileItem() --> exception: ${exception.toString()}');

      return null;
    }
  }

  // ######################################
  // Exchange rates
  // ######################################

  /// This method can be used to create a new ```ExchangeRate```.
  /// * Should be used in a try catch block.
  Future<ExchangeRate> _createExchangeRate({required ExchangeRate exchangeRate}) async {
    // Encode the object to corresponding database schema.
    final DbExchangeRate schema = exchangeRate.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbExchangeRate.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateExchangeRate(),
    );

    return exchangeRate;
  }

  /// This method can be used to find a exchange rate depending on its ```expenseDate``` locally.
  /// * Returns ```null``` on error.
  /// * Returns ```0.0``` if exchange rate was not found.
  Future<Map<String, dynamic>> _findLocalExchangeRate({required DateTime exchangeRateDateInUtc, required String fromCurrencyCode, required String toCurrencyCode}) async {
    try {
      // Generate the standardized exchange rate key.
      final String exchangeRateKey = ExchangeRate.getExchangeRateKey(
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
      );

      // Build query.
      final DbExchangeRate? schema = await state.database!.dbExchangeRates
          .where()
          .exchangeRateDateInUtcExchangeRateKeyEqualTo(
            exchangeRateDateInUtc.millisecondsSinceEpoch,
            exchangeRateKey,
          )
          .findFirst();

      // Check if exchange rate was found.
      if (schema == null) {
        // Output debug messages.
        debugPrint('LocalStorageCubit --> findLocalExchangeRate() --> local exchange rate not found');

        return {
          'status': ExchangeRate.exchangeRateStatusNotFoundLocal,
          'exchange_rate': null,
        };
      }

      // Convert to object.
      ExchangeRate exchangeRate = ExchangeRate.fromSchema(schema: schema)!;

      // Check if reciprocial item was requested.
      final bool isReci = exchangeRate.fromCurrencyCode != fromCurrencyCode;

      // Exchange rate was not found in the cloud.
      if (exchangeRate.exchangeRate == 0.0 || exchangeRate.exchangeRate == 0) {
        return {
          'status': ExchangeRate.exchangeRateStatusNotFoundCloud,
          'exchange_rate': null,
        };
      }

      // Database exchange rate is the reciprocal one, change rate.
      if (isReci) {
        // Update exchange rate.
        exchangeRate = exchangeRate.copyWith(
          exchangeRate: 1 / exchangeRate.exchangeRate,
        );
      }

      return {
        'status': ExchangeRate.exchangeRateStatusSuccessLocal,
        'exchange_rate': exchangeRate,
      };
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> findLocalExchangeRate() --> failure: ${failure.toString()}');

      return {
        'status': ExchangeRate.exchangeRateStatusFailure,
        'exchange_rate': null,
      };
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> findLocalExchangeRate() --> exception: ${exception.toString()}');

      return {
        'status': ExchangeRate.exchangeRateStatusFailure,
        'exchange_rate': null,
      };
    }
  }

  /// This method can be used to find a exchange rate depending on its ```expenseDate``` in the cloud.
  /// * Returns ```null``` on error.
  /// * Returns ```0.0``` if exchange rate was not found.
  Future<Map<String, dynamic>> _findCloudExchangeRate({required DateTime exchangeRateDateInUtc, required String fromCurrencyCode, required String toCurrencyCode}) async {
    try {
      // Access exchange rate from the cloud.
      final double exchangeRate = await _apiRepository.findCloudExchangeRate(
        user: user,
        exchangeRateDateInUtc: exchangeRateDateInUtc,
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
      );

      // Exchange rate not found.
      if (exchangeRate == 0.0 || exchangeRate == 0) {
        return {
          'status': ExchangeRate.exchangeRateStatusNotFoundCloud,
          'exchange_rate': null,
        };
      }

      return {
        'status': ExchangeRate.exchangeRateStatusSuccessCloud,
        'exchange_rate': exchangeRate,
      };
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> findCloudExchangeRate() --> failure: ${failure.toString()}');

      return {
        'status': ExchangeRate.exchangeRateStatusFailure,
        'exchange_rate': null,
      };
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> findCloudExchangeRate() --> exception: ${exception.toString()}');

      return {
        'status': ExchangeRate.exchangeRateStatusFailure,
        'exchange_rate': null,
      };
    }
  }

  /// This method can be used to fetch exchange rate with status code.
  /// * This method cannot be used in a nested ISAR transaction! Use outside!
  /// * Returns a `{'status': String,'exchange_rate':double?}` object.
  /// * Use the `localOnly` flag to only check for exchange rates that are locally available.
  Future<Map<String, dynamic>> getExchangeRate({required DateTime exchangeRateDateInUtc, required ExchangeRates customExchangeRates, required String fromCurrencyCode, required String toCurrencyCode, bool localOnly = false}) async {
    try {
      // Truncate exchangeRateDate precision to day.
      final DateTime truncatedDateInUtc = DateTime.utc(
        exchangeRateDateInUtc.year,
        exchangeRateDateInUtc.month,
        exchangeRateDateInUtc.day,
      );

      // Access now.
      final DateTime now = DateTime.now().toUtc();

      // Access now truncated.
      final DateTime truncatedNowInUtc = DateTime.utc(now.year, now.month, now.day);

      // Access relevant exchange rate if it exists.
      final ExchangeRate? customExchangeRate = customExchangeRates.findMatchingExchangeRate(
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
      );

      // A custom exchange rate has always priority.
      if (customExchangeRate != null) {
        return {
          'status': ExchangeRate.exchangeRateStatusCustom,
          'exchange_rate': customExchangeRate.exchangeRate,
        };
      }

      // Exchange rate is constant.
      if (fromCurrencyCode == toCurrencyCode) {
        return {
          'status': ExchangeRate.exchangeRateStatusSuccessLocal,
          'exchange_rate': 1.0,
        };
      }

      // In case supplied exchange rate is in the future, return error because exchange rates cannot be know for the future.
      // * Do this after custom and static exchange rate because this enables future values as long as a exchange rate is available.
      if (truncatedDateInUtc.isAfter(truncatedNowInUtc)) {
        return {
          'status': ExchangeRate.exchangeRateStatusInFuture,
          'exchange_rate': null,
        };
      }

      // Check if this exchange rate can be found locally.
      final Map<String, dynamic> exchangeRateLocalMap = await _findLocalExchangeRate(
        exchangeRateDateInUtc: truncatedDateInUtc,
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
      );

      // Convenience variables.
      final String localStatus = exchangeRateLocalMap['status'];
      final ExchangeRate? exchangeRateLocal = exchangeRateLocalMap['exchange_rate'] as ExchangeRate?;

      // * This means an error occurred while getting exchange rate locally.
      if (localStatus == ExchangeRate.exchangeRateStatusFailure) {
        return {
          'status': ExchangeRate.exchangeRateStatusFailure,
          'exchange_rate': null,
        };
      }

      // * This means that exchange rate was found locally!
      if (localStatus == ExchangeRate.exchangeRateStatusSuccessLocal) {
        return {
          'status': ExchangeRate.exchangeRateStatusSuccessLocal,
          'exchange_rate': exchangeRateLocal!.exchangeRate,
        };
      }

      // * This means that exchange rate was not found in cloud and that information was already saved to local storage!
      if (localStatus == ExchangeRate.exchangeRateStatusNotFoundCloud) {
        return {
          'status': ExchangeRate.exchangeRateStatusNotFoundCloud,
          'exchange_rate': null,
        };
      }

      // Do not try and get exchange rates in the cloud.
      if (localOnly) {
        return {
          'status': ExchangeRate.exchangeRateStatusNotFoundLocal,
          'exchange_rate': null,
        };
      }

      // Create an anon cloud user if it does not already exist.
      // * This is used with rethrow set to false to prevent function stop. User should still be able to create
      // * entries. Exchange rate status will be set to failure in this case.
      final bool success = await createCloudUser(shouldThrow: false);

      // Failed to create cloud user, return error.
      if (success == false) {
        return {
          'status': ExchangeRate.exchangeRateStatusFailure,
          'exchange_rate': null,
        };
      }

      // Get exchange rate from the cloud because initial or failure indicates that it does not exist locally.
      final Map<String, dynamic> exchangeRateCloudMap = await _findCloudExchangeRate(
        exchangeRateDateInUtc: truncatedDateInUtc,
        fromCurrencyCode: fromCurrencyCode,
        toCurrencyCode: toCurrencyCode,
      );

      // Convenience variables.
      final String cloudStatus = exchangeRateCloudMap['status'];
      final double? exchangeRateCloud = exchangeRateCloudMap['exchange_rate'];

      // * This means an error occurred while getting exchange rate in the cloud.
      if (cloudStatus == ExchangeRate.exchangeRateStatusFailure) {
        return {
          'status': ExchangeRate.exchangeRateStatusFailure,
          'exchange_rate': null,
        };
      }

      // * This means that exchange rate was found online!
      if (cloudStatus == ExchangeRate.exchangeRateStatusSuccessCloud) {
        // * Save exchange rate locally.
        // * This is done in a nested try catch because failure should not stop the whole function.
        // * On failure it is simply retried next time.
        try {
          // Create local ExchangeRate object.
          final ExchangeRate exchangeRateObject = ExchangeRate.initial().copyWith(
            exchangeRateDateInUtc: truncatedDateInUtc,
            fromCurrencyCode: fromCurrencyCode,
            toCurrencyCode: toCurrencyCode,
            exchangeRate: exchangeRateCloud,
          );

          // Save locally.
          await state.database!.writeTxn(() async {
            await _createExchangeRate(exchangeRate: exchangeRateObject);
          });

          // * Saveing locally succeeded.
          return {
            'status': ExchangeRate.exchangeRateStatusSuccessLocal,
            'exchange_rate': exchangeRateCloud!,
          };
        } on Failure catch (failure) {
          // Output debug message.
          debugPrint('LocalStorageCubit --> getExchangeRate() --> createExchangeRate() --> failure on saveing locally: ${failure.toString()}');

          // * Saveing locally failed but exchange rate is still available.
          return {
            'status': ExchangeRate.exchangeRateStatusSuccessCloud,
            'exchange_rate': exchangeRateCloud!,
          };
        } catch (exception) {
          // Output debug message.
          debugPrint('LocalStorageCubit --> getExchangeRate() --> createExchangeRate() --> exception on saveing locally: ${exception.toString()}');

          // * Saveing locally failed but exchange rate is still available.
          return {
            'status': ExchangeRate.exchangeRateStatusSuccessCloud,
            'exchange_rate': exchangeRateCloud!,
          };
        }
      }

      // * This means that exchange rate was NOT found online!
      // * Save exchange rate locally because the information that it cant be found online needs to be stored!
      // * This is done in a nested try catch because failure should not stop the whole function.
      // * On failure it is simply retried next time.
      if (cloudStatus == ExchangeRate.exchangeRateStatusNotFoundCloud) {
        try {
          // Create local ExchangeRate object.
          final ExchangeRate exchangeRateObject = ExchangeRate.initial().copyWith(
            exchangeRateDateInUtc: truncatedDateInUtc,
            fromCurrencyCode: fromCurrencyCode,
            toCurrencyCode: toCurrencyCode,
            exchangeRate: 0.0,
          );

          // Save locally.
          await state.database!.writeTxn(() async {
            await _createExchangeRate(exchangeRate: exchangeRateObject);
          });

          // * Saveing locally succeeded but status should still be not found cloud.
          return {
            'status': ExchangeRate.exchangeRateStatusNotFoundCloud,
            'exchange_rate': 0.0,
          };
        } on Failure catch (failure) {
          // Output debug message.
          debugPrint('LocalStorageCubit --> getExchangeRate() --> createExchangeRate() --> failure on saveing locally: ${failure.toString()}');

          // * Saveing locally failed but status should still be not found cloud.
          return {
            'status': ExchangeRate.exchangeRateStatusNotFoundCloud,
            'exchange_rate': 0.0,
          };
        } catch (exception) {
          // Output debug message.
          debugPrint('LocalStorageCubit --> getExchangeRate() --> createExchangeRate() --> exception on saveing locally: ${exception.toString()}');

          // * Saveing locally failed but status should still be not found cloud.
          return {
            'status': ExchangeRate.exchangeRateStatusNotFoundCloud,
            'exchange_rate': 0.0,
          };
        }
      }

      // Getting exchange rate failed.
      throw Failure.genericError();
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> getExchangeRate() --> failure: ${failure.toString()}');

      return {
        'status': ExchangeRate.exchangeRateStatusFailure,
        'exchange_rate': null,
      };
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> getExchangeRate() --> exception: ${exception.toString()}');

      return {
        'status': ExchangeRate.exchangeRateStatusFailure,
        'exchange_rate': null,
      };
    }
  }

  /// This method can be used to access a batch of exchange rates in api.
  /// * Returns the number of invalid exchange rates discovered.
  Future<int> getExchangeRatesBatch({required ExchangeRates batch, required Group fromGroup}) async {
    // * Perform in nested try catch to have accurate number of invalid.
    try {
      // Init helpers.
      int numberOfInvalid = 0;

      // Output debug message.
      debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> number of exchange rates in batch job: ${batch.items.length}');

      // Perform batch request.
      final List<dynamic> exchangeRates = await _apiRepository.getExchangeRatesBatch(
        user: user,
        group: fromGroup,
        batch: batch,
      );

      // Got through returned exchange rates and validate them.
      for (final Map<String, dynamic> item in exchangeRates) {
        // Convenience variables.
        final String id = item['id'];
        final String status = item['status'];
        final double? exchangeRate = item['exchange_rate'];

        // Access by id from provided batch to get date and fromCurrencyCode and toCurrencyCode.
        final ExchangeRate? exchangeRateBatchItem = batch.byId(
          id: id,
        );

        // If for some reason the id cannot be found, set to failure.
        // * This should not happen.
        if (exchangeRateBatchItem == null) {
          // Output debug message.
          debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> Error: exchangeRateBatchItem == null');

          numberOfInvalid++;
          continue;
        }

        // A failure occurred server side, retry later.
        if (status == ExchangeRate.exchangeRateStatusFailure) {
          // Output debug message.
          debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> status == ExchangeRate.exchangeRateStatusFailure');

          numberOfInvalid++;
          continue;
        }

        // Value not found in the cloud, save this information locally.
        // * Perform this in a nested try catch because failures will be tried again later.
        if (status == ExchangeRate.exchangeRateStatusNotFoundCloud) {
          try {
            // Output debug message.
            debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> status == ExchangeRate.exchangeRateStatusNotFoundCloud');

            // Create local ExchangeRate object.
            final ExchangeRate exchangeRateObject = ExchangeRate.initial().copyWith(
              exchangeRateDateInUtc: exchangeRateBatchItem.exchangeRateDateInUtc,
              fromCurrencyCode: exchangeRateBatchItem.fromCurrencyCode,
              toCurrencyCode: exchangeRateBatchItem.toCurrencyCode,
              exchangeRate: 0.0,
            );

            // Save locally.
            await state.database!.writeTxn(() async {
              await _createExchangeRate(exchangeRate: exchangeRateObject);
            });
          } on Failure catch (failure) {
            // Output debug message.
            debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> createExchangeRate() --> failure on saveing locally: ${failure.toString()}');
          } catch (exception) {
            // Output debug message.
            debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> createExchangeRate() --> exception on saveing locally: ${exception.toString()}');
          }

          // Heighten invalid counter.
          numberOfInvalid++;

          // Continue with next item.
          continue;
        }

        // Successfully accessed exchange rate.
        // Try and save locally.
        if (status == ExchangeRate.exchangeRateStatusSuccessCloud) {
          try {
            // Output debug message.
            debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> status == ExchangeRate.exchangeRateStatusSuccessCloud');

            // Create local ExchangeRate object.
            final ExchangeRate exchangeRateObject = ExchangeRate.initial().copyWith(
              exchangeRateDateInUtc: exchangeRateBatchItem.exchangeRateDateInUtc,
              fromCurrencyCode: exchangeRateBatchItem.fromCurrencyCode,
              toCurrencyCode: exchangeRateBatchItem.toCurrencyCode,
              exchangeRate: exchangeRate,
            );

            // Save locally.
            await state.database!.writeTxn(() async {
              await _createExchangeRate(exchangeRate: exchangeRateObject);
            });
          } on Failure catch (failure) {
            // Output debug message.
            debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> createExchangeRate() --> failure on saveing locally: ${failure.toString()}');
          } catch (exception) {
            // Output debug message.
            debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> createExchangeRate() --> exception on saveing locally: ${exception.toString()}');

            // Heighten invalid counter.
            numberOfInvalid++;
          }

          // Continue with next item.
          continue;
        }

        // Output debug message.
        debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> It seems like an unhandeled case was discoverd for status: $status');

        // * If for some reason for loop reaches this, heighten invalid.
        numberOfInvalid++;
      }

      // Return number of invalid.
      return numberOfInvalid;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> failure: ${failure.toString()}');

      // * All provided exchange rates failed.
      return batch.items.length;
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> getExchangeRatesBatch() --> exception: ${exception.toString()}');

      // * All provided exchange rates failed.
      return batch.items.length;
    }
  }

  /// This method can be used to try and access all required exchange rates in batches.
  /// * Should be used in a try catch block.
  /// * Returns number of invalid exchange rates.
  Future<int> accessRequiredExchangeRatesOfLocalGroup({required Group fromGroup}) async {
    // Init helpers.
    final String toCurrencyCode = fromGroup.defaultCurrencyCode;
    ExchangeRates batchJobs = ExchangeRates.initial();
    int numberOfInvalidExchangeRates = 0;

    // Init offset.
    int offset = 0;
    int limit = 100; // Do 100 because otherwise there might be to many exchange rates in batchJobs.

    // Access Secrets.
    final Secrets? secrets = fromGroup.isEncrypted ? await getSecretsFromSecureStorage() : null;

    // Create an anon cloud user if it does not already exist.
    // * If this fails the function should fail.
    await createCloudUser();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: fromGroup.groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Continue with next item if field does not require a exchange rate.
          if (field.getIsMoneyField == false && field.getIsPaymentField == false) continue;

          String fromCurrencyCode = '';
          DateTime? exchangeRateDateInUtc;
          ExchangeRates customExchangeRates = ExchangeRates.initial();

          // Set MoneyData specific data.
          if (field.moneyData != null) {
            fromCurrencyCode = field.moneyData!.currencyCode;
            exchangeRateDateInUtc = field.moneyData!.createdAtInUtc;
            customExchangeRates = field.moneyData!.customExchangeRates;
          }

          // Set PaymentData specific data.
          if (field.paymentData != null) {
            fromCurrencyCode = field.paymentData!.currencyCode;
            exchangeRateDateInUtc = field.paymentData!.paymentDateInUtc;
            customExchangeRates = field.paymentData!.customExchangeRates;
          }

          // Access exchange rates.
          if (fromCurrencyCode.isNotEmpty && exchangeRateDateInUtc != null) {
            // Perform query.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              exchangeRateDateInUtc: exchangeRateDateInUtc,
              customExchangeRates: customExchangeRates,
              fromCurrencyCode: fromCurrencyCode,
              toCurrencyCode: toCurrencyCode,
              localOnly: true, // ! Make sure that only local exchange rates are queried to perform batch cloud get later.
            );

            // Access status.
            final String status = exchangeRateMap['status'];

            // Valid exchange rate is already available.
            if (status == ExchangeRate.exchangeRateStatusCustom || status == ExchangeRate.exchangeRateStatusSuccessLocal) continue;

            // * In this case cloud query is useless.
            if (status == ExchangeRate.exchangeRateStatusNotFoundCloud || status == ExchangeRate.exchangeRateStatusInFuture) {
              // Invalid exchange rate discovered.
              numberOfInvalidExchangeRates++;
              continue;
            }

            // Truncate exchangeRateDate precision to day.
            // * This is needed because MoneyData and PaymentData might be in a smaller precicion.
            final DateTime truncatedDateInUtc = DateTime.utc(
              exchangeRateDateInUtc.year,
              exchangeRateDateInUtc.month,
              exchangeRateDateInUtc.day,
            );

            // Create batch job reference.
            final ExchangeRate exchangeRate = ExchangeRate.initial().copyWith(
              exchangeRateDateInUtc: truncatedDateInUtc,
              fromCurrencyCode: fromCurrencyCode,
              toCurrencyCode: toCurrencyCode,
            );

            // Add to queue.
            batchJobs = batchJobs.addUniqueWithReciprocalCheck(exchangeRate: exchangeRate);
          }
        }

        // Check if batch jobs need to be performed before continuing with next entry.
        if (batchJobs.items.length >= limit) {
          // Get exchange rates batch.
          final int invalid = await getExchangeRatesBatch(
            batch: batchJobs,
            fromGroup: fromGroup,
          );

          // Update number of invalid exchange rates.
          numberOfInvalidExchangeRates = numberOfInvalidExchangeRates + invalid;

          // Reset batchJobs.
          batchJobs = ExchangeRates.initial();
        }
      }
    }

    // Once the local query is finished, check if there are any batch jobs left.
    if (batchJobs.items.isNotEmpty) {
      // Get exchange rates batch.
      final int invalid = await getExchangeRatesBatch(
        batch: batchJobs,
        fromGroup: fromGroup,
      );

      // Update number of invalid exchange rates.
      numberOfInvalidExchangeRates = numberOfInvalidExchangeRates + invalid;
    }

    return numberOfInvalidExchangeRates;
  }

  /// This method can be used to access a batch of invalid local exchange rates.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getLocalInvalidExchangeRatesBatch({required Group fromGroup, required Secrets? secrets, required int offset, required int limit}) async {
    // Helper variables.
    Entries invalidEntries = Entries.initial();
    int elapsedEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: fromGroup.groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if at least 25 invalid entries have been found.
      if (invalidEntries.items.length >= 25 || entries.items.isEmpty) {
        return {
          'invalid_entries': invalidEntries,
          'elapsed_entries': elapsedEntries,
          'is_finished': entries.items.isEmpty,
        };
      }

      // Go through entries and check if they have a invalid exchange rate.
      for (final Entry entry in entries.items) {
        // Heighten elapsed entries.
        elapsedEntries++;

        for (final Field field in entry.fields.items) {
          // Continue with next item if field does not require a exchange rate.
          if (field.getIsMoneyField == false && field.getIsPaymentField == false) continue;

          String fromCurrencyCode = '';
          DateTime? exchangeRateDateInUtc;
          ExchangeRates customExchangeRates = ExchangeRates.initial();

          // Set MoneyData specific data.
          if (field.moneyData != null) {
            fromCurrencyCode = field.moneyData!.currencyCode;
            exchangeRateDateInUtc = field.moneyData!.createdAtInUtc;
            customExchangeRates = field.moneyData!.customExchangeRates;
          }

          // Set PaymentData specific data.
          if (field.paymentData != null) {
            fromCurrencyCode = field.paymentData!.currencyCode;
            exchangeRateDateInUtc = field.paymentData!.paymentDateInUtc;
            customExchangeRates = field.paymentData!.customExchangeRates;
          }

          // Access exchange rates.
          if (fromCurrencyCode.isNotEmpty && exchangeRateDateInUtc != null) {
            // Perform query.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              exchangeRateDateInUtc: exchangeRateDateInUtc,
              customExchangeRates: customExchangeRates,
              fromCurrencyCode: fromCurrencyCode,
              toCurrencyCode: fromGroup.defaultCurrencyCode,
              // ! Make sure that only local exchange rates are queried because any that previously failed should be displayed in list.
              localOnly: true,
            );

            // Access status.
            final String status = exchangeRateMap['status'];

            // A valid exchange rate is already available.
            if (status == ExchangeRate.exchangeRateStatusCustom || status == ExchangeRate.exchangeRateStatusSuccessLocal) continue;

            // Set invalid entry to helper.
            // * Use set because it might be that a entry has many fields with invalid exchange rates but list should not contain the same entry multiple times.
            invalidEntries = invalidEntries.set(entry: entry);
          }
        }
      }
    }
  }

  /// This method can be used to validate exchange rates of a entry.
  /// * Should be used in a try catch block.
  Future<void> validateExchangeRatesOfEntry({required Entry entry, required FieldIdentifications fieldIdentifications, required String defaultCurrencyCode}) async {
    // Go through fields of entry.
    for (final Field field in entry.fields.items) {
      // Access field name.
      final String fieldName = fieldIdentifications.getById(fieldId: field.fieldId)!.label;

      // * Validate MoneyField exchange rate.
      if (field.getIsMoneyField) {
        // Access exchange rate.
        final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
          customExchangeRates: field.moneyData!.customExchangeRates,
          exchangeRateDateInUtc: field.moneyData!.createdAtInUtc!,
          fromCurrencyCode: field.moneyData!.currencyCode,
          toCurrencyCode: defaultCurrencyCode,
        );

        // Convenience variables.
        final String status = exchangeRateMap['status'];

        // Failed to create exchange rate in any other way, let user try again.
        if (status == ExchangeRate.exchangeRateStatusFailure) throw Failure.failedToCreateExchangeRate();

        // Failed to create exchange rate locally, let user try again.
        if (status == ExchangeRate.exchangeRateStatusSuccessCloud) throw Failure.failedToCreateExchangeRate();

        // This should not occur but if it does it is invalid!
        if (status == ExchangeRate.exchangeRateStatusInitial) throw Failure.failedToCreateExchangeRate();

        // Exchange rate is in the future and cannot be known.
        if (status == ExchangeRate.exchangeRateStatusInFuture) throw Failure.exchangeRateInFuture(fieldName: fieldName);

        // A exchange rate was not found and therefore user has to set a custom one.
        if (status == ExchangeRate.exchangeRateStatusNotFoundCloud) {
          throw Failure.customExchangeRateRequiredForField(
            fieldName: fieldName,
            fromCurrencyCode: field.moneyData!.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );
        }
      }

      // * Validate PaymentField exchange rate.
      if (field.getIsPaymentField) {
        // Access exchange rate.
        final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
          customExchangeRates: field.paymentData!.customExchangeRates,
          exchangeRateDateInUtc: field.paymentData!.paymentDateInUtc!,
          fromCurrencyCode: field.paymentData!.currencyCode,
          toCurrencyCode: defaultCurrencyCode,
        );

        // Convenience variables.
        final String status = exchangeRateMap['status'];

        // Failed to create exchange rate locally, let user try again.
        if (status == ExchangeRate.exchangeRateStatusSuccessCloud) throw Failure.failedToCreateExchangeRate();

        // Failed to create exchange rate in any other way, let user try again.
        if (status == ExchangeRate.exchangeRateStatusFailure) throw Failure.failedToCreateExchangeRate();

        // This should not occur but if it does it is invalid!
        if (status == ExchangeRate.exchangeRateStatusInitial) throw Failure.failedToCreateExchangeRate();

        // Exchange rate is in the future and cannot be known.
        if (status == ExchangeRate.exchangeRateStatusInFuture) throw Failure.exchangeRateInFuture(fieldName: fieldName);

        // A exchange rate was not found and therefore user has to set a custom one.
        if (status == ExchangeRate.exchangeRateStatusNotFoundCloud) {
          throw Failure.customExchangeRateRequiredForField(
            fieldName: fieldName,
            fromCurrencyCode: field.paymentData!.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );
        }
      }
    }
  }

  // ######################################
  // Local Tags
  // ######################################

  /// This method can be used to create a new ```Tag```.
  /// * Should be used in a try catch block.
  Future<Tag> createLocalTag({required Tag tag}) async {
    // Encode the tag object to corresponding database schema.
    final DbTag schema = tag.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbTag.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateTag(),
    );

    return tag;
  }

  /// This method can be used to access an Tag by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```tagId``` was not found.
  Future<Tag?> getLocalTagById({required String tagId}) async {
    // Transform String id to int id.
    final int id = DbTag.fastHash(tagId);

    final DbTag? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbTag.collectionName,
    ) as DbTag?;

    if (schema == null) return null;

    final Tag tag = Tag.fromSchema(schema: schema);

    return tag;
  }

  /// This method can be used to get a local tag by its label.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```tagLabel``` was not found.
  Future<Tag?> getLocalTagByLabel({required String tagLabel}) async {
    // Build query.
    final DbTag? schema = await state.database!.dbTags
        .filter()
        .labelEqualTo(
          tagLabel,
          caseSensitive: false,
        )
        .findFirst();

    if (schema == null) return null;

    final Tag tag = Tag.fromSchema(schema: schema);

    return tag;
  }

  /// This method can be used to get tag suggestions.
  /// * Returns ```null``` on error.
  Future<Tags?> getLocalTagSuggestions({required String value}) async {
    try {
      // Build query.
      final List<DbTag> schema = await state.database!.dbTags
          .filter()
          .labelContains(
            value,
            caseSensitive: false,
          )
          .findAll();

      final Tags tags = Tags.fromSchema(schema: schema);

      return tags;
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalTagSuggestions() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalTagSuggestions() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This method can be used to load local tags into state.
  /// * Returns `null` on error.
  Future<Tags?> loadReferencedLocalTags({required TagsData tagsData, required Field field}) async {
    try {
      // If not Tags are requested, return the object.
      if (tagsData.tagReferences.isEmpty) return Tags.initial();

      // Init helper.
      Tags helper = Tags.initial();

      // * Go through references, load tags and update state.
      for (final String reference in tagsData.tagReferences) {
        // * Create helper tag.
        final Tag referencedTag = Tag.initial().copyWith(
          tagId: reference,
        );

        // * Init correct TagsData.
        if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;
        if (field.getIsMoneyField) tagsData = field.moneyData!.tagsData;
        if (field.getIsLocationField) tagsData = field.locationData!.tagsData;
        if (field.getIsTagsField) tagsData = field.tagsData!;
        if (field.getIsImagesField) tagsData = field.imageData!.tagsData;
        if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

        // * Access Tag.
        // * This is so quick that a cache is not needed.
        final Tag? tag = await getLocalTagById(
          tagId: referencedTag.tagId,
        );

        // * Tag was deleted, exclude.
        if (tag == null) {
          // Output debug messages.
          debugPrint('LocalStorageCubit --> loadReferencedLocalTags() --> tried to display deleted tag at recordKey: ${referencedTag.tagId}.');

          continue;
        }

        // Add to helper.
        helper = helper.add(tag: tag);
      }

      return helper;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedSharedTags() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedSharedTags() --> exception: ${exception.toString()}');

      return null;
    }
  }

  // ######################################
  // Shared Tags
  // ######################################

  /// This method can be used to create a new shared ```Tag```.
  /// * Should be used in a try catch block.
  Future<Tag> createSharedTag({required Tag tag}) async {
    // Create the SharedTag
    final Tag sharedTag = await _apiRepository.createSharedTag(
      user: state.user,
      tag: tag,
    );

    return sharedTag;
  }

  /// This method can be used to access a shared Tag by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```tagId``` was not found.
  Future<Tag?> getSharedTagById({required String tagId}) async {
    // Get the SharedTag
    final Tag? sharedTag = await _apiRepository.getSharedTagById(
      user: state.user,
      tagId: tagId,
    );

    return sharedTag;
  }

  /// This method can be used to get a shared tag by its label.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```tagLabel``` was not found.
  Future<Tag?> getSharedTagByLabel({required String tagLabel}) async {
    // Check if tag exists.
    final Tag? sharedTag = await _apiRepository.getSharedTagByLabel(
      user: state.user,
      tagLabel: tagLabel,
    );

    return sharedTag;
  }

  /// This method can be used to get tag suggestions.
  /// * Returns ```null``` on error.
  Future<Tags?> getSharedTagSuggestions({required String value}) async {
    try {
      // Do not perform tag search if value is to short.
      if (value.length <= 1) return Tags.initial();

      // Get Tag suggestions.
      final Tags tags = await _apiRepository.getSharedTagSuggestions(
        user: state.user,
        value: value,
      );

      return tags;
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getSharedTagSuggestions() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getSharedTagSuggestions() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This method can be used to load shared tags into state.
  /// * Returns `null` on error.
  Future<Tags?> loadReferencedSharedTags({required TagsData tagsData, required Field field}) async {
    try {
      // If not Tags are requested, return the object.
      if (tagsData.tagReferences.isEmpty) return Tags.initial();

      // Init helper.
      Tags helper = Tags.initial();

      // * Go through references, load tags and update state.
      for (final String reference in tagsData.tagReferences) {
        // * Create helper tag.
        final Tag referencedTag = Tag.initial().copyWith(
          tagId: reference,
        );

        // * Init correct TagsData.
        if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;
        if (field.getIsMoneyField) tagsData = field.moneyData!.tagsData;
        if (field.getIsLocationField) tagsData = field.locationData!.tagsData;
        if (field.getIsTagsField) tagsData = field.tagsData!;
        if (field.getIsImagesField) tagsData = field.imageData!.tagsData;
        if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

        // Check if Tag is already in state.
        final Tag? cachedTag = state.sharedTagsCache.byId(tagId: referencedTag.tagId);

        // Tag has been accessed before.
        if (cachedTag != null) {
          // Output debug messages.
          debugPrint('LocalStorageCubit --> loadReferencedSharedTags() --> Cached tag found.');

          helper = helper.add(tag: cachedTag);

          continue;
        }

        // * Access Tag.
        final Tag? tag = await getSharedTagById(
          tagId: referencedTag.tagId,
        );

        // * Tag was deleted, exclude.
        if (tag == null) {
          // Output debug messages.
          debugPrint('LocalStorageCubit --> loadReferencedSharedTags() --> tried to display deleted tag at recordKey: ${referencedTag.tagId}.');

          continue;
        }

        // Add to helper.
        helper = helper.add(tag: tag);
      }

      // Create updated cache object.
      final Tags updatedCache = state.sharedTagsCache.joinUnique(other: helper);

      // Only emit new state if cubit is still open.
      if (isClosed) return null;

      emit(state.copyWith(
        sharedTagsCache: updatedCache,
        calledFrom: 'LocalStroageCubit --> loadReferencedSharedTags()',
      ));

      return helper;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedSharedTags() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedSharedTags() --> exception: ${exception.toString()}');

      return null;
    }
  }

  // ######################################
  // Local and Shared Tags
  // ######################################

  /// This method can be used to access tag labels in a csv save format.
  /// * Should be used in a try catch block.
  /// * Returns ```""``` if ```tagsData == null``` or ```tagsData.tagReferences.isEmpty```.
  Future<String> getCsvSaveTagLabels({required TagsData? tagsData, required bool isShared}) async {
    // Check for invalid and empty.
    if (tagsData == null || tagsData.tagReferences.isEmpty) return "";

    // Init helper.
    List<String> labels = [];

    // Access labels.
    for (final String ref in tagsData.tagReferences) {
      // Access tag.
      final Tag? tag = isShared == false ? await getLocalTagById(tagId: ref) : await getSharedTagById(tagId: ref);

      // Skip unknown tags.
      if (tag == null) continue;

      // Add label.
      labels.add(tag.label);
    }

    // Convert to csv save list.
    final String listAsString = labels.join(',');

    return listAsString;
  }

  // #######################################
  // Suggestions
  // #######################################

  /// This method can be used to get email suggestions.
  /// * Returns ```const []``` on error.
  Future<List<String>> getLocalEmailSuggestions({required String value}) async {
    try {
      // Build query.
      final List<DbEntry> schema = await state.database!.dbEntrys
          .filter()
          .fields(
            (q) => q.itemsElement(
              (q) => q.emailData(
                (q) => q.valueContains(value),
              ),
            ),
          )
          .findAll();

      // Convert relevant emails.
      final Entries entries = Entries.fromSchema(schema: schema);

      // Select emails.
      final List<String> suggestions = entries.getEmailSuggestions;

      return suggestions;
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalEmailSuggestions() --> failure: ${failure.toString()}');

      return const [];
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalEmailSuggestions() --> exception: ${exception.toString()}');

      return const [];
    }
  }

  /// This method can be used to get username suggestions.
  /// * Returns ```const []``` on error.
  Future<List<String>> getLocalUsernameSuggestions({required String value}) async {
    try {
      // Build query.
      final List<DbEntry> schema = await state.database!.dbEntrys
          .filter()
          .fields(
            (q) => q.itemsElement(
              (q) => q.usernameData(
                (q) => q.valueContains(value),
              ),
            ),
          )
          .findAll();

      // Convert relevant emails.
      final Entries entries = Entries.fromSchema(schema: schema);

      // Select emails.
      final List<String> suggestions = entries.getUsernameSuggestions;

      return suggestions;
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalEmailSuggestions() --> failure: ${failure.toString()}');

      return const [];
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalEmailSuggestions() --> exception: ${exception.toString()}');

      return const [];
    }
  }

  /// This method can be used to get website suggestions.
  /// * Returns ```const []``` on error.
  Future<List<String>> getLocalWebsiteSuggestions({required String value}) async {
    try {
      // Build query.
      final List<DbEntry> schema = await state.database!.dbEntrys
          .filter()
          .fields(
            (q) => q.itemsElement(
              (q) => q.websiteData(
                (q) => q.valueContains(value),
              ),
            ),
          )
          .findAll();

      // Convert relevant emails.
      final Entries entries = Entries.fromSchema(schema: schema);

      // Select emails.
      final List<String> suggestions = entries.getWebsiteSuggestions;

      return suggestions;
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalWebsiteSuggestions() --> failure: ${failure.toString()}');

      return const [];
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalWebsiteSuggestions() --> exception: ${exception.toString()}');

      return const [];
    }
  }

  /// This method can be used to get phone suggestions.
  /// * Returns ```const []``` on error.
  Future<List<PhoneData>> getLocalPhoneSuggestions({required String value}) async {
    try {
      // Build query.
      final List<DbEntry> schema = await state.database!.dbEntrys
          .filter()
          .fields(
            (q) => q.itemsElement(
              (q) => q.phoneData(
                (q) => q.valueContains(value),
              ),
            ),
          )
          .findAll();

      // Convert relevant emails.
      final Entries entries = Entries.fromSchema(schema: schema);

      // Select emails.
      final List<PhoneData> suggestions = entries.getPhoneSuggestions;

      return suggestions;
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalPhoneSuggestions() --> failure: ${failure.toString()}');

      return const [];
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> getLocalPhoneSuggestions() --> exception: ${exception.toString()}');

      return const [];
    }
  }

  // ######################################
  // Participant to Member reference
  // ######################################

  /// This method can be used to create a new ```ParticipantToMember``` reference.
  /// * Should be used in a try catch block.
  Future<ParticipantToMember> createParticipantToMemberReference({required String participantId, required Member member, required String addedBy, required DateTime addedAtInUtc}) async {
    // Create CompoundKey.
    final CompoundKeyParticipantToMember participantToMemberId = CompoundKeyParticipantToMember(
      participantId: participantId,
      memberId: member.memberId,
    );

    // Create Participant to Member Reference.
    final ParticipantToMember participantToMember = ParticipantToMember.initial().copyWith(
      participantToMemberId: participantToMemberId,
      addedBy: addedBy,
      addedAtInUtc: addedAtInUtc,
    );

    // Encode object to corresponding database schema.
    final DbParticipantToMember schema = participantToMember.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbParticipantToMember.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToAddReference(),
    );

    return participantToMember;
  }

  /// This method can be used to delete a new ```ParticipantToMember``` reference.
  /// * Should be used in a try catch block.
  Future<void> deleteParticipantToMemberReference({required Participant participant, required Member member}) async {
    // Create CompoundKey.
    final CompoundKeyParticipantToMember participantToMemberId = CompoundKeyParticipantToMember(
      participantId: participant.participantId,
      memberId: member.memberId,
    );

    // Create Participant to Member Reference.
    final ParticipantToMember participantToMember = ParticipantToMember.initial().copyWith(
      participantToMemberId: participantToMemberId,
    );

    // Encode object to corresponding database schema.
    final DbParticipantToMember schema = participantToMember.toSchema();

    await _storageRepository.delete(
      db: state.database,
      collectionName: DbParticipantToMember.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteReference(),
    );

    return;
  }

  // ######################################
  // Group to Entry Reference
  // ######################################

  /// This method can be used to access an GroupToEntryReference by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```CompoundKeyGroupToEntry``` was not found.
  Future<GroupToEntry?> getLocalGroupToEntryReferenceById({required String groupId, required String entryId}) async {
    // Create group to entry ref.
    final CompoundKeyGroupToEntry groupToEntryId = CompoundKeyGroupToEntry(
      groupId: groupId,
      entryId: entryId,
    );

    // Transform String id to int id.
    final int id = DbGroupToEntry.fastHash(groupToEntryId.getCompoundKey);

    // Access the reference.
    final DbGroupToEntry? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbGroupToEntry.collectionName,
    ) as DbGroupToEntry?;

    if (schema == null) return null;

    final GroupToEntry ref = GroupToEntry.fromSchema(schema: schema);

    return ref;
  }

  /// This method can be used to create a new ```GroupToEntry``` reference.
  /// * Should be used in a try catch block.
  Future<void> createLocalGroupToEntryReference({required Group group, required Entry entry, required String addedBy}) async {
    // Create CompoundKey.
    final CompoundKeyGroupToEntry groupToEntryId = CompoundKeyGroupToEntry(
      groupId: group.groupId,
      entryId: entry.entryId,
    );

    // Create Group to Entry Reference.
    final GroupToEntry groupToEntry = GroupToEntry.initial().copyWith(
      groupToEntryId: groupToEntryId,
      entryCreatedAtInUtc: entry.createdAtInUtc,
      modelEntryReference: entry.modelEntryReference,
      addedBy: addedBy,
    );

    // Encode object to corresponding database schema.
    final DbGroupToEntry schema = groupToEntry.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbGroupToEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToAddReference(),
    );

    return;
  }

  /// This method can be used to edit an existing ```GroupToEntry``` object.
  /// * Should be used in a try catch block.
  Future<GroupToEntry> editLocalGroupToEntryReference({required GroupToEntry editedGroupToEntry}) async {
    // Encode the user object to corresponding database schema.
    final DbGroupToEntry schema = editedGroupToEntry.toSchema();

    await _storageRepository.update(
      db: state.database,
      collectionName: DbGroupToEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.genericError(),
    );

    return editedGroupToEntry;
  }

  /// This method can be used to update local group to entry references.
  Future<void> updateEntryCreatedAtOfLocalGroupToEntryReferences({required Entry entry}) async {
    // Init helpers.
    int offset = 0;
    const int limit = 100;

    // Go though group entries.
    while (true) {
      // Get DbReferences.
      final List<DbGroupToEntry> dbReferences = await state.database!.dbGroupToEntrys
          .where()
          .entryIdEqualTo(
            entry.entryId,
          )
          .offset(offset)
          .limit(limit)
          .findAll();

      // Stop while loop if there are no references left.
      if (dbReferences.isEmpty) break;

      // Go through references.
      for (final DbGroupToEntry element in dbReferences) {
        // Convert from schema.
        final GroupToEntry converted = GroupToEntry.fromSchema(schema: element);

        // Create updated group to entry reference.
        final GroupToEntry updatedRef = converted.copyWith(
          entryCreatedAtInUtc: entry.createdAtInUtc,
        );

        // Update the ref.
        await editLocalGroupToEntryReference(editedGroupToEntry: updatedRef);
      }

      // Increment offset to fetch the next batch.
      offset += limit;
    }
  }

  /// This method can be used to delete a new ```GroupToEntry``` reference.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalGroupToEntryReference({required Group group, required Entry entry}) async {
    // Create CompoundKey.
    final CompoundKeyGroupToEntry groupToEntryId = CompoundKeyGroupToEntry(
      groupId: group.groupId,
      entryId: entry.entryId,
    );

    // Create Group to Entry Reference.
    final GroupToEntry groupToEntry = GroupToEntry.initial().copyWith(
      groupToEntryId: groupToEntryId,
    );

    // Encode object to corresponding database schema.
    final DbGroupToEntry schema = groupToEntry.toSchema();

    await _storageRepository.delete(
      db: state.database,
      collectionName: DbGroupToEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteReference(),
    );

    return;
  }

  /// This method can be used to check if a local group is empty.
  /// * Should be used in a try catch block.
  Future<bool> getLocalGroupIsEmpty({required String groupId}) async {
    // Find the first entry of this group.
    final DbGroupToEntry? dbGroupToEntry = await state.database!.dbGroupToEntrys
        .where()
        .groupIdEqualTo(
          groupId,
        )
        .findFirst();

    // No reference found, group is empty.
    if (dbGroupToEntry == null) return true;

    // There are entries in this group.
    return false;
  }

  /// This method can be used to access entries which are not specified group.
  /// * Should be used in a try catch block.
  Future<Entries> getLocalEntriesNotInLocalGroup({required String groupId, required int offset, required int limit, required Secrets? secrets}) async {
    // Find entries not in specified group.
    final List<DbGroupToEntry> dbGroupToEntries = await state.database!.dbGroupToEntrys
        .where()
        .groupIdNotEqualTo(
          groupId,
        )
        .offset(offset)
        .limit(limit)
        .findAll();

    // Init helper.
    List<Entry> helper = [];

    // Go through list and access entries.
    for (final DbGroupToEntry element in dbGroupToEntries) {
      // Convert from schema.
      final GroupToEntry groupToEntry = GroupToEntry.fromSchema(schema: element);

      final Entry? entry = await getLocalEntryById(
        entryId: groupToEntry.groupToEntryId.entryId,
        secrets: secrets,
      );

      if (entry == null) {
        // Output debug messages.
        debugPrint('LocalStroageCubit --> getEntriesNotInGroup() --> entry == null');
        continue;
      }

      helper.add(entry);
    }

    return Entries(items: helper);
  }

  /// This method can be used to access specified number of entries of a group.
  /// * Should be used in a try catch block.
  /// * Returns most recently added entry first.
  Future<Entries> getLocalEntriesInLocalGroup({required String groupId, required int offset, required int limit, required Secrets? secrets, bool descending = true}) async {
    // Helper.
    List<Entry> entries = [];

    // Get DbReferences.
    final List<DbGroupToEntry> dbReferences = descending
        ? await state.database!.dbGroupToEntrys
            .where()
            .groupIdEqualTo(groupId)
            .sortByEntryCreatedAtInUtcDesc()
            .offset(offset)
            .limit(
              limit,
            )
            .findAll()
        : await state.database!.dbGroupToEntrys
            .where()
            .groupIdEqualTo(groupId)
            .sortByEntryCreatedAtInUtc()
            .offset(offset)
            .limit(
              limit,
            )
            .findAll();

    // Go through DbReferences and access entries.
    for (final DbGroupToEntry element in dbReferences) {
      // Transfrom to reference.
      final GroupToEntry groupToEntry = GroupToEntry.fromSchema(schema: element);

      // Fetch entry.
      final Entry? entry = await getLocalEntryById(
        entryId: groupToEntry.groupToEntryId.entryId,
        secrets: secrets,
      );

      // Entry not found.
      if (entry == null) {
        // Output debug messages.
        debugPrint('LocalStorageCubit --> getEntriesInGroup() --> referenced entry not found (entry == null)');
        continue;
      }

      entries.add(entry);
    }

    return Entries(items: entries);
  }

  /// This method can be used to access the number of entries in a group.
  /// * Should be used in a try catch block.
  Future<int> getNumberOfLocalEntriesInLocalGroup({required String groupId}) async {
    // Get number of entries in group.
    final int numberOfEntriesInGroup = await state.database!.dbGroupToEntrys
        .where()
        .groupIdEqualTo(
          groupId,
        )
        .count();

    return numberOfEntriesInGroup;
  }

  // ######################################
  // Groups
  // ######################################

  /// This method can be used to create a new group.
  /// * Should be used in a try catch block.
  Future<Group> createLocalGroup({required Group group}) async {
    // Encode the group object to corresponding database schema.
    final DbGroup schema = group.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbGroup.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateGroup(),
    );

    // Only emit new states if cubit is open.
    if (isClosed) return group;

    return group;
  }

  /// This method can be used to update a group.
  /// * Should be used in a try catch block.
  /// * Updates ```editedAt``` with ```DateTime.now()``` if ```isEdit == true```
  Future<Group> editLocalGroup({required Group editedGroup, required bool isEdit}) async {
    // Access now.
    final DateTime nowInUtc = DateTime.now().toUtc();

    // * Update editedAt/lastInteraction of group.
    final Group finalEditedGroup = editedGroup.copyWith(
      editedAtInUtc: isEdit ? nowInUtc : editedGroup.editedAtInUtc,
    );

    // Encode the group object to corresponding database schema.
    final DbGroup schema = finalEditedGroup.toSchema();

    await _storageRepository.update(
      db: state.database,
      collectionName: DbGroup.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToUpdateGroup(),
    );

    return finalEditedGroup;
  }

  /// This method can be used to delete a group.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalGroup({required Group group}) async {
    // Convert to database schema.
    final DbGroup schema = group.toSchema();

    // Delete object from store.
    await _storageRepository.delete(
      db: state.database,
      collectionName: DbGroup.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteGroup(),
    );

    // Only emit new states if cubit is open.
    if (isClosed) return;
  }

  /// This method can be used to get all local protected group ids.
  /// * Should be used in a try catch block.
  Future<List<String>> getLocalProtectedGroupIds() async {
    // Init helper.
    List<String> helper = [];

    final List<DbGroup> localSchema = await state.database!.dbGroups
        .where()
        .isProtectedEqualTo(
          true,
        )
        .findAll();

    final Groups groups = Groups.fromSchema(schema: localSchema);

    // * No protected groups found.
    if (groups.items.isEmpty) return helper;

    for (final Group group in groups.items) {
      // Update helper.
      helper.add(group.groupId);
    }

    return helper;
  }

  /// This method can be used to access a local group by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```groupId``` was not found.
  Future<Group?> getLocalGroupById({required String groupId}) async {
    // Transform String id to int id.
    final int id = DbGroup.fastHash(groupId);

    final DbGroup? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbGroup.collectionName,
    ) as DbGroup?;

    if (schema == null) return null;

    Group group = Group.fromSchema(schema: schema);

    // Access relevant Prefs.
    final GroupPrefs? groupPrefs = await getLocalGroupPrefsById(
      groupId: group.groupId,
    );

    // Set Prefs if they were found.
    if (groupPrefs != null) {
      group = group.copyWith(
        groupPrefs: groupPrefs,
      );
    }

    return group;
  }

  /// This method can be used to access a group by its name.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```groupName``` was not found.
  Future<Group?> getLocalGroupByName({required String groupName, required bool shouldAccessPrefs}) async {
    final DbGroup? schema = await state.database!.dbGroups
        .where()
        .groupNameEqualTo(
          groupName,
        )
        .findFirst();

    if (schema == null) return null;

    Group group = Group.fromSchema(schema: schema);

    // Access relevant Prefs.
    if (shouldAccessPrefs) {
      final GroupPrefs? groupPrefs = await getLocalGroupPrefsById(
        groupId: group.groupId,
      );

      // Set Prefs if they were found.
      if (groupPrefs != null) {
        group = group.copyWith(
          groupPrefs: groupPrefs,
        );
      }
    }

    return group;
  }

  /// This method can be used to access all local groups.
  /// * This returns top level groups and subgroups.
  Future<Groups> getAllLocalGroups() async {
    // Init helper.
    List<Group> helper = [];

    // Build query.
    final List<DbGroup> localSchema = await state.database!.dbGroups
        .where()
        .groupTypeEqualTo(
          Group.groupTypeLocal,
        )
        .or()
        .groupTypeEqualTo(Group.groupTypeLocalSub)
        .findAll();

    final Groups groups = Groups.fromSchema(schema: localSchema);

    for (final Group group in groups.items) {
      // Check for prefs.
      final GroupPrefs? groupPrefs = await getLocalGroupPrefsById(
        groupId: group.groupId,
      );

      // Set Prefs if they were found.
      if (groupPrefs != null) {
        // Update group with prefs.
        final Group updated = group.copyWith(
          groupPrefs: groupPrefs,
        );

        helper.add(updated);
        continue;
      }

      // Prefs not found, add group to helper.
      helper.add(group);
    }

    return Groups(items: helper);
  }

  /// This method can be used to access all local top level groups.
  /// * Should be used in a try catch block.
  Future<Groups> getAllLocalTopLevelGroups() async {
    // Init helper.
    List<Group> helper = [];

    // Build query.
    final List<DbGroup> localSchema = await state.database!.dbGroups
        .where()
        .groupTypeEqualTo(
          Group.groupTypeLocal,
        )
        .findAll();

    final Groups groups = Groups.fromSchema(schema: localSchema);

    for (final Group group in groups.items) {
      // Check for prefs.
      final GroupPrefs? groupPrefs = await getLocalGroupPrefsById(
        groupId: group.groupId,
      );

      // Set Prefs if they were found.
      if (groupPrefs != null) {
        // Update group with prefs.
        final Group updated = group.copyWith(
          groupPrefs: groupPrefs,
        );

        helper.add(updated);
        continue;
      }

      // Prefs not found, add group to helper.
      helper.add(group);
    }

    return Groups(items: helper);
  }

  /// This method can be used to access all subgroups of a specified top level group.
  /// * Should be used in a try catch block.
  Future<Groups> getAllLocalSubgroups({required String groupId}) async {
    // Init helper.
    List<Group> helper = [];

    // Build query.
    final List<DbGroup> schema = await state.database!.dbGroups
        .where()
        .parentGroupReferenceEqualTo(
          groupId,
        )
        .findAll();

    final Groups groups = Groups.fromSchema(schema: schema);

    for (final Group group in groups.items) {
      // Check for prefs.
      final GroupPrefs? groupPrefs = await getLocalGroupPrefsById(
        groupId: group.groupId,
      );

      // Set Prefs if they were found.
      if (groupPrefs != null) {
        // Update group with prefs.
        final Group updated = group.copyWith(
          groupPrefs: groupPrefs,
        );

        helper.add(updated);
        continue;
      }

      // Prefs not found, add group to helper.
      helper.add(group);
    }

    return Groups(items: helper);
  }

  /// This method can be used to access all groups a entry is in.
  /// * Should be used in a try catch block.
  Future<Groups> getLocalGroupsOfEntry({required Entry entry}) async {
    // Find entries not in specified group.
    final List<DbGroupToEntry> dbGroupToEntries = await state.database!.dbGroupToEntrys
        .where()
        .entryIdEqualTo(
          entry.entryId,
        )
        .findAll();

    // Init helper.
    List<Group> helper = [];

    // Go through list and access entries.
    for (final DbGroupToEntry element in dbGroupToEntries) {
      // Convert from schema.
      final GroupToEntry groupToEntry = GroupToEntry.fromSchema(schema: element);

      Group? group = await getLocalGroupById(
        groupId: groupToEntry.groupToEntryId.groupId,
      );

      if (group == null) {
        // Output debug messages.
        debugPrint('LocalStroageCubit --> getGroupsOfEntry() --> group == null');
        continue;
      }

      // Check for prefs.
      final GroupPrefs? groupPrefs = await getLocalGroupPrefsById(
        groupId: group.groupId,
      );

      // Set Prefs if they were found.
      if (groupPrefs != null) {
        // Update group with prefs.
        group = group.copyWith(
          groupPrefs: groupPrefs,
        );
      }

      helper.add(group);
    }

    return Groups(items: helper);
  }

  /// This method can be used to access all model entries used in this group.
  /// * Should be used in a try catch block.
  Future<ModelEntries> getUtilizedModelEntriesOfLocalGroup({required String groupId}) async {
    // Find model entries of a group.
    final List<DbGroupToEntry> dbGroupToEntries = await state.database!.dbGroupToEntrys
        .where()
        .groupIdEqualTo(
          groupId,
        )
        .distinctByModelEntryReference()
        .findAll();

    // Init helper.
    List<ModelEntry> helper = [];

    // Go through list and access model entries.
    for (final DbGroupToEntry element in dbGroupToEntries) {
      // Convert from schema.
      final GroupToEntry groupToEntry = GroupToEntry.fromSchema(schema: element);

      // Access relevant model entry.
      final ModelEntry? modelEntry = await getLocalModelEntryById(
        modelEntryId: groupToEntry.modelEntryReference,
        shouldAccessPrefs: false,
      );

      if (modelEntry == null) {
        // Output debug messages.
        debugPrint('LocalStroageCubit --> getLocalModelEntriesOfGroup() --> modelEntry == null');
        continue;
      }

      helper.add(modelEntry);
    }

    return ModelEntries(items: helper);
  }

  /// This method can be used to access several data points which are necessary for all charts.
  /// * Should be used in a try catch block.
  /// * Cycles through entries with offset and limit.
  Future<Map<String, dynamic>> getInitialChartsDataOfLocalGroup({required String groupId, required ModelEntries modelEntriesOfGroup, required Secrets? secrets}) async {
    // Access field identifications of entryModels.
    final FieldIdentifications allFieldIdentifications = await modelEntriesOfGroup.getFieldIdentifications;

    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    FieldIdentifications utilizedFieldIdentifications = FieldIdentifications.initial();
    Map<String, Measurements> utilizedMeasurements = {};
    int totalEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Heighten counter.
        totalEntries++;

        for (final Field field in entry.fields.items) {
          // Only check for fieldIdentifications if needed.
          if (allFieldIdentifications != utilizedFieldIdentifications) {
            // Access referenced FieldIdentification.
            final FieldIdentification? fieldIdentification = allFieldIdentifications.getById(
              fieldId: field.fieldId,
            );

            // If this field identification was not found, add it.
            if (fieldIdentification != null && utilizedFieldIdentifications.getById(fieldId: field.fieldId) == null) {
              utilizedFieldIdentifications = utilizedFieldIdentifications.add(fieldIdentification: fieldIdentification);
            }
          }

          // For Measurement field check data.
          if (field.fieldType == Field.fieldTypeMeasurement) {
            // Access field.
            final MeasurementData measurementData = field.measurementData!;

            // Check if this fieldId was already added to helper map.
            final Measurements? measurements = utilizedMeasurements[field.fieldId];

            // Field id was not found, initialize.
            if (measurements == null) {
              // Prepare measurement data so that it can be used in MeasurementData --> getMostUtilized.
              final MeasurementData updated = measurementData.copyWith(
                value: "1", // * In this case the value will be utilized as a counter to check how often this pair was found.
              );

              utilizedMeasurements[field.fieldId] = Measurements(
                items: [updated],
              );
            }

            // Field id was found, update.
            if (measurements != null) {
              // FieldId was found, check if category/unit pair exists.
              final MeasurementData? pair = measurements.getByCategoryAndUnit(
                category: measurementData.category,
                unit: measurementData.unit,
              );

              // Category/Unit pair already exists, update counter.
              if (pair != null) {
                // Update the counter for the existing pair.
                final MeasurementData updatedPair = pair.copyWith(
                  value: (pair.valueAsDouble + 1).toString(),
                );

                // Replace the updated pair in the list.
                utilizedMeasurements[field.fieldId] = Measurements(
                  items: measurements.items.map((item) {
                    return item == pair ? updatedPair : item;
                  }).toList(),
                );
              }

              // Category/Unit pair does not exist, init.
              if (pair == null) {
                // Add to helper.
                utilizedMeasurements[field.fieldId] = Measurements(
                  items: [
                    ...utilizedMeasurements[field.fieldId]!.items,
                    measurementData.copyWith(
                      value: "1",
                    )
                  ],
                );
              }
            }
          }
        }
      }
    }

    return {
      "utilized_field_identifications": utilizedFieldIdentifications,
      "utilized_measurements": utilizedMeasurements,
      "total_entries": totalEntries,
    };
  }

  // ######################################
  // Shared Groups
  // ######################################

  /// This method can be used to create a ```Group``` in the cloud.
  /// * Should be used in a try catch block.
  Future<String> createSharedGroup({required Group group}) async {
    // User wants to create a top level group.
    if (group.getIsSharedGroupType) {
      final String groupId = await _apiRepository.createSharedGroup(
        user: state.user,
        group: group,
      );

      return groupId;
    }

    // User wants to create a Subgroup.
    if (group.getIsSharedSubgroupType) {
      final String groupId = await _apiRepository.createSharedSubgroup(
        user: state.user,
        group: group,
      );

      return groupId;
    }

    throw Failure.failureUnknownGroupType();
  }

  /// This method can be used to edit a shared ```Group``` or ```Subgroup```.
  /// * Should be used in a try catch block.
  Future<void> editSharedGroup({required Group group}) async {
    // User wants to edit a top level group.
    if (group.getIsSharedGroupType) {
      await _apiRepository.editSharedGroup(
        user: state.user,
        group: group,
      );

      return;
    }

    // User wants to edit a Subgroup.
    if (group.getIsSharedSubgroupType) {
      await _apiRepository.editSharedSubgroup(
        user: state.user,
        group: group,
      );

      return;
    }

    throw Failure.failureUnknownGroupType();
  }

  /// This method can be used to delete a ```Group``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> deleteSharedGroup({required Group group}) async {
    await _apiRepository.deleteSharedGroup(
      user: state.user,
      group: group,
    );
  }

  /// This method can be used to delete a ```Subgroup``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> deleteSharedSubgroup({required Group group}) async {
    await _apiRepository.deleteSharedSubgroup(
      user: state.user,
      group: group,
    );
  }

  /// This method can be used to access a shared ```Group``` by its id.
  /// * Should be used in a try catch block.
  Future<Group> getSharedGroupById({required String groupId}) async {
    // Fetch Group.
    final Group fetchedGroup = await _apiRepository.getSharedGroupById(
      user: state.user,
      groupId: groupId,
    );

    return fetchedGroup;
  }

  /// This method can be used to access a shared ```Subgroup``` by its id.
  /// * Should be used in a try catch block.
  Future<Group> getSharedSubgroupById({required String rootGroupReference, required String subgroupId}) async {
    // Fetch Group.
    final Group fetchedGroup = await _apiRepository.getSharedSubgroupById(
      user: state.user,
      rootGroupReference: rootGroupReference,
      subgroupId: subgroupId,
    );

    return fetchedGroup;
  }

  /// This method can be used to access all shared top level groups of a user.
  /// * Should be used in a try catch block.
  Future<Groups> getSelfAllSharedTopLevelGroups() async {
    // Get cloud groups of user.
    final Groups groups = await _apiRepository.getSelfAllSharedTopLevelGroups(
      user: user,
    );

    return groups;
  }

  /// This method can be used to access all shared subgroups of a group.
  /// * Should be used in a try catch block.
  Future<Groups> getSharedSubgroupsOfGroup({required String rootGroupReference, required String groupId}) async {
    // Fetch Groups.
    final Groups subgroups = await _apiRepository.getSharedSubgroupsOfGroup(
      user: state.user,
      groupId: groupId,
      rootGroupReference: rootGroupReference,
    );

    return subgroups;
  }

  /// This method can be used to leave a shared group.
  /// * Should be used in a try catch block.
  Future<void> leaveSharedGroup({required Group group}) async {
    // Leave group
    await _apiRepository.leaveSharedGroup(
      user: state.user,
      group: group,
    );
  }

  /// This method can be used to get group details by its alias.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getSharedGroupByAlias({required String alias}) async {
    // Fetch details.
    final Map<String, dynamic> details = await _apiRepository.getSharedGroupByAlias(
      user: user,
      alias: alias,
    );

    return details;
  }

  /// This method can be used to validate a shared group invite.
  /// * Should be used in a try catch block.
  Future<Group> validateSharedGroupInvite({required String groupId, required String accessPin}) async {
    // Fetch group.
    final Group group = await _apiRepository.validateSharedGroupInvite(
      user: user,
      groupId: groupId,
      accessPin: accessPin,
    );

    return group;
  }

  /// This method can be used to join a shared group.
  /// * Should be used in a try catch block.
  Future<void> joinSharedGroup({required String groupId, required String accessPin}) async {
    await _apiRepository.joinSharedGroup(
      user: user,
      groupId: groupId,
      accessPin: accessPin,
    );
  }

  /// This method can be used to access several data points which are necessary for all charts.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getInitialChartsDataOfSharedGroup({required Group group}) async {
    // Fetch initial charts data.
    final Map<String, dynamic> initialChartsData = await _apiRepository.getSharedGroupGetInitialChartsData(
      user: user,
      group: group,
    );

    return initialChartsData;
  }

  /// This method can be used to query shared chart items.
  /// * Should be used in a try catch block.
  Future<dynamic> getSharedChartItems({required Group group, required Chart chart, required String? descriptiveValueInstruction, required ChartsSheetCubit? chartsSheetCubit, required ExpenseReportSheetCubit? expenseReportSheetCubit}) async {
    // Convenience variables.
    final bool isBarChart = chart.chartType == Chart.chartTypeBarChart;
    final bool isPieChart = chart.chartType == Chart.chartTypePieChart;
    final bool isLineChart = chart.chartType == Chart.chartTypeLineChart;
    final bool isDescriptiveChart = chart.chartType == Chart.chartTypeDescriptiveChart;

    // * This is used to block requests at the api level if needed.
    final String requestId = const Uuid().v4();

    int elapsed = 0;
    int total = 0;
    String lastEntryId = '';

    // Init loading message.
    final Chart resettedChart = chart.copyWith(
      loadingMessage: '',
    );

    // Perform state update if cubit is specified.
    if (chartsSheetCubit != null) chartsSheetCubit.updateCharts(chart: resettedChart);

    // Perform state update if cubit is specified.
    if (expenseReportSheetCubit != null) expenseReportSheetCubit.updateCharts(chart: resettedChart);

    while (true) {
      // Fetch chart data.
      final dynamic chartData = await _apiRepository.getSharedChartItems(
        user: user,
        group: group,
        chart: chart,
        descriptiveValueInstruction: descriptiveValueInstruction,
        requestId: requestId,
        lastEntryId: lastEntryId,
      );

      // Update helpers.
      elapsed = chartData['elapsed'];
      total = chartData['total'];
      lastEntryId = chartData['last_entry_id'];

      // * This is an extra field to avoid compare misstakes with elapsed and total.
      final bool? finished = chartData['finished'];

      // Developer forgot to include finished flag. Stop while loop.
      if (finished == null) throw Failure.genericError();

      // Convert to bar items.
      if (isBarChart && finished) {
        // Convenience variables.
        final BarItems barItems = BarItems.fromCloudObject(chartData['bar_items']);

        return barItems;
      }

      // Convert to pie items.
      if (isPieChart && finished) {
        // Convenience variables.
        final PieItems pieItems = PieItems.fromCloudObject(chartData['pie_items']);

        return pieItems;
      }

      // Convert to line items.
      if (isLineChart && finished) {
        // Convenience variables.
        final LineItems lineItems = LineItems.fromCloudObject(chartData['line_items']);

        return lineItems;
      }

      // Access descriptive value.
      if (isDescriptiveChart && finished) {
        return chartData['descriptive_value'];
      }

      // * Getting data has not finished.

      // Reset chart loading message.
      final Chart updated = chart.copyWith(
        loadingMessage: '$elapsed / $total',
      );

      // Perform state update if cubit is specified.
      if (chartsSheetCubit != null) chartsSheetCubit.updateCharts(chart: updated);

      // Perform state update if cubit is specified.
      if (expenseReportSheetCubit != null) expenseReportSheetCubit.updateCharts(chart: updated);
    }
  }

  // ######################################
  // Local Group Prefs
  // ######################################

  /// This method can be used to create a new GroupPrefs object.
  /// * Should be used in a try catch block.
  Future<GroupPrefs> createLocalGroupPrefs({required GroupPrefs groupPrefs}) async {
    // Encode object to corresponding database schema.
    final DbGroupPrefs schema = groupPrefs.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbGroupPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateGroupPrefs(),
    );

    return groupPrefs;
  }

  /// This method can be used to update an existing GroupPrefs object.
  /// * Should be used in a try catch block.
  Future<void> editLocalGroupPrefs({required GroupPrefs groupPrefs}) async {
    // Encode the object to corresponding database schema.
    final DbGroupPrefs schema = groupPrefs.toSchema();

    // Conduct database operation.
    await _storageRepository.update(
      db: state.database,
      collectionName: DbGroupPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToUpdateGroupPrefs(),
    );

    return;
  }

  /// This method can be used to delete a GroupPrefs.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalGroupPrefs({required GroupPrefs groupPrefs}) async {
    // Encode the object to corresponding database schema.
    final DbGroupPrefs schema = groupPrefs.toSchema();

    // Conduct database operation.
    await _storageRepository.delete(
      db: state.database,
      collectionName: DbGroupPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteGroupPrefs(),
    );
  }

  /// This method can be used to put GroupPrefs into storage.
  /// * Should be used in a try catch block.
  /// * This method sets ```createdAt``` and ```editedAt``` if needed.
  Future<GroupPrefs> putLocalGroupPrefs({required String groupId, required GroupPrefs groupPrefs}) async {
    // Check if this GroupPrefs already exists.
    final GroupPrefs? existing = await getLocalGroupPrefsById(
      groupId: groupId,
    );

    // * Object does not exist. Create it.
    if (existing == null) {
      // Create now.
      final DateTime nowInUtc = DateTime.now().toUtc();

      // New ModelEntryPrefs.
      final GroupPrefs newPrefs = groupPrefs.copyWith(
        groupId: groupId,
        createdAtInUtc: nowInUtc,
        editedAtInUtc: nowInUtc,
      );

      // Encode the object to corresponding database schema.
      final DbGroupPrefs schema = newPrefs.toSchema();

      await _storageRepository.create(
        db: state.database,
        collectionName: DbGroupPrefs.collectionName,
        schema: schema,
        shouldThrow: Failure.failedToPutGroupPrefs(),
      );

      return newPrefs;
    }

    // Update GroupPrefs.
    final GroupPrefs editedPrefs = groupPrefs.copyWith(
      groupId: existing.groupId,
      createdAtInUtc: existing.createdAtInUtc,
      editedAtInUtc: DateTime.now().toUtc(),
    );

    // Encode the object to corresponding database schema.
    final DbGroupPrefs schema = editedPrefs.toSchema();

    await _storageRepository.update(
      db: state.database,
      collectionName: DbGroupPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToPutGroupPrefs(),
    );

    return editedPrefs;
  }

  /// This method can be used to access a ```GroupPrefs``` by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```groupPrefsId``` was not found.
  Future<GroupPrefs?> getLocalGroupPrefsById({required String groupId}) async {
    // Transform String id to int id.
    final int id = DbGroupPrefs.fastHash(groupId);

    final DbGroupPrefs? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbGroupPrefs.collectionName,
    ) as DbGroupPrefs?;

    if (schema == null) return null;

    final GroupPrefs groupPrefs = GroupPrefs.fromSchema(schema: schema);

    return groupPrefs;
  }

  // ######################################
  // Shared Group Prefs
  // ######################################

  /// This method can be used to put GroupPrefs into the cloud.
  /// * Should be used in a try catch block.
  Future<void> putSelfSharedGroupPrefs({required String groupId, required GroupPrefs groupPrefs}) async {
    // Put the shared reference.
    await _apiRepository.putSelfSharedGroupPrefs(
      user: user,
      groupId: groupId,
      groupPrefs: groupPrefs,
    );
  }

  // ######################################
  // Local Recent Entries
  // ######################################

  /// This method can be used to access a recent entry by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```RecentEntry``` was not found.
  Future<RecentEntry?> getLocalRecentEntryById({required String entryId}) async {
    // Transform String id to int id.
    final int id = DbRecentEntry.fastHash(entryId);

    final DbRecentEntry? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbRecentEntry.collectionName,
    ) as DbRecentEntry?;

    if (schema == null) return null;

    // Transform from schema.
    final RecentEntry recentEntry = RecentEntry.fromSchema(
      schema: schema,
    );

    return recentEntry;
  }

  /// This method can be used to put a recent entry reference into storage.
  /// * Returns ```null``` on failure.
  /// * If ```groupReference.isEmpty``` , existing ```groupReference``` will be used.
  /// * If ```rootGroupReference.isEmpty``` , existing ```rootGroupReference``` will be used.
  Future<RecentEntry?> putLocalRecentEntry({required String entryId, required String rootGroupReference, required String groupReference}) async {
    try {
      // Recent entry object.
      final RecentEntry recentEntry = RecentEntry.initial().copyWith(
        entryId: entryId,
        rootGroupReference: rootGroupReference,
        groupReference: groupReference,
      );

      // Check if this recent entry already exists.
      final RecentEntry? existing = await getLocalRecentEntryById(
        entryId: recentEntry.entryId,
      );

      // * Recent entry does not exist. Create it.
      if (existing == null) {
        // Encode the object to corresponding database schema.
        final DbRecentEntry schema = recentEntry.toSchema();

        await _storageRepository.create(
          db: state.database,
          collectionName: DbRecentEntry.collectionName,
          schema: schema,
          shouldThrow: Failure.failedToPutRecentEntry(),
        );

        return recentEntry;
      }

      // * Recent entry exists. Update it.
      final RecentEntry updated = existing.copyWith(
        groupReference: recentEntry.groupReference.isEmpty ? existing.groupReference : recentEntry.groupReference,
        rootGroupReference: recentEntry.rootGroupReference.isEmpty ? existing.rootGroupReference : recentEntry.rootGroupReference,
        interactedAtInUtc: DateTime.now().toUtc(),
      );

      // Encode the object to corresponding database schema.
      final DbRecentEntry schema = updated.toSchema();

      await _storageRepository.update(
        db: state.database,
        collectionName: DbRecentEntry.collectionName,
        schema: schema,
        shouldThrow: Failure.failedToPutRecentEntry(),
      );

      return updated;
    } on Failure catch (failure) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> putLocalRecentEntry() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug messages.
      debugPrint('LocalStorageCubit --> putLocalRecentEntry() --> exception: ${exception.toString()}');

      return null;
    }
  }

  /// This method can be used to delete a recent entry reference.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalRecentEntry({required Entry entry}) async {
    // Create Recent entry.
    final RecentEntry recentEntry = RecentEntry.initial().copyWith(
      entryId: entry.entryId,
    );

    // Convert to database schema.
    final DbRecentEntry schema = recentEntry.toSchema();

    // Delete object from store.
    await _storageRepository.delete(
      db: state.database,
      collectionName: DbRecentEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteRecentEntry(),
    );
  }

  /// This method can be used to access specified number of entries recently interacted with.
  /// * Should be used in a try catch block.
  Future<Entries> getLocalRecentEntries({required int offset, required int limit, required bool showProtectedRecentEntries, required List<String> protectedGroupIds, required Secrets? secrets}) async {
    // Access now in utc.
    final DateTime nowInUtc = DateTime.now().toUtc();

    // Build query.
    final List<DbRecentEntry> dbRecentEntries = showProtectedRecentEntries == false && protectedGroupIds.isNotEmpty
        ? await state.database!.dbRecentEntrys
            .filter()
            .not()
            .anyOf(protectedGroupIds, (q, id) => q.rootGroupReferenceEqualTo(id))
            .interactedAtInUtcLessThan(nowInUtc.millisecondsSinceEpoch, include: true)
            .sortByInteractedAtInUtc()
            .offset(
              offset,
            )
            .limit(limit)
            .findAll()
        : await state.database!.dbRecentEntrys
            .where()
            .interactedAtInUtcLessThan(nowInUtc.millisecondsSinceEpoch, include: true)
            .sortByInteractedAtInUtcDesc()
            .offset(
              offset,
            )
            .limit(limit)
            .findAll();

    // Init Entries.
    List<Entry> recentEntries = [];

    // No recent entries found.
    if (dbRecentEntries.isEmpty) return Entries(items: recentEntries);

    // Go through references and collect entries.
    for (final DbRecentEntry item in dbRecentEntries) {
      // Access entry.
      final Entry? entry = await getLocalEntryById(
        entryId: item.entryId,
        secrets: secrets,
      );

      // Entry not found, continue with next one.
      if (entry == null) continue;

      recentEntries.add(entry);
    }

    return Entries(items: recentEntries);
  }

  // ######################################
  // Shared Recent Entries
  // ######################################

  /// This method can be used to access recent entries from the cloud.
  /// * Only executes if a cloud user exists.
  /// * Should be used in a try catch block.
  /// * Returns ```Entries``` and connected ```ModelEntries```.
  Future<Map<String, dynamic>> getSelfSharedRecentEntries({required int offset, required int limit}) async {
    // * Return empty objects if no cloud user exists.
    if (state.user.tokens.accessToken.isEmpty) {
      return {
        'entries': Entries.initial(),
        'model_entries': ModelEntries.initial(),
      };
    }

    // Access specified data.
    final Map<String, dynamic> entriesAndModelEntries = await _apiRepository.getSelfSharedRecentEntries(
      user: user,
      offset: offset,
      limit: limit,
    );

    return entriesAndModelEntries;
  }

  /// This method can be used to access a shared recent entry by its id.
  /// * Should be used in a try catch block.
  Future<RecentEntry> getSelfSharedRecentEntryById({required String entryId}) async {
    // Access the self recent entry.
    final RecentEntry recentEntry = await _apiRepository.getSelfSharedRecentEntryById(
      user: user,
      entryId: entryId,
    );

    return recentEntry;
  }

  /// This method can be used to put a recent entry reference into the cloud.
  /// * Do not await this function for smooth UI experience.
  Future<void> putSharedRecentEntry({required String entryId, required String groupReference}) async {
    try {
      // Put the shared reference.
      _apiRepository.putSharedRecentEntry(
        user: user,
        entryId: entryId,
        referenceType: Group.referenceTypeGroup,
        referenceId: groupReference,
      );
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> putSharedRecentEntry() --> failure: ${failure.toString()}');
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> putSharedRecentEntry() --> exception: "${exception.toString()}"');
    }
  }

  // ######################################
  // Local Entries
  // ######################################

  /// This method can be used to encrypt an entry.
  /// * Should be used in a try catch block.
  Future<Entry> _encryptLocalEntry({required Entry entry, required Secrets? secrets}) async {
    // Ensure that secrets are available.
    if (secrets == null || secrets.getSecretsAreValid == false) throw Failure.genericError();

    // Helper vars.
    List<Field> helperFields = [];

    // Go through fields and encrypt values.
    for (final Field field in entry.fields.items) {
      // * TextField.
      if (field.getIsTextField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.textData!.value,
        );

        // Create updated Data.
        final TextData updatedData = field.textData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          textData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * PasswordField.
      if (field.getIsPasswordField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.passwordData!.value,
        );

        // Create updated Data.
        final PasswordData updatedData = field.passwordData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          passwordData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * PhoneField.
      if (field.getIsPhoneField) {
        // Parallelize encryption tasks.
        final List<Uint8List> results = await Future.wait(
          [
            _encryptValueWrapper(
              secrets: secrets,
              value: field.phoneData!.value,
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.phoneData!.internationalPrefix,
            ),
          ],
        );

        // Create updated Data.
        final PhoneData updatedData = field.phoneData!.copyWith(
          encryptedValue: results.first,
          encryptedInternationalPrefix: results.last,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          phoneData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * DateField.
      if (field.getIsDateField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.dateData!.valueInUtc!.toIso8601String(),
        );

        // Create updated Data.
        final DateData updatedData = field.dateData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          dateData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * DateAndTimeField.
      if (field.getIsDateAndTimeField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.dateAndTimeData!.valueInUtc!.toIso8601String(),
        );

        // Create updated Data.
        final DateAndTimeData updatedData = field.dateAndTimeData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          dateAndTimeData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * TimeField.
      if (field.getIsTimeField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.timeData!.getFormattedTime,
        );

        // Create updated Data.
        final TimeData updatedData = field.timeData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          timeData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * NumberField.
      if (field.getIsNumberField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.numberData!.value,
        );

        // Create updated Data.
        final NumberData updatedData = field.numberData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          numberData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * EmailField.
      if (field.getIsEmailField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.emailData!.value,
        );

        // Create updated Data.
        final EmailData updatedData = field.emailData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          emailData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * WebsiteField.
      if (field.getIsWebsiteField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.websiteData!.value,
        );

        // Create updated Data.
        final WebsiteData updatedData = field.websiteData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          websiteData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * UsernameField.
      if (field.getIsUsernameField) {
        // Parallelize encryption tasks.
        final List<Uint8List> results = await Future.wait(
          [
            _encryptValueWrapper(
              secrets: secrets,
              value: field.usernameData!.value,
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.usernameData!.service,
            ),
          ],
        );

        // Create updated Data.
        final UsernameData updatedData = field.usernameData!.copyWith(
          encryptedValue: results.first,
          encryptedService: results.last,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          usernameData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * LocationField.
      if (field.getIsLocationField) {
        // Parallelize encryption tasks.
        final List<Uint8List> results = await Future.wait(
          [
            _encryptValueWrapper(
              secrets: secrets,
              value: field.locationData!.latitudeAsDouble.toString(),
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.locationData!.longitudeAsDouble.toString(),
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.locationData!.type,
            ),
          ],
        );

        // Create updated Data.
        final LocationData updatedData = field.locationData!.copyWith(
          encryptedLatitude: results[0],
          encryptedLongitude: results[1],
          encryptedType: results[2],
        );

        // Create updated field.
        final Field updated = field.copyWith(
          locationData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * MoneyField.
      if (field.getIsMoneyField) {
        // Parallelize encryption tasks.
        final List<Uint8List> results = await Future.wait(
          [
            _encryptValueWrapper(
              secrets: secrets,
              value: field.moneyData!.getFormattedNumber,
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.moneyData!.currencyCode,
            ),
          ],
        );

        // Create updated Data.
        final MoneyData updatedData = field.moneyData!.copyWith(
          encryptedValue: results.first,
          encryptedCurrency: results.last,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          moneyData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * PaymentField.
      if (field.getIsPaymentField) {
        // Parallelize encryption tasks.
        final List<Uint8List> results = await Future.wait(
          [
            _encryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.paymentDateInUtc!.toIso8601String(),
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.total,
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.currencyCode,
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.sharedReferencesToString(),
            ),
          ],
        );

        // Create updated Data.
        final PaymentData updatedData = field.paymentData!.copyWith(
          encryptedPaymentDate: results[0],
          encryptedTotal: results[1],
          encryptedCurrency: results[2],
          encryptedShareReferences: results[3],
        );

        // Create updated field.
        final Field updated = field.copyWith(
          paymentData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * DateOfBirthField.
      if (field.getIsDateOfBirthField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.dateOfBirthData!.value!.toIso8601String(),
        );

        // Create updated Data.
        final DateOfBirthData updatedData = field.dateOfBirthData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          dateOfBirthData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * MeasurementField.
      if (field.getIsMeasurementField) {
        // Parallelize encryption tasks.
        final List<Uint8List> results = await Future.wait(
          [
            _encryptValueWrapper(
              secrets: secrets,
              value: field.measurementData!.category,
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.measurementData!.unit,
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: field.measurementData!.value,
            ),
          ],
        );

        // Create updated Data.
        final MeasurementData updatedData = field.measurementData!.copyWith(
          encryptedCategory: results[0],
          encryptedUnit: results[1],
          encryptedValue: results[2],
        );

        // Create updated field.
        final Field updated = field.copyWith(
          measurementData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * BooleanField.
      if (field.getIsBooleanField) {
        // Encrypt value.
        final Uint8List encrypted = await _encryptValueWrapper(
          secrets: secrets,
          value: field.booleanData!.value.toString(),
        );

        // Create updated Data.
        final BooleanData updatedData = field.booleanData!.copyWith(
          encryptedValue: encrypted,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          booleanData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * EmotionField.
      if (field.getIsEmotionField) {
        // Parallelize encryption tasks.
        final List<Uint8List> results = await Future.wait(
          [
            _encryptValueWrapper(
              secrets: secrets,
              value: EmotionData.emotionsToString(emotionData: field.emotionData!),
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: EmotionData.intensitiesToString(emotionData: field.emotionData!),
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: EmotionData.occurrencesToString(emotionData: field.emotionData!),
            ),
            _encryptValueWrapper(
              secrets: secrets,
              value: EmotionData.timezonesToString(emotionData: field.emotionData!),
            ),
          ],
        );

        // Create updated Data.
        final EmotionData updatedData = field.emotionData!.copyWith(
          encryptedEmotions: results[0],
          encryptedIntensities: results[1],
          encryptedOccurrences: results[2],
          encryptedTimezones: results[3],
        );

        // Create updated field.
        final Field updated = field.copyWith(
          emotionData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * ImagesField.
      // ! Associated values, like title and caption, are not encrypted and the actual image encryption happens elsewhere.
      if (field.getIsImagesField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // * FileField.
      // ! Associated values, like title and caption, are not encrypted and the actual file encryption happens elsewhere.
      if (field.getIsFilesField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // * AvatarImageField.
      // ! Associated values, like title and caption, are not encrypted and the actual image encryption happens elsewhere.
      if (field.getIsAvatarImageField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // * TagsField.
      // ! Tags are not encrypted to maintain searchability.
      if (field.getIsTagsField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // If no `continue` was executed, the field type is unhandled.
      throw Failure.unknownFieldType();
    }

    // Create updated fields.
    final Fields updatedFields = entry.fields.copyWith(
      items: helperFields,
    );

    // Update entry.
    final Entry updated = entry.copyWith(
      isEncrypted: true,
      fields: updatedFields,
    );

    return updated;
  }

  /// This method can be used to decrypt an entry.
  /// * Should be used in a try catch block.
  Future<Entry> _decryptLocalEntry({required Entry entry, required Secrets? secrets}) async {
    // Ensure that secrets are available.
    if (secrets == null || secrets.getSecretsAreValid == false) throw Failure.genericError();

    // Helper vars.
    List<Field> helperFields = [];

    // Go through fields and encrypt values.
    for (final Field field in entry.fields.items) {
      // * TextField.
      if (field.getIsTextField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.textData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final TextData updatedData = field.textData!.copyWith(
          value: decrypted,
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          textData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * PasswordField.
      if (field.getIsPasswordField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.passwordData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final PasswordData updatedData = field.passwordData!.copyWith(
          value: decrypted,
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          passwordData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * PhoneField.
      if (field.getIsPhoneField) {
        // Parallelize decryption tasks.
        final List<dynamic> results = await Future.wait(
          [
            _decryptValueWrapper(
              secrets: secrets,
              value: field.phoneData!.encryptedValue!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.phoneData!.encryptedInternationalPrefix!,
              removeSalt: true,
            ),
          ],
        );

        // Create updated Data.
        final PhoneData updatedData = field.phoneData!.copyWith(
          value: results.first as String,
          internationalPrefix: results.last as String,
          encryptedValue: null,
          encryptedInternationalPrefix: null,
        );

        // Create updated field.
        final Field updated = field.copyWith(
          phoneData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * DateField.
      if (field.getIsDateField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.dateData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final DateData updatedData = field.dateData!.copyWith(
          valueInUtc: DateTime.parse(decrypted),
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          dateData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * DateAndTimeField.
      if (field.getIsDateAndTimeField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.dateAndTimeData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final DateAndTimeData updatedData = field.dateAndTimeData!.copyWith(
          valueInUtc: DateTime.parse(decrypted),
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          dateAndTimeData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * TimeField.
      if (field.getIsTimeField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.timeData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Turn String into TimeOfDay.
        final TimeOfDay timeOfDay = HelperFunctions.parseTimeOfDay(value: decrypted)!;

        // Create updated Data.
        final TimeData updatedData = field.timeData!.copyWith(
          value: timeOfDay,
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          timeData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * TimeField.
      if (field.getIsNumberField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.numberData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final NumberData updatedData = field.numberData!.copyWith(
          value: decrypted,
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          numberData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * EmailField.
      if (field.getIsEmailField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.emailData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final EmailData updatedData = field.emailData!.copyWith(
          value: decrypted,
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          emailData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * WebsiteField.
      if (field.getIsWebsiteField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.websiteData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final WebsiteData updatedData = field.websiteData!.copyWith(
          value: decrypted,
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          websiteData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * UsernameField.
      if (field.getIsUsernameField) {
        // Parallelize decryption tasks.
        final List<dynamic> results = await Future.wait(
          [
            _decryptValueWrapper(
              secrets: secrets,
              value: field.usernameData!.encryptedValue!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.usernameData!.encryptedService!,
              removeSalt: true,
            ),
          ],
        );

        // Create updated Data.
        final UsernameData updatedData = field.usernameData!.copyWith(
          value: results.first as String,
          service: results.last as String,
          encryptedValue: Uint8List(0),
          encryptedService: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          usernameData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * LocationField.
      if (field.getIsLocationField) {
        // Parallelize decryption tasks.
        final List<dynamic> results = await Future.wait(
          [
            _decryptValueWrapper(
              secrets: secrets,
              value: field.locationData!.encryptedLatitude!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.locationData!.encryptedLongitude!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.locationData!.encryptedType!,
              removeSalt: true,
            ),
          ],
        );

        // Create updated Data.
        final LocationData updatedData = field.locationData!.copyWith(
          latitude: results[0] as String,
          longitude: results[1] as String,
          type: results[2] as String,
          encryptedLatitude: Uint8List(0),
          encryptedLongitude: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          locationData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * MoneyField.
      if (field.getIsMoneyField) {
        // Parallelize decryption tasks.
        final List<dynamic> results = await Future.wait(
          [
            _decryptValueWrapper(
              secrets: secrets,
              value: field.moneyData!.encryptedValue!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.moneyData!.encryptedCurrency!,
              removeSalt: true,
            ),
          ],
        );

        // Create updated Data.
        final MoneyData updatedData = field.moneyData!.copyWith(
          value: results.first as String,
          currencyCode: results.last as String,
          encryptedValue: Uint8List(0),
          encryptedCurrency: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          moneyData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * PaymentField.
      if (field.getIsPaymentField) {
        // Parallelize decryption tasks.
        final List<dynamic> results = await Future.wait(
          [
            _decryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.encryptedPaymentDate!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.encryptedTotal!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.encryptedCurrency!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.paymentData!.encryptedShareReferences!,
              removeSalt: true,
            ),
          ],
        );

        // Create updated Data.
        final PaymentData updatedData = field.paymentData!.copyWith(
          paymentDateInUtc: DateTime.parse(results[0] as String),
          total: results[1] as String,
          currencyCode: results[2] as String,
          shareReferences: PaymentData.shareReferencesFromString(value: results[3] as String),
          encryptedPaymentDate: Uint8List(0),
          encryptedTotal: Uint8List(0),
          encryptedCurrency: Uint8List(0),
          encryptedShareReferences: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          paymentData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * DateOfBirthField.
      if (field.getIsDateOfBirthField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.dateOfBirthData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final DateOfBirthData updatedData = field.dateOfBirthData!.copyWith(
          value: DateTime.parse(decrypted),
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          dateOfBirthData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * MeasurementField.
      if (field.getIsMeasurementField) {
        // Parallelize decryption tasks.
        final List<dynamic> results = await Future.wait(
          [
            _decryptValueWrapper(
              secrets: secrets,
              value: field.measurementData!.encryptedCategory!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.measurementData!.encryptedUnit!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.measurementData!.encryptedValue!,
              removeSalt: true,
            ),
          ],
        );

        // Create updated Data.
        final MeasurementData updatedData = field.measurementData!.copyWith(
          category: results[0] as String,
          unit: results[1] as String,
          value: results[2] as String,
          encryptedCategory: Uint8List(0),
          encryptedUnit: Uint8List(0),
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          measurementData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * BooleanField.
      if (field.getIsBooleanField) {
        // Encrypt value.
        final String decrypted = await _decryptValueWrapper(
          secrets: secrets,
          value: field.booleanData!.encryptedValue!,
          removeSalt: true,
        ) as String;

        // Create updated Data.
        final BooleanData updatedData = field.booleanData!.copyWith(
          value: bool.parse(decrypted),
          encryptedValue: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          booleanData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * EmotionField.
      if (field.getIsEmotionField) {
        // Parallelize decryption tasks.
        final List<dynamic> results = await Future.wait(
          [
            _decryptValueWrapper(
              secrets: secrets,
              value: field.emotionData!.encryptedEmotions!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.emotionData!.encryptedIntensities!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.emotionData!.encryptedOccurrences!,
              removeSalt: true,
            ),
            _decryptValueWrapper(
              secrets: secrets,
              value: field.emotionData!.encryptedTimezones!,
              removeSalt: true,
            ),
          ],
        );

        // Helper vars.
        final List<String> emotions = tryParseStringList(value: results[0] as String)!;
        final List<String> intensities = tryParseStringList(value: results[1] as String)!;
        final List<String> occurrences = tryParseStringList(value: results[2] as String)!;
        final List<String> timezones = tryParseStringList(value: results[3] as String)!;

        List<EmotionItem> emotionItems = [];

        // Parse emotion items.
        for (int i = 0; i < emotions.length; i++) {
          // Access data.
          final String emotion = emotions[i];
          final int intensity = int.parse(intensities[i]);
          final String timezone = timezones[i];

          // * Does not need toUtc, because it already is in utc.
          final DateTime occurrenceInUtc = HelperFunctions.parseDate(value: occurrences[i])!;

          // Create EmotionItem.
          final EmotionItem emotionItem = EmotionItem.initial().copyWith(
            emotion: emotion,
            intensity: intensity,
            occurrenceInUtc: occurrenceInUtc,
            occurrenceTimeZone: timezone,
          );

          // Add to list.
          emotionItems.add(emotionItem);
        }

        // Create updated Data.
        final EmotionData updatedData = field.emotionData!.copyWith(
          emotions: emotionItems,
          encryptedEmotions: Uint8List(0),
          encryptedIntensities: Uint8List(0),
          encryptedOccurrences: Uint8List(0),
          encryptedTimezones: Uint8List(0),
        );

        // Create updated field.
        final Field updated = field.copyWith(
          emotionData: updatedData,
        );

        // Add to helper.
        helperFields.add(updated);

        // Continue with next field.
        continue;
      }

      // * ImagesField.
      // ! Associated values, like title and caption, are not encrypted and the actual image decryption happens elsewhere.
      if (field.getIsImagesField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // * FilesField.
      // ! Associated values, like title and caption, are not encrypted and the actual file decryption happens elsewhere.
      if (field.getIsFilesField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // * ImagesField.
      // ! Associated values, like title and caption, are not encrypted and the actual image decryption happens elsewhere.
      if (field.getIsAvatarImageField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // * TagsField.
      // ! Tags are not encrypted to maintain searchability.
      if (field.getIsTagsField) {
        // Add to helper.
        helperFields.add(field);

        // Continue with next field.
        continue;
      }

      // If no `continue` was executed, the field type is unhandled.
      throw Failure.unknownFieldType();
    }

    // Create updated fields.
    final Fields updatedFields = entry.fields.copyWith(
      items: helperFields,
    );

    // Update entry.
    // * Do not set isEncrypted to false! The variable does NOT indicate CURRENT entry encryption state.
    final Entry updated = entry.copyWith(
      fields: updatedFields,
    );

    return updated;
  }

  /// This method can be used to create a new entry.
  /// * Should be used in a try catch block.
  Future<Entry> createLocalEntry({required Entry entry, required bool encrypt, required Secrets? secrets}) async {
    // Entry should be encrypted.
    if (encrypt) entry = await _encryptLocalEntry(entry: entry, secrets: secrets);

    // Encode the entry object to corresponding database schema.
    final DbEntry schema = entry.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateEntry(),
    );

    return entry;
  }

  /// This method can be used to update an existing entry.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` on error if ```shouldRethrow == false```.
  /// * Updates ```editedAt``` with ```DateTime.now()``` if ```isEdit == true```.
  Future<Entry?> editLocalEntry({required Entry editedEntry, required bool isEdit, bool shouldRethrow = true, required Secrets? secrets}) async {
    try {
      // Access now.
      final DateTime nowInUtc = DateTime.now().toUtc();

      // * Update editedAt/lastInteraction of entry.
      Entry updatedEntry = editedEntry.copyWith(
        editedAtInUtc: isEdit ? nowInUtc : editedEntry.editedAtInUtc,
      );

      // Entry should be encrypted before save.
      if (editedEntry.isEncrypted) updatedEntry = await _encryptLocalEntry(entry: updatedEntry, secrets: secrets);

      // Encode the entry object to corresponding database schema.
      final DbEntry schema = updatedEntry.toSchema();

      // * Internally the update function checks if a id exists and if that is the case performs a put.
      await _storageRepository.update(
        db: state.database,
        collectionName: DbEntry.collectionName,
        schema: schema,
        shouldThrow: Failure.failedToUpdateEntry(),
      );

      return updatedEntry;
    } on Failure catch (failure) {
      if (shouldRethrow == false) {
        // Output debug messages.
        debugPrint('LocalStorageCubit --> updateEntry() --> failure: ${failure.toString()}');

        return null;
      }

      rethrow;
    } catch (exception) {
      if (shouldRethrow == false) {
        // Output debug messages.
        debugPrint('LocalStorageCubit --> updateEntry() --> exception: ${exception.toString()}');

        return null;
      }

      rethrow;
    }
  }

  /// This method can be used to delete an entry.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalEntry({required Entry entry}) async {
    // Convert to database schema.
    final DbEntry schema = entry.toSchema();

    // Delete object from store.
    await _storageRepository.delete(
      db: state.database,
      collectionName: DbEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteEntry(),
    );
  }

  /// This method can be used to access an entry by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if entry was not found.
  Future<Entry?> getLocalEntryById({required String entryId, required Secrets? secrets}) async {
    // Transform String id to int id.
    final int id = DbEntry.fastHash(entryId);

    final DbEntry? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbEntry.collectionName,
    ) as DbEntry?;

    if (schema == null) return null;

    // Transform from schema.
    final Entry entry = Entry.fromSchema(
      schema: schema,
    );

    // Entry needs decryption.
    if (entry.isEncrypted) return await _decryptLocalEntry(entry: entry, secrets: secrets);

    return entry;
  }

  /// This method can be used to search all ```Entries``` by their name.
  /// * Should be used in a try catch block.
  Future<Entries> searchAllLocalEntriesByName({required String searchCriteria, required Secrets secrets}) async {
    // Init helper.
    List<Entry> helper = [];

    // Conduct search.
    // * Entry name is not encrypted to maintain searchability.
    final List<DbEntry> dbEntries = await state.database!.dbEntrys
        .filter()
        .entryNameContains(
          searchCriteria, // Data is not normalized.
          caseSensitive: false,
        )
        .findAll();

    // No entries found.
    if (dbEntries.isEmpty) return Entries.initial();

    // Transfrom from schema.
    for (final DbEntry schema in dbEntries) {
      // Transform from schema.
      Entry entry = Entry.fromSchema(
        schema: schema,
      );

      // Entry needs decryption.
      if (entry.isEncrypted) entry = await _decryptLocalEntry(entry: entry, secrets: secrets);

      // Add to list.
      helper.add(entry);
    }

    return Entries(items: helper);
  }

  /// This method can be used to search ```Entries``` of group by their name.
  /// * Should be used in a try catch block.
  Future<Entries> searchLocalGroupEntriesByName({required String searchCriteria, required String groupId, required Secrets secrets}) async {
    // Init helper.
    List<Entry> helper = [];

    // Conduct search.
    // * Entry name is not encrypted to maintain searchability.
    final List<DbEntry> dbEntries = await state.database!.dbEntrys
        .filter()
        .entryNameContains(
          searchCriteria, // Data is not normalized.
          caseSensitive: false,
        )
        .findAll();

    // No entries found.
    if (dbEntries.isEmpty) return Entries.initial();

    // * Needs to be performed in a txn because of get GroupToEntry object.
    await state.database!.txn(() async {
      // Transfrom from schema.
      for (final DbEntry schema in dbEntries) {
        // Transform from schema.
        Entry entry = Entry.fromSchema(
          schema: schema,
        );

        // Make sure search is conducted in current group only.
        final GroupToEntry? groupToEntry = await getLocalGroupToEntryReferenceById(
          groupId: groupId,
          entryId: entry.entryId,
        );

        // Reference does not exist.
        if (groupToEntry == null) continue;

        // Entry needs decryption.
        if (entry.isEncrypted) entry = await _decryptLocalEntry(entry: entry, secrets: secrets);

        // Add to list.
        helper.add(entry);
      }
    });

    return Entries(items: helper);
  }

  /// This method can be used to delete ```Entries``` of a group.
  /// * Should be used in a try catch block.
  /// * This method will not delete entries which are also in another group.
  Future<void> deleteLocalEntriesOfLocalGroup({required Group group, required Function(String) onDelete}) async {
    // Init helpers.
    int offset = 0;
    const int limit = 100;

    // Helper to track how many entries were deleted in each round.
    int numberOfDeletes = 0;

    // Go though group entries.
    while (true) {
      // Get DbReferences.
      final List<DbGroupToEntry> dbReferences = await state.database!.dbGroupToEntrys
          .where()
          .groupIdEqualTo(
            group.groupId,
          )
          .offset(offset)
          .limit(limit)
          .findAll();

      // Reset helper.
      numberOfDeletes = 0;

      // Stop while loop if there are no references left.
      if (dbReferences.isEmpty) return;

      // Go through references.
      for (final DbGroupToEntry element in dbReferences) {
        // Transform to reference.
        final String entryId = GroupToEntry.fromSchema(schema: element).groupToEntryId.entryId;
        final Entry entry = Entry.initial().copyWith(entryId: entryId);

        // Check if this entry is in more then one group.
        final List<DbGroupToEntry> references = await state.database!.dbGroupToEntrys
            .where()
            .entryIdEqualTo(
              entryId,
            )
            .limit(2)
            .findAll();

        // Delete the entry if it is only in one group.
        if (references.length == 1) {
          // Perform entry delete.
          await deleteLocalEntry(entry: entry);

          // Heighten helper.
          numberOfDeletes++;
        }

        // Perform recent entry delete.
        // * Always do this because even if the entry exists in a different group, it could be that the recent entry is intialized with the
        // * about to be deleted group.
        await deleteLocalRecentEntry(
          entry: entry,
        );

        // Delete reference.
        await deleteLocalGroupToEntryReference(
          group: group,
          entry: entry,
        );

        // Trigger the on delete function to display delete progress.
        await onDelete(entryId);
      }

      // Increment offset to fetch the next batch.
      offset += limit;

      // * This is needed because a delete shifts the entry collection up and get batch is performed unordered.
      // Prevent negative offset.
      offset = (offset - numberOfDeletes) < 0 ? 0 : offset - numberOfDeletes;
    }
  }

  /// This method can be used to find entries by tags.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getLocalEntriesByTags({required Group group, required String tagId, required Secrets? secrets, required int limit, required int offset, required String filter}) async {
    // Helper variables.
    Entries entriesWithTags = Entries.initial();
    int elapsedEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: group.groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if at least 50 entries have been found.
      if (entriesWithTags.items.length >= 50 || entries.items.isEmpty) {
        return {
          'entries': entriesWithTags,
          'elapsed_entries': elapsedEntries,
          'is_finished': entries.items.isEmpty,
        };
      }

      // Go through entries and check if they have a invalid exchange rate.
      outerloop:
      for (final Entry entry in entries.items) {
        // Heighten elapsed entries.
        elapsedEntries++;

        for (final Field field in entry.fields.items) {
          // Continue with next item if field does not require a exchange rate.
          if (field.getIsPaymentField == false && field.getIsFilesField == false && field.getIsTagsField == false && field.getIsLocationField == false && field.getIsImagesField == false && field.getIsMoneyField == false) continue;

          // Access TagData.
          TagsData? tagsData;

          // Payment field.
          if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;

          // Money field.
          if (field.getIsMoneyField) {
            // Access money data.
            final MoneyData moneyData = field.moneyData!;

            // * Income is requested, exclude entries with negative values.
            if (filter == 'income' && moneyData.valueAsDouble <= 0) continue outerloop;

            // * Expenses are requested, exclude entries with positive values.
            if (filter == 'expenses' && moneyData.valueAsDouble >= 0) continue outerloop;

            tagsData = field.moneyData!.tagsData;
          }

          // Location field.
          if (field.getIsLocationField) tagsData = field.locationData!.tagsData;

          // Tags field.
          if (field.getIsTagsField) tagsData = field.tagsData!;

          // Images field.
          if (field.getIsImagesField) tagsData = field.imageData!.tagsData;

          // Images field.
          if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

          // Tags not applied.
          if (tagsData == null) continue;

          // Check if tag is present.
          final bool containsTag = tagsData.tagReferences.contains(tagId);

          // Tag not present.
          if (containsTag == false) continue;

          // Check if entry is already in list.
          final bool isDuplicate = await entriesWithTags.getEntryById(entryId: entry.entryId) != null;

          // Go to next entry.
          if (isDuplicate) continue outerloop;

          // Entry is not yet in helper list it.
          entriesWithTags = entriesWithTags.add(entry: entry);
        }
      }
    }
  }

  /// This method can be used to find all untagged entries.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getLocalEntriesUntaggedByFieldType({required Group group, required String fieldType, required Secrets? secrets, required int limit, required int offset, required String filter}) async {
    // Helper variables.
    Entries entriesWithoutTags = Entries.initial();
    int elapsedEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: group.groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if at least 50 entries have been found.
      if (entriesWithoutTags.items.length >= 50 || entries.items.isEmpty) {
        return {
          'entries': entriesWithoutTags,
          'elapsed_entries': elapsedEntries,
          'is_finished': entries.items.isEmpty,
        };
      }

      // Go through entries and check if they have a invalid exchange rate.
      outerloop:
      for (final Entry entry in entries.items) {
        // Heighten elapsed entries.
        elapsedEntries++;

        for (final Field field in entry.fields.items) {
          // Continue with next item if field type does not match.
          if (field.fieldType != fieldType) continue;

          // Init TagData.
          TagsData? tagsData;

          // Payment field.
          if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;

          // Money field.
          if (field.getIsMoneyField) {
            // Access money data.
            final MoneyData moneyData = field.moneyData!;

            // * Income is requested, exclude entries with negative values.
            if (filter == 'income' && moneyData.valueAsDouble <= 0) continue outerloop;

            // * Expenses are requested, exclude entries with positive values.
            if (filter == 'expenses' && moneyData.valueAsDouble >= 0) continue outerloop;

            tagsData = field.moneyData!.tagsData;
          }

          // Location field.
          if (field.getIsLocationField) tagsData = field.locationData!.tagsData;

          // Tags field.
          if (field.getIsTagsField) tagsData = field.tagsData!;

          // Images field.
          if (field.getIsImagesField) tagsData = field.imageData!.tagsData;

          // Images field.
          if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

          // If any field contains tags, skip this entry.
          if (tagsData != null && tagsData.tagReferences.isNotEmpty) {
            continue outerloop; // Skip to the next entry in the outer loop.
          }
        }

        // Add the untagged entry to the list.
        entriesWithoutTags = entriesWithoutTags.add(entry: entry);
      }
    }
  }

  /// This method can be used to find all entries which do not have tags in this specific field.
  /// * Should be used in a try catch block.
  Future<Map<String, dynamic>> getLocalEntriesUntaggedByFieldId({required Group group, required String fieldId, required Secrets? secrets, required int limit, required int offset, required String filter}) async {
    // Helper variables.
    Entries entriesWithoutTags = Entries.initial();
    int elapsedEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: group.groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if at least 50 entries have been found.
      if (entriesWithoutTags.items.length >= 50 || entries.items.isEmpty) {
        return {
          'entries': entriesWithoutTags,
          'elapsed_entries': elapsedEntries,
          'is_finished': entries.items.isEmpty,
        };
      }

      // Go through entries and check if they have a invalid exchange rate.
      outerloop:
      for (final Entry entry in entries.items) {
        // Heighten elapsed entries.
        elapsedEntries++;

        for (final Field field in entry.fields.items) {
          // Ignore entries which do not have this field set.
          if (field.fieldId != fieldId) continue;

          // Init TagData.
          TagsData? tagsData;

          // Payment field.
          if (field.getIsPaymentField) tagsData = field.paymentData!.tagsData;

          // Money field.
          if (field.getIsMoneyField) {
            // Access money data.
            final MoneyData moneyData = field.moneyData!;

            // * Income is requested, exclude entries with negative values.
            if (filter == 'income' && moneyData.valueAsDouble <= 0) continue outerloop;

            // * Expenses are requested, exclude entries with positive values.
            if (filter == 'expenses' && moneyData.valueAsDouble >= 0) continue outerloop;

            tagsData = field.moneyData!.tagsData;
          }

          // Location field.
          if (field.getIsLocationField) tagsData = field.locationData!.tagsData;

          // Tags field.
          if (field.getIsTagsField) tagsData = field.tagsData!;

          // Images field.
          if (field.getIsImagesField) tagsData = field.imageData!.tagsData;

          // Images field.
          if (field.getIsFilesField) tagsData = field.fileData!.tagsData;

          // If any field contains tags, skip this entry.
          if (tagsData != null && tagsData.tagReferences.isNotEmpty) {
            continue outerloop; // Skip to the next entry in the outer loop.
          }
        }

        // Add the untagged entry to the list.
        entriesWithoutTags = entriesWithoutTags.add(entry: entry);
      }
    }
  }

  // ######################################
  // Shared Entries
  // ######################################

  /// This method can be used to create a shared ```Entry```.
  /// * Should be used in a try catch block.
  Future<Entry> createSharedEntry({required Entry entry, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // * Create Entry.
    final Entry insertedEntry = await _apiRepository.createSharedEntry(
      user: state.user,
      entry: entry,
      rootGroupReference: rootGroupReference,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return insertedEntry;
  }

  /// This method can be used to edit a shared ```Entry```.
  /// * Should be used in a try catch block.
  Future<Entry> editSharedEntry({required Entry entry, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // * Edit Entry.
    final Entry editedEntry = await _apiRepository.editSharedEntry(
      user: state.user,
      entry: entry,
      rootGroupReference: rootGroupReference,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return editedEntry;
  }

  /// This method can be used to delete a shared ```Entry```.
  /// * Should be used in a try catch block.
  Future<void> deleteSharedEntry({required Entry entry, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // * Delete Entry.
    await _apiRepository.deleteSharedEntry(
      user: state.user,
      entry: entry,
      rootGroupReference: rootGroupReference,
      referenceType: referenceType,
      referenceId: referenceId,
    );
  }

  /// This method can be used to access a shared ```Entry``` by its id.
  /// * Should be used in a try catch block.
  Future<Entry> getSharedEntryById({required String rootGroupReference, required String entryId, required String referenceType, required String referenceId}) async {
    // Fetch Group.
    final Entry fetchedEntry = await _apiRepository.getSharedEntryById(
      user: state.user,
      rootGroupReference: rootGroupReference,
      entryId: entryId,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return fetchedEntry;
  }

  /// This method can be used to access entries stored in the cloud.
  /// * Should be used in a try catch block.
  Future<Entries> getSharedEntriesOfSharedGroup({required String rootGroupReference, required String referenceType, required String referenceId, required int offset, required int limit}) async {
    // * Access Entries.
    final Entries entries = await _apiRepository.getEntriesOfSharedGroup(
      user: state.user,
      rootGroupReference: rootGroupReference,
      referenceType: referenceType,
      referenceId: referenceId,
      offset: offset,
      limit: limit,
    );

    return entries;
  }

  /// This method can be used to search a shared ```Entry``` in a ```Group``` by its name.
  /// * Should be used in a try catch block.
  Future<Entries> searchSharedEntriesOfSharedGroupByName({required String searchCriteria, required String rootGroupReference, required String groupId}) async {
    // Search for Entries.
    final Entries entries = await _apiRepository.searchEntriesOfGroupByName(
      user: user,
      searchCriteria: searchCriteria,
      rootGroupReference: rootGroupReference,
      groupId: groupId,
    );

    return entries;
  }

  // ######################################
  // Local Model Entries
  // ######################################

  /// This method can be used to create a new ModelEntry.
  /// * Should be used in a try catch block.
  Future<ModelEntry> createLocalModelEntry({required ModelEntry modelEntry}) async {
    // Encode the modelEntry object to corresponding database schema.
    final DbModelEntry schema = modelEntry.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbModelEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateModelEntry(),
    );

    return modelEntry;
  }

  /// This method can be used to update an existing ModelEntry.
  /// * Should be used in a try catch block.
  Future<void> editLocalModelEntry({required ModelEntry updatedModelEntry}) async {
    // Encode the modelEntry object to corresponding database schema.
    final DbModelEntry schema = updatedModelEntry.toSchema();

    // Conduct database operation.
    await _storageRepository.update(
      db: state.database,
      collectionName: DbModelEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToUpdateModelEntry(),
    );

    return;
  }

  /// This method can be used to delete a ModelEntry.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalModelEntry({required ModelEntry modelEntry}) async {
    // Encode the modelEntry object to corresponding database schema.
    final DbModelEntry schema = modelEntry.toSchema();

    // Conduct database operation.
    await _storageRepository.delete(
      db: state.database,
      collectionName: DbModelEntry.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteEntryModel(),
    );
  }

  /// This method can be used to access a local ```ModelEntry``` by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```modelEntryId``` was not found.
  Future<ModelEntry?> getLocalModelEntryById({required String modelEntryId, required bool shouldAccessPrefs}) async {
    // Transform String id to int id.
    final int id = DbModelEntry.fastHash(modelEntryId);

    final DbModelEntry? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbModelEntry.collectionName,
    ) as DbModelEntry?;

    if (schema == null) return null;

    ModelEntry modelEntry = ModelEntry.fromSchema(schema: schema);

    // If this flag was set, access model entry prefs.
    if (shouldAccessPrefs) {
      // Access relevant ModelEntryPrefs.
      final ModelEntryPrefs? modelEntryPrefs = await getLocalModelEntryPrefsById(
        modelEntryId: modelEntry.modelEntryId,
      );

      // Set ModelEntryPrefs if they were found.
      if (modelEntryPrefs != null) {
        modelEntry = modelEntry.copyWith(
          modelEntryPrefs: modelEntryPrefs,
        );
      }
    }

    return modelEntry;
  }

  /// This method can be used to access all ```ModelEntries```.
  /// * Should be used in a try catch block.
  Future<ModelEntries> getAllLocalModelEntries({required bool shouldAccessPrefs}) async {
    // Init helper.
    List<ModelEntry> helper = [];

    // Find entries not in specified group.
    final List<DbModelEntry> dbModelEntries = await state.database!.dbModelEntrys.where().findAll();

    for (final DbModelEntry schema in dbModelEntries) {
      // Convert from schema.
      ModelEntry modelEntry = ModelEntry.fromSchema(schema: schema);

      if (shouldAccessPrefs) {
        // Access relevant ModelEntryPrefs.
        final ModelEntryPrefs? modelEntryPrefs = await getLocalModelEntryPrefsById(
          modelEntryId: modelEntry.modelEntryId,
        );

        // Set ModelEntryPrefs if they were found.
        if (modelEntryPrefs != null) {
          modelEntry = modelEntry.copyWith(
            modelEntryPrefs: modelEntryPrefs,
          );
        }
      }

      helper.add(modelEntry);
    }

    return ModelEntries(items: helper);
  }

  /// This method can be used to access all ```ModelEntries``` related to specified entries.
  /// * Should be used in a try catch block.
  /// * Fails if a ModelEntry is not found.
  Future<ModelEntries> getLocalModelEntriesOfLocalEntries({required Entries entries}) async {
    // Init helper.
    List<ModelEntry> helper = [];

    for (final Entry item in entries.items) {
      // Access related ModelEntry.
      final ModelEntry? modelEntry = await getLocalModelEntryById(
        modelEntryId: item.modelEntryReference,
        shouldAccessPrefs: false,
      );

      if (modelEntry == null) throw Failure.entryModelNotFound();

      helper.add(modelEntry);
    }

    return ModelEntries(items: helper);
  }

  /// This method can be used to check if a ```ModelEntry``` is referenced.
  /// * Should be used in a try catch block.
  Future<bool> localModelEntryIsReferenced({required ModelEntry modelEntry}) async {
    // Access ref.
    final DbEntry? dbEntry = await state.database!.dbEntrys
        .where()
        .modelEntryReferenceEqualTo(
          modelEntry.modelEntryId,
        )
        .findFirst();

    if (dbEntry == null) return false;

    return true;
  }

  // ######################################
  // Shared Model Entries
  // ######################################

  /// This method can be used to create a new shared ```ModelEntry```.
  /// * Should be used in a try catch block.
  Future<ModelEntry> createSharedModelEntry({required ModelEntry modelEntry}) async {
    // * Create ModelEntry.
    final ModelEntry insertedEntryModel = await _apiRepository.createSharedModelEntry(
      user: state.user,
      modelEntry: modelEntry,
    );

    return insertedEntryModel;
  }

  /// This method can be used to edit a ```ModelEntry``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> editSharedModelEntry({required ModelEntry modelEntry}) async {
    await _apiRepository.editSharedModelEntry(
      user: state.user,
      modelEntry: modelEntry,
    );
  }

  /// This method can be used to delete a ```ModelEntry``` in the cloud.
  /// * Should be used in a try catch block.
  /// * This method will only perform delete if ```ModelEntry``` is NOT referenced.
  Future<void> deleteSharedModelEntry({required ModelEntry modelEntry}) async {
    await _apiRepository.deleteSharedModelEntry(
      user: state.user,
      modelEntry: modelEntry,
    );
  }

  /// This method can be used to access a shared ```ModelEntry``` by its id.
  /// * Should be used in a try catch block.
  /// * returns ```null``` if ```modelEntryId``` was not found.
  Future<ModelEntry?> getSharedModelEntryById({required String modelEntryId, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // No modelEntryId present.
    if (modelEntryId.isEmpty) return null;

    // Fetch EntryModel.
    final ModelEntry? fetchedEntryModel = await _apiRepository.getSharedModelEntryById(
      user: state.user,
      rootGroupReference: rootGroupReference,
      modelEntryId: modelEntryId,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return fetchedEntryModel;
  }

  /// This method can be used to access all ```ModelEntries``` of specified entries.
  /// * Should be used in a try catch block.
  /// * Returns ```ModelEntries.initial()``` if ```entries.items.isEmpty```.
  Future<ModelEntries> getSharedModelEntriesOfSharedEntries({required String rootGroupReference, required String referenceId, required String referenceType, required Entries entries}) async {
    // Do not conduct this query if no entries are present.
    if (entries.items.isEmpty) return ModelEntries.initial();

    // Access references.
    final List<String> references = entries.getModelEntriesIds;

    // Access ModelEntries of Entries.
    final ModelEntries modelEntries = await _apiRepository.getSharedModelEntriesBatch(
      user: user,
      rootGroupReference: rootGroupReference,
      referenceId: referenceId,
      references: references,
    );

    return modelEntries;
  }

  /// This method can be used to access all shared ```ModelEntries``` of a user.
  /// * Should be used in a try catch block.
  Future<ModelEntries> selfGetAllSharedModelEntries() async {
    // Fetch ModelEntries.
    final ModelEntries fetchedModelEntries = await _apiRepository.selfGetAllModelEntries(
      user: user,
    );

    return fetchedModelEntries;
  }

  /// This method can be used to access common model entries.
  /// * Should be used in a try catch block.
  Future<ModelEntries> getSharedCommonModelEntries({required String rootGroupReference, required List<String> references, required String referenceId}) async {
    // Do not conduct this query if no references are present.
    if (references.isEmpty) return ModelEntries.initial();

    // Fetch ModelEntries.
    final ModelEntries fetchedModelEntries = await _apiRepository.getSharedModelEntriesBatch(
      user: user,
      rootGroupReference: rootGroupReference,
      references: references,
      referenceId: referenceId,
    );

    return fetchedModelEntries;
  }

  // ######################################
  // Local ModelEntryPrefs
  // ######################################

  /// This method can be used to create a ```ModelEntryPrefs``` object.
  /// * Should be used in a try catch block.
  Future<ModelEntryPrefs> createLocalModelEntryPrefs({required ModelEntryPrefs modelEntryPrefs}) async {
    // Encode the modelEntryPrefs object to corresponding database schema.
    final DbModelEntryPrefs schema = modelEntryPrefs.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbModelEntryPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateModelEntryPrefs(),
    );

    return modelEntryPrefs;
  }

  /// This method can be used to update an existing ```ModelEntryPrefs``` object.
  /// * Should be used in a try catch block.
  Future<void> editLocalModelEntryPrefs({required ModelEntryPrefs modelEntryPrefs}) async {
    // Encode the object to corresponding database schema.
    final DbModelEntryPrefs schema = modelEntryPrefs.toSchema();

    // Conduct database operation.
    await _storageRepository.update(
      db: state.database,
      collectionName: DbModelEntryPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToUpdateModelEntryPrefs(),
    );

    return;
  }

  /// This method can be used to delete a ```ModelEntryPrefs```.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalModelEntryPrefs({required ModelEntryPrefs modelEntryPrefs}) async {
    // Encode the object to corresponding database schema.
    final DbModelEntryPrefs schema = modelEntryPrefs.toSchema();

    // Conduct database operation.
    await _storageRepository.delete(
      db: state.database,
      collectionName: DbModelEntryPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteModelEntryPrefs(),
    );
  }

  /// This method can be used to put ```ModelEntryPrefs``` into storage.
  /// * Should be used in a try catch block.
  Future<ModelEntryPrefs> putLocalModelEntryPrefs({required String modelEntryId, required ModelEntryPrefs modelEntryPrefs}) async {
    // Check if this ModelEntryPrefs already exists.
    final ModelEntryPrefs? existing = await getLocalModelEntryPrefsById(
      modelEntryId: modelEntryId,
    );

    // * Object does not exist. Create it.
    if (existing == null) {
      // Create now.
      final DateTime nowInUtc = DateTime.now().toUtc();

      // New ModelEntryPrefs.
      final ModelEntryPrefs newPrefs = modelEntryPrefs.copyWith(
        modelEntryId: modelEntryId,
        createdAtInUtc: nowInUtc,
        editedAtInUtc: nowInUtc,
      );

      // Encode the object to corresponding database schema.
      final DbModelEntryPrefs schema = newPrefs.toSchema();

      await _storageRepository.create(
        db: state.database,
        collectionName: DbModelEntryPrefs.collectionName,
        schema: schema,
        shouldThrow: Failure.failedToPutModelEntryPrefs(),
      );

      return newPrefs;
    }

    // Update ModelEntryPrefs.
    final ModelEntryPrefs editedPrefs = modelEntryPrefs.copyWith(
      modelEntryId: existing.modelEntryId,
      createdAtInUtc: existing.createdAtInUtc,
      editedAtInUtc: DateTime.now().toUtc(),
    );

    // Encode the object to corresponding database schema.
    final DbModelEntryPrefs schema = editedPrefs.toSchema();

    await _storageRepository.update(
      db: state.database,
      collectionName: DbModelEntryPrefs.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToPutModelEntryPrefs(),
    );

    return editedPrefs;
  }

  /// This method can be used to access a ```ModelEntryPrefs``` by its id.
  /// * Should be used in a try catch block.
  Future<ModelEntryPrefs?> getLocalModelEntryPrefsById({required String modelEntryId}) async {
    // Transform String id to int id.
    final int id = DbModelEntryPrefs.fastHash(modelEntryId);

    final DbModelEntryPrefs? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbModelEntryPrefs.collectionName,
    ) as DbModelEntryPrefs?;

    if (schema == null) return null;

    final ModelEntryPrefs modelEntryPrefs = ModelEntryPrefs.fromSchema(schema: schema);

    return modelEntryPrefs;
  }

  /// This method can be used to access all local ```ModelEntryPrefs``` objects.
  /// * Should be used in a try catch block.
  Future<List<ModelEntryPrefs>> getAllLocalModelEntryPrefs() async {
    // Init helper.
    List<ModelEntryPrefs> helper = [];

    // Find entries not in specified group.
    final List<DbModelEntryPrefs> dbModelEntryPrefs = await state.database!.dbModelEntryPrefs.where().findAll();

    for (final DbModelEntryPrefs schema in dbModelEntryPrefs) {
      // Convert from schema.
      ModelEntryPrefs modelEntryPrefs = ModelEntryPrefs.fromSchema(schema: schema);

      helper.add(modelEntryPrefs);
    }

    return helper;
  }

  // ######################################
  // Shared ModelEntryPrefs
  // ######################################

  /// This method can be used to put ```ModelEntryPrefs``` into the cloud.
  /// * Should be used in a try catch block.
  Future<void> putSelfSharedModelEntryPrefs({required String modelEntryId, required ModelEntryPrefs modelEntryPrefs, required bool? isSelfDefault}) async {
    // Put the shared reference.
    await _apiRepository.putSelfSharedModelEntryPrefs(
      user: user,
      modelEntryId: modelEntryId,
      modelEntryPrefs: modelEntryPrefs,
      isSelfDefault: isSelfDefault,
    );
  }

  // ######################################
  // Local Members
  // ######################################

  /// This method can be used to create a new member object.
  /// * Should be used in a try catch block.
  Future<Member> createLocalMember({required Member member}) async {
    // Encode the object to corresponding database schema.
    final DbMember schema = member.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbMember.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateMember(),
    );

    return member;
  }

  /// This method can be used to update an existing Member.
  /// * Should be used in a try catch block.
  Future<Member> editLocalMember({required Member updatedMember}) async {
    // Encode object to corresponding database schema.
    final DbMember schema = updatedMember.toSchema();

    // Conduct database operation.
    await _storageRepository.update(
      db: state.database,
      collectionName: DbMember.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToUpdateMember(),
    );

    return updatedMember;
  }

  /// This method can be used to access a local ```Member``` by its id.
  /// * Should be used in a try catch block.
  /// * Returned ```Member``` is NOT initialized yet.
  /// * Returns ```null``` if ```memberId``` was not found.
  Future<Member?> getLocalMemberById({required String memberId}) async {
    // Transform String id to int id.
    final int id = DbMember.fastHash(memberId);

    final DbMember? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbMember.collectionName,
    ) as DbMember?;

    if (schema == null) return null;

    final Member member = Member.fromSchema(schema: schema);

    return member;
  }

  /// This method can be used to access and initialize all members.
  /// * Should be used in a try catch block.
  Future<Members> getAllLocalMembers() async {
    // Init helper.
    List<Member> helper = [];

    // Find all members.
    final List<DbMember> dbMembers = await state.database!.dbMembers.where().findAll();

    for (final DbMember schema in dbMembers) {
      // Convert from schema.
      Member member = Member.fromSchema(schema: schema);

      helper.add(member);
    }

    return Members(items: helper);
  }

  /// This method can be used to access and initialize a ```Member```.
  /// * Should be used in a try catch block.
  /// * Initializes ```Member.unknownMember()``` if ```member == null```.
  Future<Member> initializeLocalMember({required String memberId}) async {
    // Access member.
    Member? member = await getLocalMemberById(
      memberId: memberId,
    );

    // Member was not found.
    if (member == null) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> initializeMember() --> unknown member.');

      // Init unknown member.
      final Member unknownMember = Member.unknownMember(
        memberId: memberId,
      );

      return unknownMember;
    }

    return member;
  }

  /// This method can be used to access and initialize all ```Members``` of a specified ```Participant```.
  /// * Should be used in a try catch block.
  /// * Returns ```Members.initial()``` if ```participantId.isEmpty```.
  Future<Members> getLocalMembersOfParticipant({required String participantId}) async {
    // If participantId is empty return Members.initial().
    if (participantId.isEmpty) return Members.initial();

    // Access member refs.
    final List<DbParticipantToMember> memberRefs = await state.database!.dbParticipantToMembers
        .where()
        .participantIdEqualTo(
          participantId,
        )
        .findAll();

    // Init helper.
    List<Member> members = [];

    // Go through refs and get members.
    for (final DbParticipantToMember schema in memberRefs) {
      // Convert from schema.
      final ParticipantToMember ref = ParticipantToMember.fromSchema(schema: schema);

      // * Do not initialize empty ids. This causes a bug where a unknown member is initialized because
      // * an empty id is searched and obviously not found.
      if (ref.participantToMemberId.memberId.isEmpty) continue;

      // Init member.
      final Member member = await initializeLocalMember(
        memberId: ref.participantToMemberId.memberId,
      );

      members.add(member);
    }

    return Members(
      items: members,
    );
  }

  /// This method can be used to access and initialize all ```Members``` specified in ```references```.
  /// * Should be used in a try catch block.
  /// * Returns ```Members.initial()``` if ```references.isEmpty```.
  Future<Members> getReferencedLocalMembers({required List<String> references}) async {
    // return initial if empty.
    if (references.isEmpty) return Members.initial();

    // Init helper.
    List<Member> members = [];

    // Go through refs and get members.
    for (final String memberId in references) {
      // * Do not initialize empty ids. This causes a bug where a unknown member is initialized because
      // * an empty id is searched and obviously not found.
      if (memberId.isEmpty) continue;

      // Init member.
      final Member member = await initializeLocalMember(
        memberId: memberId,
      );

      members.add(member);
    }

    return Members(
      items: members,
    );
  }

  /// This method can be used to access a name by its name.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```memberName``` was not found.
  Future<Member?> getLocalMemberByName({required String memberName}) async {
    final DbMember? schema = await state.database!.dbMembers
        .where()
        .memberNameEqualTo(
          memberName,
        )
        .findFirst();

    if (schema == null) return null;

    final Member member = Member.fromSchema(schema: schema);

    return member;
  }

  /// This method can be used to load local members into state.
  Future<Members?> loadReferencedLocalMembers({required String participantReference, required List<String> additionalMemberIds}) async {
    try {
      // Access members of participant.
      final Members participantMembers = await getLocalMembersOfParticipant(
        participantId: participantReference,
      );

      // Compare involved Member ids to participantMembers and remove those that are already available.
      for (final Member member in participantMembers.items) {
        if (additionalMemberIds.contains(member.memberId)) additionalMemberIds.remove(member.memberId);
      }

      // Access references that are not in state yet.
      final Members referencedMembers = await getReferencedLocalMembers(
        references: additionalMemberIds,
      );

      // Join members.
      final Members members = await participantMembers.addUniqueMembers(
        members: referencedMembers,
      );

      // No members available which indicates an error.
      if (members.items.isEmpty) return null;

      return members;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedLocalMembers() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedLocalMembers() --> exception: ${exception.toString()}');

      return null;
    }
  }

  // ######################################
  // Shared Members
  // ######################################

  /// This method can be used to access all shared Members of a user.
  /// * Should be used in a try catch block.
  Future<Members> getSelfAllSharedMembers() async {
    // Get all shared user members.
    final Members members = await _apiRepository.getSelfAllMembers(
      user: user,
    );

    return members;
  }

  /// This method can be used to access all shared members of a specified shared reference.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```referenceId``` was not found.
  Future<Members?> getSelfAllSharedMembersOfReference({required String referenceType, required String referenceId}) async {
    // Get shared members of shared reference.
    final Members? members = await _apiRepository.getSelfMembersOfReference(
      user: user,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return members;
  }

  /// This method can be used to access and initialize all shared ```Members``` of a specified shared ```Participant```.
  /// * Should be used in a try catch block.
  /// * Returns ```Members.initial()``` if ```participantId.isEmpty```.
  Future<Members> getSharedMembersOfParticipant({required String participantId, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // If an empty participant id was supplied, return Members.initial().
    if (participantId.isEmpty) return Members.initial();

    // Get shared members of shared reference.
    final Members members = await _apiRepository.getSharedMembersOfParticipant(
      user: user,
      participantId: participantId,
      rootGroupReference: rootGroupReference,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return members;
  }

  /// This method can be used to access and initialize all shared ```Members``` specified in ```references```.
  /// * Should be used in a try catch block.
  /// * Returns ```Members.initial()``` if ```references.isEmpty```.
  Future<Members> getSharedReferencedMembers({required List<String> references, required String rootGroupReference, required String referenceType, required String referenceId}) async {
    // No references supplied.
    if (references.isEmpty) return Members.initial();

    // Get shared members of shared reference.
    final Members members = await _apiRepository.getSharedMembersBatch(
      user: user,
      rootGroupReference: rootGroupReference,
      references: references,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return members;
  }

  /// This method can be used to load shared members into state.
  Future<Members?> loadReferencedSharedMembers({required Group fromGroup, required String participantReference, required List<String> additionalMemberIds}) async {
    try {
      // Access members of participant.
      final Members participantMembers = await getSharedMembersOfParticipant(
        participantId: participantReference,
        rootGroupReference: fromGroup.rootGroupReference,
        referenceType: fromGroup.getReferenceType,
        referenceId: fromGroup.groupId,
      );

      // Compare involved Member ids to participantMembers and remove those that are already available.
      for (final Member member in participantMembers.items) {
        if (additionalMemberIds.contains(member.memberId)) additionalMemberIds.remove(member.memberId);
      }

      // Access references that are not in state yet.
      final Members referencedMembers = await getSharedReferencedMembers(
        references: additionalMemberIds,
        rootGroupReference: fromGroup.rootGroupReference,
        referenceType: fromGroup.getReferenceType,
        referenceId: fromGroup.groupId,
      );

      // Join members.
      final Members members = await participantMembers.addUniqueMembers(
        members: referencedMembers,
      );

      // No members available which indicates an error.
      if (members.items.isEmpty) return null;

      return members;
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedSharedMembers() --> failure: ${failure.toString()}');

      return null;
    } catch (exception) {
      // Output debug message.
      debugPrint('LocalStorageCubit --> loadReferencedSharedMembers() --> exception: ${exception.toString()}');

      return null;
    }
  }

  // ######################################
  // Local Participants
  // ######################################

  /// This method can be used to create a new participant object.
  /// * Should be used in a try catch block.
  Future<Participant> createLocalParticipant({required Participant participant}) async {
    // Encode the modelEntry object to corresponding database schema.
    final DbParticipant schema = participant.toSchema();

    await _storageRepository.create(
      db: state.database,
      collectionName: DbParticipant.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToCreateParticipant(),
    );

    return participant;
  }

  /// This method can be used to update an existing members object.
  /// * Should be used in a try catch block.
  Future<Participant> editLocalParticipant({required Participant updatedParticipant}) async {
    // Encode the participant object to corresponding database schema.
    final DbParticipant schema = updatedParticipant.toSchema();

    // Conduct database operation.
    await _storageRepository.update(
      db: state.database,
      collectionName: DbParticipant.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToUpdateParticipant(),
    );

    return updatedParticipant;
  }

  /// This method can be used to delete a participant.
  /// * Should be used in a try catch block.
  Future<void> deleteLocalParticipant({required Participant participant}) async {
    // Encode the participant object to corresponding database schema.
    final DbParticipant schema = participant.toSchema();

    // Conduct database operation.
    await _storageRepository.delete(
      db: state.database,
      collectionName: DbParticipant.collectionName,
      schema: schema,
      shouldThrow: Failure.failedToDeleteParticipant(),
    );
  }

  /// This method can be used to access a ```Participant``` by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```participantId``` was not found.
  Future<Participant?> getLocalParticipantById({required String participantId}) async {
    // Transform String id to int id.
    final int id = DbParticipant.fastHash(participantId);

    final DbParticipant? schema = await _storageRepository.getById(
      db: state.database,
      id: id,
      collectionName: DbParticipant.collectionName,
    ) as DbParticipant?;

    if (schema == null) return null;

    final Participant participant = Participant.fromSchema(schema: schema);

    return participant;
  }

  /// This method can be used to access all local Participants.
  /// * Should be used in a try catch block.
  Future<Participants> getLocalParticipants() async {
    // Init helper.
    List<Participant> helper = [];

    // Find all Participants.
    final List<DbParticipant> dbParticipants = await state.database!.dbParticipants.where().findAll();

    for (final DbParticipant schema in dbParticipants) {
      // Convert from schema.
      Participant participant = Participant.fromSchema(schema: schema);

      helper.add(participant);
    }

    return Participants(items: helper);
  }

  // ######################################
  // Shared Participants
  // ######################################

  /// This method can be used to store ```Participant``` and associated ```Members``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> createSharedParticipantAndMembers({required Participant participant, required Members members}) async {
    // Store objects in the cloud.
    await _apiRepository.createSharedParticipantAndMembers(
      user: state.user,
      participant: participant,
      members: members,
    );
  }

  /// This method can be used to edit a ```Participant``` and associated ```Members``` in the cloud.
  /// * Should be used in a try catch block.
  Future<void> editSharedParticipantAndMembers({required String participantId, required Participant? editedParticipant, required Members removedMembers, required Members addedMembers, required Members editedMembers}) async {
    // Edit objects in the cloud.
    await _apiRepository.editSharedParticipantAndMembers(
      user: user,
      participantId: participantId,
      editedParticipant: editedParticipant,
      removedMembers: removedMembers,
      addedMembers: addedMembers,
      editedMembers: editedMembers,
    );
  }

  /// This method can be used to access a shared participant by its id.
  /// * Should be used in a try catch block.
  /// * Returns ```null``` if ```participantId``` was not found.
  Future<Participant?> getSharedParticipantById({required String participantId, required String referenceType, required String referenceId}) async {
    // No participantId present.
    if (participantId.isEmpty) return null;

    // Fetch Participant.
    final Participant? fetchedParticipant = await _apiRepository.getSharedParticipantById(
      user: state.user,
      participantId: participantId,
      referenceType: referenceType,
      referenceId: referenceId,
    );

    return fetchedParticipant;
  }

  /// This method can be used to access all shared Participant of self user.
  /// * Should be used in a try catch block.
  Future<Participants> getSelfSharedParticipants() async {
    // Fetch Participants.
    final Participants fetchedParticipants = await _apiRepository.getSelfSharedParticipants(
      user: user,
    );

    return fetchedParticipants;
  }

  // ######################################
  // Local Payment Data Charts
  // ######################################

  /// This method can be used to calculate overall costs, i.e. combined costs of all members.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<double> localPaymentDataOverallCosts({required String filterByFieldId, required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init total costs.
    double totalCosts = 0.0;

    // Init bar helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isExpenseField = field.fieldType == Field.fieldTypePayment;

          if (isExpenseField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // * Filter in utc, but display in local.
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // Only consider this if filterByYear is not null. If it is null all years should be considered.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

            for (final ShareReference share in expenseData.shareReferences.items) {
              // Get bar item.
              BarItem? barItem = barItems.getItemById(id: share.id);

              // Flag that indicates if this bar item was found or not.
              bool exists = true;

              // If the bar item was not found, init a new one.
              if (barItem == null) {
                // Update flag.
                exists = false;

                // Get Member object.
                final Member member = await getLocalMemberById(memberId: share.id) ?? Member.unknownMember(memberId: share.id);

                // Init bar item
                barItem = BarItem.initial().copyWith(
                  id: share.id,
                  bottomTitle: member.memberName,
                );
              }

              // Create updated yAxisValue.
              final double yAxisValue = barItem.yAxisValue + (share.valueAsDouble * exchangeRateToDefault);

              // Update BarItem.
              final BarItem udpated = barItem.copyWith(
                topTitle: yAxisValue.toStringAsFixed(2),
                barColor: Colors.red,
                yAxisValue: yAxisValue,
              );

              // Update BarItems.
              barItems = exists ? barItems.update(updatedBarItem: udpated) : barItems.add(barItem: udpated);
            }
          }
        }
      }
    }

    // Go through bar items and add individual costs to total costs.
    for (final BarItem item in barItems.items) {
      totalCosts = totalCosts + item.yAxisValue;
    }

    return totalCosts;
  }

  /// This method can be used to calculate the actual amount spent by a member.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<double> localPaymentDataTotalCostsByMember({required DateTime? filterByYear, required Member filterByMember, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isExpenseField = field.fieldType == Field.fieldTypePayment;

          if (isExpenseField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // * Filter in utc, but display stuff in local.
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // Only consider this if filterByYear is not null. If it is null all years should be considered.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

            for (final ShareReference share in expenseData.shareReferences.items) {
              if (share.id == filterByMember.memberId) {
                // Get bar item.
                BarItem? barItem = barItems.getItemById(id: share.id);

                // Flag that indicates if this bar item was found or not.
                bool exists = true;

                // If the bar item was not found, init a new one.
                if (barItem == null) {
                  // Update flag.
                  exists = false;

                  // Get Member object.
                  final Member member = await getLocalMemberById(memberId: share.id) ?? Member.unknownMember(memberId: share.id);

                  // Init bar item
                  barItem = BarItem.initial().copyWith(
                    id: share.id,
                    bottomTitle: member.memberName,
                  );
                }

                // Create updated yAxisValue.
                final double yAxisValue = barItem.yAxisValue + (share.valueAsDouble * exchangeRateToDefault);

                // Update BarItem.
                final BarItem udpated = barItem.copyWith(
                  topTitle: yAxisValue.toStringAsFixed(2),
                  barColor: Colors.red,
                  yAxisValue: yAxisValue,
                );

                // Update BarItems.
                barItems = exists ? barItems.update(updatedBarItem: udpated) : barItems.add(barItem: udpated);
              }
            }
          }
        }
      }
    }

    // In case member has no costs.
    if (barItems.items.isEmpty) return 0.0;

    // If there are more then one items an error occurred because there should only ever be one item.
    if (barItems.items.length != 1) throw Failure.genericError();

    return barItems.items.first.yAxisValue;
  }

  /// This method can be used to calculate the ```CreditorsDebitors``` of entries in a group.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<CreditorsDebitors> localPaymentDataCreditorsDebitors({required Group group, required String filterByFieldId, required DateTime? filterByYear, required bool showAllTransactions, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    CreditorsDebitors creditorsDebitors = CreditorsDebitors.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: group.groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          if (field.fieldType == Field.fieldTypePayment) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // In case this expense was already compensated do not consider it.
            // * This is for example the case in an employee gets their salary. In that case they compensated the
            // * the amount by providing their labour.
            if (expenseData.isCompensated) continue;

            // * Filter in utc but display stuff in local.
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // Only consider this if filterByYear is not null. If it is null all years should be considered.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: group.defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: group.defaultCurrencyCode);

            for (final ShareReference ref in expenseData.shareReferences.items) {
              // * Ignore self spendings.
              if (expenseData.paidById == ref.id) continue;

              // Get Creditor.
              final Member creditor = await getLocalMemberById(
                    memberId: expenseData.paidById,
                  ) ??
                  Member.unknownMember(
                    memberId: expenseData.paidById,
                  );

              // Get Debitor.
              final Member debitor = await getLocalMemberById(
                    memberId: ref.id,
                  ) ??
                  Member.unknownMember(
                    memberId: ref.id,
                  );

              // Create DebitorCreditor object.
              final CreditorDebitor current = CreditorDebitor.initial().copyWith(
                creditor: creditor,
                debitor: debitor,
                value: ref.valueAsDouble * exchangeRateToDefault,
              );

              // * Does this pair already exist?
              final CreditorDebitor? existing = creditorsDebitors.getCreditorDebitor(
                creditorId: creditor.memberId,
                debitorId: debitor.memberId,
              );

              // * Pair was not found.
              if (existing == null) {
                creditorsDebitors = creditorsDebitors.add(creditorDebitor: current);
                continue;
              }

              // * Object found, update it.
              final CreditorDebitor updatedCreditor = existing.copyWith(
                value: existing.value + current.value,
              );

              creditorsDebitors = creditorsDebitors.update(creditorDebitor: updatedCreditor);
            }
          }
        }
      }
    }

    // Level pairs.
    creditorsDebitors = creditorsDebitors.settlePairs();

    // User wants to see all transactions.
    if (showAllTransactions) return creditorsDebitors;

    // User wants to see optimized transactions.
    final CreditorsDebitors optimized = creditorsDebitors.optimizedSettlement();

    return optimized;
  }

  /// This function can be used to calculate the debt balances of a all members.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  /// * If ```fieldId != null``` only the expense field with this id will be used during calculations.
  Future<BarItems> localPaymentDataDebtBalancesAllMembers({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isExpenseField = field.fieldType == Field.fieldTypePayment;

          if (isExpenseField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // In case this expense was already compensated do not consider it.
            // * This is for example the case in an employee gets their salary. In that case they compensated the
            // * the amount by providing their labour.
            if (expenseData.isCompensated) continue;

            // * Filter in utc but display stuff in local.
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // Only consider this if filterByYear is not null. If it is null all years should be considered.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // * Check if this share was only for the paying member.
            final bool isSelfOnlyPayment = expenseData.shareReferences.isSelfPaymentOnly(
              paidById: expenseData.paidById,
            );

            // In case this is a self payment, continue with next entry because they do not contribute to debts.
            if (isSelfOnlyPayment) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

            // Get total.
            final double totalSpent = expenseData.calculateConvertedTotal(
              exchangeRateToDefault: exchangeRateToDefault,
            );

            // Access paid by member.
            final Member paidByMember = await getLocalMemberById(
                  memberId: expenseData.paidById,
                ) ??
                Member.unknownMember(
                  memberId: expenseData.paidById,
                );

            // * Get barItem of paid by member.
            BarItem? barItemPaidBy = barItems.getItemById(id: paidByMember.memberId);

            // Bar item was found. Add total.
            if (barItemPaidBy != null) {
              // Get added total.
              final double addedTotal = barItemPaidBy.yAxisValue + totalSpent;

              final BarItem barItem = BarItem.initial().copyWith(
                id: paidByMember.memberId,
                topTitle: paidByMember.memberName,
                bottomTitle: addedTotal.toStringAsFixed(2),
                barColor: addedTotal < 0 ? Colors.red : Colors.green,
                yAxisValue: addedTotal,
              );

              // * Update paid by member.
              barItems = barItems.update(updatedBarItem: barItem);

              // Update bar item.
              barItemPaidBy = barItem;
            }

            // Bar item was not found. Init item.
            if (barItemPaidBy == null) {
              // Get yAxisValue.
              final double yAxisValue = totalSpent;

              final BarItem barItem = BarItem.initial().copyWith(
                id: paidByMember.memberId,
                topTitle: paidByMember.memberName,
                bottomTitle: yAxisValue.toStringAsFixed(2),
                barColor: Colors.green,
                yAxisValue: yAxisValue,
              );

              // * Insert paid by member.
              barItems = barItems.add(barItem: barItem);

              // Update bar item.
              barItemPaidBy = barItem;
            }

            // Go through shares and add relevant data.
            for (final ShareReference share in expenseData.shareReferences.items) {
              // * Get barItem of paid for member.
              BarItem? barItemPaidFor = barItems.getItemById(id: share.id);

              // Share not found, add to items.
              if (barItemPaidFor == null) {
                // Access member.
                final Member paidForMember = await getLocalMemberById(
                      memberId: share.id,
                    ) ??
                    Member.unknownMember(
                      memberId: share.id,
                    );

                // Init bar item.
                BarItem barItem = BarItem.initial().copyWith(
                  id: paidForMember.memberId,
                  topTitle: paidForMember.memberName,
                  bottomTitle: '0.0',
                  barColor: Colors.green,
                  yAxisValue: 0.0,
                );

                // * Insert the bar item.
                barItems = barItems.add(barItem: barItem);

                // * Set bar item paid for.
                barItemPaidFor = barItem;
              }

              // Calculate yAxisValue of paid for.
              final double yAxisValuePaidFor = barItemPaidFor.yAxisValue - (share.valueAsDouble * exchangeRateToDefault);

              // Create updated bar item for paid for member.
              final BarItem updatedPaidForItem = barItemPaidFor.copyWith(
                bottomTitle: yAxisValuePaidFor.toStringAsFixed(2),
                barColor: yAxisValuePaidFor < 0 ? Colors.red : Colors.green,
                yAxisValue: yAxisValuePaidFor,
              );

              // Update bar items.
              barItems = barItems.update(updatedBarItem: updatedPaidForItem);
            }
          }
        }
      }
    }

    return barItems;
  }

  /// This method can be used to calculate the costs of all members.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  /// * If ```fieldId != null``` only the expense field with this id will be used during calculations.
  Future<BarItems> localPaymentDataTotalCostsAllMembers({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isExpenseField = field.fieldType == Field.fieldTypePayment;

          if (isExpenseField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // * Filter in utc but display stuff in local.
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // Only consider this if filterByYear is not null. If it is null all years should be considered.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

            for (final ShareReference share in expenseData.shareReferences.items) {
              // Get bar item.
              BarItem? barItem = barItems.getItemById(id: share.id);

              // Flag that indicates if this bar item was found or not.
              bool exists = true;

              // If the bar item was not found, init a new one.
              if (barItem == null) {
                // Update flag.
                exists = false;

                // Get Member object.
                final Member member = await getLocalMemberById(memberId: share.id) ?? Member.unknownMember(memberId: share.id);

                // Init bar item
                barItem = BarItem.initial().copyWith(
                  id: share.id,
                  bottomTitle: member.memberName,
                );
              }

              // Create updated yAxisValue.
              final double yAxisValue = barItem.yAxisValue + (share.valueAsDouble * exchangeRateToDefault);

              // Update BarItem.
              final BarItem udpated = barItem.copyWith(
                topTitle: yAxisValue.toStringAsFixed(2),
                barColor: Colors.red,
                yAxisValue: yAxisValue,
              );

              // Update BarItems.
              barItems = exists ? barItems.update(updatedBarItem: udpated) : barItems.add(barItem: udpated);
            }
          }
        }
      }
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    // * And for some performance gains list with one item dont need to be sorted.
    if (barItems.items.length >= 2) barItems.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItems;
  }

  /// This method can be used to calculate the costs over time and member.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localPaymentDataCostsByMemberOverTime({required String timeInterval, required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required Member member, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Convenience variables to check time interval.
    final bool isYearly = timeInterval == PickerItem.intervalYearly;
    final bool isMonthly = timeInterval == PickerItem.intervalMonthly;
    final bool isDaily = isYearly == false && isMonthly == false;

    // Init bar helper.
    BarItems barItems = isYearly
        ? BarItems.yearly(barColor: Colors.red)
        : isMonthly
            ? BarItems.monthly(barColor: Colors.red)
            : BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isExpenseField = field.fieldType == Field.fieldTypePayment;

          if (isExpenseField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // Get the month of the DateTime object as a string.
            // * Filter in utc, but display stuff in local.
            final String monthAsString = DateFormat('MMMM').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String dayAsString = DateFormat('yyyy-MM-dd').format(expenseData.paymentDateInUtc!).toLowerCase();

            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

            // Access correct bar item id.
            final String barItemId = isMonthly
                ? monthAsString
                : isYearly
                    ? yearAsString
                    : dayAsString;

            // Access BarItem of id.
            BarItem? barItem = barItems.getItemById(id: barItemId);

            // If filter is set to daily and BarItem was not found, init.
            if (barItem == null && isDaily) {
              barItem = BarItem.initial().copyWith(
                id: barItemId,
                // This is done to show the year if all values should be displayed because more then one year can be shown.
                bottomTitle: DateFormat(filterByYear == null ? 'yyyy-MM-dd' : 'MM-dd').format(expenseData.paymentDateInUtc!.toLocal()),
                barColor: Colors.red,
              );
            }

            // If filter is NOT set to daily and BarItem was not found, an error occurred.
            if (isDaily == false && barItem == null) throw Failure.genericError();

            // If bar item is still null, an error occurred.
            if (barItem == null) throw Failure.genericError();

            for (final ShareReference share in expenseData.shareReferences.items) {
              if (share.id == member.memberId) {
                // * Ignore 0 values. This is needed because otherwise months that have a 0.0 value will be given a topTitle.
                if (share.valueAsDouble == 0) continue;

                // Update bar item.
                final double yAxisValue = barItem.yAxisValue + (share.valueAsDouble * exchangeRateToDefault);

                // Update BarItem.
                final BarItem udpated = barItem.copyWith(
                  topTitle: yAxisValue.toStringAsFixed(2),
                  yAxisValue: yAxisValue,
                );

                // Update BarItems.
                barItems = barItems.set(barItem: udpated);
              }
            }
          }
        }
      }
    }

    return barItems;
  }

  /// This method can be used to calculate the costs by tags.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localPaymentDataMemberCostsByTag({required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required Member member, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();
    BarItem untagged = BarItem.initial().copyWith(
      barColor: Colors.deepPurple,
      bottomTitle: labels.basicLabelsNotTagged(),
      referenceId: filterByFieldId.isEmpty ? Field.fieldTypeTags : filterByFieldId,
      referenceType: filterByFieldId.isEmpty ? 'untagged_by_field_type' : 'untagged_by_field_id',
    );

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Only consider desired field.
          if (field.getIsPaymentField == false) continue;

          // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access the shared expense.
          final PaymentData expenseData = field.paymentData!;

          // Get the month of the DateTime object as a string.
          // * Filter in utc, but display in local.
          final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();

          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: expenseData.customExchangeRates,
            exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
            fromCurrencyCode: expenseData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

          // Get member share.
          final ShareReference? share = expenseData.shareReferences.getById(
            id: member.memberId,
          );

          // Member not found in this entry.
          if (share == null) continue;

          // Calculate converted value.
          final double convertedValue = share.valueAsDouble * exchangeRateToDefault;

          // If a value is not tagged, create a bar item for those values.
          if (expenseData.tagsData.tagReferences.isEmpty) {
            // Get value.
            final double value = untagged.yAxisValue + convertedValue;

            // Update pie item
            untagged = untagged.copyWith(
              topTitle: value.toStringAsFixed(2),
              yAxisValue: value,
            );

            continue;
          }

          // Tags are present, calculate proportional allocation.
          final double tagShare = convertedValue / expenseData.tagsData.tagReferences.length;

          // Go through tags and add them with value.
          for (final String tagRef in expenseData.tagsData.tagReferences) {
            // Get tag.
            Tag? tag = await getLocalTagById(
              tagId: tagRef,
            );

            // If tag is unknown, create an unknown tag.
            tag ??= Tag.initial().copyWith(tagId: tagRef, label: labels.unknownTag());

            // Access bar item.
            BarItem? barItem = barItems.getItemById(
              id: tagRef,
            );

            // Item not found, add initial.
            barItem ??= BarItem.initial().copyWith(id: tagRef, bottomTitle: tag.label);

            // Calculate y_axis_value.
            final double value = barItem.yAxisValue + tagShare;

            // Update bar item
            barItem = barItem.copyWith(
              topTitle: value.toStringAsFixed(2),
              barColor: Colors.red,
              yAxisValue: value,
              referenceType: 'tag',
              referenceId: tagRef,
            );

            // Update BarItems.
            barItems = barItems.set(barItem: barItem);
          }
        }
      }
    }

    // Add untagged if needed.
    if (untagged.yAxisValue != 0) barItems = barItems.add(barItem: untagged);

    // Access the total.
    final double sum = barItems.getYAxisValueSum;

    // If there are no values to display, return initial.
    if (sum == 0) return BarItems.initial();

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    // * And for some performance gains list with one item dont need to be sorted.
    if (barItems.items.length >= 2) barItems.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItems;
  }

  /// This method can be used to calculate the overall costs by tags.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localPaymentDataOverallCostsByTag({required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();
    BarItem untagged = BarItem.initial().copyWith(
      barColor: Colors.deepPurple,
      bottomTitle: labels.basicLabelsNotTagged(),
      referenceId: filterByFieldId.isEmpty ? Field.fieldTypeTags : filterByFieldId,
      referenceType: filterByFieldId.isEmpty ? 'untagged_by_field_type' : 'untagged_by_field_id',
    );

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Only consider desired field.
          if (field.getIsPaymentField == false) continue;

          // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access the shared expense.
          final PaymentData expenseData = field.paymentData!;

          // Get the month of the DateTime object as a string.
          // * Filter in utc, but display stuff in local.
          final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();

          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: expenseData.customExchangeRates,
            exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
            fromCurrencyCode: expenseData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

          // Get converted total.
          final double convertedTotal = expenseData.calculateConvertedTotal(
            exchangeRateToDefault: exchangeRateToDefault,
          );

          // If a value is not tagged, create a bar item for those values.
          if (expenseData.tagsData.tagReferences.isEmpty) {
            // Get value.
            final double value = untagged.yAxisValue + convertedTotal;

            // Update pie item
            untagged = untagged.copyWith(
              topTitle: value.toStringAsFixed(2),
              yAxisValue: value,
            );

            continue;
          }

          // Tags are present, calculate proportional allocation.
          final double tagShare = convertedTotal / expenseData.tagsData.tagReferences.length;

          // Go through tags and add them with value.
          for (final String tagRef in expenseData.tagsData.tagReferences) {
            // Get tag.
            Tag? tag = await getLocalTagById(
              tagId: tagRef,
            );

            // If tag is unknown, create an unknown tag.
            tag ??= Tag.initial().copyWith(tagId: tagRef, label: labels.unknownTag());

            // Access bar item.
            BarItem? barItem = barItems.getItemById(
              id: tagRef,
            );

            // Item not found, add initial.
            barItem ??= BarItem.initial().copyWith(id: tagRef, bottomTitle: tag.label);

            // Calculate y_axis_value.
            final double value = barItem.yAxisValue + tagShare;

            // Update bar item
            barItem = barItem.copyWith(
              topTitle: value.toStringAsFixed(2),
              barColor: Colors.red,
              yAxisValue: value,
              referenceType: 'tag',
              referenceId: tagRef,
            );

            // Update BarItems.
            barItems = barItems.set(barItem: barItem);
          }
        }
      }
    }

    // Add untagged if needed.
    if (untagged.yAxisValue != 0) barItems = barItems.add(barItem: untagged);

    // Access the total.
    final double sum = barItems.getYAxisValueSum;

    // If there are no values to display, return initial.
    if (sum == 0) return BarItems.initial();

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    // * And for some performance gains list with one item dont need to be sorted.
    if (barItems.items.length >= 2) barItems.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItems;
  }

  /// This method can be used to calculate the absolut expenses over time and member.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localPaymentDataAbsolutExpensesByMemberOverTime({required String timeInterval, required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required Member member, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Convenience variables to check time interval.
    final bool isYearly = timeInterval == PickerItem.intervalYearly;
    final bool isMonthly = timeInterval == PickerItem.intervalMonthly;
    final bool isDaily = isYearly == false && isMonthly == false;

    // Init bar helper.
    BarItems barItems = isYearly
        ? BarItems.yearly(barColor: Colors.red)
        : isMonthly
            ? BarItems.monthly(barColor: Colors.red)
            : BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isExpenseField = field.fieldType == Field.fieldTypePayment;

          if (isExpenseField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // Get the month of the DateTime object as a string.
            // * Filter in utc, but display stuff in local.
            final String monthAsString = DateFormat('MMMM').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String dayAsString = DateFormat('yyyy-MM-dd').format(expenseData.paymentDateInUtc!).toLowerCase();

            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

            // This expense was paid by selected member. Update value.
            if (expenseData.paidById == member.memberId) {
              // Access correct bar item id.
              final String barItemId = isMonthly
                  ? monthAsString
                  : isYearly
                      ? yearAsString
                      : dayAsString;

              // Get total paid.
              final double totalPaid = expenseData.calculateConvertedTotal(
                exchangeRateToDefault: exchangeRateToDefault,
              );

              // Access BarItem of id.
              BarItem? barItem = barItems.getItemById(id: barItemId);

              // If filter is set to daily and BarItem was not found, init.
              if (barItem == null && isDaily) {
                barItem = BarItem.initial().copyWith(
                  id: barItemId,
                  // This is done to show the year if all values should be displayed because more then one year can be shown.
                  bottomTitle: DateFormat(filterByYear == null ? 'yyyy-MM-dd' : 'MM-dd').format(expenseData.paymentDateInUtc!.toLocal()),
                  barColor: Colors.red,
                );
              }

              // If filter is NOT set to daily and BarItem was not found, an error occurred.
              if (isDaily == false && barItem == null) throw Failure.genericError();

              // If bar item is still null, an error occurred.
              if (barItem == null) throw Failure.genericError();

              // Calculate new yAxisValue.
              final double yAxisValue = barItem.yAxisValue + totalPaid;

              // Update BarItem.
              final BarItem udpated = barItem.copyWith(
                topTitle: yAxisValue.toStringAsFixed(2),
                yAxisValue: yAxisValue,
              );

              // Update BarItems.
              barItems = barItems.set(barItem: udpated);
            }
          }
        }
      }
    }

    return barItems;
  }

  /// This method can be used to calculate the absolut income over time and member.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localPaymentDataAbsolutIncomeByMemberOverTime({required String timeInterval, required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required Member member, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Convenience variables to check time interval.
    final bool isYearly = timeInterval == PickerItem.intervalYearly;
    final bool isMonthly = timeInterval == PickerItem.intervalMonthly;
    final bool isDaily = isYearly == false && isMonthly == false;

    // Init bar helper.
    BarItems barItems = isYearly
        ? BarItems.yearly(barColor: Colors.green)
        : isMonthly
            ? BarItems.monthly(barColor: Colors.green)
            : BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isExpenseField = field.fieldType == Field.fieldTypePayment;

          if (isExpenseField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final PaymentData expenseData = field.paymentData!;

            // * Only include payments that have been marked as compensated because all other
            // * payments have to be repaid at some point. Ideally.
            if (expenseData.isCompensated == false) continue;

            // Get the month of the DateTime object as a string.
            // * Filter in utc, but display in local.
            final String monthAsString = DateFormat('MMMM').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String yearAsString = DateFormat('yyyy').format(expenseData.paymentDateInUtc!).toLowerCase();
            final String dayAsString = DateFormat('yyyy-MM-dd').format(expenseData.paymentDateInUtc!).toLowerCase();

            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access exchange rate if needed.
            final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
              customExchangeRates: expenseData.customExchangeRates,
              exchangeRateDateInUtc: expenseData.paymentDateInUtc!,
              fromCurrencyCode: expenseData.currencyCode,
              toCurrencyCode: defaultCurrencyCode,
            );

            // Convenience variables.
            final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

            // Could not find exchange rate, which means total cannot be accurately calculated.
            if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: expenseData.currencyCode, to: defaultCurrencyCode);

            for (final ShareReference share in expenseData.shareReferences.items) {
              if (share.id == member.memberId) {
                // Access correct bar item id.
                final String barItemId = isMonthly
                    ? monthAsString
                    : isYearly
                        ? yearAsString
                        : dayAsString;

                // Access BarItem of id.
                BarItem? barItem = barItems.getItemById(id: barItemId);

                // If filter is set to daily and BarItem was not found, init.
                if (barItem == null && isDaily) {
                  barItem = BarItem.initial().copyWith(
                    id: barItemId,
                    // This is done to show the year if all values should be displayed because more then one year can be shown.
                    bottomTitle: DateFormat(filterByYear == null ? 'yyyy-MM-dd' : 'MM-dd').format(expenseData.paymentDateInUtc!.toLocal()),
                    barColor: Colors.green,
                  );
                }

                // If filter is NOT set to daily and BarItem was not found, an error occurred.
                if (isDaily == false && barItem == null) throw Failure.genericError();

                // If bar item is still null, an error occurred.
                if (barItem == null) throw Failure.genericError();

                // Calculate new yAxisValue.
                final double yAxisValue = barItem.yAxisValue + (share.valueAsDouble * exchangeRateToDefault);

                // Update BarItem.
                final BarItem udpated = barItem.copyWith(
                  topTitle: yAxisValue.toStringAsFixed(2),
                  yAxisValue: yAxisValue,
                );

                // Update BarItems.
                barItems = barItems.set(barItem: udpated);
              }
            }
          }
        }
      }
    }

    return barItems;
  }

  /// This method can be used to calculate the absolut profit or losses over time and member.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localPaymentDataAbsolutProfitOrLossByMemberOverTime({required String timeInterval, required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required Member member, required String filterByFieldId, required Secrets? secrets}) async {
    // Calculate Income.
    final BarItems barItemsIncome = await localPaymentDataAbsolutIncomeByMemberOverTime(
      groupId: groupId,
      defaultCurrencyCode: defaultCurrencyCode,
      timeInterval: timeInterval,
      member: member,
      filterByYear: filterByYear,
      filterByFieldId: filterByFieldId,
      secrets: secrets,
    );

    // Calculate Losses.
    final BarItems barItemsLosses = await localPaymentDataAbsolutExpensesByMemberOverTime(
      groupId: groupId,
      defaultCurrencyCode: defaultCurrencyCode,
      timeInterval: timeInterval,
      member: member,
      filterByYear: filterByYear,
      filterByFieldId: filterByFieldId,
      secrets: secrets,
    );

    // Init helper.
    BarItems profitAndLosses = BarItems.initial();

    // Go through income bar items and update items.
    for (final BarItem incomeItem in barItemsIncome.items) {
      // Check if there is a loss item for this member.
      final BarItem? lossItem = barItemsLosses.getItemById(id: incomeItem.id);

      // No loss item found, add to profitAndLosses.
      if (lossItem == null) {
        profitAndLosses = profitAndLosses.add(barItem: incomeItem);
        continue;
      }

      // Check if this item is already in profitAndLosses.
      final bool exists = profitAndLosses.getItemById(id: incomeItem.id) != null;

      // Loss item found, Create updated total and update item.
      final double updatedTotal = incomeItem.yAxisValue - lossItem.yAxisValue;

      // Update item.
      final BarItem updatedBarItem = incomeItem.copyWith(
        topTitle: updatedTotal.toStringAsFixed(2),
        barColor: updatedTotal < 0 ? Colors.red : Colors.green,
        yAxisValue: updatedTotal.abs(), // * Use absolut value to prevent chart from drawing negative bars.
      );

      profitAndLosses = exists ? profitAndLosses.update(updatedBarItem: updatedBarItem) : profitAndLosses.add(barItem: updatedBarItem);
    }

    return profitAndLosses;
  }

  /// This method can be used to calculate the member cost share of the overall costs.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localPaymentDataMemberCostsOfOverallCosts({required DateTime? filterByYear, required Member filterByMember, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Get the overall costs.
    final double overallCosts = await localPaymentDataOverallCosts(
      filterByFieldId: filterByFieldId,
      groupId: groupId,
      defaultCurrencyCode: defaultCurrencyCode,
      filterByYear: filterByYear,
      secrets: secrets,
    );

    // Nothing was spent, return empty items.
    if (overallCosts == 0) return PieItems.initial();

    // Get the total spent of a member.
    final double memberTotalSpent = await localPaymentDataTotalCostsByMember(
      filterByFieldId: filterByFieldId,
      filterByMember: filterByMember,
      filterByYear: filterByYear,
      defaultCurrencyCode: defaultCurrencyCode,
      groupId: groupId,
      secrets: secrets,
    );

    // Total others.
    final double totalOthers = overallCosts - memberTotalSpent;

    // Calculate percentage.
    final double percentageMember = ((memberTotalSpent / overallCosts) * 100);
    final double percentageOthers = 100 - percentageMember;

    // String representation.
    final String roundedMember = percentageMember.toStringAsFixed(2);
    final String roundedOther = percentageOthers.toStringAsFixed(2);

    // Create PieItem member.
    final PieItem pieItemMember = PieItem.initial().copyWith(
      title: '$roundedMember %',
      value: percentageMember,
      color: Colors.amber,
      legendLabel: filterByMember.memberName,
      legendValue: memberTotalSpent,
      legendSuffix: defaultCurrencyCode,
    );

    // Create PieItem others.
    final PieItem pieItemOthers = PieItem.initial().copyWith(
      title: '$roundedOther %',
      value: percentageOthers,
      color: Colors.deepPurple,
      legendLabel: labels.basicLabelsOthers(),
      legendValue: totalOthers,
      legendSuffix: defaultCurrencyCode,
    );

    // Init helper.
    final PieItems pieItems = PieItems(items: [
      pieItemMember,
      pieItemOthers,
    ]);

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (pieItems.items.isNotEmpty) pieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return pieItems;
  }

  /// This method can be used to calculate the member cost shares by tag.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localPaymentDataMemberCostSharesByTag({required DateTime? filterByYear, required Member filterByMember, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Calculate costs by tag.
    final BarItems barItems = await localPaymentDataMemberCostsByTag(
      defaultCurrencyCode: defaultCurrencyCode,
      filterByFieldId: filterByFieldId,
      filterByYear: filterByYear,
      groupId: groupId,
      member: filterByMember,
      secrets: secrets,
    );

    // Get total costs.
    final double sum = barItems.getYAxisValueSum;

    // If there are no values to display, return initial.
    if (sum == 0) return PieItems.initial();

    PieItems pieItems = PieItems.initial();
    List<Color> usedColors = [];

    // Iterate through the items and adjust percentages
    for (int i = 0; i < barItems.items.length; i++) {
      final BarItem barItem = barItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calcualte percentage.
      final double percentage = (barItem.yAxisValue / sum) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Create an updated PieItem
      final PieItem updatedItem = PieItem.initial().copyWith(
        id: barItem.id,
        title: '$percentageString %',
        value: percentage,
        color: color,
        legendLabel: barItem.bottomTitle,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: barItem.referenceId,
        referenceType: barItem.referenceType,
      );

      // Add the updated item to the adjusted list
      pieItems = pieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (pieItems.items.isNotEmpty) pieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return pieItems;
  }

  /// This method can be used to calculate the over all costs shares by tag.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localPaymentDataOverallCostsSharesByTag({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Calculate costs by tag.
    final BarItems barItems = await localPaymentDataOverallCostsByTag(
      defaultCurrencyCode: defaultCurrencyCode,
      filterByFieldId: filterByFieldId,
      filterByYear: filterByYear,
      groupId: groupId,
      secrets: secrets,
    );

    // Get total costs.
    final double sum = barItems.getYAxisValueSum;

    PieItems pieItems = PieItems.initial();
    List<Color> usedColors = [];

    // Iterate through the items and adjust percentages
    for (int i = 0; i < barItems.items.length; i++) {
      final BarItem barItem = barItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calcualte percentage.
      final double percentage = (barItem.yAxisValue / sum) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Create an updated PieItem
      final PieItem updatedItem = PieItem.initial().copyWith(
        id: barItem.id,
        title: '$percentageString %',
        value: percentage,
        color: color,
        legendLabel: barItem.bottomTitle,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: barItem.referenceId,
        referenceType: barItem.referenceType,
      );

      // Add the updated item to the adjusted list
      pieItems = pieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    // * And for some performance gains list with one item dont need to be sorted.
    if (pieItems.items.length >= 2) pieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return pieItems;
  }

  // ######################################
  // Shared Payment Data Charts
  // ######################################

  /// This method can be used to calculate the ```CreditorsDebitors``` of entries in a shared group.
  Future<CreditorsDebitors> sharedPaymentDataCreditorsDebitors({required Group group, required String filterByFieldId, required DateTime? filterByYear, required bool showAllTransactions, required ExpenseReportSheetCubit expenseReportSheetCubit}) async {
    // * This is used to block requests at the api level if needed.
    final String requestId = const Uuid().v4();

    int elapsed = 0;
    int total = 0;
    String lastEntryId = '';

    // Perform state update.
    expenseReportSheetCubit.updateCreditorsDebitorsLoadingMessage(loadingMessage: '');

    while (true) {
      // Fetch CreditorsDebitors.
      final dynamic fetched = await _apiRepository.getPaymentDataCreditorsDebitors(
        user: user,
        group: group,
        filterByFieldId: filterByFieldId,
        filterByYear: filterByYear,
        showAllTransactions: showAllTransactions,
        requestId: requestId,
        lastEntryId: lastEntryId,
      );

      // Update helpers.
      elapsed = fetched['elapsed'];
      total = fetched['total'];
      lastEntryId = fetched['last_entry_id'];

      // * This is an extra field to avoid compare misstakes with elapsed and total.
      final bool? finished = fetched['finished'];

      // Developer forgot to include finished flag. Stop while loop.
      if (finished == null) throw Failure.genericError();

      // Convert to line items.
      if (finished) {
        // Convenience variables.
        final CreditorsDebitors creditorsDebitors = CreditorsDebitors.fromCloudObject(fetched['creditors_debitors']);

        return creditorsDebitors;
      }

      // * Getting data has not finished.

      // Perform state update.
      expenseReportSheetCubit.updateCreditorsDebitorsLoadingMessage(loadingMessage: '$elapsed / $total');
    }
  }

  // ######################################
  // # Number Data Charts
  // ######################################

  /// This method can be used to calculate the numerical progression.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<LineItems> localNumberDataGetNumericalProgressionIndividual({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    LineDots lineDotsIndividual = LineDots.initial();

    int counter = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // heighten counter.
        counter++;

        for (final Field field in entry.fields.items) {
          // Only number fields are relevant.
          if (field.getIsNumberField == false) continue;

          // In case a fieldId was supplied, make sure that only fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access data.
          final NumberData numberData = field.numberData!;

          // Get the month of the DateTime object as a string
          final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Calculate y axis values.
          final double yAxisValueIndividual = numberData.valueAsDouble;

          // Create line dot
          final LineDot lineDotIndividual = LineDot.initial().copyWith(
            xAxisValue: (counter + 1).toDouble(),
            yAxisValue: yAxisValueIndividual,
          );

          // Add to helper.
          lineDotsIndividual = lineDotsIndividual.add(lineDot: lineDotIndividual);
        }
      }
    }

    // Create LineItem.
    final LineItem lineItemIndividual = LineItem.initial().copyWith(
      lineDots: lineDotsIndividual,
      legendLabel: labels.basicLabelsIndividualValues(),
    );

    // Create LineItems.
    final LineItems lineItems = LineItems(
      items: [
        lineItemIndividual,
      ],
    );

    return lineItems;
  }

  /// This method can be used to calculate the numerical progression.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<LineItems> localNumberDataGetNumericalProgressionAccumulated({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    LineDots lineDotsTotal = LineDots.initial();
    double yAxisValueTotal = 0.0;
    int counter = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // heighten counter.
        counter++;

        for (final Field field in entry.fields.items) {
          // Only number fields are relevant.
          if (field.getIsNumberField == false) continue;

          // In case a fieldId was supplied, make sure that only fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access data.
          final NumberData numberData = field.numberData!;

          // Get the month of the DateTime object as a string
          final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Calculate y axis values.
          yAxisValueTotal = yAxisValueTotal + numberData.valueAsDouble;

          // Create line dot
          final LineDot lineDotTotal = LineDot.initial().copyWith(
            xAxisValue: (counter + 1).toDouble(),
            yAxisValue: yAxisValueTotal,
          );

          // Add to helper.
          lineDotsTotal = lineDotsTotal.add(lineDot: lineDotTotal);
        }
      }
    }

    // Get akkumulated value.
    final double sum = lineDotsTotal.items.isEmpty ? 0.0 : lineDotsTotal.items.last.yAxisValue;

    // Create LineItem.
    final LineItem lineItemTotal = LineItem.initial().copyWith(
      lineDots: lineDotsTotal,
      color: Colors.deepPurple,
      legendLabel: labels.basicLabelsAccumulated(),
      legendValue: sum,
    );

    // Create LineItems.
    final LineItems lineItems = LineItems(
      items: [
        lineItemTotal,
      ],
    );

    return lineItems;
  }

  /// This method can be used to calculate the numerical order.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localNumberDataGetNumericalOrder({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isNumberField = field.fieldType == Field.fieldTypeNumber;

          if (isNumberField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data.
            final NumberData numberData = field.numberData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Init BarItem.
            final BarItem barItem = BarItem.initial().copyWith(
              barColor: Colors.deepPurple,
              topTitle: numberData.valueAsDouble.toStringAsFixed(2),
              bottomTitle: entry.entryName,
              yAxisValue: numberData.valueAsDouble,
            );

            // Add to helper.
            barItems = barItems.add(barItem: barItem);
          }
        }
      }
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    // * And for some performance gains list with one item dont need to be sorted.
    if (barItems.items.length >= 2) barItems.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItems;
  }

  // ######################################
  // # Boolean Data Charts
  // ######################################

  /// This method can be used to calculate the true false distribution.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localBooleanDataTrueFalseDistribution({required String groupId, required String filterByFieldId, required DateTime? filterByYear, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItems pieItems = PieItems.initial();
    int totalEntries = 0;
    int numberOfTrueValues = 0;
    int numberOfFalseValues = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isBooleanField = field.fieldType == Field.fieldTypeBoolean;

          if (isBooleanField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the desired data point.
            final BooleanData booleanData = field.booleanData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();

            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten total helper.
            totalEntries++;

            if (booleanData.value!) numberOfTrueValues++;
            if (booleanData.value! == false) numberOfFalseValues++;
          }
        }
      }
    }

    // If there are no values to display, return initial.
    if (totalEntries == 0) return PieItems.initial();

    // Check which value to base data on.
    final bool baseOnTrue = numberOfTrueValues >= numberOfFalseValues;

    // Calculate share.
    final double firstShare = baseOnTrue ? (numberOfTrueValues / totalEntries) * 100 : (numberOfFalseValues / totalEntries) * 100;
    final double secondShare = 100 - firstShare;

    // String representation.
    final String percentageFirstString = firstShare.toStringAsFixed(2);
    final String percentageSecondString = secondShare.toStringAsFixed(2);

    // Create Pie item for the first share.
    final PieItem pieItemFirst = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.green : Colors.red,
      title: '$percentageFirstString %',
      value: firstShare,
      legendLabel: baseOnTrue ? labels.basicLabelsTrue() : labels.basicLabelsFalse(),
      legendValue: baseOnTrue ? numberOfTrueValues.toDouble() : numberOfFalseValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemFirst);

    // If firstShare is 100%, skip adding the second item.
    if (firstShare == 100) return pieItems;

    // Create Pie item for the second share.
    final PieItem pieItemSecond = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.red : Colors.green,
      title: '$percentageSecondString %',
      value: secondShare,
      legendLabel: baseOnTrue ? labels.basicLabelsFalse() : labels.basicLabelsTrue(),
      legendValue: baseOnTrue ? numberOfFalseValues.toDouble() : numberOfTrueValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemSecond);

    return pieItems;
  }

  /// This method can be used to display the true false history over entries.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localBooleanDataTrueFalseHistory({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required int maxHistoryLength, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    BarItems barItems = BarItems.initial();
    int totalCheckedEntries = 0;

    while (true) {
      // If desired length has been reached, break.
      // * This is needed here and in for loop.
      if (maxHistoryLength == totalCheckedEntries) break;

      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // If desired length has been reached, break.
        if (maxHistoryLength == totalCheckedEntries) break;

        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeBoolean;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data.
            final BooleanData booleanData = field.booleanData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten flag.
            totalCheckedEntries++;

            // Init BarItem.
            final BarItem barItem = BarItem.initial().copyWith(
              barColor: booleanData.value! ? Colors.green : Colors.red,
              bottomTitle: entry.entryName,
              yAxisValue: booleanData.value! ? 2 : 1,
            );

            // Add to helper.
            barItems = barItems.add(barItem: barItem);
          }
        }
      }
    }

    return barItems;
  }

  // ######################################
  // # Email Data Charts
  // ######################################

  /// This function can be used to calculate the n frequencies of emails in group.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localEmailDataFrequencyDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeEmail;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data.
            final EmailData emailData = field.emailData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Check if this email already has a bar item.
            final BarItem? barItem = barItems.getItemById(id: emailData.value);

            // Email does not exist --> init.
            if (barItem == null) {
              // Init BarItem.
              final BarItem barItem = BarItem.initial().copyWith(
                id: emailData.value,
                barColor: Colors.deepPurple,
                bottomTitle: emailData.value,
                yAxisValue: 1.0,
              );

              // Add to helper.
              barItems = barItems.add(barItem: barItem);

              continue;
            }

            // Update existing bar item.
            final BarItem updatedBarItem = barItem.copyWith(
              yAxisValue: barItem.yAxisValue + 1,
            );

            // Update helper.
            barItems = barItems.update(updatedBarItem: updatedBarItem);
          }
        }
      }
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    // * And for some performance gains list with one item dont need to be sorted.
    if (barItems.items.length >= 2) barItems.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItems;
  }

  /// This function can be used to calculate the n frequencies of emails in percent of group.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localEmailDataFrequencyShares({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    BarItems barItems = BarItems.initial();
    int totalRelevantEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeEmail;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data.
            final EmailData emailData = field.emailData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten counter.
            totalRelevantEntries++;

            // Check if this email already has a bar item.
            final BarItem? barItem = barItems.getItemById(id: emailData.value);

            // Email does not exist --> init.
            if (barItem == null) {
              // Init BarItem.
              final BarItem barItem = BarItem.initial().copyWith(
                id: emailData.value,
                bottomTitle: emailData.value,
                yAxisValue: 1.0,
              );

              // Add to helper.
              barItems = barItems.add(barItem: barItem);

              continue;
            }

            // Update existing bar item.
            final BarItem updatedBarItem = barItem.copyWith(
              yAxisValue: barItem.yAxisValue + 1,
            );

            // Update helper.
            barItems = barItems.update(updatedBarItem: updatedBarItem);
          }
        }
      }
    }

    PieItems pieItems = PieItems.initial();
    List<Color> usedColors = [];

    // Iterate through the items and adjust percentages
    for (int i = 0; i < barItems.items.length; i++) {
      final BarItem barItem = barItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calculate percentage.
      final double percentage = (barItem.yAxisValue / totalRelevantEntries) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Create an updated PieItem
      final PieItem updatedItem = PieItem.initial().copyWith(
        id: barItem.id,
        title: '$percentageString %',
        value: percentage,
        color: color,
        legendLabel: barItem.bottomTitle,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: barItem.referenceId,
        referenceType: barItem.referenceType,
      );

      // Add the updated item to the adjusted list
      pieItems = pieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (pieItems.items.isNotEmpty) pieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return pieItems;
  }

  /// This function can be used to calculate the n frequencies of providers in percent of group.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localEmailDataProviderShares({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    BarItems barItems = BarItems.initial();
    PieItem pieItemOthers = PieItem.initial();
    int totalRelevantEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeEmail;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data.
            final EmailData emailData = field.emailData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten counter.
            totalRelevantEntries++;

            // Check if this email already has a bar item.
            final BarItem? barItem = barItems.getItemById(id: emailData.provider);

            // Email does not exist --> init.
            if (barItem == null) {
              // Init BarItem.
              final BarItem barItem = BarItem.initial().copyWith(
                id: emailData.provider,
                bottomTitle: emailData.provider,
                yAxisValue: 1.0,
              );

              // Add to helper.
              barItems = barItems.add(barItem: barItem);

              continue;
            }

            // Update existing bar item.
            final BarItem updatedBarItem = barItem.copyWith(
              yAxisValue: barItem.yAxisValue + 1,
            );

            // Update helper.
            barItems = barItems.update(updatedBarItem: updatedBarItem);
          }
        }
      }
    }

    PieItems adjustedPieItems = PieItems.initial();
    List<Color> usedColors = [];

    // Go through bar items and turn them into pie items.
    for (int i = 0; i < barItems.items.length; i++) {
      final BarItem barItem = barItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calculate percentage.
      final double percentage = (barItem.yAxisValue / totalRelevantEntries) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Check if the provider is empty.
      if (barItem.bottomTitle.isEmpty) {
        // Init PieItem.
        pieItemOthers = pieItemOthers.copyWith(
          id: barItem.id,
          title: '$percentageString %',
          value: percentage,
          color: Colors.grey,
          legendLabel: labels.basicLabelsNotSpecified(),
          legendValue: percentage,
          legendSuffix: '%',
          referenceId: barItem.referenceId,
          referenceType: barItem.referenceType,
        );

        // Add to helper.
        adjustedPieItems = adjustedPieItems.set(pieItem: pieItemOthers);

        // Continue with next item.
        continue;
      }

      // Init PieItem.
      final PieItem pieItem = PieItem.initial().copyWith(
        id: barItem.id,
        title: '$percentageString %',
        value: percentage,
        color: color,
        legendLabel: barItem.bottomTitle,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: barItem.referenceId,
        referenceType: barItem.referenceType,
      );

      // Add to helper.
      adjustedPieItems = adjustedPieItems.add(pieItem: pieItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (adjustedPieItems.items.isNotEmpty) adjustedPieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return adjustedPieItems;
  }

  // ######################################
  // # Username Data Charts
  // ######################################

  /// This function can be used to calculate the n frequencies of usernames in percent of group.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localUsernameDataUsernameDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    BarItems barItems = BarItems.initial();
    int totalRelevantEntries = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeUsername;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data.
            final UsernameData usernameData = field.usernameData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten counter.
            totalRelevantEntries++;

            // Check if this value already has a bar item.
            final BarItem? barItem = barItems.getItemById(id: usernameData.value);

            // Email does not exist --> init.
            if (barItem == null) {
              // Init BarItem.
              final BarItem barItem = BarItem.initial().copyWith(
                id: usernameData.value,
                bottomTitle: usernameData.value,
                yAxisValue: 1.0,
              );

              // Add to helper.
              barItems = barItems.add(barItem: barItem);

              continue;
            }

            // Update existing bar item.
            final BarItem updatedBarItem = barItem.copyWith(
              yAxisValue: barItem.yAxisValue + 1,
            );

            // Update helper.
            barItems = barItems.update(updatedBarItem: updatedBarItem);
          }
        }
      }
    }

    PieItems pieItems = PieItems.initial();
    List<Color> usedColors = [];

    // Iterate through the items and adjust percentages
    for (int i = 0; i < barItems.items.length; i++) {
      final BarItem barItem = barItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calculate percentage.
      final double percentage = (barItem.yAxisValue / totalRelevantEntries) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Create an updated PieItem
      final PieItem updatedItem = PieItem.initial().copyWith(
        id: barItem.id,
        title: '$percentageString %', // Update title with percentage.
        value: percentage,
        color: color,
        legendLabel: barItem.bottomTitle,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: barItem.referenceId,
        referenceType: barItem.referenceType,
      );

      // Add the updated item to the adjusted list
      pieItems = pieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (pieItems.items.isNotEmpty) pieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return pieItems;
  }

  // ######################################
  // # Avatar Image Data Charts
  // ######################################

  /// This function can be used to calculate chart about distribution of entries with and without avatar image.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localAvatarImageDataHasImageDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItems pieItems = PieItems.initial();
    int totalEntries = 0;
    int numberOfTrueValues = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Heighten total helper.
        totalEntries++;

        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeAvatarImage;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Image exists if field id was found.
            numberOfTrueValues++;
          }
        }
      }
    }

    // If there are no values to display, return initial.
    if (totalEntries == 0) return PieItems.initial();

    // Get number of false values.
    final int numberOfFalseValues = totalEntries - numberOfTrueValues;

    // Check which value to base data on.
    final bool baseOnTrue = numberOfTrueValues >= numberOfFalseValues;

    // Calculate share.
    final double firstShare = baseOnTrue ? (numberOfTrueValues / totalEntries) * 100 : (numberOfFalseValues / totalEntries) * 100;
    final double secondShare = 100 - firstShare;

    // String representations.
    final String percentageFirstString = firstShare.toStringAsFixed(2);
    final String percentageSecondString = secondShare.toStringAsFixed(2);

    // Create Pie item for the first share.
    final PieItem pieItemFirst = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.pink : Colors.deepPurple,
      title: '$percentageFirstString %',
      value: firstShare,
      legendLabel: baseOnTrue ? labels.basicLabelsImageExists() : labels.basicLabelsImageMissing(),
      legendValue: baseOnTrue ? numberOfTrueValues.toDouble() : numberOfFalseValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemFirst);

    // If firstShare is 100%, skip adding the second item.
    if (firstShare == 100) return pieItems;

    // Create Pie item for the second share.
    final PieItem pieItemSecond = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.deepPurple : Colors.pink,
      title: '$percentageSecondString %',
      value: secondShare,
      legendLabel: baseOnTrue ? labels.basicLabelsImageMissing() : labels.basicLabelsImageExists(),
      legendValue: baseOnTrue ? numberOfFalseValues.toDouble() : numberOfTrueValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemSecond);

    return pieItems;
  }

  /// This function can be used to calculate chart about distribution of entries with and without avatar image title.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localAvatarImageDataHasTitleDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItems pieItems = PieItems.initial();
    int totalEntries = 0;
    int numberOfTrueValues = 0;
    int numberOfFalseValues = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeAvatarImage;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the desired data point.
            final AvatarImageData avatarImage = field.avatarImageData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten total helper.
            totalEntries++;

            if (avatarImage.image!.title.isEmpty) numberOfFalseValues++;
            if (avatarImage.image!.title.isNotEmpty) numberOfTrueValues++;
          }
        }
      }
    }

    // If there are no values to display, return initial.
    if (totalEntries == 0) return PieItems.initial();

    // Check which value to base data on.
    final bool baseOnTrue = numberOfTrueValues >= numberOfFalseValues;

    // Calculate share.
    final double firstShare = baseOnTrue ? (numberOfTrueValues / totalEntries) * 100 : (numberOfFalseValues / totalEntries) * 100;
    final double secondShare = 100 - firstShare;

    // String representations.
    final String percentageFirstString = firstShare.toStringAsFixed(2);
    final String percentageSecondString = secondShare.toStringAsFixed(2);

    // Create Pie item for the first share.
    final PieItem pieItemFirst = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.green : Colors.red,
      title: '$percentageFirstString %',
      value: firstShare,
      legendLabel: baseOnTrue ? labels.basicLabelsTitleExists() : labels.basicLabelsTitleMissing(),
      legendValue: baseOnTrue ? numberOfTrueValues.toDouble() : numberOfFalseValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemFirst);

    // If firstShare is 100%, skip adding the second item.
    if (firstShare == 100) return pieItems;

    // Create Pie item for the second share.
    final PieItem pieItemSecond = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.green : Colors.red,
      title: '$percentageSecondString %',
      value: secondShare,
      legendLabel: baseOnTrue ? labels.basicLabelsTitleMissing() : labels.basicLabelsImageExists(),
      legendValue: baseOnTrue ? numberOfFalseValues.toDouble() : numberOfTrueValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemSecond);

    return pieItems;
  }

  /// This function can be used to calculate chart about distribution of entries with and without avatar image text.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localAvatarImageDataHasTextDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItems pieItems = PieItems.initial();
    int totalEntries = 0;
    int numberOfTrueValues = 0;
    int numberOfFalseValues = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeAvatarImage;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the desired data point.
            final AvatarImageData avatarImage = field.avatarImageData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten total helper.
            totalEntries++;

            if (avatarImage.image!.caption.isEmpty) numberOfFalseValues++;
            if (avatarImage.image!.caption.isNotEmpty) numberOfTrueValues++;
          }
        }
      }
    }

    // If there are no values to display, return initial.
    if (totalEntries == 0) return PieItems.initial();

    // Check which value to base data on.
    final bool baseOnTrue = numberOfTrueValues >= numberOfFalseValues;

    // Calculate share.
    final double firstShare = baseOnTrue ? (numberOfTrueValues / totalEntries) * 100 : (numberOfFalseValues / totalEntries) * 100;
    final double secondShare = 100 - firstShare;

    // String representations.
    final String percentageFirstString = firstShare.toStringAsFixed(2);
    final String percentageSecondString = secondShare.toStringAsFixed(2);

    // Create Pie item for the first share.
    final PieItem pieItemFirst = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.green : Colors.red,
      title: '$percentageFirstString %',
      value: firstShare,
      legendLabel: baseOnTrue ? labels.basicLabelsTextExists() : labels.basicLabelsTextMissing(),
      legendValue: baseOnTrue ? numberOfTrueValues.toDouble() : numberOfFalseValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemFirst);

    // If firstShare is 100%, skip adding the second item.
    if (firstShare == 100) return pieItems;

    // Create Pie item for the second share.
    final PieItem pieItemSecond = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.green : Colors.red,
      title: '$percentageSecondString %',
      value: secondShare,
      legendLabel: baseOnTrue ? labels.basicLabelsTextMissing() : labels.basicLabelsTextExists(),
      legendValue: baseOnTrue ? numberOfFalseValues.toDouble() : numberOfTrueValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemSecond);

    return pieItems;
  }

  // ######################################
  // # Date of birth Data Charts
  // ######################################

  /// This function can be used to calculate chart about seasonal distribution of birthdays.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localDateOfBirthDataSeasonalDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItems pieItems = PieItems.seasonal();
    int totalRelevantFields = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeDateOfBirth;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the desired data point.
            final DateOfBirthData dateOfBirthData = field.dateOfBirthData!;

            // Get the month of the DateTime object as a string
            final String yearAsString = DateFormat('yyyy').format(dateOfBirthData.value!).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten total helper.
            totalRelevantFields++;

            // Get season.
            final String season = dateOfBirthData.getSeason;

            // Access item.
            final PieItem item = pieItems.getItemById(id: season)!;

            // Update item.
            final PieItem updatedItem = item.copyWith(
              value: item.value + 1,
            );

            // Update pie items.
            pieItems = pieItems.update(updatedPieItem: updatedItem);
          }
        }
      }
    }

    // If there are no values to display, return initial.
    if (totalRelevantFields == 0) return PieItems.initial();

    PieItems adjustedPieItems = PieItems.initial();

    // Go through pie items and caluclate percentage.
    for (int i = 0; i < pieItems.items.length; i++) {
      final PieItem pieItem = pieItems.items[i];

      // Calculate percentage.
      final double percentage = (pieItem.value / totalRelevantFields) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Create an updated PieItem
      final PieItem updatedItem = pieItem.copyWith(
        title: '$percentageString %',
        value: percentage,
        legendValue: percentage,
        legendSuffix: '%',
      );

      // Add the updated item to the adjusted list
      adjustedPieItems = adjustedPieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (adjustedPieItems.items.isNotEmpty) adjustedPieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return adjustedPieItems;
  }

  /// This function can be used to calculate chart about number of birthdays per month.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localDateOfBirthDataBirthdaysPerMonth({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.monthly();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeDateOfBirth;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final DateOfBirthData dateOfBirthData = field.dateOfBirthData!;

            // Get the month of the DateTime object as a string
            final String monthAsString = DateFormat('MMMM').format(dateOfBirthData.value!).toLowerCase();
            final String yearAsString = DateFormat('yyyy').format(dateOfBirthData.value!).toLowerCase();

            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Access correct bar item id.
            final String barItemId = monthAsString;

            // Access BarItem of id.
            final BarItem barItem = barItems.getItemById(id: barItemId)!;

            // Calculate yAxisValue.
            final double yAxisValue = barItem.yAxisValue + 1;

            // Update BarItem.
            final BarItem udpated = barItem.copyWith(
              topTitle: yAxisValue.toStringAsFixed(0),
              yAxisValue: yAxisValue,
            );

            // Update BarItems.
            barItems = barItems.update(updatedBarItem: udpated);
          }
        }
      }
    }

    return barItems;
  }

  /// This method can be used to access the entries with the next upcoming birthday.
  /// * Entries is used because there might be more then one birthday on the same day.
  /// * This method cycles through entries with offset and limit.
  Future<List<FieldToEntry>> getLocalNextBirthdayEntries({required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    List<FieldToEntry> upcomingBirthdays = [];

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeDateOfBirth;

          if (isDesiredField) {
            // Access the shared expense.
            final DateOfBirthData dateOfBirthData = field.dateOfBirthData!;

            final int daysUntilBirthday = dateOfBirthData.getDaysUntilBirthday!;

            if (daysUntilBirthday < 4 * 30) {
              // Create FieldToEntry helper.
              final FieldToEntry fieldToEntry = FieldToEntry.initial().copyWith(
                entryId: entry.entryId,
                entryName: entry.entryName,
                field: field,
              );

              // Add to list.
              upcomingBirthdays.add(fieldToEntry);
            }
          }
        }
      }
    }

    // Sort the upcomingBirthdays list by the next birthday
    upcomingBirthdays.sort((a, b) {
      final int diffA = a.field!.dateOfBirthData!.getDaysUntilBirthday!;
      final int diffB = b.field!.dateOfBirthData!.getDaysUntilBirthday!;
      return diffA.compareTo(diffB);
    });

    return upcomingBirthdays;
  }

  // ######################################
  // # Money Data Charts
  // ######################################

  /// This method can be used to calculate the numerical progression accumulated.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<LineItems> localMoneyDataGetNumericalProgressionAccumulated({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String defaultCurrencyCode, required Secrets? secrets}) async {
    // Make sure that a default currency was supplied.
    // * Return initial to trigger chart replacement message instead of throwing failure, because
    // * on failure there is a retry button, with chart replacement there is not.
    if (defaultCurrencyCode.isEmpty) return LineItems.initial();

    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    LineDots lineDotsTotal = LineDots.initial();
    double yAxisValueTotal = 0.0;
    int counter = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
        descending: false,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // heighten counter.
        counter++;

        for (final Field field in entry.fields.items) {
          // Only consider relevant field.
          if (field.getIsMoneyField == false) continue;

          // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access data.
          final MoneyData moneyData = field.moneyData!;

          // Get the month of the DateTime object as a string.
          // * Filter in utc, display stuff in local.
          final String yearAsString = DateFormat('yyyy').format(moneyData.createdAtInUtc!).toLowerCase();
          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: moneyData.customExchangeRates,
            exchangeRateDateInUtc: moneyData.createdAtInUtc!,
            fromCurrencyCode: moneyData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: moneyData.currencyCode, to: defaultCurrencyCode);

          // Calculate y axis values.
          yAxisValueTotal = yAxisValueTotal + (moneyData.valueAsDouble * exchangeRateToDefault);

          // Create line dot
          final LineDot lineDotTotal = LineDot.initial().copyWith(
            xAxisValue: (counter + 1).toDouble(),
            yAxisValue: yAxisValueTotal,
          );

          // Add to helper.
          lineDotsTotal = lineDotsTotal.add(lineDot: lineDotTotal);
        }
      }
    }

    // Get accumulated value.
    final double sum = lineDotsTotal.items.isEmpty ? 0.0 : lineDotsTotal.items.last.yAxisValue;

    // Create LineItem.
    final LineItem lineItemTotal = LineItem.initial().copyWith(
      lineDots: lineDotsTotal,
      enableBelowLine: true,
      color: Colors.deepPurple,
      legendLabel: labels.basicLabelsAccumulated(),
      legendValue: sum,
    );

    // Create LineItems.
    final LineItems lineItems = LineItems(
      items: [
        lineItemTotal,
      ],
    );

    return lineItems;
  }

  /// This method can be used to calculate the absolut income over time.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localMoneyDataIncomeOverTime({required String timeInterval, required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Convenience variables to check time interval.
    final bool isYearly = timeInterval == PickerItem.intervalYearly;
    final bool isMonthly = timeInterval == PickerItem.intervalMonthly;
    final bool isDaily = isYearly == false && isMonthly == false;

    // Init bar helper.
    BarItems barItems = isYearly
        ? BarItems.yearly(barColor: Colors.green)
        : isMonthly
            ? BarItems.monthly(barColor: Colors.green)
            : BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Only consider relevant field.
          if (field.getIsMoneyField == false) continue;

          // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access the shared expense.
          final MoneyData moneyData = field.moneyData!;

          // If value is not positive, continue.
          if (moneyData.valueAsDouble <= 0) continue;

          // Get the month of the DateTime object as a string.
          // * Filter in utc but display stuff in local.
          final String monthAsString = DateFormat('MMMM').format(moneyData.createdAtInUtc!).toLowerCase();
          final String yearAsString = DateFormat('yyyy').format(moneyData.createdAtInUtc!).toLowerCase();
          final String dayAsString = DateFormat('yyyy-MM-dd').format(moneyData.createdAtInUtc!).toLowerCase();

          final String filterByYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != filterByYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: moneyData.customExchangeRates,
            exchangeRateDateInUtc: moneyData.createdAtInUtc!,
            fromCurrencyCode: moneyData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: moneyData.currencyCode, to: defaultCurrencyCode);

          // Access correct bar item id.
          final String barItemId = isMonthly
              ? monthAsString
              : isYearly
                  ? yearAsString
                  : dayAsString;

          // Access BarItem of id.
          BarItem? barItem = barItems.getItemById(id: barItemId);

          // If filter is set to daily and BarItem was not found, init.
          if (barItem == null && isDaily) {
            barItem = BarItem.initial().copyWith(
              id: barItemId,
              // This is done to show the year if all values should be displayed because more then one year can be shown.
              bottomTitle: DateFormat(filterByYear == null ? 'yyyy-MM-dd' : 'MM-dd').format(moneyData.createdAtInUtc!.toLocal()),
              barColor: Colors.green,
            );
          }

          // If filter is NOT set to daily and BarItem was not found, an error occurred.
          if (barItem == null && isDaily == false) throw Failure.genericError();

          // If bar item is still null, an error occurred.
          if (barItem == null) throw Failure.genericError();

          // Calculate new yAxisValue.
          final double yAxisValue = barItem.yAxisValue + (moneyData.valueAsDouble * exchangeRateToDefault);

          // Update BarItem.
          final BarItem udpated = barItem.copyWith(
            topTitle: yAxisValue.toStringAsFixed(2),
            yAxisValue: yAxisValue,
          );

          // Update BarItems.
          barItems = barItems.set(barItem: udpated);
        }
      }
    }

    return barItems;
  }

  /// This function can be used to calculate chart about expnese categories.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localMoneyDataIncomeByCategory({required DateTime? filterByYear, required String defaultCurrencyCode, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItem untagged = PieItem.initial().copyWith(
      title: labels.basicLabelsNotTagged(),
      referenceId: filterByFieldId.isEmpty ? Field.fieldTypeMoney : filterByFieldId,
      referenceType: filterByFieldId.isEmpty ? 'untagged_by_field_type' : 'untagged_by_field_id',
    );

    PieItems pieItems = PieItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Only consider desired field.
          if (field.getIsMoneyField == false) continue;

          // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access the desired data point.
          final MoneyData moneyData = field.moneyData!;

          // Only consider income.
          if (moneyData.valueAsDouble <= 0) continue;

          // Get the month of the DateTime object as a string.
          // * Filter in utc, but display stuff in local.
          final String yearAsString = DateFormat('yyyy').format(moneyData.createdAtInUtc!).toLowerCase();
          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: moneyData.customExchangeRates,
            exchangeRateDateInUtc: moneyData.createdAtInUtc!,
            fromCurrencyCode: moneyData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: moneyData.currencyCode, to: defaultCurrencyCode);

          // Get value.
          final double convertedValue = moneyData.valueAsDouble.abs() * exchangeRateToDefault;

          // If a value is not tagged, create a pie item for those values.
          if (moneyData.tagsData.tagReferences.isEmpty) {
            // Get value.
            final double value = untagged.value + convertedValue;

            // Update pie item
            untagged = untagged.copyWith(
              value: value,
            );

            continue;
          }

          // Tags are present, calculate proportional allocation.
          final double tagShare = convertedValue / moneyData.tagsData.tagReferences.length;

          // Go through tags and add them with value.
          for (final String tagRef in moneyData.tagsData.tagReferences) {
            // Get tag.
            Tag? tag = await getLocalTagById(
              tagId: tagRef,
            );

            // If tag is unknown, create a unknown tag.
            tag ??= Tag.initial().copyWith(tagId: tagRef, label: labels.unknownTag());

            // Access pie item.
            PieItem? pieItem = pieItems.getItemById(
              id: tagRef,
            );

            // Item not found, add initial.
            pieItem ??= PieItem.initial().copyWith(id: tagRef, title: tag.label);

            // Calculate y_axis_value.
            final double value = pieItem.value + tagShare;

            // Update pie item
            pieItem = pieItem.copyWith(
              value: value,
              referenceType: 'tag',
              referenceId: tagRef,
            );

            // Update PieItems.
            pieItems = pieItems.set(pieItem: pieItem);
          }
        }
      }
    }

    // Add untagged if needed.
    if (untagged.value != 0) pieItems = pieItems.add(pieItem: untagged);

    // Access the total.
    final double sum = pieItems.pieItemsSum();

    // If there are no values to display, return initial.
    if (sum == 0) return PieItems.initial();

    PieItems adjustedPieItems = PieItems.initial();
    List<Color> usedColors = [];

    // Iterate through the items and adjust percentages
    for (int i = 0; i < pieItems.items.length; i++) {
      final PieItem pieItem = pieItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calculate percentage.
      final double percentage = (pieItem.value / sum) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Create an updated PieItem
      final PieItem updatedItem = pieItem.copyWith(
        title: '$percentageString %',
        value: percentage,
        color: color,
        legendLabel: pieItem.title,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: pieItem.referenceId,
        referenceType: pieItem.referenceType,
      );

      // Add the updated item to the adjusted list
      adjustedPieItems = adjustedPieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (adjustedPieItems.items.isNotEmpty) adjustedPieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return adjustedPieItems;
  }

  /// This method can be used to calculate the absolut expense over time.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localMoneyDataExpensesOverTime({required String timeInterval, required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Convenience variables to check time interval.
    final bool isYearly = timeInterval == PickerItem.intervalYearly;
    final bool isMonthly = timeInterval == PickerItem.intervalMonthly;
    final bool isDaily = isYearly == false && isMonthly == false;

    // Init bar helper.
    BarItems barItems = isYearly
        ? BarItems.yearly(barColor: Colors.red)
        : isMonthly
            ? BarItems.monthly(barColor: Colors.red)
            : BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          if (field.getIsMoneyField == false) continue;

          // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access the shared expense.
          final MoneyData moneyData = field.moneyData!;

          // If value is not negative, continue.
          if (moneyData.valueAsDouble >= 0) continue;

          // Get the month of the DateTime object as a string.
          // * Filter in utc, but display stuff in local.
          final String monthAsString = DateFormat('MMMM').format(moneyData.createdAtInUtc!).toLowerCase();
          final String yearAsString = DateFormat('yyyy').format(moneyData.createdAtInUtc!).toLowerCase();
          final String dayAsString = DateFormat('yyyy-MM-dd').format(moneyData.createdAtInUtc!).toLowerCase();

          final String filterByYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != filterByYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: moneyData.customExchangeRates,
            exchangeRateDateInUtc: moneyData.createdAtInUtc!,
            fromCurrencyCode: moneyData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: moneyData.currencyCode, to: defaultCurrencyCode);

          // Access correct bar item id.
          final String barItemId = isMonthly
              ? monthAsString
              : isYearly
                  ? yearAsString
                  : dayAsString;

          // Access BarItem of id.
          BarItem? barItem = barItems.getItemById(id: barItemId);

          // If filter is set to daily and BarItem was not found, init.
          if (barItem == null && isDaily) {
            barItem = BarItem.initial().copyWith(
              id: barItemId,
              // This is done to show the year if all values should be displayed because more then one year can be shown.
              bottomTitle: DateFormat(filterByYear == null ? 'yyyy-MM-dd' : 'MM-dd').format(moneyData.createdAtInUtc!.toLocal()),
              barColor: Colors.red,
            );
          }

          // If filter is NOT set to daily and BarItem was not found, an error occurred.
          if (barItem == null && isDaily == false) throw Failure.genericError();

          // If bar item is still null, an error occurred.
          if (barItem == null) throw Failure.genericError();

          // Calculate new yAxisValue.
          final double yAxisValue = barItem.yAxisValue + (moneyData.valueAsDouble.abs() * exchangeRateToDefault);

          // Update BarItem.
          final BarItem udpated = barItem.copyWith(
            topTitle: yAxisValue.toStringAsFixed(2),
            yAxisValue: yAxisValue,
          );

          // Update BarItems.
          barItems = barItems.set(barItem: udpated);
        }
      }
    }

    return barItems;
  }

  /// This function can be used to calculate chart about expnese categories.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localMoneyDataExpensesByCategory({required DateTime? filterByYear, required String defaultCurrencyCode, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItem untagged = PieItem.initial().copyWith(
      title: labels.basicLabelsNotTagged(),
      referenceId: filterByFieldId.isEmpty ? Field.fieldTypeMoney : filterByFieldId,
      referenceType: filterByFieldId.isEmpty ? 'untagged_by_field_type' : 'untagged_by_field_id',
    );

    PieItems pieItems = PieItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Only consider desired field.
          if (field.getIsMoneyField == false) continue;

          // In case a fieldId was supplied, make sure that only money fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access the desired data point.
          final MoneyData moneyData = field.moneyData!;

          // Only consider expenses.
          if (moneyData.valueAsDouble >= 0) continue;

          // Get the month of the DateTime object as a string.
          // * Filter in utc, but display stuff in local.
          final String yearAsString = DateFormat('yyyy').format(moneyData.createdAtInUtc!).toLowerCase();
          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: moneyData.customExchangeRates,
            exchangeRateDateInUtc: moneyData.createdAtInUtc!,
            fromCurrencyCode: moneyData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: moneyData.currencyCode, to: defaultCurrencyCode);

          // Get value.
          final double convertedValue = moneyData.valueAsDouble.abs() * exchangeRateToDefault;

          // If a value is not tagged, create a pie item for those values.
          if (moneyData.tagsData.tagReferences.isEmpty) {
            // Get value.
            final double value = untagged.value + convertedValue;

            // Update pie item
            untagged = untagged.copyWith(
              value: value,
            );

            continue;
          }

          // Tags are present, calculate proportional allocation.
          final double tagShare = convertedValue / moneyData.tagsData.tagReferences.length;

          // Go through tags and add them with value.
          for (final String tagRef in moneyData.tagsData.tagReferences) {
            // Get tag.
            Tag? tag = await getLocalTagById(
              tagId: tagRef,
            );

            // If tag is unknown, create a unknown tag.
            tag ??= Tag.initial().copyWith(tagId: tagRef, label: labels.unknownTag());

            // Access pie item.
            PieItem? pieItem = pieItems.getItemById(
              id: tagRef,
            );

            // Item not found, add initial.
            pieItem ??= PieItem.initial().copyWith(id: tagRef, title: tag.label);

            // Calculate y_axis_value.
            final double value = pieItem.value + tagShare;

            // Update pie item
            pieItem = pieItem.copyWith(
              value: value,
              referenceType: 'tag',
              referenceId: tagRef,
            );

            // Update PieItems.
            pieItems = pieItems.set(pieItem: pieItem);
          }
        }
      }
    }

    // Add untagged if needed.
    if (untagged.value != 0) pieItems = pieItems.add(pieItem: untagged);

    // Access the total.
    final double sum = pieItems.pieItemsSum();

    // If there are no values to display, return initial.
    if (sum == 0) return PieItems.initial();

    PieItems adjustedPieItems = PieItems.initial();
    List<Color> usedColors = [];

    // Iterate through the items and adjust percentages
    for (int i = 0; i < pieItems.items.length; i++) {
      final PieItem pieItem = pieItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calculate percentage.
      final double percentage = (pieItem.value / sum) * 100;

      // String representation.
      final String percentageString = percentage.toStringAsFixed(2);

      // Create an updated PieItem
      final PieItem updatedItem = pieItem.copyWith(
        title: '$percentageString %',
        value: percentage,
        color: color,
        legendLabel: pieItem.title,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: pieItem.referenceId,
        referenceType: pieItem.referenceType,
      );

      // Add the updated item to the adjusted list
      adjustedPieItems = adjustedPieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (adjustedPieItems.items.isNotEmpty) adjustedPieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return adjustedPieItems;
  }

  /// This method can be used to calculate values by entry.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localMoneyDataValuesByEntry({required DateTime? filterByYear, required String groupId, required String defaultCurrencyCode, required String filterByFieldId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Only consider relevant field.
          if (field.getIsMoneyField == false) continue;

          // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Access the shared expense.
          final MoneyData moneyData = field.moneyData!;

          // Get the month of the DateTime object as a string
          final String yearAsString = DateFormat('yyyy').format(moneyData.createdAtInUtc!).toLowerCase();

          final String filterByYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != filterByYearAsString) continue;

          // Access exchange rate if needed.
          final Map<String, dynamic> exchangeRateMap = await getExchangeRate(
            customExchangeRates: moneyData.customExchangeRates,
            exchangeRateDateInUtc: moneyData.createdAtInUtc!,
            fromCurrencyCode: moneyData.currencyCode,
            toCurrencyCode: defaultCurrencyCode,
          );

          // Convenience variables.
          final double? exchangeRateToDefault = exchangeRateMap['exchange_rate'];

          // Could not find exchange rate, which means total cannot be accurately calculated.
          if (exchangeRateToDefault == null || exchangeRateToDefault == 0.0) throw Failure.exchangeRateNotFound(from: moneyData.currencyCode, to: defaultCurrencyCode);

          // Calculate new yAxisValue.
          final double yAxisValue = moneyData.valueAsDouble * exchangeRateToDefault;

          // Init bar item.
          final BarItem barItem = BarItem.initial().copyWith(
            topTitle: yAxisValue.toStringAsFixed(2),
            bottomTitle: entry.entryName,
            barColor: yAxisValue < 0 ? Colors.red : Colors.green,
            yAxisValue: yAxisValue.abs(), // * Use absolute value to ensure that bars always go upwards.
          );

          // Update BarItems.
          barItems = barItems.add(barItem: barItem);
        }
      }
    }

    return barItems;
  }

  /// This function can be used to calculate chart about currency distribution.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localMoneyDataCurrencyDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItems pieItems = PieItems.initial();
    int totalRelevantFields = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeMoney;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the desired data point.
            final MoneyData moneyData = field.moneyData!;

            // Get the month of the DateTime object as a string.
            // * Filter in utc, but display stuff in local.
            final String yearAsString = DateFormat('yyyy').format(moneyData.createdAtInUtc!).toLowerCase();
            final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

            // Only consider item if it falls into date range.
            // If filterByYear is set to null, consider all years.
            if (filterByYear != null && yearAsString != selectedYearAsString) continue;

            // Heighten total.
            totalRelevantFields++;

            // Get pie item.
            final PieItem? pieItem = pieItems.getItemById(id: moneyData.currencyCode);

            // PieItem not found, init.
            if (pieItem == null) {
              // Init new pie item.
              final PieItem pieItemInitial = PieItem.initial().copyWith(
                id: moneyData.currencyCode,
                legendLabel: moneyData.currencyCode,
                value: 1,
              );

              // Add to list.
              pieItems = pieItems.add(pieItem: pieItemInitial);

              continue;
            }

            // Update item.
            final PieItem updatedItem = pieItem.copyWith(
              value: pieItem.value + 1,
            );

            // Update pie items.
            pieItems = pieItems.update(updatedPieItem: updatedItem);
          }
        }
      }
    }

    // If there are no values to display, return initial.
    if (totalRelevantFields == 0) return PieItems.initial();

    // Updated pie items.
    PieItems updatedPieItems = PieItems.initial();
    List<Color> previousColors = [];

    // Go through pie items and caluclate percentage.
    for (final PieItem pieItem in pieItems.items) {
      // Get a random color from available colors.
      final Color color = getNextColorFromAvailableColors(
        previousColors: previousColors,
      );

      // Add used color.
      previousColors.add(color);

      // Calculate values.
      final double percentage = (pieItem.value / totalRelevantFields) * 100;
      final String percentageString = percentage.toStringAsFixed(2);

      // Updated item.
      final PieItem updated = pieItem.copyWith(
        title: '$percentageString %',
        value: percentage,
        color: color,
        legendValue: percentage,
        legendSuffix: '%',
      );

      // Add to list.
      updatedPieItems = updatedPieItems.add(pieItem: updated);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (updatedPieItems.items.isNotEmpty) updatedPieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return updatedPieItems;
  }

  // ######################################
  // Tags Data Charts
  // ######################################

  /// This function can be used to calculate chart entries by category.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localTagsDataEntriesByTag({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();
    BarItem untagged = BarItem.initial().copyWith(
      bottomTitle: labels.basicLabelsNotTagged(),
      referenceId: filterByFieldId.isEmpty ? Field.fieldTypeTags : filterByFieldId,
      referenceType: filterByFieldId.isEmpty ? 'untagged_by_field_type' : 'untagged_by_field_id',
    );

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Helper to track untagged entries.
        bool isNotTagged = true;

        for (final Field field in entry.fields.items) {
          // Only consider desired field.
          if (field.getIsTagsField == false) continue;

          // In case a fieldId was supplied, make sure that only fields that have this fieldId are considered.
          if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

          // Update flag.
          isNotTagged = false;

          // Access the shared expense.
          final TagsData tagsData = field.tagsData!;

          // Get the month of the DateTime object as a string
          final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
          final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

          // Only consider item if it falls into date range.
          // If filterByYear is set to null, consider all years.
          if (filterByYear != null && yearAsString != selectedYearAsString) continue;

          // Go through tags and add them with value.
          for (final String tagRef in tagsData.tagReferences) {
            // Get tag.
            Tag? tag = await getLocalTagById(
              tagId: tagRef,
            );

            // If tag is unknown, create a unknown tag.
            tag ??= Tag.initial().copyWith(tagId: tagRef, label: labels.unknownTag());

            // Access bar item.
            BarItem? barItem = barItems.getItemById(
              id: tagRef,
            );

            // Item not found, add initial.
            barItem ??= BarItem.initial().copyWith(id: tagRef, bottomTitle: tag.label);

            // Get value.
            final double yAxisValue = barItem.yAxisValue + 1;

            // Update bar item
            barItem = barItem.copyWith(
              yAxisValue: yAxisValue,
              referenceId: tagRef,
              referenceType: 'tag',
            );

            // Update BarItems.
            barItems = barItems.set(barItem: barItem);
          }
        }

        // If flag is set, update untagged.
        if (isNotTagged) {
          // Get value.
          final double value = untagged.yAxisValue + 1;

          // Update pie item
          untagged = untagged.copyWith(
            yAxisValue: value,
          );
        }
      }
    }

    // Add untagged if needed.
    if (untagged.yAxisValue != 0) barItems = barItems.add(barItem: untagged);

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (barItems.items.isNotEmpty) barItems.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItems;
  }

  /// This method can be used to calculate entry shares by tag.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localTagsDataEntrySharesByTag({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Calculate costs by tag.
    final BarItems barItems = await localTagsDataEntriesByTag(
      filterByFieldId: filterByFieldId,
      filterByYear: filterByYear,
      groupId: groupId,
      secrets: secrets,
    );

    // Get total entries.
    final double sum = barItems.getYAxisValueSum;

    // If there are no values to display, return initial.
    if (sum == 0) return PieItems.initial();

    PieItems adjustedPieItems = PieItems.initial();
    List<Color> usedColors = [];
    double accumulatedPercentage = 0.0;

    // Iterate through the items and adjust percentages
    for (int i = 0; i < barItems.items.length; i++) {
      final BarItem barItem = barItems.items[i];

      // Assign a unique color for visualization
      final Color color = getNextColorFromAvailableColors(previousColors: usedColors);
      usedColors.add(color);

      // Calculate the percentage
      double percentage;
      if (i == barItems.items.length - 1) {
        // Adjust the last item's percentage to ensure the total is 100%.
        percentage = 100.0 - accumulatedPercentage;
      } else {
        percentage = (barItem.yAxisValue / sum) * 100;
        percentage = double.parse(percentage.toStringAsFixed(2)); // Round to 2 decimals.
        accumulatedPercentage += percentage;
      }

      // Create an updated PieItem
      final PieItem updatedItem = PieItem.initial().copyWith(
        id: barItem.id,
        title: percentage.toStringAsFixed(2), // Update title with percentage.
        value: percentage,
        color: color,
        legendLabel: barItem.bottomTitle,
        legendValue: percentage,
        legendSuffix: '%',
        referenceId: barItem.referenceId,
        referenceType: barItem.referenceType,
      );

      // Add the updated item to the adjusted list
      adjustedPieItems = adjustedPieItems.add(pieItem: updatedItem);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (adjustedPieItems.items.isNotEmpty) adjustedPieItems.items.sort((a, b) => b.value.compareTo(a.value));

    return adjustedPieItems;
  }

  // ######################################
  // Emotion Data Charts
  // ######################################

  /// This method can be used to calculate entry shares by tag.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<PieItems> localEmotionDataPositiveAndNegativeDistribution({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helpers.
    PieItems pieItems = PieItems.initial();
    int totalEntries = 0;
    int numberOfPositiveValues = 0;
    int numberOfNegativeValues = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeEmotion;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the desired data point.
            final EmotionData emotionData = field.emotionData!;

            for (final EmotionItem emotionItem in emotionData.emotions) {
              // Get the year of the DateTime object as a string
              final String yearAsString = emotionItem.getOccurence(preserveUtc: false, format: 'yyyy').toLowerCase();
              final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

              // Only consider item if it falls into date range.
              // If filterByYear is set to null, consider all years.
              if (filterByYear != null && yearAsString != selectedYearAsString) continue;

              // Check if this emotion is positive.
              final bool isPositiveEmotion = emotionData.isPositiveEmotion(emotionItem: emotionItem);
              final bool isNegativeEmotion = emotionData.isNegativeEmotion(emotionItem: emotionItem);

              if (isPositiveEmotion) {
                numberOfPositiveValues++;

                // Heighten total helper.
                totalEntries++;

                continue;
              }

              if (isNegativeEmotion) {
                numberOfNegativeValues++;

                // Heighten total helper.
                totalEntries++;

                continue;
              }
            }
          }
        }
      }
    }

    // If there are no values to display, return initial.
    if (totalEntries == 0) return PieItems.initial();

    // Check which value to base data on.
    final bool baseOnTrue = numberOfPositiveValues >= numberOfNegativeValues;

    // Calculate share.
    double firstShare = baseOnTrue ? (numberOfPositiveValues / totalEntries) * 100 : (numberOfNegativeValues / totalEntries) * 100;
    double secondShare = 100 - firstShare;

    // Adjust for rounding errors.
    final double roundingError = 100 - (firstShare + secondShare);
    if (roundingError != 0) {
      if (firstShare >= secondShare) {
        firstShare += roundingError;
      } else {
        secondShare += roundingError;
      }
    }

    // Create Pie item for the first share.
    final PieItem pieItemFirst = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.green : Colors.red,
      legendLabel: baseOnTrue ? labels.basicLabelsPositiveEmotion() : labels.basicLabelsNegativeEmotion(),
      title: '${firstShare.toStringAsFixed(2)} %',
      value: firstShare,
      legendValue: baseOnTrue ? numberOfPositiveValues.toDouble() : numberOfNegativeValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemFirst);

    // If firstShare is 100%, skip adding the second item.
    if (firstShare == 100) return pieItems;

    // Create Pie item for the second share.
    final PieItem pieItemSecond = PieItem.initial().copyWith(
      color: baseOnTrue ? Colors.red : Colors.green,
      legendLabel: baseOnTrue ? labels.basicLabelsNegativeEmotion() : labels.basicLabelsPositiveEmotion(),
      title: '${secondShare.toStringAsFixed(2)} %',
      value: secondShare,
      legendValue: baseOnTrue ? numberOfNegativeValues.toDouble() : numberOfPositiveValues.toDouble(),
    );

    // Add to pieItems.
    pieItems = pieItems.add(pieItem: pieItemSecond);

    return pieItems;
  }

  /// This function can be used to calculate chart average intensity by emotion.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localEmotionDataAverageIntensityByEmotion({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeEmotion;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data point.
            final EmotionData emotionData = field.emotionData!;

            // Go through emotions.
            for (final EmotionItem emotionItem in emotionData.emotions) {
              // Get the year of the DateTime object as a string.
              final String yearAsString = emotionItem.getOccurence(preserveUtc: false, format: 'yyyy').toLowerCase();
              final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

              // Only consider item if it falls into date range.
              // If filterByYear is set to null, consider all years.
              if (filterByYear != null && yearAsString != selectedYearAsString) continue;

              // Access BarItem.
              final BarItem? barItem = barItems.getItemById(id: emotionItem.emotion);

              // Item not found, init.
              if (barItem == null) {
                // Init bar item.
                final BarItem barItem = BarItem.initial().copyWith(
                  id: emotionItem.emotion,
                  barColor: Colors.deepPurple,
                  bottomTitle: EmotionData.emotionsByTypeAndLanguage()[emotionItem.emotion],
                  // * TopTitle is used to track the total number of this specific emotion. Will be overwritten later.
                  topTitle: '1',
                  yAxisValue: emotionItem.intensity!.toDouble(),
                );

                barItems = barItems.add(barItem: barItem);

                continue;
              }

              // * Item found, update.

              // Calculate new yAxisValue.
              final double yAxisValue = barItem.yAxisValue + emotionItem.intensity!;

              // Heighten total.
              // * TopTitle is used to track the total number of this specific emotion. Will be overwritten later.
              final int total = int.parse(barItem.topTitle) + 1;

              // Update bar item.
              final BarItem updatedBarItem = barItem.copyWith(
                topTitle: total.toString(),
                yAxisValue: yAxisValue,
              );

              barItems = barItems.update(updatedBarItem: updatedBarItem);
            }
          }
        }
      }
    }

    // Init bar helper.
    BarItems barItemsFinal = BarItems.initial();

    // * Go through barItems to calculate average and overwrite topTitle.
    for (final BarItem barItem in barItems.items) {
      // Calculate average.
      final double average = barItem.yAxisValue / int.parse(barItem.topTitle);

      // Update barItem.
      final BarItem updated = barItem.copyWith(
        topTitle: average.toStringAsFixed(2),
        yAxisValue: average,
      );

      // Add to helper.
      barItemsFinal = barItemsFinal.add(barItem: updated);
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    // * And for some performance gains list with one item dont need to be sorted.
    if (barItemsFinal.items.length >= 2) barItemsFinal.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItemsFinal;
  }

  /// This function can be used to calculate chart average wellbeing.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localEmotionDataAverageWellbeing({required String timeInterval, required DateTime? filterByYear, required String filterByFieldId, required String groupId, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Convenience variables to check time interval.
    final bool isYearly = timeInterval == PickerItem.intervalYearly;
    final bool isMonthly = timeInterval == PickerItem.intervalMonthly;
    final bool isDaily = isYearly == false && isMonthly == false;

    // Init bar helper.
    BarItems barItems = isYearly
        ? BarItems.yearly()
        : isMonthly
            ? BarItems.monthly()
            : BarItems.initial();

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeEmotion;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access the shared expense.
            final EmotionData emotionData = field.emotionData!;

            // Go through emotions.
            for (final EmotionItem emotionItem in emotionData.emotions) {
              // Get the DateTime object as a string
              final String monthAsString = emotionItem.getOccurence(preserveUtc: false, format: 'MMMM').toLowerCase();
              final String yearAsString = emotionItem.getOccurence(preserveUtc: false, format: 'yyyy').toLowerCase();
              final String dayAsString = emotionItem.getOccurence(preserveUtc: false, format: 'yyyy-MM-dd').toLowerCase();

              final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

              // Only consider item if it falls into date range.
              // If filterByYear is set to null, consider all years.
              if (filterByYear != null && yearAsString != selectedYearAsString) continue;

              // Access correct bar item id.
              final String barItemId = isMonthly
                  ? monthAsString
                  : isYearly
                      ? yearAsString
                      : dayAsString;

              // Access BarItem of id.
              BarItem? barItem = barItems.getItemById(id: barItemId);

              // If filter is set to daily and BarItem was not found, init.
              if (barItem == null && isDaily) {
                barItem = BarItem.initial().copyWith(
                  id: barItemId,
                  // This is done to show the year if all values should be displayed because more then one year can be shown.
                  bottomTitle: emotionItem.getOccurence(preserveUtc: false, format: filterByYear == null ? 'yyyy-MM-dd' : 'MM-dd'),
                );
              }

              // If filter is NOT set to daily and BarItem was not found, an error occurred.
              if (barItem == null && isDaily == false) throw Failure.genericError();

              // If bar item is still null, an error occurred.
              if (barItem == null) throw Failure.genericError();

              // Get positive/negative indicators.
              final bool isPositiveEmotion = emotionData.isPositiveEmotion(emotionItem: emotionItem);
              final bool isNegativeEmotion = emotionData.isNegativeEmotion(emotionItem: emotionItem);

              // * Emotions can be neutral. In that case continue with next item.
              if (isPositiveEmotion == false && isNegativeEmotion == false) continue;

              // Calculate y axis value.
              // * If emotion was positive, add intensity otherwise subtract it.
              final double yAxisValue = isPositiveEmotion ? barItem.yAxisValue + emotionItem.intensity! : barItem.yAxisValue - emotionItem.intensity!;

              // Heighten total.
              // * TopTitle is used to track the total number of this specific emotion. Will be overwritten later.
              final int total = barItem.topTitle.isEmpty ? 1 : int.parse(barItem.topTitle) + 1;

              // Update BarItem.
              final BarItem udpated = barItem.copyWith(
                topTitle: total.toString(),
                yAxisValue: yAxisValue,
              );

              // Update BarItems.
              barItems = barItems.set(barItem: udpated);
            }
          }
        }
      }
    }

    // Init bar helper.
    BarItems barItemsFinal = BarItems.initial();

    // * Go through barItems to calculate average and overwrite topTitle.
    for (final BarItem barItem in barItems.items) {
      // Access total.
      final int total = barItem.topTitle.isEmpty ? 1 : int.parse(barItem.topTitle);

      // Calculate average.
      final double average = barItem.yAxisValue / total;

      // Update barItem.
      final BarItem updated = barItem.copyWith(
        topTitle: average.toStringAsFixed(2),
        barColor: average < 0 ? Colors.red : Colors.green,
        yAxisValue: average,
      );

      // Add to helper.
      barItemsFinal = barItemsFinal.add(barItem: updated);
    }

    return barItemsFinal;
  }

  // ######################################
  // Measurement Data Charts
  // ######################################

  /// This function can be used to access the maximum of a measurement field.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  /// * Returns ```null``` if no value was found.
  Future<double?> localMeasurementDataMaximum({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String measurementCategory, required String measurementUnit, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    double? max;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Get the month of the DateTime object as a string.
        final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
        final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

        // Only consider item if it falls into date range.
        // If filterByYear is set to null, consider all years.
        if (filterByYear != null && yearAsString != selectedYearAsString) continue;

        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeMeasurement;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data point.
            final MeasurementData measurementData = field.measurementData!;

            // Skip other categories.
            if (measurementData.category != measurementCategory) continue;

            // Calculate converted value.
            final double convertedValue = MeasurementData.getConvertedValue(
              unit: measurementData.unit,
              category: measurementData.category,
              value: measurementData.valueAsDouble,
              toUnit: measurementUnit,
            );

            // Init value.
            if (max == null) {
              max = convertedValue;
              continue;
            }

            // Update max if needed.
            if (measurementData.valueAsDouble > max) max = convertedValue;
          }
        }
      }
    }

    return max;
  }

  /// This function can be used to access the minimum of a measurement field.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  /// * Returns ```null``` if no value was found.
  Future<double?> localMeasurementDataMinimum({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String measurementCategory, required String measurementUnit, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    double? min;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Get the month of the DateTime object as a string.
        final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
        final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

        // Only consider item if it falls into date range.
        // If filterByYear is set to null, consider all years.
        if (filterByYear != null && yearAsString != selectedYearAsString) continue;

        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeMeasurement;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data point.
            final MeasurementData measurementData = field.measurementData!;

            // Skip other categories.
            if (measurementData.category != measurementCategory) continue;

            // Calculate converted value.
            final double convertedValue = MeasurementData.getConvertedValue(
              unit: measurementData.unit,
              category: measurementData.category,
              value: measurementData.valueAsDouble,
              toUnit: measurementUnit,
            );

            // Init value.
            if (min == null) {
              min = convertedValue;
              continue;
            }

            // Update min if needed.
            if (measurementData.valueAsDouble < min) min = convertedValue;
          }
        }
      }
    }

    return min;
  }

  /// This function can be used to access the average of a measurement field.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  /// * Returns ```null``` if no value was found.
  Future<double?> localMeasurementDataAverage({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String measurementCategory, required String measurementUnit, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    double? sum;
    int totalItems = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Get the month of the DateTime object as a string.
        final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
        final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

        // Only consider item if it falls into date range.
        // If filterByYear is set to null, consider all years.
        if (filterByYear != null && yearAsString != selectedYearAsString) continue;

        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeMeasurement;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data point.
            final MeasurementData measurementData = field.measurementData!;

            // Skip other categories.
            if (measurementData.category != measurementCategory) continue;

            // Calculate converted value.
            final double convertedValue = MeasurementData.getConvertedValue(
              unit: measurementData.unit,
              category: measurementData.category,
              value: measurementData.valueAsDouble,
              toUnit: measurementUnit,
            );

            // Heighten total.
            totalItems++;

            // Init value.
            if (sum == null) {
              sum = convertedValue;
              continue;
            }

            // Update min if needed.
            sum = sum + convertedValue;
          }
        }
      }
    }

    // No items found, return null.
    if (sum == null || totalItems == 0) return null;

    return sum / totalItems;
  }

  /// This function can be used to access the sum of a measurement field.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  /// * Returns ```null``` if no value was found.
  Future<double?> localMeasurementDataSum({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String measurementCategory, required String measurementUnit, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init helper.
    double? sum;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Get the month of the DateTime object as a string.
        final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
        final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

        // Only consider item if it falls into date range.
        // If filterByYear is set to null, consider all years.
        if (filterByYear != null && yearAsString != selectedYearAsString) continue;

        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeMeasurement;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data point.
            final MeasurementData measurementData = field.measurementData!;

            // Skip other categories.
            if (measurementData.category != measurementCategory) continue;

            // Calculate converted value.
            final double convertedValue = MeasurementData.getConvertedValue(
              unit: measurementData.unit,
              category: measurementData.category,
              value: measurementData.valueAsDouble,
              toUnit: measurementUnit,
            );

            // Init value.
            if (sum == null) {
              sum = convertedValue;
              continue;
            }

            // Update min if needed.
            sum = sum + convertedValue;
          }
        }
      }
    }

    // No items found, return null.
    if (sum == null) return null;

    return sum;
  }

  /// This function can be used to display a progression of value chart.
  /// * Should be used in a try catch block.
  /// * This method cycles through entries with offset and limit.
  Future<BarItems> localMeasurementDataProgressionOfValue({required DateTime? filterByYear, required String filterByFieldId, required String groupId, required String measurementCategory, required String measurementUnit, required Secrets? secrets}) async {
    // Init offset.
    int offset = 0;
    int limit = 100;

    // Init bar helper.
    BarItems barItems = BarItems.initial();
    // int total = 0;

    while (true) {
      // Access Entries.
      final Entries entries = await getLocalEntriesInLocalGroup(
        groupId: groupId,
        offset: offset,
        limit: limit,
        secrets: secrets,
      );

      // Heighten offset.
      offset = offset + limit;

      // Stop while loop if there are no entries left.
      if (entries.items.isEmpty) break;

      // Go through data.
      for (final Entry entry in entries.items) {
        // Get the month of the DateTime object as a string.
        final String yearAsString = DateFormat('yyyy').format(entry.createdAtInUtc).toLowerCase();
        final String selectedYearAsString = filterByYear == null ? '' : DateFormat('yyyy').format(filterByYear).toLowerCase();

        // Only consider item if it falls into date range.
        // If filterByYear is set to null, consider all years.
        if (filterByYear != null && yearAsString != selectedYearAsString) continue;

        for (final Field field in entry.fields.items) {
          // Convenicen variables.
          final bool isDesiredField = field.fieldType == Field.fieldTypeMeasurement;

          if (isDesiredField) {
            // In case a fieldId was supplied, make sure that only expense fields that have this fieldId are considered.
            if (filterByFieldId.isNotEmpty && filterByFieldId != field.fieldId) continue;

            // Access data point.
            final MeasurementData measurementData = field.measurementData!;

            // Skip other categories.
            if (measurementData.category != measurementCategory) continue;

            // Heighten total.
            // total++;

            // Calculate converted value.
            final double yAxisValue = MeasurementData.getConvertedValue(
              unit: measurementData.unit,
              category: measurementData.category,
              value: measurementData.valueAsDouble,
              toUnit: measurementUnit,
            );

            // Init BarItem.
            final BarItem barItem = BarItem.initial().copyWith(
              barColor: Colors.deepPurple,
              topTitle: yAxisValue.toStringAsFixed(2),
              bottomTitle: entry.entryName,
              yAxisValue: yAxisValue,
            );

            // Add to helper.
            barItems = barItems.add(barItem: barItem);
          }
        }
      }
    }

    // Sort in descending order.
    // * This check is needed because an empty list cannot be sorted.
    if (barItems.items.isNotEmpty) barItems.items.sort((a, b) => b.yAxisValue.compareTo(a.yAxisValue));

    return barItems;
  }
}
