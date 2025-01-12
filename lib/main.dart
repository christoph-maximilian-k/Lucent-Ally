import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;

// App Router.
import 'app_router.dart';

// Repositories.
import '/data/repositories/storage/storage_repository.dart';
import '/data/repositories/location/location_repository.dart';
import 'data/repositories/files/file_repository.dart';
import '/data/repositories/local_notifications/local_notifications_repository.dart';
import '/data/repositories/api/api_repository.dart';

// Models.
import '/data/models/labels/labels.dart';
import '/data/models/users/user.dart';
import '/data/models/secrets/secrets.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';
import '/logic/app_messages_cubit/app_messages_cubit.dart';

// Widgets.
import '/widgets/debouncer/debouncer.dart';

// * Instantiate local User to gain access to it throughout app.
User user = User.initial();
Labels labels = user.labels;
late SharedPreferences sharedPreferences;

/// * It is necessary to run this as ```async``` and to ```await``` at least one method in here in order to be able to access ```WidgetsBinding.instance.window.physicalSize``` for themes.
void main() async {
  // Neccessary if flutter needs to call native code, before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Init SharedPreferences.
  sharedPreferences = await SharedPreferences.getInstance();

  // Check system prefs.
  final bool systemIsDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  final String defaultSystemTheme = systemIsDarkMode ? User.themeDark : User.themeLight;

  // Access app theme.
  final String theme = sharedPreferences.getString(Secrets.mapKeyAppTheme) ?? defaultSystemTheme;

  // Update user theme.
  // * This is done in here because otherwise the default theme defined in User.initial() will be breifly shown even though
  // * user might have set a different theme.
  user = user.copyWith(theme: theme);

  // Initialize timezone package.
  tz_data.initializeTimeZones();

  // This makes sure, that the device orientation is never in landscape mode for now.
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Instantiate debouncer.
  final Debouncer debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // This repository holds methods to save data locally.
        RepositoryProvider<StorageRepository>(
          create: (_) => StorageRepository(),
        ),
        // This repository holds methods to interact with API.
        RepositoryProvider<ApiRepository>(
          create: (_) => ApiRepository(),
        ),
        // This repository holds methods to access location.
        RepositoryProvider<LocationRepository>(
          create: (_) => LocationRepository(),
        ),
        // This repository holds methods to access files.
        RepositoryProvider<FileRepository>(
          create: (_) => FileRepository(),
        ),
        // This repository holds methods to deliver local notifications.
        RepositoryProvider<LocalNotificationsRepository>(
          create: (_) => LocalNotificationsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Provide storage cubit globally in the app.
          BlocProvider<LocalStorageCubit>(
            create: (context) => LocalStorageCubit(
              storageRepository: context.read<StorageRepository>(),
              apiRepository: context.read<ApiRepository>(),
            ),
          ),
          // Provide app messages cubit gloablly in the app.
          BlocProvider<AppMessagesCubit>(
            create: (context) => AppMessagesCubit(),
          ),
        ],
        child: BlocConsumer<LocalStorageCubit, LocalStorageState>(
          listener: (context, state) {
            // * If user changed user object (for example settings were updated) notify globally.
            if (state.user != user) {
              // Set app user.
              user = state.user;

              // Set app labels.
              labels = state.user.labels;
            }
          },
          // * This cubit should only rebuild the whole app if the theme, language or logout minutes changed
          buildWhen: (previous, current) {
            // * Theme changed.
            if (previous.user.theme != current.user.theme) return true;

            // * Language changed.
            if (previous.user.languageLocale != current.user.languageLocale) return true;

            // * Auto logout changed.
            if (previous.user.autoLogoutInMinutes != current.user.autoLogoutInMinutes) return true;

            return false;
          },
          builder: (context, state) {
            // Access screen size.
            final Size screenSize = View.of(context).physicalSize;

            // Access indication about which theme to display.
            final ThemeData themeData = user.getTheme(
              screenSize: screenSize,
            );

            // Access indication about system overlay style.
            final SystemUiOverlayStyle systemUiOverlayStyle = user.getSystemUiOverlayStyle(
              screenSize: screenSize,
            );

            // This future is needed to correctly set some aspects of system ui.
            Future.delayed(Duration(milliseconds: 100), () {
              SystemChrome.setSystemUIOverlayStyle(
                systemUiOverlayStyle,
              );
            });

            // Change the colour of system overlay.
            SystemChrome.setSystemUIOverlayStyle(
              systemUiOverlayStyle,
            );

            return Listener(
              // * Listen for user interactions (scroll).
              onPointerMove: (final PointerMoveEvent event) {
                debouncer.run(
                  action: () => context.read<LocalStorageCubit>().handleAutoLogout(),
                );
              },
              // * Listen for user interactions (tap).
              onPointerDown: (final PointerDownEvent event) {
                debouncer.run(
                  action: () => context.read<LocalStorageCubit>().handleAutoLogout(),
                );
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: labels.appName(),
                theme: themeData,
                initialRoute: '/',
                onGenerateRoute: (final RouteSettings settings) => AppRouter.onGenerateRoute(
                  routeSettings: settings,
                  context: context,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
