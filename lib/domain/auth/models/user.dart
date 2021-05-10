import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String sessionId;
  final String username;
  User({
    @required this.sessionId,
    @required this.username,
  });

  @override
  List<Object> get props => [
        sessionId,
        username,
      ];
}
