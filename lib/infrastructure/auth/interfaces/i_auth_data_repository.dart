import 'package:dartz/dartz.dart';
import '../../../domain/auth/models/user.dart';
import '../../core/failures/server_failures.dart';

abstract class IAuthDataRepository {
  Future<Either<ServerFailure, User>> getUserLogged();
}
