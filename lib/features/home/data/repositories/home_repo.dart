import 'package:dartz/dartz.dart';
import 'package:telejob/core/unified_api/handling_exception_manager.dart';
import 'package:telejob/features/home/data/datasources/home_datasource.dart';
import 'package:telejob/features/home/data/models/job_categories.dart';
import 'package:telejob/features/home/data/models/requests_model.dart';
import 'package:telejob/features/home/data/models/workers_model.dart';

import '../../../../core/error/failures.dart';

class HomeRepo with HandlingExceptionManager {
  Future<Either<Failure, void>> sendJobRequest(
      Map<String, dynamic> body) async {
    return wrapHandling(tryCall: () async {
      return Right(await HomeDatasource().sendJobReqeust(body));
    });
  }

  Future<Either<Failure, JobCategoriesModel>> indexJobCateogries() async {
    return wrapHandling(tryCall: () async {
      return Right(await HomeDatasource().indexJobCategories());
    });
  }

  Future<Either<Failure, IndexRequestsModel>> indexRequests() async {
    return wrapHandling(tryCall: () async {
      return Right(await HomeDatasource().indexRequest());
    });
  }

  Future<Either<Failure, IndexWorkersModel>> indexWorkers(
      Map<String, String>? params) async {
    return wrapHandling(tryCall: () async {
      return Right(await HomeDatasource().indexWorkers(params ?? {}));
    });
  }
}
