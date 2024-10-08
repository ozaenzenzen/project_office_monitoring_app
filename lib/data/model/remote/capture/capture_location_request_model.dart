class CaptureLocationRequestModel {
  String? picture;
  String? location;
  String? address;
  String? information;
  String? latitude;
  String? longitude;

  CaptureLocationRequestModel({
    this.picture,
    this.location,
    this.address,
    this.information,
    this.latitude,
    this.longitude,
  });

  factory CaptureLocationRequestModel.fromJson(Map<String, dynamic> json) => CaptureLocationRequestModel(
        picture: json["picture"],
        location: json["location"],
        address: json["address"],
        information: json["information"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "picture": picture,
        "location": location,
        "address": address,
        "information": information,
        "latitude": latitude,
        "longitude": longitude,
      };
}
