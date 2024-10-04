part of 'platform_activation_bloc.dart';

@immutable
sealed class PlatformActivationState {}

final class PlatformActivationHide extends PlatformActivationState {}

final class PlatformActivationShow extends PlatformActivationState {}
// final class PlatformActivationInitial extends PlatformActivationState {}
// final class PlatformActivationInitial extends PlatformActivationState {}
