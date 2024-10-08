class CaptureLocationResponseModel {
  int? status;
  String? message;
  CaptureLocationData? data;

  CaptureLocationResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CaptureLocationResponseModel.fromJson(Map<String, dynamic> json) => CaptureLocationResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["Data"] == null ? null : CaptureLocationData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": data?.toJson(),
      };
}

class CaptureLocationData {
  String? location;
  String? latitude;
  String? longitude;
  String? address;
  String? information;

  CaptureLocationData({
    this.location,
    this.latitude,
    this.longitude,
    this.address,
    this.information,
  });

  factory CaptureLocationData.fromJson(Map<String, dynamic> json) => CaptureLocationData(
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        information: json["information"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "information": information,
      };
}
