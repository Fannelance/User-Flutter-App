import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fannelance/core/utils.dart';
import 'package:fannelance/views/signup_view.dart';
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
    const secureStorage =  FlutterSecureStorage();

    Future<void> loginRequest() async {
      try {
        await dotenv.load(fileName: '.env');
        final String? serverURL = dotenv.env['serverURL'];

        Dio dio = Dio();
        String url = '$serverURL/user/login';
        Map<String, dynamic> data = {
          'password': AuthenticationBodyWidgetState.passwordController.text,
          'phone': AuthenticationBodyWidgetState.mobileNumberController.text,
        };
        String jsonData = jsonEncode(data);
        Response response = await dio.post(
          url,
          data: jsonData,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

        if (response.statusCode == 200) {
          print('Success!');
          await secureStorage.write(
              key: 'token', value: response.data['token']);
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
      body: AuthenticationBodyWidget(
        title: 'Log in',
        subTitle: 'Enter your mobile number and password',
        noteText: GestureDetector(
          onTap: () {},
          child: Text(
            'Forgot password?',
            style: AppStyles(
              fontSize: screenWidth / 23,
            ).styleUnderline,
          ),
        ),
        buttonText: 'Log in',
        questionText: 'Don’t have an account?',
        suggestionText: 'Sign up',
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SignupView();
          }));
        },
        buttonOnPressed: loginRequest,
      ),
    );
  }
}