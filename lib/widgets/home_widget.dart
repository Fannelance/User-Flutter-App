import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/widgets/service_search_widget.dart';
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
          CardServiceWidget(
            border: 20,
            height: screenWidth / 5.5,
            width: screenWidth / 5.5,
            image: obj.serviceIcon,
            padding: 16,
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
