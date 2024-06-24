import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/routes.dart';
import 'package:fannelance/services/stripe_service.dart';
import 'package:fannelance/widgets/notification_button_widget.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        box_5,
        ListTile(
          leading: const CircleAvatar(
            radius: 28,
            backgroundColor: kBlack,
            child: CircleAvatar(
              radius: 27,
              backgroundColor: kWhite,
              child: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                  'assets/icons/worker_male.png',
                ),
              ),
            ),
          ),
          title: Text(
            'John Doe',
            style: TextStyle(
              fontSize: screenWidth / 22,
              fontFamily: kBold,
            ),
          ),
          subtitle: Text(
            '5 kms away',
            style: TextStyle(
              fontSize: screenWidth / 24,
              fontFamily: kBold,
              color: kGrey3,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(
                '4.8',
                style: TextStyle(
                  fontSize: screenWidth / 24,
                  fontFamily: kBold,
                ),
              ),
            ],
          ),
          // trailing: trailing,
        ),
        box_15,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NotificationButtonWidget(
                text: 'Accept',
                color: kGreen,
                onPressed: () async {
                  await StripeService.handlePayment(context);
                  if (context.mounted) {
                    Navigator.pushNamed(context, kActivityRoute);
                  }
                },
              ),
              NotificationButtonWidget(
                text: 'Reject',
                color: kRedEc,
                onPressed: () {},
              ),
            ],
          ),
        ),
        box_15,
      ],
    );
  }
}
