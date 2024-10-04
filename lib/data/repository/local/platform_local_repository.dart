import 'dart:convert';

import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';
import 'package:project_office_monitoring_app/init_config.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';
import 'package:project_office_monitoring_app/support/local_service_hive.dart';

class PlatformLocalRepository {
  String activationCode = "activationCode";

  Future<void> setActivationCode(InitializePlatformDataEntity value) async {
    try {
      AppInitConfig.localStorage.config.putSecure(
        key: activationCode,
        data: jsonEncode(value.toJson()),
      );
    } on Exception catch (e) {
      AppLogger.debugLog("[setActivationCode][error] $e");
      rethrow;
    }
  }

  Future<InitializePlatformDataEntity?> getActivationCode() async {
    try {
      var output = await AppInitConfig.localStorage.config.getSecure(
        key: activationCode,
      );
      InitializePlatformDataEntity result = InitializePlatformDataEntity.fromJson(jsonDecode(output));
      return result;
    } on Exception catch (e) {
      AppLogger.debugLog("[getActivationCode][error] $e");
      return null;
    }
  }
}
