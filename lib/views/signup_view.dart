import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/signup_service.dart';
import 'package:fannelance/widgets/authentication_body_widget.dart';
import 'package:fannelance/widgets/authentication_textfield_widget.dart';
import 'package:fannelance/widgets/authentication_dropdown_widget.dart';
import 'package:fannelance/widgets/app_bar_sub_widget.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => SignupViewState();
}

class SignupViewState extends State<SignupView> {
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const AppBarSubWidget(),
      body: AuthenticationBodyWidget(
        title: 'Create Account',
        helperText: 'Get ready to relax while we take care of your home.',
        registrationData: Column(
          children: [
            AuthenticationTextFieldWidget(
              hint: 'First Name',
              controller: firstNameController,
            ),
            box_20,
            AuthenticationTextFieldWidget(
              hint: 'Last Name',
              controller: lastNameController,
            ),
            box_20,
            AuthenticationTextFieldWidget(
              hint: 'Email',
              controller: emailController,
            ),
            box_20,
            const AuthenticationDropdownWidget(),
            box_20,
          ],
        ),
        noteText: Column(
          children: [
            box_10,
            Row(
              children: [
                Flexible(
                  child: Text(
                    'By continuing you agree to our Terms of Service and Privacy Policy.',
                    maxLines: 3,
                    style: TextStyle(
                      color: kGrey5,
                      height: 1.2,
                      fontSize: screenWidth / 26,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        buttonText: 'Sign up',
        buttonOnPressed: () async {
          await SignupService().signupRequest(context);
        },
      ),
    );
  }
}
