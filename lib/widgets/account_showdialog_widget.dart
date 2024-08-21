import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/routes.dart';
import 'package:fannelance/services/delete_account_service.dart';
import 'package:fannelance/widgets/account_alertdialog_widget.dart';
import 'package:fannelance/widgets/account_popup_menu_widget.dart';
import 'package:flutter/material.dart';

class ShowDialogAccountWidget extends StatefulWidget {
  const ShowDialogAccountWidget({
    super.key,
  });

  @override
  State<ShowDialogAccountWidget> createState() =>
      ShowDialogAccountWidgetState();
}

class ShowDialogAccountWidgetState extends State<ShowDialogAccountWidget> {
  void showDeleteDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Delete Account Dialog
    showDialog(
      context: context,
      builder: (dialogContext) {
        return DialogAccountWidget(
          icon: Icon(
            Icons.warning_rounded,
            color: kRedEc,
            size: screenWidth / 7,
          ),
          title: 'Are you sure you want to delete your account?',
          subTitle: 'Press "Delete" to remove it,'
              ' or "Cancel" if you want to keep your benefits.',
          buttonText: 'Delete',
          onPressed: () async {
            await DeleteAccountService().deleteAccountRequest(context);
          },
        );
      },
    );
  }

  // Logout Dialog
  void showLogoutDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) {
        return DialogAccountWidget(
          icon: Icon(
            Icons.warning_rounded,
            color: kAmber,
            size: screenWidth / 7,
          ),
          title: 'Are you sure you want to logout?',
          subTitle: 'Press "Logout" to logout,'
              ' or "Cancel" if you want to stay with us.',
          buttonText: 'Logout',
          onPressed: () async {
            await kSecureStorage.delete(key: 'token');
            if (context.mounted) {
              Navigator.pushReplacementNamed(
                context,
                kPhoneNumberRoute,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuAccountWidget(
      onTapDelete: () => showDeleteDialog(context),
      onTapLogout: () => showLogoutDialog(context),
    );
  }
}
