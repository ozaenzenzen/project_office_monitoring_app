part of 'platform_bloc.dart';

@immutable
sealed class PlatformState {}

final class PlatformInitial extends PlatformState {}

final class PlatformLoading extends PlatformState {}

final class PlatformSuccess extends PlatformState {}

final class PlatformFailed extends PlatformState {
  final String errorMessage;

  PlatformFailed({
    required this.errorMessage,
  });
}
