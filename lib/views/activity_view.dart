import 'package:fannelance/services/activity_service.dart';
import 'package:fannelance/widgets/activity_empty_widget.dart';
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
      body: FutureBuilder(
        future: ActivityService().activityRequest(),
        builder: (context, snapshot) {
          var snapData = snapshot.data?['data'];
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError) {
            return const CircularIndicatorWidget();
          } else if (!snapshot.hasData ||
              (snapData as List).isEmpty ||
              snapshot.data == null) {
            return const ActivityEmptyWidget();
          } else {
            final reversedRequests = snapData.reversed.toList();
            return ListView.separated(
              itemCount: snapData.length,
              itemBuilder: (context, index) {
                return ActivityWidget(
                  userData: reversedRequests[index],
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
