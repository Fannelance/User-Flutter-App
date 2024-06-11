import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.obj});
  final ServicesModel obj;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          kWorkersRoute,
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: screenWidth / 5.5,
            width: screenWidth / 5.5,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: kBorder20,
              ),
              color: kGreyE8,
              shadowColor: kGrey9,
              elevation: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(obj.serviceIcon),
              ),
            ),
          ),
          Text(
            obj.serviceName.split(' ').length > 1
                ? obj.serviceName.split(' ')[1]
                : obj.serviceName,
            style: TextStyle(fontSize: screenWidth / 32),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
