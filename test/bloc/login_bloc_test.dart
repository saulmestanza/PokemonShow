import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_show/bloc/login/login_bloc.dart';
import 'package:pokemon_show/bloc/login/login_event.dart';
import 'package:pokemon_show/bloc/login/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LoginBloc', () {
    SharedPreferences.setMockInitialValues({});
    late SharedPreferences sharedPreferences;

    setUp(() {
      sharedPreferences = MockSharedPreferences();
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when LoginSubmitted fails',
      build: () {
        return LoginBloc();
      },
      act: (bloc) => bloc.add(
        LoginSubmitted(
          email: 'test@example.com',
          password: 'password',
        ),
      ),
      expect: () => [
        LoginLoading(),
        isA<LoginFailure>(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when LoginSubmitted is added',
      build: () {
        when(() => sharedPreferences.setBool("isLoggedIn", true)).thenAnswer(
          (_) async => true,
        );
        return LoginBloc();
      },
      act: (bloc) => bloc.add(
        LoginSubmitted(email: 'admin', password: 'admin'),
      ),
      expect: () => [
        LoginLoading(),
        LoginSuccess(),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginSuccess] when isLoggedIn is true',
      build: () {
        when(() => sharedPreferences.getBool("isLoggedIn")).thenAnswer(
          (_) => true,
        );
        return LoginBloc();
      },
      act: (bloc) => bloc.add(LoginCheckStatus()),
      expect: () {
        return [
          LoginLoading(),
          LoginSuccess(),
        ];
      },
    );
  });
}
