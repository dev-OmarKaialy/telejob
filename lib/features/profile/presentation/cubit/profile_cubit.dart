import 'package:bloc/bloc.dart';
import 'package:telejob/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:telejob/features/profile/data/models/profile_model.dart';
import 'package:telejob/features/profile/data/repositories/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  getProfile() async {
    emit(state.copyWith(profileStatus: CubitStatus.loading));
    final result = await ProfileRepo().getProfile();
    result.fold((l) {
      emit(state.copyWith(profileStatus: CubitStatus.failed));
    }, (r) {
      emit(state.copyWith(profileStatus: CubitStatus.success));
    });
  }
}
