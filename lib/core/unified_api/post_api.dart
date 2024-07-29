import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../extensions/log_colors_extension.dart';
import '../services/shared_preferences_service.dart';
import 'handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class PostApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final Map body;
  final FromJson fromJson;
  final bool isLogin;
  final Duration timeout;

  const PostApi({
    required this.uri,
    required this.body,
    required this.fromJson,
    this.isLogin = false,
    this.timeout = const Duration(seconds: 20),
  });

  Future<T> callRequest() async {
    // log('the token in the request header is $token'.logWhite, name: 'request manager ==> post function ');
    try {
      final token = SharedPreferencesService.getToken();
      log(token ?? '', name: 'token is ');
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token'
      };

      var request = http.Request('POST', uri);
      request.body = jsonEncode(body);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(timeout);
      log(request.body.logGreen, name: "request body");
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body.logCyan);
      log(response.statusCode.toString().logGreen);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString().logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    }
  }
}
