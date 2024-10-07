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
import 'package:project_office_monitoring_app/support/app_logger.dart';

part 'get_log_staff_event.dart';
part 'get_log_staff_state.dart';

class GetLogStaffBloc extends Bloc<GetLogStaffEvent, GetLogStaffState> {
  GetLogStaffBloc(
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) : super(GetLogStaffInitial()) {
    on<GetLogStaffEvent>((event, emit) {
      if (event is GetLogStaffAction) {
        if (event.req.typeAction == TypeAction.refresh) {
          currentPage = 1;
          responseData.listData = [];
          listResponseData = [];
          _getListLogAction(
            event,
            monitorRepository,
            accountLocalRepository,
            platformLocalRepository,
          );
        } else {
          if (currentPage <= responseData.totalPages!) {
            currentPage++;
            _getListLogAction(
              event,
              monitorRepository,
              accountLocalRepository,
              platformLocalRepository,
            );
          } else {
            emit(
              GetLogStaffSuccess(
                data: responseData,
                typeAction: TypeAction.loading,
              ),
            );
          }
        }
      }
    });
  }

  GetListLogDataEntity responseData = GetListLogDataEntity();
  List<ListDatumEntity>? listResponseData = [];
  int currentPage = 1;

  Future<void> _getListLogAction(
    GetLogStaffAction event,
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
  ) async {
    emit(GetLogStaffLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      InitializePlatformDataEntity? platformData = await platformLocalRepository.getActivationCode();
      if (platformData == null) {
        emit(
          GetLogStaffFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }
      String? userToken = await accountLocalRepository.getUserToken();
      if (userToken == null) {
        emit(
          GetLogStaffFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }

      GetListLogRequestModel dataReq = event.req;
      dataReq.currentPage = currentPage;

      GetListLogResponseModel? result = await monitorRepository.getListLog(
        platformKey: platformData.platformKey!,
        userToken: userToken,
        req: dataReq,
      );
      if (result != null) {
        if (result.status == 200) {
          responseData = result.toEntity()!;
          listResponseData?.addAll(result.toEntity()!.listData!);
          responseData.listData = listResponseData;
          AppLogger.debugLog("length ${responseData.listData?.length}");
          emit(
            GetLogStaffSuccess(
              data: responseData,
              typeAction: dataReq.typeAction,
            ),
          );
        } else {
          emit(
            GetLogStaffFailed(
              errorMessage: "${result.message}",
            ),
          );
        }
      } else {
        emit(
          GetLogStaffFailed(
            errorMessage: "Data is empty",
          ),
        );
      }
    } catch (e) {
      emit(
        GetLogStaffFailed(
          errorMessage: "$e",
        ),
      );
    }
  }
}
