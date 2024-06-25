import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:fannelance/models/payment_intent_input_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class StripeService {
  // Create payment intent
  static Future<dynamic> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${dotenv.env['secretKey']}',
          'Content-Type': Headers.formUrlEncodedContentType
        },
      ),
      data: paymentIntentInputModel.toJson(),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(
        'Failed with status: ${response.statusCode} ${response.data['error']}',
      );
    }
  }

  // Initialize the payment sheet
  static Future<void> initializePaymentSheet({
    required String clientSecret,
    required String customerId,
    required String ephemeralKeySecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        customerId: customerId,
        customerEphemeralKeySecret: ephemeralKeySecret,
        merchantDisplayName: "Fannelance",
        googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'EG'),
        appearance: PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(
            background: Colors.white,
            primary: Colors.black,
            componentBackground: Colors.grey[200]!,
            componentBorder: Colors.grey[300]!,
            componentText: Colors.black,
            primaryText: Colors.black,
            secondaryText: Colors.black,
            placeholderText: Colors.black38,
            icon: Colors.black,
            error: Colors.red,
            componentDivider: Colors.grey[400]!,
          ),
          primaryButton: const PaymentSheetPrimaryButtonAppearance(
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: kBlack,
              ),
              dark: PaymentSheetPrimaryButtonThemeColors(
                  background: kBlack, text: kWhite),
            ),
          ),
        ),
      ),
    );
  }

  // Present payment sheet
  static Future presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  // Create Ephemeral Key
  static Future<dynamic> createEphemeralKey({
    required String customer,
  }) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/ephemeral_keys',
      data: {'customer': customer},
      options: Options(
        headers: {
          'Authorization': "Bearer ${dotenv.env['secretKey']}",
          'Stripe-Version': '2023-10-16',
          'Content-Type': Headers.formUrlEncodedContentType,
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(
        'Failed with status: ${response.statusCode} ${response.data['error']}',
      );
    }
  }

  // Call the 4 methods
  static Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      var paymentIntent = await createPaymentIntent(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      var ephemeralKey = await createEphemeralKey(
        customer: paymentIntentInputModel.customerId,
      );
      await initializePaymentSheet(
        clientSecret: paymentIntent['client_secret'],
        customerId: paymentIntentInputModel.customerId,
        ephemeralKeySecret: ephemeralKey['secret'],
      );
      await presentPaymentSheet();
    } catch (error) {
      throw Exception(
        error.toString(),
      );
    }
  }

  // Handle the payment process
  static Future<void> handlePayment(BuildContext context) async {
    try {
      PaymentIntentInputModel inputModel = PaymentIntentInputModel(
        amount: 100,
        currency: 'EGP',
        customerId: 'cus_PbfjLHEmbwUdrx',
      );

      await StripeService.makePayment(
        paymentIntentInputModel: inputModel,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Your request is completed successfully",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Your request Failed",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
