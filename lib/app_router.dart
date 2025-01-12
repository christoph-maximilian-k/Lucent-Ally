import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Screens.
import './screens/initial/initial_screen.dart';
import './screens/main/main_screen.dart';
import './screens/splash/splash_screen.dart';

// Cubits.
import '/logic/cubit/local_storage_cubit.dart';

// Pages.
import 'pages/view_files_page/view_files_page.dart';

class AppRouter {
  static Route? onGenerateRoute({required RouteSettings routeSettings, required BuildContext context}) {
    // Display route name for debugging purposes.
    debugPrint('AppRouter --> Route --> ${routeSettings.name}');

    // User accessed on generate route through deep links.
    if (routeSettings.name != null && routeSettings.name!.contains(LocalStorageCubit.routeNameDeepLinks)) {
      // Handle deep links.
      context.read<LocalStorageCubit>().handleDeepLink(
            deepLink: routeSettings.name!,
          );

      // Do not return a route.
      return null;
    }

    switch (routeSettings.name) {
      case '/':
        return InitialScreen.route();
      case MainScreen.routeName:
        return MainScreen.route();
      case ViewFilesPage.routeName:
        return ViewFilesPage.route(arguments: routeSettings.arguments as ViewFilesPageArguments);
      default:
        return SplashScreen.route();
    }
  }
}
