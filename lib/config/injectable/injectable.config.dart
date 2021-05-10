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
import '../../infrastructure/auth/services/auth_service_impl.dart';
import '../../application/auth/auth_state.dart';
import '../../infrastructure/activities/repositories/demo_repository.dart';
import '../../infrastructure/auth/repository/demo_auth_repository.dart'
    as lyrics_app;
import '../../infrastructure/activities/services/activities_service_impl.dart';
import '../../infrastructure/core/api/api_configuration.dart';
import '../../domain/activities/use_cases/get_activities_use_case.dart';
import '../../domain/auth/use_cases/get_user_logged_use_case.dart';
import '../../infrastructure/activities/interfaces/i_activities_data_interface.dart';
import '../../domain/activities/services/i_activities_service_interface.dart';
import '../../infrastructure/auth/interfaces/i_auth_data_repository.dart';
import '../../domain/auth/services/i_auth_services.dart';
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
  gh.lazySingletonAsync<AuthState>(() => AuthState.init());
  gh.factory<BaseOptions>(() => DevBaseOptions());
  gh.factory<Dio>(() => MyDio(baseOptions: get<BaseOptions>()));
  gh.lazySingleton<IActivityDataRepository>(
      () => DemoRepository(random: get<Random>()));
  gh.lazySingleton<IActivityService>(
      () => DemoService(dataRepository: get<IActivityDataRepository>()));
  gh.lazySingleton<IAuthDataRepository>(() => lyrics_app.DemoRepository());
  gh.lazySingleton<IAuthService>(
      () => AuthService(dataRepository: get<IAuthDataRepository>()));
  gh.factory<InterceptorsWrapper>(() => AppInterceptorsWrapper());
  gh.lazySingleton<SaveActivityUseCase>(
      () => SaveActivityUseCase(get<IActivityService>()));
  gh.factory<Api>(() => ApiImpl(
      interceptorsWrapper: get<InterceptorsWrapper>(), dio: get<Dio>()));
  gh.lazySingleton<GetActivitiesUseCase>(
      () => GetActivitiesUseCase(get<IActivityService>()));
  gh.lazySingleton<GetUserLoggedUseCase>(
      () => GetUserLoggedUseCase(get<IAuthService>()));
  return get;
}
