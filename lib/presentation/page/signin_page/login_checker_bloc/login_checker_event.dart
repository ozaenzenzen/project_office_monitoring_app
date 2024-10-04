part of 'login_checker_bloc.dart';

@immutable
sealed class LoginCheckerEvent {}

final class CheckIsLoginAction extends LoginCheckerEvent {}