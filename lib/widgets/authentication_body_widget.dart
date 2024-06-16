import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:fannelance/widgets/password_textfield_widget.dart';
import 'package:flutter/material.dart';

class AuthenticationBodyWidget extends StatefulWidget {
  final Widget? registrationData;
  final Widget? noteText;
  final Widget? helperTextWidget;
  final Widget? suggestionText;
  final String title;
  final String helperText;
  final String buttonText;
  final Future<void> Function() buttonOnPressed;

  const AuthenticationBodyWidget({
    super.key,
    this.noteText,
    required this.buttonText,
    this.suggestionText,
    required this.title,
    required this.buttonOnPressed,
    this.registrationData,
    required this.helperText,
    this.helperTextWidget,
  });

  @override
  State<AuthenticationBodyWidget> createState() =>
      AuthenticationBodyWidgetState();
}

class AuthenticationBodyWidgetState extends State<AuthenticationBodyWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          box_20,
          // Title
          Text(
            widget.title,
            style: TextStyle(
              fontSize: screenWidth / 11,
              fontFamily: bold,
            ),
          ),
          box_5,

          // Helper text
          Text(
            widget.helperText,
            maxLines: 3,
            style: TextStyle(
              color: kGrey7,
              height: 1.4,
              fontSize: screenWidth / 21,
            ),
          ),

          widget.helperTextWidget ?? Container(),    
          box_30,

          // Username + Email
          if (widget.registrationData != null) widget.registrationData!,

          // Password
          PasswordTextFieldWidget(
            hint: 'Password',
            controller: ChangePasswordviewState.passwordController,
          ),

          // Note
          if (widget.noteText != null) widget.noteText!,
          box_20,

          // Button
          AuthenticationButtonWidget(
            buttonText: widget.buttonText,
            buttonOnPressed: widget.buttonOnPressed,
          ),
          box_20,

          // Forgot password
          if (widget.suggestionText != null) widget.suggestionText!
        ],
      ),
    );
  }
}
