import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/authentication_textfield_widget.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:flutter/material.dart';

class AuthenticationBodyWidget extends StatefulWidget {
  final Widget? userNameTextField;
  final Widget? noteText;
  final Widget? suggestionText;
  final String title;
  final String buttonText;
  final Future<void> Function() buttonOnPressed;

  const AuthenticationBodyWidget({
    super.key,
    this.noteText,
    required this.buttonText,
    this.suggestionText,
    required this.title,
    required this.buttonOnPressed,
    this.userNameTextField,
  });

  @override
  State<AuthenticationBodyWidget> createState() =>
      AuthenticationBodyWidgetState();
}

class AuthenticationBodyWidgetState extends State<AuthenticationBodyWidget> {
  static TextEditingController passwordController = TextEditingController();

  static bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          box_20,
          //title
          Text(
            widget.title,
            style: TextStyle(
                fontSize: screenWidth / 18, fontWeight: FontWeight.bold),
          ),
          box_30,

          //user name
          if (widget.userNameTextField != null) widget.userNameTextField!,

          //password
          AuthenticationTextFieldWidget(
            hint: 'Password',
            obscureText: obscureText,
            autocorrect: false,
            visibilityIcon: IconButton(
              padding: const EdgeInsets.only(right: 20),
              icon: Icon(
                color: grey7,
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
            input: passwordController,
          ),

          //note
          if (widget.noteText != null) widget.noteText!,
          box_20,

          //button
          AuthenticationButtonWidget(
            buttonText: widget.buttonText,
            buttonOnPressed: widget.buttonOnPressed,
          ),

          //suggestion
          if (widget.suggestionText != null) widget.suggestionText!
        ],
      ),
    );
  }
}
