
part of 'auth_cubit.dart';


@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}
final class AuthLoading extends AuthState {
  const AuthLoading();
}
final class AuthFailed extends AuthState {
  final Object error;
  const AuthFailed({required this.error});
}
