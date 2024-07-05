import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/views/request_view.dart';
import 'package:flutter/material.dart';

class ServiceHomeWidget extends StatelessWidget {
  const ServiceHomeWidget({super.key, required this.servicesModel});
  final ServicesModel servicesModel;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final serviceName = servicesModel.serviceName;
    final jobTitle = servicesModel.jobTitle;
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RequestView(jobTitle: jobTitle)))
      },
      child: Column(
        children: [
          Container(
            height: screenWidth / 6,
            width: screenWidth / 6,
            decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: kBorder10,
              boxShadow: [
                BoxShadow(
                  color: kGrey8,
                  blurRadius: 0.02,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                servicesModel.serviceIcon,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              serviceName.split(' ').length > 1
                  ? serviceName.split(' ')[1]
                  : serviceName,
              style: TextStyle(
                fontSize: screenWidth / 32,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
