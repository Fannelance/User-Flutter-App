import 'package:fannelance/helpers/api_request.dart';

class UserDataService {
  Future<dynamic> userDataRequest() async {
    try {
      Map<String, dynamic> data = await ApiRequest().get(url: 'user');
      return data;
    } catch (e) {
      print("Error reading/parsing JSON response from server: $e");
      rethrow;
    }
  }
}
