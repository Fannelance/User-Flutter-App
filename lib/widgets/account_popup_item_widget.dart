import 'package:flutter/material.dart';

class PopupItemAccountWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;

  const PopupItemAccountWidget({
    super.key,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 25,
        ),
      ),
    );
  }
}
