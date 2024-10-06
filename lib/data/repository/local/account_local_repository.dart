import 'dart:convert';

import 'package:project_office_monitoring_app/domain/entities/company_data_entity.dart';
import 'package:project_office_monitoring_app/domain/entities/user_data_entity.dart';
import 'package:project_office_monitoring_app/init_config.dart';
import 'package:project_office_monitoring_app/support/app_logger.dart';
import 'package:project_office_monitoring_app/support/local_service_hive.dart';

class AccountLocalRepository {
  String userData = "userData";
  String companyData = "companyData";
  String isLogin = "isLogin";
  String isActivationCodeActive = "isActivationCodeActive";

  Future<void> setIsLogin(bool value) async {
    try {
      AppInitConfig.localStorage.user.putSecure(
        key: isLogin,
        data: value,
      );
    } catch (e) {
      AppLogger.debugLog("[setIsLogin][error] $e");
      rethrow;
    }
  }

  Future<bool> getIsLogin() async {
    try {
      bool result = await AppInitConfig.localStorage.user.getSecure(
        key: isLogin,
      );
      return result;
    } catch (e) {
      AppLogger.debugLog("[getIsLogin][error] $e");
      return false;
    }
  }

  Future<void> setIsActivationCodeActive(bool data) async {
    try {
      AppInitConfig.localStorage.config.putSecure(
        key: isActivationCodeActive,
        data: data,
      );
    } catch (e) {
      AppLogger.debugLog("[setIsActivationCodeActive][error] $e");
      rethrow;
    }
  }

  Future<bool> getIsActivationCodeActive() async {
    try {
      bool result = await AppInitConfig.localStorage.config.getSecure(
        key: isActivationCodeActive,
      );
      return result;
    } catch (e) {
      AppLogger.debugLog("[getIsActivationCodeActive][error] $e");
      return false;
    }
  }

  Future<void> setCompanyData(CompanyDataEntity data) async {
    try {
      AppInitConfig.localStorage.user.putSecure(
        key: companyData,
        data: jsonEncode(data.toJson()),
      );
    } catch (e) {
      AppLogger.debugLog("[setCompanyData][error] $e");
      rethrow;
    }
  }

  Future<CompanyDataEntity?> getCompanyData() async {
    try {
      var output = await AppInitConfig.localStorage.user.getSecure(
        key: companyData,
      );
      CompanyDataEntity result = CompanyDataEntity.fromJson(jsonDecode(output));
      return result;
    } catch (e) {
      AppLogger.debugLog("[getCompanyData][error] $e");
      return null;
    }
  }

  Future<void> setUserData(UserDataEntity data) async {
    try {
      AppInitConfig.localStorage.user.putSecure(
        key: userData,
        data: jsonEncode(data.toJson()),
      );
    } catch (e) {
      AppLogger.debugLog("[setUserData][error] $e");
      rethrow;
    }
  }

  Future<UserDataEntity?> getUserData() async {
    try {
      var output = await AppInitConfig.localStorage.user.getSecure(
        key: userData,
      );

      UserDataEntity result = UserDataEntity.fromJson(jsonDecode(output));
      return result;
    } catch (e) {
      AppLogger.debugLog("[getUserData][error] $e");
      return null;
    }
  }
}
