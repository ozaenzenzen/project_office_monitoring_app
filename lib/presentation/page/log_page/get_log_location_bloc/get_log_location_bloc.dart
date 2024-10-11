// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_response_model.dart';
import 'package:project_office_monitoring_app/data/repository/local/account_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/monitor_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/local/platform_local_repository.dart';
import 'package:project_office_monitoring_app/data/repository/remote/monitor_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';
import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';

part 'get_log_location_event.dart';
part 'get_log_location_state.dart';

// @pragma('vm:entry-point')
// Future<void> insertToLocalUseCompute(
//   MonitorLocalRepository monitorLocalRepository,
//   GetListLogDataEntity value,
// ) async {
//   await AppInitConfig.localStorage.init();
//   await compute<GetListLogDataEntity, void>(
//     monitorLocalRepository.setListLog,
//     value,
//   );
// }

class GetLogLocationBloc extends Bloc<GetLogLocationEvent, GetLogLocationState> {
  GetLogLocationBloc(
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
    MonitorLocalRepository monitorLocalRepository,
  ) : super(GetLogLocationInitial()) {
    on<GetLogLocationEvent>((event, emit) {
      if (event is GetLogLocationAction) {
        if (event.req.typeAction == TypeAction.refresh) {
          currentPage = 1;
          responseData.listData = [];
          listResponseData = [];
          _getListLogAction(
            event,
            monitorRepository,
            accountLocalRepository,
            platformLocalRepository,
            monitorLocalRepository,
          );
        } else {
          if (currentPage <= responseData.totalPages!) {
            currentPage++;
            _getListLogAction(
              event,
              monitorRepository,
              accountLocalRepository,
              platformLocalRepository,
              monitorLocalRepository,
            );
          } else {
            emit(
              GetLogLocationSuccess(
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

  // Future<void> insertToLocalUseCompute(
  //   MonitorLocalRepository monitorLocalRepository,
  //   GetListLogDataEntity value,
  // ) async {
  //   await compute<GetListLogDataEntity, void>(
  //     monitorLocalRepository.setListLog,
  //     value,
  //   );
  // }

  // Future<void> insertToLocal(
  //   MonitorLocalRepository monitorLocalRepository,
  //   GetListLogDataEntity value,
  // ) async {
  //   await monitorLocalRepository.setListLog(value);
  // }

  Future<void> _getListLogAction(
    GetLogLocationAction event,
    MonitorRepository monitorRepository,
    AccountLocalRepository accountLocalRepository,
    PlatformLocalRepository platformLocalRepository,
    MonitorLocalRepository monitorLocalRepository,
  ) async {
    emit(GetLogLocationLoading());
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      InitializePlatformDataEntity? platformData = await platformLocalRepository.getActivationCode();
      if (platformData == null) {
        emit(
          GetLogLocationFailed(
            errorMessage: "data support is empty",
          ),
        );
        return;
      }
      String? userToken = await accountLocalRepository.getUserToken();
      if (userToken == null) {
        emit(
          GetLogLocationFailed(
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
          await monitorLocalRepository.setListLog(responseData);
          // await insertToLocalUseCompute(monitorLocalRepository, responseData);
          emit(GetLogLocationSuccess(
            data: responseData,
            typeAction: event.req.typeAction,
          ));
        } else {
          emit(
            GetLogLocationFailed(
              errorMessage: "${result.message}",
            ),
          );
        }
      } else {
        emit(
          GetLogLocationFailed(
            errorMessage: "Data is empty",
          ),
        );
      }
    } catch (e) {
      emit(
        GetLogLocationFailed(
          errorMessage: "$e",
        ),
      );
    }
  }
}
