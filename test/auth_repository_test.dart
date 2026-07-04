import 'package:dev_mate_ai/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthRepositoryImpl', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    test(
      'signIn marks the user as authenticated when credentials match',
      () async {
        final repository = AuthRepositoryImpl();

        final created = await repository.signUp(
          'user@example.com',
          'password123',
        );
        expect(created, isTrue);

        final authenticated = await repository.signIn(
          'user@example.com',
          'password123',
        );
        expect(authenticated, isTrue);
      },
    );
  });
}
