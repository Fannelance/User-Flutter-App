import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/login_view.dart';
import 'package:fannelance/views/otp_view.dart';
import 'package:fannelance/views/signup_view.dart';
import 'package:fannelance/widgets/authentication_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class PhoneNumberView extends StatefulWidget {
  const PhoneNumberView({
    super.key,
  });

  @override
  State<PhoneNumberView> createState() => PhoneNumberViewState();
}

class PhoneNumberViewState extends State<PhoneNumberView> {
  static TextEditingController phoneNumberController = TextEditingController();
  static String countryDialCode = "";
  static String phone = "";

  @override
  void initState() {
    super.initState();
    countryDialCode = "20";
  }

  @override
  Widget build(BuildContext context) {
    const secureStorage = FlutterSecureStorage();

    Future<void> sendPhoneNumber() async {
      try {
        await dotenv.load(fileName: '.env');
        final String? serverURL = dotenv.env['serverURL'];

        Dio dio = Dio();

        Future<Response> phoneRequest(String url) async {
          Map<String, dynamic> data = {
            'phone':
                '+$countryDialCode${phoneNumberController.text.substring(1)}',
          };
          String jsonData = jsonEncode(data);
          Response response = await dio.post(
            url,
            data: jsonData,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
              validateStatus: (status) {
                return true;
              },
            ),
          );
          await secureStorage.write(
            key: 'token',
            value: response.data['token'],
          );

          String? token = await secureStorage.read(key: 'token');
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
          phone =
              decodedToken.containsKey('phone') ? decodedToken['phone'] : '';

          phoneNumberController.clear();
          return response;
        }

        Future<Response> otpRequest(String url) async {
          String? token = await secureStorage.read(key: 'token');
          Response response = await dio.post(
            url,
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

          return response;
        }

        Response response = await phoneRequest('$serverURL/user/check-phone');

        void phoneIsVerified() async {
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const LoginView();
              }),
            );
          }
        }

        void phoneIsNotVerified() async {
          await otpRequest('$serverURL/send-otp');
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const OTPView(
                  nextPage: SignupView(),
                );
              }),
            );
          }
        }

        if (response.statusCode == 200) {
          phoneIsVerified();
        } else {
          phoneIsNotVerified();
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            box_95,
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      'assets/icons/electrician.png',
                    ),
                  ),
                ),
              ],
            ),

            box_25,

            IntlPhoneField(
              countries: const <Country>[
                Country(
                  name: "Egypt",
                  nameTranslations: {
                    "en": "Egypt",
                    "ar": "مصر",
                  },
                  flag: "🇪🇬",
                  code: "EG",
                  dialCode: "20",
                  minLength: 11,
                  maxLength: 11,
                ),
              ],
              disableLengthCheck: true,
              onCountryChanged: (value) {
                setState(() => countryDialCode = value.dialCode);
              },
              onSubmitted: (value) {
                sendPhoneNumber();
              },
              controller: phoneNumberController,
              textInputAction: TextInputAction.next,
              invalidNumberMessage: null,
              initialCountryCode: 'EG',
              dropdownTextStyle: const TextStyle(fontSize: 18),
              showCountryFlag: false,
              dropdownIconPosition: IconPosition.trailing,
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: white,
              ),
              cursorColor: black,
              dropdownDecoration: const BoxDecoration(
                border: Border(
                 right: BorderSide(
                   color: Colors.grey,
                 ) 
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    bottomLeft: Radius.circular(19)),
              ),
              flagsButtonPadding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
              decoration: InputDecoration(
                prefix: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  VerticalDivider(
                    thickness: 1,
                    indent: 20,
                    color: Colors.grey,
                  )
                ]),
                labelStyle: const TextStyle(
                  fontSize: 32,
                ),
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                hintText: 'Phone Number',
                border: phoneBorder,
                focusedBorder: phoneBorder.copyWith(
                  borderSide: const BorderSide(
                    color: black,
                  ),
                ),
              ),
            ),
            box_20,
            //button
            AuthenticationButtonWidget(
              buttonText: 'Continue',
              buttonOnPressed: sendPhoneNumber,
            ),
          ],
        ),
      ),
    ));
  }
}
