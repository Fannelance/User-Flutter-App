import 'package:fannelance/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async{
      await dotenv.load(fileName: '.env');

  Stripe.publishableKey=dotenv.env['publishableKey']!;
  runApp(const Fannelance());
}

class Fannelance extends StatelessWidget {
  const Fannelance({super.key});

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavBar(),
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Gilroy-SemiBold', 
            // fontSize: 16, 
          ),
        ),
      ),
    );
  }
}