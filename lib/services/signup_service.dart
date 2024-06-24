import 'package:fannelance/core/constants.dart';
import 'package:fannelance/core/routes.dart';
import 'package:fannelance/helpers/api_request.dart';
import 'package:fannelance/views/change_password_view.dart';
import 'package:fannelance/views/signup_view.dart';
import 'package:fannelance/widgets/authentication_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SignupService {
  Future getCurrentLocationApp() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<void> signupRequest(BuildContext context) async {
    Position position = await getCurrentLocationApp();
    
    try {
      await ApiRequest().post(
        url: 'user/register',
        data: {
          'firstname': SignupViewState.firstNameController.text,
          'lastname': SignupViewState.lastNameController.text,
          'email': SignupViewState.emailController.text,
          'password': ChangePasswordviewState.passwordController.text,
          'gender': AuthenticationDropdownWidgetState.gender,
          'location': {
            'type': 'Point',
            'coordinates': [position.latitude, position.longitude]
          }
        },
        token: await kSecureStorage.read(key: 'token'),
        onPressedSuccess: () {
          Navigator.pushNamed(
            context,
            kPhoneNumberRoute,
          );
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}
