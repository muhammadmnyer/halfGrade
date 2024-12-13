import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:half_grade/core/injection_container.dart';
import 'package:half_grade/domain_layer/repository.dart';
import 'package:half_grade/domain_layer/usecases/auth_usecases/login.dart';
import 'package:half_grade/domain_layer/usecases/auth_usecases/signup.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> login(BuildContext context,{required String email, required String password}) async {

    emit(const AuthLoading());

    final login = Login(repository: InjectionContainer.instance.get<Repository>());

    login(
      email: email,
      password: password,
    )
        .then((value) {
          value.fold(
              (l) {
                emit(AuthFailed(error: l.message));
              },
              (r) {
                emit(const AuthInitial());
                Navigator.of(context,rootNavigator: true)
                    .pushNamedAndRemoveUntil('/', (route) => false,);
              },
          );
    },);

  }

  Future<void> signup(BuildContext context,{
    required String email,
    required String password,
    required String schoolName,
    required String city,
    required String username
  })async{
    emit(const AuthLoading());
    final signUp = SignUp(repository: InjectionContainer.instance.get());
    signUp(
        email: email,
        password: password,
        schoolName: schoolName,
        city: city,
        username: username
    )
        .then((value) {
      value.fold(
            (l) {
          emit(AuthFailed(error: l.message));
        },
            (r) {
              emit(const AuthFailed(error: 'please verify your email'));
              Navigator.of(context,rootNavigator: true)
                .pushNamedAndRemoveUntil('login', (route) => false,);
        },
      );
    },);
  }

}
