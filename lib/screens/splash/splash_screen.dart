import 'dart:io';

import 'package:flutter/material.dart';

// labels.
import '/main.dart';

// Models.
import '/data/models/failure.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  /// The route name for navigation purposes.
  /// ```dart
  /// static const String routeName = '/splash-screen';
  /// ```
  static const String routeName = '/splash-screen';

  /// Splash screen route.
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBasePage(
      isModalSheet: false,
      // Page is loading.
      pageIsLoading: false,
      // Page Failure.
      pageHasError: true,
      pageFailure: Failure.genericError(),
      pageErrorButtonLabel: labels.basicLabelsClose(),
      onPageErrorButtonPressed: () => exit(1),
      // Common Failure.
      failure: Failure.initial(),
      onDismissFailure: () {},
      // Floating Action Bar.
      floatingActionBarDisabled: true,
      // Content.
      content: [],
    );
  }
}
