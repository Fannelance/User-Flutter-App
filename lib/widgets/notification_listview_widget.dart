import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

class NotificationListViewWidget extends StatelessWidget {
  const NotificationListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        box_50,
        const Padding(
          padding: EdgeInsets.only(left: 20,),
          child: Text(
            'Get one of these offers',
            style: TextStyle(
              fontSize: 20,
              fontFamily: kBold
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return const NotificationWidget();
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(thickness: 0.5);
            },
          ),
        ),
      ],
    );
  }
}
