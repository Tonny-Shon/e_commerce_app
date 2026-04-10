import 'package:e_commerce_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/outline_button_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/text_theme.dart';
import 'package:e_commerce_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class EAppTheme {
  EAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: EColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: ETextTheme.lightText,
    elevatedButtonTheme: EButtonTheme.lightButton,
    checkboxTheme: ECheckBox.lightCheckBoxTheme,
    bottomSheetTheme: EBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: ETextFormFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: EOutlineButtonTheme.lightOutlineButton,
    appBarTheme: EAppBarTheme.lightAppBar,
    chipTheme: EChipTheme.lightChipTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: EColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: ETextTheme.darkTheme,
    elevatedButtonTheme: EButtonTheme.darkButton,
    checkboxTheme: ECheckBox.darkCheckBoxTheme,
    bottomSheetTheme: EBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: ETextFormFieldTheme.darkInputDecorationTheme,
    outlinedButtonTheme: EOutlineButtonTheme.darkOutlineButton,
    appBarTheme: EAppBarTheme.darkAppBar,
    chipTheme: EChipTheme.darkChipTheme,
  );
}
