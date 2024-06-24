import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/forgot_password_service.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:fannelance/widgets/password_textfield_widget.dart';
import 'package:fannelance/widgets/app_bar_sub_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  static var newPasswordController = TextEditingController();
  static var repeatedNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const AppBarSubWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box_20,
            // Title
            Text(
              'Create a new password',
              style: TextStyle(
                fontSize: screenWidth / 11,
                fontFamily: kBold,
                height: 1.1,
              ),
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
            AuthenticationButtonWidget(
              buttonOnPressed: () async {
                await ForgotPasswordService().forgotPasswordRequest(context);
              },
              buttonText: 'Confirm',
            )
          ],
        ),
      ),
    );
  }
}
