import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class WorkersModel {
  final String workerName;
  final String workerPhoto;
  final String workerLocation;
  final int workerHourlyRate;
  final double workerRating;

  WorkersModel({
    required this.workerName,
    required this.workerPhoto,
    required this.workerLocation,
    required this.workerHourlyRate,
    required this.workerRating,
  });

  static Future<List<WorkersModel>> loadAndParseJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/cleaners.json');
      final data = json.decode(response);
      if (data.isNotEmpty && data['Cleaners'] is List) {
        List<WorkersModel> workersList = (data['Cleaners'] as List)
            .map((workersList) => WorkersModel.fromJson(workersList))
            .toList();

        return workersList;
      } else {
        if (kDebugMode) {
          print("JSON file is empty or does not contain 'Cleaners' key");
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

  factory WorkersModel.fromJson(Map<String, dynamic> json) {
    return WorkersModel(
      workerPhoto: json['workerPhoto'] ?? "",
      workerName: json['workerName'] ?? "",
      workerLocation: json['workerLocation'] ?? "",
      workerHourlyRate: int.parse(json['workerHourlyRate']) ,
      workerRating: double.parse(json['workerRating']) ,
    );
  }
}
