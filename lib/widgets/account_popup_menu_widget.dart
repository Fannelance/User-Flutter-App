import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/account_popup_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupMenuAccountWidget extends StatelessWidget {
  final void Function()? onTap;

  const PopupMenuAccountWidget({
    super.key,
    this.onTap,
  });

  get secureStorage => null;

  @override
  Widget build(BuildContext context) {
    const secureStorage = FlutterSecureStorage();
    Uri url;

    return PopupMenuButton(
      position: PopupMenuPosition.over,
      padding: const EdgeInsets.all(0),
      surfaceTintColor: white,
      color: white,
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 40,
          child: const PopupItemAccountWidget(
            title: 'Reset Password',
          ),
          onTap: () => Navigator.pushNamed(
            context,
            kChangePasswordRoute,
          ),
        ),
        PopupMenuItem(
          height: 40,
          child: const PopupItemAccountWidget(
            title: 'Support',
          ),
          onTap: () async {
            url = Uri(scheme: 'tel', path: '01025042013');
            await launchUrl(url);
          },
        ),
        PopupMenuItem(
          height: 40,
          child: const PopupItemAccountWidget(
            title: 'Logout',
          ),
          onTap: () {
            secureStorage.delete(key: 'token');
            Navigator.pushReplacementNamed(
              context,
              kPhoneNumberRoute,
            );
          },
        ),
        PopupMenuItem(
          height: 40,
          onTap: onTap,
          child: const PopupItemAccountWidget(
            title: 'Delete Account',
          ),
        ),
      ],
    );
  }
}
