import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes extends Equatable {
  final double screenWidth;
  final double screenHeight;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color background;
  final Color onBackground;
  final Color shadow;
  final Color inputBackground;
  final Color inputHint;
  final Color inputIcon;
  final Color selection;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconTertiary;

  final Color primaryContainer;
  final Color secondaryContainer;
  final Color tertiaryContainer;

  final double iconSize;

  final double widgetBorderRadius;
  final double sheetBorderRadius;
  final double fontSizeBig;
  final double fontSizeMedium;
  final double fontSizeSmall;
  final double fontSizeTiny;
  final double elevation;

  final Size minimumButtonSize;

  const Themes({
    required this.screenWidth,
    required this.screenHeight,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.background,
    required this.onBackground,
    required this.shadow,
    required this.inputBackground,
    required this.inputHint,
    required this.inputIcon,
    required this.selection,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconTertiary,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.tertiaryContainer,
    required this.iconSize,
    required this.widgetBorderRadius,
    required this.sheetBorderRadius,
    required this.fontSizeBig,
    required this.fontSizeMedium,
    required this.fontSizeSmall,
    required this.fontSizeTiny,
    required this.elevation,
    required this.minimumButtonSize,
  });

  @override
  List<Object> get props => [
        screenWidth,
        screenHeight,
        primary,
        onPrimary,
        secondary,
        onSecondary,
        error,
        onError,
        background,
        onBackground,
        shadow,
        inputBackground,
        inputHint,
        inputIcon,
        selection,
        iconPrimary,
        iconSecondary,
        iconTertiary,
        primaryContainer,
        secondaryContainer,
        tertiaryContainer,
        iconSize,
        widgetBorderRadius,
        sheetBorderRadius,
        fontSizeBig,
        fontSizeMedium,
        fontSizeSmall,
        fontSizeTiny,
        elevation,
        minimumButtonSize,
      ];

  /// Factory constructor to initialize a dark theme.
  factory Themes.darkTheme({required Size screenSize}) {
    return Themes(
      screenHeight: screenSize.width,
      screenWidth: screenSize.height,
      primary: const Color.fromARGB(255, 43, 41, 41),
      onPrimary: const Color.fromARGB(255, 241, 114, 10),
      secondary: const Color.fromRGBO(17, 125, 114, 1),
      onSecondary: Colors.grey.shade200,
      error: const Color.fromARGB(255, 163, 23, 13),
      onError: Colors.black,
      background: const Color.fromARGB(255, 26, 23, 23),
      onBackground: Colors.grey.shade200,
      shadow: Colors.black,
      inputBackground: Colors.grey.shade400,
      inputHint: Colors.grey.shade900,
      inputIcon: Colors.black,
      selection: Colors.blue,
      iconPrimary: const Color.fromRGBO(17, 125, 114, 1),
      iconSecondary: Colors.grey.shade400,
      iconTertiary: Colors.black,
      primaryContainer: Colors.grey.shade500,
      secondaryContainer: Colors.green.shade900,
      tertiaryContainer: Colors.black,
      iconSize: 15.0,
      widgetBorderRadius: 10.0,
      sheetBorderRadius: 15.0,
      fontSizeBig: 18.0,
      fontSizeMedium: 14.0,
      fontSizeSmall: 12.0,
      fontSizeTiny: 10.0,
      elevation: 4.0,
      minimumButtonSize: Size(screenSize.width * 0.4, 42.0),
    );
  }

  /// Factory constructor to initialize a light theme.
  factory Themes.lightTheme({required Size screenSize}) {
    return Themes(
      screenHeight: screenSize.width,
      screenWidth: screenSize.height,
      primary: const Color.fromARGB(255, 255, 255, 255),
      onPrimary: const Color.fromARGB(255, 164, 126, 224),
      secondary: const Color.fromRGBO(17, 125, 114, 1),
      onSecondary: const Color.fromARGB(255, 46, 43, 43),
      error: const Color.fromARGB(255, 163, 23, 13),
      onError: Colors.black,
      background: const Color.fromARGB(255, 243, 243, 243),
      onBackground: const Color.fromARGB(255, 46, 43, 43),
      shadow: Colors.black,
      inputBackground: Colors.grey.shade400,
      inputHint: Colors.grey.shade900,
      selection: Colors.blue,
      inputIcon: Colors.black,
      iconPrimary: const Color.fromRGBO(17, 125, 114, 1),
      iconSecondary: const Color.fromARGB(255, 46, 43, 43),
      iconTertiary: Colors.black,
      primaryContainer: Colors.grey.shade500,
      secondaryContainer: Colors.green.shade900,
      tertiaryContainer: Colors.white,
      iconSize: 15.0,
      widgetBorderRadius: 10.0,
      sheetBorderRadius: 15.0,
      fontSizeBig: 18.0,
      fontSizeMedium: 14.0,
      fontSizeSmall: 12.0,
      fontSizeTiny: 10.0,
      elevation: 6.0,
      minimumButtonSize: Size(screenSize.width * 0.4, 42.0),
    );
  }

  /// This getter can be used to access system overlay style depending on theme.
  SystemUiOverlayStyle getSystemUiOverlayStyle({required bool isDark}) {
    return SystemUiOverlayStyle(
      // * StatusBar.
      statusBarColor: background,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      // * NavBar.
      systemNavigationBarColor: background,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    );
  }

  /// This getter can be used to instantiate [ThemeData] of a [Themes] theme.
  ThemeData get getTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: background,
        onSurface: onBackground,
        shadow: shadow,
        primaryContainer: primaryContainer,
        secondaryContainer: secondaryContainer,
        tertiaryContainer: tertiaryContainer,
      ),
      visualDensity: VisualDensity.compact,
      scaffoldBackgroundColor: Colors.transparent,
      // --- CardTheme ---
      cardTheme: CardTheme(
        elevation: elevation,
        color: primary,
        shadowColor: shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widgetBorderRadius),
          ),
        ),
      ),
      // --- Modal Bottom Sheet ---
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        modalBackgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(sheetBorderRadius),
            topRight: Radius.circular(sheetBorderRadius),
          ),
        ),
      ),
      // --- Text Themes ---
      textTheme: TextTheme(
        // ---- Title.
        titleLarge: TextStyle(
          color: onPrimary,
          fontSize: fontSizeBig,
        ),
        titleMedium: TextStyle(
          color: onPrimary,
          fontSize: fontSizeMedium,
        ),
        titleSmall: TextStyle(
          color: onPrimary,
          fontSize: fontSizeSmall,
        ),
        // ---- Headline.
        headlineLarge: TextStyle(
          color: secondary,
          fontSize: fontSizeBig,
        ),
        headlineMedium: TextStyle(
          color: secondary,
          fontSize: fontSizeMedium,
        ),
        headlineSmall: TextStyle(
          color: secondary,
          fontSize: fontSizeSmall,
        ),
        // ---- Label.
        labelLarge: TextStyle(
          color: onBackground,
          fontSize: fontSizeBig,
        ),
        labelMedium: TextStyle(
          color: onBackground,
          fontSize: fontSizeMedium,
        ),
        labelSmall: TextStyle(
          color: onBackground,
          fontSize: fontSizeTiny,
        ),
        // ---- Display.
        displayLarge: TextStyle(
          color: onBackground,
          fontSize: fontSizeBig,
        ),
        displayMedium: TextStyle(
          color: onBackground,
          fontSize: fontSizeMedium,
        ),
        displaySmall: TextStyle(
          color: onBackground,
          fontSize: fontSizeTiny,
        ),
        // * AppName style.
        bodyLarge: TextStyle(
          color: onBackground,
          fontSize: fontSizeBig,
          fontWeight: FontWeight.w500,
          letterSpacing: 2.0,
        ),
        // * Error style.
        bodySmall: TextStyle(
          color: error,
          fontSize: fontSizeSmall,
        ),
      ),
      // --- Icon Primary ---
      primaryIconTheme: IconThemeData(
        color: iconPrimary,
        size: iconSize,
      ),
      // --- Icon Secondary ---
      iconTheme: IconThemeData(
        color: iconSecondary,
        size: iconSize,
      ),
      // --- App Bar ---
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(sheetBorderRadius),
            topRight: Radius.circular(sheetBorderRadius),
          ),
        ),
      ),
      // --- Elevated Button ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondary,
          foregroundColor: onSecondary,
          minimumSize: minimumButtonSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widgetBorderRadius),
            ),
          ),
          elevation: elevation,
          textStyle: TextStyle(
            fontSize: fontSizeMedium,
          ),
        ),
      ),
      // --- Text Button ---
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: onPrimary,
          minimumSize: minimumButtonSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widgetBorderRadius),
            ),
            side: BorderSide(
              color: onPrimary,
              width: 1.0,
            ),
          ),
          elevation: elevation,
          textStyle: TextStyle(
            fontSize: fontSizeMedium,
          ),
        ),
      ),
      // --- Text Input ---
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: TextStyle(
          color: inputHint,
          backgroundColor: inputBackground,
          fontSize: fontSizeMedium,
          decoration: TextDecoration.none,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: inputBackground,
            width: 1.0,
          ),
        ),
        iconColor: inputIcon,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: inputHint,
        selectionHandleColor: selection,
        selectionColor: selection,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(widgetBorderRadius),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        labelStyle: TextStyle(
          color: onPrimary,
          fontSize: fontSizeMedium,
        ),
        backgroundColor: background,
        side: BorderSide(
          color: background,
        ),
      ),
    );
  }
}
