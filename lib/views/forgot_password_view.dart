import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/login_view.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:fannelance/widgets/password_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  static var newPasswordController = TextEditingController();
  static var repeatedNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Future<void> resetPasswordRequest() async {
      try {
        await dotenv.load(fileName: '.env');
        final String? serverURL = dotenv.env['serverURL'];

        const secureStorage = FlutterSecureStorage();
        String? token = await secureStorage.read(key: 'token');
        Dio dio = Dio();

        String url = '$serverURL/user/reset-password';

        Map<String, dynamic> data = {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          }
        } else {
          print(
              'Failed with status: ${response.statusCode} ${response.data['error']}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
      appBar: const SubAppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box_20,
            // Title
            Text(
              'Create a new password',
              style: TextStyle(
                fontSize: screenWidth / 11,
                fontFamily: bold,
                height: 1.1,
              ),
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
              buttonOnPressed: resetPasswordRequest,
              buttonText: 'Confirm',
            )
          ],
        ),
      ),
    );
  }
}
