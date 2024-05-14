import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class DropDownMenuWidget extends StatefulWidget {
  const DropDownMenuWidget({
    super.key,
  });

  @override
  State<DropDownMenuWidget> createState() => DropDownMenuWidgetState();
}

class DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  static String gender = '';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const materialStatePropertyAll = MaterialStatePropertyAll(white);
    return DropdownMenu(
      onSelected: (value) {
        if (value != null) {
          gender = value;
        }
      },
      menuStyle: const MenuStyle(
        backgroundColor: materialStatePropertyAll,
        surfaceTintColor: materialStatePropertyAll,
      ),
      trailingIcon: const Icon(
        Icons.arrow_drop_down,
        size: 30,
        color: grey7,
      ),
      hintText: 'Gender',
      width: screenWidth - 50,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: grey6,
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
