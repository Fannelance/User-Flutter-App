import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/services_model.dart';
import 'package:fannelance/views/request_view.dart';
import 'package:flutter/material.dart';

class ServiceSearchWidget extends StatelessWidget {
  final Function(int) onNavigate;
  final ServicesModel obj;
  final Function addToSearchHistoryList;

  const ServiceSearchWidget({
    super.key,
    required this.obj,
    required this.addToSearchHistoryList,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestView(
              jobTitle: obj.jobTitle,
              onNavigate: onNavigate,
            ),
          ),
        );
        addToSearchHistoryList(obj);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 16,
        ),
        child: Row(
          children: [
            SizedBox(
              height: screenWidth / 7.5,
              width: screenWidth / 7.5,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: kBorder10,
                ),
                color: kGreyE8,
                shadowColor: kGrey9,
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(obj.serviceIcon),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              obj.serviceName,
              style: TextStyle(
                fontSize: screenWidth / 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
