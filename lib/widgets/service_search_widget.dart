import 'package:fannelance/core/utils.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:flutter/material.dart';

class ServiceSearchWidget extends StatelessWidget {
  final ServicesModel obj;
  const ServiceSearchWidget({
    super.key,
    required this.obj,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: Row(
        children: [
          CardServiceWidget(
            border: 10,
            height: screenWidth / 7.5,
            width: screenWidth / 7.5,
            image: obj.serviceIcon,
            padding: screenWidth / 60,
          ).cardWidget,
          const SizedBox(
            width: 16,
          ),
          Text(
            obj.serviceName,
            style: TextStyle(
              fontSize: screenWidth / 20,
            ),
          ),
        ],
      ),
    );
  }
}
