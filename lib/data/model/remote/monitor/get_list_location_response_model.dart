import 'package:project_office_monitoring_app/domain/entities/get_list_location_data_entity.dart';

class GetListLocationResponseModel {
  int? status;
  String? message;
  List<GetListLocationDatum>? data;

  GetListLocationResponseModel({
    this.status,
    this.message,
    this.data,
  });

  List<GetListLocationDataEntity>? toEntity() {
    var output = List<GetListLocationDataEntity>.from(
      data!.map(
        (x) => GetListLocationDataEntity(
          location: x.location,
        ),
      ),
    );
    return output;
    // return GetListLocationDataEntity.fromJson(data!.to);
  }

  factory GetListLocationResponseModel.fromJson(Map<String, dynamic> json) => GetListLocationResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["Data"] == null ? [] : List<GetListLocationDatum>.from(json["Data"]!.map((x) => GetListLocationDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetListLocationDatum {
  String? location;

  GetListLocationDatum({
    this.location,
  });

  factory GetListLocationDatum.fromJson(Map<String, dynamic> json) => GetListLocationDatum(
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
      };
}
