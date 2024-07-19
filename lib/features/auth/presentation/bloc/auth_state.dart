part of 'auth_bloc.dart';

enum CubitStatus { loading, success, init, failed }

class AuthState {
  final CubitStatus status;
  const AuthState({
    this.status = CubitStatus.init,
  });

  AuthState copyWith({
    CubitStatus? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }
}
