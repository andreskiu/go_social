import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:go_social/domain/auth/failures/auth_failures.dart';
import 'package:go_social/domain/auth/models/user.dart';
import 'package:go_social/domain/auth/services/i_auth_services.dart';
import 'package:go_social/domain/auth/use_cases/get_user_logged_use_case.dart';
import 'package:go_social/domain/core/use_case.dart';
import 'package:go_social/infrastructure/core/failures/server_failures.dart';

class AuthServiceMock extends Mock implements IAuthService {}

void main() {
  GetUserLoggedUseCase useCase;
  AuthServiceMock authServiceMock;
  const _username = "Andreskiu";
  const _session = "shjdfbhjk3hj3kvgriy43hgki5y34454";
  final _validUser = User(
    sessionId: _session,
    username: _username,
  );
  setUp(() {
    authServiceMock = AuthServiceMock();
    useCase = GetUserLoggedUseCase(authServiceMock);
  });
  group('Get User Logged use case', () {
    test('Success Path', () async {
      final _params = NoParams();

      when(authServiceMock.getUserLogged()).thenAnswer(
        (_) async => Right(_validUser),
      );
      final _result = await useCase(_params);

      expect(_result, Right(_validUser));

      verify(authServiceMock.getUserLogged());

      verifyNoMoreInteractions(authServiceMock);
    });

    test('Failure Path - Not found failure', () async {
      final _params = NoParams();
      final _failure = ServerFailure.notFound();
      when(authServiceMock.getUserLogged()).thenAnswer(
        (_) async => Left(_failure),
      );
      final _result = await useCase(_params);

      expect(_result, Left(AuthFailure.notFound()));

      verify(authServiceMock.getUserLogged());

      verifyNoMoreInteractions(authServiceMock);
    });

    test('Failure Path - general failures', () async {
      final _params = NoParams();
      final _failure = ServerFailure.connectionError();
      when(authServiceMock.getUserLogged()).thenAnswer(
        (_) async => Left(_failure),
      );
      final _result = await useCase(_params);

      expect(
        _result,
        Left(AuthFailure.serverError(errorContent: _failure.details)),
      );

      verify(authServiceMock.getUserLogged());

      verifyNoMoreInteractions(authServiceMock);
    });
  });
}
