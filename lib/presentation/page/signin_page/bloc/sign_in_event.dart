part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

final class SignInAction extends SignInEvent {
  final SignInRequestModel signInRequestModel;
  // final String platformkey;

  SignInAction({
    required this.signInRequestModel,
    // required this.platformkey,
  });
}