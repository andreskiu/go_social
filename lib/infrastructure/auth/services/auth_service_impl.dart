import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/auth/models/user.dart';
import '../../../domain/auth/services/i_auth_services.dart';
import '../interfaces/i_auth_data_repository.dart';
import '../../core/failures/server_failures.dart';

@LazySingleton(as: IAuthService)
class AuthService implements IAuthService {
  final IAuthDataRepository dataRepository;

  AuthService({
    @required this.dataRepository,
  });

  @override
  Future<Either<ServerFailure, User>> getUserLogged() {
    return dataRepository.getUserLogged();
  }
}
