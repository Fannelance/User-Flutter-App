import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServicesModel {
  final String serviceIcon;
  final String serviceName;

  ServicesModel({
    required this.serviceIcon,
    required this.serviceName,
  });

  static Future<List<ServicesModel>> loadAndParseJson() async {
    try {
      await dotenv.load(fileName: '.env');
      final String serverURL = dotenv.env['serverURL']!;

      const secureStorage = FlutterSecureStorage();
      String? token = await secureStorage.read(key: 'token');

      Dio dio = Dio();
      final String url = '$serverURL/services-list';

      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return true;
          },
        ),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('services')) {
          final List<dynamic> services = responseData['services'];
          List<ServicesModel> servicesList = services
              .map((serviceJson) => ServicesModel.fromJson(serviceJson))
              .toList();
          print("Loaded ${servicesList.length} services from server");
          return servicesList;
        } else {
          print("No data field found in the response or data is not an array");
          return [];
        }
      } else {
        print("Failed to load data from server: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error reading/parsing JSON response from server: $e");
      return [];
    }
  }

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      serviceIcon: json['serviceIcon'] ?? "",
      serviceName: json['serviceName'] ?? "",
    );
  }
}
