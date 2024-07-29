import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../services/shared_preferences_service.dart';
import 'handling_exception_request.dart';

typedef FromJson<T> = T Function(String body);

class MultiPostApi with HandlingExceptionRequest {
  final Uri uri;
  final Map<String, String> body;
  final Map<String, String> files;
  final FromJson fromJson;
  final Duration timeout;
  const MultiPostApi({
    required this.uri,
    required this.body,
    required this.files,
    required this.fromJson,
    this.timeout = const Duration(seconds: 20),
  });

  Future<dynamic> callRequest() async {
    final token = SharedPreferencesService.getToken();
    log(token ?? '', name: 'token is ');

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token'
      };
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      for (var item in files.entries) {
        log('${item.key} ${item.value}');
        request.files.add(
          await http.MultipartFile.fromPath(item.key, item.value,
              filename: item.value.split('/').last,
              contentType: MediaType('image', 'jpg')),
        );
      }
      log(
          request.files
              .map((e) => '${e.field}   ${e.filename ?? ''}')
              .toString(),
          name: 'files names');
      log(
          request.files
              .map((e) => '${e.field}   ${e.contentType ?? ''}')
              .toString(),
          name: 'files names');
      request.fields.addAll(body);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(timeout);
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception',
        name: 'RequestManager post function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri',
        name: 'RequestManager post function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception',
        name: 'RequestManager post function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString(),
        name: 'RequestManager post function',
      );
      rethrow;
    }
  }
}
