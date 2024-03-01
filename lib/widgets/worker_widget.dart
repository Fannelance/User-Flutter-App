import 'package:fannelance/core/stripe_service.dart';
import 'package:fannelance/core/utils.dart';
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
        PaymentIntentInputModel paymentInputModel =
            PaymentIntentInputModel(amount: 40, currency: 'EGP',customerId: 'cus_PbfjLHEmbwUdrx',);
        StripeService.makePayment(paymentIntentInputModel: paymentInputModel);
      },
      child: Container(
        height: screenWidth / 3,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffC8C8C8),
                blurRadius: 1,
              )
            ]),
        child: Column(
          children: [
            //image
            ProfilePicture(
              imagePath: obj.workerPhoto,
              defaultIcon: Icons.account_circle,
            ),
            const Spacer(
              flex: 1,
            ),
            //name
            Text(
              textAlign: TextAlign.center,
              obj.workerName,
              maxLines: 2,
              style: AppStyles(fontSize: screenWidth / 19).styleWorker,
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
                    color: Color(0xff000000),
                  ),
                  itemCount: 5,
                  itemSize: screenWidth / 20,
                  unratedColor: const Color(0xff000000).withAlpha(50),
                  direction: Axis.horizontal,
                ),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Color(0xffC8C8C8),
              height: 25,
            ),

            //price + location
            Row(
              children: [
                //price
                Icon(
                  FontAwesome.pound,
                  size: screenWidth / 28,
                  color: const Color(0xff555555),
                ),
                Text(
                  obj.workerHourlyRate.toString(),
                  style: AppStyles(fontSize: screenWidth / 25).styleGrey5,
                ),
                Text(
                  "/hour",
                  style: AppStyles(fontSize: screenWidth / 25).styleGrey5,
                ),
                const Spacer(),

                //location
                Icon(
                  CustomIcons.location,
                  size: screenWidth / 28,
                  color: const Color(0xff555555),
                ),
                const SizedBox(width: 2),
                Text(
                  obj.workerLocation,
                  style: AppStyles(fontSize: screenWidth / 25).styleGrey5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
