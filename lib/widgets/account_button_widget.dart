import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class ButtonAccountWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const ButtonAccountWidget({
    super.key,
    this.onPressed,
    this.text = 'Cancel',
    this.backgroundColor = kBlack,
    this.textColor = kWhite,
    this.borderColor = kBlack,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: () {
        onPressed!();
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        surfaceTintColor: kWhite,
        backgroundColor: backgroundColor,
        fixedSize: Size(
          screenWidth / 3.5,
          screenWidth / 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: kBorder16,
          side: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: screenWidth / 25,
        ),
      ),
    );
  }
}
