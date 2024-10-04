import 'package:project_office_monitoring_app/domain/entities/initialize_platform_data_entity.dart';

class InitializePlatformResponseModel {
  int? status;
  String? message;
  InitializePlatformData? data;

  InitializePlatformResponseModel({
    this.status,
    this.message,
    this.data,
  });

  InitializePlatformDataEntity toCompanyDataEntity() => InitializePlatformDataEntity.toLocal(
        platformName: data?.platformName,
        platformSecret: data?.platformSecret,
        platformKey: data?.platformKey,
      );

  factory InitializePlatformResponseModel.fromJson(Map<String, dynamic> json) => InitializePlatformResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["Data"] == null ? null : InitializePlatformData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": data?.toJson(),
      };
}

class InitializePlatformData {
  String? platformName;
  String? platformSecret;
  String? platformKey;

  InitializePlatformData({
    this.platformName,
    this.platformSecret,
    this.platformKey,
  });

  factory InitializePlatformData.fromJson(Map<String, dynamic> json) => InitializePlatformData(
        platformName: json["platform_name"],
        platformSecret: json["platform_secret"],
        platformKey: json["platform_key"],
      );

  Map<String, dynamic> toJson() => {
        "platform_name": platformName,
        "platform_secret": platformSecret,
        "platform_key": platformKey,
      };
}
