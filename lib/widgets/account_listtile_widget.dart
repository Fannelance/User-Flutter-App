import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class ListTileAccountWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final IconData icon;
  const ListTileAccountWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: kGrey9,
          ),
          title: Text(
            title ?? "",
            style: TextStyle(
              color: kGrey7,
              fontSize: screenWidth / 24,
            ),
          ),
          subtitle: Text(
            subTitle ?? "",
            style: TextStyle(
              color: kBlack,
              fontSize: screenWidth / 26,
            ),
          ),
        ),
        const Divider(
          indent: 55,
          endIndent: 20,
          thickness: 0.2,
          color: kGrey7,
          height: 0,
        ),
      ],
    );
  }
}
