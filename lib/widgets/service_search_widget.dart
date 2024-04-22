import 'package:fannelance/core/constants.dart';
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
            ),
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

/*------------ EmptySearchWidget ------------*/

class EmptySearchWidget extends StatelessWidget {
  const EmptySearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'No recent searches',
          style: TextStyle(
            fontSize: screenWidth / 20,
          ),
        ),
      ),
    );
  }
}


/*------------ CardServiceWidget ------------*/

class CardServiceWidget extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final double border;
  final String image;

  const CardServiceWidget({
    super.key,
    required this.height,
    required this.width,
    required this.padding,
    required this.border,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border),
        ),
        color: greyE8,
        shadowColor: grey9,
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Image.asset(image),
        ),
      ),
    );
  }
}

