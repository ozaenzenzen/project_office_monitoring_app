part of 'platform_bloc.dart';

@immutable
sealed class PlatformEvent {}

final class InitializePlatformAction extends PlatformEvent {
  final InitializePlatformRequestModel initializePlatformRequestModel;

  InitializePlatformAction({
    required this.initializePlatformRequestModel,
  });
}