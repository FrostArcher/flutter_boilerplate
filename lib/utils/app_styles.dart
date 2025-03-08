import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newappmytectra/utils/app_settings.dart';
import 'package:newappmytectra/utils/session.dart';

const MaterialColor kSwatch = MaterialColor(0xff28293D, {
  50: Color(0xffe6e6ee),
  100: Color(0xffcdcede),
  200: Color(0xff9c9dbe),
  300: Color(0xff6a6d9d),
  400: Color(0xff484a6e),
  500: Color(0xff28293D),
  600: Color(0xff262639),
  700: Color(0xff242436),
  800: Color(0xff222233),
  900: Color(0xff202030),
});

const Color kHintColor = Color(0xffdedede);
const Color kDividerColor = Color(0xffbcbcbc);
Color kErrorColor = Colors.pink;
Color kBackgroundColor = Colors.white;

//Dark theme

const Color kHintColorDark = Color(0xffdedede);
const Color kDividerColorDark = Color(0x55bcbcbc);
Color kErrorColorDark = Colors.pink[300]!;
Color kBackgroundColorDark = kSwatch;

class RScheme {
  final Color primary;
  final Color secondary;
  final String? name;

  List<Color> get colors => [secondary, primary];

  RScheme(this.primary, this.secondary, [this.name]);
}

class AppTheme {
  final AppSettings settings;

  AppTheme(this.settings);

  static double get kRadius => (Session.cornerRadius) * 2.0;

  static double get kRadiusSmall => (Session.cornerRadius) * 1.0;

  static double get kRadiusSmallest => (Session.cornerRadius) * 0.5;

  static List<RScheme> colors = [
    RScheme(const Color(0xff4179bd), const Color(0xff41BFFF), "appDefault"),
    RScheme(const Color(0xffd15d3d), const Color(0xffd6b23c), "Fire"),
    RScheme(const Color(0xffb5386a), const Color(0xffe06f3f), "Hibiscus"),
    RScheme(const Color(0xffa6295f), const Color(0xffc445bc), "Fuscia"),
    RScheme(const Color(0xff4775ba), const Color(0xff4fc996), "Parakeet"),
    RScheme(const Color(0xff227574), const Color(0xff27e6e2), "Tiffany blue"),
  ];

  static Gradient gradient(BuildContext context,
      {List<Color>? colors,
        AlignmentGeometry? begin,
        AlignmentGeometry? end}) =>
      LinearGradient(
        colors: colors ??
            [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
        begin: begin ?? Alignment.topRight,
        end: end ?? Alignment.bottomLeft,
      );

  TextTheme get _textTheme => TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    titleMedium:TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    titleSmall:TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      decorationColor: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    labelSmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );

  TextTheme get _textThemeDark => TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    titleMedium:TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    titleSmall:TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decorationColor: Colors.white,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  InputDecorationTheme get _inputTheme => InputDecorationTheme(
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColor, width: 0.5),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColor, width: 0.5),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide:
      BorderSide(color: colors[settings.color].secondary, width: 1),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColor, width: 0.5),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColor, width: 1),
    ),
  );

  InputDecorationTheme get _inputThemeDark => InputDecorationTheme(
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColorDark, width: 0.5),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: kDividerColorDark, width: 0.5),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide:
      BorderSide(color: colors[settings.color].secondary, width: 1),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColorDark, width: 0.5),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kErrorColorDark, width: 1),
    ),
  );

  TextSelectionThemeData get _textSelectionTheme => TextSelectionThemeData(
    cursorColor: colors[settings.color].secondary,
    selectionHandleColor: colors[settings.color].secondary,
    selectionColor: colors[settings.color].secondary.withOpacity(0.5),
  );

  ThemeData get theme => ThemeData(
    primarySwatch: kSwatch,
    textSelectionTheme: _textSelectionTheme,
    colorScheme: ColorScheme(
      primary: colors[settings.color].primary,
      secondary: colors[settings.color].secondary,
      surface: Colors.white,
      error: kErrorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: kSwatch,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      height: 36,
      colorScheme: ColorScheme(
        primary: colors[settings.color].secondary,
        secondary: Colors.white,
        surface: colors[settings.color].secondary,
        error: kErrorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      buttonColor: colors[settings.color].secondary,
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusSmall),
      ),
    ),
    primaryColor: colors[settings.color].primary,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    secondaryHeaderColor: colors[settings.color].primary,
    dividerColor: kSwatch[100],
    hintColor: kSwatch[200],
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: _textTheme,
    inputDecorationTheme: _inputTheme,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleTextStyle: _textTheme.titleMedium,
      toolbarTextStyle: _textTheme.titleMedium,
      foregroundColor: _textTheme.labelSmall?.color,
      color: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: kSwatch[50]!,
      disabledColor: kSwatch,
      selectedColor: colors[settings.color].secondary,
      secondarySelectedColor: colors[settings.color].secondary,
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      labelStyle: _textTheme.labelMedium,
      secondaryLabelStyle:
      _textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
      brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(color: kSwatch),
    fontFamily: settings.fontName,
  );

  ThemeData get darkTheme => ThemeData(
    primarySwatch: kSwatch,
    colorScheme: ColorScheme(
      primary: colors[settings.color].primary,
      secondary: colors[settings.color].secondary,
      surface: kSwatch,
      error: kErrorColorDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    textSelectionTheme: _textSelectionTheme,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      height: 36,
      colorScheme: ColorScheme(
        primary: colors[settings.color].secondary,
        secondary: Colors.white,
        surface: colors[settings.color].secondary,
        background: colors[settings.color].secondary,
        error: kErrorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      buttonColor: colors[settings.color].secondary,
    ),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusSmall),
      ),
    ),
    inputDecorationTheme: _inputThemeDark,
    primaryColor: colors[settings.color].primary,
    canvasColor: kSwatch,
    secondaryHeaderColor: colors[settings.color].primary,
    cardColor: kSwatch,
    hintColor: Colors.white38,
    disabledColor: kSwatch[200],
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kBackgroundColorDark,
    textTheme: _textThemeDark,
    appBarTheme: AppBarTheme(
      titleTextStyle: _textThemeDark.titleMedium,
      toolbarTextStyle: _textThemeDark.titleMedium,
      foregroundColor: _textThemeDark.labelSmall?.color,
      elevation: 0.0,
      color: Colors.transparent,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: kSwatch[900]!,
      disabledColor: kSwatch,
      selectedColor: colors[settings.color].secondary,
      secondarySelectedColor: colors[settings.color].secondary,
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      labelStyle: _textThemeDark.labelMedium!,
      secondaryLabelStyle: _textThemeDark.labelSmall!,
      brightness: Brightness.dark,
    ),
    dividerColor: kDividerColorDark,
    iconTheme: const IconThemeData(color: Colors.white),
    fontFamily: settings.fontName,
  );
}
