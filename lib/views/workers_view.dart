import 'package:fannelance/extras/extras.dart';
import 'package:fannelance/models/custom_icons_icons.dart';
import 'package:fannelance/models/worker_model.dart';
import 'package:fannelance/widgets/worker_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WorkersView extends StatefulWidget {
  const WorkersView({super.key});

  @override
  State<WorkersView> createState() => _WorkersViewState();
}

class _WorkersViewState extends State<WorkersView> {
  List<WorkersModel> workersList = [];

  @override
  void initState() {
    super.initState();
    getWorkersList();
  }

  void getWorkersList() async {
    List<WorkersModel>? loadedWorkers = await WorkersModel.loadAndParseJson();
    setState(() {
      workersList = loadedWorkers;
    });
  }

  @override
  Widget build(context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            IconButton(
              padding: const EdgeInsets.only(left: 18, top: 50),
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                CustomIcons.backarrow,
                size: screenWidth/15,
                color: AppColors.black,
              )),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Best cleaners in your hands",
               style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: screenWidth/13, height: 1.2),
            ),
          ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              padding: const EdgeInsets.only(right: 35),
              onPressed: () {},
              icon: Icon(
                Iconsax.setting_4,
                size: screenWidth/16,
                color: AppColors.black,
              )),
          ],
        ),
        
        Expanded(
          child: GridView.builder(
            padding:const EdgeInsets.only(left: 10,right: 10,bottom: 15,top: 1),
            itemCount: workersList.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.75,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return WorkerWidget(
                obj: workersList[index],
              );
            }
          ),
        )
      ]),
    );
  }
}
