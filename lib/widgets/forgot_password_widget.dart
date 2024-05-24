import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    Dio dio = Dio();
    const secureStorage = FlutterSecureStorage();

    Future<Response> otpRequest() async {
      String? token = await secureStorage.read(key: 'token');
      String? serverURL = dotenv.env['serverURL'];

      String? url = '$serverURL/send-otp';

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
      print(response);

      return response;
    }

    return GestureDetector(
      onTap: () {
        otpRequest();
        Navigator.pushNamed(
          context,
          kOtpForgotPasswordRoute,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Forgot Password?',
            style: TextStyle(
              color: grey5,
              fontSize: screenWidth / 24,
            ),
          ),
        ],
      ),
    );
  }
}
