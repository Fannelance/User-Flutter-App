import 'package:fannelance/extras/extras.dart';
import 'package:fannelance/models/custom_icons_icons.dart';
import 'package:fannelance/models/worker_model.dart';
import 'package:fannelance/widgets/profile_picture_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class WorkerWidget extends StatelessWidget {
  const WorkerWidget({super.key, required this.obj});
  final WorkersModel obj;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth/3,
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
          ProfilePicture(imagePath: obj.workerPhoto, defaultIcon: Icons.account_circle),
          const Spacer(flex: 2,),
          //name
          Text(
            textAlign:TextAlign.center,
            obj.workerName,
            maxLines:2,
            style: TextStyle(fontSize: screenWidth/19,height: 1),
          ),
          const Spacer(flex: 2,),
          //location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CustomIcons.location, size: screenWidth/19, color: AppColors.grey5),
              const SizedBox(width: 2),
              Text(
                obj.workerLocation,
                style: TextStyle(color: AppColors.grey5, fontSize: screenWidth/22),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: AppColors.greyC8,
            height: 15,
          ),
          //price + rating
          Row(
            children: [
              Icon(FontAwesome.pound, size: screenWidth/28, color: AppColors.grey5),
              Text(obj.workerHourlyRate.toString(),
                style: TextStyle(color: AppColors.grey5, fontSize: screenWidth/25),
              ),
              Text("/hour",
                style: TextStyle(color: AppColors.grey5, fontSize: screenWidth/25),
              ),
              const Spacer(),
              Icon(Icons.star,size: screenWidth/24,color: AppColors.orangeff,),
              const SizedBox(width: 1,),
              Text(obj.workerRating.toString(),
                style: TextStyle(color: AppColors.grey5, fontSize: screenWidth/25),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
