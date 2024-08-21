import 'dart:async';
import 'package:fannelance/core/assets.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/worker_notificationdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class NotificationWidget extends StatefulWidget {
  final Function(int) onNavigate;
  final dynamic workerData;
  final void Function(String) selectedWorker;
  const NotificationWidget({
    super.key,
    required this.workerData,
    required this.selectedWorker,
    required this.onNavigate,
  });

  @override
  NotificationWidgetState createState() => NotificationWidgetState();
}

class NotificationWidgetState extends State<NotificationWidget> {
  bool isVisible = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 10), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    String userName =
        toBeginningOfSentenceCase('${widget.workerData!['firstname']} ') +
            toBeginningOfSentenceCase('${widget.workerData!['lastname']}');
    String distance =
        (widget.workerData!['distance'] / 1000).toStringAsFixed(2);
    String rate = widget.workerData!['rate'].toStringAsFixed(1);
    String price = widget.workerData!['price'].toStringAsFixed(1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onRequest(context);
            },
            splashColor: Colors.grey.withOpacity(0.3),
            highlightColor: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: kBlack,
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: kWhite,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: widget.workerData!['gender'] == 'female'
                        ? AssetsData.workerFemale
                        : AssetsData.workerMale,
                  ),
                ),
              ),
              title: Text(
                userName,
                style: TextStyle(
                  fontSize: screenWidth / 22,
                  fontFamily: kBold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        size: 16,
                        Icons.location_on,
                        color: kGrey3,
                      ),
                      Text(
                        '$distance km',
                        style: TextStyle(
                          fontSize: screenWidth / 32,
                          fontFamily: kBold,
                          color: kGrey3,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$price EGP/Hour',
                    style: TextStyle(
                      fontSize: screenWidth / 32,
                      fontFamily: kBold,
                      color: kGrey3,
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    rate,
                    style: TextStyle(
                      fontSize: screenWidth / 30,
                      fontFamily: kBold,
                    ),
                  ),
                  const Icon(
                    size: 16,
                    Icons.star,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onRequest(BuildContext context) {
    print('ListTile tapped!');
    widget.selectedWorker(widget.workerData!['_id']);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerNotificationDialog(
          workerData: widget.workerData,
          onNavigate: widget.onNavigate,
        ),
      ),
    );
  }
}
