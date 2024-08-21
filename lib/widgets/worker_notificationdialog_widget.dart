import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/routes.dart';
import 'package:fannelance/views/request_view.dart';
import 'package:fannelance/widgets/notification_accepted_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkerNotificationDialog extends StatefulWidget {
  final Function(int) onNavigate;
  final dynamic workerData;

  const WorkerNotificationDialog({
    super.key,
    required this.workerData,
    required this.onNavigate,
  });

  @override
  WorkerNotificationDialogState createState() =>
      WorkerNotificationDialogState();
}

class WorkerNotificationDialogState extends State<WorkerNotificationDialog> {
  late AudioPlayer audioPlayer;
  late String workerId;
  late String userName;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayer.play(AssetSource('sounds/notification.mp3'));
    workerId = widget.workerData['_id'];
    userName = toBeginningOfSentenceCase('${widget.workerData['firstname']} ') +
        toBeginningOfSentenceCase('${widget.workerData['lastname']}');

    RequestViewState.socketService.sendRequest(workerId);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _listenToAcceptedRequest(context);
      },
    );
  }

  void _listenToAcceptedRequest(BuildContext context) {
    RequestViewState.socketService.listenToAcceptedRequest(
      (dynamic requestId) {
        print('Worker has accepted the request: $requestId');
        Navigator.popUntil(context, ModalRoute.withName(kNavbarRoute));
        widget.onNavigate(2);
        NotificationAcceptedWidget().showNotification(context);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              box_100,
              CircularCountDownTimer(
                textFormat: 'ss',
                isReverse: true,
                width: screenWidth / 2.5,
                height: screenWidth / 2.5,
                duration: 10,
                fillColor: const Color.fromARGB(235, 255, 255, 255),
                textStyle: TextStyle(fontSize: screenWidth / 6, color: kBlack),
                strokeWidth: 1,
                ringColor: kBlack,
                onComplete: () {
                  RequestViewState.socketService.sendTimeout(workerId);
                },
              ),
              box_50,
              SizedBox(
                width: screenWidth / 1.5,
                child: Column(
                  children: [
                    Text(
                      'Your request has been sent successfully to $userName!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kBlack,
                        fontFamily: kBold,
                        fontSize: screenWidth / 20,
                      ),
                    ),
                    box_10,
                    Text('Please wait...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kGrey9,
                            fontSize: screenWidth / 25,
                            letterSpacing: 1.2)),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
