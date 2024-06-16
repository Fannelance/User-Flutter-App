import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fannelance/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRequest {
  Dio dio = Dio();

/* ************************* Get Request ************************* */

  Future<dynamic> get({
    required String url,
  }) async {
    await dotenv.load(fileName: '.env');
    final String? serverURL = dotenv.env['serverURL'];
    String baseUrl = '$serverURL/$url';

    String? token = await kSecureStorage.read(key: 'token');

    Response response = await dio.get(
      baseUrl,
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
      return response.data;
    } else {
      print(
        'Failed with status: ${response.statusCode} ${response.data['error']}',
      );
      return response.data;
    }
  }

/* ************************* Post Request ************************* */

  Future<dynamic> post({
    required String url,
    Object? data,
    VoidCallback? onPressedSuccess,
    VoidCallback? onPressedNotSuccess,
    bool writeToken = false,
    String? token,
  }) async {
    // Url
    await dotenv.load(fileName: '.env');
    final String? serverURL = dotenv.env['serverURL'];
    String baseUrl = '$serverURL/$url';

    // Headers
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    // Data
    String? jsonData;
    if (data != null) {
      jsonData = jsonEncode(data);
    }

    // Response
    Response response = await dio.post(
      baseUrl,
      data: jsonData,
      options: Options(
        headers: headers,
        validateStatus: (status) {
          return true;
        },
      ),
    );
    print(response);

    // writeToken
    if (writeToken) {
      await kSecureStorage.write(
        key: 'token',
        value: response.data['token'],
      );
    }

    // Check statusCode
    if (response.statusCode == 200) {
      print('Success with status: ${response.statusCode}');
      if (onPressedSuccess != null) onPressedSuccess();
    } else {
      if (onPressedNotSuccess != null) onPressedNotSuccess();
      print('Failed with status: ${response.statusCode}');
    }
  }

/* ************************* Put Request ************************* */

  Future<dynamic> put({
    required String url,
    required Object data,
    required VoidCallback onPressed,
    bool writeToken = true,
  }) async {
    await dotenv.load(fileName: '.env');
    final String? serverURL = dotenv.env['serverURL'];
    String baseUrl = '$serverURL/$url';

    String? token = await kSecureStorage.read(key: 'token');

    String jsonData = jsonEncode(data);
    Response response = await dio.put(
      baseUrl,
      data: jsonData,
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
    print(response);

    if (response.statusCode == 200) {
      print('Success!');
      onPressed();
      return response.data;
    } else {
      print(
        'Failed with status: ${response.statusCode} ${response.data['error']}',
      );
    }
  }

/* ************************* Delete Request ************************* */

  Future delete({
    required String url,
    required BuildContext context,
    required VoidCallback onPressed,
  }) async {
    await dotenv.load(fileName: '.env');
    final String serverURL = dotenv.env['serverURL']!;

    String? token = await kSecureStorage.read(key: 'token');

    String baseUrl = '$serverURL/$url';

    final Response response = await dio.delete(
      baseUrl,
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
      print('Deletion Success! with status: ${response.statusCode}');
      kSecureStorage.delete(key: 'token');
      onPressed();
    } else {
      print('Failed with status: ${response.statusCode}');
    }
  }
}
