class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  LoginBloc loginBloc;
  MockUserRepository userRepository;
  MockAuthenticationBloc authenticationBloc;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(
      userRepository: userRepository,
      authenticationBloc: authenticationBloc,
    );
  });

  tearDown(() {
    loginBloc?.close();
    authenticationBloc?.close();
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        LoginInitial(),
        LoginLoading(),
        LoginInitial(),
      ];

      when(userRepository.authenticate(
        username: 'valid.username',
        password: 'valid.password',
        university: University.pwr,
      )).thenAnswer((_) => Future.value('token'));

      expectLater(
        loginBloc,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authenticationBloc.add(LoggedIn(
          token: 'token',
          university: University.pwr,
          username: 'valid.username',
        ))).called(1);
      });

      loginBloc.add(LoginButtonPressed(
        username: 'valid.username',
        password: 'valid.password',
        university: University.pwr,
      ));
    });
  });
}