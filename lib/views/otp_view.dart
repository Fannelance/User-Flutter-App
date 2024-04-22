import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/phone_number_view.dart';
import 'package:fannelance/views/signup_view.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pinput/pinput.dart';

class OTPView extends StatefulWidget {
  const OTPView({
    Key? key,
  }) : super(key: key);

  @override
  State<OTPView> createState() => OTPViewState();
}

class OTPViewState extends State<OTPView> {
  final focusNode = FocusNode();
  // final formKey = GlobalKey<FormState>();
  String pinController = '';

  @override
  void initState() {
    super.initState();
    pinController = '';
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const secureStorage = FlutterSecureStorage();

    final defaultPinTheme = PinTheme(
      width: screenWidth / 7,
      height: screenWidth / 7,
      textStyle: const TextStyle(
        fontSize: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: border19,
        border: Border.all(color: grey8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyBorderWith(
      border: Border.all(color: focusedBorderColor),
    );

    final errorPinTheme = defaultPinTheme.copyBorderWith(
      border: Border.all(color: redAccent),
    );

    Future<void> otpRequest() async {
      try {
        await dotenv.load(fileName: '.env');
        final String? serverURL = dotenv.env['serverURL'];

        Dio dio = Dio();
        String url = '$serverURL/verify-otp';
        Map<String, dynamic> data = {
          'code': pinController,
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

        if (response.statusCode == 200) {
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const SignupView();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box_20,
            //title
            Text(
              'Enter OTP code',
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            box_10,
            //note
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Code has been sent to +${PhoneNumberViewState.countryDialCode + PhoneNumberViewState.phoneNumberController.text}',
                    maxLines: 3,
                    style: TextStyle(
                      color: grey5,
                      height: 1.2,
                      fontSize: screenWidth / 24,
                    ),
                  ),
                ),
              ],
            ),

            box_30,

            //pins
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 5,
                    autofocus: true,
                    focusNode: focusNode,
                    onTapOutside: (pointer) {
                      focusNode.unfocus();
                    },
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsRetrieverApi,
                    listenForMultipleSmsOnAndroid: true,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      setState(() => pinController = pin);
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 9,
                          ),
                          width: 22,
                          height: 1,
                          color: black,
                        ),
                      ],
                    ),
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: focusedPinTheme,
                    errorPinTheme: errorPinTheme,
                  ),
                ),
              ],
            ),

            box_30,

            //button
            AuthenticationButtonWidget(
              buttonText: 'Continue',
              buttonOnPressed: () => otpRequest(),
            ),

            box_30,

            //send again
            Row(
              children: [
                Text(
                  "Didn't recieve a code? ",
                  style: underlineStyle.copyWith(
                    decoration: TextDecoration.none,
                    fontSize: screenWidth / 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend',
                    style: underlineStyle.copyWith(
                      fontSize: screenWidth / 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
