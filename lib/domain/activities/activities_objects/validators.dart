import 'package:dartz/dartz.dart';
import '../../activities/failures/activities_failures.dart';

Either<ActivitiesFailure, String> validateActivityTitle(String input) {
  if (input == null || input.isEmpty) {
    return Left(ActivitiesFailure.Mandatory(field: ActivitiesFields.Title));
  }

  if (input.length > 30) {
    return Left(ActivitiesFailure.TooLong());
  }

  return Right(input);
}

Either<ActivitiesFailure, String> validateActivityDescription(String input) {
  if (input == null || input.isEmpty) {
    return Left(
        ActivitiesFailure.Mandatory(field: ActivitiesFields.Description));
  }
  if (input.length > 300) {
    return Left(ActivitiesFailure.TooLong());
  }
  return Right(input);
}

Either<ActivitiesFailure, String> validateActivityAddress(String input) {
  if (input == null || input.isEmpty) {
    return Left(ActivitiesFailure.Mandatory(field: ActivitiesFields.Address));
  }
  if (input.length > 70) {
    return Left(ActivitiesFailure.TooLong());
  }
  return Right(input);
}

Either<ActivitiesFailure, DateTime> validateActivityDate(DateTime input) {
  if (input == null) {
    return Left(ActivitiesFailure.Mandatory());
  }
  final _today = DateTime.now();
  if (input.isBefore(DateTime(_today.year, _today.month, _today.day))) {
    return Left(ActivitiesFailure.invalidDate());
  }
  return Right(input);
}
