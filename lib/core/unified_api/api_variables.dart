import 'dart:developer';

import '../extensions/log_colors_extension.dart';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  final _scheme = 'https';
  final _host = 'telejob.onrender.com';
  // final _port = 5000;

  Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      // port: _port,
      path: path,
      queryParameters: queryParameters,
    );
    log(uri.toString().logMagenta);
    return uri;
  }

  Uri _customerUri({required String path, Map<String, String>? params}) =>
      _mainUri(path: 'customer/$path', queryParameters: params);

  Uri login() => _customerUri(path: 'login');
  Uri register() => _customerUri(path: 'signup');
  Uri forgetPassword() => _customerUri(path: 'forgotPassword');
  Uri resetPassword() => _customerUri(path: 'resetPassword');
  Uri indexWorkers(Map<String, String> params) =>
      _customerUri(path: 'workers', params: params);
  Uri getWorker(String id) => _customerUri(path: 'worker/$id');
  Uri reportTypes() => _customerUri(path: 'reportTypes');
  Uri reportWorker() => _customerUri(path: 'report');
  Uri requests() => _customerUri(path: 'requests');
  Uri sendRequest() => _customerUri(path: 'request');
  Uri cancelRequest(String id) => _customerUri(path: 'request/$id');
  Uri singleRequests(String id) => _customerUri(path: 'request/$id');
  Uri jobCategories() => _mainUri(path: 'jobCategories');
  Uri profile() => _customerUri(path: 'profile');
}
