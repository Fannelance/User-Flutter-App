import 'package:fannelance/core/constants.dart';
import 'package:fannelance/services/Close_workers_service.dart';
import 'package:fannelance/widgets/circular_indicator_widget.dart';
import 'package:fannelance/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationListViewWidget extends StatefulWidget {
  const NotificationListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationListViewWidgetState createState() =>
      _NotificationListViewWidgetState();
}

class _NotificationListViewWidgetState
    extends State<NotificationListViewWidget> {
  late Future<dynamic> _workersFuture;

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  void _loadWorkers() {
    setState(() {
      _workersFuture = CloseWorkersService().closeWorkersRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: _workersFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                    box_15,
                    const Center(child: CircularIndicatorWidget()),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                print(snapshot.data);
                return snapshot.data['data']!.isEmpty
                    ? SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screenWidth / 1.5,
                              child: const Text(
                                  'We’re sorry, all workers are busy.',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: kBold),
                                  textAlign: TextAlign.center),
                            ),
                            IconButton(
                                icon: const Icon(Icons.refresh),
                                onPressed: _loadWorkers,
                                color: kBlack),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: snapshot.data['data']!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NotificationWidget(
                            workerData: snapshot.data['data'][index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(thickness: 0.5);
                        },
                      );
              }
            },
          ),
        ),
      ],
    );
  }
}
