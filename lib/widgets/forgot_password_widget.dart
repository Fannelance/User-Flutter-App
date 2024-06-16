import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/send_otp_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        SendOtpService().sendOtpRequest();
        Navigator.pushNamed(
          context,
          kOtpForgotPasswordRoute,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Forgot Password?',
            style: TextStyle(
              color: kGrey5,
              fontSize: screenWidth / 24,
            ),
          ),
        ],
      ),
    );
  }
}
