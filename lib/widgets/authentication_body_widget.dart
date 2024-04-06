import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/utils.dart';
import 'package:fannelance/widgets/authentication_textfield_widget.dart';
import 'package:flutter/material.dart';

class AuthenticationBodyWidget extends StatefulWidget {
  final Widget? usernameTextField;
  final Widget noteText;
  final String buttonText;
  final String questionText;
  final String suggestionText;
  final String title;
  final String subTitle;
  final void Function() onTap;
  final Future<void> Function() buttonOnPressed;

  const AuthenticationBodyWidget({
    super.key,
    this.usernameTextField,
    required this.noteText,
    required this.buttonText,
    required this.questionText,
    required this.suggestionText,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.buttonOnPressed,
  });

  @override
  State<AuthenticationBodyWidget> createState() =>
      AuthenticationBodyWidgetState();
}

class AuthenticationBodyWidgetState extends State<AuthenticationBodyWidget> {
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController mobileNumberController = TextEditingController();

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            //title
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: screenWidth / 13,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            //subtitle
            Row(
              children: [
                Text(
                  widget.subTitle,
                  style: TextStyle(
                    color: grey7,
                    fontSize: screenWidth / 25,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            //username
            if (widget.usernameTextField != null) widget.usernameTextField!,

            //mobile number
            AuthenticationTextFieldWidget(
              hint: 'Mobile number',
              inputType: TextInputType.number,
              countryCode: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '+20  |',
                  style: TextStyle(fontSize: screenWidth / 22),
                ),
              ),
              input: mobileNumberController,
            ),
            const SizedBox(
              height: 20,
            ),
            //password
            AuthenticationTextFieldWidget(
              hint: 'Password',
              obscureText: obscureText,
              autocorrect: false,
              visibilityIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
              input: passwordController,
              // validator: validatePassword,
            ),
            const SizedBox(
              height: 20,
            ),
            //note
            Row(
              children: [
                Flexible(child: widget.noteText),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            //button
            ElevatedButton(
              onPressed: widget.buttonOnPressed,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(
                    double.infinity,
                    50,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(black),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                    color: white,
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //suggestion
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.questionText,
                  style: TextStyle(
                    fontSize: screenWidth / 25,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    widget.suggestionText,
                    style: AppStyles(
                      fontSize: screenWidth / 25,
                    ).styleUnderline,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
