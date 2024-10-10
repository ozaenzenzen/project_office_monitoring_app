import 'dart:convert';

import 'package:project_office_monitoring_app/data/model/remote/capture/capture_location_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/capture/capture_location_response_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_location_response_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_log_response_model.dart';
import 'package:project_office_monitoring_app/env.dart';
import 'package:project_office_monitoring_app/support/app_api_path.dart';
import 'package:project_office_monitoring_app/support/app_api_service.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';

class MonitorRepository {
  Future<CaptureLocationResponseModel?> captureLocation({
    required String platformKey,
    required String userToken,
    required CaptureLocationRequestModel req,
  }) async {
    try {
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(
        AppApiPath.captureLocation,
        method: MethodRequest.post,
        request: req.toJson(),
        header: <String, String>{
          'platformkey': platformKey,
          'token': userToken,
        },
      );
      if (response.data != null) {
        return CaptureLocationResponseModel.fromJson(response.data);
      } else {
        return response.data;
      }
    } catch (errorMessage) {
      AppLogger.debugLog("[MonitorRepository][captureLocation] errorMessage $errorMessage");
      rethrow;
      // return null;
    }
  }

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
      GetListLogResponseModel mappingData = GetListLogResponseModel.fromJson(response.data);
      // AppLogger.debugLog("resp ${jsonEncode(mappingData.toJson())}");
      return mappingData;
    } catch (errorMessage) {
      AppLogger.debugLog("[MonitorRepository][getListLog] errorMessage $errorMessage");
      rethrow;
      // return null;
    }
  }
}