import 'package:telejob/core/unified_api/api_variables.dart';
import 'package:telejob/core/unified_api/get_api.dart';
import 'package:telejob/core/unified_api/post_api.dart';
import 'package:telejob/features/home/data/models/job_categories.dart';
import 'package:telejob/features/home/data/models/requests_model.dart';
import 'package:telejob/features/home/data/models/workers_model.dart';

import '../models/report_type.dart';

class HomeDatasource {
  Future<IndexRequestsModel> indexRequest() async {
    final getApi = GetApi(
        uri: ApiVariables().requests(), fromJson: indexRequestsModelFromJson);
    return await getApi.callRequest();
  }

  Future<JobCategoriesModel> indexJobCategories() async {
    final getApi = GetApi(
        uri: ApiVariables().jobCategories(),
        fromJson: jobCategoriesModelFromJson);
    return await getApi.callRequest();
  }

  Future<IndexWorkersModel> indexWorkers(Map<String, String> params) async {
    final getApi = GetApi(
        uri: ApiVariables().indexWorkers(params),
        fromJson: indexWorkersModelFromJson);
    return await getApi.callRequest();
  }

  Future<void> sendJobReqeust(Map<String, dynamic> body) async {
    final postApi = PostApi(
        uri: ApiVariables().sendRequest(), body: body, fromJson: (s) {});
    return await postApi.callRequest();
  }

  Future<ReportTypesModel> indexReportTypes() async {
    final getApi = GetApi(
        uri: ApiVariables().reportTypes(), fromJson: reportTypesModelFromJson);
    return await getApi.callRequest();
  }
}
