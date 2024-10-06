part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserDataEntity? userData;
  ProfileSuccess({
    this.userData,
  });
}

final class ProfileFailed extends ProfileState {
  final String errorMessage;
  ProfileFailed({
    required this.errorMessage,
  });
}
