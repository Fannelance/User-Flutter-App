import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/notification_listview_widget.dart';
import 'package:flutter/material.dart';

abstract class RequestView extends StatelessWidget {
  const RequestView({super.key});

  static void showDraggableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Starts at 50% of screen height
          minChildSize: 0.25, // Minimum height of 25%
          maxChildSize: 0.75, // Maximum height of 75%
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    height: 4.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: kGrey9,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  const Expanded(
                    child: NotificationListViewWidget(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}

// import 'package:fannelance/widgets/app_bar_sub_widget.dart';
// import 'package:fannelance/widgets/notification_listview_widget.dart';
// import 'package:flutter/material.dart';

// class RequestView extends StatelessWidget {
//   const RequestView({super.key});

//   static void showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return const RequestView();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize:
//             MainAxisSize.min, // Ensures the bottom sheet takes minimal height
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 16.0),
//             height: 4.0,
//             width: 50.0,
//             decoration: BoxDecoration(
//               color: Colors.grey[400],
//               borderRadius: BorderRadius.circular(2.0),
//             ),
//           ),
//           const Expanded(
//             child: NotificationListViewWidget(),
//           ),
//         ],
//       ),
//     );
//   }
// }


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

