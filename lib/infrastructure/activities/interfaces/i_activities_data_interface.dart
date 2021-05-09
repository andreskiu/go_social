import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/activities/models/activity.dart';
import '../../core/failures/server_failures.dart';

abstract class IActivityDataRepository {
  Either<ServerFailure, Stream<List<Activity>>> getActivities();

  Future<Either<ServerFailure, Unit>> saveActivity({
    @required Activity activity,
  });
}
