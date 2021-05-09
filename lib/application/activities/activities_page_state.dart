import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../../domain/activities/models/activity.dart';
import '../../domain/activities/use_cases/get_activities_use_case.dart';
import '../../domain/core/use_case.dart';

@injectable
class ActivityPageState extends ChangeNotifier {
  ActivityPageState({
    @required this.getActivitiesUseCase,
  });

  @factoryMethod
  static Future<ActivityPageState> init() async {
    final _activityPageState = ActivityPageState(
      getActivitiesUseCase: GetIt.I<GetActivitiesUseCase>(),
    );
    await _activityPageState.getActivities();
    return _activityPageState;
  }

// injections
  final GetActivitiesUseCase getActivitiesUseCase;

//data
  Stream<List<Activity>> activitiesStream;

  Future<void> getActivities() async {
    final streamOrFailure = await getActivitiesUseCase(NoParams());
    streamOrFailure.fold((l) => null, (stream) {
      activitiesStream = stream;
    });

    notifyListeners();
  }
}
