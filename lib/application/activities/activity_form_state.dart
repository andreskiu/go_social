import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../../domain/auth/use_cases/get_user_logged_use_case.dart';
import '../../domain/core/use_case.dart';

import '../../domain/activities/activities_objects/activities_fields.dart';
import '../../domain/activities/models/activity.dart';
import '../../domain/activities/use_cases/save_activity_use_case.dart';
import '../../domain/core/failures.dart';

class ActivityFormState extends ChangeNotifier {
  ActivityFormState({
    this.initialActivity,
  });

  final SaveActivityUseCase saveActivityUseCase =
      GetIt.I.get<SaveActivityUseCase>();

  final GetUserLoggedUseCase getUserLoggedUseCase =
      GetIt.I.get<GetUserLoggedUseCase>();

  final Activity initialActivity;

  //state
  bool isLoading = false;

  FieldActivityTitle fieldTitle;
  FieldActivityDescription fieldDescription;
  FieldActivityDate fieldDate;
  FieldActivityAddress fieldAddress;
  ErrorContent error;

  Future<bool> submitForm() async {
    isLoading = true;
    notifyListeners();
    final userLoggedOrFailure = await getUserLoggedUseCase(NoParams());

    final _params = SaveActivityUseCaseParams(
      activity: initialActivity,
      address: fieldAddress,
      date: fieldDate,
      title: fieldTitle,
      description: fieldDescription,
      owner: userLoggedOrFailure?.getOrElse(() => null)?.username,
    );
    final _successOrFailure = await saveActivityUseCase(_params);
    // do something with the result. show some error.
    _successOrFailure.fold((fail) {
      error = fail.details;
    }, (_) {
      error = null;
    });

    isLoading = false;
    notifyListeners();
    return _successOrFailure.isRight();
  }
}
