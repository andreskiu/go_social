import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:lyrics_app/domain/core/failures.dart';
import '../../domain/activities/use_cases/save_activity_use_case.dart';
import '../../domain/activities/activities_objects/activities_fields.dart';
import '../../domain/activities/models/activity.dart';

class ActivityFormState extends ChangeNotifier {
  ActivityFormState({
    this.initialActivity,
  });

  final SaveActivityUseCase saveActivityUseCase =
      GetIt.I.get<SaveActivityUseCase>();

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
    final _params = SaveActivityUseCaseParams(
      address: fieldAddress,
      date: fieldDate,
      title: fieldTitle,
      description: fieldDescription,
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
