import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String? imagePath;
  final IconData defaultIcon;

  const ProfilePicture({
    super.key,
    required this.imagePath,
    required this.defaultIcon,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth/4.5,
      height: screenWidth/4.5,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: imagePath != null
        ? ClipOval(
            child: Image.network(
              imagePath!,
              fit: BoxFit.cover,
            ),
          )
        : Icon(
            defaultIcon,
          ),
    );
  }
}
