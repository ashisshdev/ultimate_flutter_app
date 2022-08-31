import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
    // implement page transition theme
    );

ThemeData darkTheme = ThemeData.dark().copyWith(
    // implement page transition theme
    );

ThemeData pinkTheme = lightTheme.copyWith(
    primaryColor: const Color(0xFFF49FB6),
    scaffoldBackgroundColor: const Color(0xFFF49FB6),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Color(0xFF24737c),
      backgroundColor: Color(0xFFA6E0DE),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black87,
      ),
    ));

ThemeData halloweenTheme = lightTheme.copyWith(
  primaryColor: const Color(0xFF55705A),
  scaffoldBackgroundColor: const Color(0xFFE48873),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color(0xFFea8e71),
    backgroundColor: Color(0xFF2b2119),
  ),
);

ThemeData darkBlueTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xFF1E1E2C),
  scaffoldBackgroundColor: const Color(0xFF2D2D44),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF33E1Ed),
    ),
  ),
);

// common appbar, inputTextField , cards and buttons etc..

final allThemes = <String, ThemeData>{
  'dark': darkTheme,
  'light': lightTheme,
  'pink': pinkTheme,
  'darkBlue': darkBlueTheme,
  'halloween': halloweenTheme,
};

/// lmao more themes
/// import 'package:flutter/material.dart';
//
//  class AppThemes {
//   static final appThemeData = {
//     AppTheme.darkTheme: ThemeData(
//       primarySwatch: Colors.grey,
//       primaryColor: Colors.black,
//       brightness: Brightness.dark,
//       backgroundColor: const Color(0xFF212121),
//       dividerColor: Colors.black54,
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: Colors.white,
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: ButtonStyle(
//           foregroundColor: MaterialStateProperty.all(Colors.white),
//         ),
//       ),
//       textTheme: const TextTheme(
//         subtitle1: TextStyle(color: Colors.white),
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor: Colors.grey, unselectedItemColor: Colors.white),
//     ),
//
//     //
//     //
//
//     AppTheme.lightTheme: ThemeData(
//       primarySwatch: Colors.grey,
//       primaryColor: Colors.white,
//       brightness: Brightness.light,
//       backgroundColor: const Color(0xFFE5E5E5),
//       dividerColor: const Color(0xff757575),
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: ButtonStyle(
//           foregroundColor: MaterialStateProperty.all(Colors.black),
//         ),
//       ),
//       textTheme: const TextTheme(
//         subtitle1: TextStyle(color: Colors.black),
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor: Colors.grey,
//           selectedItemColor: Colors.black,
//           unselectedItemColor: Colors.white),
//     ),
//   };
// }
