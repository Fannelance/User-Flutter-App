import 'package:fannelance/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  Stripe.publishableKey = dotenv.env['publishableKey']!;
  runApp(const Fannelance());
}

class Fannelance extends StatelessWidget {
  const Fannelance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavBarWidget(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFFFFFF),
        canvasColor: const Color(0xffFFFFFF),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xff000000),
            fontFamily: 'Gilroy-SemiBold',
          ),
        ),
      ),
    );
  }
}
