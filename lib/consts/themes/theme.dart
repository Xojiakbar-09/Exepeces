import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class Apptheme {
 static final  ThemeData light = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Cols.black,
    foregroundColor: Cols.white,
    fixedSize: Size(350, 48)
  )
  ),
    fontFamily: FontFamily.inter,
     scaffoldBackgroundColor: Cols.white,
    colorScheme: ColorScheme.light(  
      primary: Cols.white
    )
  );
  static final  ThemeData dark = ThemeData(
        fontFamily: FontFamily.inter,
     scaffoldBackgroundColor: Cols.white,
    colorScheme: ColorScheme.dark(
      primary: Cols.black
    )
  );
}
