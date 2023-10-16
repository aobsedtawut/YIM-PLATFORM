import 'package:flutter/material.dart';

ThemeData yimTheme(BuildContext context) {
  return ThemeData(
    fontFamily: 'totae',
    primaryColor: Colors.yellow,
    scaffoldBackgroundColor: grayD3,
    colorScheme: ThemeData()
        .colorScheme
        .copyWith(primary: const Color.fromARGB(255, 155, 140, 5)),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: grayD3,
    ),
  );
}

const Color cream = Color.fromARGB(255, 248, 236, 189);
const Color gray1D = Color(0xFF1D1D1D);

const Color grayD3 = Color.fromARGB(255, 116, 115, 115);
