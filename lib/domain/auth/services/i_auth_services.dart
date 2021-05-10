import 'package:dartz/dartz.dart';

import '../../../infrastructure/core/failures/server_failures.dart';
import '../models/user.dart';

abstract class IAuthService {
  Future<Either<ServerFailure, User>> getUserLogged();
}
