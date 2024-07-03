import 'package:fannelance/helpers/api_request.dart';
class CloseWorkersService {
  Future<dynamic> closeWorkersRequest() async {
    try {
      Map<String, dynamic> data = await ApiRequest().get(url: 'close-workers');
      return data;
    } catch (e) {
      print("Error reading/parsing JSON response from server: $e");
      rethrow;
    }
  }
}
