// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/account/signin_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/account_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(
    AppAccountRepository accountRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {
      if (event is SignInAction) {
        _signInAction(
          accountRepository,
          accountLocalRepository,
          platformLocalRepository,
          event,
        );
      }
    });
  }

  Future<void> _signInAction(
    AppAccountRepository accountReposistory,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
    SignInAction event,
  ) async {
    emit(SignInLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      InitializePlatformDataEntity? dataPlatformKey = await platformLocalRepository.getActivationCode();
      if (dataPlatformKey != null) {
        SignInResponseModel? signInResponseModel = await accountReposistory.signIn(
          event.signInRequestModel,
          dataPlatformKey.platformKey ?? "",
        );
        if (signInResponseModel != null) {
          if (signInResponseModel.status == 200) {
            if (signInResponseModel.userToken != null) {
              accountLocalRepository.setUserToken(signInResponseModel.userToken ?? "");
            }
            accountLocalRepository.setIsLogin(true);
            accountLocalRepository.setUserData(signInResponseModel.toUserDataEntity());
            if (signInResponseModel.data != null) {
              accountLocalRepository.setCompanyData(signInResponseModel.data!.toCompanyDataEntity());
            }
            accountLocalRepository.setIsLogin(true);
            emit(SignInSuccess());
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
