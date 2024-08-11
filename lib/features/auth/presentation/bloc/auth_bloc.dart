import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telejob/core/services/shared_preferences_service.dart';
import 'package:telejob/features/auth/data/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await AuthRepo()
          .login({'email': event.email, "password": event.password});
      result.fold((l) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (r) async {
        emit(state.copyWith(status: CubitStatus.success));
        await SharedPreferencesService.setToken(r.jwt!);
      });
    });

    on<RegisterEvent>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));
      final result = await AuthRepo().register(event.toMap());
      result.fold((l) {
        emit(state.copyWith(status: CubitStatus.failed));
      }, (r) async {
        emit(state.copyWith(status: CubitStatus.success));
        await SharedPreferencesService.setToken(r.jwt!);
      });
    });
  }
}
