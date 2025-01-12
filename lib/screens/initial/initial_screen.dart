import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Labels.
import '/main.dart';

// Screens.
import '/screens/main/main_screen.dart';

// Cubits.
import 'cubit/initial_screen_cubit.dart';
import '/logic/cubit/local_storage_cubit.dart';

// Widgets.
import '/widgets/logo/logo.dart';
import '/widgets/customs/custom_base_page.dart';
import '/widgets/customs/custom_loading_spinner.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  /// The route name for navigation purposes.
  /// ```dart
  /// static const String routeName = '/initial-screen';
  /// ```
  static const String routeName = '/initial-screen';

  /// Initial Screen route.
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<InitialScreenCubit>(
        create: (_) => InitialScreenCubit(
          localStorageCubit: context.read<LocalStorageCubit>(),
        )..initialize(),
        child: const InitialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access screen height to center content.
    final double height = MediaQuery.of(context).size.height;

    return BlocBuilder<LocalStorageCubit, LocalStorageState>(
      builder: (context, localStorageState) {
        return BlocConsumer<InitialScreenCubit, InitialScreenState>(
          listener: (context, initialScreenState) async {
            // Proceed to next screen.
            if (initialScreenState.status == InitialScreenStatus.success) {
              Navigator.of(context).pushNamed(MainScreen.routeName);
            }
          },
          // * Do not build if state is set to success because on success next screen will be pushed.
          buildWhen: (previous, current) => current.status != InitialScreenStatus.success,
          builder: (context, state) {
            final bool pageHasError = state.status == InitialScreenStatus.pageHasError;

            return CustomBasePage(
              isModalSheet: false,
              canPop: false,
              floatingActionBarDisabled: true,
              // * In this specific case, page is loading should not hide content.
              pageIsLoading: false,
              // * Page Failure.
              pageHasError: pageHasError,
              pageFailure: state.pageFailure,
              pageErrorButtonLabel: labels.basicLabelsTryAgain(),
              onPageErrorButtonPressed: () => context.read<InitialScreenCubit>().initialize(),
              // * Common Failure.
              failure: state.failure,
              onDismissFailure: () => context.read<InitialScreenCubit>().dismissFailure(),
              // * Content.
              contentHeight: height,
              content: Platform.isAndroid
                  // * Android implementation.
                  ? [
                      Spacer(),
                      CustomLoadingSpinner(),
                      Spacer(),
                    ]
                  // * IOS implementation.
                  : [
                      Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // * Logo
                          Center(
                            child: Logo(
                              size: 150.0,
                              showName: false,
                            ),
                          ),
                          CustomLoadingSpinner(
                            paddingTop: 200.0,
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
            );
          },
        );
      },
    );
  }
}
