import 'package:telejob/core/unified_api/api_variables.dart';
import 'package:telejob/core/unified_api/get_api.dart';
import 'package:telejob/core/unified_api/put_api.dart';
import 'package:telejob/features/profile/data/models/profile_model.dart';

class ProfileDatasource {
  Future<GetProfileModel> getProfile() async {
    final getApi = GetApi(
        uri: ApiVariables().profile(), fromJson: getProfileModelFromJson);
    return await getApi.callRequest();
  }

  Future<void> updateProfile(Map<String, dynamic> body) async {
    final putApi =
        PutApi(uri: ApiVariables().profile(), fromJson: (str) {}, body: body);
    return await putApi.callRequest();
  }
}
