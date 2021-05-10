import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_social/domain/activities/failures/activities_failures.dart';
import 'package:go_social/domain/activities/models/activity.dart';
import 'package:go_social/domain/activities/services/i_activities_service_interface.dart';
import 'package:go_social/domain/activities/use_cases/get_activities_use_case.dart';
import 'package:go_social/domain/core/failures.dart';
import 'package:go_social/domain/core/use_case.dart';
import 'package:go_social/infrastructure/activities/repositories/demo_repository.dart';

import 'package:go_social/infrastructure/core/failures/server_failures.dart';
import 'package:mockito/mockito.dart';

class ActivityServiceMock extends Mock implements IActivityService {}

void main() {
  GetActivitiesUseCase useCase;
  ActivityServiceMock activityServiceMock;
  RandomActivityGenerator randomActivityGenerator;
  final activities = <Activity>[];

  setUp(() {
    activityServiceMock = ActivityServiceMock();
    useCase = GetActivitiesUseCase(activityServiceMock);
    randomActivityGenerator = RandomActivityGenerator(random: Random());
    for (var i = 0; i < 20; i++) {
      activities.add(randomActivityGenerator.generateActivity());
    }
  });
  group('Get Activities use case', () {
    test('Success Path', () async {
      final _params = NoParams();

      final _stream = StreamController<List<Activity>>.broadcast();

      when(activityServiceMock.getActivities())
          .thenAnswer((_) => Right(_stream.stream));
      final _result = await useCase(_params);

      expect(_result, Right(_stream.stream));

      verify(activityServiceMock.getActivities());

      verifyNoMoreInteractions(activityServiceMock);
    });

    group('Failure Path, checking:', () {
      test('Activities Not found', () async {
        final _params = NoParams();

        when(activityServiceMock.getActivities())
            .thenAnswer((_) => Left(ServerFailure.notFound()));
        final _result = await useCase(_params);

        expect(_result, Left(ActivitiesFailure.notFound()));

        verify(activityServiceMock.getActivities());

        verifyNoMoreInteractions(activityServiceMock);
      });

      test('Activities other failure', () async {
        final _params = NoParams();

        final _error = ErrorContent(
          message: "Some error",
          errorCode: 403,
        );
        when(activityServiceMock.getActivities())
            .thenAnswer((_) => Left(ServerFailure.badRequest(details: _error)));
        final _result = await useCase(_params);

        expect(
            _result, Left(ActivitiesFailure.serverError(errorContent: _error)));

        verify(activityServiceMock.getActivities());

        verifyNoMoreInteractions(activityServiceMock);
      });
    });
  });
}
