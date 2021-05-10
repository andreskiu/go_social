import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../core/failures.dart';

class AuthFailure extends Failure<AuthFailureTypes> with EquatableMixin {
  @override
  final AuthFailureTypes type;
  final ErrorContent details;

  AuthFailure({
    @required this.type,
    this.details,
  });

  @override
  List<Object> get props => [
        type,
        details,
      ];

  factory AuthFailure.invalidParams() {
    return AuthFailure(type: AuthFailureTypes.InvalidParams);
  }

  factory AuthFailure.notFound() {
    return AuthFailure(type: AuthFailureTypes.NotFound);
  }

  factory AuthFailure.serverError({@required ErrorContent errorContent}) {
    return AuthFailure(
      type: AuthFailureTypes.ServerError,
      details: errorContent,
    );
  }
}

enum AuthFailureTypes {
  NotFound,
  InvalidParams,
  ServerError,
}

class AuthFailureManager {
  ErrorContent getAuthErrorContent(AuthFailure failure) {
    var _msg = "";
    var _mustBeTranslated = true;
    var _errorCode = 0;

    switch (failure.type) {
      case AuthFailureTypes.InvalidParams:
        _msg = "auth.errors.user_not_logged";
        break;
      case AuthFailureTypes.NotFound:
        _msg = "auth.errors.user_not_logged";
        break;
      case AuthFailureTypes.ServerError:
        _msg = "auth.errors.user_not_logged";
        break;
    }

    return ErrorContent(
      errorCode: _errorCode,
      message: _msg,
      mustBeTranslated: _mustBeTranslated,
    );
  }
}
