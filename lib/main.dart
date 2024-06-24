import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  final String token = await kSecureStorage.read(key: 'token') ?? "";
  Stripe.publishableKey = dotenv.env['publishableKey']!;
  runApp(FannelanceUser(token: token));
}

class FannelanceUser extends StatelessWidget {
  final String? token;
  const FannelanceUser({
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
      routes: Routes().routes,
      initialRoute:
          (token == "" || JwtDecoder.isExpired(token!) || !isAuthorized)
              ? kPhoneNumberRoute
              : kNavbarRoute,
      // initialRoute: kWaitingRoute,

      theme: ThemeData(
        scaffoldBackgroundColor: kWhite,
        canvasColor: kWhite,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: kBlack,
            fontFamily: kSemiBold,
          ),
        ),
      ),
    );
  }
}
