import 'package:project_office_monitoring_app/env.dart';
import 'package:project_office_monitoring_app/support/app_connectivity_service.dart';
import 'package:project_office_monitoring_app/support/app_info.dart';
import 'package:project_office_monitoring_app/support/local_service_hive.dart';

class AppInitConfig {
  static LocalServiceHive localStorage = LocalServiceHive();
  
  static Future<void> init() async {
    // AppTheme.appThemeInit();
    // await GetStorage.init();
    await localStorage.init();
    AppInfo.appInfoInit();
    AppConnectivityService.init();
    // AppLocalStorage.init();
    // EnvironmentConfig.customBaseUrl = "https://4be5-112-215-170-211.ngrok.io"; // for ngrok
    // EnvironmentConfig.customBaseUrl = "http://10.0.2.2:8080"; // for emulator android
    // EnvironmentConfig.customBaseUrl = "https://7c30-114-10-42-165.ngrok-free.app"; // for emulator android
    // EnvironmentConfig.customBaseUrl = "https://6feb-114-10-42-165.ngrok-free.app"; // for emulator android
    EnvironmentConfig.customBaseUrl = "https://9ba6-114-10-42-165.ngrok-free.app"; // for emulator android
    // EnvironmentConfig.customBaseUrl = "http://localhost:8080"; // for emulator iOS
  }

  static void logout() async {
    await localStorage.user.clear();
    // await localStorage.config.clear();
  }
}
