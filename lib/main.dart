import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:fannelance/views/forgot_password_view.dart';
import 'package:fannelance/views/login_view.dart';
import 'package:fannelance/views/otp_view.dart';
import 'package:fannelance/views/phone_number_view.dart';
import 'package:fannelance/views/signup_view.dart';
import 'package:fannelance/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
void main() async {
  await dotenv.load(fileName: '.env');
  const secureStorage = FlutterSecureStorage();
  final String token = await secureStorage.read(key: 'token') ?? "";
  Stripe.publishableKey = dotenv.env['publishableKey']!;
  runApp(Fannelance(token: token));
}

class Fannelance extends StatelessWidget {
  final String? token;
  const Fannelance({
    required this.token,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isAuthorized = false;
    if (token != "")
      {isAuthorized = JwtDecoder.decode(token!)['isAuth'] ?? false;}
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (token == "" || JwtDecoder.isExpired(token!) || !isAuthorized)
          ? const PhoneNumberView()
          : const NavBarWidget(),
      // home: LoginView(),
      // home: SignupView(),
      // home: OTPView(),
      // home: NavBarWidget(),
      // home: CountryStateCityScreen(),
      // home: ChangePasswordview(),
      // home: ForgotPasswordView(),
      // home: PhoneNumberView(),
      theme: ThemeData(
        scaffoldBackgroundColor: white,
        canvasColor: white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: black,
            fontFamily: 'Gilroy-SemiBold',
          ),
        ),
      ),
    );
  }
}
