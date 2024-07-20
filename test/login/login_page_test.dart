import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_show/bloc/login/login_bloc.dart';
import 'package:pokemon_show/bloc/login/login_event.dart';
import 'package:pokemon_show/bloc/login/login_state.dart';
import 'package:pokemon_show/pages/login_page.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  group('LoginPage', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = MockLoginBloc();
    });

    testWidgets('renders LoginPage', (tester) async {
      final mockLoginBloc = MockLoginBloc();

      whenListen(
        mockLoginBloc,
        Stream.fromIterable(<LoginState>[]),
        initialState: LoginSuccess(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => loginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
