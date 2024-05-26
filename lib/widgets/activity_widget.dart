import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: SvgPicture.asset(
            'assets/icons/worker.svg',
            width: screenWidth / 7.5,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: "Ahmed Hassan ",
                  style: TextStyle(
                    fontFamily: "Gilroy-Bold",
                    fontSize: screenWidth / 24,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "| Carpenter",
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: screenWidth / 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth / 1.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "50/hour",
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: screenWidth / 26,
                      ),
                    ),
                    Text(
                      '5th Jan 11:00',
                      style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: screenWidth / 26,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
