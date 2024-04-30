import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:fannelance/widgets/authentication_body_widget.dart';
import 'package:fannelance/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const secureStorage = FlutterSecureStorage();

    Future<void> loginRequest() async {
      try {
        await dotenv.load(fileName: '.env');
        final String? serverURL = dotenv.env['serverURL'];

        Dio dio = Dio();
        String url = '$serverURL/user/login';
        Map<String, dynamic> data = {
          'password': AuthenticationBodyWidgetState.passwordController.text,
        };
        String jsonData = jsonEncode(data);

        String? token = await secureStorage.read(key: 'token');

        Response response = await dio.post(
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
        print(response);

        if (response.statusCode == 200) {
          print('Success!');
          await secureStorage.write(
            key: 'token',
            value: response.data['token'],
          );
          if (context.mounted) {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return const NavBarWidget();
              }),
            );
          }
        } else {
          print('Failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    final helperTextStyle = TextStyle(
      color: grey7,
      height: 1.4,
      fontSize: screenWidth / 21,
    );
    return Scaffold(
      appBar: const SubAppBarWidget(),
      body: AuthenticationBodyWidget(
        title: 'Log in',
        helperTextWidget: Text(
          // '+${PhoneNumberViewState.countryDialCode + PhoneNumberViewState.phoneNumberController.text}',
          '+20102502013',
          maxLines: 3,
          style: helperTextStyle.copyWith(color: grey3, letterSpacing: 1.2),
        ),
        suggestionText: Column(
          children: [
            box_20,
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot Password?',
                      style: helperTextStyle.copyWith(
                        color: grey5,
                        fontSize: screenWidth / 22,
                      )),
                ],
              ),
            ),
          ],
        ),
        buttonText: 'Log in',
        buttonOnPressed: () async {
          await loginRequest();
          AuthenticationBodyWidgetState.passwordController.text = "";
        },
        helperText: 'Login to your account ',
      ),
    );
  }
}
