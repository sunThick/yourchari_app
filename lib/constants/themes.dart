import 'package:flutter/material.dart';

ThemeData lightThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromARGB(255, 212, 212, 212),
        secondary: const Color.fromARGB(255, 217, 217, 217)),
  );
}

ThemeData darkThemeData() {
  return ThemeData(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: Colors.blueGrey, secondary: Colors.amber),
      textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)));
}
