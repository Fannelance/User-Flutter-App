import 'package:fannelance/widgets/notification_listview_widget.dart';
import 'package:flutter/material.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => RequestViewState();
}

class RequestViewState extends State<RequestView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotificationListViewWidget(),
    );
  }
  //   return Scaffold(
  //     body: !snapshot.hasData
  //         ? const Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               CircularIndicatorWidget(),
  //               Text(
  //                 'Searching for a technician near you, please wait.',
  //               ),
  //             ],
  //           )
  //         : isAvailable
  //             ? const NotificationDetailsListViewWidget()
  //             : Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const Center(
  //                     child: Text(
  //                       'Sorry, there are no available workers. Please try later.',
  //                     ),
  //                   ),
  //                   MaterialButton(
  //                     color: kWhite,
  //                     onPressed: () {
  //                       setState(() {
  //                         isAvailable = !isAvailable;
  //                       });
  //                     },
  //                     child: const Text('Retry'),
  //                   ),
  //                 ],
  //               ),
  //   );
  // }
}
