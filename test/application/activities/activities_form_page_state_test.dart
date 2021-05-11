import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_social/application/activities/activity_form_state.dart';
import 'package:go_social/domain/activities/activities_objects/activities_fields.dart';
import 'package:go_social/domain/activities/failures/activities_failures.dart';
import 'package:go_social/domain/activities/models/activity.dart';
import 'package:go_social/domain/activities/use_cases/save_activity_use_case.dart';
import 'package:go_social/domain/auth/models/user.dart';
import 'package:go_social/domain/auth/use_cases/get_user_logged_use_case.dart';
import 'package:go_social/domain/core/failures.dart';
import 'package:go_social/domain/core/use_case.dart';
import 'package:go_social/infrastructure/activities/repositories/demo_repository.dart';
import 'package:mockito/mockito.dart';

class SaveActivityUseCaseMock extends Mock implements SaveActivityUseCase {}

class GetUserLoggedUseCaseMock extends Mock implements GetUserLoggedUseCase {}

void main() {
  SaveActivityUseCaseMock saveActivityUseCaseMock;
  GetUserLoggedUseCaseMock getUserLoggedUseCaseMock;
  ActivityFormState state;
  RandomActivityGenerator randomActivityGenerator;
  Activity exampleActivity;

  setUpAll(() {
    saveActivityUseCaseMock = SaveActivityUseCaseMock();
    GetIt.I.registerFactory<SaveActivityUseCase>(() => saveActivityUseCaseMock);

    getUserLoggedUseCaseMock = GetUserLoggedUseCaseMock();
    GetIt.I.registerFactory<GetUserLoggedUseCase>(
      () => getUserLoggedUseCaseMock,
    );
    randomActivityGenerator = RandomActivityGenerator(random: Random());
    exampleActivity = randomActivityGenerator.generateActivity();
  });
  group('Activity Form State', () {
    test('Checking Initialization', () async {
      state = ActivityFormState(
        initialActivity: null,
      );

      expect(state.fieldAddress, null);
      expect(state.fieldDate, null);
      expect(state.fieldDescription, null);
      expect(state.fieldTitle, null);
      expect(state.initialActivity, null);
      expect(state.isLoading, false);
    });
    group('Submit form', () {
      test('Checking succesful path', () async {
        state = ActivityFormState(
          initialActivity: null,
        );

        expect(state.isLoading, false);
        state.fieldAddress = FieldActivityAddress(exampleActivity.address);
        state.fieldDate = FieldActivityDate(exampleActivity.date);
        state.fieldDescription =
            FieldActivityDescription(exampleActivity.description);
        state.fieldTitle = FieldActivityTitle(exampleActivity.title);

        final _params = SaveActivityUseCaseParams(
          address: state.fieldAddress,
          date: state.fieldDate,
          description: state.fieldDescription,
          title: state.fieldTitle,
          owner: "owner",
        );

        final _activitySaved = Activity(
          owner: _params.owner,
          address: _params.address.getValue(),
          title: _params.address.getValue(),
          description: _params.description.getValue(),
          date: _params.date.getValue(),
        );

        final _user = User(
          sessionId: "sessionId",
          username: "owner",
        );

        when(state.saveActivityUseCase(_params))
            .thenAnswer((_) async => Right(_activitySaved));

        when(state.getUserLoggedUseCase(NoParams()))
            .thenAnswer((_) async => Right(_user));

        final _expectedLoadingValues = [true, false];
        final _expectedActivitySavesValues = [null, _activitySaved];

        state.addListener(() {
          expect(state.isLoading, _expectedLoadingValues.removeAt(0));
          expect(state.error, null);
          expect(state.activitySaved, _expectedActivitySavesValues.removeAt(0));
        });

        final result = await state.submitForm();

        expect(result, true);
        verify(state.saveActivityUseCase(_params));

        verifyNoMoreInteractions(state.saveActivityUseCase);
      });

      test('Checking Failure path', () async {
        state = ActivityFormState(
          initialActivity: null,
        );

        expect(state.isLoading, false);
        state.fieldAddress = FieldActivityAddress(exampleActivity.address);
        state.fieldDate = FieldActivityDate(exampleActivity.date);
        state.fieldDescription =
            FieldActivityDescription(exampleActivity.description);
        state.fieldTitle = FieldActivityTitle(exampleActivity.title);

        final _params = SaveActivityUseCaseParams(
          address: state.fieldAddress,
          date: state.fieldDate,
          description: state.fieldDescription,
          title: state.fieldTitle,
          owner: "owner",
        );

        final _failure = ActivitiesFailure.invalidParams();
        final _user = User(
          sessionId: "sessionId",
          username: "owner",
        );

        when(state.saveActivityUseCase(_params))
            .thenAnswer((_) async => Left(_failure));

        when(state.getUserLoggedUseCase(NoParams()))
            .thenAnswer((_) async => Right(_user));

        final _expectedLoadingValues = [true, false];
        final _expectedErrorValues = [null, _failure.details];

        state.addListener(() {
          expect(state.isLoading, _expectedLoadingValues.removeAt(0));
          expect(state.error, _expectedErrorValues.removeAt(0));
          expect(state.activitySaved, null);
        });

        final result = await state.submitForm();

        expect(result, false);
        verify(state.saveActivityUseCase(_params));

        verifyNoMoreInteractions(state.saveActivityUseCase);
      });
    });
  });
}
