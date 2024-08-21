import 'package:fannelance/views/activity_view.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:fannelance/views/forgot_password_view.dart';
import 'package:fannelance/views/login_view.dart';
import 'package:fannelance/views/otp_view.dart';
import 'package:fannelance/views/phone_number_view.dart';
import 'package:fannelance/views/signup_view.dart';
import 'package:fannelance/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';

class Routes {
  final myKey = GlobalKey<NavBarState>();
  Map<String, Widget Function(BuildContext)> routes = {
    kNavbarRoute: (context) => const NavBarWidget(),
    kActivityRoute: (context) => const ActivityView(),
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
  };
}

const kNavbarRoute = 'Navbar Widget';
const kActivityRoute = 'Activity View';
const kChangePasswordRoute = 'Change Password View';
const kForgotPasswordRoute = 'Forgot Password View';
const kPhoneNumberRoute = 'Phone Number View';
const kOtpSignUpRoute = 'OTP Signup View';
const kOtpForgotPasswordRoute = 'OTP Forgot Password View';
const kLoginRoute = 'Login View';
const kSignupRoute = 'Signup View';

