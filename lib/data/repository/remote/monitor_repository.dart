import 'dart:convert';

import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_location_response_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_response_model.dart';
import 'package:project_office_monitoring_app/env.dart';
import 'package:project_office_monitoring_app/support/app_api_path.dart';
import 'package:project_office_monitoring_app/support/app_api_service.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';

class MonitorRepository {
  Future<GetListLocationResponseModel?> getListLocation({
    required String platformKey,
    required String userToken,
  }) async {
    try {
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(
        AppApiPath.getListLocation,
        method: MethodRequest.get,
        header: <String, String>{
          'platformkey': platformKey,
          'token': userToken,
        },
      );
      return GetListLocationResponseModel.fromJson(response.data);
    } catch (errorMessage) {
      AppLogger.debugLog("[MonitorRepository][getListLocation] errorMessage $errorMessage");
      rethrow;
      // return null;
    }
  }

  Future<GetListLogResponseModel?> getListLog({
    required String platformKey,
    required String userToken,
    required GetListLogRequestModel req,
  }) async {
    try {
      Map<String, dynamic>? reqData;
      if (req.location != null) {
        reqData = req.toJsonWithLocation();
      } 
      if (req.staffUserStamp != null) {
        reqData = req.toJsonWithStaffUserStamp();
      }
      AppLogger.debugLog("req ${jsonEncode(reqData)}");
      var header = <String, String>{
        'platformkey': platformKey,
        'token': userToken,
      };
      // AppLogger.debugLog("header $header");
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(
        AppApiPath.getListLog,
        method: MethodRequest.post,
        // request: req.toJson(),
        request: reqData,
        header: header,
      );
      return GetListLogResponseModel.fromJson(response.data);
    } catch (errorMessage) {
      AppLogger.debugLog("[MonitorRepository][getListLog] errorMessage $errorMessage");
      rethrow;
      // return null;
    }
  }
}