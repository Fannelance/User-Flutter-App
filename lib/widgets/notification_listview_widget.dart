import 'package:fannelance/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

class NotificationListViewWidget extends StatefulWidget {
  final Function(int) onNavigate;

  final List<dynamic> workersData;
  const NotificationListViewWidget({
    Key? key,
    required this.workersData,
    required this.onNavigate,
  }) : super(key: key);

  @override
  NotificationListViewWidgetState createState() =>
      NotificationListViewWidgetState();
}

class NotificationListViewWidgetState
    extends State<NotificationListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.workersData.length,
      itemBuilder: (BuildContext context, int index) {
        return NotificationWidget(
          workerData: widget.workersData[index],
          selectedWorker: (x) {},
          onNavigate: widget.onNavigate,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(thickness: 0.5),
    );
  }
}
