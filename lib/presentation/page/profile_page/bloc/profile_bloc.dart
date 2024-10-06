// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/profile/get_profile_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/account_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';
import 'package:project_office_monitoring_app/domain/entities/user_data_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    AppAccountRepository accountRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      if (event is GetProfileRemoteAction) {
        _getProfileRemote(
          accountRepository,
          accountLocalRepository,
          platformLocalRepository,
        );
      } else if (event is GetProfileLocalAction) {
        _getProfileLocal(accountLocalRepository);
      }
    });
  }

  Future<void> _getProfileLocal(
    AccountLocalRepository accountLocalRepository,
  ) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      UserDataEntity? result = await accountLocalRepository.getUserData();
      if (result != null) {
        emit(ProfileSuccess(userData: result));
      } else {
        emit(
          ProfileFailed(
            errorMessage: "Data empty",
          ),
        );
      }
    } catch (e) {
      emit(
        ProfileFailed(
          errorMessage: "$e",
        ),
      );
    }
  }

  Future<void> _getProfileRemote(
    AppAccountRepository accountRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      InitializePlatformDataEntity? platformData = await platformLocalRepository.getActivationCode();
      if (platformData == null) {
        emit(
          ProfileFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }
      String? userToken = await accountLocalRepository.getUserToken();
      if (userToken == null) {
        emit(
          ProfileFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }

      GetProfileResponseModel? result = await accountRepository.getUserData(
        platformkey: platformData.platformKey ?? "",
        token: userToken,
      );
      if (result != null) {
        if (result.status == 200) {
          accountLocalRepository.setUserData(result.toUserDataEntity());
          var companyEntity = result.toCompanyDataEntity();
          if (companyEntity != null) {
            accountLocalRepository.setCompanyData(result.toCompanyDataEntity()!);
          }
          emit(
            ProfileSuccess(
              userData: result.toUserDataEntity(),
            ),
          );
        } else {
          emit(
            ProfileFailed(
              errorMessage: "${result.message}",
            ),
          );
        }
      } else {
        emit(
          ProfileFailed(
            errorMessage: "data is empty",
          ),
        );
      }
    } catch (e) {
      emit(
        ProfileFailed(
          errorMessage: "$e",
        ),
      );
    }
  }
}
