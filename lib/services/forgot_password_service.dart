import 'package:fannelance/core/routes.dart';
import 'package:fannelance/helpers/api_request.dart';
import 'package:fannelance/views/forgot_password_view.dart';
import 'package:flutter/material.dart';

class ForgotPasswordService {
  Future<void> forgotPasswordRequest(BuildContext context) async {
    await ApiRequest().put(
      url: 'user/update-password',
      data: {
        'newpassword': ForgotPasswordViewState.newPasswordController.text,
        'repeatedpassword':
            ForgotPasswordViewState.repeatedNewPasswordController.text,
      },
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          kLoginRoute,
        );
      },
    );
  }
}
