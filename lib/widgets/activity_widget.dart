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

    return ListTile(
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: screenWidth / 22,
                  fontFamily: kBold,
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
                      style: TextStyle(
                        fontSize: screenWidth / 24,
                        fontFamily: kBold,
                        color: kGrey5,
                      ),
                    ),
                  ),
                ],
              ),
              // RatingBarIndicator(
              //   rating: 3.5,
              //   itemBuilder: (context, index) => const Icon(
              //     Icons.star,
              //     color: kAmber,
              //   ),
              //   itemCount: 1,
              //   itemSize: screenWidth / 20,
              //   direction: Axis.horizontal,
              // ),
              Text(
                jobTitle,
                style: TextStyle(
                  fontSize: screenWidth / 24,
                  fontFamily: kBold,
                  color: kGrey5,
                ),
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
                  style: TextStyle(
                    fontSize: screenWidth / 24,
                    fontFamily: kBold,
                    color: kGrey5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
