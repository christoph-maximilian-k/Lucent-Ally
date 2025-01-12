part of 'local_storage_cubit.dart';

enum LocalStorageStatus { waiting, logout, deepLink, showProtectedEntriesChanged }

class LocalStorageState extends Equatable {
  final Isar? database;

  final User user;

  final PickerItems timezones;

  /// This is used to speed up image availability. It stores decrypted images so that if they get viewed again in a session the wont have to be decrypted again.
  final Files decryptedImages;

  final Tags sharedTagsCache;

  final List<CloudUser> cloudUsersCache;

  final Timer? logoutTimer;

  final bool protectedGroupIsShown;
  final bool showProtectedEntries;
  final bool authIsFresh;

  final Map<String, String> lastDeepLinkArgs;

  final String currentRequestId;
  final List<String> cancledRequestIds;

  final LocalStorageStatus status;

  final FlutterSecureStorage? nativeKeyStorage;

  const LocalStorageState({
    required this.database,
    required this.user,
    required this.timezones,
    required this.decryptedImages,
    required this.logoutTimer,
    required this.sharedTagsCache,
    required this.protectedGroupIsShown,
    required this.showProtectedEntries,
    required this.authIsFresh,
    required this.cloudUsersCache,
    required this.lastDeepLinkArgs,
    required this.currentRequestId,
    required this.cancledRequestIds,
    required this.nativeKeyStorage,
    required this.status,
  });

  @override
  List<Object?> get props => [
        database,
        user,
        timezones,
        decryptedImages,
        logoutTimer,
        sharedTagsCache,
        protectedGroupIsShown,
        showProtectedEntries,
        authIsFresh,
        cloudUsersCache,
        lastDeepLinkArgs,
        currentRequestId,
        cancledRequestIds,
        nativeKeyStorage,
        status,
      ];

  /// Initialize a new ```LocalStorageState``` object.
  factory LocalStorageState.initial() {
    return LocalStorageState(
      database: null,
      user: User.initial(),
      timezones: PickerItems.initial(),
      decryptedImages: Files.initial(),
      logoutTimer: null,
      sharedTagsCache: Tags.initial(),
      protectedGroupIsShown: false,
      showProtectedEntries: false,
      authIsFresh: false,
      cloudUsersCache: const [],
      lastDeepLinkArgs: const {},
      currentRequestId: '',
      cancledRequestIds: const [],
      nativeKeyStorage: null,
      status: LocalStorageStatus.waiting,
    );
  }

  LocalStorageState copyWith({
    Isar? database,
    User? user,
    PickerItems? timezones,
    Files? decryptedImages,
    Timer? logoutTimer,
    bool? protectedGroupIsShown,
    Tags? sharedTagsCache,
    bool? showProtectedEntries,
    bool? authIsFresh,
    List<CloudUser>? cloudUsersCache,
    LocalStorageStatus? status,
    Map<String, String>? lastDeepLinkArgs,
    String? currentRequestId,
    List<String>? cancledRequestIds,
    FlutterSecureStorage? nativeKeyStorage,
    required String calledFrom,
  }) {
    // Output debug messages.
    debugPrint('LocalStorageCubit --> copyWith() --> called from: $calledFrom --> status changed from "${this.status}" to "$status"');

    return LocalStorageState(
      database: database ?? this.database,
      user: user ?? this.user,
      timezones: timezones ?? this.timezones,
      decryptedImages: decryptedImages ?? this.decryptedImages,
      logoutTimer: logoutTimer ?? this.logoutTimer,
      sharedTagsCache: sharedTagsCache ?? this.sharedTagsCache,
      protectedGroupIsShown: protectedGroupIsShown ?? this.protectedGroupIsShown,
      showProtectedEntries: showProtectedEntries ?? this.showProtectedEntries,
      cloudUsersCache: cloudUsersCache ?? this.cloudUsersCache,
      nativeKeyStorage: nativeKeyStorage ?? this.nativeKeyStorage,
      authIsFresh: authIsFresh ?? this.authIsFresh,
      lastDeepLinkArgs: lastDeepLinkArgs ?? this.lastDeepLinkArgs,
      currentRequestId: currentRequestId ?? this.currentRequestId,
      cancledRequestIds: cancledRequestIds ?? this.cancledRequestIds,
      status: status ?? this.status,
    );
  }
}
