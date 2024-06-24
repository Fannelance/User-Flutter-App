import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/routes.dart';
import 'package:fannelance/helpers/api_request.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:flutter/material.dart';

class LoginService {
  Future<void> loginRequest(BuildContext context) async {
    try {
      await ApiRequest().post(
        url: 'user/login',
        data: {
          'password': ChangePasswordviewState.passwordController.text,
        },
        token: await kSecureStorage.read(key: 'token'),
        onPressedSuccess: () {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(
            context,
            kNavbarRoute,
          );
        },
        writeToken: true,
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}
