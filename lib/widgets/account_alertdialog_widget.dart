import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/account_buttondialog_widget.dart';
import 'package:flutter/material.dart';

class DialogAccountWidget extends StatelessWidget {
  const DialogAccountWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    this.onPressed,
    this.icon,
  });
  final Widget? icon;
  final String title;
  final String subTitle;
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: kWhite,
      surfaceTintColor: kWhite,
      actionsOverflowButtonSpacing: 10,
      insetPadding: const EdgeInsets.symmetric(horizontal: 55),
      iconPadding: const EdgeInsets.symmetric(vertical: 12),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),

      // Icon
      icon: icon,

      // Title
      title: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 20,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,
      ),

      // Subtitle
      content: Text(
        subTitle,
        style: TextStyle(
          fontSize: screenWidth / 28,
          color: kGrey5,
        ),
      ),

      // Buttons
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonDialogAccountWidget(
              // Delete
              onPressed: () {
                onPressed!();
              },
              text: buttonText,
              backgroundColor: kWhite,
              textColor: kBlack,
              borderColor: kGreyE8,
            ),
            const SizedBox(width: 6),
            // Cancel
            ButtonDialogAccountWidget(
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
