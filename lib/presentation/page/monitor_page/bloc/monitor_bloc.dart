// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_location_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/monitor_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/get_list_location_data_entity.dart';
import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';

part 'monitor_event.dart';
part 'monitor_state.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  MonitorBloc(
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) : super(MonitorInitial()) {
    on<MonitorEvent>((event, emit) {
      if (event is GetListLocationAction) {
        _getListLocationAction(
          monitorRepository,
          accountLocalRepository,
          platformLocalRepository,
        );
      }
    });
  }

  Future<void> _getListLocationAction(
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) async {
    emit(MonitorLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      InitializePlatformDataEntity? platformData = await platformLocalRepository.getActivationCode();
      if (platformData == null) {
        emit(
          MonitorFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }
      String? userToken = await accountLocalRepository.getUserToken();
      if (userToken == null) {
        emit(
          MonitorFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }

      GetListLocationResponseModel? result = await monitorRepository.getListLocation(
        platformkey: platformData.platformKey!,
        token: userToken,
      );
      if (result != null) {
        if (result.status == 200) {
          emit(
            MonitorSuccess(
              result: result.toEntity() ?? [],
            ),
          );
        } else {
          emit(
            MonitorFailed(
              errorMessage: "Data support is empty",
            ),
          );
        }
      } else {
        emit(
          MonitorFailed(
            errorMessage: "Data support is empty",
          ),
        );
      }
    } catch (e) {
      emit(
        MonitorFailed(
          errorMessage: "$e",
        ),
      );
    }
  }
}
