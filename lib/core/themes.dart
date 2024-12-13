import 'package:flutter/material.dart';

abstract class Themes {
  static ThemeData mainTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      useMaterial3: true,
      fontFamily: 'itim',
      scaffoldBackgroundColor: Colors.transparent
  );
}