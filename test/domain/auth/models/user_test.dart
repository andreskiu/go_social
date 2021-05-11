import 'package:flutter_test/flutter_test.dart';
import 'package:go_social/domain/auth/models/user.dart';

void main() {
  const _username = "Andreskiu";
  const _session = "shjdfbhjk3hj3kvgriy43hgki5y34454";

  group('User Model', () {
    test('Testing Equality', () async {
      final _user = User(
        sessionId: _session,
        username: _username,
      );

      final _user2 = User(
        sessionId: _session,
        username: _username,
      );

      expect(_user, _user2);
    });
  });
}
