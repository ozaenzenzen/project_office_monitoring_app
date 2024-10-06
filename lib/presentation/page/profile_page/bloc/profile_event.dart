part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetProfileLocalAction extends ProfileEvent {}

final class GetProfileRemoteAction extends ProfileEvent {}
