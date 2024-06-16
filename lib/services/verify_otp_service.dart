import 'package:fannelance/core/constants.dart';
import 'package:fannelance/helpers/api_request.dart';
import 'package:flutter/material.dart';

class VerifyOtpService {
  Future<void> verifyOtpRequest({
    required String pinController,
    required BuildContext context,
    required String nextPage,
  }) async {
    await ApiRequest().post(
      url: 'verify-otp',
      data: {
        'code': pinController,
      },
      token: await kSecureStorage.read(key: 'token'),
      onPressedSuccess: () {
        Navigator.pushReplacementNamed(
          context,
          nextPage,
        );
      },
    );
  }
}
