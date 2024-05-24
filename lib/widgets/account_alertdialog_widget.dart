import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/account_button_widget.dart';
import 'package:fannelance/widgets/account_popup_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  Future deleteAccount() async {
    try {
      await dotenv.load(fileName: '.env');
      final String serverURL = dotenv.env['serverURL']!;

      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'token');

      Dio dio = Dio();
      final String url = '$serverURL/user/delete-account';

      final Response response = await dio.delete(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) {
              return true;
            },
          ));

      if (response.statusCode == 200) {
        print('Deletion Success!');
        secureStorage.delete(key: 'token');
        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            kPhoneNumberRoute,
          );
        }
      } else {
        print('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print("Error reading/parsing JSON response from server: $e");
      rethrow;
    }
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonAccountWidget(
                  onPressed: () {
                    print('Delete');
                    deleteAccount();
                  },
                  text: 'Delete',
                  backgroundColor: white,
                  textColor: black,
                  borderColor: greyE8,
                ),
                const SizedBox(width: 6),
                ButtonAccountWidget(onPressed: () {}),
              ],
            ),
            //No button
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
