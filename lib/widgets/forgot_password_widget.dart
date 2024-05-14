import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/forgot_password_view.dart';
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
        //phone
        //otp
        //change password
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const ForgotPasswordView();
          }),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Forgot Password?',
            style: TextStyle(
              color: grey5,
              fontSize: screenWidth / 22,
            ),
          ),
        ],
      ),
    );
  }
}
