import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/activities/models/activity.dart';
import '../../core/failures/server_failures.dart';
import '../interfaces/i_activities_data_interface.dart';

const imageBasePath = "assets/images/activities/";

@LazySingleton(as: IActivityDataRepository)
class DemoRepository implements IActivityDataRepository {
  RandomActivityGenerator generator;
  final List<Activity> activities = [];
  final activityStream = StreamController<List<Activity>>.broadcast();
  @factoryMethod
  DemoRepository({Random random}) {
    generator = RandomActivityGenerator(
      random: random,
    );
    //data initialization
    for (var i = 0; i < 60; i++) {
      activities.add(generator.generateActivity());
    }
  }

  @override
  Either<ServerFailure, Stream<List<Activity>>> getActivities() {
    _sortActivities();
    Future.delayed(Duration(seconds: 1))
        .then((value) => activityStream.sink.add(activities));
    return Right(activityStream.stream);
  }

  void _sortActivities() {
    activities.sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<Either<ServerFailure, Unit>> saveActivity({Activity activity}) async {
    await Future.delayed(Duration(seconds: 1));

    final oldActivityIndex =
        activities.indexWhere((act) => act.id == activity.id);
    if (oldActivityIndex == -1) {
      activities.add(activity);
    } else {
      activities.replaceRange(oldActivityIndex, oldActivityIndex, [activity]);
    }
    _sortActivities();
    activityStream.sink.add(activities);
    return Right(unit);
  }
}

class RandomActivityGenerator {
  final Random random;
  int _id = 0;
  RandomActivityGenerator({
    @required this.random,
  });
  final persons = [
    "Andres",
    "Pablo",
    "Mariana",
    "Alejandro",
    "Diego",
    "Jessica",
    "Franco",
    "Carolina",
    "Silvia",
    "Luisina",
    "Gabriel",
    "Luis",
    "Bibiana",
    "Juan",
    "Martin",
  ];

  final locations = [
    "My house",
    "The Mall",
    "Shopping 1",
    "Tucson City",
    "Villa la Angostura, Neuquen, Argentina",
    "Brewery",
    "The forest",
    "Nahuel Huapi Lake",
  ];

  final activities = [
    "Birthday Party",
    "Pool Party",
    "Just a walk",
    "Car Race",
    "You know What",
    "Cinema",
    "Football Match"
  ];

  final descriptions = [
    "Hey guys, it's been a while since the last time we did this! Let's Go!",
    """Hey someone want to join me for this \"adventure\" ? 
    Come on, it will be fun!""",
    "This is a really nice description for this event, don\'t deny it",
  ];
  final images = [
    "bike.jpeg",
    "cinema.jpg",
    "party.jpeg",
    "pool_party.jpeg",
  ];

  Activity generateActivity() {
    final _date = DateTime(
      2021 - random.nextInt(30),
      12 - random.nextInt(12),
      28 - random.nextInt(27),
      23 - random.nextInt(23),
      59 - random.nextInt(59),
    );
    _id += 1;
    return Activity(
      id: _id,
      owner: persons[random.nextInt(persons.length - 1)],
      address: locations[random.nextInt(locations.length - 1)],
      title: activities[random.nextInt(activities.length - 1)],
      description: descriptions[random.nextInt(descriptions.length - 1)],
      date: _date,
      image: imageBasePath + images[random.nextInt(images.length - 1)],
    );
  }
}
