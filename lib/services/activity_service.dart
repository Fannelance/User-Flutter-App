import 'package:fannelance/helpers/api_request.dart';

class ActivityService {
  Future<dynamic> activityRequest() async {
    try {
      Map<String, dynamic> data = await ApiRequest().get(url: 'user/requests');
      return data;
    } catch (e) {
      print("Error reading/parsing JSON response from server: $e");
      rethrow;
    }
  }
}
