import 'package:fannelance/core/stripe_service.dart';
import 'package:fannelance/core/styles.dart';
import 'package:fannelance/models/custom_icons_icons.dart';
import 'package:fannelance/models/payment_intent_input_model.dart';
import 'package:fannelance/models/worker_model.dart';
import 'package:fannelance/widgets/profile_picture_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class WorkerWidget extends StatelessWidget {
  const WorkerWidget({super.key, required this.obj});
  final WorkersModel obj;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        PaymentIntentInputModel paymentIntentInputModel =
            PaymentIntentInputModel(amount: 40, currency: 'EGP');
        StripeService.makePayment(paymentIntentInputModel);
      },
      child: Container(
        height: screenWidth / 3,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyC8,
                blurRadius: 1,
              )
            ]),
        child: Column(
          children: [
            //image
            ProfilePicture(
                imagePath: obj.workerPhoto, defaultIcon: Icons.account_circle),
            const Spacer(
              flex: 1,
            ),
            //name
            Text(
              textAlign: TextAlign.center,
              obj.workerName,
              maxLines: 2,
              style: TextStyle(fontSize: screenWidth / 19, height: 1),
            ),
            const Spacer(
              flex: 1,
            ),

            //rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBarIndicator(
                  rating: 3.5,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  itemCount: 5,
                  itemSize: screenWidth / 20,
                  unratedColor: Colors.black.withAlpha(50),
                  direction: Axis.horizontal,
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: AppColors.greyC8,
              height: 25,
            ),

            //price + location
            Row(
              children: [
                //price
                Icon(FontAwesome.pound,
                    size: screenWidth / 28, color: AppColors.grey5),
                Text(
                  obj.workerHourlyRate.toString(),
                  style: TextStyle(
                      color: AppColors.grey5, fontSize: screenWidth / 25),
                ),
                Text(
                  "/hour",
                  style: TextStyle(
                      color: AppColors.grey5, fontSize: screenWidth / 25),
                ),
                const Spacer(),
                //location
                Icon(CustomIcons.location,
                    size: screenWidth / 28, color: AppColors.grey5),
                const SizedBox(width: 2),
                Text(
                  obj.workerLocation,
                  style: TextStyle(
                      color: AppColors.grey5, fontSize: screenWidth / 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
