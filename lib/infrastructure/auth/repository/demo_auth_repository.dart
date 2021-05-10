import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/auth/models/user.dart';
import '../../core/failures/server_failures.dart';
import '../interfaces/i_auth_data_repository.dart';

@LazySingleton(as: IAuthDataRepository)
class DemoRepository implements IAuthDataRepository {
  @override
  Future<Either<ServerFailure, User>> getUserLogged() async {
    final _exampleUser = User(
      sessionId: "This_could_be_a_perfect_token",
      username: "Diego",
    );
    return Right(_exampleUser);
  }
}
