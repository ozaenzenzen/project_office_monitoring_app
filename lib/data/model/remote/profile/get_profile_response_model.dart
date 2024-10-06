import 'package:project_office_monitoring_app/domain/entities/company_data_entity.dart';
import 'package:project_office_monitoring_app/domain/entities/user_company_data_entity.dart';
import 'package:project_office_monitoring_app/domain/entities/user_data_entity.dart';

class GetProfileResponseModel {
  int? status;
  String? message;
  GetProfileData? data;

  GetProfileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  UserCompanyDataEntity? toUserCompanyDataEntity() {
    if (data == null) {
      return null;
    } else {
      return UserCompanyDataEntity.fromJson(
        data!.toJson(),
      );
    }
  }

  CompanyDataEntity? toCompanyDataEntity() {
    if (data == null) {
      return null;
    } else {
      return CompanyDataEntity(
        companyStamp: data?.companyData?.companyStamp,
        companyName: data?.companyData?.companyName,
        companyEmail: data?.companyData?.companyEmail,
        companyPhone: data?.companyData?.companyPhone,
        picture: data?.companyData?.picture,
        city: data?.companyData?.city,
        state: data?.companyData?.state,
        zip: data?.companyData?.zip,
        address: data?.companyData?.address,
        information: data?.companyData?.information,
      );
    }
  }

  UserDataEntity toUserDataEntity() => UserDataEntity(
        userStamp: data?.userStamp,
        name: data?.name,
        email: data?.email,
        noreg: data?.noreg,
        jabatan: data?.jabatan,
        phone: data?.phone,
        typeuser: data?.typeuser,
        profilePicture: data?.profilePicture,
      );

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) => GetProfileResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["Data"] == null ? null : GetProfileData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Data": data?.toJson(),
      };
}

class GetProfileData {
  String? userStamp;
  String? name;
  String? email;
  String? noreg;
  String? jabatan;
  String? phone;
  int? typeuser;
  String? profilePicture;
  GetProfileCompanyData? companyData;

  GetProfileData({
    this.userStamp,
    this.name,
    this.email,
    this.noreg,
    this.jabatan,
    this.phone,
    this.typeuser,
    this.profilePicture,
    this.companyData,
  });

  factory GetProfileData.fromJson(Map<String, dynamic> json) => GetProfileData(
        userStamp: json["user_stamp"],
        name: json["name"],
        email: json["email"],
        noreg: json["noreg"],
        jabatan: json["jabatan"],
        phone: json["phone"],
        typeuser: json["typeuser"],
        profilePicture: json["profile_picture"],
        companyData: json["company_data"] == null ? null : GetProfileCompanyData.fromJson(json["company_data"]),
      );

  Map<String, dynamic> toJson() => {
        "user_stamp": userStamp,
        "name": name,
        "email": email,
        "noreg": noreg,
        "jabatan": jabatan,
        "phone": phone,
        "typeuser": typeuser,
        "profile_picture": profilePicture,
        "company_data": companyData?.toJson(),
      };
}

class GetProfileCompanyData {
  String? companyStamp;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  String? picture;
  String? city;
  String? state;
  String? zip;
  String? address;
  String? information;

  GetProfileCompanyData({
    this.companyStamp,
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.picture,
    this.city,
    this.state,
    this.zip,
    this.address,
    this.information,
  });

  factory GetProfileCompanyData.fromJson(Map<String, dynamic> json) => GetProfileCompanyData(
        companyStamp: json["company_stamp"],
        companyName: json["company_name"],
        companyEmail: json["company_email"],
        companyPhone: json["company_phone"],
        picture: json["picture"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        address: json["address"],
        information: json["information"],
      );

  Map<String, dynamic> toJson() => {
        "company_stamp": companyStamp,
        "company_name": companyName,
        "company_email": companyEmail,
        "company_phone": companyPhone,
        "picture": picture,
        "city": city,
        "state": state,
        "zip": zip,
        "address": address,
        "information": information,
      };
}
