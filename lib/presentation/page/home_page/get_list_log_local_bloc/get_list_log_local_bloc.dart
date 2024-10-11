// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_office_monitoring_app/data/repository/local/monitor_local_repository.dart';
import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';

part 'get_list_log_local_event.dart';
part 'get_list_log_local_state.dart';

class GetListLogLocalBloc extends Bloc<GetListLogLocalEvent, GetListLogLocalState> {
  GetListLogLocalBloc(
    MonitorLocalRepository monitorLocalRepository,
  ) : super(GetListLogLocalInitial()) {
    on<GetListLogLocalEvent>((event, emit) async {
      if (event is GetListLogLocalAction) {
        await _getListLogLocalAction(monitorLocalRepository);
      }
    });
  }

  // Future<GetListLogDataEntity?> getFromLocalUseCompute(
  //   MonitorLocalRepository monitorLocalRepository,
  // ) async {
  //   try {
  //     var data = await compute<void, GetListLogDataEntity?>(
  //       monitorLocalRepository.getListLog,
  //       null,
  //     );
  //     AppLogger.debugLog("data $data");
  //     return data;
  //   } catch (e) {
  //     AppLogger.debugLog("error $e");
  //     return null;
  //   }
  // }

  Future<void> _getListLogLocalAction(
    MonitorLocalRepository monitorLocalRepository,
  ) async {
    emit(GetListLogLocalLoading());
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      GetListLogDataEntity? result = await monitorLocalRepository.getListLog();
      // GetListLogDataEntity? result = await getFromLocalUseCompute(monitorLocalRepository);
      if (result != null) {
        emit(
          GetListLogLocalSuccess(
            output: result,
          ),
        );
      } else {
        emit(
          GetListLogLocalFailed(
            errorMessage: "empty data",
          ),
        );
      }
    } catch (e) {
      emit(
        GetListLogLocalFailed(
          errorMessage: "$e",
        ),
      );
    }
  }

  // Future<void> _getListLogLocalAction() async {
  //   emit(GetListLogLocalLoading());
  //   try {
  //     //
  //   } catch (e) {
  //     emit(
  //       GetListLogLocalFailed(
  //         errorMessage: "$e",
  //       ),
  //     );
  //   }
  // }
}
