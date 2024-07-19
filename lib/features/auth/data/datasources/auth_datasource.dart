import 'package:telejob/core/unified_api/api_variables.dart';
import 'package:telejob/core/unified_api/post_api.dart';
import 'package:telejob/features/auth/data/models/auth_model.dart';

class AuthDatasource {
  Future<AuthResponseModel> login(Map<String, dynamic> body) async {
    final postApi = PostApi(
        uri: ApiVariables().login(),
        body: body,
        fromJson: authResponseMOdelFromJson);

    return await postApi.callRequest();
  }

  Future<AuthResponseModel> register(Map<String, dynamic> body) async {
    final postApi = PostApi(
        uri: ApiVariables().register(),
        body: body,
        fromJson: authResponseMOdelFromJson);

    return await postApi.callRequest();
  }
}
