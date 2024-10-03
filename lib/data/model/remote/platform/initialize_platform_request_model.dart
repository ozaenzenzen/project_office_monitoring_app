class InitializePlatformRequestModel {
  String? platformName;
  String? platformSecret;

  InitializePlatformRequestModel({
    this.platformName,
    this.platformSecret,
  });

  factory InitializePlatformRequestModel.fromJson(Map<String, dynamic> json) => InitializePlatformRequestModel(
        platformName: json["platform_name"],
        platformSecret: json["platform_secret"],
      );

  Map<String, dynamic> toJson() => {
        "platform_name": platformName,
        "platform_secret": platformSecret,
      };
}
