import 'package:fannelance/widgets/activity_widget.dart';
import 'package:flutter/material.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 12, left: 8),
          child: Text(
            'Activity',
            style: TextStyle(
                fontFamily: 'Gilroy-Bold', fontSize: screenWidth / 9.7),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Column(
            children: [
              SizedBox(height: 24),
              ActivityWidget(),
              Divider(thickness: 0.5),
            ],
          );
        },
      ),
    );
  }
}
