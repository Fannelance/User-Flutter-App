import 'package:dio/dio.dart';
import 'package:fannelance/models/payment_intent_input_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class StripeService {
  //create payment intent
  static Future createPaymentIntent({
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
    return response.data;
  }

  //initialize the payment sheet
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
        appearance: const PaymentSheetAppearance(
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: Color(0xff000000),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //present payment sheet
  static Future presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  //create Ephemeral Key
  static Future createEphemeralKey({
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
    return response.data;
  }

  //call the 4 methods
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
}
