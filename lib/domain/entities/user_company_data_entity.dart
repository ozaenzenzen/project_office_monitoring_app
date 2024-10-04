class UserCompanyDataEntity {
  String? userStamp;
  String? name;
  String? email;
  String? noreg;
  String? jabatan;
  String? phone;
  int? typeuser;
  String? profilePicture;
  UserCompanyData? companyData;

  UserCompanyDataEntity({
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


  factory UserCompanyDataEntity.fromJson(Map<String, dynamic> json) => UserCompanyDataEntity(
        userStamp: json["user_stamp"],
        name: json["name"],
        email: json["email"],
        noreg: json["noreg"],
        jabatan: json["jabatan"],
        phone: json["phone"],
        typeuser: json["typeuser"],
        profilePicture: json["profile_picture"],
        companyData: json["company_data"] == null ? null : UserCompanyData.fromJson(json["company_data"]),
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

class UserCompanyData {
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

  UserCompanyData({
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

  factory UserCompanyData.fromJson(Map<String, dynamic> json) => UserCompanyData(
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
