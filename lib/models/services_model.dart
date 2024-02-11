import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ServicesModel {
  final String serviceIcon;
  final String serviceName;

  ServicesModel({ required this.serviceIcon, required this.serviceName});

  static Future<List<ServicesModel>> loadAndParseJson() async {
    try {
      final String response = await rootBundle.loadString('assets/services.json');
      final content = json.decode(response);

      if (content.isNotEmpty && content['Services'] is List) {
        List<ServicesModel> servicesList = (content['Services'] as List)
            .map((servicesList) => ServicesModel.fromJson(servicesList))
            .toList();

        return servicesList;
      } else {
        if (kDebugMode) {
          print("JSON file is empty or does not contain 'Services' key");
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error reading/parsing JSON file: $e");
      }

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
