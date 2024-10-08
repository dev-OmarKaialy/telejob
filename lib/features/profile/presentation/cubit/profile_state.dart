part of 'profile_cubit.dart';

class ProfileState {
  final CubitStatus profileStatus;
  final CubitStatus updateProfileStatus;
  final GetProfileModel? profile;
  const ProfileState({
    this.profileStatus = CubitStatus.init,
    this.updateProfileStatus = CubitStatus.init,
    this.profile,
  });

  ProfileState copyWith({
    CubitStatus? profileStatus,
    CubitStatus? updateProfileStatus,
    GetProfileModel? profile,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      profile: profile ?? this.profile,
    );
  }
}
