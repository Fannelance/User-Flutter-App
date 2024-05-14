import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/authentication_textfield_widget.dart';
import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const PasswordTextFieldWidget({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      PasswordTextFieldWidgetState();
}

class PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationTextFieldWidget(
      hint: widget.hint,
      controller: widget.controller,
      obscureText: obscureText,
      autocorrect: false,
      visibilityIcon: IconButton(
        padding: const EdgeInsets.only(
          right: 20,
        ),
        icon: Icon(
          size: 22,
          color: grey7,
          obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
    );
  }
}
