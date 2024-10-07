class GetListLogDataEntity {
  int? currentPage;
  int? nextPage;
  int? totalPages;
  int? totalItems;
  List<ListDatumEntity>? listData;

  GetListLogDataEntity({
    this.currentPage,
    this.nextPage,
    this.totalPages,
    this.totalItems,
    this.listData,
  });

  factory GetListLogDataEntity.fromJson(Map<String, dynamic> json) => GetListLogDataEntity(
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        totalPages: json["total_pages"],
        totalItems: json["total_items"],
        listData: json["list_data"] == null ? [] : List<ListDatumEntity>.from(json["list_data"]!.map((x) => ListDatumEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "next_page": nextPage,
        "total_pages": totalPages,
        "total_items": totalItems,
        "list_data": listData == null ? [] : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}

class ListDatumEntity {
  MonitorDataEntity? monitorData;
  UserDataEntity? userData;

  ListDatumEntity({
    this.monitorData,
    this.userData,
  });

  factory ListDatumEntity.fromJson(Map<String, dynamic> json) => ListDatumEntity(
        monitorData: json["monitor_data"] == null ? null : MonitorDataEntity.fromJson(json["monitor_data"]),
        userData: json["user_data"] == null ? null : UserDataEntity.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "monitor_data": monitorData?.toJson(),
        "user_data": userData?.toJson(),
      };
}

class MonitorDataEntity {
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

  MonitorDataEntity({
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

  factory MonitorDataEntity.fromJson(Map<String, dynamic> json) => MonitorDataEntity(
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

class UserDataEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? noreg;
  String? phone;
  String? jabatan;

  UserDataEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.noreg,
    this.phone,
    this.jabatan,
  });

  factory UserDataEntity.fromJson(Map<String, dynamic> json) => UserDataEntity(
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
