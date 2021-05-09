import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'validators.dart';
import '../../core/value_objects.dart';
import '../../activities/failures/activities_failures.dart';

abstract class ActivityObject<T> extends ValueObject {
  @override
  Either<ActivitiesFailure, T> get value;

  @override
  ActivitiesFailure getError() => value.fold((l) => l, (r) => null);

  @override
  T getValue() => value.getOrElse(() => null);
}

class FieldActivityTitle extends ActivityObject<String> {
  factory FieldActivityTitle(String input) {
    return FieldActivityTitle._(
      value: validateActivityTitle(input),
    );
  }

  FieldActivityTitle._({
    @required this.value,
  });

  @override
  final Either<ActivitiesFailure, String> value;
}

class FieldActivityDescription extends ActivityObject<String> {
  factory FieldActivityDescription(String input) {
    return FieldActivityDescription._(
      value: validateActivityDescription(input),
    );
  }

  FieldActivityDescription._({
    @required this.value,
  });

  @override
  final Either<ActivitiesFailure, String> value;
}

class FieldActivityAddress extends ActivityObject<String> {
  factory FieldActivityAddress(String input) {
    return FieldActivityAddress._(
      value: validateActivityAddress(input),
    );
  }

  FieldActivityAddress._({
    @required this.value,
  });

  @override
  final Either<ActivitiesFailure, String> value;
}

class FieldActivityDate extends ActivityObject<DateTime> {
  factory FieldActivityDate(DateTime input) {
    return FieldActivityDate._(
      value: validateActivityDate(input),
    );
  }

  FieldActivityDate._({
    @required this.value,
  });

  @override
  final Either<ActivitiesFailure, DateTime> value;
}
