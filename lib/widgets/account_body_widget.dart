import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/account_listtile_widget.dart';
import 'package:fannelance/widgets/account_showdialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class BodyAccountWidget extends StatefulWidget {
  const BodyAccountWidget({
    super.key,
    required this.userData,
  });

  final dynamic userData;

  @override
  State<BodyAccountWidget> createState() => _BodyAccountWidgetState();
}

class _BodyAccountWidgetState extends State<BodyAccountWidget> {
  Future<String> getCurrentLocation(double lat, double long) async {
    List<Placemark> location = await placemarkFromCoordinates(lat, long);
    Placemark place = location[0];

    return "${place.locality}, ${place.subAdministrativeArea}";
  }

  String? locationString;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    String userName =
        toBeginningOfSentenceCase('${widget.userData!['firstname']} ') +
            toBeginningOfSentenceCase('${widget.userData!['lastname']}');

    final latitude = widget.userData['location']['coordinates'][0];
    final longitude = widget.userData['location']['coordinates'][1];

    if (locationString == null) {
      getCurrentLocation(latitude, longitude).then((location) {
        setState(() {
          locationString = location;
        });
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Column(
        children: [
          box_60,
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowDialogAccountWidget(),
            ],
          ),
          CircleAvatar(
            radius: screenWidth / 9,
            backgroundImage: widget.userData!['gender'] == 'female'
                ? const AssetImage(
                    'assets/icons/female.png',
                  )
                : const AssetImage(
                    'assets/icons/male.png',
                  ),
          ),
          box_10,
          Text(
            userName,
            style: TextStyle(
              fontSize: screenWidth / 18,
              fontFamily: kBold,
            ),
          ),
          box_50,
          ListTileAccountWidget(
            title: 'Username',
            subTitle: userName,
            icon: FontAwesome.user,
          ),
          ListTileAccountWidget(
            title: 'Email',
            subTitle: widget.userData!['email'],
            icon: Icons.mail,
          ),
          ListTileAccountWidget(
            title: 'Phone number',
            subTitle: widget.userData!['phone'],
            icon: Iconsax.mobile5,
          ),
          ListTileAccountWidget(
            title: 'Location',
            subTitle: locationString ?? 'Loading...',
            icon: Icons.location_on,
          ),
        ],
      ),
    );
  }
}
