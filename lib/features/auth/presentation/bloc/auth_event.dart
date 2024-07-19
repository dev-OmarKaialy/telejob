part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String address;
  const RegisterEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'address': address});

    return result;
  }
}
