import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../core/failures.dart';

class ActivitiesFailure extends Failure<ActivitiesFailureTypes>
    with EquatableMixin {
  @override
  final ActivitiesFailureTypes type;
  final ErrorContent details;
  final ActivitiesFields field;
  ActivitiesFailure({
    @required this.type,
    this.details,
    this.field,
  });

  @override
  List<Object> get props => [
        type,
        details,
      ];

  factory ActivitiesFailure.invalidParams() {
    return ActivitiesFailure(type: ActivitiesFailureTypes.InvalidParams);
  }

  factory ActivitiesFailure.invalidDate() {
    return ActivitiesFailure(type: ActivitiesFailureTypes.InvalidDate);
  }

  factory ActivitiesFailure.Mandatory({
    ActivitiesFields field = ActivitiesFields.Any,
  }) {
    return ActivitiesFailure(
      type: ActivitiesFailureTypes.Mandatory,
      field: field,
    );
  }

  factory ActivitiesFailure.TooLong() {
    return ActivitiesFailure(type: ActivitiesFailureTypes.TooLong);
  }
  factory ActivitiesFailure.notFound() {
    return ActivitiesFailure(type: ActivitiesFailureTypes.NotFound);
  }

  factory ActivitiesFailure.serverError({@required ErrorContent errorContent}) {
    return ActivitiesFailure(
      type: ActivitiesFailureTypes.ServerError,
      details: errorContent,
    );
  }
}

enum ActivitiesFailureTypes {
  Mandatory,
  TooLong,
  InvalidDate,
  NotFound,
  InvalidParams,
  ServerError,
}

enum ActivitiesFields {
  Title,
  Description,
  Address,
  Any,
}

class ActivitiesFailureManager {
  ErrorContent getActivityErrorContent(ActivitiesFailure failure) {
    var _msg = "";
    var _mustBeTranslated = true;
    var _errorCode = 0;

    switch (failure.type) {
      case ActivitiesFailureTypes.InvalidParams:
        _msg = "activities.pages.activities.errors.invalidParams";
        break;
      case ActivitiesFailureTypes.NotFound:
        _msg = "activities.pages.activities.errors.notFound";
        break;
      case ActivitiesFailureTypes.ServerError:
        _msg = "activities.pages.activities.errors.server_error";
        break;
      case ActivitiesFailureTypes.Mandatory:
        switch (failure.field) {
          case ActivitiesFields.Title:
            _msg = "activities.fields.title.errors.empty";

            break;
          case ActivitiesFields.Description:
            _msg = "activities.fields.description.errors.empty";
            break;
          case ActivitiesFields.Any:
            _msg = "activities.fields.date.errors.empty";

            break;
          case ActivitiesFields.Address:
            _msg = "activities.fields.address.errors.empty";
            break;
        }
        break;
      case ActivitiesFailureTypes.TooLong:
        _msg = "activities.fields.title.errors.too_long";
        break;
      case ActivitiesFailureTypes.InvalidDate:
        _msg = "activities.fields.address.errors.invalid_date";
        break;
    }

    return ErrorContent(
      errorCode: _errorCode,
      message: _msg,
      mustBeTranslated: _mustBeTranslated,
    );
  }
}
