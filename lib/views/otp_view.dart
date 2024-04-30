import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/signup_view.dart';
import 'package:fannelance/widgets/app_bar_widget.dart';
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

    // final errorPinTheme = defaultPinTheme.copyBorderWith(
    //   border: Border.all(color: redAccent),
    // );

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
            Navigator.pushReplacement(
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
            SizedBox(
              width: screenWidth/1.6,
              child: Text(
                'Verify your phone number',
                style: TextStyle(
                  fontSize: screenWidth / 11,
                  // fontWeight: FontWeight.bold,
                  height: 1.1,
                  fontFamily: bold,
                ),
              ),
            ),
            box_15,
            //note
            Row(
              children: [
                Flexible(
                  child: Text(
                    // 'We sent an SMS with a 5-digit code to XXX XXXX X${PhoneNumberViewState.phoneNumberController.text.substring(7)}',
                    'We sent an SMS with a 5-digit code to XXX XXXX X${'1025042013'.substring(7)}',
                    maxLines: 3,
                    style: TextStyle(
                      color: grey7,
                      height: 1.4,
                      fontSize: screenWidth / 21,
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
                      otpRequest();

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
                    // errorPinTheme: errorPinTheme,
                  ),
                ),
              ],
            ),

            box_30,

            //send again
            Row(
              children: [
                Text(
                  "Didn't recieve a code? ",
                  style: TextStyle(
                    color: grey5,
                    fontSize: screenWidth / 22,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontSize: screenWidth / 22,
                      color:focusedBorderColor
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
