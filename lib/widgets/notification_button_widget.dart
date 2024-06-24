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

    return MaterialButton(
      color: color,
      elevation: 0,
      minWidth: screenWidth / 2.3,
      height: 44,
      shape: const RoundedRectangleBorder(
        borderRadius: kBorder16,
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
