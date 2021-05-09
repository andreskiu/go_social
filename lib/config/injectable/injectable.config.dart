// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../application/activities/activities_page_state.dart';
import '../../infrastructure/core/api/api.dart';
import '../../infrastructure/activities/repositories/demo_repository.dart';
import '../../infrastructure/activities/services/activities_service_impl.dart';
import '../../infrastructure/core/api/api_configuration.dart';
import '../../domain/activities/use_cases/get_activities_use_case.dart';
import '../../infrastructure/activities/interfaces/i_activities_data_interface.dart';
import '../../domain/activities/services/i_activities_service_interface.dart';
import '../../domain/activities/use_cases/save_activity_use_case.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factoryAsync<ActivityPageState>(() => ActivityPageState.init());
  gh.factory<BaseOptions>(() => DevBaseOptions());
  gh.factory<Dio>(() => MyDio(baseOptions: get<BaseOptions>()));
  gh.lazySingleton<IActivityDataRepository>(
      () => DemoRepository(random: get<Random>()));
  gh.lazySingleton<IActivityService>(
      () => DemoService(dataRepository: get<IActivityDataRepository>()));
  gh.factory<InterceptorsWrapper>(() => AppInterceptorsWrapper());
  gh.lazySingleton<SaveActivityUseCase>(
      () => SaveActivityUseCase(get<IActivityService>()));
  gh.factory<Api>(() => ApiImpl(
      interceptorsWrapper: get<InterceptorsWrapper>(), dio: get<Dio>()));
  gh.lazySingleton<GetActivitiesUseCase>(
      () => GetActivitiesUseCase(get<IActivityService>()));
  return get;
}
