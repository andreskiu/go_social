import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../failures/activities_failures.dart';
import '../models/activity.dart';
import '../services/i_activities_service_interface.dart';
import '../../../infrastructure/core/failures/server_failures.dart';
import '../../core/use_case.dart';

@lazySingleton
class GetActivitiesUseCase extends UseCase<Stream<List<Activity>>, NoParams> {
  final IActivityService service;

  GetActivitiesUseCase(this.service);

  @override
  Future<Either<ActivitiesFailure, Stream<List<Activity>>>> call(
    NoParams params,
  ) async {
    final result = service.getActivities();

    return result.fold(
      (fail) {
        if (fail.type == ServerFailureTypes.NotFound) {
          return Left(ActivitiesFailure.notFound());
        }
        return Left(
          ActivitiesFailure(
            type: ActivitiesFailureTypes.ServerError,
            details: fail.details,
          ),
        );
      },
      (history) => Right(history),
    );
  }
}
