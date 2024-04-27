import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/account_button_widget.dart';
import 'package:fannelance/widgets/account_popup_menu_widget.dart';
import 'package:flutter/material.dart';

class AlertDialogAccountWidget extends StatefulWidget {
  const AlertDialogAccountWidget({
    super.key,
  });

  @override
  State<AlertDialogAccountWidget> createState() =>
      _AlertDialogAccountWidgetState();
}

class _AlertDialogAccountWidgetState extends State<AlertDialogAccountWidget> {
  bool isShown = true;

  void delete(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: white,
          surfaceTintColor: white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 55,
          ),
          iconPadding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 24,
          ),
          actionsOverflowButtonSpacing: 10,

          // Icon
          icon: Icon(
            Icons.warning_rounded,
            size: screenWidth / 7,
            color: redEc,
          ),

          // Title
          title: Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(
              fontSize: screenWidth / 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),

          // Subtitle
          content: Text(
            'Press "Delete" to remove it, or "Cancel" if you want to keep your benefits.',
            style: TextStyle(
              fontSize: screenWidth / 28,
              color: grey5,
            ),
          ),
          
          actions: [
            //Yes button
            ButtonAccountWidget(
              onPressed: () => setState(() {
                isShown = false;
              }),
              text: 'Delete',
              backgroundColor: white,
              textColor: black,
              borderColor: greyE8,
            ),
            //No button
            const ButtonAccountWidget(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuAccountWidget(
      onTap: isShown == true ? () => delete(context) : () {},
    );
  }
}
