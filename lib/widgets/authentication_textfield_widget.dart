import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class AuthenticationTextFieldWidget extends StatelessWidget {
  final String hint;
  final Widget? countryCode;
  final Widget? visibilityIcon;
  final TextInputType? inputType;
  final bool obscureText;
  final bool autocorrect;
  final TextEditingController input;

  const AuthenticationTextFieldWidget({
    super.key,
    required this.hint,
    this.inputType,
    this.countryCode,
    this.obscureText = false,
    this.autocorrect = true,
    this.visibilityIcon,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: input,
      obscureText: obscureText,
      enableSuggestions: autocorrect,
      autocorrect: autocorrect,
      keyboardType: inputType,
      cursorColor: black,
      decoration: InputDecoration(
        suffixIcon: visibilityIcon,
        prefixIcon: countryCode,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: greyC8),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: black),
        ),
        focusColor: black,
      ),
      onTapOutside: (pointer) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
