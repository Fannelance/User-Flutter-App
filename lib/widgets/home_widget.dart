import 'package:fannelance/extras/extras.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/views/workers_view.dart';
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
          SizedBox(
            height: screenWidth/4.4,
            width: screenWidth/4.4,
            child: Card(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: AppColors.greyE8,
              shadowColor:AppColors.black9,
              elevation: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  obj.serviceIcon,
                ),
              ),
            ),
          ),

         
          Text(
            obj.serviceName,
            style: TextStyle(fontSize: screenWidth/26),
          )
        ],
      ),
    );
  }
}
