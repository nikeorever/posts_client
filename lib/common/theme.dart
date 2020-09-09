import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui
    show
        ParagraphStyle,
        TextStyle,
        StrutStyle,
        lerpDouble,
        Shadow,
        FontFeature,
        TextHeightBehavior;

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
        scaffoldBackgroundColor: Color.fromARGB(255, 249, 249, 249),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle:
                GoogleFonts.merriweatherSans(color: Colors.white)),
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
  Animation<Color> get progressIndicatorValueColor =>
      AlwaysStoppedAnimation(Colors.black54);

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
      scaffoldBackgroundColor: Color.fromARGB(255, 249, 249, 249),
      snackBarTheme: SnackBarThemeData(
          contentTextStyle: GoogleFonts.merriweatherSans(color: Colors.white)),
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
  Animation<Color> get progressIndicatorValueColor =>
      AlwaysStoppedAnimation(Colors.teal);

  @override
  DrawerHeaderThemeData get drawerHeaderThemeData => DrawerHeaderThemeData(
        decoration: const BoxDecoration(color: Colors.teal),
        subtitle1: themeData.textTheme.subtitle1
            .copyWith(fontSize: 16, color: Colors.white),
        subtitle2:
            themeData.textTheme.subtitle1.copyWith(color: Colors.white70),
      );
}

TextStyle markdownFont(
        {Color color,
        Color backgroundColor,
        double fontSize,
        FontWeight fontWeight,
        FontStyle fontStyle,
        double letterSpacing,
        double wordSpacing,
        TextBaseline textBaseline,
        double height,
        Locale locale,
        Paint foreground,
        Paint background,
        List<ui.Shadow> shadows,
        List<ui.FontFeature> fontFeatures,
        TextDecoration decoration,
        Color decorationColor,
        TextDecorationStyle decorationStyle,
        double decorationThickness}) =>
    GoogleFonts.merriweatherSans(
        color: color,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness);

MarkdownStyleSheet markdownStyleSheet(BuildContext context) {
  return MarkdownStyleSheet(
    a: markdownFont(
      // [google](http://www.google.com)
      decoration: TextDecoration.underline,
      color: Color.fromARGB(255, 12, 147, 228),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    p: markdownFont(
      // normal text
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    code: markdownFont(
      // `Dart`,
      // ```dart
      // void main() {}
      // ```
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.w300,
      fontSize: 14,
    ),
    codeblockPadding: EdgeInsets.all(8),
    codeblockDecoration: BoxDecoration(
      color: Color.fromRGBO(238, 238, 238, 1),
      borderRadius: BorderRadius.circular(4.0),
    ),
    h1: markdownFont(
      // # h1
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    h2: markdownFont(
      // ## h2
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    h3: markdownFont(
      // ### h3
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    h4: markdownFont(
      // #### h4
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    h5: markdownFont(
      // ##### h5
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    h6: markdownFont(
      // ###### h6
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    em: markdownFont(
      // *I*
      fontStyle: FontStyle.italic,
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    strong: markdownFont(
      // **B**
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    del: markdownFont(
      // ~~D~~
      color: Color.fromRGBO(0, 0, 0, 0.75),
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    img: markdownFont(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    checkbox: markdownFont(
      color: Theme.of(context).primaryColor,
      decoration: TextDecoration.lineThrough,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    tableHead: markdownFont(
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    tableBody: markdownFont(
      // normal text
      color: Color.fromRGBO(0, 0, 0, 0.75),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    tableHeadAlign: TextAlign.center,
    tableBorder: TableBorder.all(
      color: Color.fromARGB(255, 225, 225, 225),
      width: 1,
    ),
    tableColumnWidth: const FlexColumnWidth(),
    tableCellsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    tableCellsDecoration: const BoxDecoration(),
    blockquote: markdownFont(
      // > This is blockquote
      color: Color.fromRGBO(0, 0, 0, 0.5),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    blockquotePadding: const EdgeInsets.all(8),
    blockquoteDecoration: BoxDecoration(),
    blockquoteAlign: WrapAlignment.start,
    blockSpacing: 8.0,
    listIndent: 24.0,
    listBullet: markdownFont(
      /*
        * Item
          1. First Subitem
          2. Second Subitem
        * Item
          - Subitem
          - Subitem
        * Item
      */
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    ),
    horizontalRuleDecoration: BoxDecoration(
      // >---
      border: Border(
        top: BorderSide(
          width: 1.0,
          color: Color.fromARGB(255, 225, 225, 225),
        ),
      ),
    ),
  );
}
