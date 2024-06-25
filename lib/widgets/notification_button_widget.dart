import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class NotificationButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final void Function()? onPressed;
  const NotificationButtonWidget({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialButton(
      color: color,
      elevation: 0,
      minWidth: screenWidth,
      height: screenHeight / 24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: kWhite,
          fontSize: screenWidth / 22,
          fontFamily: kBold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
