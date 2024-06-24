import 'package:fannelance/core/routes.dart';
import 'package:fannelance/helpers/api_request.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:flutter/material.dart';

class ChangePasswordService {
  Future<void> changePasswordRequest(BuildContext context) async {
    await ApiRequest().put(
      url: 'user/update-password',
      data: {
        'oldpassword': ChangePasswordviewState.passwordController.text,
        'newpassword': ChangePasswordviewState.newPasswordController.text,
        'repeatedpassword':
            ChangePasswordviewState.repeatedNewPasswordController.text,
      },
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          kNavbarRoute,
        );
      },
    );
  }
}
