import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityEmptyWidget extends StatelessWidget {
  const ActivityEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/activity.svg',
            height: 100,
            width: 70,
            colorFilter: const ColorFilter.mode(
              kGrey6,
              BlendMode.srcIn,
            ),
          ),
          const Text(
            'No Activity Right Now!',
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
