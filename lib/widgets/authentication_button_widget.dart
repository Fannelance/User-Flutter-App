import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class AuthenticationButtonWidget extends StatelessWidget {
  final String buttonText;
  final Future<void> Function()? buttonOnPressed;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;

  const AuthenticationButtonWidget({
    super.key,
    required this.buttonText,
    this.buttonOnPressed,
    this.textColor = kWhite,
    this.buttonColor = kBlack,
    this.borderColor = kBlack,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: buttonOnPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        fixedSize: Size(
          screenWidth - 50,
          screenWidth / 7.3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: kBorder16,
          side: BorderSide(
            color: borderColor!,
          ),
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: screenWidth / 19,
          ),
        ),
      ),
    );
  }
}
