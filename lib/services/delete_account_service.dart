import 'package:fannelance/core/constants.dart';
import 'package:fannelance/helpers/api_request.dart';
import 'package:flutter/material.dart';

class DeleteAccountService {
  Future<void> deleteAccountRequest(BuildContext context) async {
    await ApiRequest().delete(
      url: 'user/delete-account',
      context: context,
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          kPhoneNumberRoute,
        );
      },
    );
  }
}
