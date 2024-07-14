import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ewaiq_mobile_v02/core/extensions/log_colors_extension.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> wrapHandling<T>({
    required Future<Right<Failure, T>> Function() tryCall,
    Future<T?> Function()? tryCallLocal,
  }) async {
    try {
      final right = await tryCall();
      return right;
    } on ServerException catch (e) {
      log("<< ServerException >> ".logRed);
      if (tryCallLocal != null) {
        final result = await tryCallLocal();
        if (result != null) {
          return Right(result);
        } else {
          return Left(ServerFailure(e.message));
        }
      } else {
        return Left(ServerFailure(e.message));
      }
    } catch (e) {
      log("<< catch >> error is $e".logRed);
      if (tryCallLocal != null) {
        final result = await tryCallLocal();
        if (result != null) {
          return Right(result);
        } else {
          return const Left(ServerFailure(".message"));
        }
      } else {
        return const Left(ServerFailure(".message"));
      }
    }
  }
}
