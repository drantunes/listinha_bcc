import 'package:flutter/material.dart';

final themeNotifier = ValueNotifier(ThemeMode.light);

class ListinhaTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
      brightness: Brightness.light,
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
      brightness: Brightness.dark,
    ),
  );
}
