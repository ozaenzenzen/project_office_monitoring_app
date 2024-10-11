import 'dart:convert';

import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';
import 'package:project_office_monitoring_app/init_config.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';
import 'package:project_office_monitoring_app/support/local_service_hive.dart';

class MonitorLocalRepository {
  String listLog = "listLog";

  Future<void> setListLog(GetListLogDataEntity value) async {
    try {
      await AppInitConfig.localStorage.user.putSecure(
        key: listLog,
        data: jsonEncode(value.toJson()),
      );
    } on Exception catch (e) {
      AppLogger.debugLog("[setListLog][error] $e");
      rethrow;
    }
  }

  // Future<GetListLogDataEntity?> getListLog(void _) async {
  Future<GetListLogDataEntity?> getListLog() async {
    try {
      var output = await AppInitConfig.localStorage.user.getSecure(
        key: listLog,
      );
      if (output != null) {
        GetListLogDataEntity result = GetListLogDataEntity.fromJson(jsonDecode(output));
        return result;
      } else {
        return null;
      }
    } on Exception catch (e) {
      AppLogger.debugLog("[getListLog][error] $e");
      return null;
    }
  }
}
