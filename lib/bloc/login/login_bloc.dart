import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        if (event.email == "admin" && event.password == "admin") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(error: "Wrong credentials, please try again"));
        }
      } catch (e) {
        emit(LoginFailure(error: "Wrong credentials, please try again"));
      }
    });

    on<LoginCheckStatus>((event, emit) async {
      emit(LoginLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? isLoggedIn = prefs.getBool('isLoggedIn');
        if (isLoggedIn != null && isLoggedIn) {
          emit(LoginSuccess());
        } else {
          emit(LoginInitial());
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
