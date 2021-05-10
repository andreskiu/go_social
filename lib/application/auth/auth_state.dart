import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../../domain/auth/models/user.dart';
import '../../domain/auth/use_cases/get_user_logged_use_case.dart';
import '../../domain/core/use_case.dart';

@lazySingleton
class AuthState extends ChangeNotifier {
  AuthState({
    @required this.getUserLoggedUseCase,
  });

  @factoryMethod
  static Future<AuthState> init() async {
    final _activityPageState = AuthState(
      getUserLoggedUseCase: GetIt.I<GetUserLoggedUseCase>(),
    );
    await _activityPageState.getUserLogged();
    return _activityPageState;
  }

// injections
  final GetUserLoggedUseCase getUserLoggedUseCase;

//state
  User userLogged;
  Future<void> getUserLogged() async {
    final _userOrFailure = await getUserLoggedUseCase.call(NoParams());
    _userOrFailure.fold((left) {
      userLogged = null;
    }, (user) {
      userLogged = user;
    });
    notifyListeners();
  }
}
