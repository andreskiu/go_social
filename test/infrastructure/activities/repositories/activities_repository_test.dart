import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lyrics_app/domain/activities/models/activity.dart';
import 'package:lyrics_app/infrastructure/activities/repositories/demo_repository.dart';
import 'package:mockito/mockito.dart';

// class RandomMock extends Mock implements Random {}

void main() {
  DemoRepository _repository;
  // RandomMock randomMock;
  setUp(() {
    // randomMock = RandomMock();
    _repository = DemoRepository(random: Random());
  });
  group('Demo Repository', () {
    group('initialization', () {
      test('retrieve information from repository', () {
        // final _repo = DemoRepository(random: Random());

        expect(_repository.activities.length > 50, true);
        expect(_repository.activityStream != null, true);
      });
    });
    group('getActivities', () {
      test('retrieve information from repository', () {
        final _result = _repository.getActivities();
        final _stream = _result.getOrElse(() => null);

        expect(_stream != null, true);
        expect(_repository.activityStream != null, true);
        expectLater(_stream, emits(_repository.activities));
      });
    });
  });
}
