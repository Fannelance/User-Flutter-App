import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/utils.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
     required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final double screenWidth= MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor:white,
      title: Text(
        title,
        style: AppStyles(fontSize: screenWidth/9.7).styleTitle,
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
