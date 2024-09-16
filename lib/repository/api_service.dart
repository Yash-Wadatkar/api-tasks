import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  final String getDataUrl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a90e866a82e34633a8914b306f5e120c';

  final String postUrl = 'https://dummy.restapiexample.com/api/v1/create';

  /// method to get data from api
  Future<dynamic> getNews() async {
    try {
      final response = await http
          .get(Uri.parse(getDataUrl))
          .timeout(const Duration(seconds: 10));

      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } on FormatException {
      throw Exception('Invalid response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }

  /// method to post data
  Future<dynamic> createEmployee(
      {required String name,
      required String salary,
      required String age}) async {
    try {
      final response = await http
          .post(
            Uri.parse(postUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': name,
              'salary': salary,
              'age': age,
            }),
          )
          .timeout(const Duration(seconds: 10));

      return _processResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    } on FormatException {
      throw Exception('Invalid response format');
    } on TimeoutException {
      throw Exception('Request timed out');
    } on HttpException {
      throw Exception('Server error');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  /// method to handle response
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 201:
        return json.decode(response.body); // Created (POST success)
      case 400:
        throw Exception('Bad Request');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:
        throw Exception('Not Found');
      case 500:
        throw Exception('Internal Server Error');
      default:
        throw Exception('Something went wrong');
    }
  }
}
