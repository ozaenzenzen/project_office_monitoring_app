part of 'platform_activation_bloc.dart';

@immutable
sealed class PlatformActivationEvent {}

final class CheckIsActivationCodeActiveAction extends PlatformActivationEvent {}