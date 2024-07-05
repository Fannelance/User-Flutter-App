import 'package:fannelance/services/activity_service.dart';
import 'package:fannelance/widgets/activity_widget.dart';
import 'package:fannelance/widgets/app_bar_main_widget.dart';
import 'package:fannelance/widgets/circular_indicator_widget.dart';
import 'package:flutter/material.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMainWidget(title: 'Activity'),
      body:FutureBuilder(
        future: ActivityService().activityRequest(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularIndicatorWidget();
          } else {
            var activityData = snapshot.data?['data'];
            return ListView.separated(
              itemCount: activityData.length,
              itemBuilder: (context, index) {
                final dynamic user = activityData[index];
                return ActivityWidget(
                  userData: user,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(thickness: 0.5);
              },
            );
          }
        },
      ), 
    );
  }
}
