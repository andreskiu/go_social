import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../infrastructure/core/failures/server_failures.dart';
import '../models/activity.dart';

abstract class IActivityService {
  Either<ServerFailure, Stream<List<Activity>>> getActivities();

  Future<Either<ServerFailure, Unit>> saveActivity({
    @required Activity activity,
  });
}
