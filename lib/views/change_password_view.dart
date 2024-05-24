import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:fannelance/widgets/forgot_password_widget.dart';
import 'package:fannelance/widgets/password_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChangePasswordview extends StatefulWidget {
  const ChangePasswordview({super.key});

  @override
  State<ChangePasswordview> createState() => ChangePasswordviewState();
}

class ChangePasswordviewState extends State<ChangePasswordview> {
  static var passwordController = TextEditingController();
  static var newPasswordController = TextEditingController();
  static var repeatedNewPasswordController = TextEditingController();

  Future<void> changePasswordRequest() async {
    try {
      await dotenv.load(fileName: '.env');
      final String? serverURL = dotenv.env['serverURL'];

      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'token');
      print(token);
      Dio dio = Dio();
      String url = '$serverURL/user/update-password';
      Map<String, dynamic> data = {
        'oldpassword': passwordController.text,
        'newpassword': newPasswordController.text,
        'repeatedpassword': repeatedNewPasswordController.text,
      };

      String jsonData = jsonEncode(data);
      Response response = await dio.put(
        url,
        data: jsonData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return true;
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Success!');
        if (context.mounted) {
          Navigator.pushReplacementNamed(
            context,
            kNavbarRoute,
          );
        }
      } else {
        print(response.data['error']);
        print(
            'Failed with status: ${response.statusCode} ${response.data['error']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const SubAppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Reset password',
              style: TextStyle(
                fontSize: screenWidth / 11,
                fontFamily: bold,
              ),
            ),
            box_5,
            Text('Password must be equal to or more than 6 characters.',
                maxLines: 3,
                style: TextStyle(
                  color: grey7,
                  height: 1.4,
                  fontSize: screenWidth / 21,
                )),
            box_20,
            PasswordTextFieldWidget(
              hint: 'Current password',
              controller: passwordController,
            ),
            box_20,
            PasswordTextFieldWidget(
              hint: 'New password',
              controller: newPasswordController,
            ),
            box_20,
            PasswordTextFieldWidget(
              hint: 'Re-type new password',
              controller: repeatedNewPasswordController,
            ),
            box_20,
            AuthenticationButtonWidget(
                buttonOnPressed: changePasswordRequest, buttonText: 'Confirm'),
            box_20,
            const ForgotPasswordWidget(),
          ],
        ),
      ),
    );
  }
}
