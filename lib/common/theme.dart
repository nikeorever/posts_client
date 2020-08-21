import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// NAME       SIZE   WEIGHT   SPACING  2018 NAME
/// display4   112.0  thin     0.0      headline1
/// display3   56.0   normal   0.0      headline2
/// display2   45.0   normal   0.0      headline3
/// display1   34.0   normal   0.0      headline4
/// headline   24.0   normal   0.0      headline5
/// title      20.0   medium   0.0      headline6
/// subhead    16.0   normal   0.0      subtitle1
/// body2      14.0   medium   0.0      body1 (bodyText1)
/// body1      14.0   normal   0.0      body2 (bodyText2)
/// caption    12.0   normal   0.0      caption
/// button     14.0   medium   0.0      button
/// subtitle   14.0   medium   0.0      subtitle2
/// overline   10.0   normal   0.0      overline
///
const int _whitePrimaryValue = 0xFFFFFFFF;
const MaterialColor white = MaterialColor(
  _whitePrimaryValue,
  <int, Color>{
    50: Color(_whitePrimaryValue),
    100: Color(_whitePrimaryValue),
    200: Color(_whitePrimaryValue),
    300: Color(_whitePrimaryValue),
    400: Color(_whitePrimaryValue),
    500: Color(_whitePrimaryValue),
    600: Color(_whitePrimaryValue),
    700: Color(_whitePrimaryValue),
    800: Color(_whitePrimaryValue),
    900: Color(_whitePrimaryValue)
  },
);

class DrawerHeaderThemeData {
  final Decoration decoration;
  final TextStyle subtitle1;
  final TextStyle subtitle2;

  DrawerHeaderThemeData(
      {@required this.decoration,
      @required this.subtitle1,
      @required this.subtitle2});
}

abstract class NikeoTheme {
  const NikeoTheme();

  static List<NikeoTheme> validNikeoThemes() =>
      const <NikeoTheme>[NikeoLightTheme(), NikeoDartTheme()];

  String get name;

  ThemeData get themeData;

  Animation<Color> get progressIndicatorValueColor;

  DrawerHeaderThemeData get drawerHeaderThemeData;
}

class NikeoLightTheme extends NikeoTheme {
  const NikeoLightTheme();

  @override
  get name => 'Light';

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: white,
        scaffoldBackgroundColor: white,
        fontFamily: GoogleFonts.merriweatherSans().fontFamily,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.teal, backgroundColor: Colors.white),
        tabBarTheme: TabBarTheme(
            indicator: UnderlineTabIndicator(
                borderSide: const BorderSide(width: 2.0, color: Colors.teal)),
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            labelStyle: GoogleFonts.merriweatherSans(
                fontWeight: FontWeight.normal, fontSize: 14),
            unselectedLabelStyle: GoogleFonts.merriweatherSans(
                fontWeight: FontWeight.normal, fontSize: 14)),
        textTheme: TextTheme(
          headline1: GoogleFonts.playball(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
          subtitle1: GoogleFonts.merriweatherSans(
              fontWeight: FontWeight.w400, fontSize: 14),
        ),
      );

  @override
  Animation<Color> get progressIndicatorValueColor => AlwaysStoppedAnimation(Colors.black54);

  @override
  DrawerHeaderThemeData get drawerHeaderThemeData => DrawerHeaderThemeData(
        decoration: const BoxDecoration(),
        subtitle1: themeData.textTheme.subtitle1
            .copyWith(fontSize: 16, color: Colors.black),
        subtitle2:
            themeData.textTheme.subtitle1.copyWith(color: Colors.black54),
      );
}

class NikeoDartTheme extends NikeoTheme {
  const NikeoDartTheme();

  @override
  get name => 'Dart';

  @override
  ThemeData get themeData => ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: white,
      fontFamily: GoogleFonts.merriweatherSans().fontFamily,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, backgroundColor: Colors.teal),
      tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
              borderSide: const BorderSide(width: 2.0, color: Colors.white)),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: GoogleFonts.merriweatherSans(
              fontWeight: FontWeight.normal, fontSize: 14),
          unselectedLabelStyle: GoogleFonts.merriweatherSans(
              fontWeight: FontWeight.normal, fontSize: 14)),
      textTheme: TextTheme(
          headline1: GoogleFonts.playball(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
          subtitle1: GoogleFonts.merriweatherSans(
              fontWeight: FontWeight.w400, fontSize: 14)));

  @override
  Animation<Color> get progressIndicatorValueColor => AlwaysStoppedAnimation(Colors.teal);

  @override
  DrawerHeaderThemeData get drawerHeaderThemeData => DrawerHeaderThemeData(
        decoration: const BoxDecoration(color: Colors.teal),
        subtitle1: themeData.textTheme.subtitle1
            .copyWith(fontSize: 16, color: Colors.white),
        subtitle2:
            themeData.textTheme.subtitle1.copyWith(color: Colors.white70),
      );
}
