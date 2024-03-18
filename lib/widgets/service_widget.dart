import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/views/workers_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key, required this.obj});
  final ServicesModel obj;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const WorkersView();
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(left: 25, right: 25, top: 13),
        width: double.infinity,
        height: screenWidth/5.5,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff888888),
              blurRadius: 1,
            ),
          ]),
        child: Row(
          children: [
            Image.asset(
              obj.serviceIcon,
              width: screenWidth/11,
              height: screenWidth/11,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 15),
              child: Text(
                obj.serviceName,
                style: TextStyle( fontSize: screenWidth/18),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Icon(
              Iconsax.arrow_right_3,
              size: screenWidth/12,
            )
          ],
        ),
      ),
    );
  }
}
