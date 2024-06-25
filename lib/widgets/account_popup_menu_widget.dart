import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupMenuAccountWidget extends StatelessWidget {
  final void Function()? onTapDelete;
  final void Function()? onTapLogout;

  const PopupMenuAccountWidget({
    super.key,
    this.onTapDelete,
    this.onTapLogout,
  });

  get secureStorage => null;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    TextStyle textStyle = TextStyle(
      fontSize: screenWidth / 25,
    );

    Uri url;

    return PopupMenuButton(
      position: PopupMenuPosition.over,
      padding: const EdgeInsets.all(0),
      surfaceTintColor: kWhite,
      color: kWhite,
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 40,
          child: Text(
            'Reset Password',
            style: textStyle,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              kChangePasswordRoute,
            );
          },
        ),
        PopupMenuItem(
          height: 40,
          child: Text(
            'Support',
            style: textStyle,
          ),
          onTap: () async {
            url = Uri(
              scheme: 'tel',
              path: '01025042013',
            );
            await launchUrl(url);
          },
        ),
        PopupMenuItem(
          height: 40,
          onTap: onTapLogout,
          child: Text(
            'Logout',
            style: textStyle,
          ),
        ),
        PopupMenuItem(
          height: 40,
          onTap: onTapDelete,
          child: Text(
            'Delete Account',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
