import 'package:flutter/material.dart';

class AppTheme {
  static final colors = _AppColors();

  final dark = ThemeData(
      splashColor: Colors.black,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.gray950,
      textTheme: const TextTheme(),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colors.gray800,
      ),
      platform: TargetPlatform.iOS,
      dividerTheme: DividerThemeData(
        color: AppTheme.colors.gray600,
        space: 30,
        thickness: 1,
      ));
}

class _AppColors {
  final gray950 = const Color(0XFF09090A);
  final gray900 = const Color(0XFF121214);
  final gray800 = const Color(0XFF202024);
  final gray600 = const Color(0XFF323238);
  final gray300 = const Color(0XFFBDBD99);
  final gray200 = const Color(0XFFC4C4CC);

  final green500 = const Color(0XFF047C3F);
  final yellow500 = const Color(0XFFF7DD47);
  final yellow600 = const Color(0XFFBBA317);
  final red500 = const Color(0XFFDB4437);
  final white = const Color(0XFFFFFFFF);
}
