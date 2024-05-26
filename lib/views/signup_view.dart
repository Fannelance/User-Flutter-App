import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:fannelance/views/phone_number_view.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:fannelance/widgets/authentication_body_widget.dart';
import 'package:fannelance/widgets/authentication_textfield_widget.dart';
import 'package:fannelance/widgets/drop_down_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => SignupViewState();
}

class SignupViewState extends State<SignupView> {
  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();

  Future getCurrentLocationApp() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  @override
  void initState() {
    getCurrentLocationApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> registerRequest() async {
      try {
        await dotenv.load(fileName: '.env');
        final String? serverURL = dotenv.env['serverURL'];

        const secureStorage = FlutterSecureStorage();
        String? token = await secureStorage.read(key: 'token');

        Position position = await getCurrentLocationApp();

        Dio dio = Dio();
        String url = '$serverURL/user/register';
        Map<String, dynamic> data = {
          'firstname': firstNameController.text,
          'lastname': lastNameController.text,
          'email': emailController.text,
          'password': ChangePasswordviewState.passwordController.text,
          'gender': DropDownMenuWidgetState.gender,
          'location': {
            'type': 'point',
            'coordinates': [position.latitude, position.longitude]
          }
        };

        String jsonData = jsonEncode(data);
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

        if (response.statusCode == 200) {
          print('Success!');
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const PhoneNumberView();
              }),
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

    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const SubAppBarWidget(),
      body: AuthenticationBodyWidget(
        // Title
        title: 'Create Account',
        helperText: 'Get ready to relax while we take care of your home.',
        registrationData: Column(
          children: [
            // First name
            AuthenticationTextFieldWidget(
              hint: 'First Name',
              controller: firstNameController,
            ),
            box_20,
            // Last name
            AuthenticationTextFieldWidget(
              hint: 'Last Name',
              controller: lastNameController,
            ),
            box_20,
            AuthenticationTextFieldWidget(
              hint: 'Email',
              controller: emailController,
            ),
            box_20,
            const DropDownMenuWidget(),
            box_20,
          ],
        ),
        // Note
        noteText: Column(
          children: [
            box_10,
            Row(
              children: [
                Flexible(
                  child: Text(
                    'By continuing you agree to our Terms of Service and Privacy Policy.',
                    maxLines: 3,
                    style: TextStyle(
                      color: grey5,
                      height: 1.2,
                      fontSize: screenWidth / 26,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        buttonText: 'Sign up',
        buttonOnPressed: registerRequest,
      ),
    );
  }
}
