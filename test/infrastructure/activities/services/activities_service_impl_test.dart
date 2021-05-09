import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lyrics_app/domain/activities/models/activity.dart';
import 'package:lyrics_app/infrastructure/activities/interfaces/i_activities_data_interface.dart';
import 'package:lyrics_app/infrastructure/activities/services/activities_service_impl.dart';
import 'package:lyrics_app/infrastructure/core/failures/server_failures.dart';
import 'package:mockito/mockito.dart';

class IActivityDataRepositoryMock extends Mock
    implements IActivityDataRepository {}

void main() {
  DemoService service;
  IActivityDataRepositoryMock _repository;
  setUp(() {
    _repository = IActivityDataRepositoryMock();

    service = DemoService(
      dataRepository: _repository,
    );
  });
  group('Activities Service Implementation', () {
    group('get activities', () {
      test('retrieve information from repository', () {
        final stream = StreamController<List<Activity>>.broadcast();

        when(_repository.getActivities())
            .thenAnswer((_) => Right(stream.stream));

        final result = service.getActivities();

        expect(result, Right(stream.stream));
        verify(service.dataRepository.getActivities());
        verifyNoMoreInteractions(service.dataRepository);
      });

      test('Failre path', () {
        when(_repository.getActivities())
            .thenAnswer((_) => Left(ServerFailure.notFound()));

        final result = service.getActivities();

        expect(result, Left(ServerFailure.notFound()));
        verify(service.dataRepository.getActivities());
        verifyNoMoreInteractions(service.dataRepository);
      });
    });
  });
}
