import 'package:fannelance/core/constants.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:fannelance/views/forgot_password_view.dart';
import 'package:fannelance/views/login_view.dart';
import 'package:fannelance/views/otp_view.dart';
import 'package:fannelance/views/phone_number_view.dart';
import 'package:fannelance/views/services_view.dart';
import 'package:fannelance/views/signup_view.dart';
import 'package:fannelance/views/workers_view.dart';
import 'package:fannelance/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  final String token = await kSecureStorage.read(key: 'token') ?? "";
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
    if (token != "") {
      isAuthorized = JwtDecoder.decode(token!)['isAuth'] ?? false;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        kNavbarRoute: (context) => const NavBarWidget(),
        kServicesRoute: (context) => const ServicesView(),
        kWorkersRoute: (context) => const WorkersView(),
        kChangePasswordRoute: (context) => const ChangePasswordview(),
        kForgotPasswordRoute: (context) => const ForgotPasswordView(),
        kPhoneNumberRoute: (context) => const PhoneNumberView(),
        kLoginRoute: (context) => const LoginView(),
        kSignupRoute: (context) => const SignupView(),
        kOtpSignUpRoute: (context) {
          return const OTPView(
            nextPage: kSignupRoute,
          );
        },
        kOtpForgotPasswordRoute: (context) {
          return const OTPView(
            nextPage: kForgotPasswordRoute,
          );
        }
      },

      initialRoute:
          (token == "" || JwtDecoder.isExpired(token!) || !isAuthorized)
              ? kPhoneNumberRoute
              : kNavbarRoute,

      theme: ThemeData(
        scaffoldBackgroundColor: kWhite,
        canvasColor: kWhite,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: kBlack,
            fontFamily: 'Gilroy-SemiBold',
          ),
        ),
      ),
    );
  }
}
