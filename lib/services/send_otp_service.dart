import 'package:fannelance/core/constants.dart';
import 'package:fannelance/helpers/api_request.dart';

// phoneIsNotVerified
class SendOtpService {
  Future<dynamic> sendOtpRequest() async {
    print('sms must be sent');
    await ApiRequest().post(
      url: 'user/send-otp',
      token: await kSecureStorage.read(key: 'token'),
    );
  }
}
