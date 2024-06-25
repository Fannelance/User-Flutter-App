import 'dart:async';

import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/stripe_service.dart';
import 'package:fannelance/widgets/notification_button_widget.dart';
import 'package:fannelance/widgets/timer_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class NotificationWidget extends StatefulWidget {
  final dynamic workerData;
  const NotificationWidget({super.key, required this.workerData});

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
        isVisible = false;
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

    return isVisible
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TimerBar(
                duration: Duration(seconds: 10), // Duration for the timer
                color: kBlack, // Color of the timer bar
              ),
              box_5,
              Material(
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundColor: kBlack,
                    child: CircleAvatar(
                      radius: 27,
                      backgroundColor: kWhite,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(
                          'assets/icons/worker_male.png',
                        ),
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
                  subtitle: Row(
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: NotificationButtonWidget(
                    text: 'Confirm',
                    color: kBlack,
                    onPressed: () async {
                      // Navigator.pop(context);
                      print("Confirm");
                      await StripeService.handlePayment(context);
                    }),
              ),
            ],
          )
        : const SizedBox();
  }
}
