import 'package:flutter/material.dart';
import 'package:travel_log/config/constants/app_color_constant.dart';
import 'package:travel_log/config/constants/theme_constant.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme(bool isDark) {
    return ThemeData(
      // colorScheme:
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: ThemeConstant.darkPrimaryColor,
            )
          : const ColorScheme.light(
              primary: Color.fromARGB(255, 227, 227, 227),
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'Montserrat',
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? Colors.grey[900]
            : const Color.fromARGB(255, 250, 250, 250),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark
            ? Colors.grey[900]
            : const Color.fromARGB(255, 250, 250, 250),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColorConstant.elevatedbutton),
        ),
      ),
    );
  }
}
