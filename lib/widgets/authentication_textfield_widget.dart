import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class AuthenticationTextFieldWidget extends StatelessWidget {
  final String hint;
  final Widget? visibilityIcon;
  final TextInputType? inputType;
  final bool obscureText;
  final bool autocorrect;
  final TextEditingController input;

  const AuthenticationTextFieldWidget({
    super.key,
    required this.hint,
    this.inputType,
    this.obscureText = false,
    this.autocorrect = true,
    this.visibilityIcon,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth - 45,
      child: TextFormField(
        controller: input,
        obscureText: obscureText,
        enableSuggestions: autocorrect,
        autocorrect: autocorrect,
        keyboardType: inputType,
        cursorColor: black,
        mouseCursor: MouseCursor.uncontrolled,
        autofocus: true,
        decoration: InputDecoration(
          suffixIcon: visibilityIcon,
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          enabledBorder: authenticationBorder,
          focusedBorder: authenticationBorder.copyWith(
              borderSide: const BorderSide(
            color: black,
          )),
          focusColor: black,
        ),
        onTapOutside: (pointer) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
