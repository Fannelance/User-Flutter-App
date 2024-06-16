import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/check_phone_number_service.dart';
import 'package:fannelance/services/login_service.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:fannelance/widgets/authentication_body_widget.dart';
import 'package:fannelance/widgets/forgot_password_widget.dart';
import 'package:fannelance/widgets/app_bar_sub_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final helperTextStyle = TextStyle(
      color: kGrey7,
      height: 1.4,
      fontSize: screenWidth / 21,
    );

    return Scaffold(
      appBar: const AppBarSubWidget(),
      body: AuthenticationBodyWidget(
        title: 'Log in',
        helperTextWidget: Text(
          CheckPhoneNumberService.phoneNumber.substring(2),
          maxLines: 3,
          style: helperTextStyle.copyWith(
            color: kGrey3,
            letterSpacing: 1.2,
          ),
        ),
        suggestionText: const ForgotPasswordWidget(),
        buttonText: 'Log in',
        buttonOnPressed: () async {
          await LoginService().loginRequest(context);
          ChangePasswordviewState.passwordController.text = "";
        },
        helperText: 'Enter the password for your account',
      ),
    );
  }
}
