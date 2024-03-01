import 'package:flutter/material.dart';

class AppStyles {
  final double fontSize;
  late final TextStyle styleGrey5;
  late final TextStyle styleUnderline;
  late final TextStyle styleTitle;
  late final TextStyle styleTitle2;
  late final TextStyle styleWorker;

  AppStyles({required this.fontSize}) {
    styleUnderline = TextStyle(
      shadows: const [Shadow(offset: Offset(0, -2))],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationThickness: 1.5,
      fontSize: fontSize,
    );

    styleGrey5 = TextStyle(
      color: const Color(0xff555555),
      fontSize: fontSize,
    );

    styleTitle = TextStyle(
      fontFamily: 'Gilroy-Bold',
      fontSize: fontSize,
    );

    styleTitle2 = TextStyle(
      fontFamily: 'Gilroy-Bold',
      fontSize: fontSize,
      height: 1.2,
    );

    styleWorker = TextStyle(
      fontSize: fontSize,
      height: 1,
    );
  }
}