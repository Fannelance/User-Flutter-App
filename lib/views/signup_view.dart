import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fannelance/views/login_view.dart';
import 'package:fannelance/widgets/authentication_body_widget.dart';
import 'package:fannelance/widgets/authentication_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => SignupViewState();
}

class SignupViewState extends State<SignupView> {
  static TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> registerRequest() async {
      try {
        await dotenv.load(fileName: '.env');
        final String? serverURL = dotenv.env['serverURL'];
        Dio dio = Dio();
        String url = '$serverURL/user/register';
        Map<String, dynamic> data = {
          'username': SignupViewState.userNameController.text,
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
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const LoginView();
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

    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AuthenticationBodyWidget(
        title: 'Sign up',
        subTitle: 'Enter your credentials to continue',
        usernameTextField: Column(
          children: [
            //user name
            AuthenticationTextFieldWidget(
              hint: 'User name',
              input: userNameController,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        buttonText: 'Sign up',
        questionText: 'Already have an account?',
        suggestionText: 'Log in',
        noteText: Text(
          'By continuing you agree to our Terms of Service and Privacy Policy.',
          style: TextStyle(
            height: 1,
            fontSize: screenWidth / 25,
          ),
          maxLines: 3,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LoginView();
          }));
        },
        buttonOnPressed: registerRequest,
      ),
    );
  }
}
