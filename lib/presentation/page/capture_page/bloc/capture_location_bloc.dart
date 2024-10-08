// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/capture/capture_location_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/capture/capture_location_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/monitor_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';

part 'capture_location_event.dart';
part 'capture_location_state.dart';

class CaptureLocationBloc extends Bloc<CaptureLocationEvent, CaptureLocationState> {
  CaptureLocationBloc(
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) : super(CaptureLocationInitial()) {
    on<CaptureLocationEvent>((event, emit) {
      if (event is CaptureAction) {
        _captureAction(
          event,
          monitorRepository,
          accountLocalRepository,
          platformLocalRepository,
        );
      }
    });
  }

  Future<void> _captureAction(
    CaptureAction event,
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) async {
    emit(CaptureLocationLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      InitializePlatformDataEntity? platformData = await platformLocalRepository.getActivationCode();
      if (platformData == null) {
        emit(
          CaptureLocationFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }
      String? userToken = await accountLocalRepository.getUserToken();
      if (userToken == null) {
        emit(
          CaptureLocationFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }

      CaptureLocationResponseModel? result = await monitorRepository.captureLocation(
        platformKey: platformData.platformKey!,
        userToken: userToken,
        req: event.req,
      );
      if (result != null) {
        if (result.status == 201) {
          emit(
            CaptureLocationSuccess(
              resp: result,
            ),
          );
        } else {
          emit(
            CaptureLocationFailed(
              errorMessage: "${result.message}",
            ),
          );
        }
      } else {
        emit(
          CaptureLocationFailed(
            errorMessage: "Data is empty",
          ),
        );
      }
    } catch (e) {
      emit(
        CaptureLocationFailed(
          errorMessage: "$e",
        ),
      );
    }
  }

  // Future<void> _captureAction(
  //   MonitorRepository monitorRepository,
  //   AccountLocalRepository accountLocalRepository,
  //   PlatformLocalRepository platformLocalRepository,
  // ) async {
  //   try {
  //     //
  //   } catch (e) {
  //     //
  //   }
  // }
}
