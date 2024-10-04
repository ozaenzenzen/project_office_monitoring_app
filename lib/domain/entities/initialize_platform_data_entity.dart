class InitializePlatformDataEntity {
  String? platformName;
  String? platformSecret;
  String? platformKey;

  InitializePlatformDataEntity({
    this.platformName,
    this.platformSecret,
    this.platformKey,
  });

  InitializePlatformDataEntity.toLocal({
    this.platformName,
    this.platformSecret,
    this.platformKey,
  });

  factory InitializePlatformDataEntity.fromJson(Map<String, dynamic> json) => InitializePlatformDataEntity(
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
