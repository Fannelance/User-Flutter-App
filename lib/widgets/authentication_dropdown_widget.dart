import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class AuthenticationDropdownWidget extends StatefulWidget {
  const AuthenticationDropdownWidget({
    super.key,
  });

  @override
  State<AuthenticationDropdownWidget> createState() =>
      AuthenticationDropdownWidgetState();
}

class AuthenticationDropdownWidgetState
    extends State<AuthenticationDropdownWidget> {
  static String gender = '';
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const widgetStatePropertyAll = WidgetStatePropertyAll(kWhite);
    return DropdownMenu(
      onSelected: (value) {
        if (value != null) {
          gender = value;
        }
      },
      menuStyle: const MenuStyle(
        backgroundColor: widgetStatePropertyAll,
        surfaceTintColor: widgetStatePropertyAll,
      ),
      trailingIcon: const Icon(
        Icons.arrow_drop_down,
        size: 30,
        color: kGrey7,
      ),
      hintText: 'Gender',
      width: screenWidth - 50,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: kGrey6,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        enabledBorder: authenticationBorder,
      ),
      dropdownMenuEntries: const <DropdownMenuEntry<String>>[
        DropdownMenuEntry(
          label: 'Male',
          value: 'Male',
        ),
        DropdownMenuEntry(
          label: 'Female',
          value: 'Female',
        ),
      ],
    );
  }
}
