import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class AuthenticationTextFieldWidget extends StatelessWidget {
  final String hint;
  final Widget? visibilityIcon;
  final TextInputType? inputType;
  final bool obscureText;
  final bool autocorrect;
  final TextEditingController controller;

  const AuthenticationTextFieldWidget({
    super.key,
    required this.hint,
    this.inputType,
    this.obscureText = false,
    this.autocorrect = true,
    this.visibilityIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth - 45,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enableSuggestions: autocorrect,
        autocorrect: autocorrect,
        keyboardType: inputType,
        cursorColor: kBlack,
        decoration: InputDecoration(
          suffixIcon: visibilityIcon,
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          enabledBorder: authenticationBorder,
          focusedBorder: authenticationBorder.copyWith(
            borderSide: const BorderSide(color: kBlack),
          ),
        ),
        onTapOutside: (pointer) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
