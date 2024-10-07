// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/monitor_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';
import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';

part 'log_event.dart';
part 'log_state.dart';

class LogBloc extends Bloc<LogEvent, LogState> {
  LogBloc(
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) : super(LogInitial()) {
    on<LogEvent>((event, emit) {
      if (event is GetListLogAction) {
        _getListLogAction(
          event,
          monitorRepository,
          accountLocalRepository,
          platformLocalRepository,
        );
      }
    });
  }

  Future<void> _getListLogAction(
    GetListLogAction event,
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) async {
    emit(LogLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      InitializePlatformDataEntity? platformData = await platformLocalRepository.getActivationCode();
      if (platformData == null) {
        emit(
          LogFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }
      String? userToken = await accountLocalRepository.getUserToken();
      if (userToken == null) {
        emit(
          LogFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }

      GetListLogResponseModel? result = await monitorRepository.getListLog(
        platformKey: platformData.platformKey!,
        userToken: userToken,
        req: event.req,
      );
      if (result != null) {
        if (result.status == 200) {
          emit(LogSuccess(
            result: result.toEntity(),
          ));
        } else {
          emit(
            LogFailed(
              errorMessage: "${result.message}",
            ),
          );
        }
      } else {
        emit(
          LogFailed(
            errorMessage: "Data is empty",
          ),
        );
      }
    } catch (e) {
      emit(
        LogFailed(
          errorMessage: "$e",
        ),
      );
    }
  }
}
