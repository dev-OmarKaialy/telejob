import 'package:dartz/dartz.dart';
import 'package:telejob/core/unified_api/handling_exception_manager.dart';
import 'package:telejob/features/auth/data/datasources/auth_datasource.dart';

import '../../../../core/error/failures.dart';
import '../models/auth_model.dart';

class AuthRepo with HandlingExceptionManager {
  Future<Either<Failure, AuthResponseModel>> login(
      Map<String, dynamic> body) async {
    return wrapHandling(tryCall: () async {
      return Right(await AuthDatasource().login(body));
    });
  }

  Future<Either<Failure, AuthResponseModel>> register(
      Map<String, dynamic> body) async {
    return wrapHandling(tryCall: () async {
      return Right(await AuthDatasource().register(body));
    });
  }
}
