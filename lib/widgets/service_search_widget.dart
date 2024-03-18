import 'package:fannelance/core/utils.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/views/workers_view.dart';
import 'package:flutter/material.dart';

class ServiceSearchWidget extends StatelessWidget {
  final ServicesModel obj;
  final Function addToSearchHistoryList;

  const ServiceSearchWidget({
    super.key,
    required this.obj,
    required this.addToSearchHistoryList,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WorkersView()),
        );
        addToSearchHistoryList(obj);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Row(
          children: [
            CardServiceWidget(
              border: 10,
              height: screenWidth / 7.5,
              width: screenWidth / 7.5,
              image: obj.serviceIcon,
              padding: screenWidth / 60,
            ).cardWidget,
            const SizedBox(
              width: 15,
            ),
            Text(
              obj.serviceName,
              style: TextStyle(
                fontSize: screenWidth / 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Empty Search Widget */

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Text(
        'No recent searches',
        style: TextStyle(
          fontSize: screenWidth / 20,
        ),
      ),
    );
  }
}
