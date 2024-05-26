import 'package:fannelance/widgets/activity_widget.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Activity'),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Column(
            children: [
              ActivityWidget(),
              Divider(thickness: 0.5),
            ],
          );
        },
      ),
    );
  }
}
