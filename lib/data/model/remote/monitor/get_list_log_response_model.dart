import 'package:project_office_monitoring_app/domain/entities/get_list_log_data_entity.dart';

class GetListLogResponseModel {
  int? status;
  String? message;
  GetListLogData? data;

  GetListLogResponseModel({
    this.status,
    this.message,
    this.data,
  });

  GetListLogDataEntity? toEntity() {
    if (data != null) {
      return GetListLogDataEntity.fromJson(data!.toJson());
    } else {
      return null;
    }
  }

  factory GetListLogResponseModel.fromJson(Map<String, dynamic> json) => GetListLogResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["Data"] == null ? null : GetListLogData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": data?.toJson(),
      };
}

class GetListLogData {
  int? currentPage;
  int? nextPage;
  int? totalPages;
  int? totalItems;
  List<ListDatum>? listData;

  GetListLogData({
    this.currentPage,
    this.nextPage,
    this.totalPages,
    this.totalItems,
    this.listData,
  });

  factory GetListLogData.fromJson(Map<String, dynamic> json) => GetListLogData(
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        totalPages: json["total_pages"],
        totalItems: json["total_items"],
        listData: json["list_data"] == null ? [] : List<ListDatum>.from(json["list_data"]!.map((x) => ListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "next_page": nextPage,
        "total_pages": totalPages,
        "total_items": totalItems,
        "list_data": listData == null ? [] : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}

class ListDatum {
  MonitorData? monitorData;
  UserData? userData;

  ListDatum({
    this.monitorData,
    this.userData,
  });

  factory ListDatum.fromJson(Map<String, dynamic> json) => ListDatum(
        monitorData: json["monitor_data"] == null ? null : MonitorData.fromJson(json["monitor_data"]),
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "monitor_data": monitorData?.toJson(),
        "user_data": userData?.toJson(),
      };
}

class MonitorData {
  String? uuid;
  String? userStamp;
  String? platformName;
  String? picture;
  String? location;
  String? address;
  String? information;
  String? latitude;
  String? longitude;
  DateTime? createdAt;

  MonitorData({
    this.uuid,
    this.userStamp,
    this.platformName,
    this.picture,
    this.location,
    this.address,
    this.information,
    this.latitude,
    this.longitude,
    this.createdAt,
  });

  factory MonitorData.fromJson(Map<String, dynamic> json) => MonitorData(
        uuid: json["uuid"],
        userStamp: json["user_stamp"],
        platformName: json["platform_name"],
        picture: json["picture"],
        location: json["location"],
        address: json["address"],
        information: json["information"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "user_stamp": userStamp,
        "platform_name": platformName,
        "picture": picture,
        "location": location,
        "address": address,
        "information": information,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
      };
}

class UserData {
  String? firstName;
  String? lastName;
  String? email;
  String? noreg;
  String? phone;
  String? jabatan;

  UserData({
    this.firstName,
    this.lastName,
    this.email,
    this.noreg,
    this.phone,
    this.jabatan,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        noreg: json["noreg"],
        phone: json["phone"],
        jabatan: json["jabatan"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "noreg": noreg,
        "phone": phone,
        "jabatan": jabatan,
      };
}
