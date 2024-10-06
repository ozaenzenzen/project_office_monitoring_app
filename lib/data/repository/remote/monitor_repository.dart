import 'package:project_office_monitoring_app/data/model/remote/monitor/get_list_location_response_model.dart';
import 'package:project_office_monitoring_app/env.dart';
import 'package:project_office_monitoring_app/support/app_api_path.dart';
import 'package:project_office_monitoring_app/support/app_api_service.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';

class MonitorRepository {
  Future<GetListLocationResponseModel?> getListLocation({
    required String platformkey,
    required String token,
  }) async {
    try {
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(
        AppApiPath.getListLocation,
        method: MethodRequest.get,
        header: <String, String>{
          'platformkey': platformkey,
          'token': token,
        },
      );
      return GetListLocationResponseModel.fromJson(response.data);
    } catch (errorMessage) {
      AppLogger.debugLog("[MonitorRepository][getListLocation] errorMessage $errorMessage");
      rethrow;
      // return null;
    }
  }
}