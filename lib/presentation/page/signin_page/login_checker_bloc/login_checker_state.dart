part of 'login_checker_bloc.dart';

@immutable
sealed class LoginCheckerState {}

final class LoginCheckerTrue extends LoginCheckerState {}

final class LoginCheckerFalse extends LoginCheckerState {}
