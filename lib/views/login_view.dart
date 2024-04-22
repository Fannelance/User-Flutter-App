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
            Navigator.push(
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

    return Scaffold(
      appBar: const SubAppBarWidget(),
      body: AuthenticationBodyWidget(
        title: 'Log to your account',
        suggestionText: Column(
          children: [
            box_20,
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot password?',
                    style: underlineStyle.copyWith(
                      fontSize: screenWidth / 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        buttonText: 'Log in',
        buttonOnPressed: loginRequest,
      ),
    );
  }
}
