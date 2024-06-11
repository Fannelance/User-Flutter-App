import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class AppBarSubWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSubWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: kWhite,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
        ),
        iconSize: screenWidth / 15,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
