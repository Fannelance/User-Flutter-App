import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:fannelance/widgets/forgot_password_widget.dart';
import 'package:fannelance/widgets/password_textfield_widget.dart';
import 'package:flutter/material.dart';

class ChangePasswordview extends StatefulWidget {
  const ChangePasswordview({super.key});

  @override
  State<ChangePasswordview> createState() => ChangePasswordviewState();
}

class ChangePasswordviewState extends State<ChangePasswordview> {
  static var passwordController = TextEditingController();
  static var newPasswordController = TextEditingController();
  static var repeatedNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const SubAppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box_20,
            // Title
            Text(
              'Change password',
              style: TextStyle(
                fontSize: screenWidth / 11,
                fontFamily: bold,
              ),
            ),
            box_20,
            PasswordTextFieldWidget(
              hint: 'Current password',
              controller: passwordController,
            ),
            box_20,
            PasswordTextFieldWidget(
              hint: 'New password',
              controller: newPasswordController,
            ),
            box_20,
            PasswordTextFieldWidget(
              hint: 'Re-type new password',
              controller: repeatedNewPasswordController,
            ),
            box_20,
            const AuthenticationButtonWidget(buttonText: 'Change password'),
            box_20,
            const ForgotPasswordWidget(),
          ],
        ),
      ),
    );
  }
}
