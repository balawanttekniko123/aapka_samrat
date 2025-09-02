import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:samrat_chaudhary/presentation/splash_screen.dart';
import '../../main.dart';
import '../network/network_info.dart';
import '../storage/auth_token_provider.dart';
import 'api_exceptions.dart';

class ApiHelper {
  final NetworkInfo networkInfo;

  final AuthTokenProvider authTokenProvider;

  ApiHelper(this.networkInfo, this.authTokenProvider);

  // Future<Map<String, String>> _getHeaders(Map<String, String>? headers) async {
  //   final token = await authTokenProvider.getToken();
  //   return {
  //     if (token != null) 'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json',
  //     ...?headers,
  //   };
  // }

  Future<Map<String, String>> _defaultHeaders() async {
    final token = await authTokenProvider.getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }


  Future<dynamic> get(String url) async {
    log('url===>$url');
    if (!await networkInfo.isConnected) throw NetworkException();

    final headers = await _defaultHeaders();
    print('Request Headers: $headers');
    final response = await http.get(Uri.parse(url), headers: headers);
    log('Response Status Code: ${response.statusCode}');
    log('Response Body: ${response.body}');
    return _handleResponse(response);
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    log('url===>$url');
    log('body===>$body');
    if (!await networkInfo.isConnected) throw NetworkException();

    final headers = await _defaultHeaders();
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }
  Future<dynamic> post2(String url, {Map<String, dynamic>? body}) async {
    log('url===>$url');
    log('body===>$body');
    if (!await networkInfo.isConnected) throw NetworkException();

    final headers = await _defaultHeaders();
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String url, {Map<String, dynamic>? body}) async {
    if (!await networkInfo.isConnected) throw NetworkException();

    final headers = await _defaultHeaders();
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String url) async {
    if (!await networkInfo.isConnected) throw NetworkException();

    final headers = await _defaultHeaders();
    final response = await http.delete(Uri.parse(url), headers: headers);
    return _handleResponse(response);
  }




  Future<Map<String, dynamic>> postMultipart2(
      String url, {
        Map<String, String>? fields,
        Map<String, String>? filePaths,
      }) async {
    if (!await networkInfo.isConnected) throw NetworkException();

    final token = await authTokenProvider.getToken();
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';

    print("Updating profile with:");
    print("Fields: $fields");
    print("Files: $filePaths");

    if (fields != null) request.fields.addAll(fields);
    if (filePaths != null) {
      for (var entry in filePaths.entries) {
        request.files.add(await http.MultipartFile.fromPath(
          entry.key,
          entry.value,
          contentType: MediaType('image', 'jpeg'),
        ));
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("StatusCode: ${response.statusCode}");
    print("ResponseBody: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to upload');
    }
  }



  Future<Map<String, dynamic>> postMultipart(
      String url, {
        Map<String, String>? fields,
        Map<String, File>? files,
      }) async {
    if (!await networkInfo.isConnected) throw NetworkException();

    final token = await authTokenProvider.getToken();
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';

    if (fields != null) request.fields.addAll(fields);
    if (files != null) {
      for (var entry in files.entries) {
        request.files.add(await http.MultipartFile.fromPath(
          entry.key,
          entry.value.path,
        ));
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    // Ensure the response is handled properly (check status code, etc.)
    return _handleResponse(response);  // Expecting Map<String, dynamic> response
  }



  dynamic _handleResponse(http.Response response) {
    log('response.statusCode===>${response.statusCode}');
    log('response===>${jsonDecode(response.body)}');
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        return jsonDecode(response.body);
      case 400:
        return jsonDecode(response.body);
      case 404:
        return jsonDecode(response.body);
      case 401:
        getUnauthorized();
        throw UnauthorizedException();
      case 500:
      default:
        throw ServerException("Error ${response.statusCode}: ${response.body}");
    }
  }

  getUnauthorized() async {
    await authTokenProvider.clearToken();
    _logoutAndRedirectToLogin();
  }

  void _logoutAndRedirectToLogin() {
    LogoutManager.logoutAndRedirectToLogin();
  }
}
class LogoutManager {
  static void logoutAndRedirectToLogin() {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => SplashScreen()),
      // MaterialPageRoute(builder: (_) => LoginPage()),
          (route) => false,
    );
  }
}