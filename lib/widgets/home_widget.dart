import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/views/workers_view.dart';
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const WorkersView();
        }));
      },
      child: Column(
        children: [
          CardServiceWidget(
            border: 20,
            height: screenWidth / 4.4,
            width: screenWidth / 4.4,
            image: obj.serviceIcon,
            padding: 20,
          ),
          Text(
            obj.serviceName,
            style: TextStyle(fontSize: screenWidth / 26),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
