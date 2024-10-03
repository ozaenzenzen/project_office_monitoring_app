// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/remote/account_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(AppAccountRepository accountRepository) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {
      if (event is SignInAction) {
        _signInAction(accountRepository, event);
      }
    });
  }

  Future<void> _signInAction(
    AppAccountRepository accountReposistory,
    SignInAction event,
  ) async {
    emit(SignInLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      SignInResponseModel? signInResponseModel = await accountReposistory.signIn(
        event.signInRequestModel,
        event.platformkey,
      );
      if (signInResponseModel != null) {
        if (signInResponseModel.status == 200) {
          emit(
            SignInSuccess(
                // userdata: signInResponseModel.userdata!,
                ),
          );
        } else {
          emit(
            SignInFailed(
              errorMessage: signInResponseModel.message.toString(),
            ),
          );
        }
      } else {
        emit(
          SignInFailed(
            errorMessage: "Terjadi kesalahan, data kosong",
          ),
        );
      }
    } catch (errorMessage) {
      emit(
        SignInFailed(
          errorMessage: errorMessage.toString(),
        ),
      );
    }
  }
}
