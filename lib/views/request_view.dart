import 'dart:async';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/socket_service.dart';
import 'package:fannelance/widgets/app_bar_sub_widget.dart';
import 'package:fannelance/widgets/circular_indicator_widget.dart';
import 'package:fannelance/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

class RequestView extends StatefulWidget {
  final String jobTitle;
  const RequestView({super.key, required this.jobTitle});

  @override
  RequestViewState createState() => RequestViewState();
}

class RequestViewState extends State<RequestView> {
  final List<dynamic> _workers = [];
  bool _isDisposed = false;
  static late SocketService socketService;
  final StreamController<List<dynamic>> _workersStreamController =
      StreamController<List<dynamic>>();

  @override
  void initState() {
    super.initState();
    _initializeSocketService();
    _getAvailableWorkers();
  }

  void _initializeSocketService() async {
    socketService = SocketService();
    await socketService.connect();
  }

  _getAvailableWorkers() {
    socketService.listenToAvailableWorkers(widget.jobTitle,
        (List<dynamic> workers) {
      if (!_isDisposed) {
        setState(() {
          for (var worker in workers) {
            if (!_workers.contains(worker)) _workers.add(worker);
          }

          _workersStreamController.add(_workers);
        });
      }
      _listenToChosenWorker();
    });
  }

  _listenToChosenWorker() {
    socketService.listenToChosenWorker((dynamic workerId) {
      print('Worker has been chosen: $workerId');
      deleteWorkerById(workerId);
    });
  }

  void deleteWorkerById(String id) {
    setState(() {
      _workers.removeWhere((worker) => worker['_id'] == id);
      print('Removed worker: $id');
      _workersStreamController.add(_workers);
    });
  }

  @override
  void dispose() {
    _workers.clear();
    _isDisposed = true;
    _workersStreamController.close();
    socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: true,
      onPopInvoked: (bool value) {
        print('Back button pressed');
      },
      child: Scaffold(
        appBar: const AppBarSubWidget(),
        body: Container(
          decoration: const BoxDecoration(
            color: kWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text(
                  'Here are some of our best workers near you!',
                  style: TextStyle(
                    height: 1.2,
                    fontSize: screenWidth / 17,
                    fontFamily: kBold,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<dynamic>>(
                  stream: _workersStreamController.stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth / 1.5,
                            child: const Text(
                              'The Perfect Workers Are Here for You!',
                              style: TextStyle(fontSize: 18, fontFamily: kBold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Center(child: CircularIndicatorWidget()),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth / 1.5,
                              child: Text(
                                'We’re sorry, all workers are busy.',
                                style: TextStyle(
                                    fontSize: screenWidth / 24,
                                    fontFamily: kBold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () async {
                                _getAvailableWorkers();
                              },
                              color: Colors.black,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NotificationWidget(
                            workerData: snapshot.data?[index],
                            selectedWorker: deleteWorkerById,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(thickness: 0.5),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
