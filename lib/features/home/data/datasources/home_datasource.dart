import 'package:telejob/core/unified_api/api_variables.dart';
import 'package:telejob/core/unified_api/delete_api.dart';
import 'package:telejob/core/unified_api/get_api.dart';
import 'package:telejob/core/unified_api/multi_post_api.dart';
import 'package:telejob/features/home/data/models/job_categories.dart';
import 'package:telejob/features/home/data/models/requests_model.dart';
import 'package:telejob/features/home/data/models/workers_model.dart';

import '../models/report_type.dart';

class HomeDatasource {
  Future<void> deleteRequest(String id) async {
    final deleteApi =
        DeleteApi(uri: ApiVariables().resetPassword(), fromJson: (str) {});
    return await deleteApi.callRequest();
  }

  Future<void> createRequest(
      Map<String, String> files, Map<String, String> body) async {
    final postApi = MultiPostApi(
        uri: ApiVariables().sendRequest(),
        body: body,
        files: files,
        fromJson: (str) {});
    return await postApi.callRequest();
  }

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

  Future<ReportTypesModel> indexReportTypes() async {
    final getApi = GetApi(
        uri: ApiVariables().reportTypes(), fromJson: reportTypesModelFromJson);
    return await getApi.callRequest();
  }
}
