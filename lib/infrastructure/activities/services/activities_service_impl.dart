import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/activities/models/activity.dart';
import '../../../domain/activities/services/i_activities_service_interface.dart';
import '../interfaces/i_activities_data_interface.dart';
import '../../core/failures/server_failures.dart';

@LazySingleton(as: IActivityService)
class DemoService implements IActivityService {
  final IActivityDataRepository dataRepository;

  DemoService({
    @required this.dataRepository,
  });

  @override
  Either<ServerFailure, Stream<List<Activity>>> getActivities() {
    return dataRepository.getActivities();
  }

  @override
  Future<Either<ServerFailure, Unit>> saveActivity({Activity activity}) {
    return dataRepository.saveActivity(activity: activity);
  }
}
