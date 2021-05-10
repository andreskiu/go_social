import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../failures/auth_failures.dart';

import '../../../infrastructure/core/failures/server_failures.dart';
import '../../core/use_case.dart';
import '../models/user.dart';
import '../services/i_auth_services.dart';

@lazySingleton
class GetUserLoggedUseCase extends UseCase<User, NoParams> {
  final IAuthService service;

  GetUserLoggedUseCase(this.service);

  @override
  Future<Either<AuthFailure, User>> call(
    NoParams params,
  ) async {
    final result = await service.getUserLogged();

    return result.fold(
      (fail) {
        if (fail.type == ServerFailureTypes.NotFound) {
          return Left(AuthFailure.notFound());
        }
        return Left(
          AuthFailure(
            type: AuthFailureTypes.ServerError,
            details: fail.details,
          ),
        );
      },
      (user) => Right(user),
    );
  }
}
