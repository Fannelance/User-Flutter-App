import 'package:fannelance/core/routes.dart';
import 'package:fannelance/helpers/api_request.dart';
import 'package:fannelance/services/send_otp_service.dart';
import 'package:fannelance/views/phone_number_view.dart';
import 'package:flutter/material.dart';

class CheckPhoneNumberService {
  static String phoneNumber = '';

  Future<void> checkPhoneNumberRequest({required BuildContext context}) async {
    phoneNumber = '+${PhoneNumberViewState.countryDialCode}'
        '${PhoneNumberViewState.phoneNumberController.text.substring(1)}';
    await ApiRequest().post(
      url: 'user/check-phone',
      data: {
        'phone': phoneNumber,
      },
      onPressedSuccess: () {
        Navigator.pushNamed(
          context,
          kLoginRoute,
        );
      },
      onPressedNotSuccess: () async {
        await SendOtpService().sendOtpRequest();
        if (context.mounted) {
          Navigator.pushNamed(
            context,
            kSignupRoute,
          );
        }
      },
      writeToken: true,
    );
  }
}
