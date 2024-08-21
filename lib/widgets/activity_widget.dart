import 'package:fannelance/core/assets.dart';
import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityWidget extends StatelessWidget {
  final dynamic userData;
  const ActivityWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    String userName = toBeginningOfSentenceCase('${userData!['firstname']} ') +
        toBeginningOfSentenceCase('${userData!['lastname']}');
    String jobTitle = userData['jobTitle'];
    String rate = userData['rate'].toStringAsFixed(1);
    String phoneNumber = userData['phone'];
    DateTime createdAt = DateTime.parse(userData['request_date']);
    DateTime localDate = createdAt.toLocal();
    String formattedDate = DateFormat('dd MMM HH:mm').format(localDate);

    var textStyle = TextStyle(
      fontSize: screenWidth / 26,
      fontFamily: kSemiBold,
      color: kGrey6,
    );
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: kBlack,
        child: CircleAvatar(
          radius: 27,
          backgroundColor: kWhite,
          child: CircleAvatar(
            radius: 24,
            backgroundImage: userData!['gender'] == 'female'
                ? AssetsData.workerFemale
                : AssetsData.workerMale,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: textStyle.copyWith(
                  color: kBlack,
                  fontSize: screenWidth / 24,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: screenWidth / 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, top: 2),
                    child: Text(
                      rate,
                      style: textStyle,
                    ),
                  ),
                ],
              ),
              Text(
                jobTitle,
                style: textStyle,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                minWidth: 35,
                height: 35,
                color: kGreen,
                onPressed: () async {
                  await launchUrl(Uri(
                    scheme: 'tel',
                    path: phoneNumber,
                  ));
                },
                shape: const CircleBorder(
                  side: BorderSide(
                    color: kGreen,
                  ),
                ),
                child: const Icon(
                  Icons.phone,
                  color: kWhite,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formattedDate,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
