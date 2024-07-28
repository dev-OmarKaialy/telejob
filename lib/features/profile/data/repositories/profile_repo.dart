import 'package:dartz/dartz.dart';
import 'package:telejob/core/unified_api/handling_exception_manager.dart';
import 'package:telejob/features/profile/data/datasources/profile_datasource.dart';

import '../../../../core/error/failures.dart';
import '../models/profile_model.dart';

class ProfileRepo with HandlingExceptionManager {
  Future<Either<Failure, GetProfileModel>> getProfile() async {
    return wrapHandling(tryCall: () async {
      return Right(await ProfileDatasource().getProfile());
    });
  }

  Future<Either<Failure, void>> updateProfile(Map<String, dynamic> body) async {
    return wrapHandling(tryCall: () async {
      return Right(await ProfileDatasource().updateProfile(body));
    });
  }
}
