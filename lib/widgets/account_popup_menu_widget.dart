import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/reset_password_view.dart';
import 'package:fannelance/widgets/account_popup_item_widget.dart';
import 'package:flutter/material.dart';

class PopupMenuAccountWidget extends StatelessWidget {
  final void Function()? onTap;

  const PopupMenuAccountWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ResetPasswoedView();
              },
            ),
          ),
        ),
        PopupMenuItem(
          height: 40,
          child: const PopupItemAccountWidget(
            title: 'Support',
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ResetPasswoedView();
              },
            ),
          ),
        ),
        PopupMenuItem(
          height: 40,
          child: const PopupItemAccountWidget(
            title: 'Logout',
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ResetPasswoedView();
              },
            ),
          ),
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
