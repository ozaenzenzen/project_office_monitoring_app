// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/platform/initialize_platform_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/platform/initialize_platform_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/platform_repository.dart';

part 'platform_event.dart';
part 'platform_state.dart';

class PlatformBloc extends Bloc<PlatformEvent, PlatformState> {
  PlatformBloc(
    PlatformRepository platformRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) : super(PlatformInitial()) {
    on<PlatformEvent>((event, emit) {
      if (event is InitializePlatformAction) {
        _initializePlatformAction(
          platformRepository,
          accountLocalRepository,
          platformLocalRepository,
          event,
        );
      }
    });
  }

  Future<void> _initializePlatformAction(
    PlatformRepository platformRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
    InitializePlatformAction event,
  ) async {
    emit(PlatformLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      InitializePlatformResponseModel? initializePlatformResponseModel = await platformRepository.initializePlatform(
        event.initializePlatformRequestModel,
      );
      if (initializePlatformResponseModel != null) {
        if (initializePlatformResponseModel.status == 200) {
          platformLocalRepository.setActivationCode(initializePlatformResponseModel.toCompanyDataEntity());
          accountLocalRepository.setIsActivationCodeActive(true);
          emit(
            PlatformSuccess(),
          );
        } else {
          emit(
            PlatformFailed(
              errorMessage: initializePlatformResponseModel.message.toString(),
            ),
          );
        }
      } else {
        emit(
          PlatformFailed(
            errorMessage: "Terjadi kesalahan, data kosong",
          ),
        );
      }
    } catch (errorMessage) {
      emit(
        PlatformFailed(
          errorMessage: errorMessage.toString(),
        ),
      );
    }
  }
}
