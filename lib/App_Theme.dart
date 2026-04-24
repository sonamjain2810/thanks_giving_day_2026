import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/SizeConfig.dart';

class AppTheme {
  //default constructor
  AppTheme._();

  // yaha per sab color define kiye hai jo hame ThemeData me use karege light Theme.
  static const Color _lightIconColor = Colors.grey;
  static const Color _lightPrimaryColor = Colors.white70;
  static const MaterialColor _lightPrimaryVariantColor = Colors.deepOrange;
  static const Color _lightSecondaryColor = Colors.grey;
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _lightPrimaryIconThemeColor = Colors.deepOrange;
  static const Color _lightButtonTextColor = Colors.white;
  static const Color _lightButtonColor = Colors.yellow;
  static const Color _lightButtonSplashColor = Colors.deepOrange;
  static const Color _lightAppBarTextColor = Colors.white;
  static const Color _lightDividerColor = Colors.black;
  static const Color _lightCardColor = Colors.white70;
  static const Color _lightShadowColor = Colors.grey;

  // yaha per sab color define kiye hai jo hame ThemeData me use karege dark Theme.
  static const Color _darkIconColor = Colors.white;
  static const Color _darkPrimaryColor = Colors.black;
  static final Color? _darkPrimaryVariantColor = Colors.grey[800];
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkPrimaryIconThemeColor = Colors.red;
  static const Color _darkButtonTextColor = Colors.white;
  static const Color _darkButtonColor = Colors.red;
  static const Color _darkButtonSplashColor = Colors.blue;
  static const Color _darkAppBarTextColor = Colors.white;
  static const Color _darkDividerColor = Colors.white;
  static const Color _darkCardColor = Colors.grey;
  static const Color _darkShadowColor = Colors.white70;

  // upar jo hamne light theme ke colors banaye the woh ThemeData me use karege
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    primarySwatch: _lightPrimaryVariantColor,
    dividerColor: _lightDividerColor,

    // AppBar
    appBarTheme: AppBarTheme(
      color: _lightPrimaryVariantColor, // <<< ORANGE RESTORED
      toolbarTextStyle: _lightAppBarTextTextTheme.displayLarge,
      elevation: 8.0,
      iconTheme: const IconThemeData(
        color: _lightButtonTextColor,
      ),
    ),

    textTheme: TextTheme(
      headlineSmall: GoogleFonts.oswald(
        textStyle: const TextStyle(color: _lightOnPrimaryColor),
      ),

      //Side Bar List Items Text Color
      titleSmall: const TextStyle(color: _lightOnPrimaryColor),
      titleLarge: GoogleFonts.ptSans(
        textStyle: const TextStyle(color: _lightDividerColor),
      ),
      titleMedium: GoogleFonts.ptSans(
        textStyle: const TextStyle(color: _lightDividerColor),
      ),
      labelLarge: GoogleFonts.ptSans(
        textStyle: const TextStyle(color: _lightOnPrimaryColor),
      ),
      bodyLarge: GoogleFonts.ptSans(
        textStyle: const TextStyle(color: _lightDividerColor),
      ),
      bodyMedium: GoogleFonts.ptSans(
        textStyle: const TextStyle(color: _lightOnPrimaryColor),
      ),
      bodySmall: GoogleFonts.ptSans(
        textStyle: const TextStyle(color: _lightOnPrimaryColor),
      ),
    ),

    iconTheme: const IconThemeData(
      color: _lightIconColor,
    ),

    primaryIconTheme: const IconThemeData(color: _lightButtonTextColor),

    buttonTheme: _lightButtonThemeData,

    // Drawer Color
    canvasColor: _lightPrimaryColor,
    useMaterial3: false,

    // Card Theme (FIXED HERE)
    cardTheme: CardThemeData(
      elevation: 6.0,
      color: _lightCardColor,
      shadowColor: _lightShadowColor,
    ),

    inputDecorationTheme: _lightInputDecorationTheme,

    // Change circular progress bar color
    hintColor: _lightPrimaryVariantColor,
  );

  static final InputDecorationTheme _lightInputDecorationTheme =
      InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: _lightPrimaryVariantColor),
      borderRadius: BorderRadius.circular(20.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: _lightPrimaryVariantColor),
    ),
    hintStyle: GoogleFonts.ptSans(textStyle: _lightScreenBodyText1TextStyle),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  );

  // light Appbar text Styling
  static final TextTheme _lightAppBarTextTextTheme = TextTheme(
    bodyLarge: GoogleFonts.lobster(textStyle: _lightAppBarHeadline1TextStyle),
  );

  static const TextStyle _lightAppBarHeadline1TextStyle = TextStyle(
    color: _lightAppBarTextColor,
  );

  static final ButtonThemeData _lightButtonThemeData = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: _lightButtonColor,
    splashColor: _lightButtonSplashColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final TextStyle _lightButtonTextTextStyle = TextStyle(
    fontSize: 1.56 * SizeConfig.textMultiplier,
    color: _lightButtonTextColor,
  );

  static final TextStyle _lightScreenHeading1TextStyle = TextStyle(
    fontSize: 2.68 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold,
    color: _lightOnPrimaryColor,
    letterSpacing: 1,
  );

  static final TextStyle _lightScreenBodyText1TextStyle = TextStyle(
    fontSize: 2.23 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
    letterSpacing: .5,
  );

  static final TextStyle _lightScreenBodyText2TextStyle = TextStyle(
    fontSize: 2 * SizeConfig.textMultiplier,
    color: _lightPrimaryColor,
    letterSpacing: .5,
  );

  static final TextStyle _lightScreenSubTitle1TextStyle = TextStyle(
    fontSize: 1.79 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
    letterSpacing: .3,
  );

  static final TextStyle _lightScreenSubTitle2TextStyle = TextStyle(
    fontSize: 1.60 * SizeConfig.textMultiplier,
    color: _lightOnPrimaryColor,
    letterSpacing: .10,
  );

  // ---------------------------------------------------------
  // DARK THEME
  // ---------------------------------------------------------

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryColor,

    appBarTheme: AppBarTheme(
      backgroundColor: _lightPrimaryVariantColor, // ORANGE
      surfaceTintColor: Colors.transparent, // VERY IMPORTANT
      toolbarTextStyle: _lightAppBarTextTextTheme.displayLarge,
      elevation: 8.0,
      iconTheme: const IconThemeData(
        color: _lightButtonTextColor,
      ),
    ),

    colorScheme: const ColorScheme.light(
      primary: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),

    iconTheme: const IconThemeData(
      color: _darkIconColor,
    ),

    primaryIconTheme: const IconThemeData(color: _darkPrimaryIconThemeColor),

    textTheme: _darkTextTheme,

    buttonTheme: _darkButtonThemeData,

    canvasColor: _darkPrimaryColor,

    dividerColor: _darkDividerColor,

    // Card Theme (FIXED HERE)
    cardTheme: CardThemeData(
      elevation: 6.0,
      color: _darkCardColor,
      shadowColor: _darkShadowColor,
    ),

    inputDecorationTheme: _darkInputDecorationTheme,
  );

  static final InputDecorationTheme _darkInputDecorationTheme =
      InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _darkPrimaryVariantColor!),
      borderRadius: BorderRadius.circular(20.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _darkPrimaryVariantColor!),
    ),
    hintStyle: GoogleFonts.ptSans(textStyle: _darkScreenBodyText1TextStyle),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  );

  static final TextTheme _darkAppBarTextTextTheme = TextTheme(
    bodyLarge: GoogleFonts.lobster(textStyle: _darkAppBarHeadline1TextStyle),
  );

  static final TextStyle _darkAppBarHeadline1TextStyle =
      _lightAppBarHeadline1TextStyle.copyWith(
    color: _darkAppBarTextColor,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.oswald(textStyle: _darkScreenHeading1TextStyle),
    bodyMedium: GoogleFonts.ptSans(textStyle: _darkScreenBodyText1TextStyle),
    bodySmall: GoogleFonts.ptSans(textStyle: _darkScreenSubTitle1TextStyle),
  );

  static final TextStyle _darkScreenHeading1TextStyle =
      _lightScreenHeading1TextStyle.copyWith(
    color: _darkOnPrimaryColor,
  );

  static final TextStyle _darkScreenBodyText1TextStyle =
      _lightScreenBodyText1TextStyle.copyWith(
    color: _darkOnPrimaryColor,
  );

  static final TextStyle _darkScreenSubTitle1TextStyle =
      _lightScreenSubTitle1TextStyle.copyWith(
    color: _darkOnPrimaryColor,
  );

  static final TextStyle _darkScreenSubTitle2TextStyle =
      _lightScreenSubTitle2TextStyle.copyWith(
    color: _darkOnPrimaryColor,
  );

  static final ButtonThemeData _darkButtonThemeData =
      _lightButtonThemeData.copyWith(
    buttonColor: _darkButtonColor,
    splashColor: _darkButtonSplashColor,
  );

  static final TextStyle _darkButtonTextTextStyle =
      _lightButtonTextTextStyle.copyWith(
    color: _darkButtonTextColor,
  );

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
