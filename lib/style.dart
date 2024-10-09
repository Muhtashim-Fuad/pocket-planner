import 'package:flutter/material.dart';

final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 0, 140, 255),
);

final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 19, 21, 27),
);

const TextStyle _regularTextStyle = TextStyle(
  fontFamily: "Montserrat",
  fontSize: 13.0,
  fontVariations: [
    FontVariation("wght", 500),
  ],
);

class StyleData {
  static const primaryCreditColor = Colors.green;
  static const primaryDebitColor = Colors.red;

  static TextStyle listTileTextStyle = _regularTextStyle.copyWith(
    color: const Color.fromARGB(255, 221, 221, 221),
  );

  static final TextStyle radioTextStyle = _regularTextStyle.copyWith(
    fontSize: 14.0,
    letterSpacing: -0.5,
  );

  static final TextStyle inputTextStyle = _regularTextStyle.copyWith(
    letterSpacing: -0.1,
    fontSize: 14.0,
    fontVariations: [
      const FontVariation("wght", 300),
    ],
  );

  static final ThemeData _baseThemeData = ThemeData(
    useMaterial3: true,
    fontFamily: "Montserrat",
    primaryColorDark: Colors.white,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    dialogTheme: DialogTheme(
      elevation: 8.0,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      titleTextStyle: _regularTextStyle,
      contentTextStyle: _regularTextStyle.copyWith(
        fontVariations: const [FontVariation("wght", 300)],
      ),
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2.0,
        textStyle: _regularTextStyle.copyWith(
          fontSize: 14.0,
          fontVariations: [
            const FontVariation("wght", 700),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      hintStyle: _regularTextStyle.copyWith(
        color: const Color.fromARGB(255, 138, 138, 138),
        letterSpacing: -0.1,
        fontSize: 14.0,
        fontVariations: [
          const FontVariation("wght", 300),
        ],
      ),
      labelStyle: _regularTextStyle.copyWith(
        letterSpacing: -0.5,
        fontVariations: [
          const FontVariation("wght", 300),
        ],
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 8.0,
      selectedItemColor: Colors.blue,
      unselectedItemColor: const Color.fromARGB(255, 85, 85, 85),
      showUnselectedLabels: true,
      selectedLabelStyle: _regularTextStyle.copyWith(
        fontFamily: "Montserrat",
        fontSize: 12.0,
        letterSpacing: -0.25,
      ),
      unselectedLabelStyle: _regularTextStyle.copyWith(
        fontFamily: "Montserrat",
        fontSize: 11.0,
        letterSpacing: -0.25,
      ),
      type: BottomNavigationBarType.fixed,
      enableFeedback: false,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
      ),
    ),
    listTileTheme: ListTileThemeData(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      titleTextStyle: _regularTextStyle,
      subtitleTextStyle: _regularTextStyle.copyWith(color: Colors.grey),
      style: ListTileStyle.list,
    ),
  );

  static final ThemeData darkThemeData = _baseThemeData.copyWith(
    dialogBackgroundColor: _darkColorScheme.onInverseSurface,
    colorScheme: _darkColorScheme,
    primaryColor: Colors.white,
    splashColor: const Color.fromARGB(255, 65, 65, 65),
    highlightColor: const Color.fromARGB(255, 65, 65, 65),
    scaffoldBackgroundColor: _darkColorScheme.onInverseSurface,
    bottomNavigationBarTheme: _baseThemeData.bottomNavigationBarTheme.copyWith(
      backgroundColor: Colors.black,
    ),
    dialogTheme: _baseThemeData.dialogTheme.copyWith(
      titleTextStyle: TextStyle(fontFamily: "Montserrat", color: _darkColorScheme.onSurface),
      contentTextStyle: TextStyle(fontFamily: "Montserrat", color: _darkColorScheme.onSurface),
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(
        fontFamily: "Montserrat",
        color: _darkColorScheme.onSurface,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontFamily: "Montserrat"),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        foregroundColor: _darkColorScheme.onSurface,
        iconColor: _darkColorScheme.onSurface,
      ),
    ),
  );

  static final ThemeData lightThemeData = _baseThemeData.copyWith(
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.onInverseSurface,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightColorScheme.onSurface,
        iconColor: _lightColorScheme.onSurface,
      ),
    ),
    dialogTheme: _baseThemeData.dialogTheme.copyWith(
      backgroundColor: _darkColorScheme.onInverseSurface,
      titleTextStyle: TextStyle(
          fontFamily: "Montserrat", color: _darkColorScheme.onSurface),
      contentTextStyle: TextStyle(
          fontFamily: "Montserrat", color: _darkColorScheme.onSurface),
    ),
  );
}
