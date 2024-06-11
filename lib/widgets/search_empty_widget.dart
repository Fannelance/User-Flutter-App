import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'No recent searches',
          style: TextStyle(
            color: kGrey5,
            fontSize: screenWidth / 24,
          ),
        ),
      ),
    );
  }
}
