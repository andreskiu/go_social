import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/use_case.dart';
import '../activities_objects/activities_fields.dart';
import '../failures/activities_failures.dart';
import '../models/activity.dart';
import '../services/i_activities_service_interface.dart';

@lazySingleton
class SaveActivityUseCase extends UseCase<Unit, SaveActivityUseCaseParams> {
  final IActivityService service;

  SaveActivityUseCase(this.service);

  @override
  Future<Either<ActivitiesFailure, Unit>> call(
    SaveActivityUseCaseParams params,
  ) async {
    if (!params.areValid()) {
      return Left(ActivitiesFailure.invalidParams());
    }
    Activity _activity;
    if (params.activity == null) {
      //new activity
      _activity = Activity.empty().copyWith(owner: params.owner);
    } else {
      _activity = params.activity;
    }

    final _activityToSave = _activity.copyWith(
      address: params.address.getValue(),
      title: params.title.getValue(),
      description: params.description.getValue(),
      date: params.date.getValue(),
    );
    final _successOrFailure =
        await service.saveActivity(activity: _activityToSave);

    return _successOrFailure.fold(
      (fail) {
        return Left(
          ActivitiesFailure(
            type: ActivitiesFailureTypes.ServerError,
            details: fail.details,
          ),
        );
      },
      (_) => Right(_),
    );
  }
}

class SaveActivityUseCaseParams extends Equatable {
  final FieldActivityTitle title;
  final FieldActivityDescription description;
  final FieldActivityAddress address;
  final FieldActivityDate date;
  final Activity activity;
  final String owner;

  SaveActivityUseCaseParams({
    @required this.title,
    @required this.description,
    @required this.address,
    @required this.date,
    @required this.owner,
    this.activity,
  });

  bool areValid() {
    return title.isValid() &&
        description.isValid() &&
        date.isValid() &&
        address.isValid();
  }

  @override
  List<Object> get props => [
        title.value,
        description.value,
        date.value,
        address.value,
      ];
}
