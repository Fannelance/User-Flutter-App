import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/views/request_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key, required this.obj});
  final ServicesModel obj;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => RequestView.showDraggableBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(left: 25, right: 25, top: 13),
        width: double.infinity,
        height: screenHeight / 15,
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: kBorder10,
          boxShadow: [
            BoxShadow(
              color: kGrey8,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              obj.serviceIcon,
              width: screenWidth / 12,
              height: screenWidth / 12,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 15),
              child: Text(
                obj.serviceName,
                style: TextStyle(fontSize: screenWidth / 22),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Icon(
              Iconsax.arrow_right_3,
              size: screenWidth / 18,
            )
          ],
        ),
      ),
    );
  }
}
