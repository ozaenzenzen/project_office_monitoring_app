import 'dart:developer';

import 'package:project_office_monitoring_app/data/model/remote/platform/initialize_platform_request_model.dart';
import 'package:project_office_monitoring_app/data/model/remote/platform/initialize_platform_response_model.dart';
import 'package:project_office_monitoring_app/env.dart';
import 'package:project_office_monitoring_app/support/app_api_path.dart';
import 'package:project_office_monitoring_app/support/app_api_service.dart';

class PlatformRepository {
  Future<InitializePlatformResponseModel?> initializePlatform(
    InitializePlatformRequestModel data,
  ) async {
    try {
      final response = await AppApiService(
        EnvironmentConfig.baseUrl(),
      ).call(
        AppApiPath.initializePlatform,
        request: data.toJson(),
      );
      return InitializePlatformResponseModel.fromJson(response.data);
    } catch (errorMessage) {
      log("[AppAccountReposistory][signin] errorMessage $errorMessage");
      rethrow;
    }
  }
}
